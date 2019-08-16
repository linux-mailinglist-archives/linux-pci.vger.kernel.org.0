Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7F4990048
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 12:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfHPKwK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 06:52:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50056 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfHPKwJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Aug 2019 06:52:09 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7GApdHN004849;
        Fri, 16 Aug 2019 05:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565952699;
        bh=hn8fy2leOOJ2v5vDgwq8C00AfqgX3leZ0vhsRcjx8Kc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=D58NfWon6bgolsIr719N63cAQowNbSydh3J9Dt6vskmGUNY9McMH6xZEFtYU9Y/jE
         qoCCFFrtaTIcdYpaXFj7CjGEoLDXrQRX9u58x+iEOvDnyh9mHsFQ2aY5gVb/NWhB+1
         r2AVDLGnnEqvOkAaq8NvlRSISc/GpIWJZcYskhM8=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7GApdDJ001483
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Aug 2019 05:51:39 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 16
 Aug 2019 05:51:39 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 16 Aug 2019 05:51:39 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7GApXr5015579;
        Fri, 16 Aug 2019 05:51:34 -0500
Subject: Re: [PATCH 02/10] PCI: designware-ep: Add the doorbell mode of MSI-X
 in EP mode
To:     Xiaowei Bao <xiaowei.bao@nxp.com>,
        Andrew Murray <andrew.murray@arm.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
References: <20190815083716.4715-1-xiaowei.bao@nxp.com>
 <20190815083716.4715-2-xiaowei.bao@nxp.com>
 <20190815115340.GG43882@e119886-lin.cambridge.arm.com>
 <AM5PR04MB329973845D6396624AFDE547F5AF0@AM5PR04MB3299.eurprd04.prod.outlook.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <02cf2f3d-336c-85bb-1fb5-a141c5a9cf79@ti.com>
Date:   Fri, 16 Aug 2019 16:19:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <AM5PR04MB329973845D6396624AFDE547F5AF0@AM5PR04MB3299.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 16/08/19 8:28 AM, Xiaowei Bao wrote:
> 
> 
>> -----Original Message-----
>> From: Andrew Murray <andrew.murray@arm.com>
>> Sent: 2019��8��15�� 19:54
>> To: Xiaowei Bao <xiaowei.bao@nxp.com>
>> Cc: jingoohan1@gmail.com; gustavo.pimentel@synopsys.com;
>> bhelgaas@google.com; robh+dt@kernel.org; mark.rutland@arm.com;
>> shawnguo@kernel.org; Leo Li <leoyang.li@nxp.com>; kishon@ti.com;
>> lorenzo.pieralisi@arm.com; arnd@arndb.de; gregkh@linuxfoundation.org;
>> M.h. Lian <minghuan.lian@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>;
>> Roy Zang <roy.zang@nxp.com>; linux-pci@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org
>> Subject: Re: [PATCH 02/10] PCI: designware-ep: Add the doorbell mode of
>> MSI-X in EP mode
>>
>> On Thu, Aug 15, 2019 at 04:37:08PM +0800, Xiaowei Bao wrote:
>>> Add the doorbell mode of MSI-X in EP mode.
>>>
>>> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
>>> ---
>>>  drivers/pci/controller/dwc/pcie-designware-ep.c | 14 ++++++++++++++
>>>  drivers/pci/controller/dwc/pcie-designware.h    | 14 ++++++++++++++
>>>  2 files changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> index 75e2955..e3a7cdf 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> @@ -454,6 +454,20 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep
>> *ep, u8 func_no,
>>>  	return 0;
>>>  }
>>>
>>> +int dw_pcie_ep_raise_msix_irq_doorbell(struct dw_pcie_ep *ep, u8
>> func_no,
>>> +				       u16 interrupt_num)
>>> +{
>>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>> +	u32 msg_data;
>>> +
>>> +	msg_data = (func_no << PCIE_MSIX_DOORBELL_PF_SHIFT) |
>>> +		   (interrupt_num - 1);
>>> +
>>> +	dw_pcie_writel_dbi(pci, PCIE_MSIX_DOORBELL, msg_data);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>>>  			      u16 interrupt_num)
>>
>> Have I understood correctly that the hardware provides an alternative
>> mechanism that allows for raising MSI-X interrupts without the bother of
>> reading the capabilities registers?
> Yes, the hardware provide two way to MSI-X, please check the page 492 of 
> DWC_pcie_dm_registers_4.30 Menu.
> MSIX_DOORBELL_OFF on page 492 0x948 Description: MSI-X Doorbell Register....>
>>
>> If so is there any good reason to keep dw_pcie_ep_raise_msix_irq? (And thus
>> use it in dw_plat_pcie_ep_raise_irq also)?
> I am not sure, but I think the dw_pcie_ep_raise_msix_irq function is not correct, 
> because I think we can't get the MSIX table from the address ep->phys_base + tbl_addr, 
> but I also don't know where I can get the correct MSIX table.

Sometime back when I tried raising MSI-X from EP, it was failing. It's quite
possible dw_pcie_ep_raise_msix_irq function is not correct.

MSI-X table can be obtained from the inbound ATU corresponding to the MSIX bar.
IMO MSI-X support in EP mode needs rework. For instance set_msix should also
take BAR number as input to be configured in the MSI-X capability. The function
driver (pci-epf-test.c) should allocate memory taking into account the MSI-X table.

Thanks
Kishon
