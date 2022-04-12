Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAC94FE429
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 16:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356757AbiDLOvg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 10:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356756AbiDLOvg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 10:51:36 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE6A18392
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 07:49:18 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-de3ca1efbaso20991368fac.9
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 07:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MI/s8lMb+5u9jDXMESm67P3hh7kDpykXHC+Y/RJF84A=;
        b=56O9tT1QRqtS08dRScUmWklBBdxwJ25OkqyFh8qKnW5Fd5lgxyqobGx2ABCl0NL/7u
         HIzLW1WYYmrcI5TkI5vFUAeKM5vOKjUcRG/zTss7S/7U6g2QsyCog9AyIypK5onR+9Co
         lAd7QWBhVaPwymffdH0nK0m1jD2DqnePvMvmvX6a0TsZwnJ0GxttYrpxM1rDXwh7SqSQ
         +A501U2dMFezJ3DtH4oU7vrDTtjfC3P1kMZM4EnUHxw0yiPITd1sbx8BxWNz19sGqB49
         5WR/TFVoHSw8BRn3Y31CZ1Bmza13958mrcrJJ8nANxaRQVAzfa7ZVVWuHbFOdxcXA1Sm
         sl8Q==
X-Gm-Message-State: AOAM532758AXem/WLliJBCs3zaNAwvleI8U7c1wPoBSsAh0Jkpc/nb6f
        wdfgv0irMhP05prce2FPD7oJlWk5BA==
X-Google-Smtp-Source: ABdhPJwUotTgf8IcQnbPpu0mkxdh8FumjKvhk7ToNcfcWBQX5t22KktLun3tNILU6iSaX8dNJpcArg==
X-Received: by 2002:a05:6808:148:b0:2ec:f0e2:fc42 with SMTP id h8-20020a056808014800b002ecf0e2fc42mr1844690oie.84.1649774946984;
        Tue, 12 Apr 2022 07:49:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q18-20020a056830019200b005e6b8f3a819sm5653190ota.75.2022.04.12.07.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 07:49:06 -0700 (PDT)
Received: (nullmailer pid 109670 invoked by uid 1000);
        Tue, 12 Apr 2022 14:49:05 -0000
Date:   Tue, 12 Apr 2022 09:49:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V12 4/6] PCI: loongson: Improve the MRRS quirk for LS7A
Message-ID: <YlWRYTuS6194hVjV@robh.at.kernel.org>
References: <20220226104731.76776-1-chenhuacai@loongson.cn>
 <20220226104731.76776-5-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226104731.76776-5-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 26, 2022 at 06:47:29PM +0800, Huacai Chen wrote:
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
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/controller/pci-loongson.c | 47 ++++++++++-----------------
>  drivers/pci/pci.c                     |  6 ++++
>  include/linux/pci.h                   |  1 +
>  3 files changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 48d9d283cb59..ba182f9d5718 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -67,37 +67,26 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
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
> +	if (!bridge)

Isn't this condition impossible? I'd drop and just let the NULL 
dereference fault happen rather than continue on silently.

> +		return;
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
> index 8253a5413d7c..01a464eb640a 100644
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
