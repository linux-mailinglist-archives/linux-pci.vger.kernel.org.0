Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D945F724101
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 13:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbjFFLf3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 07:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbjFFLf3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 07:35:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64262E47;
        Tue,  6 Jun 2023 04:35:25 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qb7cP2yyJzLqTL;
        Tue,  6 Jun 2023 19:32:21 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 19:35:23 +0800
Subject: Re: [PATCH v3 2/4] hwtracing: hisi_ptt: Add support for dynamically
 updating the filter list
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <alexander.shishkin@linux.intel.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>, Yicong Yang <yangyicong@huawei.com>,
        <yangyicong@hisilicon.com>
References: <20230523093228.48149-1-yangyicong@huawei.com>
 <20230523093228.48149-3-yangyicong@huawei.com>
 <20230606105655.00006d92@Huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <f6c80e50-d78e-e34a-be6b-7fd20c48a59f@huawei.com>
Date:   Tue, 6 Jun 2023 19:35:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230606105655.00006d92@Huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/6/6 17:56, Jonathan Cameron wrote:
> On Tue, 23 May 2023 17:32:26 +0800
> Yicong Yang <yangyicong@huawei.com> wrote:
> 
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> The PCIe devices supported by the PTT trace can be removed/rescanned by
>> hotplug or through sysfs.  Add support for dynamically updating the
>> available filter list by registering a PCI bus notifier block. Then user
>> can always get latest information about available tracing filters and
>> driver can block the invalid filters of which related devices no longer
>> exist in the system.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Hi Yangyicong,
> 
> A few comments inline

Thanks for the comments! Will fix them up in next version.

