Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A924ABEDE
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 14:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377771AbiBGNMb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 08:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442273AbiBGMUv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 07:20:51 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40ECC02B656;
        Mon,  7 Feb 2022 04:07:24 -0800 (PST)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JsknY4wy6z67Y0C;
        Mon,  7 Feb 2022 19:44:17 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 7 Feb 2022 12:49:13 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Feb
 2022 11:49:12 +0000
Date:   Mon, 7 Feb 2022 11:49:11 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
CC:     <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <daniel.thompson@linaro.org>, <joro@8bytes.org>,
        <john.garry@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
        <robin.murphy@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v3 4/8] hisi_ptt: Add tune function support for
 HiSilicon PCIe Tune and Trace device
Message-ID: <20220207114911.0000127e@Huawei.com>
In-Reply-To: <20220124131118.17887-5-yangyicong@hisilicon.com>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
        <20220124131118.17887-5-yangyicong@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 24 Jan 2022 21:11:14 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> Add tune function for the HiSilicon Tune and Trace device. The interface
> of tune is exposed through sysfs attributes of PTT PMU device.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

A few trivial things inline, but looks good in general to me.
With those tidied up
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/hwtracing/ptt/hisi_ptt.c | 154 +++++++++++++++++++++++++++++++
>  drivers/hwtracing/ptt/hisi_ptt.h |  19 ++++
>  2 files changed, 173 insertions(+)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 2994354e690b..b11e702eb506 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -21,6 +21,159 @@
>  
>  #include "hisi_ptt.h"
>  
> +static int hisi_ptt_wait_tuning_finish(struct hisi_ptt *hisi_ptt)
> +{
> +	u32 val;
> +
> +	return readl_poll_timeout(hisi_ptt->iobase + HISI_PTT_TUNING_INT_STAT,
> +				  val, !(val & HISI_PTT_TUNING_INT_STAT_MASK),
> +				  HISI_PTT_WAIT_POLL_INTERVAL_US,
> +				  HISI_PTT_WAIT_TIMEOUT_US);
> +}
> +
> +static int hisi_ptt_tune_data_get(struct hisi_ptt *hisi_ptt,
> +				  u32 event, u16 *data)
> +{
> +	u32 reg;
> +
> +	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
> +	reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
> +	reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
> +			  event);
> +	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
> +
> +	/* Write all 1 to indicates it's the read process */
> +	writel(~0UL, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);

Just to check, this is includes the bits above the DATA_VAL_MASK?
Fine if so, just seems odd to define a field but then write 
parts of the register that aren't part of that field.

> +
> +	if (hisi_ptt_wait_tuning_finish(hisi_ptt))
> +		return -ETIMEDOUT;
> +
> +	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
> +	reg &= HISI_PTT_TUNING_DATA_VAL_MASK;
> +	*data = (u16)reg;

As below, prefer a FIELD_GET() for this.

> +
> +	return 0;
> +}
> +
> +static int hisi_ptt_tune_data_set(struct hisi_ptt *hisi_ptt,
> +				  u32 event, u16 data)
> +{
> +	u32 reg;
> +
> +	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
> +	reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
> +	reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
> +			  event);
> +	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
> +
> +	reg = data;
Given you defined HISI_PTT_TUNING_DATA_VAL_MASK why not use it here

writel(FIELD_PREP(..), ...)? 

> +	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
> +
> +	if (hisi_ptt_wait_tuning_finish(hisi_ptt))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +


