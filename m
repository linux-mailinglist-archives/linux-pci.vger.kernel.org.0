Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370331BC4E3
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 18:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgD1QQR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Apr 2020 12:16:17 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56744 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbgD1QQR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Apr 2020 12:16:17 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03SGFudR001305;
        Tue, 28 Apr 2020 11:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588090556;
        bh=8fXivnlbbbn4L5jCdnMcunsvQltul4JatC/I2sDPy3k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=o8Q1dKAKumI9AuZuygJqiQhmee1QA49Ouc81U59hsiww7bK01VgxgrCqdNp7yzX0e
         R1MmG05B4DFE+VsTxTkArUSJkdZBttmag33or25f9RZ/vacup2HQj3wS8sL6iOXivO
         8R+19OS0oDS3UMBSbIjtaSdyKcwzFlOxoiKTE4cI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03SGFuw7008647
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Apr 2020 11:15:56 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 28
 Apr 2020 11:15:56 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 28 Apr 2020 11:15:56 -0500
Received: from [10.250.234.195] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03SGFpMO006509;
        Tue, 28 Apr 2020 11:15:52 -0500
Subject: Re: [PATCH -next] PCI: dwc: pci-dra7xx: Fix potential NULL
 dereference in dra7xx_pcie_probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20200427111044.162618-1-weiyongjun1@huawei.com>
 <cad871c8-0915-9dda-2c61-30dfb5504d23@ti.com> <20200428130734.GF2014@kadam>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <ebb4db96-08ef-64fe-5331-291f054562ed@ti.com>
Date:   Tue, 28 Apr 2020 21:45:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428130734.GF2014@kadam>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 28/04/20 6:37 pm, Dan Carpenter wrote:
> On Mon, Apr 27, 2020 at 05:29:50PM +0530, Vignesh Raghavendra wrote:
>> Hi,
>>
>> On 27/04/20 4:40 pm, Wei Yongjun wrote:
>>> platform_get_resource() may fail and return NULL, so we should
>>> better check it's return value to avoid a NULL pointer dereference
>>> a bit later in the code.
>>>
>>> This is detected by Coccinelle semantic patch.
>>>
>>> @@
>>> expression pdev, res, n, t, e, e1, e2;
>>> @@
>>>
>>> res = \(platform_get_resource\|platform_get_resource_byname\)(pdev, t, n);
>>> + if (!res)
>>> +   return -EINVAL;
>>> ... when != res == NULL
>>> e = devm_ioremap(e1, res->start, e2);
>>>
>>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>>> ---
>>>  drivers/pci/controller/dwc/pci-dra7xx.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
>>> index 3b0e58f2de58..7a3d12f7e7d9 100644
>>> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
>>> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
>>> @@ -878,6 +878,9 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>>  	}
>>>  
>>>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ti_conf");
>                                            ^^^^
> 
>>> +	if (!res)
>>> +		return -EINVAL;
>>> +
>>>  	base = devm_ioremap(dev, res->start, resource_size(res));
>                             ^^^
>>
>> I don't see why this should be devm_ioremap(). It should also have been
>> devm_ioremap_resource() which does the NULL check.
> 
> It's different device pointers.
> 

Sorry, I don't understand this comment... Currently we have:

static int __init dra7xx_pcie_probe(struct platform_device *pdev)
{
        struct device *dev = &pdev->dev;
	...
	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ti_conf");
        base = devm_ioremap(dev, res->start, resource_size(res));
        if (!base)
                return -ENOMEM;

Instead of the proposed patch, what I am asking is:

	base = devm_platform_ioremap_resource_byname(pdev, "ti_conf");
	if (IS_ERR(base))
		return PTR_ERR(base);




> regards,
> dan carpenter
> 
