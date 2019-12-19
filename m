Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA1E125CA2
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 09:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfLSI3c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 03:29:32 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54724 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfLSI3c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 03:29:32 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBJ8TOcM038842;
        Thu, 19 Dec 2019 02:29:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576744164;
        bh=qHodQfVRoxRI6Q5T0UwFr5pC1wfIqkcyWERy28q6efM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rFFo8hMSSugW3xBnanhPdce0vj4r2wn92etK1aDt7i4TSJMWFK6pylOxtFH49rT4V
         elwE09sGfpgkdY5/VOCCo02Ah2TbXfRK+rvq9L+dx8B7zFYW4+9u3S9JtfBLmi+dAg
         cnFSx3j0bzRviyHkJqSyCL1xrM3fSOgKyoqm4OVM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBJ8TO6E124868
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Dec 2019 02:29:24 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Dec 2019 02:29:23 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Dec 2019 02:29:24 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJ8TKFJ062210;
        Thu, 19 Dec 2019 02:29:21 -0600
Subject: Re: [PATCH 01/13] PCI: cadence: Remove stray "pm_runtime_put_sync()"
 in error path
To:     Andrew Murray <andrew.murray@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-2-kishon@ti.com>
 <20191216134526.GW24359@e119886-lin.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a1b70012-9cfc-0420-2717-8bdd9df1b4de@ti.com>
Date:   Thu, 19 Dec 2019 14:01:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216134526.GW24359@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,

On 16/12/19 7:15 pm, Andrew Murray wrote:
> On Mon, Dec 09, 2019 at 02:51:35PM +0530, Kishon Vijay Abraham I wrote:
>> commit bd22885aa188f135fd9 ("PCI: cadence: Refactor driver to use
>> as a core library") while refactoring the Cadence PCIe driver to be
>> used as library, removed pm_runtime_get_sync() from cdns_pcie_ep_setup()
>> and cdns_pcie_host_setup() but missed to remove the corresponding
>> pm_runtime_put_sync() in the error path. Fix it here.
>>
>> Fixes: commit bd22885aa188f135fd9 ("PCI: cadence: Refactor driver to use
> 
> As this is a fix, a commit subject starting with PCI: cadence: Fix ... may
> be more obvious.
> 
> I'd suggest you use the shorter form of this, i.e. Fixes: %h (\"%s\"))
> 
> Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core library")
> 
>> as a core library")

Okay.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>   drivers/pci/controller/cadence/pcie-cadence-ep.c   | 2 --
>>   drivers/pci/controller/cadence/pcie-cadence-host.c | 2 --
>>   2 files changed, 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> index 1c173dad67d1..560f22b4d165 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> @@ -473,7 +473,5 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>>   	pci_epc_mem_exit(epc);
>>   
>>    err_init:
>> -	pm_runtime_put_sync(dev);
>> -
>>   	return ret;
>>   }
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 9b1c3966414b..ccf55e143e1d 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -275,7 +275,5 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>   	pci_free_resource_list(&resources);
>>   
>>    err_init:
>> -	pm_runtime_put_sync(dev);
>> -
> 
> There is probably more you can do here for both -host and -ep:
> 
>   - Remove the possibly now unused <linux/pm_runtime.h> include
>   - Remove the err_init label and return directly from source.

Okay, will fix this up.

Thanks
Kishon
