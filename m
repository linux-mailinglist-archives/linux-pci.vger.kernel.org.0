Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BB662B70C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 10:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiKPJ54 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 04:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiKPJ5w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 04:57:52 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B38723BD5;
        Wed, 16 Nov 2022 01:57:50 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8DxndodtHRjwb0HAA--.22737S3;
        Wed, 16 Nov 2022 17:57:49 +0800 (CST)
Received: from [10.20.42.77] (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxLeAatHRjIcAUAA--.54855S3;
        Wed, 16 Nov 2022 17:57:47 +0800 (CST)
Subject: Re: [PATCH V5] PCI: loongson: Skip scanning unavailable child devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        wanghongliang <wanghongliang@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221114171103.GA917836@bhelgaas>
From:   Liu Peibao <liupeibao@loongson.cn>
Message-ID: <bdf78e6a-3be9-2b5c-ac57-9df8341a2fcc@loongson.cn>
Date:   Wed, 16 Nov 2022 17:57:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221114171103.GA917836@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxLeAatHRjIcAUAA--.54855S3
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQAMCmNzgWVJUwAAsp
X-Coremail-Antispam: 1Uk129KBjvJXoWxZF15uw17XFW5Zr4DCw4DArb_yoW5ZF1xpF
        W3KFW8tr1DGr929wnFgw43ury7Aws7Zws5Gr1kCr12k3Z8WryaqrWxJF15Xay3XF1fXFWa
        vFWjqryktay5ZaUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOiSdUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/15/22 1:11 AM, Bjorn Helgaas wrote:
> Hi Liu,
> 
> On Mon, Nov 14, 2022 at 03:43:46PM +0800, Liu Peibao wrote:
>> The PCI Controller of 2K1000 could not mask devices by setting vender ID or
>> device ID in configuration space header as invalid values.
> 
> I don't think this 2K1000 information is really relevant.  I
> understand that some chipsets might support this, and they might use
> that to avoid this issue, but there's no PCI requirement that the
> Vendor/Device ID be writable by anything.
> 

OK, I think I got it.

>> When there are
>> pins shareable between the platform device and the on chip PCI device, if
> 
> What does "pins shareable between the platform device and the on chip
> PCI device" mean?
> 
> I assume there's a single device in the hardware, and both the
> "platform device" and the PCI device" refer to that single device?
> 
> And there's some reason you prefer to use the platform device
> interface to enumerate that device?
> 

No, they are not the same device. For example, GMAC1(on chip PCI device) and
GPIO(platform device, not PCI device) 14 use the same pin. The function for
this pin can be configured by one bit in general register, eg, 0 for GPIO 14,
1 for GMAC1. Sometimes, GPIO 14 is preferred, so configure the pin with
function GPIO 14 and disable GMAC1.

>> the platform device is preferred, we should not scan this PCI device. In
>> the above scene, add `status = "disabled"` property in DT node of this PCI
>> device.
>>
>> Before this patch, to solve the above problem, we treat the on chip PCI
>> devices as platform devices with fixed address assigned by the BIOS.
> 
> This says "before this patch".  But the rest of the sentence sounds
> like what happens *after* this patch.
> 

In fact, I want to describe an solution. But it seems that I described a
little confusing and please check the refactored commit log in the
following comments.

>> When
>> there is device not preferred, add the `status = "disabled"` property in DT
>> node.
> 
>> In kernel, the PCI host bridge only scans slot 9/A/B/C/D/E that are
>> bridges.
> 
> I guess this has something to do with pdev_may_exist() [1], but why do
> you mention it here?  Do you intend to remove pdev_may_exist() and use
> this DT mechanism instead?
> 
> Bjorn
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pci-loongson.c?id=v6.0#n168
> 

You are right and I did something ugly in pdev_may_exist() in my kernel. I
really don't want to continue doing this, so I am developing this patch.

Also I don't want to remove pdev_may_exist(). This patch could replace
pdev_may_exist() only in DT, but pdev_may_exist() matters in both ACPI and DT.

Overall, how about the following refactored commit log:

"This patch adds a mechanism to disable on chip PCI devices by DT. Typically,
when there are pins shareable between the platform device and the on chip PCI
device, if the PCI device is not preferred, add `status = "disabled"` property
to this PCI device DT node.

For example, on LS2K1000, GMAC1(on chip PCI device) and GPIO(platform device,
not PCI device) 14 share the same pin. If GMAC1 is not preferred, add
`status = "disabled"` property in GMAC1 DT node."

BR,
Peibao

