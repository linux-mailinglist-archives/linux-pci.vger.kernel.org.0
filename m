Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE13723E23
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 11:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbjFFJr3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 05:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbjFFJrW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 05:47:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D1490;
        Tue,  6 Jun 2023 02:47:20 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qb5DX683Xz67cTX;
        Tue,  6 Jun 2023 17:45:00 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 10:47:10 +0100
Date:   Tue, 6 Jun 2023 10:47:09 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <alexander.shishkin@linux.intel.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v3 1/4] hwtracing: hisi_ptt: Factor out filter
 allocation and release operation
Message-ID: <20230606104709.00000047@Huawei.com>
In-Reply-To: <20230523093228.48149-2-yangyicong@huawei.com>
References: <20230523093228.48149-1-yangyicong@huawei.com>
        <20230523093228.48149-2-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Tue, 23 May 2023 17:32:25 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Factor out the allocation and release of filters. This will make it easier
> to extend and manage the function of the filter.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Straight forward refactor. LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/hwtracing/ptt/hisi_ptt.c | 63 ++++++++++++++++++++------------
>  1 file changed, 39 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 30f1525639b5..548cfef51ace 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -354,6 +354,39 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
>  	return 0;
>  }
>  
> +static void hisi_ptt_del_free_filter(struct hisi_ptt *hisi_ptt,
> +				      struct hisi_ptt_filter_desc *filter)
> +{
> +	list_del(&filter->list);
> +	kfree(filter);
> +}
> +
> +static struct hisi_ptt_filter_desc *
> +hisi_ptt_alloc_add_filter(struct hisi_ptt *hisi_ptt, struct pci_dev *pdev)
> +{
> +	struct hisi_ptt_filter_desc *filter;
> +
> +	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
> +	if (!filter) {
> +		pci_err(hisi_ptt->pdev, "failed to add filter for %s\n",
> +			pci_name(pdev));
> +		return NULL;
> +	}
> +
> +	filter->devid = PCI_DEVID(pdev->bus->number, pdev->devfn);
> +	filter->is_port = pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT;
> +	if (filter->is_port) {
> +		list_add_tail(&filter->list, &hisi_ptt->port_filters);
> +
> +		/* Update the available port mask */
> +		hisi_ptt->port_mask |= hisi_ptt_get_filter_val(filter->devid, true);
> +	} else {
> +		list_add_tail(&filter->list, &hisi_ptt->req_filters);
> +	}
> +
> +	return filter;
> +}
> +
>  static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
>  {
>  	struct pci_dev *root_port = pcie_find_root_port(pdev);
> @@ -374,23 +407,9 @@ static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
>  	 * should be partial initialized and users would know which filter fails
>  	 * through the log. Other functions of PTT device are still available.
>  	 */
> -	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
> -	if (!filter) {
> -		pci_err(hisi_ptt->pdev, "failed to add filter %s\n", pci_name(pdev));
> +	filter = hisi_ptt_alloc_add_filter(hisi_ptt, pdev);
> +	if (!filter)
>  		return -ENOMEM;
> -	}
> -
> -	filter->devid = PCI_DEVID(pdev->bus->number, pdev->devfn);
> -
> -	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) {
> -		filter->is_port = true;
> -		list_add_tail(&filter->list, &hisi_ptt->port_filters);
> -
> -		/* Update the available port mask */
> -		hisi_ptt->port_mask |= hisi_ptt_get_filter_val(filter->devid, true);
> -	} else {
> -		list_add_tail(&filter->list, &hisi_ptt->req_filters);
> -	}
>  
>  	return 0;
>  }
> @@ -400,15 +419,11 @@ static void hisi_ptt_release_filters(void *data)
>  	struct hisi_ptt_filter_desc *filter, *tmp;
>  	struct hisi_ptt *hisi_ptt = data;
>  
> -	list_for_each_entry_safe(filter, tmp, &hisi_ptt->req_filters, list) {
> -		list_del(&filter->list);
> -		kfree(filter);
> -	}
> +	list_for_each_entry_safe(filter, tmp, &hisi_ptt->req_filters, list)
> +		hisi_ptt_del_free_filter(hisi_ptt, filter);
>  
> -	list_for_each_entry_safe(filter, tmp, &hisi_ptt->port_filters, list) {
> -		list_del(&filter->list);
> -		kfree(filter);
> -	}
> +	list_for_each_entry_safe(filter, tmp, &hisi_ptt->port_filters, list)
> +		hisi_ptt_del_free_filter(hisi_ptt, filter);
>  }
>  
>  static int hisi_ptt_config_trace_buf(struct hisi_ptt *hisi_ptt)

