Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD4E7CC30D
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 14:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343752AbjJQMYM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 08:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343954AbjJQMYD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 08:24:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4CF213A;
        Tue, 17 Oct 2023 05:21:19 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S8tJ01hxfzvQDd;
        Tue, 17 Oct 2023 20:16:32 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 17 Oct 2023 20:21:15 +0800
CC:     <mathieu.poirier@linaro.org>, <jonathan.cameron@huawei.com>,
        <linux-kernel@vger.kernel.org>, <yangyicong@hisilicon.com>,
        <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <hejunhao3@huawei.com>
Subject: Re: [PATCH v3 0/5] Several updates for PTT driver
To:     <suzuki.poulose@arm.com>
References: <20231010084731.30450-1-yangyicong@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <fc5ef77c-f4c6-adac-38ab-37e1a23270ef@huawei.com>
Date:   Tue, 17 Oct 2023 20:21:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20231010084731.30450-1-yangyicong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Hi Suzuki,

a gentle ping..

Hope all previous comments are addressed/clarified. Any further comment on this?

Thanks.

On 2023/10/10 16:47, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> This series contains several updates for PTT driver:
> - Disable interrupt when trace stops, reverse to what we do in trace start
> - Always handle the interrupt in hardirq context
> - Optimize the AUX buffer handling to make consumer have more time to process
>   the data
> - Since we're a uncore PMU so block any task attach operation
> - Add a dummy pmu::read() callback since the perf core may use
> 
> Change since v2:
> - Add fix tag for Patch 5/5
> - refine the commit in Patch 3/5, trying to make it more clear
> Link: https://lore.kernel.org/all/20230914112223.27165-1-yangyicong@huawei.com/
> 
> Change since v1:
> - Add Jonathan's tag, thanks
> Link: https://lore.kernel.org/all/20230809081825.11518-1-yangyicong@huawei.com/
> 
> Junhao He (1):
>   hwtracing: hisi_ptt: Add dummy callback pmu::read()
> 
> Yicong Yang (4):
>   hwtracing: hisi_ptt: Disable interrupt after trace end
>   hwtracing: hisi_ptt: Handle the interrupt in hardirq context
>   hwtracing: hisi_ptt: Optimize the trace data committing
>   hwtracing: hisi_ptt: Don't try to attach a task
> 
>  drivers/hwtracing/ptt/hisi_ptt.c | 33 +++++++++++++++++++++-----------
>  drivers/hwtracing/ptt/hisi_ptt.h |  1 +
>  2 files changed, 23 insertions(+), 11 deletions(-)
> 
