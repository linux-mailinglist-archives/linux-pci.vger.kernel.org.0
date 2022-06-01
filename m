Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B3A539B3B
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 04:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241907AbiFACWT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 22:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240621AbiFACWS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 22:22:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940592B264
        for <linux-pci@vger.kernel.org>; Tue, 31 May 2022 19:22:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25525B81757
        for <linux-pci@vger.kernel.org>; Wed,  1 Jun 2022 02:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DADC385A9;
        Wed,  1 Jun 2022 02:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654050132;
        bh=2j5iP7QckkMamZAC8IQxp5FXHwq7dZp6G1zs3iMVU4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=orvhk6iQIrAdR2mIbkjDbSVAz+N4CFrT0iyVoopGIW1vIwdMUw1iO+W15X+XbpAtb
         Dwaew3sVuw/LAv6GEPjPY8mvwQdoWi9CObMjAZ3NoLvo45PvzEXwPam+ZUaF4YJLCo
         jeCN5w4RfdrwgUFmR6DkV7fHl936boj9GRtLqTULMHLomBF9s0rs+jjQwJ3+gh+fqy
         xUamKuD8Xu/JFPNvuKEnE+jgO96/yn8r9LEG1Z0/58V0JeK1hkEbh9pGxkrh1KED2D
         EFKo70fWaoa58XkMId7jemABkCdQyn/kOiS566gT3kCPR7CropJKibeIHNe7ne/HN4
         RyBRmsJrXL7IQ==
Date:   Tue, 31 May 2022 21:22:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V13 4/6] PCI: loongson: Improve the MRRS quirk for LS7A
Message-ID: <20220601022210.GA796391@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430084846.3127041-5-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 30, 2022 at 04:48:44PM +0800, Huacai Chen wrote:
> In new revision of LS7A, some PCIe ports support larger value than 256,
> but their maximum supported MRRS values are not detectable. Moreover,
> the current loongson_mrrs_quirk() cannot avoid devices increasing its
> MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
> will actually set a big value in its driver. So the only possible way
> is configure MRRS of all devices in BIOS, and add a pci host bridge bit
> flag (i.e., no_inc_mrrs) to stop the increasing MRRS operations.
> 
> However, according to PCIe Spec, it is legal for an OS to program any
> value for MRRS, and it is also legal for an endpoint to generate a Read
> Request with any size up to its MRRS. As the hardware engineers say, the
> root cause here is LS7A doesn't break up large read requests. In detail,
> LS7A PCIe port reports CA (Completer Abort) if it receives a Memory Read
> request with a size that's "too big" ("too big" means larger than the
> PCIe ports can handle, which means 256 for some ports and 4096 for the
> others, and of course this is a problem in the LS7A's hardware design).

This seems essentially similar to ks_pcie_quirk() [1].  Why are they
different, and why do you need no_inc_mrrs, when keystone doesn't?

Or *does* keystone need it and we just haven't figured that out yet?
Are all callers of pcie_set_readrq() vulnerable to issues there?

Whatever we do should be as uniform as possible across host
controllers.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pci-keystone.c?id=v5.18#n528

> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/controller/pci-loongson.c | 44 +++++++++------------------
>  drivers/pci/pci.c                     |  6 ++++
>  include/linux/pci.h                   |  1 +
>  3 files changed, 22 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 48316daa1f23..83447264048a 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -67,37 +67,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  			DEV_LS7A_LPC, system_bus_quirk);
>  
> -static void loongson_mrrs_quirk(struct pci_dev *dev)
> +static void loongson_mrrs_quirk(struct pci_dev *pdev)
>  {
> -	struct pci_bus *bus = dev->bus;
> -	struct pci_dev *bridge;
> -	static const struct pci_device_id bridge_devids[] = {
> -		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> -		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> -		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
> -		{ 0, },
> -	};
> -
> -	/* look for the matching bridge */
> -	while (!pci_is_root_bus(bus)) {
> -		bridge = bus->self;
> -		bus = bus->parent;
> -		/*
> -		 * Some Loongson PCIe ports have a h/w limitation of
> -		 * 256 bytes maximum read request size. They can't handle
> -		 * anything larger than this. So force this limit on
> -		 * any devices attached under these ports.
> -		 */
> -		if (pci_match_id(bridge_devids, bridge)) {
> -			if (pcie_get_readrq(dev) > 256) {
> -				pci_info(dev, "limiting MRRS to 256\n");
> -				pcie_set_readrq(dev, 256);
> -			}
> -			break;
> -		}
> -	}
> +	/*
> +	 * Some Loongson PCIe ports have h/w limitations of maximum read
> +	 * request size. They can't handle anything larger than this. So
> +	 * force this limit on any devices attached under these ports.
> +	 */
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
> +
> +	bridge->no_inc_mrrs = 1;
>  }
> -DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_0, loongson_mrrs_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_1, loongson_mrrs_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_2, loongson_mrrs_quirk);
>  
>  static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
>  {
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f..72a15bf9eee8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5993,6 +5993,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>  {
>  	u16 v;
>  	int ret;
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
>  
>  	if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
>  		return -EINVAL;
> @@ -6011,6 +6012,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>  
>  	v = (ffs(rq) - 8) << 12;
>  
> +	if (bridge->no_inc_mrrs) {
> +		if (rq > pcie_get_readrq(dev))
> +			return -EINVAL;
> +	}
> +
>  	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
>  						  PCI_EXP_DEVCTL_READRQ, v);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 60adf42460ab..d146eb28e6da 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -569,6 +569,7 @@ struct pci_host_bridge {
>  	void		*release_data;
>  	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>  	unsigned int	no_ext_tags:1;		/* No Extended Tags */
> +	unsigned int	no_inc_mrrs:1;		/* No Increase MRRS */
>  	unsigned int	native_aer:1;		/* OS may use PCIe AER */
>  	unsigned int	native_pcie_hotplug:1;	/* OS may use PCIe hotplug */
>  	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
> -- 
> 2.27.0
> 
