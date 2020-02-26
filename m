Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEFCE16FE84
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 12:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgBZL7f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 06:59:35 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1069 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgBZL7e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2020 06:59:34 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e565d970000>; Wed, 26 Feb 2020 03:59:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 26 Feb 2020 03:59:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 26 Feb 2020 03:59:32 -0800
Received: from [10.25.74.250] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 26 Feb
 2020 11:59:28 +0000
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
 <ac537e94-7ec8-de61-322a-8a8c7ff48ac5@nvidia.com>
 <20200226100749.GA13197@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <ad4eb93b-0c99-42f8-d1ee-3e5513b9be0a@nvidia.com>
Date:   Wed, 26 Feb 2020 17:29:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200226100749.GA13197@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582718359; bh=ATXt1WS4GNEvZyxJqERlqZmbCuP69KF1XDahM/zOBOA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=nEMzr1EI2esFJmbzUY+7K4QW8obtsb1d/9DM91uPJK/uKxXQNtd6vY1tL0Wop9clg
         jecwP6OyCgdfkMX/sBjhHYAJjwkmTuGctAvgJxme6+dhuOM38JJBMTVGJBpJoOp3l4
         79pa/S6h6L7ClkKT036sXC6lozMpae0+pcmX4x+CYR+e+r2C16DJ16x4rzUzL8cICa
         UXnUcPEWnaE7W8UK7CVvziwfEQSpT7u3r7I7upQCyLsvgrRWZdueQ0g2qpcyDc/WXf
         W5qLSB53Wj/ACa9ybnrLI4qlMkXZ/WrzOYLx2pK6TR0685s4YUi5baFXxoHtXrIgNH
         PrA9VLVMu3MGw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/26/2020 3:37 PM, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Feb 25, 2020 at 11:43:07PM +0530, Vidya Sagar wrote:
>>
>>
>> On 2/25/2020 5:38 PM, Lorenzo Pieralisi wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Mon, Feb 17, 2020 at 05:40:36PM +0530, Vidya Sagar wrote:
>>>> Add support to defer core initialization and to receive a notifier
>>>> when core is ready to accommodate platforms where core is not for
>>>> initialization untile reference clock from host is available.
>>>
>>> I don't understand this commit log, please reword it and fix
>>> the typos, I would merge it then, thanks.
>> Would the following be ok?
>>
>> Add support to defer DWC core initialization for the endpoint mode of
> 
> I removed "DWC" since this is not what this patch is actually doing.
> 
>> operation. Initialization would resume based on the notifier
>> mechanism. This would enable support for implementations like Tegra194
>> for endpoint mode operation, where the core initialization needs to be
>> deferred until the PCIe reference clock is available from the host
>> system.
>>
>> If it is ok, I'll send new patch series with this commit log.
> 
> No need, merged in pci/endpoint for v5.7, thanks.
Thanks,
Vidya Sagar

