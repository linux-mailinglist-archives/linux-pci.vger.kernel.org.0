Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486373B5CD6
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 12:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhF1LB7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 07:01:59 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:45239 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232708AbhF1LB6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 07:01:58 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9C99832007F9;
        Mon, 28 Jun 2021 06:59:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 28 Jun 2021 06:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=J
        0r5jhfEbM+pULp+xSbVxQq2d2pYLTDUf4DdunX9qjQ=; b=CjAUyPBKianVY84Go
        cMmQRCxe/WHfhAOIfUhGlElg0qeTadxBhZfmBGzyIesu7iLOFlODaf6vv3WVabtP
        PooW96LMWHSrRzxcsYpVqa5WfFroNO1DnWV1BENR6dwQ4CkS3BFDUAxF/dHXpUom
        VxHiMhF3S/jImO7dmOXAq0fDHYWAcIVBA8CqlGY8lrs69suFvK6SVMJR31iPFMGq
        0l1R5v0qE8MvVtoMWsttEWtbv0YsGsexhYiHuRsJpErwbo9GM3mL0NVi329JCZDO
        3foNt3Yh3EU1OI0y5YV5OO7mDm2XH9758Mz9lkPHXsR4lfYNw1WZKI8K9AYAfjzf
        h3o1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=J0r5jhfEbM+pULp+xSbVxQq2d2pYLTDUf4DdunX9q
        jQ=; b=T+D0JeL73M/boIC/0wcis1PwjXfhKSDb4BqM07aeDGn9I3SXV5GZ6P6/g
        6pMOZvUp6XZ2t5/COB27LlgwBA9MG4XCkllpRVJ0W1EtjBNVo4fPKDMzqDOAyJTz
        bXnMk9WiZsqh96hst0LRBhTlYI6N553/14VYJy9mTARSD+5VOpQYaE1w6vIvTkZx
        +YbczbucQvgKF+w/fotueQuSE+iFZ+PgyYl6MDWk5zDKltEjx0KINxsK8Hcqusjq
        rvzkz0zh9zR46ksn78OIZEvXT1jVvtpJm8AsaVQlWP1cJSl7+SGSTnzUjj4Garxn
        QEqAtdwfKkxqiRPrwG2tYbZeUq6bQ==
X-ME-Sender: <xms:k6vZYDNOB9BwUbQ6f6_Uf8ms2E30Dmr-H-e47YCq2h44ays4BAQ_PA>
    <xme:k6vZYN85WLyXTvYnEDN7TeDAe9UjJg_-KYWjLKrsuOVOuF42lDbSqwF02DzNL9jUD
    XJHyon-8C_g58P6hLY>
X-ME-Received: <xmr:k6vZYCRWgyjL8hKQ_TdmrKlXRTLFJ1fqfouwCgXqxosjpQi-E06Y_-AwCAiG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehgedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdeftfenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeefleduiedtvdekffeggfeukeejgeeffeetlefghfekffeuteei
    jeeghefhueffvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:k6vZYHtxYyX3r3VOll9HCGH6C0ld1oO0GqUU4aFrWPl3VU4xHTtA5w>
    <xmx:k6vZYLeX88awNa6rZJJKpJJWF_fkCe_ft-6QA6BhtYssqinbBDMbeg>
    <xmx:k6vZYD2foJ-Vk-JcsYx5N5mYHJhqLjip_oAC0j2VEgfuInoJkvrYyA>
    <xmx:lKvZYC4sAwdOErrD5o1xI42PUzk7tkTN5sTYlJO25OMrSLtE1qEraw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 06:59:29 -0400 (EDT)
Subject: Re: [PATCH V4 4/4] PCI: Add quirk for multifunction devices of LS7A
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jianmin Lv <lvjianmin@loongson.cn>
References: <20210628101027.1372370-1-chenhuacai@loongson.cn>
 <20210628101027.1372370-5-chenhuacai@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <6928fc97-37c9-b307-a743-d94c0cfa759b@flygoat.com>
Date:   Mon, 28 Jun 2021 18:59:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628101027.1372370-5-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



ÔÚ 2021/6/28 ÏÂÎç6:10, Huacai Chen Ð´µÀ:
> From: Jianmin Lv <lvjianmin@loongson.cn>
>
> In LS7A, multifunction device use same PCI PIN (because the PIN register
> report the same INTx value to each function) but we need different IRQ
> for different functions, so add a quirk to fix it for standard PCI PIN
> usage.
>
> This patch only affect ACPI based systems (and only needed by ACPI based
> systems, too). For DT based systems, the irq mappings is defined in .dts
> files and be handled by of_irq_parse_pci().
>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

> ---
>   drivers/pci/quirks.c    | 14 ++++++++++++++
>   include/linux/pci_ids.h | 10 ++++++++++
>   2 files changed, 24 insertions(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4bbdf5a5425f..bb5d257f9ccd 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -242,6 +242,20 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>   			DEV_LS7A_LPC, loongson_system_bus_quirk);
>   
> +static void loongson_pci_pin_quirk(struct pci_dev *dev)
> +{
> +	dev->pin = 1 + (PCI_FUNC(dev->devfn) & 3);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_0, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_1, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_2, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_AHCI, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_EHCI, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_OHCI, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DC, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_GPU, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_GMAC, loongson_pci_pin_quirk);
> +
>   static void loongson_mrrs_quirk(struct pci_dev *pdev)
>   {
>   	/*
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 4c3fa5293d76..dc024ab21d91 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -151,6 +151,16 @@
>   /* Vendors and devices.  Sort key: vendor first, device next. */
>   
>   #define PCI_VENDOR_ID_LOONGSON		0x0014
> +#define PCI_DEVICE_ID_LOONGSON_APB      0x7a02
> +#define PCI_DEVICE_ID_LOONGSON_GMAC     0x7a03
> +#define PCI_DEVICE_ID_LOONGSON_DC       0x7a06
> +#define PCI_DEVICE_ID_LOONGSON_HDA      0x7a07
> +#define PCI_DEVICE_ID_LOONGSON_GPU      0x7a15
> +#define PCI_DEVICE_ID_LOONGSON_AHCI     0x7a08
> +#define PCI_DEVICE_ID_LOONGSON_EHCI     0x7a14
> +#define PCI_DEVICE_ID_LOONGSON_OHCI     0x7a24
> +#define PCI_DEVICE_ID_LOONGSON_LPC      0x7a0c
> +#define PCI_DEVICE_ID_LOONGSON_DMA      0x7a0f
>   
>   #define PCI_VENDOR_ID_TTTECH		0x0357
>   #define PCI_DEVICE_ID_TTTECH_MC322	0x000a

