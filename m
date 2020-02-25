Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E09416ED99
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 19:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbgBYSNR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 13:13:17 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4863 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730017AbgBYSNR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 13:13:17 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e5563970000>; Tue, 25 Feb 2020 10:12:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 25 Feb 2020 10:13:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 25 Feb 2020 10:13:15 -0800
Received: from [10.25.74.250] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Feb
 2020 18:13:10 +0000
Subject: Re: [PATCH V3 5/5] PCI: pci-epf-test: Add support to defer core
 initialization
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <andrew.murray@arm.com>, <bhelgaas@google.com>, <kishon@ti.com>,
        <thierry.reding@gmail.com>, <Jisheng.Zhang@synaptics.com>,
        <jonathanh@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200217121036.3057-1-vidyas@nvidia.com>
 <20200217121036.3057-6-vidyas@nvidia.com>
 <20200225120832.GA7710@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <ac537e94-7ec8-de61-322a-8a8c7ff48ac5@nvidia.com>
Date:   Tue, 25 Feb 2020 23:43:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200225120832.GA7710@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582654359; bh=ZvETQ+ouytMuwblQdY1QXIne6U0B0F6861iyW2Xtjpk=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JXZDpSk9xsRyXzWcV+pE5k0m9WQB/RBlLM/7toUqg9ji5ApPVGzox9EToYPtMM1Gz
         eRxvIhKVLc0n+3Dh3Jl38+XKlJB6LdqlgRrPPTyfzWNsO4OzLxNo6sn+UNjQgO7j+8
         svl1y/kRfokdxA0ERwoxbKCRCazRBUy9dSBYXrkrpgLm2Pq4wEAsJxy36fEymC89rI
         0CNDx75T2vha1tunTc9zrDEDgxCneiYb6AwTFKCSHotuWB5eEhnr2mW5aSvfuLNFnW
         rKWp+fCkGq2+4lYuqdo+0eo5Ud+J9OBgYKcO3PXapOlU6mj4asAt0JniINqXbjCXvM
         82AO2sohHMIUA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/25/2020 5:38 PM, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Feb 17, 2020 at 05:40:36PM +0530, Vidya Sagar wrote:
>> Add support to defer core initialization and to receive a notifier
>> when core is ready to accommodate platforms where core is not for
>> initialization untile reference clock from host is available.
> 
> I don't understand this commit log, please reword it and fix
> the typos, I would merge it then, thanks.
Would the following be ok?

Add support to defer DWC core initialization for the endpoint mode of 
operation. Initialization would resume based on the notifier mechanism. 
This would enable support for implementations like Tegra194 for endpoint 
mode operation, where the core initialization needs to be deferred until 
the PCIe reference clock is available from the host system.

If it is ok, I'll send new patch series with this commit log.

