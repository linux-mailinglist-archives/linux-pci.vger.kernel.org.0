Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2454BE02B
	for <lists+linux-pci@lfdr.de>; Mon, 21 Feb 2022 18:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356797AbiBULvs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Feb 2022 06:51:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356817AbiBULvl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Feb 2022 06:51:41 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E421FA42;
        Mon, 21 Feb 2022 03:51:13 -0800 (PST)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2LFt5Hsdz67jnf;
        Mon, 21 Feb 2022 19:50:10 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 12:51:10 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 21 Feb
 2022 11:51:09 +0000
Date:   Mon, 21 Feb 2022 11:51:08 +0000
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
Subject: Re: [PATCH v4 4/8] hisi_ptt: Add support for dynamically updating
 the filter list
Message-ID: <20220221115108.000033bf@Huawei.com>
In-Reply-To: <20220221084307.33712-5-yangyicong@hisilicon.com>
References: <20220221084307.33712-1-yangyicong@hisilicon.com>
        <20220221084307.33712-5-yangyicong@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
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

On Mon, 21 Feb 2022 16:43:03 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> The PCIe devices supported by the PTT trace can be removed/rescanned
> by hotplug or through sysfs.  Add support for dynamically updating
> the available filter list by registering a PCI bus notifier block.
> Then user can always get latest information about available tracing
> filters and driver can block the invalid filters of which related
> devices no longer exist in the system.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

One comment following on from ordering of mixed devm and manual cleanup
in earlier patches.

Otherwise looks fine to me.

> ---
>  drivers/hwtracing/ptt/hisi_ptt.c | 138 ++++++++++++++++++++++++++++---
>  drivers/hwtracing/ptt/hisi_ptt.h |  34 ++++++++
>  2 files changed, 160 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index c2b6f8aa9f1e..50193a331faa 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -269,25 +269,118 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
>  	return 0;
>  }
>  


...

> @@ -313,6 +406,9 @@ static void hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
>  	struct pci_bus *bus;
>  	u32 reg;
>  
> +	INIT_DELAYED_WORK(&hisi_ptt->work, hisi_ptt_update_filters);
> +	spin_lock_init(&hisi_ptt->filter_update_lock);
> +	INIT_KFIFO(hisi_ptt->filter_update_kfifo);
>  	INIT_LIST_HEAD(&hisi_ptt->port_filters);
>  	INIT_LIST_HEAD(&hisi_ptt->req_filters);
>  
> @@ -329,6 +425,13 @@ static void hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
>  	hisi_ptt->upper = FIELD_GET(HISI_PTT_DEVICE_RANGE_UPPER, reg);
>  	hisi_ptt->lower = FIELD_GET(HISI_PTT_DEVICE_RANGE_LOWER, reg);
>  
> +	/*
> +	 * No need to fail if the bus is NULL here as the device
> +	 * maybe hotplugged after the PTT driver probe, in which
> +	 * case we can detect the event and update the list as
> +	 * we register a bus notifier for dynamically updating
> +	 * the filter list.
> +	 */
>  	bus = pci_find_bus(pci_domain_nr(pdev->bus), PCI_BUS_NUM(hisi_ptt->upper));
>  	if (bus)
>  		pci_walk_bus(bus, hisi_ptt_init_filters, hisi_ptt);
> @@ -832,6 +935,12 @@ static int hisi_ptt_probe(struct pci_dev *pdev,
>  		return ret;
>  	}
>  
> +	/* Register the bus notifier for dynamically updating the filter list */
> +	hisi_ptt->hisi_ptt_nb.notifier_call = hisi_ptt_notifier_call;
> +	ret = bus_register_notifier(&pci_bus_type, &hisi_ptt->hisi_ptt_nb);
> +	if (ret)
> +		pci_warn(pdev, "failed to register filter update notifier, ret = %d", ret);
> +
>  	return 0;
>  }
>  
> @@ -839,6 +948,11 @@ void hisi_ptt_remove(struct pci_dev *pdev)
>  {
>  	struct hisi_ptt *hisi_ptt = pci_get_drvdata(pdev);
>  
> +	bus_unregister_notifier(&pci_bus_type, &hisi_ptt->hisi_ptt_nb);
> +

wrt to earlier comment on ordering you'll also need to move these to
a devm_action() call to keep the ordering clean wrt to probe vs remove().

> +	/* Cancel any work that has been queued */
> +	cancel_delayed_work_sync(&hisi_ptt->work);
> +
>  	if (hisi_ptt->trace_ctrl.status == HISI_PTT_TRACE_STATUS_ON)
>  		hisi_ptt_trace_end(hisi_ptt);
>  

...

