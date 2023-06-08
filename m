Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01910728A73
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 23:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjFHVxf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 17:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjFHVxe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 17:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27371FE9
        for <linux-pci@vger.kernel.org>; Thu,  8 Jun 2023 14:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58A4F6144C
        for <linux-pci@vger.kernel.org>; Thu,  8 Jun 2023 21:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E976C433D2;
        Thu,  8 Jun 2023 21:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686261211;
        bh=G9xx7IhVNkMCgWKqF4T0InCbfFAKBbmjppDV+AWKaJ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iMHzKDQh/h/8JzkOw3KgNAQ9FratTobL4oQDoagcqj0eHlnJVlfX9SCnFW1hJwd8n
         JOIHboKmb6lGaILl7aatthux6EqWNvsNA/Q2/7KjKavBIdcR5ueNYBPsk9sIR13tRm
         dRxzAe4C6SDtHcBhiGxDc809bgrM16hfdSJAyevAtAEYS3RDQ2q6CetgyCrkxdnuS1
         lhLMzXx6or2pIqby0RIjx0kip32Z0SY4eY7BM8aN50IPH9j7EyjZmVpZ1MSyzKtKXY
         nFoD6xLstSE2x7fVFu7CLY8PvqdCldNiQHwoS1D+z97TqwfsjOwoq6PYb/m9qFOqGS
         wVOgdEU2BydNQ==
Date:   Thu, 8 Jun 2023 16:53:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Damien Dejean <dam.dejean@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: Old Asus doesn't seem to support MSI
Message-ID: <20230608215330.GA1217213@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83D038E9-B36D-4200-8A1E-C6B1EA6FE0E4@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 08, 2023 at 11:15:24PM +0200, Damien Dejean wrote:
> > 1) Krzysztof found a slightly newer BIOS for your system [1].  It's
> > conceivable that could help.
> 
> I already updated the laptop with this BIOS but it changed nothing.

Thanks for checking!

> > 2) If you happen to have Windows, AIDA64 [2] can tell us whether it
> > uses MSI.
> 
> I don’t have Windows available on this laptop anymore, however if I
> find a way to install it I’ll do, if I can run AIDA that will help.

Not sure this is worth spending time on.  We might learn "Windows
doesn't use MSI", which would suggest that we do the same via a quirk.

Or we might learn "Windows *does* use MSI", but we still wouldn't know
how to make it work.  In this case, I would assume some kind of
Windows driver for the chipset configures it, but we don't know *how*,
so we'd probably still use a quirk to disable it.