Thanks,
Vidya Sagar
> 
> Lorenzo
> 
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>> V3:
>> * Added Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> V2:
>> * Addressed review comments from Kishon
>>
>>   drivers/pci/endpoint/functions/pci-epf-test.c | 118 ++++++++++++------
>>   1 file changed, 77 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>> index bddff15052cc..be04c6220265 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -360,18 +360,6 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>>                           msecs_to_jiffies(1));
>>   }
>>
>> -static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
>> -                              void *data)
>> -{
>> -     struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
>> -     struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>> -
>> -     queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
>> -                        msecs_to_jiffies(1));
>> -
>> -     return NOTIFY_OK;
>> -}
>> -
>>   static void pci_epf_test_unbind(struct pci_epf *epf)
>>   {
>>        struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>> @@ -428,6 +416,78 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>>        return 0;
>>   }
>>
>> +static int pci_epf_test_core_init(struct pci_epf *epf)
>> +{
>> +     struct pci_epf_header *header = epf->header;
>> +     const struct pci_epc_features *epc_features;
>> +     struct pci_epc *epc = epf->epc;
>> +     struct device *dev = &epf->dev;
>> +     bool msix_capable = false;
>> +     bool msi_capable = true;
>> +     int ret;
>> +
>> +     epc_features = pci_epc_get_features(epc, epf->func_no);
>> +     if (epc_features) {
>> +             msix_capable = epc_features->msix_capable;
>> +             msi_capable = epc_features->msi_capable;
>> +     }
>> +
>> +     ret = pci_epc_write_header(epc, epf->func_no, header);
>> +     if (ret) {
>> +             dev_err(dev, "Configuration header write failed\n");
>> +             return ret;
>> +     }
>> +
>> +     ret = pci_epf_test_set_bar(epf);
>> +     if (ret)
>> +             return ret;
>> +
>> +     if (msi_capable) {
>> +             ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
>> +             if (ret) {
>> +                     dev_err(dev, "MSI configuration failed\n");
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     if (msix_capable) {
>> +             ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
>> +             if (ret) {
>> +                     dev_err(dev, "MSI-X configuration failed\n");
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
>> +                              void *data)
>> +{
>> +     struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
>> +     struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>> +     int ret;
>> +
>> +     switch (val) {
>> +     case CORE_INIT:
>> +             ret = pci_epf_test_core_init(epf);
>> +             if (ret)
>> +                     return NOTIFY_BAD;
>> +             break;
>> +
>> +     case LINK_UP:
>> +             queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
>> +                                msecs_to_jiffies(1));
>> +             break;
>> +
>> +     default:
>> +             dev_err(&epf->dev, "Invalid EPF test notifier event\n");
>> +             return NOTIFY_BAD;
>> +     }
>> +
>> +     return NOTIFY_OK;
>> +}
>> +
>>   static int pci_epf_test_alloc_space(struct pci_epf *epf)
>>   {
>>        struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>> @@ -496,14 +556,11 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>   {
>>        int ret;
>>        struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>> -     struct pci_epf_header *header = epf->header;
>>        const struct pci_epc_features *epc_features;
>>        enum pci_barno test_reg_bar = BAR_0;
>>        struct pci_epc *epc = epf->epc;
>> -     struct device *dev = &epf->dev;
>>        bool linkup_notifier = false;
>> -     bool msix_capable = false;
>> -     bool msi_capable = true;
>> +     bool core_init_notifier = false;
>>
>>        if (WARN_ON_ONCE(!epc))
>>                return -EINVAL;
>> @@ -511,8 +568,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>        epc_features = pci_epc_get_features(epc, epf->func_no);
>>        if (epc_features) {
>>                linkup_notifier = epc_features->linkup_notifier;
>> -             msix_capable = epc_features->msix_capable;
>> -             msi_capable = epc_features->msi_capable;
>> +             core_init_notifier = epc_features->core_init_notifier;
>>                test_reg_bar = pci_epc_get_first_free_bar(epc_features);
>>                pci_epf_configure_bar(epf, epc_features);
>>        }
>> @@ -520,34 +576,14 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>        epf_test->test_reg_bar = test_reg_bar;
>>        epf_test->epc_features = epc_features;
>>
>> -     ret = pci_epc_write_header(epc, epf->func_no, header);
>> -     if (ret) {
>> -             dev_err(dev, "Configuration header write failed\n");
>> -             return ret;
>> -     }
>> -
>>        ret = pci_epf_test_alloc_space(epf);
>>        if (ret)
>>                return ret;
>>
>> -     ret = pci_epf_test_set_bar(epf);
>> -     if (ret)
>> -             return ret;
>> -
>> -     if (msi_capable) {
>> -             ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
>> -             if (ret) {
>> -                     dev_err(dev, "MSI configuration failed\n");
>> -                     return ret;
>> -             }
>> -     }
>> -
>> -     if (msix_capable) {
>> -             ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
>> -             if (ret) {
>> -                     dev_err(dev, "MSI-X configuration failed\n");
>> +     if (!core_init_notifier) {
>> +             ret = pci_epf_test_core_init(epf);
>> +             if (ret)
>>                        return ret;
>> -             }
>>        }
>>
>>        if (linkup_notifier) {
>> --
>> 2.17.1
>>
