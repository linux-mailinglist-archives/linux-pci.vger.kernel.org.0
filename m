Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17024569332
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 22:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiGFUVh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 16:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiGFUVh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 16:21:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD6020F77;
        Wed,  6 Jul 2022 13:21:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D2CFB81ECC;
        Wed,  6 Jul 2022 20:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93301C341C0;
        Wed,  6 Jul 2022 20:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657138893;
        bh=gOcE8HPlzWbrrVF7KpH0louwUHrwrtqqE+BWqbjxFQg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SPWDMNZbK0/XjRSnLQOxqLWkLpqI/1rDlyOvfopFPr/oagPQAbxHsApeJAjQGKPvY
         mWJ9UoUz0D0URe53P+Rsy0Aj8v8exukL0e3cGmwCS/fkTBCRffl69ZNE/yHeQmvYMN
         TbhdJpEX8hHIAUPJMZMg+A6/A5vmttfMObCxsZZoLYf3wJloH4cZLJSxBgiwHZaFdG
         BtuUEuJ5motTuKyZp20CNwuHiBBu4eOwJ+O79oE3ljhP9eyVNpzvnC22l5kvrNJpEd
         3yt1CNi04owS5mOaTyM6J4kSV9fVMMqmV0T57BLo4YvaxftGXT4YzIAx+uko9iZeO4
         +dyzDVuUMKHNw==
Date:   Wed, 6 Jul 2022 15:21:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH RESEND v1 1/2] ACPI/PCI: Make _SRS optional for link
 device
Message-ID: <20220706202131.GA218207@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35de3948-d8f2-c2da-05f9-995eecf275ce@arm.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 06, 2022 at 11:52:56AM +0200, Pierre Gondois wrote:
> On 7/5/22 19:29, Bjorn Helgaas wrote:
> > On Fri, Jul 01, 2022 at 06:16:23PM +0200, Pierre Gondois wrote:
> > > From: Pierre Gondois <Pierre.Gondois@arm.com>
> > > 
> > > In ACPI 6.4, s6.2.13 "_PRT (PCI Routing Table)", PCI legacy
> > > interrupts can be described though a link device (first model).
> > >  From s6.2.16 "_SRS (Set Resource Settings)":
> > > "This optional control method [...]"
> > > 
> > > Make it optional to have a _SRS method for link devices.
> > 
> > I think it would be helpful to outline the reason for wanting these
> > changes in the commit log.  Otherwise we don't know the benefit and
> > it's harder to justify making the change since it's not an obvious
> > cleanup.
> > 
> > IIRC from [1] there *is* a good reason: you need to use Interrupt Link
> > devices so you can specify "level triggered, active high".
> > 
> > Without an Interrupt Link, you would get the default "level triggered,
> > active low" setting, which apparently isn't compatible with GICv2.
> > 
> > I assume this fixes a device that previously didn't work correctly,
> > but I don't see the details of that in the bugzilla.  I'm a little
> > confused about this.  Isn't GICv2 widely used already?  How are things
> > working now?  Or are there just a lot of broken devices?
> 
> It was unsure which of the 2 models described in ACPI 6.4, s6.2.13
> "_PRT (PCI Routing Table)" would be used for UEFI for kvmtool.
> 
> Remainder:
> The first model allows to accurately describe interrupts: level/edge
> triggered and active high/low. Interrupts are also configurable with
> _CRS/_PRS/_SRS/_DIS methods
> The second model allows to describe hardwired interrupts, and are
> by default level triggered, active low.
> 
> The kernel is aware that GivV2 interrupts are active high, so there
> was actually no need to accurately describe them. Thus the second
> model was used.
> While experimenting, we temporarily had a configuration using
> the first model, and only had a _CRS method (no _PRS/_SRS), which
> triggered some warnings.

OK, thanks.  So it sounds like there is some existing kernel code that
special-cases GICv2 interrupts to make them level/high, and that code
would not have been necessary if _PRS/_SRS had been optional from the
beginning.

I don't think we could ever *remove* that code because there's
firmware in the field that relies on it, and that firmware will never
be updated.

> So these patches are not fixes for existing platforms, but merely
> to make _PRS/_SRS methods optional.
> 
> In [1] I said I would submit patches to change that. If you think
> this is not necessary as the configuration is non-existing, I am
> perfectly fine to drop the patches.
> 
> Also as Rafael noted, the _DIS method should also be taken into
> consideration if _PRS/_SRS are made optional.

But that said, I'm not opposed to making _PRS/_SRS optional if that
makes legal and reasonable _PRT descriptions work, and if all the
considerations Rafael mentioned are taken care of.

Bjorn
