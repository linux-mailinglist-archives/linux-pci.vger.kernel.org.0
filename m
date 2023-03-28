Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEFD6CC885
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 18:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjC1Qv7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 12:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC1Qv6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 12:51:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DDB76B4;
        Tue, 28 Mar 2023 09:51:57 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PmFzb2xmHz6J7NQ;
        Wed, 29 Mar 2023 00:50:19 +0800 (CST)
Received: from localhost (10.195.244.179) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 28 Mar
 2023 17:51:54 +0100
Date:   Tue, 28 Mar 2023 17:51:53 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <alexander.shishkin@linux.intel.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 2/4] hwtracing: hisi_ptt: Add support for dynamically
 updating the filter list
Message-ID: <20230328175153.00002938@Huawei.com>
In-Reply-To: <20230315094316.26772-3-yangyicong@huawei.com>
References: <20230315094316.26772-1-yangyicong@huawei.com>
        <20230315094316.26772-3-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.244.179]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Wed, 15 Mar 2023 17:43:14 +0800
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
> ---

Just a few trivial comments on this.

With those tidied up
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



...

> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 0a10c7ec46ad..010cdbc3c172 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c

> +/*
> + * A PCI bus notifier is used here for dynamically updating the filter
> + * list.
> + */
> +static int hisi_ptt_notifier_call(struct notifier_block *nb, unsigned long action,
> +				  void *data)
> +{
> +	struct hisi_ptt *hisi_ptt = container_of(nb, struct hisi_ptt, hisi_ptt_nb);
> +	struct hisi_ptt_filter_update_info info;
> +	struct device *dev = data;
> +	struct pci_dev *pdev = to_pci_dev(dev);

This local variable doesn't add anything over

	info.pdev = to_pci_dev(dev);



> +
> +	info.pdev = pdev;
> +
> +	switch (action) {
> +	case BUS_NOTIFY_ADD_DEVICE:
> +		info.is_add = true;
> +		break;
> +	case BUS_NOTIFY_DEL_DEVICE:
> +		info.is_add = false;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	hisi_ptt_update_fifo_in(hisi_ptt, &info);
> +
> +	return 0;
> +}
> +

> diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
> index 5beb1648c93a..b1ba638fe7ea 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.h
> +++ b/drivers/hwtracing/ptt/hisi_ptt.h
> @@ -11,12 +11,15 @@

>  /**
>   * struct hisi_ptt_pmu_buf - Descriptor of the AUX buffer of PTT trace
>   * @length:   size of the AUX buffer
> @@ -170,10 +188,15 @@ struct hisi_ptt_pmu_buf {
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

Docs update for this one?

>  	struct hlist_node hotplug_node;
>  	struct pmu hisi_ptt_pmu;
>  	void __iomem *iobase;
> @@ -192,7 +215,19 @@ struct hisi_ptt {
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

