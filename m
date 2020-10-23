Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1027B296A61
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 09:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374431AbgJWHiw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 03:38:52 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14040 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374428AbgJWHiw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 03:38:52 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f92885b0000>; Fri, 23 Oct 2020 00:38:03 -0700
Received: from [10.40.202.195] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Oct
 2020 07:38:41 +0000
Subject: Re: [PATCH V2] PCI: dwc: Add support to handle prefetchable memory
 mapping
To:     Rob Herring <robh@kernel.org>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Andrew Murray" <amurray@thegoodpenguin.co.uk>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        <sagar.tv@gmail.com>
References: <20201005121351.32516-1-vidyas@nvidia.com>
 <20201020195931.12470-1-vidyas@nvidia.com>
 <CAL_Jsq+7caR1t=_v9Q_n43zEu9CNuiJmk0nPnvL8+S27rYhm9g@mail.gmail.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <baa80ff4-5510-5c7b-303c-454adbf88a19@nvidia.com>
Date:   Fri, 23 Oct 2020 13:08:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+7caR1t=_v9Q_n43zEu9CNuiJmk0nPnvL8+S27rYhm9g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603438683; bh=mmJkkDvyMQ7l3wbCnd/qCpAOQYmHLOG2drpV+/yBgDA=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=BOoSFNHru6k6NIBkTHh3Y3nmyVsWhRAASMiH2ycbb9h2Qy6U9ne7SisYDfKagB8x7
         F5v68WQjXlb8imVor/8NAsxe4m72JvBKAYFoAv3PJLsm60705GU4FxScHqm+azqhIn
         4VQZ4XRKtnvVGekrhgy3kEFrF9gxwdWEDiVz45C42mnphZxA+oB9DYyT/jIIIu2GjL
         UjjKmZ47Sfbla5ODmdWuUoiiPQaLS4xcAQjsKj/2jOfSeRMHJ5fZJt/sXrvmtLEpZd
         o2Qy1aT0VsQfv9F5BkA/4qgailJ0B/7PQXece+mGjXyjq6q6yruySMP23VPJaKmhNv
         3vPjHzMO0TZPA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/23/2020 12:38 AM, Rob Herring wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Oct 20, 2020 at 2:59 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>>
>> DWC sub-system currently doesn't differentiate between prefetchable and
>> non-prefetchable memory aperture entries in the 'ranges' property and
>> provides ATU mapping only for the first memory aperture entry out of all
>> the entries present. This was introduced by the
>> commit 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources").
>> Mapping for a memory apreture is required if its CPU address and the bus
>> address are different and the current mechanism works only if the memory
>> aperture which needs mapping happens to be the first entry. It doesn't
>> work either if the memory aperture that needs mapping is not the first
>> entry or if both prefetchable and non-prefetchable apertures need mapping.
> 
> Well that's subtle...
> 
>> This patch fixes this issue by differentiating between prefetchable and
>> non-prefetchable apertures in the 'ranges' property there by removing the
>> dependency on the order in which they are specified and adds support for
>> mapping prefetchable aperture using ATU region-3 if required.
> 
> Now you don't do any iATU entry for a 1:1 memory range which is a
> change for pretty much every other platform. That means we leave the
> PCI transaction config to the whims of how h/w designers hooked up the
> sideband signals. I guess this is how Uniphier works as it only has 1
> viewport...
> 
> I think the assignment should be in this order:
> - config space
> - non-prefetchable (IIRC, it's required)
> - prefetchable
> - i/o
> 
> Stopping assignment and warning if you run out of viewports. Looking
> at the platforms, I think that would always work. There's only
> uniphier and ls1012a where we run out. Those would still behave the
> same.
As I see from the code this is how the current mapping is done

Region-0: [Fixed] Non-Prefetchable memory mapping

Region-1: [Shared] if the num of view ports <= 2
         Used for I/O by default but whenever config space is accessed, 
it is programmed to generate config space, and once done, will program 
it back for I/O generation. I'm not sure how they are synchonized when 
two different entities are trying to access the config space as well as 
the I/O at the same time.  I don't see any locking mechanism (or am I 
missing something here??)
           [Fixed] if the num of view ports > 2
         Used to generate configuration space accesses

