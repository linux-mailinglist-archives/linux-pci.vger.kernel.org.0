Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF9A5EBF84
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 12:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiI0KPg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 06:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiI0KPO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 06:15:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E638CFCA5A;
        Tue, 27 Sep 2022 03:14:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8068A1042;
        Tue, 27 Sep 2022 03:14:20 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B9BF3F73B;
        Tue, 27 Sep 2022 03:14:12 -0700 (PDT)
Message-ID: <5372edb4-5717-42a0-142e-91657a9b18c3@arm.com>
Date:   Tue, 27 Sep 2022 11:14:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 2/3] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-GB
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        linux-pci@vger.kernel.org
References: <20220926171857.GA1609097@bhelgaas>
 <7502d496-9ec1-1ca4-c643-376ec2aa662e@linux.alibaba.com>
 <20220927110435.00005b4d@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220927110435.00005b4d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-09-27 11:04, Jonathan Cameron wrote:
> On Tue, 27 Sep 2022 13:13:29 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> 在 2022/9/27 AM1:18, Bjorn Helgaas 写道:
>>> On Mon, Sep 26, 2022 at 09:31:34PM +0800, Shuai Xue wrote:
>>>> 在 2022/9/23 PM11:54, Jonathan Cameron 写道:
>>>>>> I found a similar definition in arch/ia64/pci/pci.c .
>>>>>>
>>>>>> 	#define PCI_SAL_ADDRESS(seg, bus, devfn, reg)		\
>>>>>> 	(((u64) seg << 24) | (bus << 16) | (devfn << 8) | (reg))
>>>>>>
>>>>>> Should we move it into a common header first?
>>>>>
>>>>> Maybe. The bus, devfn, reg part is standard bdf, but I don't think
>>>>> the PCI 6.0 spec defined a version with the seg in the upper bits.
>>>>> I'm not sure if we want to adopt that in LInux.
>>>>
>>>> I found lots of code use seg,bus,devfn,reg with format "%04x:%02x:%02x.%x",
>>>> I am not quite familiar with PCIe spec. What do you think about it, Bjorn?
>>>
>>> The PCIe spec defines an address encoding for bus/device/function/reg
>>> for the purposes of ECAM (PCIe r6.0, sec 7.2.2), but as far as I know,
>>> it doesn't define anything similar that includes the segment.  The
>>> segment is really outside the scope of PCIe because each segment is a
>>> completely separate PCIe hierarchy.
>>
>> Thank you for your explanation.
>>
>>>
>>> So I probably wouldn't make this a generic definition.  But if/when
>>> you print things like this out, please do use the format spec you
>>> mentioned above so it matches the style used elsewhere.
>>>    
>>
>> Agree. The print format of bus/device/function/reg is "%04x:%02x:%02x.%x",
>> so I named the PMU as the same format. Then the usage flow would be:
>>
>> - lspci to get the device root port in format seg/bus/device/function/reg.
>> 	10:00.0 PCI bridge: Device 1ded:8000 (rev 01)
>> - select its PMU name pcie_bdf_100000.
>> - monitor with perf:
>> 	perf stat -a -e pcie_bdf_200/Rx_PCIe_TLP_Data_Payload/
> 
> I think you probably want something in there to indicate it's an RP
> and the bdf part may be redundant...

Indeed that seems horribly unclear; personally I reckon something like 
"dw_pcie_200" would be more appropriate. The address is just a 
disambiguator between multiple instances so doesn't need any further 
emphasis, but what is crucial to the user is exactly what kind of PMU it 
is (especially if there's potential for other unrelated PCIe functions 
to start exposing their own different PMUs).

Thanks,
Robin.
