Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777CF4F7A01
	for <lists+linux-pci@lfdr.de>; Thu,  7 Apr 2022 10:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243200AbiDGIom (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Apr 2022 04:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240566AbiDGIom (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2022 04:44:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E3846143;
        Thu,  7 Apr 2022 01:42:40 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KYvwh6pJ9zgYQL;
        Thu,  7 Apr 2022 16:40:52 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 16:42:35 +0800
CC:     <kbuild-all@lists.01.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH v6 4/7] hisi_ptt: Add tune function support for HiSilicon
 PCIe Tune and Trace device
To:     kernel test robot <lkp@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <daniel.thompson@linaro.org>,
        <joro@8bytes.org>, <john.garry@huawei.com>,
        <shameerali.kolothum.thodi@huawei.com>, <robin.murphy@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>
References: <20220406071730.41031-5-yangyicong@hisilicon.com>
 <202204071201.AcePULOR-lkp@intel.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <73483350-8df9-967f-ba35-d910aa39b635@huawei.com>
Date:   Thu, 7 Apr 2022 16:42:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <202204071201.AcePULOR-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/4/7 12:28, kernel test robot wrote:
> Hi Yicong,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on joro-iommu/next]
> [also build test WARNING on linus/master linux/master v5.18-rc1 next-20220406]
> [cannot apply to tip/perf/core]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yicong-Yang/Add-support-for-HiSilicon-PCIe-Tune-and-Trace-device/20220406-200044
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220407/202204071201.AcePULOR-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/9400668b70cbcd5ec74a52f043c3a333b80135f8
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Yicong-Yang/Add-support-for-HiSilicon-PCIe-Tune-and-Trace-device/20220406-200044
>         git checkout 9400668b70cbcd5ec74a52f043c3a333b80135f8
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/hwtracing/ptt/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/hwtracing/ptt/hisi_ptt.c: In function 'hisi_ptt_tune_data_get':
>>> drivers/hwtracing/ptt/hisi_ptt.c:46:16: warning: conversion from 'long unsigned int' to 'u32' {aka 'unsigned int'} changes value from '18446744073709551615' to '4294967295' [-Woverflow]
>       46 |         writel(~0UL, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
>          |                ^~~~

Thanks for the report. using of ~0U will fix this.

>    drivers/hwtracing/ptt/hisi_ptt.c: At top level:
>    drivers/hwtracing/ptt/hisi_ptt.c:1131:6: warning: no previous prototype for 'hisi_ptt_remove' [-Wmissing-prototypes]
>     1131 | void hisi_ptt_remove(struct pci_dev *pdev)
>          |      ^~~~~~~~~~~~~~~
> 

for here I missed the static identifier. will fix. thanks.

> 
> vim +46 drivers/hwtracing/ptt/hisi_ptt.c
> 
>     33	
>     34	static int hisi_ptt_tune_data_get(struct hisi_ptt *hisi_ptt,
>     35					  u32 event, u16 *data)
>     36	{
>     37		u32 reg;
>     38	
>     39		reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
>     40		reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
>     41		reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
>     42				  event);
>     43		writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
>     44	
>     45		/* Write all 1 to indicates it's the read process */
>   > 46		writel(~0UL, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
>     47	
>     48		if (!hisi_ptt_wait_tuning_finish(hisi_ptt))
>     49			return -ETIMEDOUT;
>     50	
>     51		reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
>     52		reg &= HISI_PTT_TUNING_DATA_VAL_MASK;
>     53		*data = FIELD_GET(HISI_PTT_TUNING_DATA_VAL_MASK, reg);
>     54	
>     55		return 0;
>     56	}
>     57	
> 
