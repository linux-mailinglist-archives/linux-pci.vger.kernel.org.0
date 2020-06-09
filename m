Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300771F3D06
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 15:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgFINqw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 09:46:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51428 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgFINqv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 09:46:51 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 059DkcNx024577;
        Tue, 9 Jun 2020 08:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591710398;
        bh=CRDrwcybVT9N4+Rd1TgbkKxzZEB1yAs9hUhxticrpIY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=neUnJu+mO8NHT+A4pwdDZdXv50a43/WeXz/kI8Il9FmHC80yKySP12nAfZBNIhTKi
         hztEM11yYm1pR4rM7RUwRqKTBb6xhumzbA8AbyWiv0NL1m/yNeVMB91VrBSj8mmADl
         yVLOQkcUE2Lnb9sGdaF8lTXSkhOvBPbjXI2ijDzc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 059Dkc2R056437;
        Tue, 9 Jun 2020 08:46:38 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 9 Jun
 2020 08:46:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 9 Jun 2020 08:46:37 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 059DkZi5124176;
        Tue, 9 Jun 2020 08:46:35 -0500
Subject: Re: [PATCH v4] PCI: cadence: Use "dma-ranges" instead of
 "cdns,no-bar-match-nbits" property
To:     Rob Herring <robh@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200521080153.5902-1-kishon@ti.com>
 <CAL_Jsq+ZScKn1BJ9YWcs1uNEmLq5+XOdWfFNfF-S7cAqkYB1KA@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <8b30d785-7f21-92e4-47e9-c8bfe76cc6cc@ti.com>
Date:   Tue, 9 Jun 2020 19:16:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+ZScKn1BJ9YWcs1uNEmLq5+XOdWfFNfF-S7cAqkYB1KA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 5/27/2020 3:29 AM, Rob Herring wrote:
> On Thu, May 21, 2020 at 2:02 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
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
>> maximum size for BAR0 as 256GB, maximum size for BAR1 as 2 GB.
>>
>> This adds support to take the next biggest region in "dma-ranges" and
>> find the smallest BAR that each of the regions fit in and if there is
>> no BAR big enough to hold the region, split the region to see if it can
>> be fitted using multiple BARs.
>>
>> "dma-ranges" of J721E will be
>> dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
>> Since there is no BAR which can hold 2^48 size, NO_MATCH_BAR will be
>> used here.
>>
>> Legacy device tree binding compatibility is maintained by retaining
>> support for "cdns,no-bar-match-nbits".
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>> The previous version of the patch can be found @
>> https://lore.kernel.org/linux-arm-kernel/20200508130646.23939-5-kishon@ti.com/
>>
>> Changes from v3:
>> *) The whole logic of how we select a BAR to fit a region from
>> dma-ranges has been changed.
>>   1) First select the biggest region in "dma-ranges" (after combining
>>      adjacent regions)
>>   2) Try to fit this region in a smallest available BAR whose size is
>>      greater than the region size
>>   3) If no such BAR is available try to find biggest availalbe BAR
>>      whose size is lesser than the region size and only fit part of the
>>      region in that BAR.
>>   4) Repeat steps 3 and 4, to fit the remaining region size.
>>  .../controller/cadence/pcie-cadence-host.c    | 254 +++++++++++++++++-
>>  drivers/pci/controller/cadence/pcie-cadence.h |  28 +-
>>  2 files changed, 265 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 6ecebb79057a..cf8b34b71b8f 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -11,6 +11,12 @@
>>
>>  #include "pcie-cadence.h"
>>
>> +static u64 bar_max_size[] = {
>> +       [RP_BAR0] = _ULL(128 * SZ_2G),
>> +       [RP_BAR1] = SZ_2G,
>> +       [RP_NO_BAR] = _BITULL(63),
>> +};
>> +
>>  void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>>                                int where)
>>  {
>> @@ -106,6 +112,226 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>>         return 0;
>>  }
>>
>> +static int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
>> +                                       enum cdns_pcie_rp_bar bar,
>> +                                       u64 cpu_addr, u64 size,
>> +                                       unsigned long flags)
>> +{
>> +       struct cdns_pcie *pcie = &rc->pcie;
>> +       u32 addr0, addr1, aperture, value;
>> +
>> +       if (!rc->avail_ib_bar[bar])
>> +               return -EBUSY;
>> +
>> +       rc->avail_ib_bar[bar] = false;
>> +
>> +       aperture = ilog2(size);
>> +       addr0 = CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS(aperture) |
>> +               (lower_32_bits(cpu_addr) & GENMASK(31, 8));
>> +       addr1 = upper_32_bits(cpu_addr);
>> +       cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR0(bar), addr0);
>> +       cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar), addr1);
>> +
>> +       if (bar == RP_NO_BAR)
>> +               return 0;
>> +
>> +       value = cdns_pcie_readl(pcie, CDNS_PCIE_LM_RC_BAR_CFG);
> 
> Why do you need to read this first? If you do, don't you need to clear
> out any fields you're potentially writing?

