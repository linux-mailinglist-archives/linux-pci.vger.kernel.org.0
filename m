Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D954114002
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2019 12:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfLELVH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Dec 2019 06:21:07 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59166 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfLELVH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2019 06:21:07 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB5BKuPh053390;
        Thu, 5 Dec 2019 05:20:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575544856;
        bh=Aw7GprFDO9w2I0bI/UyUztLL0uF3dC6VNrttSY25G0I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JXRGtTEAZypzaSt+YXgOJI8a2WTOBCJqsykWMh6s8TRMhUk400NPe7xm8HH2wr6vs
         rqqYhHkKIPcCIK93t6UUU5Db1L2VbpOLhgV8o7BL44R0/Bp/aa+wB48QRqQcfL9fe/
         Uy4HvVkmbbz6q54lLEaCaaIilMiOmx4p1NHGU0ck=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB5BKuK8086560;
        Thu, 5 Dec 2019 05:20:56 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Dec
 2019 05:20:56 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Dec 2019 05:20:56 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB5BKpxL102091;
        Thu, 5 Dec 2019 05:20:52 -0600
Subject: Re: [PATCH 4/4] PCI: pci-epf-test: Add support to defer core
 initialization
To:     Vidya Sagar <vidyas@nvidia.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <lorenzo.pieralisi@arm.com>,
        <andrew.murray@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20191113090851.26345-1-vidyas@nvidia.com>
 <20191113090851.26345-5-vidyas@nvidia.com>
 <e8e3b8b6-d115-b4d4-19c5-1eae1d8abd0f@ti.com>
 <958fcc14-6794-0328-5c31-0dcc845ee646@nvidia.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c7877f72-97e0-ac48-06c3-8e3ecec87cd5@ti.com>
