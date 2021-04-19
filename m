Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489AF36404B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Apr 2021 13:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbhDSLSQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 07:18:16 -0400
Received: from foss.arm.com ([217.140.110.172]:40792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233486AbhDSLSQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Apr 2021 07:18:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 431B031B;
        Mon, 19 Apr 2021 04:17:46 -0700 (PDT)
Received: from [10.57.66.181] (unknown [10.57.66.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C2623F792;
        Mon, 19 Apr 2021 04:17:43 -0700 (PDT)
Subject: Re: [PATCH RESEND 0/4] Add support for HiSilicon PCIe Tune and Trace
 device
To:     Yicong Yang <yangyicong@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-pci@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, helgaas@kernel.org,
        gregkh@linuxfoundation.org, lorenzo.pieralisi@arm.com,
        will@kernel.org, mark.rutland@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.cameron@huawei.com, song.bao.hua@hisilicon.com,
        john.garry@huawei.com, prime.zeng@huawei.com, liuqi115@huawei.com,
        zhangshaokun@hisilicon.com, linuxarm@huawei.com
References: <1618654631-42454-1-git-send-email-yangyicong@hisilicon.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <529defac-cd67-3a7b-91d3-76eb0bb9dc6c@arm.com>
Date:   Mon, 19 Apr 2021 12:17:41 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1618654631-42454-1-git-send-email-yangyicong@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17/04/2021 11:17, Yicong Yang wrote:
> [RESEND with perf and coresight folks Cc'ed]
> 
> HiSilicon PCIe tune and trace device (PTT) is a PCIe Root Complex
> integrated Endpoint (RCiEP) device, providing the capability
> to dynamically monitor and tune the PCIe traffic (tune),
> and trace the TLP headers (trace).
> 
> PTT tune is designed for monitoring and adjusting PCIe link parameters.
> We provide several parameters of the PCIe link. Through the driver,
> user can adjust the value of certain parameter to affect the PCIe link
> for the purpose of enhancing the performance in certian situation.

...

> 
> The reason for not using perf is because there is no current support
> for uncore tracing in the perf facilities. We have our own format
> of data and don't need perf doing the parsing. The setting through
> perf tools doesn't seem to be friendly as well. For example,
> we cannot count on perf to decode the usual format BDF number like
> <domain>:<bus>:<dev>.<fn>, which user can use to filter the TLP
> headers through the PTT device.
> 
> A similar approach for implementing this function is ETM, which use
> sysfs for configuring and a character device for dumping data.
> 
> Greg has some comments on our implementation and doesn't advocate
> to build driver on debugfs [1]. So I resend this series to
> collect more feedbacks on the implementation of this driver.
> 
> Hi perf and ETM related experts, is it suggested to adapt this driver
> to perf? Or is the debugfs approach acceptable? Otherwise use
> sysfs + character device like ETM and use perf tools for decoding it?
> Any comments is welcomed.

Please use perf. Debugfs / sysfs is not the right place for these things.

Also, please move your driver to drivers/perf/

As Alex mentioned, the ETM drivers were initially developed when the AUX
buffer was not available. The sysfs interface is there only for the 
backward compatibility and for bring up ( due to the nature of the
connections between the CoreSight components and sometimes the missing 
engineering spec).

Suzuki
