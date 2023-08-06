Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BC177133D
	for <lists+linux-pci@lfdr.de>; Sun,  6 Aug 2023 04:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjHFCUl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Aug 2023 22:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHFCUk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2023 22:20:40 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F701FEB;
        Sat,  5 Aug 2023 19:20:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 885395C006A;
        Sat,  5 Aug 2023 22:20:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 05 Aug 2023 22:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1691288435; x=1691374835; bh=eBLuoJP0n1NBWXXyrlrlfvTyBpHJAEX0vLs
        7vFMy6Eg=; b=1EgKEWU9AtCDIIJEMLwpRCUWVSB9Js90FA6Rmvhg89QnYXD5g1O
        faT12PWyhFK3JN0tc8SgBeLtByGkqR+XEQ8/hwMz6tmnIEQkcKZ8YqRomQeVq5Op
        KIs3fWfA9dHpr8qordy332MSqvbAWuMM5MWg63g/oNbZkPnP3E/00DXCabliYKxy
        RF/9hKT7wF0q8rBhU7u2+FS9xzZggLUJbI+yyUCPAYkgHhXGgYFc9+OLwRzrnSTW
        VJpDuUj9WSs4CVJAS5bW3eueUO/7CrYRFf3lgLTFddmmHSs8hNmxHENbLxMielha
        84kq0ea0nexhnec6lMw+OrKKhze9FDoyz2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691288435; x=1691374835; bh=eBLuoJP0n1NBWXXyrlrlfvTyBpHJAEX0vLs
        7vFMy6Eg=; b=nCxyZRnr09DVTfgIZdn76DhZXJv6zJtNZ8k+xWo2ARcvvTbLx28
        Z926ktj/DiiQLq/A1c+cDpQOZBmSps0TyEgjSTfYTKa9DGf6YQ2kaHw0eukcZOeS
        zGyWIaCxJ3GlMWkrvrtqg66jk0I726CzG5MT8EV7jQA8kBXrgxjgOzovzCddSxOl
        cQH1CFVjxdRMryDaq1QNihm9g+HAPUCvh3lGJ1OZEHN4z87Edz/7ZE9Voa2hp7KJ
        5VDauAaxlgUAU6hQUo36Z0u34CRMcCKBIim/DtR13co5XRdYwr6DchbdlKVUkO7b
        Lmr440mGY5RtmjerzZJmmfSfY0LmGL/ptBg==
X-ME-Sender: <xms:cwPPZMaMsBgpv2uGMx7Sn1oLMeACfXUJ-yVbI7hkXImDhggtrWK5VQ>
    <xme:cwPPZHbwI-QddYqlFniS4Px8IeKMOOAZi8ho_NwSiD2cOVuHbzHwh7yaJwurvj2Zh
    fc24OzgOcFu6byjPoA>
X-ME-Received: <xmr:cwPPZG--f2Vxcd_xxROf6CXJ3sK-3yEHgi2XY3pRhCmxhWJJZZwmB2Is_gb8BasquElG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeejgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtke
    ertddtfeejnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepffeltdeggfdufffhfe
    etleevueduuefghfelveeukeejleeuheevgfevieeiudfhnecuffhomhgrihhnpehkvghr
    nhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:cwPPZGo7sxED37FikivrUb8NT7UApZf1jRrtUMHpBVdg41ZKYkNNbg>
    <xmx:cwPPZHpMrX4m8iPcpGFdlM-0KuTF4vZIzln2Z2KUxGzRQ-LRt_hB_Q>
    <xmx:cwPPZETI3W8Qpw3il59uiaZPBprPZ4SAralIAXBIeV7gpc8kM9TaHg>
    <xmx:cwPPZIDwWyw9uqIat9GSPBGYqEXGKzLbhqKJFXbTAfp7If1z_UPbkQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Aug 2023 22:20:33 -0400 (EDT)
Message-ID: <e9c103dc-98ac-9a51-7291-f5da1467b2ff@flygoat.com>
Date:   Sun, 6 Aug 2023 10:20:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] pci: loongson: Workaround MIPS firmware MRRS settings
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, chenhuacai@kernel.org, kw@linux.com,
        lpieralisi@kernel.org, stable@vger.kernel.org
References: <20230725061008.1504292-1-jiaxun.yang@flygoat.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230725061008.1504292-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/7/25 14:10, Jiaxun Yang 写道:
> This is a partial revert of commit 8b3517f88ff2 ("PCI:
> loongson: Prevent LS7A MRRS increases") for MIPS based Loongson.
>
> There are many MIPS based Loongson systems in wild that
> shipped with firmware which does not set maximum MRRS properly.
>
> Limiting MRRS to 256 for all as MIPS Loongson comes with higher
> MRRS support is considered rare.
>
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217680
> Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Ping?
I expect this patch to go through PCI fixes tree.

Thanks
- Jiaxun

> ---
> v2: Rename quirk name to: loongson_old_mrrs_quirk
> ---
>   drivers/pci/controller/pci-loongson.c | 38 +++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index fe0f732f6e43..d0f68b102d10 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -108,6 +108,44 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>   			DEV_LS7A_PCIE_PORT6, loongson_mrrs_quirk);
>   
> +#ifdef CONFIG_MIPS
> +static void loongson_old_mrrs_quirk(struct pci_dev *pdev)
> +{
> +	struct pci_bus *bus = pdev->bus;
> +	struct pci_dev *bridge;
> +	static const struct pci_device_id bridge_devids[] = {
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
> +		{ 0, },
> +	};
> +
> +	/* look for the matching bridge */
> +	while (!pci_is_root_bus(bus)) {
> +		bridge = bus->self;
> +		bus = bus->parent;
> +		/*
> +		 * There are still some wild MIPS Loongson firmware won't
> +		 * set MRRS properly. Limiting MRRS to 256 as MIPS Loongson
> +		 * comes with higher MRRS support is considered rare.
> +		 */
> +		if (pci_match_id(bridge_devids, bridge)) {
> +			if (pcie_get_readrq(pdev) > 256) {
> +				pci_info(pdev, "limiting MRRS to 256\n");
> +				pcie_set_readrq(pdev, 256);
> +			}
> +			break;
> +		}
> +	}
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_old_mrrs_quirk);
> +#endif
> +
>   static void loongson_pci_pin_quirk(struct pci_dev *pdev)
>   {
>   	pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);

