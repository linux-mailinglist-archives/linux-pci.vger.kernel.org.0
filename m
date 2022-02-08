Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDFE4AD265
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 08:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348508AbiBHHlo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 02:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237648AbiBHHlo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 02:41:44 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CF6C0401EF;
        Mon,  7 Feb 2022 23:41:42 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JtFKz0d97zbkH2;
        Tue,  8 Feb 2022 15:40:39 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 15:41:38 +0800
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
Subject: Re: [PATCH v3 2/8] hisi_ptt: Register PMU device for PTT trace
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-3-yangyicong@hisilicon.com>
 <20220207114228.00002e6f@Huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <b3bf3968-870b-dd93-56c2-2d2e001c2f38@huawei.com>
Date:   Tue, 8 Feb 2022 15:41:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220207114228.00002e6f@Huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/2/7 19:42, Jonathan Cameron wrote:
> On Mon, 24 Jan 2022 21:11:12 +0800
> Yicong Yang <yangyicong@hisilicon.com> wrote:
> 
>> Register PMU device of PTT trace, then users can use
>> trace through perf command. The driver makes use of perf
>> AUX trace and support following events to configure the
>> trace:
>>
>> - filter: select Root port or Endpoint to trace
>> - type: select the type of traced TLP headers
>> - direction: select the direction of traced TLP headers
>> - format: select the data format of the traced TLP headers
>>
>> This patch adds the PMU driver part of PTT trace. The perf
>> command support of PTT trace is added in the following
>> patch.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
> 
> 
>> @@ -294,6 +346,405 @@ static void hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
>>  	hisi_ptt->trace_ctrl.default_cpu = cpumask_first(cpumask_of_node(dev_to_node(&pdev->dev)));
>>  }
>>  
>> +#define HISI_PTT_PMU_FILTER_IS_PORT	BIT(19)
>> +#define HISI_PTT_PMU_FILTER_VAL_MASK	GENMASK(15, 0)
>> +#define HISI_PTT_PMU_DIRECTION_MASK	GENMASK(23, 20)
>> +#define HISI_PTT_PMU_TYPE_MASK		GENMASK(31, 24)
>> +#define HISI_PTT_PMU_FORMAT_MASK	GENMASK(35, 32)
>> +
>> +static ssize_t available_filters_show(struct device *dev,
>> +				      struct device_attribute *attr,
>> +				      char *buf)
>> +{
>> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
>> +	struct hisi_ptt_filter_desc *filter;
>> +	int pos = 0;
>> +
>> +	if (list_empty(&hisi_ptt->port_filters))
>> +		return sysfs_emit(buf, "#### No available filter ####\n");
>> +
> 
> This is a very unusual sysfs attribute.
> They are supposed to be one "thing" per file, so I'd have expected this to
> be at least two files
> 
> root_ports_available_filters
> request_available_filters
> and no available filter is indicated by these attribute returning an empty
> string.
> 

Split it makes sense to me as indeed we're maintaining two list for root ports
and requester each. but perhaps below names are better?

available_root_port_filters
available_requester_filters

And feels we don't need the titles if we split it into two files, so it'll be like
$ cat available_root_port_filters
0000:00:10.0	0x80001
0000:00:11.0	0x80004
$ cat available_requester_filters
0000:01:00.0	0x00100
0000:01:00.1	0x00101

It's also better for script I think.

> However you need to match convention for hwtracing drivers so if
> this is common approach perhaps you could point me to a similar
> example? My grep skills didn't find me one.
> 
>> +	mutex_lock(&hisi_ptt->mutex);
>> +	pos += sysfs_emit_at(buf, pos, "#### Root Ports ####\n");
>> +	list_for_each_entry(filter, &hisi_ptt->port_filters, list)
>> +		pos += sysfs_emit_at(buf, pos, "%s	0x%05lx\n",
>> +				     pci_name(filter->pdev),
>> +				     hisi_ptt_get_filter_val(filter->pdev) |
>> +				     HISI_PTT_PMU_FILTER_IS_PORT);
>> +
>> +	pos += sysfs_emit_at(buf, pos, "#### Requesters ####\n");
>> +	list_for_each_entry(filter, &hisi_ptt->req_filters, list)
>> +		pos += sysfs_emit_at(buf, pos, "%s	0x%05x\n",
>> +				     pci_name(filter->pdev),
>> +				     hisi_ptt_get_filter_val(filter->pdev));
>> +
>> +	mutex_unlock(&hisi_ptt->mutex);
>> +	return pos;
>> +}
>> +static DEVICE_ATTR_ADMIN_RO(available_filters);
>> +
> 
> ...
> 
> 
>> +static int hisi_ptt_trace_valid_config_onehot(u32 val, u32 *available_list, u32 list_size)
>> +{
>> +	int i, ret = -EINVAL;
>> +
>> +	for (i = 0; i < list_size; i++)
>> +		if (val == available_list[i]) {
>> +			ret = 0;
> 
> return 0;
> 

ok.

>> +			break;
>> +		}
>> +
>> +	return ret;
> 
> return -EINVAL;

ok.

> 
>> +}
>> +
> 
>> +
>> +static void hisi_ptt_pmu_free_aux(void *aux)
>> +{
>> +	struct hisi_ptt_pmu_buf *buf = aux;
>> +
>> +	vunmap(buf->base);
>> +	kfree(buf);
>> +}
>> +
> 
> 
> ...
> 
>> +static int hisi_ptt_pmu_add(struct perf_event *event, int flags)
>> +{
>> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	int cpu = event->cpu;
>> +
>> +	if (cpu == -1 && smp_processor_id() != hisi_ptt->trace_ctrl.default_cpu)
> 
> This check is not entirely obvious to me. Perhaps a comment would help
> readers understand why this condition is successful, but doesn't involve
> actually starting the pmu?
> 

Not sure I describe it correct and accurate. A perf session will add and start event on
each cpu, or only a range of cpus if user specified it by -C parameter of perf.
This information is passed to the PMU driver by the event->cpu, -1 indicates that user
didn't specify the cpu. This function will be called on every cpu or cpus specified by
the user.

Since we're not tracing CPUs and we don't need every cpu to start the trace, we add the
check here to only allow the event on the default cpu to start the trace. Other cpus
will just return. The default cpu is the 1st cpu of the NUMA nodes the PTT device locates.

>> +		return 0;
>> +
>> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
>> +
>> +	if (flags & PERF_EF_START) {
>> +		hisi_ptt_pmu_start(event, PERF_EF_RELOAD);
>> +		if (hwc->state & PERF_HES_STOPPED)
>> +			return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>>  /*
>>   * The DMA of PTT trace can only use direct mapping, due to some
>>   * hardware restriction. Check whether there is an iommu or the
>> @@ -359,6 +810,12 @@ static int hisi_ptt_probe(struct pci_dev *pdev,
>>  
>>  	hisi_ptt_init_ctrls(hisi_ptt);
>>  
>> +	ret = hisi_ptt_register_pmu(hisi_ptt);
>> +	if (ret) {
>> +		pci_err(pdev, "failed to register pmu device, ret = %d", ret);
> 
> Given I think this exposes userspace interfaces, it should be the very
> last thing done in probe(). Otherwise we have a race condition (at least in
> theory) where someone starts using it before we then fail the iommu mapping check.
> 

thanks for catching this. I think it'll be a problem and I'll get the iommu mapping check
in advance.

Thanks.

> 
>> +		return ret;
>> +	}
>> +
>>  	ret = hisi_ptt_check_iommu_mapping(hisi_ptt);
>>  	if (ret) {
>>  		pci_err(pdev, "cannot work with non-direct DMA mapping.\n");
> 
> Thanks,
> 
> Jonathan
> 
> .
> 
