Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4366D15DE9
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 09:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfEGHKt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 03:10:49 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8609 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfEGHKt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 03:10:49 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd12f740000>; Tue, 07 May 2019 00:10:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 May 2019 00:10:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 07 May 2019 00:10:48 -0700
Received: from [10.25.73.250] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 May
 2019 07:10:40 +0000
Subject: Re: [PATCH V5 02/16] PCI/PME: Export pcie_pme_disable_msi() &
 pcie_pme_no_msi() APIs
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-3-vidyas@nvidia.com> <20190503110159.GB32400@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <b8f482f4-8136-07b5-3d68-f45a6fd580ba@nvidia.com>
Date:   Tue, 7 May 2019 12:40:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503110159.GB32400@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557213044; bh=KIRiMdJ3vHsuNoXRBzUBVE4jj3DtsdclgdYyB8TtsKg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=N0cu64tGkekeUlr8GKtZ16+dmuv0OOULTcHPKb31Wg/Etaa5vKT7q/lCU9FWUezN/
         X+GgJbW6gv3Wlgg0qz4wcVp/+BHHqKijSr7kxXMORKyhWwiG/1PY1x/PskChTDTaiM
         Ix0gYrXm/p0ytf1PRzZ6mjbbv5b7q7+flVxgw3YiG76X7uayqz/Z/aUO4r/CkBb/2t
         D6MMYSGaJci4N2uY/oLvsOcCw1MxHSwVGcbrWEJFGvFuL73XUq5CGYt/yx+PQy9377
         t3IfNouplwTxNXL9xDOEvQ4LHkNjw+z/z/MUkElZPJv+nFXO4z/VecuQreGLOwJQe3
         f15d3SAi3cWww==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/3/2019 4:31 PM, Thierry Reding wrote:
> On Wed, Apr 24, 2019 at 10:49:50AM +0530, Vidya Sagar wrote:
>> Export pcie_pme_disable_msi() & pcie_pme_no_msi() APIs to enable drivers
>> using this API be able to build as loadable modules.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes from [v4]:
>> * None
>>
>> Changes from [v3]:
>> * None
>>
>> Changes from [v2]:
>> * Exported pcie_pme_no_msi() API after making pcie_pme_msi_disabled a static
>>
>> Changes from [v1]:
>> * This is a new patch in v2 series
>>
>>   drivers/pci/pcie/pme.c     | 14 +++++++++++++-
>>   drivers/pci/pcie/portdrv.h | 16 +++-------------
>>   2 files changed, 16 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
>> index 54d593d10396..d5e0ea4a62fc 100644
>> --- a/drivers/pci/pcie/pme.c
>> +++ b/drivers/pci/pcie/pme.c
>> @@ -25,7 +25,19 @@
>>    * that using MSI for PCIe PME signaling doesn't play well with PCIe PME-based
>>    * wake-up from system sleep states.
>>    */
>> -bool pcie_pme_msi_disabled;
>> +static bool pcie_pme_msi_disabled;
>> +
>> +void pcie_pme_disable_msi(void)
>> +{
>> +	pcie_pme_msi_disabled = true;
>> +}
>> +EXPORT_SYMBOL_GPL(pcie_pme_disable_msi);
>> +
>> +bool pcie_pme_no_msi(void)
>> +{
>> +	return pcie_pme_msi_disabled;
>> +}
>> +EXPORT_SYMBOL_GPL(pcie_pme_no_msi);
>>   
>>   static int __init pcie_pme_setup(char *str)
>>   {
>> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
>> index 1d50dc58ac40..7c8c3da4bd58 100644
>> --- a/drivers/pci/pcie/portdrv.h
>> +++ b/drivers/pci/pcie/portdrv.h
>> @@ -125,22 +125,12 @@ void pcie_port_bus_unregister(void);
>>   struct pci_dev;
>>   
>>   #ifdef CONFIG_PCIE_PME
>> -extern bool pcie_pme_msi_disabled;
>> -
>> -static inline void pcie_pme_disable_msi(void)
>> -{
>> -	pcie_pme_msi_disabled = true;
>> -}
>> -
>> -static inline bool pcie_pme_no_msi(void)
>> -{
>> -	return pcie_pme_msi_disabled;
>> -}
>> -
>> +void pcie_pme_disable_msi(void);
>> +bool pcie_pme_no_msi(void);
>>   void pcie_pme_interrupt_enable(struct pci_dev *dev, bool enable);
>>   #else /* !CONFIG_PCIE_PME */
>>   static inline void pcie_pme_disable_msi(void) {}
>> -static inline bool pcie_pme_no_msi(void) { return false; }
>> +static inline bool pcie_pme_no_msi(void) {}
> 
> This looks wrong.
Can you please give more info on what is wrong in this?

> 
> Thierry
> 

