Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0BF5EB974
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 07:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiI0FNj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 01:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiI0FNi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 01:13:38 -0400
Received: from out199-14.us.a.mail.aliyun.com (out199-14.us.a.mail.aliyun.com [47.90.199.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2EE88DF2;
        Mon, 26 Sep 2022 22:13:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VQqIJYE_1664255610;
Received: from 30.240.121.51(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VQqIJYE_1664255610)
          by smtp.aliyun-inc.com;
          Tue, 27 Sep 2022 13:13:32 +0800
Message-ID: <7502d496-9ec1-1ca4-c643-376ec2aa662e@linux.alibaba.com>
Date:   Tue, 27 Sep 2022 13:13:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v1 2/3] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        robin.murphy@arm.com, mark.rutland@arm.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        linux-pci@vger.kernel.org
References: <20220926171857.GA1609097@bhelgaas>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20220926171857.GA1609097@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2022/9/27 AM1:18, Bjorn Helgaas 写道:
> On Mon, Sep 26, 2022 at 09:31:34PM +0800, Shuai Xue wrote:
>> 在 2022/9/23 PM11:54, Jonathan Cameron 写道:
>>>> I found a similar definition in arch/ia64/pci/pci.c .
>>>>
>>>> 	#define PCI_SAL_ADDRESS(seg, bus, devfn, reg)		\
>>>> 	(((u64) seg << 24) | (bus << 16) | (devfn << 8) | (reg))
>>>>
>>>> Should we move it into a common header first?
>>>
>>> Maybe. The bus, devfn, reg part is standard bdf, but I don't think
>>> the PCI 6.0 spec defined a version with the seg in the upper bits.
>>> I'm not sure if we want to adopt that in LInux.
>>
>> I found lots of code use seg,bus,devfn,reg with format "%04x:%02x:%02x.%x",
>> I am not quite familiar with PCIe spec. What do you think about it, Bjorn?
> 
> The PCIe spec defines an address encoding for bus/device/function/reg
> for the purposes of ECAM (PCIe r6.0, sec 7.2.2), but as far as I know,
> it doesn't define anything similar that includes the segment.  The
> segment is really outside the scope of PCIe because each segment is a
> completely separate PCIe hierarchy.

Thank you for your explanation.

> 
> So I probably wouldn't make this a generic definition.  But if/when
> you print things like this out, please do use the format spec you
> mentioned above so it matches the style used elsewhere.
> 

Agree. The print format of bus/device/function/reg is "%04x:%02x:%02x.%x",
so I named the PMU as the same format. Then the usage flow would be:

- lspci to get the device root port in format seg/bus/device/function/reg.
	10:00.0 PCI bridge: Device 1ded:8000 (rev 01)
- select its PMU name pcie_bdf_100000.
- monitor with perf:
	perf stat -a -e pcie_bdf_200/Rx_PCIe_TLP_Data_Payload/

Bjorn and Jonathan, are you happy with this flow?

Thank you.

Best Regards,
Shuai