> 
> Jonathan
> 
>> ---
>>  Documentation/trace/hisi-ptt.rst |   6 +-
>>  drivers/hwtracing/ptt/hisi_ptt.c | 165 +++++++++++++++++++++++++++++--
>>  drivers/hwtracing/ptt/hisi_ptt.h |  39 ++++++++
>>  3 files changed, 201 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-ptt.rst
>> index 4f87d8e21065..3641aca4287a 100644
>> --- a/Documentation/trace/hisi-ptt.rst
>> +++ b/Documentation/trace/hisi-ptt.rst
>> @@ -153,9 +153,9 @@ Endpoint function can be specified in one trace. Specifying both Root Port
>>  and function at the same time is not supported. Driver maintains a list of
>>  available filters and will check the invalid inputs.
>>  
>> -Currently the available filters are detected in driver's probe. If the supported
>> -devices are removed/added after probe, you may need to reload the driver to update
>> -the filters.
>> +The available filters will be dynamically updates, which means you will always
> 
> updated, 
> 
>> +get correct filter information when hotplug events happen, or when you manually
>> +remove/rescan the devices.
>>  
>>  2. Type
>>  -------
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>> index 548cfef51ace..9b4acbc434b0 100644
>> --- a/drivers/hwtracing/ptt/hisi_ptt.c
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
>> @@ -357,24 +357,41 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
> 
> ...
> 
>>  static struct hisi_ptt_filter_desc *
>> -hisi_ptt_alloc_add_filter(struct hisi_ptt *hisi_ptt, struct pci_dev *pdev)
>> +hisi_ptt_alloc_add_filter(struct hisi_ptt *hisi_ptt, u16 devid, bool is_port)
>>  {
>>  	struct hisi_ptt_filter_desc *filter;
>> +	u8 devfn = devid & 0xff;
>> +	char *filter_name;
>> +
>> +	filter_name = kasprintf(GFP_KERNEL, "%04x:%02x:%02x.%d", pci_domain_nr(hisi_ptt->pdev->bus),
>> +				 PCI_BUS_NUM(devid), PCI_SLOT(devfn), PCI_FUNC(devfn));
>> +	if (!filter_name) {
>> +		pci_err(hisi_ptt->pdev, "failed to allocate name for filter %s\n",
>> +			filter_name);
>> +		kfree(filter);
> 
> Don't think you've allocated filter yet.
> 
>> +		return NULL;
>> +	}
>>  
>>  	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
>>  	if (!filter) {
>>  		pci_err(hisi_ptt->pdev, "failed to add filter for %s\n",
>> -			pci_name(pdev));
>> +			filter_name);
>>  		return NULL;
>>  	}
>>  
>> -	filter->devid = PCI_DEVID(pdev->bus->number, pdev->devfn);
>> -	filter->is_port = pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT;
>> +	filter->name = filter_name;
>> +	filter->is_port = is_port;
>> +	filter->devid = devid;
>> +
>>  	if (filter->is_port) {
>>  		list_add_tail(&filter->list, &hisi_ptt->port_filters);
>>  
>> @@ -387,6 +404,102 @@ hisi_ptt_alloc_add_filter(struct hisi_ptt *hisi_ptt, struct pci_dev *pdev)
>>  	return filter;
>>  }
> 
> 
> 
> 
> ...
> 
>> @@ -633,14 +752,19 @@ static int hisi_ptt_trace_valid_filter(struct hisi_ptt *hisi_ptt, u64 config)
>>  	 * For Requester ID filters, walk the available filter list to see
>>  	 * whether we have one matched.
>>  	 */
>> +	mutex_lock(&hisi_ptt->filter_lock);
>>  	if (!hisi_ptt->trace_ctrl.is_port) {
>>  		list_for_each_entry(filter, &hisi_ptt->req_filters, list) {
>> -			if (val == hisi_ptt_get_filter_val(filter->devid, filter->is_port))
>> +			if (val == hisi_ptt_get_filter_val(filter->devid, filter->is_port)) {
>> +				mutex_unlock(&hisi_ptt->filter_lock);
> 
> Perhaps a single exit location makes more sense given we need to unlock in
> all paths?  goto unlock; etc
> 
>>  				return 0;
>> +			}
>>  		}
>>  	} else if (bitmap_subset(&val, &port_mask, BITS_PER_LONG)) {
>> +		mutex_unlock(&hisi_ptt->filter_lock);
>>  		return 0;
>>  	}
>> +	mutex_unlock(&hisi_ptt->filter_lock);
>>  
>>  	return -EINVAL;
>>  }
>> @@ -916,6 +1040,31 @@ static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
>>  					&hisi_ptt->hisi_ptt_pmu);
>>  }
> 
> 
> 
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
>> index 5beb1648c93a..d080b306af77 100644
>> --- a/drivers/hwtracing/ptt/hisi_ptt.h
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.h
> 
> ...
> 
>> @@ -161,6 +182,7 @@ struct hisi_ptt_pmu_buf {
>>   * struct hisi_ptt - Per PTT device data
>>   * @trace_ctrl:   the control information of PTT trace
>>   * @hotplug_node: node for register cpu hotplug event
>> + * @hisi_ptt_nb:  dynamic filter update notifier
> 
> Wrong location. Order should match the fields in the structure.
> So this belongs just above hotplug_node
> 
> 
>>   * @hisi_ptt_pmu: the pum device of trace
>>   * @iobase:       base IO address of the device
>>   * @pdev:         pci_dev of this PTT device
>> @@ -170,10 +192,15 @@ struct hisi_ptt_pmu_buf {
>>   * @lower_bdf:    the lower BDF range of the PCI devices managed by this PTT device
>>   * @port_filters: the filter list of root ports
>>   * @req_filters:  the filter list of requester ID
>> + * @filter_lock:  lock to protect the filters
>>   * @port_mask:    port mask of the managed root ports
>> + * @work:         delayed work for filter updating
>> + * @filter_update_lock: spinlock to protect the filter update fifo
>> + * @filter_update_fifo: fifo of the filters waiting to update the filter list
>>   */
>>  struct hisi_ptt {
>>  	struct hisi_ptt_trace_ctrl trace_ctrl;
>> +	struct notifier_block hisi_ptt_nb;
>>  	struct hlist_node hotplug_node;
>>  	struct pmu hisi_ptt_pmu;
>>  	void __iomem *iobase;
>> @@ -192,7 +219,19 @@ struct hisi_ptt {
>>  	 */
>>  	struct list_head port_filters;
>>  	struct list_head req_filters;
>> +	struct mutex filter_lock;
>>  	u16 port_mask;
>> +
>> +	/*
>> +	 * We use a delayed work here to avoid indefinitely waiting for
>> +	 * the hisi_ptt->mutex which protecting the filter list. The
>> +	 * work will be delayed only if the mutex can not be held,
>> +	 * otherwise no delay will be applied.
>> +	 */
>> +	struct delayed_work work;
>> +	spinlock_t filter_update_lock;
>> +	DECLARE_KFIFO(filter_update_kfifo, struct hisi_ptt_filter_update_info,
>> +		      HISI_PTT_FILTER_UPDATE_FIFO_SIZE);
>>  };
>>  
>>  #define to_hisi_ptt(pmu) container_of(pmu, struct hisi_ptt, hisi_ptt_pmu)
> 
> .
> 
