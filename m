Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481B06CD9B3
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 14:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjC2Mya (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 08:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2My3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 08:54:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4A6BA;
        Wed, 29 Mar 2023 05:54:28 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PmmfC0yY6zKwRQ;
        Wed, 29 Mar 2023 20:52:03 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 20:54:26 +0800
CC:     <yangyicong@hisilicon.com>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH 3/4] hwtracing: hisi_ptt: Export available filters through
 sysfs
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20230315094316.26772-1-yangyicong@huawei.com>
 <20230315094316.26772-4-yangyicong@huawei.com>
 <20230328180234.00003421@Huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <08d5c43f-664c-457f-69a1-c6747bb56637@huawei.com>
Date:   Wed, 29 Mar 2023 20:54:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230328180234.00003421@Huawei.com>
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

On 2023/3/29 1:02, Jonathan Cameron wrote:
> On Wed, 15 Mar 2023 17:43:15 +0800
> Yicong Yang <yangyicong@huawei.com> wrote:
> 
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> The PTT can only filter the traced TLP headers by the Root Ports or the
>> Requester ID of the Endpoint, which are located on the same core of the
>> PTT device. The filter value used is derived from the BDF number of the
>> supported Root Port or the Endpoint. It's not friendly enough for the
>> users since it requires the user to be familiar enough with the platform
>> and calculate the filter value manually.
>>
>> This patch export the available filters through sysfs. Each available
>> filters is presented as an individual file with the name of the BDF
>> number of the related PCIe device. The files are created under
>> $(PTT PMU dir)/available_root_port_filters and
>> $(PTT PMU dir)/available_requester_filters respectively. The filter
>> value can be known by reading the related file.
>>
>> Then the users can easily know the available filters for trace and get
>> the filter values without calculating.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> Trivial comments only inline.
> 
> With those answered / tidied up.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>> index 010cdbc3c172..a5cd87edb813 100644
>> --- a/drivers/hwtracing/ptt/hisi_ptt.c
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> 
> 
>>
>> +
>> +static int hisi_ptt_init_filter_attributes(struct hisi_ptt *hisi_ptt)
>> +{
>> +	struct hisi_ptt_filter_desc *filter;
>> +	int ret;
>> +
>> +	mutex_lock(&hisi_ptt->filter_lock);
>> +
>> +	list_for_each_entry(filter, &hisi_ptt->port_filters, list) {
>> +		ret = hisi_ptt_create_filter_attr(hisi_ptt, filter);
>> +		if (ret)
>> +			goto err;
>> +	}
>> +
>> +	list_for_each_entry(filter, &hisi_ptt->req_filters, list) {
>> +		ret = hisi_ptt_create_filter_attr(hisi_ptt, filter);
>> +		if (ret)
>> +			goto err;
>> +	}
>> +
>> +	ret = devm_add_action_or_reset(&hisi_ptt->pdev->dev,
>> +				       hisi_ptt_remove_all_filter_attributes,
>> +				       hisi_ptt);
>> +	if (ret)
>> +		goto err;
>> +
>> +	hisi_ptt->sysfs_inited = true;
> 
> err:
> 
>> +	mutex_unlock(&hisi_ptt->filter_lock);
> 
> 	return ret;
> 
> No need for separate exit block when nothing to do but unlock.
> 

ok. will refine here.

>> +	return 0;
>> +err:
>> +	mutex_unlock(&hisi_ptt->filter_lock);
>> +	return ret;
>> +}
>> +
>>  static void hisi_ptt_update_filters(struct work_struct *work)
>>  {
>>  	struct delayed_work *delayed_work = to_delayed_work(work);
>> @@ -384,8 +517,28 @@ static void hisi_ptt_update_filters(struct work_struct *work)
>>  				continue;
>>  			}
>>  
>> +			filter->name = kstrdup(pci_name(info.pdev), GFP_KERNEL);
>> +			if (!filter->name) {
>> +				pci_err(hisi_ptt->pdev, "failed to add filter %s\n",
>> +					pci_name(info.pdev));
>> +				kfree(filter);
>> +				continue;
>> +			}
>> +
>>  			filter->devid = devid;
>>  			filter->is_port = is_port;
>> +
>> +			/*
>> +			 * If filters' sysfs entries hasn't been initialized, then
>> +			 * we're still at probe stage and leave it to handled by
>> +			 * others.
>> +			 */
>> +			if (hisi_ptt->sysfs_inited &&
> 
> Can we move this sysfs_inited check earlier? Seems silly to leave a simple check
> like that so late.
> 

maybe move it into the hisi_ptt_create_filter_attr()? will have a check.
for here we still need to update filter list even if the hisi_ptt's sysfs is not
initialized yet.

>> +			    hisi_ptt_create_filter_attr(hisi_ptt, filter)) {
>> +				kfree(filter);
>> +				continue;
>> +			}
>> +
>>  			list_add_tail(&filter->list, target_list);
>>  
>>  			if (is_port)
>> @@ -394,6 +547,11 @@ static void hisi_ptt_update_filters(struct work_struct *work)
>>  			list_for_each_entry(filter, target_list, list)
>>  				if (filter->devid == devid) {
>>  					list_del(&filter->list);
>> +
>> +					if (hisi_ptt->sysfs_inited)
>> +						hisi_ptt_remove_filter_attr(hisi_ptt, filter);
>> +
>> +					kfree(filter->name);
>>  					kfree(filter);
>>  					break;
>>  				}
>> @@ -486,10 +644,12 @@ static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
>>  	 * through the log. Other functions of PTT device are still available.
>>  	 */
>>  	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
>> -	if (!filter) {
>> -		pci_err(hisi_ptt->pdev, "failed to add filter %s\n", pci_name(pdev));
>> -		return -ENOMEM;
>> -	}
>> +	if (!filter)
>> +		goto err_mem;
>> +
>> +	filter->name = kstrdup(pci_name(pdev), GFP_KERNEL);
>> +	if (!filter->name)
>> +		goto err_name;
>>  
>>  	filter->devid = PCI_DEVID(pdev->bus->number, pdev->devfn);
>>  
>> @@ -504,6 +664,11 @@ static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
>>  	}
>>  
>>  	return 0;
>> +err_name:
>> +	kfree(filter);
>> +err_mem:
>> +	pci_err(hisi_ptt->pdev, "failed to add filter %s\n", pci_name(pdev));
> 
> I'd rather see a message for each of the error paths so we have some information on why.
> Original message wasn't great for this obviously and perhaps given they are both allocation
> errors it's not worth splitting them up.
> 

ok, will try to split it and make it more verbosely.

Thanks,
Yicong

>> +	return -ENOMEM;
>>  }
> 
> 
> .
> 
