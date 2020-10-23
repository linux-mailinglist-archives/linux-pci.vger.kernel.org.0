Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DE02969FC
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 08:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373562AbgJWG5R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 02:57:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42338 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373514AbgJWG5R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 02:57:17 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09N6uw4Z017798;
        Fri, 23 Oct 2020 01:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603436218;
        bh=YudTYWiJAucQyueQrZhz7LaNUYfcee7zekZ8Agi5wNE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vXot5HyOf60SrtnZFvJj3ik8mLI19Ypk0FXQJ4efILgUuT2jQm6m3D2IWx8Kr70WE
         8mnxmsUC64K/G93/Ag/Mctb97OnuvADcBH5xwtnHGXALdbq7U0yYbTFm8b+H8C3OzN
         JoRrShMJZIBGa0kcWH7KIvyIEBuTb2neMtz2OpzE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09N6uwRA084096
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Oct 2020 01:56:58 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 23
 Oct 2020 01:56:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 23 Oct 2020 01:56:58 -0500
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09N6uq81086583;
        Fri, 23 Oct 2020 01:56:54 -0500
Subject: Re: [PATCH v3] PCI: cadence: Retrain Link to work around Gen2
 training defect.
To:     Athani Nadeem Ladkhan <nadeem@cadence.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>
CC:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>
References: <20200930182105.9752-1-nadeem@cadence.com>
 <a3a89720-6813-b344-630d-4cd2d6ccf24f@ti.com>
 <SN2PR07MB255715C886C2DC5B9044BC01D81E0@SN2PR07MB2557.namprd07.prod.outlook.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d2aa5519-e207-c3e5-9d81-14209d856b54@ti.com>
Date:   Fri, 23 Oct 2020 12:26:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <SN2PR07MB255715C886C2DC5B9044BC01D81E0@SN2PR07MB2557.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nadeem,

On 19/10/20 10:48 pm, Athani Nadeem Ladkhan wrote:
> Hi Kishon,
> 
>> -----Original Message-----
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>> Sent: Monday, October 19, 2020 10:59 AM
>> To: Athani Nadeem Ladkhan <nadeem@cadence.com>;
>> lorenzo.pieralisi@arm.com; robh@kernel.org; bhelgaas@google.com; linux-
>> pci@vger.kernel.org; linux-kernel@vger.kernel.org; Tom Joseph
>> <tjoseph@cadence.com>
>> Cc: Swapnil Kashinath Jakhade <sjakhade@cadence.com>; Milind Parab
>> <mparab@cadence.com>
>> Subject: Re: [PATCH v3] PCI: cadence: Retrain Link to work around Gen2
>> training defect.
>>
>> EXTERNAL MAIL
>>
>>
>> Hi Nadeem,
>>
>> On 30/09/20 11:51 pm, Nadeem Athani wrote:
>>> Cadence controller will not initiate autonomous speed change if
>>> strapped as Gen2. The Retrain Link bit is set as quirk to enable this speed
>> change.
>>>
>>> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
>>> ---
>>> Changes in v3:
>>> - To set retrain link bit,checking device capability & link status.
>>> - 32bit read in place of 8bit.
>>> - Minor correction in patch comment.
>>> - Change in variable & macro name.
>>> Changes in v2:
>>> - 16bit read in place of 8bit.
>>>  drivers/pci/controller/cadence/pcie-cadence-host.c | 31
>> ++++++++++++++++++++++
>>>  drivers/pci/controller/cadence/pcie-cadence.h      |  9 ++++++-
>>>  2 files changed, 39 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c
>>> b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>> index 4550e0d469ca..2b2ae4e18032 100644
>>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>> @@ -77,6 +77,36 @@ static struct pci_ops cdns_pcie_host_ops = {
>>>  	.write		= pci_generic_config_write,
>>>  };
>>>
>>> +static void cdns_pcie_retrain(struct cdns_pcie *pcie) {
>>> +	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
>>> +	u16 lnk_stat, lnk_ctl;
>>> +
>>> +	if (!cdns_pcie_link_up(pcie))
>>> +		return;
>>> +
>>
>> Is there a IP version that can be used to check if that quirk is applicable?
> There is no such provision.

hmm okay. Can we add a DT property to indicate the quirk then since
AFAIK this is not required in future revisions of IP.
>>> +	/*
>>> +	 * Set retrain bit if current speed is 2.5 GB/s,
>>> +	 * but the PCIe root port support is > 2.5 GB/s.
>>> +	 */
>>> +
>>> +	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE +
>> pcie_cap_off +
>>> +				      PCI_EXP_LNKCAP));
>>> +	if ((lnk_cap_sls & PCI_EXP_LNKCAP_SLS) <=
>> PCI_EXP_LNKCAP_SLS_2_5GB)
>>> +		return;
>>> +
>>> +	lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off +
>> PCI_EXP_LNKSTA);
>>> +	if ((lnk_stat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB)
>> {
>>> +		lnk_ctl = cdns_pcie_rp_readw(pcie,
>>> +					     pcie_cap_off + PCI_EXP_LNKCTL);
>>> +		lnk_ctl |= PCI_EXP_LNKCTL_RL;
>>> +		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
>>> +				    lnk_ctl);
>>> +
>>> +		if (!cdns_pcie_link_up(pcie))
>>
>> Should this rather be a cdns_pcie_host_wait_for_link()?
> The use of this api cdns_pcie_link_up was mentioned in earlier reviews.
> The mentioned api cdns_pcie_host_wait_for_link is a wrapper in which there are multiple checks.
> If insist, will replace with it.

yeah, I think we should give some time for the link up to succeed after
re-training.

Thanks
Kishon
