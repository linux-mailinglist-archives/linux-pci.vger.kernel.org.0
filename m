Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A056723F0E
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 12:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjFFKPZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 06:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjFFKPY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 06:15:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DF1E47;
        Tue,  6 Jun 2023 03:15:20 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qb5sD2LrLz6D8Wm;
        Tue,  6 Jun 2023 18:13:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 11:15:18 +0100
Date:   Tue, 6 Jun 2023 11:15:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <alexander.shishkin@linux.intel.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v3 3/4] hwtracing: hisi_ptt: Export available filters
 through sysfs
Message-ID: <20230606111517.00007bc4@Huawei.com>
In-Reply-To: <20230523093228.48149-4-yangyicong@huawei.com>
References: <20230523093228.48149-1-yangyicong@huawei.com>
        <20230523093228.48149-4-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 23 May 2023 17:32:27 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The PTT can only filter the traced TLP headers by the Root Ports or the
> Requester ID of the Endpoint, which are located on the same core of the

PCI core (could be confused with CPU core)

> PTT device. The filter value used is derived from the BDF number of the
> supported Root Port or the Endpoint. It's not friendly enough for the
> users since it requires the user to be familiar enough with the platform
> and calculate the filter value manually.

Could we in theory push this problem to userspace?  If so perhaps
call out advantages / disadvantages of doing so?

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
A few minor editorial type comments inline

Jonathan

> ---
>  .../ABI/testing/sysfs-devices-hisi_ptt        |  50 +++++
>  Documentation/trace/hisi-ptt.rst              |   6 +
>  drivers/hwtracing/ptt/hisi_ptt.c              | 206 ++++++++++++++++++
>  drivers/hwtracing/ptt/hisi_ptt.h              |  14 ++
>  4 files changed, 276 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-hisi_ptt b/Documentation/ABI/testing/sysfs-devices-hisi_ptt
> index 82de6d710266..190ed504346b 100644
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
> +Description:	(Read) Indicates whether this kind of filter can be multiselected
> +		or not. 1 for multiselectable, 0 for not.
multiselect term isn't totally clear - so I'd say exactly what it means here.

	Indicates if this kind of filter can be selected at the same time as
        others filters, or must be used on it's own.

> +
> +What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/root_port_filters/<bdf>
> +Date:		May 2023
> +KernelVersion:	6.5
> +Contact:	Yicong Yang <yangyicong@hisilicon.com>
> +Description:	(Read) Indicates the filter value of this Root Port filter, which
> +		can be used to control the TLP headers to trace by the PTT trace.
> +
> +What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/requester_filters
> +Date:		May 2023
> +KernelVersion:	6.5
> +Contact:	Yicong Yang <yangyicong@hisilicon.com>
> +Description:	This directory contains the files providing the PCIe Requester filters
> +		information used for PTT trace. Each file is named after the supported
> +		Endpoint device name <domain>:<bus>:<device>.<function>.
> +
> +		See the description of the "filter" in Documentation/trace/hisi-ptt.rst
> +		for more information.
> +
> +What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/requester_filters/multiselect
> +Date:		May 2023
> +KernelVersion:	6.5
> +Contact:	Yicong Yang <yangyicong@hisilicon.com>
> +Description:	(Read) Indicates whether this kind of filter can be multiselected
> +		or not. 1 for multiselectable, 0 for not.

As above - explain multiselect using a different set of terms.

