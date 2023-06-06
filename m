Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F777723E8A
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 11:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbjFFJ5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 05:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237502AbjFFJ5F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 05:57:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80133E76;
        Tue,  6 Jun 2023 02:57:03 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qb5S71v1kz67lVQ;
        Tue,  6 Jun 2023 17:55:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 10:57:01 +0100
Date:   Tue, 6 Jun 2023 10:56:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <alexander.shishkin@linux.intel.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v3 2/4] hwtracing: hisi_ptt: Add support for dynamically
 updating the filter list
Message-ID: <20230606105655.00006d92@Huawei.com>
In-Reply-To: <20230523093228.48149-3-yangyicong@huawei.com>
References: <20230523093228.48149-1-yangyicong@huawei.com>
        <20230523093228.48149-3-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Tue, 23 May 2023 17:32:26 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The PCIe devices supported by the PTT trace can be removed/rescanned by
> hotplug or through sysfs.  Add support for dynamically updating the
> available filter list by registering a PCI bus notifier block. Then user
> can always get latest information about available tracing filters and
> driver can block the invalid filters of which related devices no longer
> exist in the system.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Hi Yangyicong,

A few comments inline

Jonathan

> ---
>  Documentation/trace/hisi-ptt.rst |   6 +-
>  drivers/hwtracing/ptt/hisi_ptt.c | 165 +++++++++++++++++++++++++++++--
>  drivers/hwtracing/ptt/hisi_ptt.h |  39 ++++++++
>  3 files changed, 201 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-ptt.rst
> index 4f87d8e21065..3641aca4287a 100644
> --- a/Documentation/trace/hisi-ptt.rst
> +++ b/Documentation/trace/hisi-ptt.rst
> @@ -153,9 +153,9 @@ Endpoint function can be specified in one trace. Specifying both Root Port
>  and function at the same time is not supported. Driver maintains a list of
>  available filters and will check the invalid inputs.
>  
> -Currently the available filters are detected in driver's probe. If the supported
> -devices are removed/added after probe, you may need to reload the driver to update
> -the filters.
> +The available filters will be dynamically updates, which means you will always

updated, 

> +get correct filter information when hotplug events happen, or when you manually
> +remove/rescan the devices.
>  
>  2. Type
>  -------
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 548cfef51ace..9b4acbc434b0 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -357,24 +357,41 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)

...

>  static struct hisi_ptt_filter_desc *
> -hisi_ptt_alloc_add_filter(struct hisi_ptt *hisi_ptt, struct pci_dev *pdev)
> +hisi_ptt_alloc_add_filter(struct hisi_ptt *hisi_ptt, u16 devid, bool is_port)
>  {
>  	struct hisi_ptt_filter_desc *filter;
> +	u8 devfn = devid & 0xff;
> +	char *filter_name;
> +
> +	filter_name = kasprintf(GFP_KERNEL, "%04x:%02x:%02x.%d", pci_domain_nr(hisi_ptt->pdev->bus),
> +				 PCI_BUS_NUM(devid), PCI_SLOT(devfn), PCI_FUNC(devfn));
> +	if (!filter_name) {
> +		pci_err(hisi_ptt->pdev, "failed to allocate name for filter %s\n",
> +			filter_name);
> +		kfree(filter);

Don't think you've allocated filter yet.

> +		return NULL;
> +	}
>  
>  	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
>  	if (!filter) {
>  		pci_err(hisi_ptt->pdev, "failed to add filter for %s\n",
> -			pci_name(pdev));
> +			filter_name);
>  		return NULL;
>  	}
>  
> -	filter->devid = PCI_DEVID(pdev->bus->number, pdev->devfn);
> -	filter->is_port = pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT;
> +	filter->name = filter_name;
> +	filter->is_port = is_port;
> +	filter->devid = devid;
> +
>  	if (filter->is_port) {
>  		list_add_tail(&filter->list, &hisi_ptt->port_filters);
>  
> @@ -387,6 +404,102 @@ hisi_ptt_alloc_add_filter(struct hisi_ptt *hisi_ptt, struct pci_dev *pdev)
>  	return filter;
>  }




