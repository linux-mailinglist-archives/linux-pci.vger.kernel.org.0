Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B562FB2C0
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 08:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbhASHTN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 02:19:13 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48578 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbhASHSo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jan 2021 02:18:44 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10J7Gd8u075236;
        Tue, 19 Jan 2021 01:16:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611040599;
        bh=UkrwWJka5SdhZJ0eXzGUAHW7z2WtA1NhNTWfJiOYt4w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ki6SkQg6UuRzVNGJSdjFjIhUDGbPWMpgFsHDA7B/abrNoCMeUdPg7vnhq+28Fbsww
         E+HrMS80To6kmnd8bZxQHPkIXknBqKHzlNBiS2EJ5isP09xeyqxhrv8hD+fnXNqIem
         0hQFJFDnxv2jr3tmtqP3V7n+8q9s38U0unHNxvr0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10J7GdvA021048
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jan 2021 01:16:39 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 19
 Jan 2021 01:16:39 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 19 Jan 2021 01:16:39 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10J7GaBK077234;
        Tue, 19 Jan 2021 01:16:37 -0600
Subject: Re: [PATCH] PCI: functions/pci-epf-test: fix missing
 destroy_workqueue() on error in pci_epf_test_init
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Qinglang Miao <miaoqinglang@huawei.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20201028091549.136349-1-miaoqinglang@huawei.com>
 <20210118124744.GA13109@e121166-lin.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <644f6522-f22d-adf6-16ba-dcdf329df7d0@ti.com>
Date:   Tue, 19 Jan 2021 12:46:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210118124744.GA13109@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Qinglang,

On 18/01/21 6:17 pm, Lorenzo Pieralisi wrote:
> On Wed, Oct 28, 2020 at 05:15:49PM +0800, Qinglang Miao wrote:
>> Add the missing destroy_workqueue() before return from
>> pci_epf_test_init() in the error handling case.
>>
>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
>> ---
>>  drivers/pci/endpoint/functions/pci-epf-test.c | 1 +
>>  1 file changed, 1 insertion(+)
> 
> Need Kishon's ack.
> 
> Lorenzo

Can you also add destroy_workqueue() in pci_epf_test_exit()?

Thank You,
Kishon

> 
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>> index e4e51d884..6854f2525 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -918,6 +918,7 @@ static int __init pci_epf_test_init(void)
>>  	ret = pci_epf_register_driver(&test_driver);
>>  	if (ret) {
>>  		pr_err("Failed to register pci epf test driver --> %d\n", ret);
>> +		destroy_workqueue(kpcitest_workqueue);
>>  		return ret;
>>  	}
>>  
>> -- 
>> 2.23.0
>>
