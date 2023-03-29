Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A74D6CD9A4
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 14:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjC2MwQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 08:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjC2MwP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 08:52:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22635F4;
        Wed, 29 Mar 2023 05:52:08 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PmmbV20k2zKwQ9;
        Wed, 29 Mar 2023 20:49:42 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 20:52:05 +0800
CC:     <yangyicong@hisilicon.com>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH 2/4] hwtracing: hisi_ptt: Add support for dynamically
 updating the filter list
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20230315094316.26772-1-yangyicong@huawei.com>
 <20230315094316.26772-3-yangyicong@huawei.com>
 <20230328175153.00002938@Huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <d22fd364-bff3-0ece-ad53-1d6f910f9f52@huawei.com>
Date:   Wed, 29 Mar 2023 20:52:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230328175153.00002938@Huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/3/29 0:51, Jonathan Cameron wrote:
> On Wed, 15 Mar 2023 17:43:14 +0800
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
>> ---
> 
> Just a few trivial comments on this.
> 
> With those tidied up
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for the comment, will fix in next version.

> 
> 
> 
> ...
> 
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>> index 0a10c7ec46ad..010cdbc3c172 100644
>> --- a/drivers/hwtracing/ptt/hisi_ptt.c
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> 
>> +/*
>> + * A PCI bus notifier is used here for dynamically updating the filter
>> + * list.
>> + */
>> +static int hisi_ptt_notifier_call(struct notifier_block *nb, unsigned long action,
>> +				  void *data)
>> +{
>> +	struct hisi_ptt *hisi_ptt = container_of(nb, struct hisi_ptt, hisi_ptt_nb);
>> +	struct hisi_ptt_filter_update_info info;
>> +	struct device *dev = data;
>> +	struct pci_dev *pdev = to_pci_dev(dev);
> 
> This local variable doesn't add anything over
> 
> 	info.pdev = to_pci_dev(dev);
> 

ok, will drop it.

> 
> 
>> +
>> +	info.pdev = pdev;
>> +
>> +	switch (action) {
>> +	case BUS_NOTIFY_ADD_DEVICE:
>> +		info.is_add = true;
>> +		break;
>> +	case BUS_NOTIFY_DEL_DEVICE:
>> +		info.is_add = false;
>> +		break;
>> +	default:
>> +		return 0;
>> +	}
>> +
>> +	hisi_ptt_update_fifo_in(hisi_ptt, &info);
>> +
>> +	return 0;
>> +}
>> +
> 
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
>> index 5beb1648c93a..b1ba638fe7ea 100644
>> --- a/drivers/hwtracing/ptt/hisi_ptt.h
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.h
>> @@ -11,12 +11,15 @@
> 
>>  /**
>>   * struct hisi_ptt_pmu_buf - Descriptor of the AUX buffer of PTT trace
>>   * @length:   size of the AUX buffer
>> @@ -170,10 +188,15 @@ struct hisi_ptt_pmu_buf {
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
> 
> Docs update for this one?
> 

sorry for missing this. will fix.

Thanks,
Yicong

>>  	struct hlist_node hotplug_node;
>>  	struct pmu hisi_ptt_pmu;
>>  	void __iomem *iobase;
>> @@ -192,7 +215,19 @@ struct hisi_ptt {
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
