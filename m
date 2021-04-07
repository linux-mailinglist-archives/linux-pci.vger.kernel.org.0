Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15C03568BC
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 12:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350573AbhDGKEC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 06:04:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16379 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350489AbhDGKD3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Apr 2021 06:03:29 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FFg0C2Z4ZzjYZn;
        Wed,  7 Apr 2021 18:01:31 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 18:03:11 +0800
Subject: Re: [PATCH 0/4] Add support for HiSilicon PCIe Tune and Trace device
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <lorenzo.pieralisi@arm.com>, <jonathan.cameron@huawei.com>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@huawei.com>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
        "liuqi (BA)" <liuqi115@huawei.com>
References: <1617713154-35533-1-git-send-email-yangyicong@hisilicon.com>
 <YGxm49c9cT69NV5Q@kroah.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <01b6e8f7-3282-514e-818d-0e768dcc5ba3@hisilicon.com>
Date:   Wed, 7 Apr 2021 18:03:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YGxm49c9cT69NV5Q@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/4/6 21:49, Greg KH wrote:
> On Tue, Apr 06, 2021 at 08:45:50PM +0800, Yicong Yang wrote:
>> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex
>> integrated Endpoint(RCiEP) device, providing the capability
>> to dynamically monitor and tune the PCIe traffic(tune),
>> and trace the TLP headers(trace). The driver exposes the user
>> interface through debugfs, so no need for extra user space tools.
>> The usage is described in the document.
> 
> Why use debugfs and not the existing perf tools for debugging?
> 

The perf doesn't match our device as we've analyzed.

For the tune function it doesn't do the sampling at all.
User specifys one link parameter and reads its current value or set
the desired one. The process is static. We didn't find a
way to adapt to perf.

For the trace function, we may barely adapt to the perf framework
but it doesn't seems like a better choice. We have our own format
of data and don't need perf doing the parsing, and we'll get extra
information added by perf as well. The settings through perf tools
won't satisfy our needs, we cannot present available settings
(filter BDF number, TLP types, buffer controls) to
the user and user cannot set in a friendly way. For example,
we cannot count on perf to decode the usual format BDF number like
<domain>:<bus>:<dev>.<fn>, which user can use filter the TLP
headers.

So we intended to make the operation of this driver a bit like
ftrace. user sets the control settings through control files
and get the result through files as well. No additional tools
is necessay. A user space tool is necessary if we use a character
device or misc device for implementing this. The trace data maybe
hundreds of megabytes, and debugfs file can just satisfy it.

Thanks,
Yicong

