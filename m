Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF691DDDEA
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 05:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgEVDgh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 23:36:37 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40664 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgEVDgh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 23:36:37 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04M3aLPc037280;
        Thu, 21 May 2020 22:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590118581;
        bh=HrQjWJ1fQIqu1ayf7fVo3VgYbxThYydlatrnKWcfJzQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tfwDFl2F4veF+44wEnyZlowAjXC0drn3TmboAkdNp0ZOyAkE78ogBwSbSWqLldhL3
         Qhuhq/XcUxjP2k8I5fxsrbCSvPrp4cNNbO92twrmXmJohLjODsk1oo8VoEkfVkVTLl
         +JrPaxJngNCUWSZzjOCCvzuHum4WA3kwsXqiceZU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04M3aLWW007398;
        Thu, 21 May 2020 22:36:21 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 22:36:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 22:36:21 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04M3aHDv049868;
        Thu, 21 May 2020 22:36:18 -0500
Subject: Re: [PATCH v4 03/14] PCI: cadence: Add support to use custom read and
 write accessors
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        PCI <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200506151429.12255-1-kishon@ti.com>
 <20200506151429.12255-4-kishon@ti.com> <20200520220724.GA636352@bogus>
 <37d2d6c3-232d-adb8-4e0b-e0c699ec435a@ti.com>
 <CAL_JsqK8xRTxuJ39yPMzE1JMBrYccXB5QqsSvn7HosvrEQGdWQ@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <0bb5280c-99d1-6b33-ce69-5698f9902415@ti.com>
