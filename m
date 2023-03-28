Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2074B6CC8BB
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 19:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjC1RCk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 13:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjC1RCj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 13:02:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBA0BDF2;
        Tue, 28 Mar 2023 10:02:37 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PmGCw2Rtfz6J7dG;
        Wed, 29 Mar 2023 01:01:00 +0800 (CST)
Received: from localhost (10.195.244.179) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 28 Mar
 2023 18:02:35 +0100
Date:   Tue, 28 Mar 2023 18:02:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <alexander.shishkin@linux.intel.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 3/4] hwtracing: hisi_ptt: Export available filters
 through sysfs
Message-ID: <20230328180234.00003421@Huawei.com>
In-Reply-To: <20230315094316.26772-4-yangyicong@huawei.com>
References: <20230315094316.26772-1-yangyicong@huawei.com>
        <20230315094316.26772-4-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.244.179]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 15 Mar 2023 17:43:15 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The PTT can only filter the traced TLP headers by the Root Ports or the
> Requester ID of the Endpoint, which are located on the same core of the
> PTT device. The filter value used is derived from the BDF number of the
> supported Root Port or the Endpoint. It's not friendly enough for the
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

Trivial comments only inline.

With those answered / tidied up.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 010cdbc3c172..a5cd87edb813 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c


>
> +
> +static int hisi_ptt_init_filter_attributes(struct hisi_ptt *hisi_ptt)
> +{
> +	struct hisi_ptt_filter_desc *filter;
> +	int ret;
> +
> +	mutex_lock(&hisi_ptt->filter_lock);
> +
> +	list_for_each_entry(filter, &hisi_ptt->port_filters, list) {
> +		ret = hisi_ptt_create_filter_attr(hisi_ptt, filter);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	list_for_each_entry(filter, &hisi_ptt->req_filters, list) {
> +		ret = hisi_ptt_create_filter_attr(hisi_ptt, filter);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	ret = devm_add_action_or_reset(&hisi_ptt->pdev->dev,
> +				       hisi_ptt_remove_all_filter_attributes,
> +				       hisi_ptt);
> +	if (ret)
> +		goto err;
> +
> +	hisi_ptt->sysfs_inited = true;

err:

> +	mutex_unlock(&hisi_ptt->filter_lock);

	return ret;

No need for separate exit block when nothing to do but unlock.

> +	return 0;
> +err:
> +	mutex_unlock(&hisi_ptt->filter_lock);
> +	return ret;
> +}
> +
>  static void hisi_ptt_update_filters(struct work_struct *work)
>  {
>  	struct delayed_work *delayed_work = to_delayed_work(work);
> @@ -384,8 +517,28 @@ static void hisi_ptt_update_filters(struct work_struct *work)
>  				continue;
>  			}
>  
> +			filter->name = kstrdup(pci_name(info.pdev), GFP_KERNEL);
> +			if (!filter->name) {
> +				pci_err(hisi_ptt->pdev, "failed to add filter %s\n",
> +					pci_name(info.pdev));
> +				kfree(filter);
> +				continue;
> +			}
> +
>  			filter->devid = devid;
>  			filter->is_port = is_port;
> +
> +			/*
> +			 * If filters' sysfs entries hasn't been initialized, then
> +			 * we're still at probe stage and leave it to handled by
> +			 * others.
> +			 */
> +			if (hisi_ptt->sysfs_inited &&

Can we move this sysfs_inited check earlier? Seems silly to leave a simple check
like that so late.

> +			    hisi_ptt_create_filter_attr(hisi_ptt, filter)) {
> +				kfree(filter);
> +				continue;
> +			}
> +
>  			list_add_tail(&filter->list, target_list);
>  
>  			if (is_port)
> @@ -394,6 +547,11 @@ static void hisi_ptt_update_filters(struct work_struct *work)
>  			list_for_each_entry(filter, target_list, list)
>  				if (filter->devid == devid) {
>  					list_del(&filter->list);
> +
> +					if (hisi_ptt->sysfs_inited)
> +						hisi_ptt_remove_filter_attr(hisi_ptt, filter);
> +
> +					kfree(filter->name);
>  					kfree(filter);
>  					break;
>  				}
> @@ -486,10 +644,12 @@ static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
>  	 * through the log. Other functions of PTT device are still available.
>  	 */
>  	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
> -	if (!filter) {
> -		pci_err(hisi_ptt->pdev, "failed to add filter %s\n", pci_name(pdev));
> -		return -ENOMEM;
> -	}
> +	if (!filter)
> +		goto err_mem;
> +
> +	filter->name = kstrdup(pci_name(pdev), GFP_KERNEL);
> +	if (!filter->name)
> +		goto err_name;
>  
>  	filter->devid = PCI_DEVID(pdev->bus->number, pdev->devfn);
>  
> @@ -504,6 +664,11 @@ static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
>  	}
>  
>  	return 0;
> +err_name:
> +	kfree(filter);
> +err_mem:
> +	pci_err(hisi_ptt->pdev, "failed to add filter %s\n", pci_name(pdev));

I'd rather see a message for each of the error paths so we have some information on why.
Original message wasn't great for this obviously and perhaps given they are both allocation
errors it's not worth splitting them up.

> +	return -ENOMEM;
>  }


