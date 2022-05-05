Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54A551C84F
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 20:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383991AbiEESti (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 14:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384748AbiEESsZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 14:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DB6DBD;
        Thu,  5 May 2022 11:41:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BE8361749;
        Thu,  5 May 2022 18:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C94C385A4;
        Thu,  5 May 2022 18:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651776084;
        bh=QgIMStOAdIOcsX917HONaQ/r+kbFXAWecfRo/JbxZGQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iKjT6HDbl2dv3GSiZlhdRdvUNuoIfMHdGKh79ysBt6O3BjntpeGq3M262qiyJQuoK
         m43IG5qMumyi2V0C9pJOkXDkYWpzT50PnCUmE2B+mD09k6UvSEmJFEfiALrjqLZSNA
         khZNn4eLUHzCOwCUBDHFsbn+TD8aEEVAe3el5FPJVXXvwdn9CE1uXHPYKeUzXO1qu/
         zRimyGdKNu6GpzHHFuIEtJVZD3NfTiv6jgBiWqP58V0wlUnmcYY3b3BM8C/uE1YZeG
         oGf24OtJgBJziKHM3b1Zg/tDsHG6+SQFOPWgCO5H0FxHtzRSZ7o1kaVFmmt8w4VmDN
         tDOCcVdEqlQkA==
Date:   Thu, 5 May 2022 13:41:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     Yicong Yang <yangyicong@hisilicon.com>, bhelgaas@google.com,
        rafael@kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, lenb@kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] PCI/ACPI: Always advertise ASPM support if
 CONFIG_PCIEASPM=y
Message-ID: <20220505184121.GA494499@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38e81af3-e7fa-df0c-c3f7-14244dde5a21@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 05, 2022 at 08:36:42PM +0800, Yicong Yang wrote:
> On 2022/5/4 6:38, Bjorn Helgaas wrote:
> > On Mon, Apr 25, 2022 at 03:06:34PM +0800, Yicong Yang wrote:
> >> When we have CONFIG_PCIEASPM enabled it means OS can always support ASPM no
> >> matter user have disabled it through pcie_aspm=off or not. But currently we
> >> won't advertise ASPM support in _OSC negotiation if user disables it, which
> >> doesn't match the fact. This will also have side effects that other PCIe
> >> services like AER and hotplug will be disabled as ASPM support is required
> >> and we won't negotiate other services if ASPM support is absent.
> >>
> >> So this patch makes OS always advertising ASPM support if CONFIG_PCIEASPM=y.
> >> It intends no functional change to pcie_aspm=off as it will still mark
> >> aspm_disabled=1 and aspm_support_enabled=false, driver will check these
> >> status before configuring ASPM.
> >>
> >> Tested this patch with pcie_aspm=off:
> >> estuary:/$ dmesg | egrep -i "aspm|osc"
> >> [    0.000000] PCIe ASPM is disabled
> >> [    8.706961] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
> >> ClockPM Segments MSI EDR HPX-Type3]
> >> [    8.726032] acpi PNP0A08:00: _OSC: platform does not support [LTR]
> >> [    8.742818] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME
> >> AER PCIeCapability DPC]
> >> estuary:/sys/module/pcie_aspm/parameters$ cat policy
> >> [default] performance powersave powersupersave
> >> estuary:/sys/module/pcie_aspm/parameters$ echo powersave > policy
> >> bash: echo: write error: Operation not permitted
> >>
> >> Cc: Rafael J. Wysocki <rafael@kernel.org>
> >> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> >> [https://lore.kernel.org/linux-pci/20220407154257.GA235990@bhelgaas/]
> >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> >> ---
> >>  drivers/acpi/pci_root.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> >> index 6f9e75d14808..17e78582e633 100644
> >> --- a/drivers/acpi/pci_root.c
> >> +++ b/drivers/acpi/pci_root.c
> >> @@ -393,7 +393,7 @@ static u32 calculate_support(void)
> >>  	support |= OSC_PCI_HPX_TYPE_3_SUPPORT;
> >>  	if (pci_ext_cfg_avail())
> >>  		support |= OSC_PCI_EXT_CONFIG_SUPPORT;
> >> -	if (pcie_aspm_support_enabled())
> >> +	if (IS_ENABLED(CONFIG_PCIEASPM))
> > 
> > Is there any way firmware could tell the difference between
> > "CONFIG_PCIEASPM not set" and "CONFIG_PCIEASPM=y and booted with
> > 'pcie_aspm=off'"?
> > 
> > If not, why would we even check whether CONFIG_PCIEASPM is set?
> 
> If we announce ASPM support when CONFIG_PCIEASPM=n it'll work as well
> but negotiation and the log don't match the fact. We'll get misleading
> messages that ASPM is supported by OS by it cannot be enable as there's
> no driver.
> 
> As mentioned by the PCIe Firmware Spec r3.3,
> "ASPM Optionality supported
>  The operating system sets this bit to 1 if it properly recognizes
>  and manages ASPM support on PCI Express components which report
>  support for ASPM L1 only in the ASPM Support field within the Link
>  Capabilities Register. Otherwise, the operating system sets this
>  bit to 0"

Yes.  I don't completely understand this bit, but I think it's related
to the fact that L0s support was originally required for all links, so
the only defined ASPM Support encodings were these:

  01b - L0s supported
  11b - L0s and L1 supported

The "ASPM Optionality" ECN [1] of June 19, 2009, added these new
encodings:

  00b - No ASPM support
  10b - L1 supported

So I think the _OSC "ASPM Optionality Supported" bit tells the
firmware that the OS supports this new possibility of devices that
support L1 but not L0s.

Linux currently never sets the "ASPM Optionality Supported" bit, but
it probably should, because I think we *do* support L1 even if L0s
isn't supported.

> When CONFIG_PCIEASPM=n we have no aspm driver and apparently cannot
> support any ASPM features so we should set the bit to 0 to match the spec.

I think you're saying that firmware could not tell the difference, but
the Linux log messages might be slightly misleading.  I assume you
mean this message:

  acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]

where we would claim that we support ASPM even when CONFIG_PCIEASPM is
unset.

The purpose of that message is to expose what Linux is telling the
platform via _OSC.  If we're telling the platform we support ASPM, I
think the message should reflect that.

But I'm actually not sure there's real value in advertising ASPM
support to the platform when CONFIG_PCIEASPM=y but we're booted with
"pcie_aspm=off".  It sounds like this was found by using that option
(even though it wasn't *needed*) and finding that Linux didn't request
control of other PCIe services.  I don't know if that's worth
changing.

> >>  		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
> >>  	if (pci_msi_enabled())
> >>  		support |= OSC_PCI_MSI_SUPPORT;

[1] https://members.pcisig.com/wg/PCI-SIG/document/8348

