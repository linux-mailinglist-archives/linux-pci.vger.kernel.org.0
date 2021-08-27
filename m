Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C7D3F9923
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 14:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245113AbhH0MoZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 08:44:25 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:35733 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245120AbhH0MoZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Aug 2021 08:44:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5EAB132003CE;
        Fri, 27 Aug 2021 08:43:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 27 Aug 2021 08:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=a
        1Wyd0t+sG4CAOU++QCMkH6driePwZ8RJe50nnc1/rQ=; b=iw1nwiG6QU5FMZkxT
        1QpBHw4f4uGgzTorra+kjA9i/2Il4ikTXSVPf/aFYoGjpukUkMmQFFHzps/rdIjj
        n/Pu3gAEA/LMEsvkQvhMJQyNW5vgd0O4HZE2cihXzU4gzVGqAEKHcnP+OajA6rn5
        5JI3Ekg0Kh+487plimhB/KmH7gwIuF8MbpGq7YjIIZRvt63A+i4u9v6Jjf/DAAxX
        lqwLRFCLTBOeHF2LmEPzEC9+FN8ga2rSsTPtNHo1wDRasTMG6Bv2TgvTuy+S2Jbr
        sbM91Jge3R/gQb/3W5l8fNUnYhb8O2qVfZi8Ix70U77OMaR/rXQcsWsIUczbjO3Z
        IjvOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=a1Wyd0t+sG4CAOU++QCMkH6driePwZ8RJe50nnc1/
        rQ=; b=CXa12nV65dc93cZ8mn1qUZII2ptBMGi5B7tGjhdD0obCYvnxINV+rP9Yt
        JulQYWpFBYG4f8GC2oNGYVfdE3XceCLCUzWXWxRbH5MIwZz9ArKS6BNfCaH5v8aP
        o1rBehhBC7FBkKxVYt9udRx0b/4Amk42Ycs5PCp1046Y9mDrpjvBTRO3oHeJaJHE
        Qx4WpQCzFt2YK0z/WbdLOJPglM1z7iAuGey7ca5a1qjqPOHgmOXNwGlelGfyvHYL
        6r83VTgAJI57z2SO/o8ZM8e5/DvapFBsIXGV28ejPDqnyhjp6QUn2yfnAZKSSEyU
        t86LmVE/RubsXqIOMAAT68Vn79qJw==
X-ME-Sender: <xms:990oYU0U0yfHHL75W5DFFejeR4s6A5yitcDF3iIqsocwc9FuiqXL2g>
    <xme:990oYfHuDl4YldVg3UPt6sO9ylADLkO6gIrwgTQllvVXuHLk89879ngT_J3_ksil2
    C3mHYa14L5gDQhuAnA>
X-ME-Received: <xmr:990oYc6alLJSfm7l14bYJAA0pXyUZl3a2xNea1lcflrVO8FozMNIMlYJfIjuNgm4ISw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddufedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdeftfenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeefleduiedtvdekffeggfeukeejgeeffeetlefghfekffeuteei
    jeeghefhueffvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:990oYd1pJiueSofjJupGz8XqvG_olKcVF30u-5TrPUUJzmz-m9xuzA>
    <xmx:990oYXFld1wxVkfcjTj4V0EKrQjEHBgO0ZW_gFBHtAPxx9W5o54Hsw>
    <xmx:990oYW9TDKf0hq_H2f-fflRSaSYIXR-N-jgk0AUkm4cf-iOg64nKHA>
    <xmx:-N0oYfAXHBZq-rwXrnABScjAn2wmyMogVk9GMV6C7UBwxFQ7TAXPWw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Aug 2021 08:43:31 -0400 (EDT)
Subject: Re: [PATCH V9 3/5] PCI: Improve the MRRS quirk for LS7A
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>
References: <20210827082031.2777623-1-chenhuacai@loongson.cn>
 <20210827082031.2777623-4-chenhuacai@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <3f3682c9-b0a3-9776-b12a-625115d8eebc@flygoat.com>
Date:   Fri, 27 Aug 2021 20:43:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210827082031.2777623-4-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


ÔÚ 2021/8/27 16:20, Huacai Chen Ð´µÀ:
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

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

I guess they got a improper value of CC_MSTR_BURST_LEN for deisgnware 
pcie core.

Thanks.

- Jiaxun

> ---
>   drivers/pci/controller/pci-loongson.c | 47 ++++++++++-----------------
>   drivers/pci/pci.c                     |  6 ++++
>   include/linux/pci.h                   |  1 +
>   3 files changed, 25 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 164c0f6e419f..3aa98f9e94a8 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -67,37 +67,26 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>   			DEV_LS7A_LPC, system_bus_quirk);
>   
> -static void loongson_mrrs_quirk(struct pci_dev *dev)
> +static void loongson_mrrs_quirk(struct pci_dev *pdev)
>   {
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
> +		return;
> +
> +	bridge->no_inc_mrrs = 1;
>   }
> -DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_0, loongson_mrrs_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_1, loongson_mrrs_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_2, loongson_mrrs_quirk);
>   
>   static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
>   {
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index aacf575c15cf..3279da8ce2dd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5800,6 +5800,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>   {
>   	u16 v;
>   	int ret;
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
>   
>   	if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
>   		return -EINVAL;
> @@ -5818,6 +5819,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>   
>   	v = (ffs(rq) - 8) << 12;
>   
> +	if (bridge->no_inc_mrrs) {
> +		if (rq > pcie_get_readrq(dev))
> +			return -EINVAL;
> +	}
> +
>   	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
>   						  PCI_EXP_DEVCTL_READRQ, v);
>   
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 540b377ca8f6..e2583c2785e2 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -541,6 +541,7 @@ struct pci_host_bridge {
>   	void		*release_data;
>   	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>   	unsigned int	no_ext_tags:1;		/* No Extended Tags */
> +	unsigned int	no_inc_mrrs:1;		/* No Increase MRRS */
>   	unsigned int	native_aer:1;		/* OS may use PCIe AER */
>   	unsigned int	native_pcie_hotplug:1;	/* OS may use PCIe hotplug */
>   	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