Date:   Thu, 5 Dec 2019 16:52:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <958fcc14-6794-0328-5c31-0dcc845ee646@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 01/12/19 7:59 pm, Vidya Sagar wrote:
> On 11/27/2019 2:50 PM, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On 13/11/19 2:38 PM, Vidya Sagar wrote:
>>> Add support to defer core initialization and to receive a notifier
>>> when core is ready to accommodate platforms where core is not for
>>> initialization untile reference clock from host is available.
>>>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> ---
>>>   drivers/pci/endpoint/functions/pci-epf-test.c | 114 ++++++++++++------
>>>   1 file changed, 77 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c 
>>> b/drivers/pci/endpoint/functions/pci-epf-test.c
>>> index bddff15052cc..068024fab544 100644
>>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>>> @@ -360,18 +360,6 @@ static void pci_epf_test_cmd_handler(struct 
>>> work_struct *work)
>>>                  msecs_to_jiffies(1));
>>>   }
>>> -static int pci_epf_test_notifier(struct notifier_block *nb, unsigned 
>>> long val,
>>> -                 void *data)
>>> -{
>>> -    struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
>>> -    struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>>> -
>>> -    queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
>>> -               msecs_to_jiffies(1));
>>> -
>>> -    return NOTIFY_OK;
>>> -}
>>> -
>>>   static void pci_epf_test_unbind(struct pci_epf *epf)
>>>   {
>>>       struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>>> @@ -428,6 +416,78 @@ static int pci_epf_test_set_bar(struct pci_epf 
>>> *epf)
>>>       return 0;
>>>   }
>>> +static int pci_epf_test_core_init(struct pci_epf *epf)
>>> +{
>>> +    struct pci_epf_header *header = epf->header;
>>> +    const struct pci_epc_features *epc_features;
>>> +    struct pci_epc *epc = epf->epc;
>>> +    struct device *dev = &epf->dev;
>>> +    bool msix_capable = false;
>>> +    bool msi_capable = true;
>>> +    int ret;
>>> +
>>> +    epc_features = pci_epc_get_features(epc, epf->func_no);
>>> +    if (epc_features) {
>>> +        msix_capable = epc_features->msix_capable;
>>> +        msi_capable = epc_features->msi_capable;
>>> +    }
>>> +
>>> +    ret = pci_epc_write_header(epc, epf->func_no, header);
>>> +    if (ret) {
>>> +        dev_err(dev, "Configuration header write failed\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    ret = pci_epf_test_set_bar(epf);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    if (msi_capable) {
>>> +        ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
>>> +        if (ret) {
>>> +            dev_err(dev, "MSI configuration failed\n");
>>> +            return ret;
>>> +        }
>>> +    }
>>> +
>>> +    if (msix_capable) {
>>> +        ret = pci_epc_set_msix(epc, epf->func_no, 
>>> epf->msix_interrupts);
>>> +        if (ret) {
>>> +            dev_err(dev, "MSI-X configuration failed\n");
>>> +            return ret;
>>> +        }
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int pci_epf_test_notifier(struct notifier_block *nb, unsigned 
>>> long val,
>>> +                 void *data)
>>> +{
>>> +    struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
>>> +    struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>>> +    int ret;
>>> +
>>> +    switch (val) {
>>> +    case CORE_INIT:
>>> +        ret = pci_epf_test_core_init(epf);
>>> +        if (ret)
>>> +            return NOTIFY_BAD;
>>> +        break;
>>> +
>>> +    case LINK_UP:
>>> +        queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
>>> +                   msecs_to_jiffies(1));
>>> +        break;
>>> +
>>> +    default:
>>> +        dev_err(&epf->dev, "Invalid EPF test notifier event\n");
>>> +        return NOTIFY_BAD;
>>> +    }
>>> +
>>> +    return NOTIFY_OK;
>>> +}
>>> +
>>>   static int pci_epf_test_alloc_space(struct pci_epf *epf)
>>>   {
>>>       struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>>> @@ -496,12 +556,11 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>>   {
>>>       int ret;
>>>       struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>>> -    struct pci_epf_header *header = epf->header;
>>>       const struct pci_epc_features *epc_features;
>>>       enum pci_barno test_reg_bar = BAR_0;
>>>       struct pci_epc *epc = epf->epc;
>>> -    struct device *dev = &epf->dev;
>>>       bool linkup_notifier = false;
>>> +    bool skip_core_init = false;
>>>       bool msix_capable = false;
>>>       bool msi_capable = true;
>>> @@ -511,6 +570,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>>       epc_features = pci_epc_get_features(epc, epf->func_no);
>>>       if (epc_features) {
>>>           linkup_notifier = epc_features->linkup_notifier;
>>> +        skip_core_init = epc_features->skip_core_init;
>>>           msix_capable = epc_features->msix_capable;
>>>           msi_capable = epc_features->msi_capable;
>>
>> Are these used anywhere in this function?
> Nope. I'll remove them.
> 
>>>           test_reg_bar = pci_epc_get_first_free_bar(epc_features);
>>> @@ -520,34 +580,14 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>>       epf_test->test_reg_bar = test_reg_bar;
>>>       epf_test->epc_features = epc_features;
>>> -    ret = pci_epc_write_header(epc, epf->func_no, header);
>>> -    if (ret) {
>>> -        dev_err(dev, "Configuration header write failed\n");
>>> -        return ret;
>>> -    }
>>> -
>>>       ret = pci_epf_test_alloc_space(epf);
>>>       if (ret)
>>>           return ret;
>>> -    ret = pci_epf_test_set_bar(epf);
>>> -    if (ret)
>>> -        return ret;
>>> -
>>> -    if (msi_capable) {
>>> -        ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
>>> -        if (ret) {
>>> -            dev_err(dev, "MSI configuration failed\n");
>>> -            return ret;
>>> -        }
>>> -    }
>>> -
>>> -    if (msix_capable) {
>>> -        ret = pci_epc_set_msix(epc, epf->func_no, 
>>> epf->msix_interrupts);
>>> -        if (ret) {
>>> -            dev_err(dev, "MSI-X configuration failed\n");
>>> +    if (!skip_core_init) {
>>> +        ret = pci_epf_test_core_init(epf);
>>> +        if (ret)
>>>               return ret;
>>> -        }
>>>       }
>>>       if (linkup_notifier) {
>>
>> This could as well be moved to pci_epf_test_core_init().
> Yes, but I would like to keep only the code that touches hardware in 
> pci_epf_test_core_init()
> to minimize the time it takes to execute it. Is there any strong reason 
> to move it? if not,
> I would prefer to leave it here in this function itself.

There is no point in scheduling a work to check for commands from host 
when the EP itself is not initialized.

Thanks
Kishon
