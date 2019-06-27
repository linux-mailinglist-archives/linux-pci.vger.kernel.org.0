Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48784585CE
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 17:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfF0PdT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 11:33:19 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4740 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0PdT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jun 2019 11:33:19 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d14e1bc0002>; Thu, 27 Jun 2019 08:33:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 27 Jun 2019 08:33:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 27 Jun 2019 08:33:17 -0700
Received: from [10.25.73.176] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Jun
 2019 15:33:11 +0000
Subject: Re: [PATCH V11 03/12] PCI: dwc: Perform dbi regs write lock towards
 the end
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190624091505.1711-1-vidyas@nvidia.com>
 <20190624091505.1711-4-vidyas@nvidia.com>
 <20190627145800.GD3782@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <ecae46b4-54cc-7f4d-5a86-908431fd472a@nvidia.com>
Date:   Thu, 27 Jun 2019 21:03:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627145800.GD3782@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561649596; bh=i+FMOxZ9zRQNIxD/tJQJP96BLZYES68rpDNzKXH1Hoo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=NI59+G6dB0bbFZOAVMh76agA4AL6+J8djBbkbKJCvGiynhoRhcuiRRXcZCNx3MGK1
         30Y9IIl8j16nKlv3yyuYUj5y0M1WwcI4yOjPK2rCeDFZkYJVUIgpRjL7df+4Sovqdq
         hnXAawpejYqElyJdckiVWzKkFZaPTtP4qq2SOmzM97x/Uk4NZkZuCdsCJBw3Yc8lhF
         7MGzi5MrJ5adaeaH443AMqbarB9ll7Xl/dywfrpDFmqWZuvqIymMz6Yittq6w2loqH
         L47JjkDApJJUcyWLy0kdPGhJQX5DJ2ZYAr6PDf5TCoJ/2d2FQYHERNf8OKXqk1dEI0
         nkQPmwugOQuHg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/27/2019 8:28 PM, Lorenzo Pieralisi wrote:
> On Mon, Jun 24, 2019 at 02:44:56PM +0530, Vidya Sagar wrote:
>> Remove multiple write enable and disable sequences of dbi registers as
>> Tegra194 implements writes to BAR-0 register (offset: 0x10) controlled by
>> DBI write-lock enable bit thereby not allowing any further writes to BAR-0
>> register in config space to take place. Hence enabling write permission at
>> the start of function and disabling the same only towards the end.
> 
> I do not understand what this patch does, I would like to rephrase
> the commit log in a way that is easier to parse.
> 
> In particular I do not get what you mean in relation to BAR-0, I am
> confused, please clarify.
> 
> Lorenzo
Well, some of the Synopsys DesignWare core's DBI registers are protected with a lock
without which, they are read-only by default. Existing code in dw_pcie_setup_rc() API
tries to unlock and lock multiple times whenever it wants to update those write-protected
registers. This patch attempts to unlock all such write-protected registers for writing
once in the beginning of the function and lock them back towards the end.
As far as BAR-0 register (which is at offset 0x10 in DBI space... nothing but the
config space) in Tegra194 is concerned, it is one of those registers to which
writes are protected. I could have added unlock/lock pair around accessing this register,
but that would bloat this API with one more pair of unlock/lock, instead I chose to remove
unlock/lock pairs for all protected registers and have unlock in the beginning and lock
towards the end.

-Vidya Sagar

> 
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Reviewed-by: Thierry Reding <treding@nvidia.com>
>> Acked-by: Jingoo Han <jingoohan1@gmail.com>
>> ---
>> Changes since [v10]:
>> * None
>>
>> Changes since [v9]:
>> * None
>>
>> Changes since [v8]:
>> * None
>>
>> Changes since [v7]:
>> * None
>>
>> Changes since [v6]:
>> * None
>>
>> Changes since [v5]:
>> * Moved write enable to the beginning of the API and write disable to the end
>>
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
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index f93252d0da5b..d3156446ff27 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -628,6 +628,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>   	u32 val, ctrl, num_ctrls;
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>   
>> +	/*
>> +	 * Enable DBI read-only registers for writing/updating configuration.
>> +	 * Write permission gets disabled towards the end of this function.
>> +	 */
>> +	dw_pcie_dbi_ro_wr_en(pci);
>> +
>>   	dw_pcie_setup(pci);
>>   
>>   	if (!pp->ops->msi_host_init) {
>> @@ -650,12 +656,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>   	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
>>   
>>   	/* Setup interrupt pins */
>> -	dw_pcie_dbi_ro_wr_en(pci);
>>   	val = dw_pcie_readl_dbi(pci, PCI_INTERRUPT_LINE);
>>   	val &= 0xffff00ff;
>>   	val |= 0x00000100;
>>   	dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
>> -	dw_pcie_dbi_ro_wr_dis(pci);
>>   
>>   	/* Setup bus numbers */
>>   	val = dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
>> @@ -687,15 +691,13 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>   
>>   	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
>>   
>> -	/* Enable write permission for the DBI read-only register */
>> -	dw_pcie_dbi_ro_wr_en(pci);
>>   	/* Program correct class for RC */
>>   	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
>> -	/* Better disable write permission right after the update */
>> -	dw_pcie_dbi_ro_wr_dis(pci);
>>   
>>   	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
>>   	val |= PORT_LOGIC_SPEED_CHANGE;
>>   	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
>> +
>> +	dw_pcie_dbi_ro_wr_dis(pci);
>>   }
>>   EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
>> -- 
>> 2.17.1
>>

