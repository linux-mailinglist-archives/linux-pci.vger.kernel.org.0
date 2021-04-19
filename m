Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D39364407
	for <lists+linux-pci@lfdr.de>; Mon, 19 Apr 2021 15:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242066AbhDSNZQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 09:25:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17796 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241261AbhDSNWV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Apr 2021 09:22:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FP6q30PrFz7vwY;
        Mon, 19 Apr 2021 21:19:27 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Mon, 19 Apr 2021
 21:21:38 +0800
Subject: Re: [PATCH RESEND 0/4] Add support for HiSilicon PCIe Tune and Trace
 device
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <gregkh@linuxfoundation.org>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, <jonathan.cameron@huawei.com>,
        <song.bao.hua@hisilicon.com>, <john.garry@huawei.com>,
        <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>
References: <1618654631-42454-1-git-send-email-yangyicong@hisilicon.com>
 <529defac-cd67-3a7b-91d3-76eb0bb9dc6c@arm.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <fb4e70d9-e5c8-1cbf-ca21-adb701089fe0@hisilicon.com>
Date:   Mon, 19 Apr 2021 21:21:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <529defac-cd67-3a7b-91d3-76eb0bb9dc6c@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/4/19 19:17, Suzuki K Poulose wrote:
> On 17/04/2021 11:17, Yicong Yang wrote:
>> [RESEND with perf and coresight folks Cc'ed]
>>
>> HiSilicon PCIe tune and trace device (PTT) is a PCIe Root Complex
>> integrated Endpoint (RCiEP) device, providing the capability
>> to dynamically monitor and tune the PCIe traffic (tune),
>> and trace the TLP headers (trace).
>>
>> PTT tune is designed for monitoring and adjusting PCIe link parameters.
>> We provide several parameters of the PCIe link. Through the driver,
>> user can adjust the value of certain parameter to affect the PCIe link
>> for the purpose of enhancing the performance in certian situation.
> 
> ...
> 
>>
>> The reason for not using perf is because there is no current support
>> for uncore tracing in the perf facilities. We have our own format
>> of data and don't need perf doing the parsing. The setting through
>> perf tools doesn't seem to be friendly as well. For example,
>> we cannot count on perf to decode the usual format BDF number like
>> <domain>:<bus>:<dev>.<fn>, which user can use to filter the TLP
>> headers through the PTT device.
>>
>> A similar approach for implementing this function is ETM, which use
>> sysfs for configuring and a character device for dumping data.
>>
>> Greg has some comments on our implementation and doesn't advocate
>> to build driver on debugfs [1]. So I resend this series to
>> collect more feedbacks on the implementation of this driver.
>>
>> Hi perf and ETM related experts, is it suggested to adapt this driver
>> to perf? Or is the debugfs approach acceptable? Otherwise use
>> sysfs + character device like ETM and use perf tools for decoding it?
>> Any comments is welcomed.
> 
> Please use perf. Debugfs / sysfs is not the right place for these things.
> 

ok.

> Also, please move your driver to drivers/perf/
> 

Does it make sense as it's a tuning and tracing device, and doesn't have counters
nor do the sampling like usual PMU device under drivers/perf/.

> As Alex mentioned, the ETM drivers were initially developed when the AUX
> buffer was not available. The sysfs interface is there only for the backward compatibility and for bring up ( due to the nature of the
> connections between the CoreSight components and sometimes the missing engineering spec).
> 

got it. thanks for the explanation.

Regards,
Yicong

> Suzuki
> 
> .

