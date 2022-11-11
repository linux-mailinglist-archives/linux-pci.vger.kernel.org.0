Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298E66258F0
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 11:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiKKK7G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 05:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiKKK7G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 05:59:06 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D0F13F0F;
        Fri, 11 Nov 2022 02:59:03 -0800 (PST)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N7wcz3Dycz689lb;
        Fri, 11 Nov 2022 18:56:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 11:59:00 +0100
Received: from localhost (10.45.151.252) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 10:58:59 +0000
Date:   Fri, 11 Nov 2022 10:58:56 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>, <liuqi6124@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>, <bagasdotme@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@huawei.com>, <f.fangjian@huawei.com>,
        <prime.zeng@huawei.com>, <shenyang39@huawei.com>
Subject: Re: [PATCH v2 3/4] drivers/perf: hisi: Add TLP filter support
Message-ID: <20221111105856.000047c7@Huawei.com>
In-Reply-To: <20221110085109.45227-4-yangyicong@huawei.com>
References: <20221110085109.45227-1-yangyicong@huawei.com>
        <20221110085109.45227-4-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.151.252]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 10 Nov 2022 16:51:08 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The PMU support to filter the TLP when counting the bandwidth with below
> options:
> 
> - only count the TLP headers
> - only count the TLP payloads
> - count both TLP headers and payloads
> 
> In the current driver it's default to count the TLP payloads only, which
> will have an implicity side effects that on the traffic only have header
> only TLPs, we'll get no data.
> 
> Make this user configuration through "len_mode" parameter and make it
> default to count both TLP headers and payloads when user not specified.
> Also update the documentation for it.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../admin-guide/perf/hisi-pcie-pmu.rst         | 18 ++++++++++++++++++
>  drivers/perf/hisilicon/hisi_pcie_pmu.c         | 14 +++++++++++++-
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
> index bbe66480ff85..b3615230a4f6 100644
> --- a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
> +++ b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
> @@ -104,3 +104,21 @@ when TLP length < threshold.
>  Example usage of perf::
>  
>    $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,thr_len=0x4,thr_mode=1/ sleep 5
> +
> +4. TLP Length filter
> +
> +   When counting bandwidth, the data can be composed of certain parts of TLP
> +   packets. You can specify it through "len_mode":
> +
> +   - 2'b00: Reserved (Do not use this since the behaviour is undefined)
> +   - 2'b01: Bandwidth of TLP payloads
> +   - 2'b10: Bandwidth of TLP headers
> +   - 2'b11: Bandwidth of both TLP payloads and headers
> +
> +   For example, "len_mode=2" means only counting the bandwidth of TLP headers
> +   and "len_mode=3" means the final bandwidth data is composed of both TLP
> +   headers and payloads. Default value if not specified is 2'b11.
> +
> +   Example usage of perf::
> +
> +     $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,len_mode=0x1/ sleep 5
> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> index 071e63d9a9ac..6fee0b6e163b 100644
> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> @@ -47,10 +47,14 @@
>  #define HISI_PCIE_EVENT_M		GENMASK_ULL(15, 0)
>  #define HISI_PCIE_THR_MODE_M		GENMASK_ULL(27, 27)
>  #define HISI_PCIE_THR_M			GENMASK_ULL(31, 28)
> +#define HISI_PCIE_LEN_M			GENMASK_ULL(35, 34)
>  #define HISI_PCIE_TARGET_M		GENMASK_ULL(52, 36)
>  #define HISI_PCIE_TRIG_MODE_M		GENMASK_ULL(53, 53)
>  #define HISI_PCIE_TRIG_M		GENMASK_ULL(59, 56)
>  
> +/* Default config of TLP length mode, will count both TLP headers and payloads */
> +#define HISI_PCIE_LEN_M_DEFAULT		3ULL
> +
>  #define HISI_PCIE_MAX_COUNTERS		8
>  #define HISI_PCIE_REG_STEP		8
>  #define HISI_PCIE_THR_MAX_VAL		10
> @@ -91,6 +95,7 @@ HISI_PCIE_PMU_FILTER_ATTR(thr_len, config1, 3, 0);
>  HISI_PCIE_PMU_FILTER_ATTR(thr_mode, config1, 4, 4);
>  HISI_PCIE_PMU_FILTER_ATTR(trig_len, config1, 8, 5);
>  HISI_PCIE_PMU_FILTER_ATTR(trig_mode, config1, 9, 9);
> +HISI_PCIE_PMU_FILTER_ATTR(len_mode, config1, 11, 10);
>  HISI_PCIE_PMU_FILTER_ATTR(port, config2, 15, 0);
>  HISI_PCIE_PMU_FILTER_ATTR(bdf, config2, 31, 16);
>  
> @@ -215,8 +220,8 @@ static void hisi_pcie_pmu_config_filter(struct perf_event *event)
>  {
>  	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>  	struct hw_perf_event *hwc = &event->hw;
> +	u64 port, trig_len, thr_len, len_mode;
>  	u64 reg = HISI_PCIE_INIT_SET;
> -	u64 port, trig_len, thr_len;
>  
>  	/* Config HISI_PCIE_EVENT_CTRL according to event. */
>  	reg |= FIELD_PREP(HISI_PCIE_EVENT_M, hisi_pcie_get_real_event(event));
> @@ -245,6 +250,12 @@ static void hisi_pcie_pmu_config_filter(struct perf_event *event)
>  		reg |= HISI_PCIE_THR_EN;
>  	}
>  
> +	len_mode = hisi_pcie_get_len_mode(event);
> +	if (len_mode)
> +		reg |= FIELD_PREP(HISI_PCIE_LEN_M, len_mode);
> +	else
> +		reg |= FIELD_PREP(HISI_PCIE_LEN_M, HISI_PCIE_LEN_M_DEFAULT);
> +
>  	hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EVENT_CTRL, hwc->idx, reg);
>  }
>  
> @@ -711,6 +722,7 @@ static struct attribute *hisi_pcie_pmu_format_attr[] = {
>  	HISI_PCIE_PMU_FORMAT_ATTR(thr_mode, "config1:4"),
>  	HISI_PCIE_PMU_FORMAT_ATTR(trig_len, "config1:5-8"),
>  	HISI_PCIE_PMU_FORMAT_ATTR(trig_mode, "config1:9"),
> +	HISI_PCIE_PMU_FORMAT_ATTR(len_mode, "config1:10-11"),
>  	HISI_PCIE_PMU_FORMAT_ATTR(port, "config2:0-15"),
>  	HISI_PCIE_PMU_FORMAT_ATTR(bdf, "config2:16-31"),
>  	NULL

