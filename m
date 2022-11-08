Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0C46205C0
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 02:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiKHBZP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 20:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiKHBZO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 20:25:14 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E1520BEB;
        Mon,  7 Nov 2022 17:25:13 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5r4J1lfTzHvkZ;
        Tue,  8 Nov 2022 09:24:48 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 09:25:11 +0800
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 09:25:11 +0800
Message-ID: <cd2386ab-a7c0-171d-28f4-4cb58d367786@huawei.com>
Date:   Tue, 8 Nov 2022 09:25:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH] PCI/ACPI: use ACPI Method Name macro directly
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <bhelgaas@google.com>,
        <tn@semihalf.com>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
References: <20221107212448.GA421592@bhelgaas>
From:   Yipeng Zou <zouyipeng@huawei.com>
In-Reply-To: <20221107212448.GA421592@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.115]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


在 2022/11/8 5:24, Bjorn Helgaas 写道:
> On Fri, Nov 04, 2022 at 11:24:30AM +0800, Yipeng Zou wrote:
>> It's convenience to find all at once, use METHOD_NAME__UID as path string.
>>
>> Fixes: 169de969c018 ("PCI/ACPI: Provide acpi_get_rc_resources() for ARM64 platform")
>> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
> Applied to pci/misc for v6.2, thanks!
>
> I dropped the "Fixes:" tag because there's no reason to backport this
> to any older kernels.
>
> I assume you're doing the same for other instances?
>
>    drivers/acpi/acpi_processor.c:          status = acpi_evaluate_integer(handle, "_UID", NULL, &uid);
>    drivers/acpi/dock.c:                                    "_UID", NULL, &lbuf);
>    drivers/acpi/processor_pdc.c:           status = acpi_evaluate_integer(handle, "_UID", NULL, &tmp);
>    drivers/perf/hisilicon/hisi_uncore_hha_pmu.c:                                          "_UID", NULL, &id);
>    drivers/xen/xen-acpi-processor.c:               status = acpi_evaluate_integer(handle, "_UID", NULL, &tmp);
yes, there are some other instances, will replace them together.
>> ---
>>   drivers/pci/pci-acpi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index a46fec776ad7..068d6745bf98 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -67,7 +67,7 @@ static acpi_status acpi_match_rc(acpi_handle handle, u32 lvl, void *context,
>>   	unsigned long long uid;
>>   	acpi_status status;
>>   
>> -	status = acpi_evaluate_integer(handle, "_UID", NULL, &uid);
>> +	status = acpi_evaluate_integer(handle, METHOD_NAME__UID, NULL, &uid);
>>   	if (ACPI_FAILURE(status) || uid != *segment)
>>   		return AE_CTRL_DEPTH;
>>   
>> -- 
>> 2.17.1
>>
-- 
Regards,
Yipeng Zou

