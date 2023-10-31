Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6B67DD08A
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 16:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344997AbjJaPbt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 11:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344229AbjJaPbs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 11:31:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C000C1
        for <linux-pci@vger.kernel.org>; Tue, 31 Oct 2023 08:31:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8443C433C8;
        Tue, 31 Oct 2023 15:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698766306;
        bh=0ht/xyjjKxAjGu7LLLsV1dUU6l8i2g6icSzBSWpyKKQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nucSoiPwjlrsu6P3IHSoQCn1zLdaiuoU1KYDRMt4NGjA5m71kxl5pOJo9sAujzqJF
         GWjs44dENfwT1zl2SFBJS3klvOj/kIHYzx/qJiDBjyQ9723prBL7bKgw4UEQNlyze3
         JJxbnzpEtZTF03YgBeTn9HLN4Z6PA/1Caury/GbaQF74w0rBMhMZjvGCKCo9XX3/g9
         suM1RZqg5ltt3f1w5YAswxGHN6sSbrS8/3HK2E9yjvVMaYXa7+05Kiy0MfdqFDahec
         e0vgylDwzRzvux66Zhepic98D2dznJVNZdY2Oss8EFsEhqUsAImFcP0Ig98CbFXLWt
         +twfkAV6891qQ==
Date:   Tue, 31 Oct 2023 10:31:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <20231031153144.GA10760@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030201654.27505-1-nirmal.patel@linux.intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 30, 2023 at 04:16:54PM -0400, Nirmal Patel wrote:
> VMD Hotplug should be enabled or disabled based on VMD rootports'
> Hotplug configuration in BIOS. is_hotplug_bridge is set on each
> VMD rootport based on Hotplug capable bit in SltCap in probe.c.
> Check is_hotplug_bridge and enable or disable native_pcie_hotplug
> based on that value.
> 
> Currently VMD driver copies ACPI settings or platform configurations
> for Hotplug, AER, DPC, PM, etc and enables or disables these features
> on VMD bridge which is not correct in case of Hotplug.

This needs some background about why it's correct to copy the ACPI
settings in the case of AER, DPC, PM, etc, but incorrect for hotplug.

> Also during the Guest boot up, ACPI settings along with VMD UEFI
> driver are not present in Guest BIOS which results in assigning
> default values to Hotplug, AER, DPC, etc. As a result Hotplug is
> disabled on VMD in the Guest OS.
> 
> This patch will make sure that Hotplug is enabled properly in Host
> as well as in VM.

Did we come to some consensus about how or whether _OSC for the host
bridge above the VMD device should apply to devices in the separate
domain below the VMD?

I think this warrants some clarification and possibly discussion in
the PCI firmware SIG.

At the very least, the commit log should mention _OSC and say
something about the fact that this is assuming PCIe hotplug ownership
for devices below VMD, regardless of what the upstream _OSC said.

> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
> ---
>  drivers/pci/controller/vmd.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 769eedeb8802..e39eaef5549a 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -720,6 +720,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	resource_size_t membar2_offset = 0x2000;
>  	struct pci_bus *child;
>  	struct pci_dev *dev;
> +	struct pci_host_bridge *vmd_bridge;
>  	int ret;
>  
>  	/*
> @@ -886,8 +887,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	 * and will fail pcie_bus_configure_settings() early. It can instead be
>  	 * run on each of the real root ports.
>  	 */
> -	list_for_each_entry(child, &vmd->bus->children, node)
> +	vmd_bridge = to_pci_host_bridge(vmd->bus->bridge);
> +	list_for_each_entry(child, &vmd->bus->children, node) {
>  		pcie_bus_configure_settings(child);
> +		/*
> +		 * When Hotplug is enabled on vmd root-port, enable it on vmd
> +		 * bridge.
> +		 */
> +		if (child->self->is_hotplug_bridge)
> +			vmd_bridge->native_pcie_hotplug = 1;
> +	}
>  
>  	pci_bus_add_devices(vmd->bus);
>  
> -- 
> 2.31.1
> 