...

> @@ -633,14 +752,19 @@ static int hisi_ptt_trace_valid_filter(struct hisi_ptt *hisi_ptt, u64 config)
>  	 * For Requester ID filters, walk the available filter list to see
>  	 * whether we have one matched.
>  	 */
> +	mutex_lock(&hisi_ptt->filter_lock);
>  	if (!hisi_ptt->trace_ctrl.is_port) {
>  		list_for_each_entry(filter, &hisi_ptt->req_filters, list) {
> -			if (val == hisi_ptt_get_filter_val(filter->devid, filter->is_port))
> +			if (val == hisi_ptt_get_filter_val(filter->devid, filter->is_port)) {
> +				mutex_unlock(&hisi_ptt->filter_lock);

Perhaps a single exit location makes more sense given we need to unlock in
all paths?  goto unlock; etc

>  				return 0;
> +			}
>  		}
>  	} else if (bitmap_subset(&val, &port_mask, BITS_PER_LONG)) {
> +		mutex_unlock(&hisi_ptt->filter_lock);
>  		return 0;
>  	}
> +	mutex_unlock(&hisi_ptt->filter_lock);
>  
>  	return -EINVAL;
>  }
> @@ -916,6 +1040,31 @@ static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
>  					&hisi_ptt->hisi_ptt_pmu);
>  }



> diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
> index 5beb1648c93a..d080b306af77 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.h
> +++ b/drivers/hwtracing/ptt/hisi_ptt.h

...

> @@ -161,6 +182,7 @@ struct hisi_ptt_pmu_buf {
>   * struct hisi_ptt - Per PTT device data
>   * @trace_ctrl:   the control information of PTT trace
>   * @hotplug_node: node for register cpu hotplug event
> + * @hisi_ptt_nb:  dynamic filter update notifier

Wrong location. Order should match the fields in the structure.
So this belongs just above hotplug_node


>   * @hisi_ptt_pmu: the pum device of trace
>   * @iobase:       base IO address of the device
>   * @pdev:         pci_dev of this PTT device
> @@ -170,10 +192,15 @@ struct hisi_ptt_pmu_buf {
>   * @lower_bdf:    the lower BDF range of the PCI devices managed by this PTT device
>   * @port_filters: the filter list of root ports
>   * @req_filters:  the filter list of requester ID
> + * @filter_lock:  lock to protect the filters
>   * @port_mask:    port mask of the managed root ports
> + * @work:         delayed work for filter updating
> + * @filter_update_lock: spinlock to protect the filter update fifo
> + * @filter_update_fifo: fifo of the filters waiting to update the filter list
>   */
>  struct hisi_ptt {
>  	struct hisi_ptt_trace_ctrl trace_ctrl;
> +	struct notifier_block hisi_ptt_nb;
>  	struct hlist_node hotplug_node;
>  	struct pmu hisi_ptt_pmu;
>  	void __iomem *iobase;
> @@ -192,7 +219,19 @@ struct hisi_ptt {
>  	 */
>  	struct list_head port_filters;
>  	struct list_head req_filters;
> +	struct mutex filter_lock;
>  	u16 port_mask;
> +
> +	/*
> +	 * We use a delayed work here to avoid indefinitely waiting for
> +	 * the hisi_ptt->mutex which protecting the filter list. The
> +	 * work will be delayed only if the mutex can not be held,
> +	 * otherwise no delay will be applied.
> +	 */
> +	struct delayed_work work;
> +	spinlock_t filter_update_lock;
> +	DECLARE_KFIFO(filter_update_kfifo, struct hisi_ptt_filter_update_info,
> +		      HISI_PTT_FILTER_UPDATE_FIFO_SIZE);
>  };
>  
>  #define to_hisi_ptt(pmu) container_of(pmu, struct hisi_ptt, hisi_ptt_pmu)

