Return-Path: <linux-pci+bounces-993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2065B812E84
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 12:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFEE281EC7
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 11:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271443FB2A;
	Thu, 14 Dec 2023 11:27:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDABAA7;
	Thu, 14 Dec 2023 03:27:00 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VyUHCGA_1702553216;
Received: from 30.240.112.122(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VyUHCGA_1702553216)
          by smtp.aliyun-inc.com;
          Thu, 14 Dec 2023 19:26:58 +0800
Message-ID: <e047da91-4a15-4864-bcda-9717170dab7e@linux.alibaba.com>
Date: Thu, 14 Dec 2023 19:26:55 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/5] drivers/perf: add Synopsys DesignWare PCIe PMU
 driver support
Content-Language: en-US
To: Will Deacon <will@kernel.org>, yangyicong@huawei.com,
 Jonathan.Cameron@huawei.com, ilkka@os.amperecomputing.com,
 robin.murphy@arm.com, kaishen@linux.alibaba.com, helgaas@kernel.org,
 baolin.wang@linux.alibaba.com
Cc: catalin.marinas@arm.com, kernel-team@android.com,
 chengyou@linux.alibaba.com, linux-kernel@vger.kernel.org,
 renyu.zj@linux.alibaba.com, zhuo.song@linux.alibaba.com,
 mark.rutland@arm.com, rdunlap@infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
References: <20231208025652.87192-1-xueshuai@linux.alibaba.com>
 <170247454282.4025634.10934949931800191482.b4-ty@kernel.org>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <170247454282.4025634.10934949931800191482.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023/12/14 01:25, Will Deacon wrote:
> On Fri, 8 Dec 2023 10:56:47 +0800, Shuai Xue wrote:
>> Change Log
>> ==========
>> change sinces v11:
>> - Fix uninitialized symbol 'now' (Per Dan and Will)
>> - Pick up Reviewed-and-tested-by tag from Ilkka for Patch 4/5
>>
>> change sinces v10:
>> - Rename to pci_clear_and_set_config_dword() to retain the "config"
>>   information and match the other accessors. (Per Bjorn)
>> - Align pci_clear_and_set_config_dword() and its call site (Per Bjorn)
>> - Polish commit log (Per Bjorn)
>> - Simplify dwc_pcie_pmu_time_based_event_enable() with bool value (Per Ilkka)
>> - Fix dwc_pcie_register_dev() return value (Per Ilkka)
>> - Fix vesc capability discovery by pdev->vendor (Per Ilkka)
>> - pick up Acked-by tag from Bjorn for Patch 3/5
>> - pick up Tested-by tag from Ilkka for all patch set
>>
>> [...]
> 
> Applied to will (for-next/perf), thanks!
> 
> [1/5] docs: perf: Add description for Synopsys DesignWare PCIe PMU driver
>       https://git.kernel.org/will/c/cae40614cdd6
> [2/5] PCI: Add Alibaba Vendor ID to linux/pci_ids.h
>       https://git.kernel.org/will/c/ad6534c626fe
> [3/5] PCI: Move pci_clear_and_set_dword() helper to PCI header
>       https://git.kernel.org/will/c/ac16087134b8
> [4/5] drivers/perf: add DesignWare PCIe PMU driver
>       https://git.kernel.org/will/c/af9597adc2f1
> [5/5] MAINTAINERS: add maintainers for DesignWare PCIe PMU driver
>       https://git.kernel.org/will/c/f56bb3de66bc
> 
> Cheers,

Really a good news for me. Thank you very much:)

And thanks to all patient and nice reviewers.

Cheers,
Shuai

