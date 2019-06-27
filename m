Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E197587AD
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 18:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfF0QwO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 12:52:14 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14316 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfF0QwN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jun 2019 12:52:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d14f43a0000>; Thu, 27 Jun 2019 09:52:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Jun 2019 09:52:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 27 Jun 2019 09:52:12 -0700
Received: from [10.25.73.176] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Jun
 2019 16:52:06 +0000
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
 <ecae46b4-54cc-7f4d-5a86-908431fd472a@nvidia.com>
 <20190627155047.GF3782@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <fbef2fee-1ca9-b894-6d1a-f2a9449968a5@nvidia.com>
Date:   Thu, 27 Jun 2019 22:22:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627155047.GF3782@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561654330; bh=yvZTQ4IOvwV6hxGeLW9GOQ2PqNDwou5Z7nhqxb2MGzs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=iYpJIifkIFk1Yn0Eghy9VIv8CWqVmaUl2NjkJCcCnw4fa44o14waMoJZ5wiY2vv4i
         AonS5CXCnMzgLrRHT3pgAav4AlJ6wHA79wV19iTR2hU3lKQPkXn5ZeZN30IhnSEuTl
         7j+nz+zLL7eMFU1AYZsTIvEY7gReETQa/nmiCqdp/KsBYN1ZLNckPodg5tL8PvbqWq
         qyy9BkbegqMYkCWBvxKzXSi8ha/QC9Q0lbPnkvEN07Bphh/8hxtwnaBr0qB8/Js98s
         qDXzoUxEMVyK/6y0EGWf0UF0sCYc+P7x/uEBCX5HiehRt9Opb3Ipyiu4L+dzJi0aHz
         4x3HfLnIFxTEQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/27/2019 9:20 PM, Lorenzo Pieralisi wrote:
> On Thu, Jun 27, 2019 at 09:03:08PM +0530, Vidya Sagar wrote:
>> On 6/27/2019 8:28 PM, Lorenzo Pieralisi wrote:
>>> On Mon, Jun 24, 2019 at 02:44:56PM +0530, Vidya Sagar wrote:
>>>> Remove multiple write enable and disable sequences of dbi registers as
>>>> Tegra194 implements writes to BAR-0 register (offset: 0x10) controlled by
>>>> DBI write-lock enable bit thereby not allowing any further writes to BAR-0
>>>> register in config space to take place. Hence enabling write permission at
>>>> the start of function and disabling the same only towards the end.
>>>
>>> I do not understand what this patch does, I would like to rephrase
>>> the commit log in a way that is easier to parse.
>>>
>>> In particular I do not get what you mean in relation to BAR-0, I am
>>> confused, please clarify.
>>>
>>> Lorenzo
>> Well, some of the Synopsys DesignWare core's DBI registers are
>> protected with a lock without which, they are read-only by default.
>> Existing code in dw_pcie_setup_rc() API tries to unlock and lock
>> multiple times whenever it wants to update those write-protected
>> registers. This patch attempts to unlock all such write-protected
>> registers for writing once in the beginning of the function and lock
>> them back towards the end.  As far as BAR-0 register (which is at
>> offset 0x10 in DBI space... nothing but the config space) in Tegra194
>> is concerned, it is one of those registers to which writes are
>> protected. I could have added unlock/lock pair around accessing this
>> register, but that would bloat this API with one more pair of
>> unlock/lock, instead I chose to remove unlock/lock pairs for all
>> protected registers and have unlock in the beginning and lock towards
>> the end.
> 
> Ok, so DBI space registers that require write permissions are per-IP.
> This is clearer so the commit log must be rewritten, it is not clear at
> all in this respect at least not as-is, if you read it you will
> notice ;-)
Ok. I'll update commit message in next patch series.

-Vidya Sagar
> 
> Lorenzo
> 
>>
>> -Vidya Sagar
>>
>>>
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>> Reviewed-by: Thierry Reding <treding@nvidia.com>
>>>> Acked-by: Jingoo Han <jingoohan1@gmail.com>
>>>> ---
>>>> Changes since [v10]:
>>>> * None
>>>>
>>>> Changes since [v9]:
>>>> * None
>>>>
>>>> Changes since [v8]:
>>>> * None
>>>>
>>>> Changes since [v7]:
>>>> * None
>>>>
>>>> Changes since [v6]:
>>>> * None
>>>>
>>>> Changes since [v5]:
>>>> * Moved write enable to the beginning of the API and write disable to the end
>>>>
>>>> Changes since [v4]:
>>>> * None
>>>>
>>>> Changes since [v3]:
>>>> * None
>>>>
>>>> Changes since [v2]:
>>>> * None
>>>>
>>>> Changes since [v1]:
>>>> * None
>>>>
>>>>    drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++------
>>>>    1 file changed, 8 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> index f93252d0da5b..d3156446ff27 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> @@ -628,6 +628,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>>>    	u32 val, ctrl, num_ctrls;
>>>>    	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>> +	/*
>>>> +	 * Enable DBI read-only registers for writing/updating configuration.
>>>> +	 * Write permission gets disabled towards the end of this function.
>>>> +	 */
>>>> +	dw_pcie_dbi_ro_wr_en(pci);
>>>> +
>>>>    	dw_pcie_setup(pci);
>>>>    	if (!pp->ops->msi_host_init) {
>>>> @@ -650,12 +656,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>>>    	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
>>>>    	/* Setup interrupt pins */
>>>> -	dw_pcie_dbi_ro_wr_en(pci);
>>>>    	val = dw_pcie_readl_dbi(pci, PCI_INTERRUPT_LINE);
>>>>    	val &= 0xffff00ff;
>>>>    	val |= 0x00000100;
>>>>    	dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
>>>> -	dw_pcie_dbi_ro_wr_dis(pci);
>>>>    	/* Setup bus numbers */
>>>>    	val = dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
>>>> @@ -687,15 +691,13 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>>>    	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
>>>> -	/* Enable write permission for the DBI read-only register */
>>>> -	dw_pcie_dbi_ro_wr_en(pci);
>>>>    	/* Program correct class for RC */
>>>>    	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
>>>> -	/* Better disable write permission right after the update */
>>>> -	dw_pcie_dbi_ro_wr_dis(pci);
>>>>    	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
>>>>    	val |= PORT_LOGIC_SPEED_CHANGE;
>>>>    	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
>>>> +
>>>> +	dw_pcie_dbi_ro_wr_dis(pci);
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
>>>> -- 
>>>> 2.17.1
>>>>
>>

