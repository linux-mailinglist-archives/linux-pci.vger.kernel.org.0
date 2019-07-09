Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55DD4634DB
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 13:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfGILYA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jul 2019 07:24:00 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44742 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfGILYA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jul 2019 07:24:00 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x69BNlHP023028;
        Tue, 9 Jul 2019 06:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562671427;
        bh=b8hnSaDtAsosEIqS3Wtlk/YzhxSQT2YsI/k+98clIo4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pAXArl2RZan427WEUzWy9FensFk4A0hpvp9/x8sbuF1yxrtUBLgCbUTKad7XwGZNf
         TqwzAlaNy9ga3jmP4K7U+LemryiE61ZvgIefs6CvPvKfpcTiyUWrWF5VHcwQWL7Spb
         pwr0Ui2qd4Km4UgVISbtWeSe1wE3RDPm8ER/MX0Y=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x69BNlV0097963
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Jul 2019 06:23:47 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 9 Jul
 2019 06:23:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 9 Jul 2019 06:23:47 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x69BNeuB048589;
        Tue, 9 Jul 2019 06:23:41 -0500
Subject: Re: [PATCH] PCI: dwc: pci-dra7xx: Add missing include file
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        YueHaibing <yuehaibing@huawei.com>
CC:     <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <20190614154044.4972-1-yuehaibing@huawei.com>
 <20190705152905.GA6284@e121166-lin.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <619055c4-7d18-a77e-f7c6-267e4340bc4e@ti.com>
Date:   Tue, 9 Jul 2019 16:52:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190705152905.GA6284@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 05/07/19 8:59 PM, Lorenzo Pieralisi wrote:
> On Fri, Jun 14, 2019 at 11:40:44PM +0800, YueHaibing wrote:
>> Fix build error:
>>
>> drivers/pci/controller/dwc/pci-dra7xx.c:
>>  In function dra7xx_pcie_probe:
>> drivers/pci/controller/dwc/pci-dra7xx.c:777:10:
>>  error: implicit declaration of function devm_gpiod_get_optional;
>>  did you mean devm_regulator_get_optional? [-Werror=implicit-function-declaration]
>>
>>   reset = devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH);
> 
> Adding the reason (in particular the config options) that triggers
> this error would not hurt.
> 
> Kishon please let me know if I can merge it (ACK it if so).

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Thanks,
> Lorenzo
> 
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/pci/controller/dwc/pci-dra7xx.c | 1 +
>>  1 file changed, 1 insertion(+)
> 
> 
>>
>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
>> index 419451e..4234ddb 100644
>> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
>> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/types.h>
>>  #include <linux/mfd/syscon.h>
>>  #include <linux/regmap.h>
>> +#include <linux/gpio/consumer.h>
>>  
>>  #include "../../pci.h"
>>  #include "pcie-designware.h"
>> -- 
>> 2.7.4
>>
>>
