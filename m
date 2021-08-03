Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0124B3DF0E4
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 16:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhHCO5d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 10:57:33 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46450 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbhHCO5c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 10:57:32 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 173Euqjp051587;
        Tue, 3 Aug 2021 09:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628002612;
        bh=+Xji1zKIuLogX0B+kK6j4X2dEkjBXwuwPZRCCqTYn94=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hfy2ciXNXPYLOeWd5Rgr0vwK6t5j4Ywtiq8rv5tnPhp/Hi33vvUtdM5b5EKe6Ybb2
         x/+A1Almuf8Co17KmPyhthoPXcM7ZZh0PFl4pFDHM4yQJnaoLuPMKi1vAtrdJdeb0k
         w/iELA9P0/DoMh1ej4YYg3XR1zOSqBnlcHwvyE0g=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 173EuqjM065661
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Aug 2021 09:56:52 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 3 Aug
 2021 09:56:52 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 3 Aug 2021 09:56:52 -0500
Received: from [10.250.232.234] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 173Euia3020120;
        Tue, 3 Aug 2021 09:56:45 -0500
Subject: Re: [PATCH v7 5/7] PCI: cadence: Add support to configure virtual
 functions
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
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
References: <20210803050310.27122-1-kishon@ti.com>
 <20210803050310.27122-6-kishon@ti.com> <20210803114530.GE11252@lpieralisi>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <be907fe7-4095-e28b-5575-76629edc30f0@ti.com>
Date:   Tue, 3 Aug 2021 20:26:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210803114530.GE11252@lpieralisi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 03/08/21 5:15 pm, Lorenzo Pieralisi wrote:
> On Tue, Aug 03, 2021 at 10:33:08AM +0530, Kishon Vijay Abraham I wrote:
>> Now that support for SR-IOV is added in PCIe endpoint core, add support
>> to configure virtual functions in the Cadence PCIe EP driver.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Acked-by: Tom Joseph <tjoseph@cadence.com>
>> ---
>>  .../pci/controller/cadence/pcie-cadence-ep.c  | 241 +++++++++++++++---
>>  drivers/pci/controller/cadence/pcie-cadence.h |   7 +
>>  2 files changed, 217 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> index 912a15be8bfd..791915054ff4 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> @@ -20,7 +20,18 @@ static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
>>  				     struct pci_epf_header *hdr)
>>  {
>>  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>> +	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
>>  	struct cdns_pcie *pcie = &ep->pcie;
>> +	u32 reg;
>> +
>> +	if (vfn > 1) {
>> +		dev_dbg(&epc->dev, "Only Virtual Function #1 has deviceID\n");
>> +		return 0;
> 
> Shouldn't this return an error ?

Since the same function driver could be used for physical function and
virtual function, I tried to avoid adding any additional case specific
for virtual function in the function driver.

If we want to return an error here, then the function driver should be
modified to not invoke writeheader for vfn > 1.
> 
>> +	} else if (vfn == 1) {
>> +		reg = cap + PCI_SRIOV_VF_DID;
>> +		cdns_pcie_ep_fn_writew(pcie, fn, reg, hdr->deviceid);
>> +		return 0;
>> +	}
>>  
>>  	cdns_pcie_ep_fn_writew(pcie, fn, PCI_DEVICE_ID, hdr->deviceid);
>>  	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_REVISION_ID, hdr->revid);
>> @@ -51,12 +62,14 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>>  				struct pci_epf_bar *epf_bar)
>>  {
>>  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>> +	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
>>  	struct cdns_pcie_epf *epf = &ep->epf[fn];
>>  	struct cdns_pcie *pcie = &ep->pcie;
>>  	dma_addr_t bar_phys = epf_bar->phys_addr;
>>  	enum pci_barno bar = epf_bar->barno;
>>  	int flags = epf_bar->flags;
>>  	u32 addr0, addr1, reg, cfg, b, aperture, ctrl;
>> +	u32 first_vf_offset, stride;
>>  	u64 sz;
>>  
>>  	/* BAR size is 2^(aperture + 7) */
>> @@ -92,26 +105,50 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>>  
>>  	addr0 = lower_32_bits(bar_phys);
>>  	addr1 = upper_32_bits(bar_phys);
>> +
>> +	if (vfn == 1) {
>> +		/* All virtual functions use the same BAR config */
>> +		if (bar < BAR_4) {
>> +			reg = CDNS_PCIE_LM_EP_VFUNC_BAR_CFG0(fn);
>> +			b = bar;
>> +		} else {
>> +			reg = CDNS_PCIE_LM_EP_VFUNC_BAR_CFG1(fn);
>> +			b = bar - BAR_4;
>> +		}
>> +	} else if (vfn == 0) {
>> +		/* BAR configuration for physical function */
>> +		if (bar < BAR_4) {
>> +			reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn);
>> +			b = bar;
>> +		} else {
>> +			reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn);
>> +			b = bar - BAR_4;
>> +		}
>> +	}
> 
> Code in both branches is almost identical except for what is
> assigned to reg, it is not fundamental but maybe it can be rewritten
> more concisely.

okay.. let me think.

Thanks
Kishon
