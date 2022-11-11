Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5A0625F1A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 17:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiKKQG3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 11:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiKKQG2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 11:06:28 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EF856EFD;
        Fri, 11 Nov 2022 08:06:27 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8CBDF320090A;
        Fri, 11 Nov 2022 11:06:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 11 Nov 2022 11:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1668182783; x=
        1668269183; bh=84aqGE7+TnTRj/APHvCLROYWnvU22/p77SRHEtjrWtU=; b=F
        xkaQpJbyEmL5732RyXmGaJal9HbRh0WaXREu9QBq9LMmnHyecCe4/titrejs4iKF
        o4HXw82LSyyQmMDjViXoi6k958blmh+iyh+/6aChjzXgInLDe93n1kokqpkuVj0m
        hbcXdUGXWziaYueua9bmxPawrlAsODzFZdc+7Lm389Gs1Xxe8cX1JXkYnfvZQMkS
        8dafdKhm2qBb3mzwpq366YKPjOm7BCbLWiezwTavLpWIvoFFRP2DjsFEaqlP36cl
        LQiDaMk9UyZtBXoYWf+aTXApnfiExAUQKo/kGWx9U8KSmN5SDK2zeck5oL32vq71
        /d6WxuGRRkFpA0PG1Vzkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668182783; x=
        1668269183; bh=84aqGE7+TnTRj/APHvCLROYWnvU22/p77SRHEtjrWtU=; b=D
        6lQEillyzweHPuTxkbzirPgCg3A1Bb2g+oy4sUFOdJ43cyIb2ywwxdPHdUeRDp+5
        i703J8dnt/91FeCJ4XUDtJQx81hV9lyFcUJOLX5zfYRUc3Peq8aH7apo0MObOpWT
        rDNe6Fciiy2IF70eRZpm9thXBtWfwx4ehzHaNnmcXjefgnMAGXD87ppmdTsvKkNe
        WQmeKJOUTmbGBzTyI7mNQ28HetMGi3f+WTbA+QeFZhWzbNUipMHwGxuixpuJR96A
        +oMe12t8Uf0kNBfT50w4DG/ii+TNREy6zQHBf6/2JsYfcK3mAwy3dzmQeweLrhiP
        8/mAv7sONkAySQCcQd5UA==
X-ME-Sender: <xms:_nJuYxAzYaIzCo7Emhao-eT_lgxNnZBoNzZPWYB1eDu3ym5xIbQofA>
    <xme:_nJuY_g5-bEOWScs8xj0irFmSCrlvwyXYCTInGwL1uvUlfYn3FImT0LN1xtH0EIas
    ENnBP07xQKfxV8LfDM>
X-ME-Received: <xmr:_nJuY8nWMimJQtCY4D0pI49_Af8ACb1LKuS0IV8qYBLxW7YE-skKjyT3PDkt7Rsa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeeigdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeduhfekvedvtdeukeeffefgteelgfeugeeuledttdeijeegieeh
    vefghefgvdefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:_nJuY7x1zcuGf5yhsvUJ-E9COsKncYntIzMl_rezg22dstN_0LLIww>
    <xmx:_nJuY2TN1SuIfkYoILJW0f0KIj8Zs5IxGwlBbb_Y4Is0_7CffTj79A>
    <xmx:_nJuY-bnplG9vAspXuaXaixWWS8IqAqFBdaekOYH3DRGKaHtWpkA1A>
    <xmx:_3JuYybA_pt4NHazdIZrOCmmO3BcWQJEc34xD1FDT65n42_RhfMesg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Nov 2022 11:06:20 -0500 (EST)
Message-ID: <dfd408ed-5c2c-c73a-b901-6641ae7aae5f@flygoat.com>
Date:   Fri, 11 Nov 2022 16:06:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V4] PCI: loongson: Skip scanning unavailable child devices
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Liu Peibao <liupeibao@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20221110231351.GA681551@bhelgaas>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20221110231351.GA681551@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2022/11/10 23:13, Bjorn Helgaas 写道:
> On Thu, Nov 10, 2022 at 11:00:45PM +0000, Jiaxun Yang wrote:
>> 在2022年11月10日十一月 下午9:07，Bjorn Helgaas写道：
>>> On Tue, Nov 08, 2022 at 02:42:40PM +0800, Liu Peibao wrote:
>>>> The PCI Controller of 2k1000 could not mask devices by setting vender ID or
>>>> device ID in configuration space header as invalid values. When there are
>>>> pins shareable between the platform device and PCI device, if the platform
>>>> device is preferred, we should not scan this PCI device. In the above
>>>> scene, add `status = "disabled"` property in DT node of this PCI device.
>>>>
>>>> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
>>>> ---
>>>> V3 -> V4: 1. get rid of the masklist and search the status property
>>>> 	  directly.
>>>>            2. check the status property only when accessing the vendor ID.
>>>> V2 -> V3: 1. use list_for_each_entry() for more clearly.
>>>>            2. fix wrong use of sizeof().
>>>> V1 -> V2: use existing property "status" instead of adding new property.
>>>>
>>>>   drivers/pci/controller/pci-loongson.c | 11 +++++++++++
>>>>   1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
>>>> index 05c50408f13b..efca0b3b5a29 100644
>>>> --- a/drivers/pci/controller/pci-loongson.c
>>>> +++ b/drivers/pci/controller/pci-loongson.c
>>>> @@ -194,6 +194,17 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus,
>>>>   			return NULL;
>>>>   	}
>>>>   
>>>> +#ifdef CONFIG_OF
>>>> +	/* Don't access disabled devices. */
>>>> +	if (pci_is_root_bus(bus) && where == PCI_VENDOR_ID) {
>>>> +		struct device_node *dn;
>>>> +
>>>> +		dn = of_pci_find_child_device(bus->dev.of_node, devfn);
>>>> +		if (dn && !of_device_is_available(dn))
>>>> +			return NULL;
>>>> +	}
>>>> +#endif
>>> Looks nice and simple, thanks for trying this out.
>> Should we make this into common PCI code?
>> I guess Loongson won’t be the last platform having such problem.
> I think we should wait until somebody else has this problem.
>
> It's not a completely trivial situation because if the device uses PCI
> memory or I/O space, we have to worry about how that space is handled.
> Does the BIOS assign that space?  Is it included in the host bridge
> _CRS or "ranges" properties?  If the device is below any PCI bridges
> (I don't think that's the case in your situation), how does the space
> it requires get routed through the bridges?

I believe in this case the address is assigned by BIOS and they are out 
of ranges
properties of host bridge. Those are all on chip devices so there won't 
be any
bridges.

@Peibao, can you please confirm this? I was never able to boot mainline 
kernel
on my LS2K board.

Thanks.
- Jiaxun


>
> It would be nice to say something in this commit log about whether
> these are issues on your platform.
>
>>>>   	/* CFG0 can only access standard space */
>>>>   	if (where < PCI_CFG_SPACE_SIZE && priv->cfg0_base)
>>>>   		return cfg0_map(priv, bus, devfn, where);
>>>> -- 
>>>> 2.20.1
>>>>
>> -- 
>> - Jiaxun