Region-2: [Fixed] I/O accesses

Region-3: [Fixed] Prefetchable memory mapping (This patch is adding it)

I honestly think that an attempt to re-assing what region is used for 
what purpose should go into a different patch.

I agree that I'm removing configuring an iATU region if it is for 1:1 
memory mapping. What I heard from our HW designers is that it is the 
default behavior of the Synopsys IP that if the CPU access falls in the 
aperture owned by Synopsys IP and there is no iATU region mapped to 
capture and generate any specific transaction for that address, then, by 
default it generates a memory transaction over the PCIe bus.
It is also possible that some implementors might have chosen to alter 
this behavior. In any case, I can continue to have the iATU programming 
done irrespective of whether it is for 1:1 mapping or not.

> 
> 
>>
>> Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
>> Link: http://patchwork.ozlabs.org/project/linux-pci/patch/20200513190855.23318-1-vidyas@nvidia.com/
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V2:
>> * Rewrote commit subject and description
>> * Addressed review comments from Lorenzo
>>
>>   .../pci/controller/dwc/pcie-designware-host.c | 42 ++++++++++++++++---
>>   drivers/pci/controller/dwc/pcie-designware.c  | 12 +++---
>>   drivers/pci/controller/dwc/pcie-designware.h  |  4 +-
>>   3 files changed, 46 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index db547ee6ff3a..dae6da39bb90 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -521,9 +521,42 @@ static struct pci_ops dw_pcie_ops = {
>>          .write = pci_generic_config_write,
>>   };
>>
>> +static void dw_pcie_setup_mem_atu(struct pcie_port *pp,
>> +                                 struct resource_entry *win)
>> +{
>> +       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +
>> +       /* Check for prefetchable memory aperture */
>> +       if (win->res->flags & IORESOURCE_PREFETCH && win->offset) {
>> +               /* Number of view ports must at least be 4 to enable mapping */
>> +               if (pci->num_viewport < 4) {
>> +                       dev_warn(pci->dev,
>> +                                "Insufficient ATU regions to map Prefetchable memory\n");
>> +               } else {
>> +                       dw_pcie_prog_outbound_atu(pci,
>> +                                                 PCIE_ATU_REGION_INDEX3,
>> +                                                 PCIE_ATU_TYPE_MEM,
>> +                                                 win->res->start,
>> +                                                 win->res->start - win->offset,
>> +                                                 resource_size(win->res));
>> +               }
>> +       } else if (win->offset) { /* Non-prefetchable memory aperture */
>> +               if (upper_32_bits(resource_size(win->res)))
>> +                       dev_warn(pci->dev,
>> +                                "Memory resource size exceeds max for 32 bits\n");
> 
> This is not designware specific. Either core code should check this or
> write a DT schema to check it.
Ok. I'll move it to pci_parse_request_of_pci_ranges() API. A change like 
below would do right?

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index ac24cd5439a9..6d872458196c 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -556,6 +556,11 @@ static int pci_parse_request_of_pci_ranges(struct 
device *dev,
                         break;
                 case IORESOURCE_MEM:
                         res_valid |= !(res->flags & IORESOURCE_PREFETCH);
+
+                       if (!(res->flags & IORESOURCE_PREFETCH))
+                               if (upper_32_bits(resource_size(res)))
+                                       dev_warn(dev,
+                                                "Memory resource size 
exceeds max for 32 bits\n");
                         break;
                 }
         }

I hope that is the right place for it.

> 
>> +               dw_pcie_prog_outbound_atu(pci,
>> +                                         PCIE_ATU_REGION_INDEX0,
>> +                                         PCIE_ATU_TYPE_MEM,
>> +                                         win->res->start,
>> +                                         win->res->start - win->offset,
>> +                                         resource_size(win->res));
>> +       }
>> +}
>> +
>>   void dw_pcie_setup_rc(struct pcie_port *pp)
>>   {
>>          u32 val, ctrl, num_ctrls;
>> +       struct resource_entry *win;
>>          struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>
>>          /*
>> @@ -578,13 +611,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>           * ATU, so we should not program the ATU here.
>>           */
>>          if (pp->bridge->child_ops == &dw_child_pcie_ops) {
>> -               struct resource_entry *entry =
>> -                       resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
>> +               resource_list_for_each_entry(win, &pp->bridge->windows)
>> +                       if (resource_type(win->res) == IORESOURCE_MEM)
>> +                               dw_pcie_setup_mem_atu(pp, win);
>>
>> -               dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
>> -                                         PCIE_ATU_TYPE_MEM, entry->res->start,
>> -                                         entry->res->start - entry->offset,
>> -                                         resource_size(entry->res));
>>                  if (pci->num_viewport > 2)
>>                          dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX2,
>>                                                    PCIE_ATU_TYPE_IO, pp->io_base,
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index c2dea8fc97c8..b5e438b70cd5 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -228,7 +228,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
>>   static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>>                                               int index, int type,
>>                                               u64 cpu_addr, u64 pci_addr,
>> -                                            u32 size)
>> +                                            u64 size)
> 
> How was this working for you before? Looks like a different change
> from what I broke.
Tegra194 has a 1:1 mapping for prefetchable memory as of today. But, 
when it is changed to a non 1:1 mapping, we need this support.