> Before doing the quirk I found a lead. At the time the laptop was
> released there was a small linux system running on it called « Asus
> Express Gate ». The sources are available on the same website that
> you and Krzysztof pointed out. The kernel used was pretty old
> (2.6.25.4) however I found some interesting information:
> 
> - the kernel configuration contains the following configuration for PCI:
>   CONFIG_PCI=y
>   CONFIG_PCI_GOANY=y
>   CONFIG_PCI_BIOS=y
>   CONFIG_PCI_DIRECT=y
>   CONFIG_PCI_MMCONFIG=y
>   CONFIG_PCI_DOMAINS=y
>   CONFIG_ARCH_SUPPORTS_MSI=y
>   CONFIG_PCI_MSI=y
>   CONFIG_PCI_LEGACY=y
>   CONFIG_HT_IRQ=y
>   CONFIG_ISA_DMA_API=y
>   So I guess MSI is expected to work.
> 
> - there’s another patch provided:
> 
> diff -Naurp linux-2.6.25.4/drivers/acpi/osl.c linux-2.6.25.4-mod/drivers/acpi/osl.c
> --- linux-2.6.25.4/drivers/acpi/osl.c	2008-05-15 23:00:12.000000000 +0800
> +++ linux-2.6.25.4-mod/drivers/acpi/osl.c	2008-09-08 11:31:38.000000000 +0800
> @@ -132,7 +132,7 @@ static char osi_additional_string[OSI_ST
>   * not ignore it will require a kernel source update to
>   * add a DMI entry, or a boot-time "acpi_osi=Linux" invocation.
>   */
> -#define OSI_LINUX_ENABLE 0
> +#define OSI_LINUX_ENABLE 1
>  
>  static struct osi_linux {
>  	unsigned int	enable:1;
> 
> I’m not sure to understand exactly what it does, but do you think
> that adding api_osi=Linux would help ?

Interesting.  I guess it would be easy enough to try (I think you need
"acpi_osi=Linux" (not "api_osi")) and I guess you would omit
"pci=nomsi" in that case.

It looks like there's *one* system (Asus, naturally) with a DMI quirk
to do "acpi_osi=Linux" automatically:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/osi.c?id=v6.3#n452

But I would still lean toward using the quirk for all machines with
the [1039:0671] chipset because it's fairly likely to fix other
similar machines.  It shouldn't *break* anything.

> > Le 8 juin 2023 à 18:21, Bjorn Helgaas <helgaas@kernel.org> a écrit :
> > 
> > [+cc Krzysztof]
> > 
> > On Thu, Jun 08, 2023 at 09:57:32AM +0200, Damien Dejean wrote:
> >> Thanks for digging into this!
> >> 
> >>> It's also conceivable that MSI used to work in older kernels, but we
> >>> broke something by v5.10.  Do you know whether any old kernels ever
> >>> worked without "pci=nomsi”?
> >> 
> >> I remember trying older linux distributions (Debian oldstable,
> >> kernel 4.19) and some older Ubuntu(s) but I don’t remember any of
> >> them working. Plus, the Ubuntu wiki pages and various post replies
> >> to “… Linux is not working on my x73sl laptop” are always suggesting
> >> the pci=nomsi option, so I guess the problem exists since a while.
> > 
> > OK, more ideas:
> > 
> > 1) Krzysztof found a slightly newer BIOS for your system [1].  It's
> > conceivable that could help.
> > 
> > 2) If you happen to have Windows, AIDA64 [2] can tell us whether it
> > uses MSI.
> > 
> > 3) I'm inclined to add the attached quirk, which disables MSI on any
> > machine with this chipset.  Should fix your ASUS X73SL, and could also
> > fix other platforms with the same chipset.  May slow down other
> > platforms where MSI *does* work.
> > 
> > 4) If needed, we could make the quirk specific to ASUS X73SL.
> > 
> > Bjorn
> > 
> > [1] https://www.asus.com/us/supportonly/x73sl/helpdesk_bios/
> > [2] https://www.aida64.com/downloads
> > 
> > 
> > commit 240bbd06303f ("PCI: Disable MSI on SiS 671")
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Thu Jun 8 10:13:11 2023 -0500
> > 
> >    PCI: Disable MSI on SiS 671
> > 
> >    Damien reports that MSI doesn't work on the SiS 671 chipset, at least on
> >    this platform:
> > 
> >      DMI: ASUSTeK Computer Inc.  F70SL/F70SL     , BIOS 211     02/18/2009
> >      pci 0000:00:00.0: [1039:0671] type 00 class 0x060000
> > 
> >    This prevents devices, e.g., NVIDIA GeForce 9300M GS GPU and an Atheros
> >    mini PCIe wifi adapter, from working.  Disable MSI completely on any
> >    platform with this chipset.
> > 
> >    I assume MSI *does* work on Windows on this platform, so there may be a
> >    chipset driver or something that configures it.  It's possible that MSI
> >    does work on different platforms with SiS 671, so if anybody cares, we
> >    *could* make this specific to the ASUS F70SL.
> > 
> >    Link: https://lore.kernel.org/r/19F46F0C-E9C8-489E-8AA5-2A16E13A6FE9@gmail.com
> >    Reported-by: Damien Dejean <dam.dejean@gmail.com>
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index f4e2a88729fd..adc58ce82d76 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2585,6 +2585,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3336, quirk_disab
> > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3351, quirk_disable_all_msi);
> > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3364, quirk_disable_all_msi);
> > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8380_0, quirk_disable_all_msi);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI, 0x0671, quirk_disable_all_msi);
> > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI, 0x0761, quirk_disable_all_msi);
> > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa5e3, quirk_disable_all_msi);
> > 
> 