> 
> Lorenzo
> 
>> Thanks,
>> Vidya Sagar
>>>
>>> Lorenzo
>>>
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>> V3:
>>>> * Added Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>>
>>>> V2:
>>>> * Addressed review comments from Kishon
>>>>
>>>>    drivers/pci/endpoint/functions/pci-epf-test.c | 118 ++++++++++++------
>>>>    1 file changed, 77 insertions(+), 41 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>>>> index bddff15052cc..be04c6220265 100644
>>>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>>>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>>>> @@ -360,18 +360,6 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>>>>                            msecs_to_jiffies(1));
>>>>    }
>>>>
>>>> -static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
>>>> -                              void *data)
>>>> -{
>>>> -     struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
>>>> -     struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>>>> -
>>>> -     queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
>>>> -                        msecs_to_jiffies(1));
>>>> -
>>>> -     return NOTIFY_OK;
>>>> -}
>>>> -
>>>>    static void pci_epf_test_unbind(struct pci_epf *epf)
>>>>    {
>>>>         struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>>>> @@ -428,6 +416,78 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>>>>         return 0;
>>>>    }
>>>>
>>>> +static int pci_epf_test_core_init(struct pci_epf *epf)
>>>> +{
>>>> +     struct pci_epf_header *header = epf->header;
>>>> +     const struct pci_epc_features *epc_features;
>>>> +     struct pci_epc *epc = epf->epc;
>>>> +     struct device *dev = &epf->dev;
>>>> +     bool msix_capable = false;
>>>> +     bool msi_capable = true;
>>>> +     int ret;
>>>> +
>>>> +     epc_features = pci_epc_get_features(epc, epf->func_no);
>>>> +     if (epc_features) {
>>>> +             msix_capable = epc_features->msix_capable;
>>>> +             msi_capable = epc_features->msi_capable;
>>>> +     }
>>>> +
>>>> +     ret = pci_epc_write_header(epc, epf->func_no, header);
>>>> +     if (ret) {
>>>> +             dev_err(dev, "Configuration header write failed\n");
>>>> +             return ret;
>>>> +     }
>>>> +
>>>> +     ret = pci_epf_test_set_bar(epf);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     if (msi_capable) {
>>>> +             ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
>>>> +             if (ret) {
>>>> +                     dev_err(dev, "MSI configuration failed\n");
>>>> +                     return ret;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     if (msix_capable) {
>>>> +             ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
>>>> +             if (ret) {
>>>> +                     dev_err(dev, "MSI-X configuration failed\n");
>>>> +                     return ret;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
>>>> +                              void *data)
>>>> +{
>>>> +     struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
>>>> +     struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>>>> +     int ret;
>>>> +
>>>> +     switch (val) {
>>>> +     case CORE_INIT:
>>>> +             ret = pci_epf_test_core_init(epf);
>>>> +             if (ret)
>>>> +                     return NOTIFY_BAD;
>>>> +             break;
>>>> +
>>>> +     case LINK_UP:
>>>> +             queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
>>>> +                                msecs_to_jiffies(1));
>>>> +             break;
>>>> +
>>>> +     default:
>>>> +             dev_err(&epf->dev, "Invalid EPF test notifier event\n");
>>>> +             return NOTIFY_BAD;
>>>> +     }
>>>> +
>>>> +     return NOTIFY_OK;
>>>> +}
>>>> +
>>>>    static int pci_epf_test_alloc_space(struct pci_epf *epf)
>>>>    {
>>>>         struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>>>> @@ -496,14 +556,11 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>>>    {
>>>>         int ret;
>>>>         struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>>>> -     struct pci_epf_header *header = epf->header;
>>>>         const struct pci_epc_features *epc_features;
>>>>         enum pci_barno test_reg_bar = BAR_0;
>>>>         struct pci_epc *epc = epf->epc;
>>>> -     struct device *dev = &epf->dev;
>>>>         bool linkup_notifier = false;
>>>> -     bool msix_capable = false;
>>>> -     bool msi_capable = true;
>>>> +     bool core_init_notifier = false;
>>>>
>>>>         if (WARN_ON_ONCE(!epc))
>>>>                 return -EINVAL;
>>>> @@ -511,8 +568,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>>>         epc_features = pci_epc_get_features(epc, epf->func_no);
>>>>         if (epc_features) {
>>>>                 linkup_notifier = epc_features->linkup_notifier;
>>>> -             msix_capable = epc_features->msix_capable;
>>>> -             msi_capable = epc_features->msi_capable;
>>>> +             core_init_notifier = epc_features->core_init_notifier;
>>>>                 test_reg_bar = pci_epc_get_first_free_bar(epc_features);
>>>>                 pci_epf_configure_bar(epf, epc_features);
>>>>         }
>>>> @@ -520,34 +576,14 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>>>         epf_test->test_reg_bar = test_reg_bar;
>>>>         epf_test->epc_features = epc_features;
>>>>
>>>> -     ret = pci_epc_write_header(epc, epf->func_no, header);
>>>> -     if (ret) {
>>>> -             dev_err(dev, "Configuration header write failed\n");
>>>> -             return ret;
>>>> -     }
>>>> -
>>>>         ret = pci_epf_test_alloc_space(epf);
>>>>         if (ret)
>>>>                 return ret;
>>>>
>>>> -     ret = pci_epf_test_set_bar(epf);
>>>> -     if (ret)
>>>> -             return ret;
>>>> -
>>>> -     if (msi_capable) {
>>>> -             ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
>>>> -             if (ret) {
>>>> -                     dev_err(dev, "MSI configuration failed\n");
>>>> -                     return ret;
>>>> -             }
>>>> -     }
>>>> -
>>>> -     if (msix_capable) {
>>>> -             ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
>>>> -             if (ret) {
>>>> -                     dev_err(dev, "MSI-X configuration failed\n");
>>>> +     if (!core_init_notifier) {
>>>> +             ret = pci_epf_test_core_init(epf);
>>>> +             if (ret)
>>>>                         return ret;
>>>> -             }
>>>>         }
>>>>
>>>>         if (linkup_notifier) {
>>>> --
>>>> 2.17.1
>>>>