> 
>>   {
>>          u32 retries, val;
>>          u64 limit_addr = cpu_addr + size - 1;
>> @@ -245,8 +245,10 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>>                                   lower_32_bits(pci_addr));
>>          dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
>>                                   upper_32_bits(pci_addr));
>> -       dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
>> -                                type | PCIE_ATU_FUNC_NUM(func_no));
>> +       val = type | PCIE_ATU_FUNC_NUM(func_no);
>> +       val = upper_32_bits(size - 1) ?
>> +               val | PCIE_ATU_INCREASE_REGION_SIZE : val;
>> +       dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
>>          dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
>>                                   PCIE_ATU_ENABLE);
>>
>> @@ -267,7 +269,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>>
>>   static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>>                                          int index, int type, u64 cpu_addr,
>> -                                       u64 pci_addr, u32 size)
>> +                                       u64 pci_addr, u64 size)
>>   {
>>          u32 retries, val;
>>
>> @@ -311,7 +313,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>>   }
>>
>>   void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>> -                              u64 cpu_addr, u64 pci_addr, u32 size)
>> +                              u64 cpu_addr, u64 pci_addr, u64 size)
>>   {
>>          __dw_pcie_prog_outbound_atu(pci, 0, index, type,
>>                                      cpu_addr, pci_addr, size);
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 9d2f511f13fa..21dd06831b50 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -80,10 +80,12 @@
>>   #define PCIE_ATU_VIEWPORT              0x900
>>   #define PCIE_ATU_REGION_INBOUND                BIT(31)
>>   #define PCIE_ATU_REGION_OUTBOUND       0
>> +#define PCIE_ATU_REGION_INDEX3         0x3
>>   #define PCIE_ATU_REGION_INDEX2         0x2
>>   #define PCIE_ATU_REGION_INDEX1         0x1
>>   #define PCIE_ATU_REGION_INDEX0         0x0
>>   #define PCIE_ATU_CR1                   0x904
>> +#define PCIE_ATU_INCREASE_REGION_SIZE  BIT(13)
>>   #define PCIE_ATU_TYPE_MEM              0x0
>>   #define PCIE_ATU_TYPE_IO               0x2
>>   #define PCIE_ATU_TYPE_CFG0             0x4
>> @@ -295,7 +297,7 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci);
>>   int dw_pcie_wait_for_link(struct dw_pcie *pci);
>>   void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
>>                                 int type, u64 cpu_addr, u64 pci_addr,
>> -                              u32 size);
>> +                              u64 size);
>>   void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>>                                    int type, u64 cpu_addr, u64 pci_addr,
>>                                    u32 size);
>> --
>> 2.17.1
>>