Date:   Fri, 22 May 2020 09:06:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK8xRTxuJ39yPMzE1JMBrYccXB5QqsSvn7HosvrEQGdWQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 5/22/2020 3:47 AM, Rob Herring wrote:
> On Thu, May 21, 2020 at 7:33 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi Rob,
>>
>> On 5/21/2020 3:37 AM, Rob Herring wrote:
>>> On Wed, May 06, 2020 at 08:44:18PM +0530, Kishon Vijay Abraham I wrote:
>>>> Add support to use custom read and write accessors. Platforms that
>>>> don't support half word or byte access or any other constraint
>>>> while accessing registers can use this feature to populate custom
>>>> read and write accessors. These custom accessors are used for both
>>>> standard register access and configuration space register access of
>>>> the PCIe host bridge.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>  drivers/pci/controller/cadence/pcie-cadence.h | 107 +++++++++++++++---
>>>>  1 file changed, 94 insertions(+), 13 deletions(-)
>>>
>>> Actually, take back my R-by...
>>>
>>>>
>>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
>>>> index df14ad002fe9..70b6b25153e8 100644
>>>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>>>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>>>> @@ -223,6 +223,11 @@ enum cdns_pcie_msg_routing {
>>>>      MSG_ROUTING_GATHER,
>>>>  };
>>>>
>>>> +struct cdns_pcie_ops {
>>>> +    u32     (*read)(void __iomem *addr, int size);
>>>> +    void    (*write)(void __iomem *addr, int size, u32 value);
>>>> +};
>>>> +
>>>>  /**
>>>>   * struct cdns_pcie - private data for Cadence PCIe controller drivers
>>>>   * @reg_base: IO mapped register base
>>>> @@ -239,7 +244,7 @@ struct cdns_pcie {
>>>>      int                     phy_count;
>>>>      struct phy              **phy;
>>>>      struct device_link      **link;
>>>> -    const struct cdns_pcie_common_ops *ops;
>>>> +    const struct cdns_pcie_ops *ops;
>>>>  };
>>>>
>>>>  /**
>>>> @@ -299,69 +304,145 @@ struct cdns_pcie_ep {
>>>>  /* Register access */
>>>>  static inline void cdns_pcie_writeb(struct cdns_pcie *pcie, u32 reg, u8 value)
>>>>  {
>>>> -    writeb(value, pcie->reg_base + reg);
>>>> +    void __iomem *addr = pcie->reg_base + reg;
>>>> +
>>>> +    if (pcie->ops && pcie->ops->write) {
>>>> +            pcie->ops->write(addr, 0x1, value);
>>>> +            return;
>>>> +    }
>>>> +
>>>> +    writeb(value, addr);
>>>>  }
>>>>
>>>>  static inline void cdns_pcie_writew(struct cdns_pcie *pcie, u32 reg, u16 value)
>>>>  {
>>>> -    writew(value, pcie->reg_base + reg);
>>>> +    void __iomem *addr = pcie->reg_base + reg;
>>>> +
>>>> +    if (pcie->ops && pcie->ops->write) {
>>>> +            pcie->ops->write(addr, 0x2, value);
>>>> +            return;
>>>> +    }
>>>> +
>>>> +    writew(value, addr);
>>>>  }
>>>
>>> cdns_pcie_writeb and cdns_pcie_writew are used, so remove them.
>>>
>>>>
>>>>  static inline void cdns_pcie_writel(struct cdns_pcie *pcie, u32 reg, u32 value)
>>>>  {
>>>> -    writel(value, pcie->reg_base + reg);
>>>> +    void __iomem *addr = pcie->reg_base + reg;
>>>> +
>>>> +    if (pcie->ops && pcie->ops->write) {
>>>> +            pcie->ops->write(addr, 0x4, value);
>>>> +            return;
>>>> +    }
>>>> +
>>>> +    writel(value, addr);
>>>
>>> writel isn't broken for you, so you don't need this either.
>>>
>>>>  }
>>>>
>>>>  static inline u32 cdns_pcie_readl(struct cdns_pcie *pcie, u32 reg)
>>>>  {
>>>> -    return readl(pcie->reg_base + reg);
>>>> +    void __iomem *addr = pcie->reg_base + reg;
>>>> +
>>>> +    if (pcie->ops && pcie->ops->read)
>>>> +            return pcie->ops->read(addr, 0x4);
>>>> +
>>>> +    return readl(addr);
>>>
>>> And neither is readl.
>>
>> Sure, I'll remove all the unused functions and avoid using ops for readl and
>> writel.
>>>
>>>>  }
>>>>
>>>>  /* Root Port register access */
>>>>  static inline void cdns_pcie_rp_writeb(struct cdns_pcie *pcie,
>>>>                                     u32 reg, u8 value)
>>>>  {
>>>> -    writeb(value, pcie->reg_base + CDNS_PCIE_RP_BASE + reg);
>>>> +    void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
>>>> +
>>>> +    if (pcie->ops && pcie->ops->write) {
>>>> +            pcie->ops->write(addr, 0x1, value);
>>>> +            return;
>>>> +    }
>>>> +
>>>> +    writeb(value, addr);
>>>>  }
>>>>
>>>>  static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
>>>>                                     u32 reg, u16 value)
>>>>  {
>>>> -    writew(value, pcie->reg_base + CDNS_PCIE_RP_BASE + reg);
>>>> +    void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
>>>> +
>>>> +    if (pcie->ops && pcie->ops->write) {
>>>> +            pcie->ops->write(addr, 0x2, value);
>>>> +            return;
>>>> +    }
>>>> +
>>>> +    writew(value, addr);
>>>
>>> You removed 2 out of 3 calls to this. I think I'd just make the root
>>> port writes always be 32-bit. It is all just one time init stuff
>>> anyways.
>>>
>>> Either rework the calls to assemble the data into 32-bits or keep these
>>> functions and do the RMW here.
>>
>> The problem with assembling data into 32-bits is we have to read/write with
>> different offsets. We'll give PCI_VENDOR_ID offset for modifying deviceID,
>> PCI_INTERRUPT_LINE for modifying INTERRUPT_PIN which might get non-intuitive.
>> Similarly in endpoint we read and write to MSI_FLAGS (which is at offset 2) we
>> have to directly use MSI capability offset.
>>
>> And doing RMW in the accessors would mean the same RMW op is repeated. So if we
>> just have cdns_pcie_rp_writeb() and cdns_pcie_rp_writew(), the same code will
>> be repeated here twice.
> 
> Why repeated? Just copy what the config accessors do:
> 
> static inline void cdns_pcie_write_sz(u32 val, void __iomem *addr, int size)
> {
>   u32 tmp, mask, where = (unsigned long)addr & 0x3;
> 
>   addr -= where;
> 
>   mask = ~(((1 << (size * 8)) - 1) << (where * 8));
>   tmp = readl(addr) & mask;
>   tmp |= val << (where * 8);
>   writel(tmp, addr);
> }
> 
> /* Root Port register access */
> static inline void cdns_pcie_rp_writeb(struct cdns_pcie *pcie,
>        u32 reg, u8 value)
> {
>   cdns_pcie_write_sz(value, pcie->reg_base + CDNS_PCIE_RP_BASE + reg, 1);
> }
> 
> static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
>        u32 reg, u16 value)
> {
>   cdns_pcie_write_sz(value, pcie->reg_base + CDNS_PCIE_RP_BASE + reg, 2);
> }
> 
>>
>> IMHO using ops is a lot cleaner for these cases. IMHO except for removing
>> unused functions and not changing readl/writel, others should use ops.
> 
> Trying to read the DW PCI driver I don't agree...
> 
> Again, unless doing RMW is fundamentally broken (like it is for config
> space at runtime), then you only want to do it on broken h/w and ops
> would be appropriate. It is all mostly one time setup, so doing a few
> extra reads isn't a big deal. If you really care about speed on that,
> probably should use the _relaxed accessor variants.
> 
> I'm being hopeful the Cadence IP doesn't become the mess that DW is.

Okay, I'll remove ops for read/write accessors.

Thanks
Kishon
