Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422433F0569
	for <lists+linux-pci@lfdr.de>; Wed, 18 Aug 2021 15:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbhHRN4i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Aug 2021 09:56:38 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52820 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbhHRN4i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Aug 2021 09:56:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17IDtUbX104904;
        Wed, 18 Aug 2021 08:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629294930;
        bh=/SM7hS5s/+pWFzi30GOYLIjoFM9YcVwy3bRzaQGqTvo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ghTl1mD69mVfxcDyDXbA11WBlA0PvG3TwRD4Lj544RjjKOkst9FqCPvdpP2lpf4uz
         K5+8MwEElG/B4NPLRfTzovEBVKee7w0+G5wrG3f6BVaFxzwovH4JD9ak6DG0ryVDrY
         SwOBE1LDTWYJrJX2PMbbTx2o6OP15YhLcpvUd6kM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17IDtUGN116309
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Aug 2021 08:55:30 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 18
 Aug 2021 08:55:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 18 Aug 2021 08:55:30 -0500
Received: from [10.250.232.133] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17IDtK7Q105937;
        Wed, 18 Aug 2021 08:55:22 -0500
Subject: Re: [PATCH v8 6/8] PCI: cadence: Add support to configure virtual
 functions
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20210817153852.GA3016660@bjorn-Precision-5520>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ce380e6f-d10a-4db2-9bde-82615cfbe4db@ti.com>
Date:   Wed, 18 Aug 2021 19:25:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210817153852.GA3016660@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 17/08/21 9:08 pm, Bjorn Helgaas wrote:
> On Wed, Aug 11, 2021 at 12:16:54PM +0530, Kishon Vijay Abraham I wrote:
>> Now that support for SR-IOV is added in PCIe endpoint core, add support
>> to configure virtual functions in the Cadence PCIe EP driver.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../pci/controller/cadence/pcie-cadence-ep.c  | 136 +++++++++++++++---
>>  drivers/pci/controller/cadence/pcie-cadence.h |   9 ++
>>  2 files changed, 125 insertions(+), 20 deletions(-)
> 
>> @@ -92,21 +118,29 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>>  
>>  	addr0 = lower_32_bits(bar_phys);
>>  	addr1 = upper_32_bits(bar_phys);
>> -	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar),
>> -			 addr0);
>> -	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar),
>> -			 addr1);
>>  
>>  	reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
>> +	if (vfn == 1)
>> +		reg = CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);
> 
> Seems sort of weird to compute "reg", then sometimes overwrite it, as
> opposed to:
> 
>   if (vfn == 1)
>     reg = CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);
>   else
>     reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);

I tried to write it without "else". But I can change it back.
> 
> Also slightly weird that "vfn" is basically used as a boolean, but
> it's actually a u8 virtual function number.  I guess VF 1 is special
> and not like the other VFs?

VF1 is special in that it's enough for configuring the SR-IOV capability
but below the "vfn" is used for configuring inbound window.

Thanks
Kishon
> 
>>  	b = (bar < BAR_4) ? bar : bar - BAR_4;
>>  
>> -	cfg = cdns_pcie_readl(pcie, reg);
>> -	cfg &= ~(CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
>> -		 CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
>> -	cfg |= (CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, aperture) |
>> -		CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl));
>> -	cdns_pcie_writel(pcie, reg, cfg);
>> +	if (vfn == 0 || vfn == 1) {
>> +		cfg = cdns_pcie_readl(pcie, reg);
>> +		cfg &= ~(CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
>> +			 CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
>> +		cfg |= (CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, aperture) |
>> +			CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl));
>> +		cdns_pcie_writel(pcie, reg, cfg);
>> +	}
>>  
>> +	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
>> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar),
>> +			 addr0);
>> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar),
>> +			 addr1);
>> +
>> +	if (vfn > 0)
>> +		epf = &epf->epf[vfn - 1];
>>  	epf->epf_bar[bar] = epf_bar;
>>  
>>  	return 0;
>> @@ -122,18 +156,25 @@ static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>>  	u32 reg, cfg, b, ctrl;
>>  
>>  	reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
>> +	if (vfn == 1)
>> +		reg = CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);
> 
> Similar recomputation of "reg".
> 
>>  	b = (bar < BAR_4) ? bar : bar - BAR_4;
>>  
>> -	ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED;
>> -	cfg = cdns_pcie_readl(pcie, reg);
>> -	cfg &= ~(CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
>> -		 CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
>> -	cfg |= CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl);
>> -	cdns_pcie_writel(pcie, reg, cfg);
>> +	if (vfn == 0 || vfn == 1) {
>> +		ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED;
>> +		cfg = cdns_pcie_readl(pcie, reg);
>> +		cfg &= ~(CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
>> +			 CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
>> +		cfg |= CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl);
>> +		cdns_pcie_writel(pcie, reg, cfg);
>> +	}
