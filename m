Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA1124B25
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 11:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfEUJH2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 05:07:28 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15932 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfEUJH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 05:07:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce3bfcf0000>; Tue, 21 May 2019 02:07:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 21 May 2019 02:07:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 21 May 2019 02:07:27 -0700
Received: from [10.24.192.74] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 09:07:23 +0000
Subject: Re: [PATCH V4 20/28] PCI: tegra: Use legacy IRQ for port service
 drivers
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
 <20190516055307.25737-21-mmaddireddy@nvidia.com>
 <20190520203731.GA54609@google.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <41397458-c97b-fb38-49ba-8f3bb9ec3ded@nvidia.com>
Date:   Tue, 21 May 2019 14:37:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520203731.GA54609@google.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558429647; bh=YH9+7V7n0rvwG/qLHf412QIldM73k0ye/xO6T188+V8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=RXxA38OOkYUgl3RMYLatODXVk8IdOwNWbC90iUR3WUp9rHWyYQDLTeE7VQXD7b+dc
         gGxjqCibHRo0ixmmrRyi7lqV9Mqiv37ydR5EVehxUO3I8kKWIshnR532opPPkCykmE
         ZBCo8qgvLzWcqSPT6LTgQ3BhVIdjkrpDyoT84P9bGE4A2x/eT0Qf4H9OqFY08Jh9II
         k5okmNuP79tl/t83countd7vBsz2ioEoKsP8GHEyJsZHHzMtjNuEURkqG9u6Swvsta
         NAuBOUE8neYHnuJAvoJa1Pkj9YxuEzzbMRpN4thxoQCOo8pSgEykOUuKWWhcTP14BJ
         SZ4v9AnXJWTgA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 21-May-19 2:07 AM, Bjorn Helgaas wrote:
> On Thu, May 16, 2019 at 11:22:59AM +0530, Manikanta Maddireddy wrote:
>> Tegra signals PCIe services like AER, PME, etc. over legacy IRQ line.
>> By default, service drivers register interrupt routine over MSI IRQ line.
>> Use pcie_pme_disable_msi() function to disable MSI for service drivers.
> I think this device is not quite spec-compliant:
>
>   https://lore.kernel.org/linux-pci/20190520175729.GC49425@google.com/
>
> and you should work around this with a quirk that sets pdev->no_msi so
> we don't use MSI for it at all.

OK, I will update in next version. 

Manikanta

>
>> PME and AER interrupts registered to MSI without this change,
>> cat /proc/interrupts | grep -i pci
>> 36: 21 0 0 0 0 0 GICv2 104 Level       PCIE
>> 37: 35 0 0 0 0 0 GICv2 105 Level       Tegra PCIe MSI
>> 76: 0  0 0 0 0 0 Tegra PCIe MSI 0 Edge PCIe PME, aerdrv, PCIe BW notif
>>
>> PME and AER interrupts registered to legacy IRQ with this change,
>> cat /proc/interrupts | grep -i pci
>> 36: 33 0 0 0 0 0 GICv2 104 Level      PCIE, PCIe PME, aerdrv, PCIe BW notif
>> 37: 52 0 0 0 0 0 GICv2 105 Level      Tegra PCIe MSI
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> ---
>> V4: No change
>>
>> V3: Corrected typo in commit log
>>
>> V2: No change
>>
>>  drivers/pci/controller/pci-tegra.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index ac57c5badd9b..0024bc42b400 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -41,6 +41,7 @@
>>  #include <soc/tegra/pmc.h>
>>  
>>  #include "../pci.h"
>> +#include "../pcie/portdrv.h"
>>  
>>  #define INT_PCI_MSI_NR (8 * 32)
>>  
>> @@ -2725,6 +2726,9 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>>  		goto put_resources;
>>  	}
>>  
>> +	/* Switch to legacy IRQ for PCIe services like AER, PME*/
>> +	pcie_pme_disable_msi();
>> +
>>  	pm_runtime_enable(pcie->dev);
>>  	err = pm_runtime_get_sync(pcie->dev);
>>  	if (err) {
>> -- 
>> 2.17.1
>>

