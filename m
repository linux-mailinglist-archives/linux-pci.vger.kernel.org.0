Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B815EC34A
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 14:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiI0Mto (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 08:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiI0Mtj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 08:49:39 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C916958B;
        Tue, 27 Sep 2022 05:49:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VQs4TXf_1664282967;
Received: from 30.240.121.51(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VQs4TXf_1664282967)
          by smtp.aliyun-inc.com;
          Tue, 27 Sep 2022 20:49:28 +0800
Message-ID: <2085a695-7fa2-b560-3164-c62cb17dd5f7@linux.alibaba.com>
Date:   Tue, 27 Sep 2022 20:49:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v1 2/3] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        linux-pci@vger.kernel.org
References: <20220926171857.GA1609097@bhelgaas>
 <7502d496-9ec1-1ca4-c643-376ec2aa662e@linux.alibaba.com>
 <20220927110435.00005b4d@huawei.com>
 <5372edb4-5717-42a0-142e-91657a9b18c3@arm.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <5372edb4-5717-42a0-142e-91657a9b18c3@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


+ Jonathan

在 2022/9/27 PM6:14, Robin Murphy 写道:
> On 2022-09-27 11:04, Jonathan Cameron wrote:
>> On Tue, 27 Sep 2022 13:13:29 +0800
>> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>
>>> 在 2022/9/27 AM1:18, Bjorn Helgaas 写道:
>>>> On Mon, Sep 26, 2022 at 09:31:34PM +0800, Shuai Xue wrote:
>>>>> 在 2022/9/23 PM11:54, Jonathan Cameron 写道:
>>>>>>> I found a similar definition in arch/ia64/pci/pci.c .
>>>>>>>
>>>>>>>     #define PCI_SAL_ADDRESS(seg, bus, devfn, reg)        \
>>>>>>>     (((u64) seg << 24) | (bus << 16) | (devfn << 8) | (reg))
>>>>>>>
>>>>>>> Should we move it into a common header first?
>>>>>>
>>>>>> Maybe. The bus, devfn, reg part is standard bdf, but I don't think
>>>>>> the PCI 6.0 spec defined a version with the seg in the upper bits.
>>>>>> I'm not sure if we want to adopt that in LInux.
>>>>>
>>>>> I found lots of code use seg,bus,devfn,reg with format "%04x:%02x:%02x.%x",
>>>>> I am not quite familiar with PCIe spec. What do you think about it, Bjorn?
>>>>
>>>> The PCIe spec defines an address encoding for bus/device/function/reg
>>>> for the purposes of ECAM (PCIe r6.0, sec 7.2.2), but as far as I know,
>>>> it doesn't define anything similar that includes the segment.  The
>>>> segment is really outside the scope of PCIe because each segment is a
>>>> completely separate PCIe hierarchy.
>>>
>>> Thank you for your explanation.
>>>
>>>>
>>>> So I probably wouldn't make this a generic definition.  But if/when
>>>> you print things like this out, please do use the format spec you
>>>> mentioned above so it matches the style used elsewhere.
>>>>    
>>>
>>> Agree. The print format of bus/device/function/reg is "%04x:%02x:%02x.%x",
>>> so I named the PMU as the same format. Then the usage flow would be:
>>>
>>> - lspci to get the device root port in format seg/bus/device/function/reg.
>>>     10:00.0 PCI bridge: Device 1ded:8000 (rev 01)
>>> - select its PMU name pcie_bdf_100000.
>>> - monitor with perf:
>>>     perf stat -a -e pcie_bdf_100000/Rx_PCIe_TLP_Data_Payload/
>>
>> I think you probably want something in there to indicate it's an RP
>> and the bdf part may be redundant...
> 
> Indeed that seems horribly unclear; personally I reckon something like "dw_pcie_200" would be more appropriate. The address is just a disambiguator between multiple instances so doesn't need any further emphasis, but what is crucial to the user is exactly what kind of PMU it is (especially if there's potential for other unrelated PCIe functions to start exposing their own different PMUs).

I see your point. The current prefix `pcie_bdf` is not appropriate,

- it does not indicate it is for a root point as Jonathan mentioned.
- its prefix is not `dwc`

Is dwc_rootport_100000 more appropriate?

- `dwc` indicates the PMU is for Synopsys DesignWare Cores PCIe controller IP
- `rootport` indicates the PMU is for a root port device
- `100000` indicates the device address


Thank you.

Best Regards,
Shuai



