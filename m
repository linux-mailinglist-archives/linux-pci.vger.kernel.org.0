Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E8E67B294
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jan 2023 13:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjAYM3j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Jan 2023 07:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjAYM3i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2023 07:29:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B584B4B2;
        Wed, 25 Jan 2023 04:29:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35961B819AB;
        Wed, 25 Jan 2023 12:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A844C433D2;
        Wed, 25 Jan 2023 12:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674649774;
        bh=gk+BOS4/NV35jRpT+sdIL/D9DR/PkgxZ0nOBPSyrVOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a8BcGo34HCl4WLII6y2qktnC00UyqXS7WM7JDzXjQ/i8c0kt0W3pD9DpZICQiDnIf
         0jcPuKlGZA5A/cH1cibYVuUYXy7OkekMjiTyw2x8cbFCsxL6GQzB0M6+CeRTAlKWs/
         CMfaR9Q5blS7zFdncWS4GY+ByGx7/3oHzfo3fH5o=
Date:   Wed, 25 Jan 2023 13:29:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Lee Jones <lee@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>, robh@kernel.org
Subject: Re: [PATCH] mfd: Add Simple PCI MFD driver
Message-ID: <Y9EgrKT3hDyx+ULy@kroah.com>
References: <20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com>
 <Y86op9oh5ldrZQyG@google.com>
 <Y862WTT03/JxXUG8@kroah.com>
 <Y9EBSmOoE5+83jS5@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9EBSmOoE5+83jS5@axis.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 25, 2023 at 11:15:38AM +0100, Vincent Whitchurch wrote:
> On Mon, Jan 23, 2023 at 05:31:21PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Jan 23, 2023 at 03:32:55PM +0000, Lee Jones wrote:
> > > On Mon, 23 Jan 2023, Vincent Whitchurch wrote:
> > > 
> > > > Add a PCI driver which registers all child nodes specified in the
> > > > devicetree.  It will allow platform devices to be used on virtual
> > > > systems which already support PCI and devicetree, such as UML with
> > > > virt-pci.
> > > > 
> > > > The driver has no id_table by default; user space needs to provide one
> > > > using the new_id mechanism in sysfs.
> > > 
> > > This feels wrong for several reasons.
> > > 
> > > Firstly, I think Greg (Cc:ed) will have something to say about this.
> > 
> > Yes, this isn't ok.  Please write a real driver for the hardware under
> > control here, and that would NOT be a MFD driver (hint, if you want to
> > split up a PCI device into different drivers, use the aux bus code, that
> > is what it is there for.)
> 
> I hope it's clear from my other replies in this thread that the entire
> purpose of this driver is to allow arbitrary platform devices to be used
> via a PCI device in virtual environments like User Mode Linux in order
> to test existing platform drivers using mocked hardware.

That still feels wrong, why is PCI involved here at all?

Don't abuse platform devices like this please, mock up a platform device
framework instead if you want to test them that way, don't think that
adding a platform device "below" a PCI device is somehow allowed at all.

> Given this "hardware", it's not clear what a "real driver" would do
> differently.

Again, you can not have a platform device below a PCI device, that's not
what a platform device is for at all.

> The auxiliary bus cannot be used since it naturally does
> not support platform devices.

The aux bus can support any type of bus (it's there to be used as you
want, it's just that people are currently using it for PCI devices right
now).

> A hard coded list of sub-devices cannot be used since arbitrary
> platform devices with arbitrary devicetree properties need to be
> supported.

Then make a new bus type and again, do not abuse platform devices.

> I could move this driver to drivers/bus/ and pitch it as a
> "PCI<->platform bridge for testing in virtual environments", if that
> makes more sense.

Again, nope, a platform device is NOT ever a child of a PCI device.
That's just not how PCI works at all.

Would you do the attempt to do this for USB?  (hint, no.)  So why is PCI
somehow special here?

thanks,

greg k-h
