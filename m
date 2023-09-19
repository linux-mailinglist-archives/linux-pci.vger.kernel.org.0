Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596917A6954
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 19:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjISRBr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 13:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISRBr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 13:01:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC102AD;
        Tue, 19 Sep 2023 10:01:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 590051FB;
        Tue, 19 Sep 2023 10:02:18 -0700 (PDT)
Received: from [10.57.94.61] (unknown [10.57.94.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8187A3F5A1;
        Tue, 19 Sep 2023 10:01:39 -0700 (PDT)
Message-ID: <3cc013bd-c85e-b28a-f921-d5593b3935a4@arm.com>
Date:   Tue, 19 Sep 2023 18:01:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/5] hwtracing: hisi_ptt: Add dummy callback
 pmu::read()
To:     Yicong Yang <yangyicong@huawei.com>, mathieu.poirier@linaro.org,
        jonathan.cameron@huawei.com, linux-kernel@vger.kernel.org
Cc:     yangyicong@hisilicon.com, alexander.shishkin@linux.intel.com,
        helgaas@kernel.org, linux-pci@vger.kernel.org,
        prime.zeng@hisilicon.com, linuxarm@huawei.com, hejunhao3@huawei.com
References: <20230914112223.27165-1-yangyicong@huawei.com>
 <20230914112223.27165-6-yangyicong@huawei.com>
 <73655f9b-9ea4-cb46-d712-20f1c4ac7c95@arm.com>
 <75b93d15-f099-5d17-caa9-94b0390773cf@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <75b93d15-f099-5d17-caa9-94b0390773cf@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/09/2023 14:03, Yicong Yang wrote:
> On 2023/9/15 20:53, Suzuki K Poulose wrote:
>> On 14/09/2023 12:22, Yicong Yang wrote:
>>> From: Junhao He <hejunhao3@huawei.com>
>>>
>>> When start trace with perf option "-C $cpu" and immediately stop it
>>> with SIGTERM or others, the perf core will invoke pmu::read() while
>>> the driver doesn't implement it. Add a dummy pmu::read() to avoid
>>> any issues.
>>
>> What issues are we talking about here ? Shouldn't the core perf
>> skip the call, if pmu::read() is not available ?
>>
> 
> Actually no, the core doesn't check it. So I think that's why some PMUs
> like SPE implements a dummy pmu::read() callback. Otherwise we'll
> dereference a NULL pointer.
> 
> Currently we only met this on emulated platforms with very slow CPUs,
> follow the instructions in the commit above.

Ok, then it calls for a Fixes tag. Please tag it to the commit that
introduced the PMU.

Suzuki

