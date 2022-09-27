Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4775EBA4C
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 08:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiI0GBc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 02:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiI0GBb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 02:01:31 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8059A8962;
        Mon, 26 Sep 2022 23:01:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VQqLV.E_1664258485;
Received: from 30.240.86.142(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VQqLV.E_1664258485)
          by smtp.aliyun-inc.com;
          Tue, 27 Sep 2022 14:01:26 +0800
Message-ID: <63037753-af65-6229-95e9-72eb310069d7@linux.alibaba.com>
Date:   Tue, 27 Sep 2022 14:01:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v1 2/3] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     will@kernel.org, Jonathan.Cameron@Huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, robin.murphy@arm.com, mark.rutland@arm.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        linux-pci@vger.kernel.org
References: <20220923185141.GA1407035@bhelgaas>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20220923185141.GA1407035@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2022/9/24 AM2:51, Bjorn Helgaas 写道:
> On Fri, Sep 23, 2022 at 10:46:09PM +0800, Shuai Xue wrote:
>> 在 2022/9/23 AM1:36, Bjorn Helgaas 写道:
>>> On Sat, Sep 17, 2022 at 08:10:35PM +0800, Shuai Xue wrote:
> 
>>>> +static struct device_attribute dwc_pcie_pmu_cpumask_attr =
>>>> +__ATTR(cpumask, 0444, dwc_pcie_pmu_cpumask_show, NULL);
>>>
>>> DEVICE_ATTR_RO()?
> 
>> DEVICE_ATTR_RO may a good choice. But does it fit the code style to use
>> DEVICE_ATTR_RO in drivers/perf? As far as know, CCN, CCI, SMMU,
>> qcom_l2_pmu use "struct device_attribute" directly.
> 
> DEVICE_ATTR_RO is just newer, and I think CCN, CCI, SMMU, etc. would
> be using it if they were written today.  Of course, the drivers/perf
> maintainers may have a different opinion :)

Well, you are right, I will use DEVICE_ATTR_RO instead :)

> 
>>> I think every caller of dwc_pcie_pmu_read_dword() makes the same check
>>> and prints the same message; maybe the message should be moved inside
>>> dwc_pcie_pmu_read_dword()?
>>>
>>> Same with dwc_pcie_pmu_write_dword(); moving the message there would
>>> simplify all callers.
>>
>> I would like to wrap dwc_pcie_pmu_{write}_dword out, use
>> pci_{read}_config_dword and drop the snaity check of return value as
>> Jonathan suggests.  How did you like it?
> 
> Sounds good.  Not sure the error checking is worthwhile since
> pci_read_config_dword() really doesn't return meaningful errors
> anyway.
> 
>>>> +static struct dwc_pcie_info_table *pmu_to_pcie_info(struct pmu *pmu)
>>>> +{
>>>> +	struct dwc_pcie_info_table *pcie_info;
>>>> +	struct dwc_pcie_pmu *pcie_pmu = to_pcie_pmu(pmu);
>>>> +
>>>> +	pcie_info = container_of(pcie_pmu, struct dwc_pcie_info_table, pcie_pmu);
>>>> +	if (pcie_info == NULL)
>>>> +		pci_err(pcie_info->pdev, "Can't get pcie info\n");
>>>
>>> It shouldn't be possible to get here for a pmu with no pcie_info, and
>>> callers don't check for a NULL pointer return value before
>>> dereferencing it, so I guess all this adds is an error message before
>>> a NULL pointer oops?  Not sure the code clutter is worth it.
>>
>> Do you mean to drop the snaity check of container_of?
> 
> Yes.  I'm suggesting that the NULL pointer oops itself has enough
> information to debug this problem, even without the pci_err().

I will drop the snaity check in next version.


Thank you for you valuable comments.

Best Regards,
Shuai