Part of the initialization is done in cdns_pcie_host_init_root_port() and part
here. I'll add code to clear out the fields.
> 
>> +       if (size + cpu_addr >= SZ_4G) {
>> +               if (!(flags & IORESOURCE_PREFETCH))
>> +                       value |= LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar);
>> +               value |= LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
>> +       } else {
>> +               if (!(flags & IORESOURCE_PREFETCH))
>> +                       value |= LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
>> +               value |= LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
>> +       }
>> +
>> +       value |= LM_RC_BAR_CFG_APERTURE(bar, aperture);
>> +       cdns_pcie_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
>> +
>> +       return 0;
>> +}
>> +
>> +static enum cdns_pcie_rp_bar
>> +cdns_pcie_host_find_min_bar(struct cdns_pcie_rc *rc, u64 size)
>> +{
>> +       enum cdns_pcie_rp_bar bar, sel_bar;
>> +
>> +       sel_bar = RP_BAR_UNDEFINED;
>> +       for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++) {
>> +               if (!rc->avail_ib_bar[bar])
>> +                       continue;
>> +
>> +               if (size <= bar_max_size[bar]) {
>> +                       if (sel_bar == RP_BAR_UNDEFINED) {
>> +                               sel_bar = bar;
>> +                               continue;
>> +                       }
>> +
>> +                       if (bar_max_size[bar] < bar_max_size[sel_bar])
>> +                               sel_bar = bar;
>> +               }
>> +       }
>> +
>> +       return sel_bar;
>> +}
>> +
>> +static enum cdns_pcie_rp_bar
>> +cdns_pcie_host_find_max_bar(struct cdns_pcie_rc *rc, u64 size)
>> +{
>> +       enum cdns_pcie_rp_bar bar, sel_bar;
>> +
>> +       sel_bar = RP_BAR_UNDEFINED;
>> +       for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++) {
>> +               if (!rc->avail_ib_bar[bar])
>> +                       continue;
>> +
>> +               if (size >= bar_max_size[bar]) {
>> +                       if (sel_bar == RP_BAR_UNDEFINED) {
>> +                               sel_bar = bar;
>> +                               continue;
>> +                       }
>> +
>> +                       if (bar_max_size[bar] > bar_max_size[sel_bar])
>> +                               sel_bar = bar;
>> +               }
>> +       }
>> +
>> +       return sel_bar;
>> +}
>> +
>> +static int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
>> +                                    struct resource_entry *entry)
>> +{
>> +       u64 cpu_addr, pci_addr, size, winsize;
>> +       struct cdns_pcie *pcie = &rc->pcie;
>> +       struct device *dev = pcie->dev;
>> +       enum cdns_pcie_rp_bar bar;
>> +       unsigned long flags;
>> +       int ret;
>> +
>> +       cpu_addr = entry->res->start;
>> +       pci_addr = entry->res->start - entry->offset;
>> +       flags = entry->res->flags;
>> +       size = resource_size(entry->res);
>> +
>> +       if (entry->offset) {
>> +               dev_err(dev, "PCI addr: %llx must be equal to CPU addr: %llx\n",
>> +                       pci_addr, cpu_addr);
>> +               return -EINVAL;
>> +       }
>> +
>> +       while (size > 0) {
>> +               /*
>> +                * Try to find a minimum BAR whose size is greater than
>> +                * or equal to the remaining resource_entry size. This will
>> +                * fail if the size of each of the available BARs is less than
>> +                * the remaining resource_entry size.
>> +                * If a minimum BAR is found, IB ATU will be configured and
>> +                * exited.
>> +                */
>> +               bar = cdns_pcie_host_find_min_bar(rc, size);
>> +               if (bar != RP_BAR_UNDEFINED) {
>> +                       ret = cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr,
>> +                                                          size, flags);
>> +                       if (ret)
>> +                               dev_err(dev, "IB BAR: %d config failed\n", bar);
>> +                       return ret;
>> +               }
>> +
>> +               /*
>> +                * If the control reaches here, it would mean the remaining
>> +                * resource_entry size cannot be fitted in a single BAR. So we
>> +                * find a maximum BAR whose size is less than or equal to the
>> +                * remaining resource_entry size and split the resource entry
>> +                * so that part of resource entry is fitted inside the maximum
>> +                * BAR. The remaining size would be fitted during the next
>> +                * iteration of the loop.
>> +                * If a maximum BAR is not found, there is no way we can fit
>> +                * this resource_entry, so we error out.
>> +                */
>> +               bar = cdns_pcie_host_find_max_bar(rc, size);
>> +               if (bar == RP_BAR_UNDEFINED) {
>> +                       dev_err(dev, "No free BAR to map cpu_addr %llx\n",
>> +                               cpu_addr);
>> +                       return -EINVAL;
>> +               }
>> +
>> +               winsize = bar_max_size[bar];
>> +               ret = cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr, winsize,
>> +                                                  flags);
>> +               if (ret) {
>> +                       dev_err(dev, "IB BAR: %d config failed\n", bar);
>> +                       return ret;
>> +               }
>> +
>> +               size -= winsize;
>> +               cpu_addr += winsize;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc)
>> +{
>> +       struct resource_entry *entry, *ib_range[CDNS_PCIE_RP_MAX_IB];
>> +       struct cdns_pcie *pcie = &rc->pcie;
>> +       struct device *dev = pcie->dev;
>> +       struct device_node *np = dev->of_node;
>> +       struct pci_host_bridge *bridge;
>> +       u32 no_bar_nbits = 32;
>> +       int i = 0, j = 0, err;
>> +       u64 size;
>> +
>> +       bridge = pci_host_bridge_from_priv(rc);
>> +       if (!bridge)
>> +               return -ENOMEM;
>> +
>> +       if (list_empty(&bridge->dma_ranges)) {
>> +               of_property_read_u32(np, "cdns,no-bar-match-nbits",
>> +                                    &no_bar_nbits);
>> +               err = cdns_pcie_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
>> +                                                  (u64)1 << no_bar_nbits, 0);
>> +               if (err)
>> +                       dev_err(dev, "IB BAR: %d config failed\n", RP_NO_BAR);
>> +               return err;
>> +       }
>> +
>> +       memset(ib_range, 0x00, sizeof(ib_range));
>> +       /* Sort the resource entries in descending order by resource size */
> 
> Use list_sort()

Not sure why it's needed but it's explicitly been sorted in ascending order
here in devm_of_pci_get_host_bridge_resources()
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/of.c#n377

Using list_sort() will disturb that.
> 
>> +       resource_list_for_each_entry(entry, &bridge->dma_ranges) {
>> +               if (i > CDNS_PCIE_RP_MAX_IB - 1) {
>> +                       dev_err(dev, "Ranges exceed maximum supported %d\n",
> 
> s/Ranges/dma-ranges entries/

Sure, will fix this.

Thanks
Kishon
