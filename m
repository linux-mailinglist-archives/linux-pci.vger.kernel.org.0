Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848B22CF3F1
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 19:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbgLDSWa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 13:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbgLDSW3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2020 13:22:29 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FF1C061A55;
        Fri,  4 Dec 2020 10:21:31 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id 4so3572125plk.5;
        Fri, 04 Dec 2020 10:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t/9k3cwk4YOKtht2Hl/Q0FI3nM9oIxVm1XwO7ouF7F4=;
        b=UHWo8bj9kGDvwqWBPw1JUXubVV+KAAHoOUgnRxaxqaWEJ6hwBWaKNLevwwWCqZyAcn
         qOLH1F0Q46ErXOJytbSmEQuYp1fgpxzZTp5LscsUDnZuxRQrW27JeLO+1w1vKiIvmqrx
         L64jB8afbwAhQHiryJ94LWlcF62oEkbVKjQRzUFF1GN5OXHwA2eLPMxj3Ttz5CJVLYoS
         0Um6rP7F8dt001OLWubnk+vywjmapkCsGRJ1giQAv5YYV3j3vLDxH4FVaLhkxZOM2leW
         EMTWhv4Cakg7fG5hkrbpV/j4oW1uXWY3lU1CsvgYWFe9ojKg7JzQMBkT6eje0MTnJeXW
         Js/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t/9k3cwk4YOKtht2Hl/Q0FI3nM9oIxVm1XwO7ouF7F4=;
        b=Hh79AZZtcFlRYMETrsJLvmpk7spvK6FnsYqYwjSvjriVFccLstH6r7T+V1nUVGpqGY
         bH4U+FtWiMPCofcp3le2URhSXrHB4RnMHd35Tu+Fq9z2uFk8wvGMqqnxqD2qJ9sicRUp
         5Btfl2t91CFOh5sbRs2KiLIJlGTd8iy3UYGM6d2EqpbYs5b/T0p1xEzdACPZXQ2RgEnP
         QJ4CQxqUAH5STlUV/Q1OrFhgbzcd2QfF0QKfLxEp2Iy3Ar9Lslyxlly6dVrcSrh8WwOC
         PokxPqUmAu4aKDKd2Hd/DXcgk0KFWX6w1nLtgX/CeMDZw2KjdOpFNK++10mMRMKKstZp
         5Isg==
X-Gm-Message-State: AOAM533T3mxIFf4GH5lICTwl9/nJT6xOyCQ8sYF12fQmzcvuddJxLLyX
        sE0g9yGJjgvTszaHBQ3boH4=
X-Google-Smtp-Source: ABdhPJzTE/+rlAt74ND5eZrGarncAkAdxjC4fiXRCdC9zAZuQ2cc8DpvddCivjwi0v8LmOBxj79ibg==
X-Received: by 2002:a17:902:82c7:b029:da:cb88:38f8 with SMTP id u7-20020a17090282c7b02900dacb8838f8mr5121068plz.49.1607106091162;
        Fri, 04 Dec 2020 10:21:31 -0800 (PST)
Received: from [10.230.29.29] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 24sm5399670pgy.45.2020.12.04.10.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 10:21:29 -0800 (PST)
Subject: Re: [PATCH V2 2/2] PCI: brcmstb: support BCM4908 with external PERST#
 signal controller
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201130083223.32594-1-zajec5@gmail.com>
 <20201130083223.32594-3-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <812ab1ce-15e0-d260-97cf-597388505416@gmail.com>
Date:   Fri, 4 Dec 2020 10:21:25 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201130083223.32594-3-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/30/2020 12:32 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> BCM4908 uses external MISC block for controlling PERST# signal. Use it
> as a reset controller.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Reorder BCM4908 in the enum pcie_type
>     Use devm_reset_control_get_optional_exclusive()
>     Don't move hw_rev read up in the code
> ---
>  drivers/pci/controller/Kconfig        |  2 +-
>  drivers/pci/controller/pcie-brcmstb.c | 32 +++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 64e2f5e379aa..d44c70bb88f6 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -273,7 +273,7 @@ config VMD
>  
>  config PCIE_BRCMSTB
>  	tristate "Broadcom Brcmstb PCIe host controller"
> -	depends on ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST
> +	depends on ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCM4908 || COMPILE_TEST
>  	depends on OF
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	default ARCH_BRCMSTB
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 9c3d2982248d..98536cf3af58 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -96,6 +96,7 @@
>  
>  #define PCIE_MISC_REVISION				0x406c
>  #define  BRCM_PCIE_HW_REV_33				0x0303
> +#define  BRCM_PCIE_HW_REV_3_20				0x0320
>  
>  #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT		0x4070
>  #define  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_MASK	0xfff00000
> @@ -190,6 +191,7 @@
>  struct brcm_pcie;
>  static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val);
>  static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val);
> +static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
>  static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
>  static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
>  
> @@ -206,6 +208,7 @@ enum {
>  
>  enum pcie_type {
>  	GENERIC,
> +	BCM4908,
>  	BCM7278,
>  	BCM2711,
>  };
> @@ -230,6 +233,13 @@ static const struct pcie_cfg_data generic_cfg = {
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  };
>  
> +static const struct pcie_cfg_data bcm4908_cfg = {
> +	.offsets	= pcie_offsets,
> +	.type		= BCM4908,
> +	.perst_set	= brcm_pcie_perst_set_4908,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +};
> +
>  static const int pcie_offset_bcm7278[] = {
>  	[RGR1_SW_INIT_1] = 0xc010,
>  	[EXT_CFG_INDEX] = 0x9000,
> @@ -282,6 +292,7 @@ struct brcm_pcie {
>  	const int		*reg_offsets;
>  	enum pcie_type		type;
>  	struct reset_control	*rescal;
> +	struct reset_control	*perst_reset;
>  	int			num_memc;
>  	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>  	u32			hw_rev;
> @@ -747,6 +758,17 @@ static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32
>  	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>  }
>  
> +static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
> +{
> +	if (WARN_ONCE(!pcie->perst_reset, "missing PERST# reset controller\n"))
> +		return;
> +
> +	if (val)
> +		reset_control_assert(pcie->perst_reset);
> +	else
> +		reset_control_deassert(pcie->perst_reset);

This looks good to me now, just one nit, you probably do not support
suspend/resume on the 4908, likely never will, but you should probably
pulse the PERST# during PCIe resume, too. With that fixed:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
