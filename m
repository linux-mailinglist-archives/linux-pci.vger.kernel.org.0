Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD61164429A
	for <lists+linux-pci@lfdr.de>; Tue,  6 Dec 2022 12:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiLFL5C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 06:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiLFL4z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 06:56:55 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D521810546;
        Tue,  6 Dec 2022 03:56:54 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NRJll4nJvzRpn5;
        Tue,  6 Dec 2022 19:56:03 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Dec 2022 19:56:52 +0800
Subject: Re: [PATCH 1/2] hwtracing: hisi_ptt: Only add the supported devices
 to the filters list
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Yicong Yang <yangyicong@huawei.com>,
        <mathieu.poirier@linaro.org>
CC:     <yangyicong@hisilicon.com>, <alexander.shishkin@linux.intel.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>, <linux-kernel@vger.kernel.org>,
        <jonathan.cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20221122120209.25682-1-yangyicong@huawei.com>
 <fb2441ce-fe4c-3733-5cd3-93a7d949d9f0@huawei.com>
 <47d600f0-e62e-e3b5-7fbe-68adce92af4f@arm.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <e82eed9c-164e-5454-299d-611882150cdb@huawei.com>
Date:   Tue, 6 Dec 2022 19:56:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <47d600f0-e62e-e3b5-7fbe-68adce92af4f@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/12/6 19:46, Suzuki K Poulose wrote:
> Hi Yicong Yang
> 
> On 06/12/2022 11:34, Yicong Yang wrote:
>> Hi Mathieu,
>>
>> Do we still have a chance to catch this cycle for these 2 patches?
> 
> Sorry, I have been handling the coresight tree this cycle (and will be
> going forward). I have already sent the pull request to Greg. I am
> afraid it is late for this cycle.
> 
> I can queue it for the next cycle.
> 

Thanks for the information.
It's ok, I'll resend in the next cycle.

Thanks,
Yicong

>>
>> Thanks!
>>
>> On 2022/11/22 20:02, Yicong Yang wrote:
>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>
>>> The PTT device can only support the devices on the same PCIe core,
>>> within BDF range [lower_bdf, upper_bdf]. It's not correct to assume
>>> the devices on the root bus are from the same PCIe core, there are
>>> cases that root ports from different PCIe core are sharing the same
>>> bus. So add the checking when initialize the filters list.
>>>
>>> Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>> ---
>>>   drivers/hwtracing/ptt/hisi_ptt.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>>> index 5d5526aa60c4..30f1525639b5 100644
>>> --- a/drivers/hwtracing/ptt/hisi_ptt.c
>>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
>>> @@ -356,8 +356,18 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
>>>     static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
>>>   {
>>> +    struct pci_dev *root_port = pcie_find_root_port(pdev);
>>>       struct hisi_ptt_filter_desc *filter;
>>>       struct hisi_ptt *hisi_ptt = data;
>>> +    u32 port_devid;
>>> +
>>> +    if (!root_port)
>>> +        return 0;
>>> +
>>> +    port_devid = PCI_DEVID(root_port->bus->number, root_port->devfn);
>>> +    if (port_devid < hisi_ptt->lower_bdf ||
>>> +        port_devid > hisi_ptt->upper_bdf)
>>> +        return 0;
>>>         /*
>>>        * We won't fail the probe if filter allocation failed here. The filters
>>>
> 
> 
> .
