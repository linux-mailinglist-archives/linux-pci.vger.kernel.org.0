Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBC5F10E22C
	for <lists+linux-pci@lfdr.de>; Sun,  1 Dec 2019 15:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfLAO30 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Dec 2019 09:29:26 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9539 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfLAO30 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Dec 2019 09:29:26 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de3ce470000>; Sun, 01 Dec 2019 06:29:27 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 01 Dec 2019 06:29:23 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 01 Dec 2019 06:29:23 -0800
Received: from [10.25.74.138] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 1 Dec
 2019 14:29:19 +0000
Subject: Re: [PATCH 4/4] PCI: pci-epf-test: Add support to defer core
 initialization
To:     Kishon Vijay Abraham I <kishon@ti.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <lorenzo.pieralisi@arm.com>,
        <andrew.murray@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20191113090851.26345-1-vidyas@nvidia.com>
 <20191113090851.26345-5-vidyas@nvidia.com>
 <e8e3b8b6-d115-b4d4-19c5-1eae1d8abd0f@ti.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <958fcc14-6794-0328-5c31-0dcc845ee646@nvidia.com>
Date:   Sun, 1 Dec 2019 19:59:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e8e3b8b6-d115-b4d4-19c5-1eae1d8abd0f@ti.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575210567; bh=R0xGxFOdur+CeguObMrwAo1cQvjZeJSyyOUZLz2IAp0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dZNGqzai/FKSRFv8UH3CuHk1nRWfvN7yIamCZKISnik8dmv8VuX5VPInG3vdGy4i9
         Bapq+hTPVusDffht2ne+7hhkSljxEf5MT9279o1UNDDTECzQAEWVH0A6Ln83AJJ7tC
         QtWinDl+cwEW9cWeVyM5Dd/C042gmgP8sagWCu/YNtOWkre9mHlr4bN/AoGQnzwJiC
         zoJmsPz4wtOp+tbNV+nNwB6MoIdi3bn2+XrTOaG/bFYa9dpzLZS4anMsdKYI8XE5uj
         iHaTp5rTiV6y50xgN5QyEaID0/ntwDw6I8dtH1eFHsxEjrXg2UXB1jskdMfr4msUYu
         8036bE/qaF6DQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/27/2019 2:50 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 13/11/19 2:38 PM, Vidya Sagar wrote:
>> Add support to defer core initialization and to receive a notifier
>> when core is ready to accommodate platforms where core is not for
>> initialization untile reference clock from host is available.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   drivers/pci/endpoint/functions/pci-epf-test.c | 114 ++++++++++++------
>>   1 file changed, 77 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>> index bddff15052cc..068024fab544 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -360,18 +360,6 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>>   			   msecs_to_jiffies(1));
>>   }
>>   
>> -static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
>> -				 void *data)
>> -{
>> -	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
>> -	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>> -
>> -	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
>> -			   msecs_to_jiffies(1));
>> -
>> -	return NOTIFY_OK;
>> -}
>> -
>>   static void pci_epf_test_unbind(struct pci_epf *epf)
>>   {
>>   	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>> @@ -428,6 +416,78 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>>   	return 0;
>>   }
>>   
>> +static int pci_epf_test_core_init(struct pci_epf *epf)
>> +{
>> +	struct pci_epf_header *header = epf->header;
>> +	const struct pci_epc_features *epc_features;
>> +	struct pci_epc *epc = epf->epc;
>> +	struct device *dev = &epf->dev;
>> +	bool msix_capable = false;
>> +	bool msi_capable = true;
>> +	int ret;
>> +
>> +	epc_features = pci_epc_get_features(epc, epf->func_no);
>> +	if (epc_features) {
>> +		msix_capable = epc_features->msix_capable;
>> +		msi_capable = epc_features->msi_capable;
>> +	}
>> +
>> +	ret = pci_epc_write_header(epc, epf->func_no, header);
>> +	if (ret) {
>> +		dev_err(dev, "Configuration header write failed\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = pci_epf_test_set_bar(epf);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (msi_capable) {
>> +		ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
>> +		if (ret) {
>> +			dev_err(dev, "MSI configuration failed\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	if (msix_capable) {
>> +		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
>> +		if (ret) {
>> +			dev_err(dev, "MSI-X configuration failed\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
>> +				 void *data)
>> +{
>> +	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
>> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>> +	int ret;
>> +
>> +	switch (val) {
>> +	case CORE_INIT:
>> +		ret = pci_epf_test_core_init(epf);
>> +		if (ret)
>> +			return NOTIFY_BAD;
>> +		break;
>> +
>> +	case LINK_UP:
>> +		queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
>> +				   msecs_to_jiffies(1));
>> +		break;
>> +
>> +	default:
>> +		dev_err(&epf->dev, "Invalid EPF test notifier event\n");
>> +		return NOTIFY_BAD;
>> +	}
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>>   static int pci_epf_test_alloc_space(struct pci_epf *epf)
>>   {
>>   	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>> @@ -496,12 +556,11 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>   {
>>   	int ret;
>>   	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>> -	struct pci_epf_header *header = epf->header;
>>   	const struct pci_epc_features *epc_features;
>>   	enum pci_barno test_reg_bar = BAR_0;
>>   	struct pci_epc *epc = epf->epc;
>> -	struct device *dev = &epf->dev;
>>   	bool linkup_notifier = false;
>> +	bool skip_core_init = false;
>>   	bool msix_capable = false;
>>   	bool msi_capable = true;
>>   
>> @@ -511,6 +570,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>   	epc_features = pci_epc_get_features(epc, epf->func_no);
>>   	if (epc_features) {
>>   		linkup_notifier = epc_features->linkup_notifier;
>> +		skip_core_init = epc_features->skip_core_init;
>>   		msix_capable = epc_features->msix_capable;
>>   		msi_capable = epc_features->msi_capable;
> 
> Are these used anywhere in this function?
Nope. I'll remove them.

>>   		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
>> @@ -520,34 +580,14 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>   	epf_test->test_reg_bar = test_reg_bar;
>>   	epf_test->epc_features = epc_features;
>>   
>> -	ret = pci_epc_write_header(epc, epf->func_no, header);
>> -	if (ret) {
>> -		dev_err(dev, "Configuration header write failed\n");
>> -		return ret;
>> -	}
>> -
>>   	ret = pci_epf_test_alloc_space(epf);
>>   	if (ret)
>>   		return ret;
>>   
>> -	ret = pci_epf_test_set_bar(epf);
>> -	if (ret)
>> -		return ret;
>> -
>> -	if (msi_capable) {
>> -		ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
>> -		if (ret) {
>> -			dev_err(dev, "MSI configuration failed\n");
>> -			return ret;
>> -		}
>> -	}
>> -
>> -	if (msix_capable) {
>> -		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
>> -		if (ret) {
>> -			dev_err(dev, "MSI-X configuration failed\n");
>> +	if (!skip_core_init) {
>> +		ret = pci_epf_test_core_init(epf);
>> +		if (ret)
>>   			return ret;
>> -		}
>>   	}
>>   
>>   	if (linkup_notifier) {
> 
> This could as well be moved to pci_epf_test_core_init().
Yes, but I would like to keep only the code that touches hardware in pci_epf_test_core_init()
to minimize the time it takes to execute it. Is there any strong reason to move it? if not,
I would prefer to leave it here in this function itself.

> 
> Thanks
> Kishon
> 

