Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6671868E658
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 04:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBHDAO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 22:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjBHDAO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 22:00:14 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 884433D0A4;
        Tue,  7 Feb 2023 19:00:11 -0800 (PST)
Received: from loongson.cn (unknown [112.20.108.204])
        by gateway (Coremail) with SMTP id _____8BxKuo6EONj1c8PAA--.31184S3;
        Wed, 08 Feb 2023 11:00:10 +0800 (CST)
Received: from [0.0.0.0] (unknown [112.20.108.204])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxc+U4EONj2pYsAA--.50954S3;
        Wed, 08 Feb 2023 11:00:09 +0800 (CST)
Message-ID: <0bb33ba8-00af-777b-fb97-a086b91865b0@loongson.cn>
Date:   Wed, 8 Feb 2023 11:00:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V6] PCI: loongson: Skip scanning disabled child devices
To:     Liu Peibao <liupeibao@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        wanghongliang <wanghongliang@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenhuacai@kernel.org
References: <20221117020935.32086-1-liupeibao@loongson.cn>
From:   Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20221117020935.32086-1-liupeibao@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxc+U4EONj2pYsAA--.50954S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uF4fXrWUurWxWFWUAFyUGFg_yoW8ZF1kpF
        Z8AayakrWrtF1IkanIv34UuF1S9w4kG397GFs7CrnF93ZxG34YgryxGFyYq3s0qr4kX3Wa
        va4kKr1xCF4UJr7anT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


在 2022/11/17 10:09, Liu Peibao 写道:
> Add a mechanism to disable on chip PCI devices by DT. Typically, when there
> are pins shareable between the platform device and the on chip PCI device,
> if the PCI device is not preferred, add `status = "disabled"` property to
> this PCI device DT node.
>
> For example, on LS2K1000, GMAC1 (on chip PCI device) and GPIO (platform
> device, not PCI device) 14 share the same pin. If GMAC1 is not preferred,
> add `status = "disabled"` property in GMAC1 DT node.
>
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
Tested-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
> V5 -> V6: 1. rewrite the commit log to make things clear.
> 	  2. replace "unavailable" as "disabled" in patch subject.
> V4 -> V5: clear the issue we are facing in commit log.
> V3 -> V4: 1. get rid of the masklist and search the status property
> 	  directly.
>            2. check the status property only when accessing the vendor ID.
> V2 -> V3: 1. use list_for_each_entry() for more clearly.
>            2. fix wrong use of sizeof().
> V1 -> V2: use existing property "status" instead of adding new property.
>
>   drivers/pci/controller/pci-loongson.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 05c50408f13b..efca0b3b5a29 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -194,6 +194,17 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus,
>   			return NULL;
>   	}
>   
> +#ifdef CONFIG_OF
> +	/* Don't access disabled devices. */
> +	if (pci_is_root_bus(bus) && where == PCI_VENDOR_ID) {
> +		struct device_node *dn;
> +
> +		dn = of_pci_find_child_device(bus->dev.of_node, devfn);
> +		if (dn && !of_device_is_available(dn))
> +			return NULL;
> +	}
> +#endif
> +
>   	/* CFG0 can only access standard space */
>   	if (where < PCI_CFG_SPACE_SIZE && priv->cfg0_base)
>   		return cfg0_map(priv, bus, devfn, where);

