Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2505D7CD837
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 11:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjJRJds (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 05:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjJRJdg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 05:33:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F5119B1;
        Wed, 18 Oct 2023 02:32:35 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S9QWh5LytzCrb2;
        Wed, 18 Oct 2023 17:28:32 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 18 Oct 2023 17:32:31 +0800
CC:     <yangyicong@hisilicon.com>, <hejunhao3@huawei.com>,
        <helgaas@kernel.org>, <linuxarm@huawei.com>,
        <linux-pci@vger.kernel.org>, <alexander.shishkin@linux.intel.com>,
        <prime.zeng@hisilicon.com>
Subject: Re: [PATCH v3 0/5] Several updates for PTT driver
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <linux-kernel@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <jonathan.cameron@huawei.com>
References: <20231010084731.30450-1-yangyicong@huawei.com>
 <169756192530.746517.2466420521869567832.b4-ty@arm.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <90fa7631-51a6-ebc5-f0dc-476caf5cabe5@huawei.com>
Date:   Wed, 18 Oct 2023 17:32:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <169756192530.746517.2466420521869567832.b4-ty@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/10/18 1:01, Suzuki K Poulose wrote:
> On Tue, 10 Oct 2023 16:47:26 +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> This series contains several updates for PTT driver:
>> - Disable interrupt when trace stops, reverse to what we do in trace start
>> - Always handle the interrupt in hardirq context
> 
> I wrapped the commit description to 75 chars for this patch to suppress the
> following checkpatch warning and queued it.

Thanks! Will take care next time.

> 
> WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
> #10:
> change of arm-ccn PMU commit 0811ef7e2f54 ("bus: arm-ccn: fix PMU interrupt flags").
> 
> total: 0 errors, 1 warnings, 12 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
>       "[PATCH] hwtracing: hisi_ptt: Handle the interrupt in hardirq context" has style problems, please review.
> 
> 
>> - Optimize the AUX buffer handling to make consumer have more time to process
>>   the data
>> - Since we're a uncore PMU so block any task attach operation
>> - Add a dummy pmu::read() callback since the perf core may use
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/5] hwtracing: hisi_ptt: Disable interrupt after trace end
>       https://git.kernel.org/coresight/c/4669551e797a
> [2/5] hwtracing: hisi_ptt: Handle the interrupt in hardirq context
>       https://git.kernel.org/coresight/c/e8b7d8718c51
> [3/5] hwtracing: hisi_ptt: Optimize the trace data committing
>       https://git.kernel.org/coresight/c/7a527d4d9273
> [4/5] hwtracing: hisi_ptt: Don't try to attach a task
>       https://git.kernel.org/coresight/c/7d52e2cfef91
> [5/5] hwtracing: hisi_ptt: Add dummy callback pmu::read()
>       https://git.kernel.org/coresight/c/4708eada8bd6
> 
> Best regards,
> 
