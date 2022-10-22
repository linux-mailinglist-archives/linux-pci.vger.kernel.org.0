Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9BB608378
	for <lists+linux-pci@lfdr.de>; Sat, 22 Oct 2022 04:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJVCFp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Oct 2022 22:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJVCFp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2022 22:05:45 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67EEF23AB5A;
        Fri, 21 Oct 2022 19:05:42 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.32])
        by gateway (Coremail) with SMTP id _____8Cxbbf1T1Nju5EBAA--.1939S3;
        Sat, 22 Oct 2022 10:05:41 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxj+D0T1NjQCgDAA--.12570S3;
        Sat, 22 Oct 2022 10:05:40 +0800 (CST)
Subject: Re: [PATCH V4 1/4] ACPI / PCI: fix LPIC IRQ model default PCI IRQ
 polarity
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, rafael@kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20221021120129.GA185586@bhelgaas>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <8362ab48-7769-8139-8ca9-aca75147a853@loongson.cn>
Date:   Sat, 22 Oct 2022 10:05:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221021120129.GA185586@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxj+D0T1NjQCgDAA--.12570S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJr1UAF45uw4Dtr4xJFyrJFb_yoW8JFWkpF
        WYg3WayF4Dtw45Zrn7ta1UA3WYyF43trsxJws8A3yrW3s0vw15Xr18tayrKF93CrZ7A340
        vFySv348u3WYkrJanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kK
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



On 2022/10/21 下午8:01, Bjorn Helgaas wrote:
> On Fri, Oct 21, 2022 at 09:58:57AM +0800, Jianmin Lv wrote:
>> On 2022/10/21 上午12:47, Bjorn Helgaas wrote:
>>> On Thu, Oct 20, 2022 at 04:22:02PM +0800, Jianmin Lv wrote:
>>>> On LoongArch ACPI based systems, the PCI devices (e.g. sata
>>>> controlers and PCI-to-to PCI bridge controlers) existed in
>>>> Loongson chipsets output high-level interrupt signal to the
>>>> interrupt controller they connected to,
> 
>>> The point is that one should be able to write this code from a spec,
>>> without having to empirically discover the interrupt polarity.  What
>>> spec tells you about using ACTIVE_HIGH here?
>>>
>> Yes, no mentions for the inverter in ACPI spec, the description about
>> device interrupt type can be found in Loongson chipset manual:
>>
>> https://github.com/loongson/LoongArch-Documentation/blob/main/docs/Loongson-7A1000-usermanual-EN/interrupt-controller/device-interrupt-types.adoc
> 
> That's the kind of reference I was looking for.  The link to HTML is
> convenient in some ways, but since specs evolve over time and URLs are
> ephemeral, I think a citation like "Loongson 7A1000 Bridge User Manual
> v2.00, sec 5.3" is more likely to be useful far in the future.
> 
Ok, good suggestion, thanks.

> Bjorn
> 

