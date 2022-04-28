Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B58E5139AD
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 18:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349758AbiD1Q0O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 12:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiD1Q0N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 12:26:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F035B69CD9;
        Thu, 28 Apr 2022 09:22:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF989B82E55;
        Thu, 28 Apr 2022 16:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A55DC385A9;
        Thu, 28 Apr 2022 16:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651162975;
        bh=9YCI8z6CAkYZpnH+exjYEu9vqU7kNPKNoSr7A9NYJXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SA7AhygoprSme/vhCjwEh+Lsfu1WzLlNPrDsWjINUT3bCrVaYkYsbCcASnGITXVLD
         0kPqYwRFi8PgmgjuDgwnv2BFhgQgbpKpJobGYz2QagN6t9OfHY1mBzSWq9gliZg4l5
         6J4HrX6G9lBdWWm55MILSQhcTSDcajeVWBXrXGbs=
Date:   Thu, 28 Apr 2022 18:22:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, rafael@kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        whitehat002 <hackyzh002@gmail.com>
Subject: Re: [PATCH] PCI/ACPI: do not reference a pci device after it has
 been released
Message-ID: <Ymq/W+KcWD9DKQr/@kroah.com>
References: <20220428142854.1065953-1-gregkh@linuxfoundation.org>
 <20220428155858.GA14614@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428155858.GA14614@bhelgaas>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 28, 2022 at 10:58:58AM -0500, Bjorn Helgaas wrote:
> On Thu, Apr 28, 2022 at 04:28:53PM +0200, Greg Kroah-Hartman wrote:
> > In acpi_get_pci_dev(), the debugging message for when a PCI bridge is
> > not found uses a pointer to a pci device whose reference has just been
> > dropped.  The chance that this really is a device that is now been
> > removed from the system is almost impossible to happen, but to be safe,
> > let's print out the debugging message based on the acpi root device
> > which we do have a valid reference to at the moment.
> 
> This code was added by 497fb54f578e ("ACPI / PCI: Fix NULL pointer
> dereference in acpi_get_pci_dev() (rev. 2)").  Not sure if it's worth
> a Fixes: tag.

Can't hurt, I'll add it for the v2 based on this review.

> 
> acpi_get_pci_dev() is used by only five callers, three of which are
> video/backlight related.  I'm always skeptical of one-off interfaces
> like this, but I don't know enough to propose any refactoring or other
> alternatives.
> 
> I'll leave this for Rafael, but if I were applying I would silently
> touch up the subject to match convention:
> 
>   PCI/ACPI: Do not reference PCI device after it has been released

Much simpler, thanks.

> 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-acpi@vger.kernel.org
> > Reported-by: whitehat002 <hackyzh002@gmail.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/acpi/pci_root.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index 6f9e75d14808..ecda378dbc09 100644
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -303,7 +303,8 @@ struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
> >  		 * case pdev->subordinate will be NULL for the parent.
> >  		 */
> >  		if (!pbus) {
> > -			dev_dbg(&pdev->dev, "Not a PCI-to-PCI bridge\n");
> > +			dev_dbg(&root->device->dev,
> > +				"dev %d, function %d is not a PCI-to-PCI bridge\n", dev, fn);
> 
> This should use "%02x.%d" to be consistent with the dev_set_name() in
> pci_setup_device().

Ah, missed that, will change it and send out a new version tomorrow.

thanks for the quick review.

greg k-h
