Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A825B3B5CD2
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 12:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhF1LBg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 07:01:36 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:34719 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232745AbhF1LBg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 07:01:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id BDB633200657;
        Mon, 28 Jun 2021 06:59:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 28 Jun 2021 06:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=k
        TJlnWKR84CxYu7zd9bGDN5rrhNP5QPzdcD/lsAI4sc=; b=WV8pJDXnSdUYBFMQ+
        RcxtqHBbAZ6u0CtCLOLQObbH68o5hyI5b1keZJCfAWhGENeJHVeFCkLQXfLFgfIO
        sxG6maF6QMiCUCC1QgcMhGS3E8D5rIiARv1vpdauA0K5xk2ZACkI9qZOZses4lkW
        iADEOzYqgIzZDlk556ORUpQ1Cn8/m6ckzzW5l4A0G12j+EerUyOqiacT6d4ReqX1
        4G74BAZmtT4MmrKjWWJzYSdy9Rt7YO+rX44IGsN/93Oi3lnyjcfxE8fbn5ABJRPc
        vqE5p7R8GHU8KixO41FJMAy7nPtXVltzHI+r6cnLgzVqcJp8C80eiNT8p5lFQTDi
        Vt9eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=kTJlnWKR84CxYu7zd9bGDN5rrhNP5QPzdcD/lsAI4
        sc=; b=oLm8I1F44ggnCcNZ/hl0lHYU+BYyoxABCdAyl3CHoxeVJz1ZDQBe3V+8w
        WM5rIaDFAZNH0cV9Hwx9fQgghVWpI74RYDUWjv44YNAoqNcokWle8d81IAEYxeuV
        i3DKyumHeZEHPHZu7JKmJGe8FZsNFLkk1N+Gf24/XbyNNsdWaI8QUWC+ovy+EebG
        T22l6R6CCPQem4j+glnjYeITg1zlymLcbQpW5iZ/FQJA1WuRx1+yIQJkdSr8oYsI
        n9yfMeMkg4Pl7GHC/TBInik17HQPk4xLSyin6U8rRk+aJQo/U/T82FYKnRcbXC8p
        0aKboMci6/3bMYFwY2RuzJf6/oPAw==
X-ME-Sender: <xms:favZYL7XSR-JJsFGitGcfoyrPrGdLbYtJFM8TMoLBUmho0ubzqXvHw>
    <xme:favZYA6sY5nk0ppOgAesZjCmm6OKgKPDUu9J0Rzta21T86X5M4joq-9Ld5la0_Kfe
    O6i19bYzQc-Yasl6WU>
X-ME-Received: <xmr:favZYCcuTZSeD1WhkkFOOns79vybe-M_WU8i5e37L7BzBSJ9uKg8D0Slsftk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehgedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdeftfenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeefleduiedtvdekffeggfeukeejgeeffeetlefghfekffeuteei
    jeeghefhueffvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:favZYMIcKx_sMautKIkTUaYxYnASXDCbn0i9A9UymhXbFDVBFKRLaA>
    <xmx:favZYPJOTfxZyp_aRWeRzOw-HBLYk3UqlKlH2rs-ijNqMVB8efXNyA>
    <xmx:favZYFyl1gVvO1cJZxkSc8N9mRM2OTpuoh70HsYAQ1nAFhLAzvgTfQ>
    <xmx:fqvZYH3aUwGxAftnCEtjD59AQ6KJSpGxVW-9pWcYrJkJIoyPGXRC2g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 06:59:07 -0400 (EDT)
Subject: Re: [PATCH V4 3/4] PCI: Improve the MRRS quirk for LS7A
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>
References: <20210628101027.1372370-1-chenhuacai@loongson.cn>
 <20210628101027.1372370-4-chenhuacai@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <4a90ec47-d212-b8c6-d8bd-599e52dff440@flygoat.com>
Date:   Mon, 28 Jun 2021 18:59:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628101027.1372370-4-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



ÔÚ 2021/6/28 ÏÂÎç6:10, Huacai Chen Ð´µÀ:
> In new revision of LS7A, some PCIe ports support larger value than 256,
> but their maximum supported MRRS values are not detectable. Moreover,
> the current loongson_mrrs_quirk() cannot avoid devices increasing its
> MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
> will actually set a big value in its driver. So the only possible way
> is configure MRRS of all devices in BIOS, and add a PCI bus flag (i.e.,
> PCI_BUS_FLAGS_NO_INC_MRRS) to stop the increasing MRRS operations.
>
> However, according to PCIe Spec, it is legal for an OS to program any
> value for MRRS, and it is also legal for an endpoint to generate a Read
> Request with any size up to its MRRS. As the hardware engineers say, the
> root cause here is LS7A doesn't break up large read requests. In detail,
> LS7A PCIe port reports CA (Completer Abort) if it receives a Memory Read
> request with a size that's "too big" (Yes, that is a problem in the LS7A
> hardware design).
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

> ---
>   drivers/pci/pci.c    |  5 +++++
>   drivers/pci/quirks.c | 41 +++++++++++------------------------------
>   include/linux/pci.h  |  1 +
>   3 files changed, 17 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8d4ebe095d0c..0f1ff4a6fe44 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5812,6 +5812,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>   
>   	v = (ffs(rq) - 8) << 12;
>   
> +	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_INC_MRRS) {
> +		if (rq > pcie_get_readrq(dev))
> +			return -EINVAL;
> +	}
> +
>   	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
>   						  PCI_EXP_DEVCTL_READRQ, v);
>   
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index dee4798a49fc..4bbdf5a5425f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -242,37 +242,18 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>   			DEV_LS7A_LPC, loongson_system_bus_quirk);
>   
> -static void loongson_mrrs_quirk(struct pci_dev *dev)
> -{
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
> +static void loongson_mrrs_quirk(struct pci_dev *pdev)
> +{
> +	/*
> +	 * Some Loongson PCIe ports have h/w limitations of maximum read
> +	 * request size. They can't handle anything larger than this. So
> +	 * force this limit on any devices attached under these ports.
> +	 */
> +	pdev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_INC_MRRS;
>   }
> -DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_0, loongson_mrrs_quirk);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_1, loongson_mrrs_quirk);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_2, loongson_mrrs_quirk);
>   
>   /*
>    * The Mellanox Tavor device gives false positive parity errors.  Disable
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 24306504226a..b336239b5282 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -240,6 +240,7 @@ enum pci_bus_flags {
>   	PCI_BUS_FLAGS_NO_MMRBC	= (__force pci_bus_flags_t) 2,
>   	PCI_BUS_FLAGS_NO_AERSID	= (__force pci_bus_flags_t) 4,
>   	PCI_BUS_FLAGS_NO_EXTCFG	= (__force pci_bus_flags_t) 8,
> +	PCI_BUS_FLAGS_NO_INC_MRRS = (__force pci_bus_flags_t) 16,
>   };
>   
>   /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */

