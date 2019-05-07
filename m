Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB9B15E90
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 09:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfEGHto (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 03:49:44 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7234 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfEGHto (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 03:49:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd1389e0002>; Tue, 07 May 2019 00:49:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 May 2019 00:49:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 May 2019 00:49:43 -0700
Received: from [10.25.73.250] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 May
 2019 07:49:36 +0000
Subject: Re: [PATCH V5 04/16] PCI: dwc: Perform dbi regs write lock towards
 the end
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
 <20190424052004.6270-5-vidyas@nvidia.com> <20190503111303.GD32400@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <2544621a-4c88-3f3e-786c-7ee8103e132d@nvidia.com>
Date:   Tue, 7 May 2019 13:19:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503111303.GD32400@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557215390; bh=7aKDP0PrR8UIUscgN8AluGENbezYgudBe8R0F7tHAOo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=VzvW/Z1vIyC82jZseAoID7gNZrMmCKK54TotulhenXUaOPM25Fgkyu8/t7GyDCArJ
         pHnYW8VMh/3Pif4M8EucT6ODyFN50p4tsXm+gyfL1U2gtH6vWczZx0ZvX7wCXgXz9t
         B6cfutJkFWW0EF5gDPAhELjdZNu2+IpwUtp9fRIHrWAy3PlVYr0YcxCvjH1aD+g+zl
         aFTIUDio1gL8KpJXFg8EJTSHpO/HhCGHVkIjBw3OwHUhcWyjPb/fNw5yFGy1zGbc2o
         0A0s1VHTiZdw/B09xqEke0nlRECDlPXV4BId0zvtAGtkJWfWYUNK8hb7V3AfL95Gic
         PKKKgGA8PnVbw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/3/2019 4:43 PM, Thierry Reding wrote:
> On Wed, Apr 24, 2019 at 10:49:52AM +0530, Vidya Sagar wrote:
>> Remove multiple write enable and disable sequences of dbi registers as
>> Tegra194 implements writes to BAR-0 register (offset: 0x10) controlled by
>> DBI write-lock enable bit thereby not allowing any further writes to BAR-0
>> register in config space to take place. Hence disabling write permission
>> only towards the end.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes since [v4]:
>> * None
>>
>> Changes since [v3]:
>> * None
>>
>> Changes since [v2]:
>> * None
>>
>> Changes since [v1]:
>> * None
>>
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 36fd3f5b48f6..e5e3571dd2fe 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -654,7 +654,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>   	val &= 0xffff00ff;
>>   	val |= 0x00000100;
>>   	dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
>> -	dw_pcie_dbi_ro_wr_dis(pci);
>>   
>>   	/* Setup bus numbers */
>>   	val = dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
>> @@ -686,8 +685,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>   
>>   	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
>>   
>> -	/* Enable write permission for the DBI read-only register */
>> -	dw_pcie_dbi_ro_wr_en(pci);
>>   	/* Program correct class for RC */
>>   	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
>>   	/* Better disable write permission right after the update */
> 
> Perhaps make this explicit by moving the write enable call to the
> beginning of the function and the write disable call to the end?
> 
> Currently it's pretty difficult to see where it's being disabled. Also,
> that would make it more resilient against instantiations that require a
> different register to be programmed with writes enabled.
Agree. I'll move enabling write to beginning of this function and disabling
to the end in the next patch series.

> 
> Thierry
> 

