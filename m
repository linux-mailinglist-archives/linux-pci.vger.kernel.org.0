Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3227C6E7D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Oct 2023 14:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343962AbjJLMwY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Oct 2023 08:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343909AbjJLMwY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2023 08:52:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69DBBB;
        Thu, 12 Oct 2023 05:52:20 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 85202660733F;
        Thu, 12 Oct 2023 13:52:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697115139;
        bh=IsbNRiCoYuF2r7zCtmm48fin6dOhQrk0w4mVm3Aehb4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EI6xHqdOve9l7tOpeJ5xPvrZznHbT7LdVqIdOabEgiffi5fSiEzMWI2cI843nCn5P
         zqlBgBfW+2257HYlkqzGcEN8L0kbv0Dw95BtRRjMBxbm5Tr++/Io5AoZUX+GiUwhnL
         Hg7tWcbKVnxwcYQ2vh1u5skXmnw9/f/65WRSMARylJnD3R6xWMn+/oUJeH3tQNTs4V
         RYuZ7nzRMgsoU9FPF+pKHNO4tRbVT3M3g8/eA/QpkueQjIBXQn5LhNGHWbX7lpOPOd
         kq6DUrTr9WTsGqD4LhTH+vuIc0YDFAfWlMQN/hxkgrZFsUpZ6DjVNtiuNDh3gkaSnJ
         jT96NXtWo/MVg==
Message-ID: <930f6df4-3267-59df-ad75-244f5b9cee84@collabora.com>
Date:   Thu, 12 Oct 2023 14:52:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] PCI: mediatek-gen3: Fix translation window
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        =?UTF-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>, "robh@kernel.org" <robh@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?SmlleXkgWWFuZyAo5p2o5rSBKQ==?= <Jieyy.Yang@mediatek.com>,
        =?UTF-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= 
        <Chuanjia.Liu@mediatek.com>,
        =?UTF-8?B?SmlhbiBZYW5nICjmnajmiKwp?= <Jian.Yang@mediatek.com>,
        =?UTF-8?B?UWl6aG9uZyBDaGVuZyAo56iL5ZWf5b+gKQ==?= 
        <Qizhong.Cheng@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>
References: <20231011122633.31559-1-jianjun.wang@mediatek.com>
 <899c7275-ccca-43bb-b1ae-a3403dd18622@baylibre.com>
 <088559162e5ec4e2d6d38d8a5707c6e0e12f5ac6.camel@mediatek.com>
 <54ed1269-8699-4531-abc6-09b602adece9@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <54ed1269-8699-4531-abc6-09b602adece9@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 12/10/23 12:27, Alexandre Mergnat ha scritto:
> 
> 
> On 12/10/2023 08:17, Jianjun Wang (王建军) wrote:
>> On Wed, 2023-10-11 at 17:38 +0200, Alexandre Mergnat wrote:
>>> External email : Please do not click links or open attachments until
>>> you have verified the sender or the content.
>>>
>>>
>>> On 11/10/2023 14:26, Jianjun Wang wrote:
>>> > The size of translation table should be a power of 2, using fls()
>>> cannot > get the proper value when the size is not a power of 2. For
>>> example, > fls(0x3e00000) - 1 = 25, hence the PCIe translation window size
>>> will be > set to 0x2000000 instead of the expected size 0x3e00000. Fix
>>> translation > window by splitting the MMIO space to multiple tables if its size
>>> is not > a power of 2.
>>>
>>> Hi Jianjun,
>>>
>>> I've no knowledge in PCIE, so maybe what my suggestion is stupid:
>>>
>>> Is it mandatory to fit the translation table size with 0x3e00000 (in this 
>>> example) ?
>>> I'm asking because you can have an issue by reaching the maximum translation 
>>> table number.
>>>
>>> Is it possible to just use only one table with the power of 2 size
>>> above 0x3e00000 => 0x4000000 ( fls(0x3e00000) = 26 = 0x4000000). The
>>> downside of this method is wasting allocation space. AFAIK I already see this 
>>> kind of method for memory protection/allocation in embedded systems,
>>> so I'm wondering if this method is safer than using multiple table for
>>> only one size which isn't a power of 2.
>>
>> Hi Alexandre,
>>
>> It's not mandatory to fit the translation table size with 0x3e00000,
>> and yes we can use only one table with the power of 2 size to prevent
>> this.
>>
>> For MediaTek's SoCs, the MMIO space range for each PCIe port is fixed,
>> and it will always be a power of 2, most of them will be 64MB. The
>> reason we have the size which isn't a power of 2 is that we reserve an
>> IO space for compatible purpose, some older devices may still use IO
>> space.
>>
>> Take MT8195 as an example, its MMIO size is 64MB, and the declaration
>> in the DT is like:
>> ranges = <0x81000000 0 0x20000000 0x0 0x20000000 0 0x200000>,
>>           <0x82000000 0 0x20200000 0x0 0x20200000 0 0x3e00000>;
>>
>> The MMIO space is splited to 2MB IO space and 62MB MEM space, that's
>> cause the current risk of the MEM space range, its actual available MEM
>> space is 32MB. But it still works for now because most of the devices
>> only require a very small amount of MEM space and will not reach ranges
>> higher than 32MB.
>>
>> So for the concern of reaching the maximum translation table number, I
>> think maybe we can just print the warning message instead of return
>> error code, since it still works but have some limitations(MEM space
>> not set as DT expected).
>>
> 
> Ok understood, thanks for your explanation.
> Then, IMHO, you should use only one table with the power of 2 size above to make 
> the code simpler, efficient, robust, more readable and avoid confusion about the 
> warning.
> 
> This is what is done for pci-mvebu.c AFAII.
> 
> If you prefer waiting another reviewer with a better PCIE expertise than me, it's 
> ok for me. With the information I have currently, I prefer to not approve the 
> current implementation because, from my PoV, it introduce unnecessary complexity.
> 

 From what I understand, using only one table with a size that is a power of two
won't let us use the entire MMIO space, hence the only solution to allow using
the entire range is to split to more than one table.

I'm not sure, though, whether PCIe devices would be able to use a MEM space that
is not power of two, or if those do even exist.

If there are devices that can use 32MB < mem <= 62MB, then I completely agree
with Jianjun on this commit.... so please, can any PCI(/e) maintainer comment
on this situation?

Regards,
Angelo
