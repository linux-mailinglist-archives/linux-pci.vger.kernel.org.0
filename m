Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A8C6277D0
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 09:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiKNIfE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 03:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiKNIfD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 03:35:03 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18746B20;
        Mon, 14 Nov 2022 00:35:01 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8AxSti1_XFjdtgGAA--.18915S3;
        Mon, 14 Nov 2022 16:35:01 +0800 (CST)
Received: from [10.20.42.77] (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxFle0_XFj3m4SAA--.31378S3;
        Mon, 14 Nov 2022 16:35:00 +0800 (CST)
Subject: Re: [PATCH V5] PCI: loongson: Skip scanning unavailable child devices
To:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        wanghongliang <wanghongliang@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221114074346.23008-1-liupeibao@loongson.cn>
 <3eb09d86.900e.1847534872f.Coremail.chenhuacai@loongson.cn>
From:   Liu Peibao <liupeibao@loongson.cn>
Message-ID: <091d18b8-fe7c-bdeb-351c-85607c82a9d6@loongson.cn>
Date:   Mon, 14 Nov 2022 16:35:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3eb09d86.900e.1847534872f.Coremail.chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxFle0_XFj3m4SAA--.31378S3
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQAKCmNw3mQO9QAAsT
X-Coremail-Antispam: 1Uk129KBjvJXoW7uFyxWF43ur4DJryUWF47CFg_yoW8JFy3p3
        4ay3Wqkr1UCryUGws5Wry7CFy3X398G3s3JFWDKa4vk34DZwn8Xas5uF4jkrWqvFWFqa4j
        9r4UurnYgayUt3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07jFa0PUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/14/22 4:14 PM, 陈华才 wrote:
> Hi, Peibao,
> 
> 
>> -----原始邮件-----
>> 发件人: "Liu Peibao" <liupeibao@loongson.cn>
>> 发送时间:2022-11-14 15:43:46 (星期一)
>> 收件人: "Bjorn Helgaas" <bhelgaas@google.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, "Krzysztof Wilczyński" <kw@linux.com>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>, "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
>> 抄送: "Huacai Chen" <chenhuacai@loongson.cn>, "Jianmin Lv" <lvjianmin@loongson.cn>, "Yinbo Zhu" <zhuyinbo@loongson.cn>, wanghongliang <wanghongliang@loongson.cn>, "Liu Peibao" <liupeibao@loongson.cn>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
>> 主题: [PATCH V5] PCI: loongson: Skip scanning unavailable child devices
>>
>> The PCI Controller of 2K1000 could not mask devices by setting vender ID or
> I think this patch is needed by both LS2K500 and LS2K1000, so replace 2K1000 with "LS2K" or "Loongson-2K" or "LS2K500/LS2K1000" maybe better. If new version is needed, please change this, thanks.
> 

LS2K500 does not need this as there are no on chip PCI devices.

BR,
Peibao

