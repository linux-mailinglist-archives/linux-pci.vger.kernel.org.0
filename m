Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F8F1DC5A5
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 05:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgEUDau (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 23:30:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44024 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgEUDat (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 23:30:49 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04L3UaIk091192;
        Wed, 20 May 2020 22:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590031836;
        bh=b6oEC2PB2pjw4Mn+qzNvfqJC+/OpQLwrj1RTuLQtQwQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JO3hOK9dmY6s1gbbvAjsW2uFby9AjDV1qyuNfY03uf01UhQ3Yz7ifb9zZorzxAOt4
         BTYt45eqipApPucs7R1iMcN9WHmjRunRmlrgWtN3kkg2/bJI7GfuLe/VTRI293EhVy
         +ZjsRrFUJzEtObV7XGG6KLJ0+2xvELfo3wTdlJQA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04L3UaTi053753
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 22:30:36 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 20
 May 2020 22:30:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 20 May 2020 22:30:36 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04L3UXwZ121668;
        Wed, 20 May 2020 22:30:33 -0500
Subject: Re: [PATCH v3 4/4] PCI: cadence: Use "dma-ranges" instead of
 "cdns,no-bar-match-nbits" property
To:     Rob Herring <robh+dt@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tom Joseph <tjoseph@cadence.com>,
        PCI <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200508130646.23939-1-kishon@ti.com>
 <20200508130646.23939-5-kishon@ti.com>
 <CAL_JsqJ1Om2CX5e1y32bzeiuv4fAdyFpZ88a346g4Q+jq_Ldcg@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <162447e2-ac3b-9523-d404-130b93e0860e@ti.com>
Date:   Thu, 21 May 2020 09:00:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ1Om2CX5e1y32bzeiuv4fAdyFpZ88a346g4Q+jq_Ldcg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 5/19/2020 10:41 PM, Rob Herring wrote:
> On Fri, May 8, 2020 at 7:07 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Cadence PCIe core driver (host mode) uses "cdns,no-bar-match-nbits"
>> property to configure the number of bits passed through from PCIe
>> address to internal address in Inbound Address Translation register.
>> This only used the NO MATCH BAR.
>>
>> However standard PCI dt-binding already defines "dma-ranges" to
>> describe the address ranges accessible by PCIe controller. Add support
>> in Cadence PCIe host driver to parse dma-ranges and configure the
>> inbound regions for BAR0, BAR1 and NO MATCH BAR. Cadence IP specifies
>> maximum size for BAR0 as 256GB, maximum size for BAR1 as 2 GB, so if
>> the dma-ranges specifies a size larger than the maximum allowed, the
>> driver will split and configure the BARs.
> 
> Would be useful to know what your dma-ranges contains now.
> 
> 
>> Legacy device tree binding compatibility is maintained by retaining
>> support for "cdns,no-bar-match-nbits".
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../controller/cadence/pcie-cadence-host.c    | 141 ++++++++++++++++--
>>  drivers/pci/controller/cadence/pcie-cadence.h |  17 ++-
>>  2 files changed, 141 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 6ecebb79057a..2485ecd8434d 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -11,6 +11,12 @@
>>
>>  #include "pcie-cadence.h"
>>
>> +static u64 cdns_rp_bar_max_size[] = {
>> +       [RP_BAR0] = _ULL(128 * SZ_2G),
>> +       [RP_BAR1] = SZ_2G,
>> +       [RP_NO_BAR] = SZ_64T,
>> +};
>> +
>>  void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>>                                int where)
>>  {
>> @@ -106,6 +112,117 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>>         return 0;
>>  }
>>
>> +static void cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
>> +                                        enum cdns_pcie_rp_bar bar,
>> +                                        u64 cpu_addr, u32 aperture)
>> +{
>> +       struct cdns_pcie *pcie = &rc->pcie;
>> +       u32 addr0, addr1;
>> +
>> +       addr0 = CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS(aperture) |
>> +               (lower_32_bits(cpu_addr) & GENMASK(31, 8));
>> +       addr1 = upper_32_bits(cpu_addr);
>> +       cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR0(bar), addr0);
>> +       cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar), addr1);
>> +}
>> +
>> +static int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
>> +                                    struct resource_entry *entry,
>> +                                    enum cdns_pcie_rp_bar *index)
>> +{
>> +       u64 cpu_addr, pci_addr, size, winsize;
>> +       struct cdns_pcie *pcie = &rc->pcie;
>> +       struct device *dev = pcie->dev;
>> +       enum cdns_pcie_rp_bar bar;
>> +       unsigned long flags;
>> +       u32 aperture;
>> +       u32 value;
>> +
>> +       cpu_addr = entry->res->start;
>> +       flags = entry->res->flags;
>> +       pci_addr = entry->res->start - entry->offset;
>> +       size = resource_size(entry->res);
>> +       bar = *index;
>> +
>> +       if (entry->offset) {
>> +               dev_err(dev, "Cannot map PCI addr: %llx to CPU addr: %llx\n",
>> +                       pci_addr, cpu_addr);
> 
> Would be a bit more clear to say PCI addr must equal CPU addr.
> 
>> +               return -EINVAL;
>> +       }
>> +
>> +       value = cdns_pcie_readl(pcie, CDNS_PCIE_LM_RC_BAR_CFG);
>> +       while (size > 0) {
>> +               if (bar > RP_NO_BAR) {
>> +                       dev_err(dev, "Failed to map inbound regions!\n");
>> +                       return -EINVAL;
>> +               }
>> +
>> +               winsize = size;
>> +               if (size > cdns_rp_bar_max_size[bar])
>> +                       winsize = cdns_rp_bar_max_size[bar];
>> +
>> +               aperture = ilog2(winsize);
>> +
>> +               cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr, aperture);
>> +
>> +               if (bar == RP_NO_BAR)
>> +                       break;
>> +
>> +               if (winsize + cpu_addr >= SZ_4G) {
>> +                       if (!(flags & IORESOURCE_PREFETCH))
>> +                               value |= LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar);
>> +                       value |= LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
>> +               } else {
>> +                       if (!(flags & IORESOURCE_PREFETCH))
>> +                               value |= LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
>> +                       value |= LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
>> +               }
>> +
>> +               value |= LM_RC_BAR_CFG_APERTURE(bar, aperture);
>> +
>> +               size -= winsize;
>> +               cpu_addr += winsize;
>> +               bar++;
>> +       }
>> +       cdns_pcie_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
>> +       *index = bar;
>> +
>> +       return 0;
>> +}
>> +
>> +static int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc)
>> +{
>> +       enum cdns_pcie_rp_bar bar = RP_BAR0;
>> +       struct cdns_pcie *pcie = &rc->pcie;
>> +       struct device *dev = pcie->dev;
>> +       struct device_node *np = dev->of_node;
>> +       struct pci_host_bridge *bridge;
>> +       struct resource_entry *entry;
>> +       u32 no_bar_nbits = 32;
>> +       int err;
>> +
>> +       bridge = pci_host_bridge_from_priv(rc);
>> +       if (!bridge)
>> +               return -ENOMEM;
>> +
>> +       if (list_empty(&bridge->dma_ranges)) {
>> +               of_property_read_u32(np, "cdns,no-bar-match-nbits",
>> +                                    &no_bar_nbits);
>> +               cdns_pcie_host_bar_ib_config(rc, RP_NO_BAR, 0x0, no_bar_nbits);
>> +               return 0;
>> +       }
>> +
>> +       resource_list_for_each_entry(entry, &bridge->dma_ranges) {
>> +               err = cdns_pcie_host_bar_config(rc, entry, &bar);
> 
> Seems like this should have some better logic to pick which BAR to
> use. Something like find the biggest region and then find the smallest
> BAR that it fits in. Then get the next biggest...

Okay, I'll change this something like for each region, find the smallest BAR
that it fits in and if there is no BAR big enough to hold the region, split the
region to see if can be fitted using multiple BARs. I don't see the purpose of
finding the biggest region first since at all times we'll only use the smallest
BAR to fit.

Thanks
Kishon
