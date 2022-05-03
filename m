Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB6A519183
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 00:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiECWmi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 18:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiECWmh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 18:42:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CA0427E8;
        Tue,  3 May 2022 15:39:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FE7EB8221B;
        Tue,  3 May 2022 22:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D36DC385A9;
        Tue,  3 May 2022 22:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651617540;
        bh=2Bi1K4m6B7eQOJ9MZayL2Ps1PpMoB2mm7sab67Dy6VM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=D6QaewuBp9l4Z26rjlkFelSZYaxGf2VKrgkDxMbpsrANS5DJ8q0azhxcPvN/+L/3p
         YROTn8ISmBPGf9MQu32SvF/dKpfeF3Up7S9h3uTtVr59MtR7k6oeDu9hgVpieWOvgR
         YFyI9mx0xfK3XbHk4j+6NvXVwY2Zfjbtq+oGh+HcV79yk4Am6+JHKM0SZbwSSwU7bx
         G3BFAwQuItj2J+iM+P4ZbhbBOFvqAYWIlTEcFFJQfqlcfS55lJHSPz92nWw03hPwft
         Uj2QU7oOhJ5Vdd/ho7pDAukGO5HX6kdEtKmPVLlVsMndTE38zIfQHFFbqSgBIEQvID
         pD1rhLJwOo0Tw==
Date:   Tue, 3 May 2022 17:38:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     bhelgaas@google.com, rafael@kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, lenb@kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] PCI/ACPI: Always advertise ASPM support if
 CONFIG_PCIEASPM=y
Message-ID: <20220503223857.GA414278@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425070634.28227-1-yangyicong@hisilicon.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 25, 2022 at 03:06:34PM +0800, Yicong Yang wrote:
> When we have CONFIG_PCIEASPM enabled it means OS can always support ASPM no
> matter user have disabled it through pcie_aspm=off or not. But currently we
> won't advertise ASPM support in _OSC negotiation if user disables it, which
> doesn't match the fact. This will also have side effects that other PCIe
> services like AER and hotplug will be disabled as ASPM support is required
> and we won't negotiate other services if ASPM support is absent.
> 
> So this patch makes OS always advertising ASPM support if CONFIG_PCIEASPM=y.
> It intends no functional change to pcie_aspm=off as it will still mark
> aspm_disabled=1 and aspm_support_enabled=false, driver will check these
> status before configuring ASPM.
>
> Tested this patch with pcie_aspm=off:
> estuary:/$ dmesg | egrep -i "aspm|osc"
> [    0.000000] PCIe ASPM is disabled
> [    8.706961] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
> ClockPM Segments MSI EDR HPX-Type3]
> [    8.726032] acpi PNP0A08:00: _OSC: platform does not support [LTR]
> [    8.742818] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME
> AER PCIeCapability DPC]
> estuary:/sys/module/pcie_aspm/parameters$ cat policy
> [default] performance powersave powersupersave
> estuary:/sys/module/pcie_aspm/parameters$ echo powersave > policy
> bash: echo: write error: Operation not permitted
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> [https://lore.kernel.org/linux-pci/20220407154257.GA235990@bhelgaas/]
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/acpi/pci_root.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 6f9e75d14808..17e78582e633 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -393,7 +393,7 @@ static u32 calculate_support(void)
>  	support |= OSC_PCI_HPX_TYPE_3_SUPPORT;
>  	if (pci_ext_cfg_avail())
>  		support |= OSC_PCI_EXT_CONFIG_SUPPORT;
> -	if (pcie_aspm_support_enabled())
> +	if (IS_ENABLED(CONFIG_PCIEASPM))

Is there any way firmware could tell the difference between
"CONFIG_PCIEASPM not set" and "CONFIG_PCIEASPM=y and booted with
'pcie_aspm=off'"?

If not, why would we even check whether CONFIG_PCIEASPM is set?

>  		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
>  	if (pci_msi_enabled())
>  		support |= OSC_PCI_MSI_SUPPORT;
> -- 
> 2.24.0
> 
