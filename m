Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB9E63BEAB
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 12:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiK2LK4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 06:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiK2LKy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 06:10:54 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE90BBA;
        Tue, 29 Nov 2022 03:10:50 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NM00707Q0zqSjv;
        Tue, 29 Nov 2022 19:06:47 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 19:10:48 +0800
CC:     <yangyicong@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@huawei.com>, <f.fangjian@huawei.com>,
        <prime.zeng@huawei.com>, <shenyang39@huawei.com>,
        <liuqi6124@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        <bagasdotme@gmail.com>, <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v3 0/4] Add TLP filter support and some fixes for
 HiSilicon PCIe PMU
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
References: <20221117084136.53572-1-yangyicong@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <b08447e8-9d2c-3855-97cb-b10e3e080e42@huawei.com>
Date:   Tue, 29 Nov 2022 19:10:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20221117084136.53572-1-yangyicong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

a gentle ping for this...

On 2022/11/17 16:41, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> HiSilicon PCIe PMU support count the bandwidth of TLP headers, TLP payloads
> or both. Add support for it. User can set this through perf tool's
> 'len_mode' like:
> 
>   $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,len_mode=0x1/ sleep 5
> 
> Also includes fixes and improvement of both driver and documentation in this
> series.
> 
> Change since v2:
> - Take Patch 3 advance in the series and drop the fix tag, Per Jonathan
> - Add tags from Jonathan for Patch 3-4, Thanks.
> Link: https://lore.kernel.org/lkml/20221110085109.45227-2-yangyicong@huawei.com/
> 
> Change since v1:
> - Refine the documentation per Jonathan and Bagas
> - Collect tags from Jonathan. Thanks.
> Link: https://lore.kernel.org/lkml/20221025113242.58271-1-yangyicong@huawei.com/
> 
> Bagas Sanjaya (1):
>   Documentation: perf: Indent filter options list of hisi-pcie-pmu
> 
> Yicong Yang (3):
>   drivers/perf: hisi: Fix some event id for hisi-pcie-pmu
>   docs: perf: Fix PMU instance name of hisi-pcie-pmu
>   drivers/perf: hisi: Add TLP filter support
> 
>  .../admin-guide/perf/hisi-pcie-pmu.rst        | 112 +++++++++++-------
>  drivers/perf/hisilicon/hisi_pcie_pmu.c        |  22 +++-
>  2 files changed, 85 insertions(+), 49 deletions(-)
> 
