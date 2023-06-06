Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1047172497A
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 18:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbjFFQqj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 12:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjFFQqj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 12:46:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8B3E62;
        Tue,  6 Jun 2023 09:46:38 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QbGXL5b9Hz688hZ;
        Wed,  7 Jun 2023 00:44:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 17:46:35 +0100
Date:   Tue, 6 Jun 2023 17:46:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <alexander.shishkin@linux.intel.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: Re: [PATCH v4 3/5] hwtracing: hisi_ptt: Export available filters
 through sysfs
Message-ID: <20230606174635.0000078b@Huawei.com>
In-Reply-To: <20230606142244.10939-4-yangyicong@huawei.com>
References: <20230606142244.10939-1-yangyicong@huawei.com>
        <20230606142244.10939-4-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 6 Jun 2023 22:22:42 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The PTT can only filter the traced TLP headers by the Root Ports or the
> Requester ID of the Endpoint, which are located on the same PCIe core of
> the PTT device. The filter value used is derived from the BDF number of
> the supported Root Port or the Endpoint. It's not friendly enough for the
> users since it requires the user to be familiar enough with the platform
> and calculate the filter value manually.
> 
> This patch export the available filters through sysfs. Each available
> filters is presented as an individual file with the name of the BDF
> number of the related PCIe device. The files are created under
> $(PTT PMU dir)/available_root_port_filters and
> $(PTT PMU dir)/available_requester_filters respectively. The filter
> value can be known by reading the related file.
> 
> Then the users can easily know the available filters for trace and get
> the filter values without calculating.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Two minor tweaks suggested inline. With those tidied up
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../ABI/testing/sysfs-devices-hisi_ptt        |  50 +++++
>  Documentation/trace/hisi-ptt.rst              |   6 +
>  drivers/hwtracing/ptt/hisi_ptt.c              | 205 ++++++++++++++++++
>  drivers/hwtracing/ptt/hisi_ptt.h              |  14 ++
>  4 files changed, 275 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-hisi_ptt b/Documentation/ABI/testing/sysfs-devices-hisi_ptt
> index 82de6d710266..10df63568df9 100644
> --- a/Documentation/ABI/testing/sysfs-devices-hisi_ptt
> +++ b/Documentation/ABI/testing/sysfs-devices-hisi_ptt
> @@ -59,3 +59,53 @@ Description:	(RW) Control the allocated buffer watermark of outbound packets.
>  		The available tune data is [0, 1, 2]. Writing a negative value
>  		will return an error, and out of range values will be converted
>  		to 2. The value indicates a probable level of the event.
> +
> +What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/root_port_filters
> +Date:		May 2023
> +KernelVersion:	6.5
> +Contact:	Yicong Yang <yangyicong@hisilicon.com>
> +Description:	This directory contains the files providing the PCIe Root Port filters
> +		information used for PTT trace. Each file is named after the supported
> +		Root Port device name <domain>:<bus>:<device>.<function>.
> +
> +		See the description of the "filter" in Documentation/trace/hisi-ptt.rst
> +		for more information.
> +
> +What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/root_port_filters/multiselect
> +Date:		May 2023
> +KernelVersion:	6.5
> +Contact:	Yicong Yang <yangyicong@hisilicon.com>
> +Description:	(Read) Indicates if this kind of filter can be selected at the same
> +		time as others filters, or must be used on it's own.

Call out meaning of 1 and 0 for these two cases.



> +
> +static int hisi_ptt_init_filter_attributes(struct hisi_ptt *hisi_ptt)
> +{
> +	struct hisi_ptt_filter_desc *filter;
> +	int ret;
> +
> +	mutex_lock(&hisi_ptt->filter_lock);
> +
> +	/*
> +	 * Register the reset callback in the first stage. In reset we traverse
> +	 * the filters list to remove the sysfs attributes so the callback alone

the callback can be
(alone got left and shouldn't have been. I wasn't clear in previous feedback)

> +	 * can be called safely even without below filter attributes creation.
> +	 */
> +	ret = devm_add_action(&hisi_ptt->pdev->dev,
> +			      hisi_ptt_remove_all_filter_attributes,
> +			      hisi_ptt);
> +	if (ret)
> +		goto out;
> +
> +	list_for_each_entry(filter, &hisi_ptt->port_filters, list) {
> +		ret = hisi_ptt_create_filter_attr(hisi_ptt, filter);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	list_for_each_entry(filter, &hisi_ptt->req_filters, list) {
> +		ret = hisi_ptt_create_filter_attr(hisi_ptt, filter);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	hisi_ptt->sysfs_inited = true;
> +out:
> +	mutex_unlock(&hisi_ptt->filter_lock);
> +	return ret;
> +}