> +
> +What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/requester_filters/<bdf>
> +Date:		May 2023
> +KernelVersion:	6.5
> +Contact:	Yicong Yang <yangyicong@hisilicon.com>
> +Description:	(Read) Indicates the filter value of this Requester filter, which
> +		can be used to control the TLP headers to trace by the PTT trace.
> diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-ptt.rst
> index 3641aca4287a..b8c7d71aee32 100644
> --- a/Documentation/trace/hisi-ptt.rst
> +++ b/Documentation/trace/hisi-ptt.rst
> @@ -148,6 +148,12 @@ For example, if the desired filter is Endpoint function 0000:01:00.1 the filter
>  value will be 0x00101. If the desired filter is Root Port 0000:00:10.0 then
>  then filter value is calculated as 0x80001.
>  
> +The driver also presents every supported Root Port and Requester filter through
> +sysfs. Each filter will be an individual file with name of its related PCIe
> +device name (domain:bus:device.function). The files of Root Port filters are
> +under $(PTT PMU dir)/root_port_filters and files of Requester filters
> +are under $(PTT PMU dir)/requester_filters.
> +
>  Note that multiple Root Ports can be specified at one time, but only one
>  Endpoint function can be specified in one trace. Specifying both Root Port
>  and function at the same time is not supported. Driver maintains a list of
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 9b4acbc434b0..65f4288a1915 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -404,6 +404,142 @@ hisi_ptt_alloc_add_filter(struct hisi_ptt *hisi_ptt, u16 devid, bool is_port)
>  	return filter;
>  }
>  
> +static ssize_t hisi_ptt_filter_show(struct device *dev, struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct hisi_ptt_filter_desc *filter;
> +	unsigned long filter_val;
> +
> +	filter = container_of(attr, struct hisi_ptt_filter_desc, attr);
> +	filter_val = hisi_ptt_get_filter_val(filter->devid, filter->is_port) |
> +		     (filter->is_port ? HISI_PTT_PMU_FILTER_IS_PORT : 0);
> +
> +	return sysfs_emit(buf, "0x%05lx\n", filter_val);
> +}
> +
> +static int hisi_ptt_create_rp_filter_attr(struct hisi_ptt *hisi_ptt,
> +					  struct hisi_ptt_filter_desc *filter)
> +{
> +	struct kobject *kobj = &hisi_ptt->hisi_ptt_pmu.dev->kobj;
> +
> +	filter->attr.attr.name = filter->name;
> +	filter->attr.attr.mode = 0400; /* DEVICE_ATTR_ADMIN_RO */
> +	filter->attr.show = hisi_ptt_filter_show;
> +
> +	return sysfs_add_file_to_group(kobj, &filter->attr.attr,
> +				       HISI_PTT_RP_FILTERS_GRP_NAME);
> +}
> +
> +static void hisi_ptt_remove_rp_filter_attr(struct hisi_ptt *hisi_ptt,
> +					  struct hisi_ptt_filter_desc *filter)
> +{
> +	struct kobject *kobj = &hisi_ptt->hisi_ptt_pmu.dev->kobj;
> +
> +	sysfs_remove_file_from_group(kobj, &filter->attr.attr,
> +				     HISI_PTT_RP_FILTERS_GRP_NAME);
> +}
> +
> +static int hisi_ptt_create_req_filter_attr(struct hisi_ptt *hisi_ptt,
> +					   struct hisi_ptt_filter_desc *filter)
> +{
> +	struct kobject *kobj = &hisi_ptt->hisi_ptt_pmu.dev->kobj;
> +
> +	filter->attr.attr.name = filter->name;
> +	filter->attr.attr.mode = 0400; /* DEVICE_ATTR_ADMIN_RO */
> +	filter->attr.show = hisi_ptt_filter_show;
> +
> +	return sysfs_add_file_to_group(kobj, &filter->attr.attr,
> +				       HISI_PTT_REQ_FILTERS_GRP_NAME);
> +}
> +
> +static void hisi_ptt_remove_req_filter_attr(struct hisi_ptt *hisi_ptt,
> +					   struct hisi_ptt_filter_desc *filter)
> +{
> +	struct kobject *kobj = &hisi_ptt->hisi_ptt_pmu.dev->kobj;
> +
> +	sysfs_remove_file_from_group(kobj, &filter->attr.attr,
> +				     HISI_PTT_REQ_FILTERS_GRP_NAME);
> +}
> +
> +static int hisi_ptt_create_filter_attr(struct hisi_ptt *hisi_ptt,
> +				       struct hisi_ptt_filter_desc *filter)
> +{
> +	int ret;
> +
> +	if (filter->is_port)
> +		ret = hisi_ptt_create_rp_filter_attr(hisi_ptt, filter);
> +	else
> +		ret = hisi_ptt_create_req_filter_attr(hisi_ptt, filter);
> +
> +	if (ret)
> +		pci_err(hisi_ptt->pdev, "failed to create sysfs attribute for filter %s\n",
> +			filter->name);
> +
> +	return ret;
> +}
> +
> +static void hisi_ptt_remove_filter_attr(struct hisi_ptt *hisi_ptt,
> +					struct hisi_ptt_filter_desc *filter)
> +{
> +	if (filter->is_port)
> +		hisi_ptt_remove_rp_filter_attr(hisi_ptt, filter);
> +	else
> +		hisi_ptt_remove_req_filter_attr(hisi_ptt, filter);
> +}
> +
> +static void hisi_ptt_remove_all_filter_attributes(void *data)
> +{
> +	struct hisi_ptt_filter_desc *filter;
> +	struct hisi_ptt *hisi_ptt = data;
> +
> +	mutex_lock(&hisi_ptt->filter_lock);
> +
> +	list_for_each_entry(filter, &hisi_ptt->req_filters, list)
> +		hisi_ptt_remove_filter_attr(hisi_ptt, filter);
> +
> +	list_for_each_entry(filter, &hisi_ptt->port_filters, list)
> +		hisi_ptt_remove_filter_attr(hisi_ptt, filter);
> +
> +	hisi_ptt->sysfs_inited = false;
> +	mutex_unlock(&hisi_ptt->filter_lock);
> +}
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
> +	 * the filters list to remove the sysfs attributes so itself alone can

"itself alone" is confusing.   Maybe "the callback"

> +	 * be called safely even without below filter attributes creation work.
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
> +
...


