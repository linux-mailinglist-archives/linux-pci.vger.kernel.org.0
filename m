Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA8AB113F46
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2019 11:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfLEKWg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Dec 2019 05:22:36 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53522 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbfLEKWf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2019 05:22:35 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB5ALv9T011289;
        Thu, 5 Dec 2019 04:21:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575541317;
        bh=iZ0pCV3atWz3xk2mdxV/dTvz0gJJheCIIPOBFtFumIw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=j3Ee9jxfTMno2zWvjbGmYoEG+BuNEgxWwjGy9tCgdboTbfrQb7QaGCntlKqMTsCLB
         viDJxHOmyDCEaC0ETjp/an4sVZprs6qG7Si6+gA7Hb8t4mpj5HzwNmd2SMnvsGnEYI
         Hk5Zv7rVkNK49COkrF84UQDsO/n9AWFl/WOb1EPo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB5ALvlC087938
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Dec 2019 04:21:57 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Dec
 2019 04:21:57 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Dec 2019 04:21:57 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB5ALnDH059515;
        Thu, 5 Dec 2019 04:21:49 -0600
Subject: Re: [PATCH 2/5] pci: endpoint: add support to handle multiple base
 for mapping outbound memory
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <linux-rockchip@lists.infradead.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
References: <20191106193609.19645-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20191106193609.19645-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8564ee76-1da6-9b7c-01f2-7cda0cd3b3dc@ti.com>
 <CA+V-a8tAk0iLNxN+ZgKyf-chLY2s4C-ajpJKeEr-B8Ajn1MkJQ@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9b8a8943-b2a1-1afd-eec1-ed664a5882ca@ti.com>
Date:   Thu, 5 Dec 2019 15:52:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CA+V-a8tAk0iLNxN+ZgKyf-chLY2s4C-ajpJKeEr-B8Ajn1MkJQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 28/11/19 2:51 am, Lad, Prabhakar wrote:
> Hi Kishon,
> 
> Thank you for the review.
> 
> On Wed, Nov 27, 2019 at 5:15 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi Prabhakar,
>>
>> On 07/11/19 1:06 AM, Lad Prabhakar wrote:
>>> From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>
>>> rcar pcie controller has support to map multiple memory regions
>>> for mapping the outbound memory in local system, this feature
>>> inspires to add support for handling multiple memory bases in
>>> endpoint framework. In case of multiple memory regions only chunk
>>> or complete region can be mapped and this window needs to be
>>> passed to the controller driver.
>>>
>>> Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> Cc: <linux-rockchip@lists.infradead.org>
>>> Cc: Shawn Lin <shawn.lin@rock-chips.com>
>>> Cc: Heiko Stuebner <heiko@sntech.de>
>>> Cc: Tom Joseph <tjoseph@cadence.com>
>>> Cc: Jingoo Han <jingoohan1@gmail.com>
>>> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>> ---
>>>   .../pci/controller/dwc/pcie-designware-ep.c   |  30 ++-
>>>   drivers/pci/controller/pcie-cadence-ep.c      |  11 +-
>>>   drivers/pci/controller/pcie-rockchip-ep.c     |  13 +-
>>>   drivers/pci/endpoint/functions/pci-epf-test.c |  29 +--
>>>   drivers/pci/endpoint/pci-epc-core.c           |   7 +-
>>>   drivers/pci/endpoint/pci-epc-mem.c            | 189 ++++++++++++++----
>>>   include/linux/pci-epc.h                       |  43 ++--
>>>   7 files changed, 234 insertions(+), 88 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> index 3dd2e2697294..8d23c20b9afd 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> @@ -195,7 +195,7 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no,
>>>   }
>>>
>>>   static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
>>> -                            phys_addr_t addr,
>>> +                            phys_addr_t addr, int window,
>>>                               u64 pci_addr, size_t size)
>>>   {
>>>        int ret;
>>> @@ -367,6 +367,7 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>>>        unsigned int aligned_offset;
>>>        u16 msg_ctrl, msg_data;
>>>        u32 msg_addr_lower, msg_addr_upper, reg;
>>> +     int window = PCI_EPC_DEFAULT_WINDOW;
>>>        u64 msg_addr;
>>>        bool has_upper;
>>>        int ret;
>>> @@ -390,11 +391,11 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>>>                reg = ep->msi_cap + PCI_MSI_DATA_32;
>>>                msg_data = dw_pcie_readw_dbi(pci, reg);
>>>        }
>>> -     aligned_offset = msg_addr_lower & (epc->mem->page_size - 1);
>>> +     aligned_offset = msg_addr_lower & (epc->mem[window]->page_size - 1);
>>>        msg_addr = ((u64)msg_addr_upper) << 32 |
>>>                        (msg_addr_lower & ~aligned_offset);
>>> -     ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
>>> -                               epc->mem->page_size);
>>> +     ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, window,
>>> +                               msg_addr, epc->mem[window]->page_size);
>>>        if (ret)
>>>                return ret;
>>>
>>> @@ -416,6 +417,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>>>        u32 reg, msg_data, vec_ctrl;
>>>        u64 tbl_addr, msg_addr, reg_u64;
>>>        void __iomem *msix_tbl;
>>> +     int window = PCI_EPC_DEFAULT_WINDOW;
>>>        int ret;
>>>
>>>        reg = ep->msix_cap + PCI_MSIX_TABLE;
>>> @@ -452,8 +454,8 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>>>                return -EPERM;
>>>        }
>>>
>>> -     ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
>>> -                               epc->mem->page_size);
>>> +     ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, window,
>>> +                               msg_addr, epc->mem[window]->page_size);
>>>        if (ret)
>>>                return ret;
>>>
>>> @@ -466,10 +468,11 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>>>
>>>   void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>>>   {
>>> +     int window = PCI_EPC_DEFAULT_WINDOW;
>>>        struct pci_epc *epc = ep->epc;
>>>
>>>        pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
>>> -                           epc->mem->page_size);
>>> +                           epc->mem[window]->page_size);
>>>
>>>        pci_epc_mem_exit(epc);
>>>   }
>>> @@ -499,9 +502,12 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>>        u32 reg;
>>>        void *addr;
>>>        u8 hdr_type;
>>> +     int window;
>>>        unsigned int nbars;
>>>        unsigned int offset;
>>>        struct pci_epc *epc;
>>> +     size_t msi_page_size;
>>> +     struct pci_epc_mem_window mem_window;
>>>        struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>>        struct device *dev = pci->dev;
>>>        struct device_node *np = dev->of_node;
>>> @@ -574,15 +580,17 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>>        if (ret < 0)
>>>                epc->max_functions = 1;
>>>
>>> -     ret = __pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
>>> -                              ep->page_size);
>>> +     mem_window.phys_base = ep->phys_base;
>>> +     mem_window.size = ep->addr_size;
>>> +     ret = __pci_epc_mem_init(epc, &mem_window, 1, ep->page_size);
>>>        if (ret < 0) {
>>>                dev_err(dev, "Failed to initialize address space\n");
>>>                return ret;
>>>        }
>>>
>>> -     ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
>>> -                                          epc->mem->page_size);
>>> +     msi_page_size = epc->mem[PCI_EPC_DEFAULT_WINDOW]->page_size;
>>> +     ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys, &window,
>>> +                                          msi_page_size);
>>>        if (!ep->msi_mem) {
>>>                dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
>>>                return -ENOMEM;
>>> diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
>>> index def7820cb824..7991b38a5350 100644
>>> --- a/drivers/pci/controller/pcie-cadence-ep.c
>>> +++ b/drivers/pci/controller/pcie-cadence-ep.c
>>> @@ -172,7 +172,7 @@ static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
>>>   }
>>>
>>>   static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, phys_addr_t addr,
>>> -                              u64 pci_addr, size_t size)
>>> +                              int window, u64 pci_addr, size_t size)
>>>   {
>>>        struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>>>        struct cdns_pcie *pcie = &ep->pcie;
>>> @@ -434,12 +434,14 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
>>>   {
>>>        struct device *dev = &pdev->dev;
>>>        struct device_node *np = dev->of_node;
>>> +     struct pci_epc_mem_window mem_window;
>>>        struct cdns_pcie_ep *ep;
>>>        struct cdns_pcie *pcie;
>>>        struct pci_epc *epc;
>>>        struct resource *res;
>>>        int ret;
>>>        int phy_count;
>>> +     int window;
>>>
>>>        ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
>>>        if (!ep)
>>> @@ -502,15 +504,16 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
>>>        if (of_property_read_u8(np, "max-functions", &epc->max_functions) < 0)
>>>                epc->max_functions = 1;
>>>
>>> -     ret = pci_epc_mem_init(epc, pcie->mem_res->start,
>>> -                            resource_size(pcie->mem_res));
>>> +     mem_window.phys_base = pcie->mem_res->start;
>>> +     mem_window.size = resource_size(pcie->mem_res);
>>> +     ret = pci_epc_mem_init(epc, &mem_window, 1);
>>>        if (ret < 0) {
>>>                dev_err(dev, "failed to initialize the memory space\n");
>>>                goto err_init;
>>>        }
>>>
>>>        ep->irq_cpu_addr = pci_epc_mem_alloc_addr(epc, &ep->irq_phys_addr,
>>> -                                               SZ_128K);
>>> +                                               &window, SZ_128K);
>>>        if (!ep->irq_cpu_addr) {
>>>                dev_err(dev, "failed to reserve memory space for MSI\n");
>>>                ret = -ENOMEM;
>>> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
>>> index d743b0a48988..d59e85c8d319 100644
>>> --- a/drivers/pci/controller/pcie-rockchip-ep.c
>>> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
>>> @@ -256,8 +256,8 @@ static void rockchip_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
>>>   }
>>>
>>>   static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn,
>>> -                                  phys_addr_t addr, u64 pci_addr,
>>> -                                  size_t size)
>>> +                                  phys_addr_t addr, int window,
>>> +                                  u64 pci_addr, size_t size)
>>>   {
>>>        struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
>>>        struct rockchip_pcie *pcie = &ep->rockchip;
>>> @@ -562,11 +562,13 @@ static const struct of_device_id rockchip_pcie_ep_of_match[] = {
>>>
>>>   static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>>>   {
>>> +     struct pci_epc_mem_window mem_window;
>>>        struct device *dev = &pdev->dev;
>>>        struct rockchip_pcie_ep *ep;
>>>        struct rockchip_pcie *rockchip;
>>>        struct pci_epc *epc;
>>>        size_t max_regions;
>>> +     int window;
>>>        int err;
>>>
>>>        ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
>>> @@ -614,15 +616,16 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>>>        /* Only enable function 0 by default */
>>>        rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
>>>
>>> -     err = pci_epc_mem_init(epc, rockchip->mem_res->start,
>>> -                            resource_size(rockchip->mem_res));
>>> +     mem_window.phys_base = rockchip->mem_res->start;
>>> +     mem_window.size = resource_size(rockchip->mem_res);
>>> +     err = pci_epc_mem_init(epc, &mem_window, 1);
>>>        if (err < 0) {
>>>                dev_err(dev, "failed to initialize the memory space\n");
>>>                goto err_uninit_port;
>>>        }
>>>
>>>        ep->irq_cpu_addr = pci_epc_mem_alloc_addr(epc, &ep->irq_phys_addr,
>>> -                                               SZ_128K);
>>> +                                               &window, SZ_128K);
>>>        if (!ep->irq_cpu_addr) {
>>>                dev_err(dev, "failed to reserve memory space for MSI\n");
>>>                err = -ENOMEM;
>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>>> index 5d74f81ddfe4..475228011703 100644
>>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>>> @@ -84,8 +84,10 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>>>        struct pci_epc *epc = epf->epc;
>>>        enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>>>        struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>>> +     int window;
>>>
>>> -     src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
>>> +     src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr,
>>> +                                       &window, reg->size);
>>>        if (!src_addr) {
>>>                dev_err(dev, "Failed to allocate source address\n");
>>>                reg->status = STATUS_SRC_ADDR_INVALID;
>>> @@ -93,15 +95,16 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>>>                goto err;
>>>        }
>>>
>>> -     ret = pci_epc_map_addr(epc, epf->func_no, src_phys_addr, reg->src_addr,
>>> -                            reg->size);
>>> +     ret = pci_epc_map_addr(epc, epf->func_no, src_phys_addr, window,
>>> +                            reg->src_addr, reg->size);
>>>        if (ret) {
>>>                dev_err(dev, "Failed to map source address\n");
>>>                reg->status = STATUS_SRC_ADDR_INVALID;
>>>                goto err_src_addr;
>>>        }
>>>
>>> -     dst_addr = pci_epc_mem_alloc_addr(epc, &dst_phys_addr, reg->size);
>>> +     dst_addr = pci_epc_mem_alloc_addr(epc, &dst_phys_addr,
>>> +                                       &window, reg->size);
>>>        if (!dst_addr) {
>>>                dev_err(dev, "Failed to allocate destination address\n");
>>>                reg->status = STATUS_DST_ADDR_INVALID;
>>> @@ -109,8 +112,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>>>                goto err_src_map_addr;
>>>        }
>>>
>>> -     ret = pci_epc_map_addr(epc, epf->func_no, dst_phys_addr, reg->dst_addr,
>>> -                            reg->size);
>>> +     ret = pci_epc_map_addr(epc, epf->func_no, dst_phys_addr, window,
>>> +                            reg->dst_addr, reg->size);
>>>        if (ret) {
>>>                dev_err(dev, "Failed to map destination address\n");
>>>                reg->status = STATUS_DST_ADDR_INVALID;
>>> @@ -146,8 +149,9 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>>>        struct pci_epc *epc = epf->epc;
>>>        enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>>>        struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>>> +     int window;
>>>
>>> -     src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
>>> +     src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, &window, reg->size);
>>>        if (!src_addr) {
>>>                dev_err(dev, "Failed to allocate address\n");
>>>                reg->status = STATUS_SRC_ADDR_INVALID;
>>> @@ -155,8 +159,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>>>                goto err;
>>>        }
>>>
>>> -     ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->src_addr,
>>> -                            reg->size);
>>> +     ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, window,
>>> +                            reg->src_addr, reg->size);
>>>        if (ret) {
>>>                dev_err(dev, "Failed to map address\n");
>>>                reg->status = STATUS_SRC_ADDR_INVALID;
>>> @@ -193,13 +197,14 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>>>        void __iomem *dst_addr;
>>>        void *buf;
>>>        phys_addr_t phys_addr;
>>> +     int window;
>>>        struct pci_epf *epf = epf_test->epf;
>>>        struct device *dev = &epf->dev;
>>>        struct pci_epc *epc = epf->epc;
>>>        enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>>>        struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>>>
>>> -     dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
>>> +     dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, &window, reg->size);
>>>        if (!dst_addr) {
>>>                dev_err(dev, "Failed to allocate address\n");
>>>                reg->status = STATUS_DST_ADDR_INVALID;
>>> @@ -207,8 +212,8 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>>>                goto err;
>>>        }
>>>
>>> -     ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->dst_addr,
>>> -                            reg->size);
>>> +     ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, window,
>>> +                            reg->dst_addr, reg->size);
>>>        if (ret) {
>>>                dev_err(dev, "Failed to map address\n");
>>>                reg->status = STATUS_DST_ADDR_INVALID;
>>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>>> index 2091508c1620..289c266c2d90 100644
>>> --- a/drivers/pci/endpoint/pci-epc-core.c
>>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>>> @@ -358,13 +358,15 @@ EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>>>    * @epc: the EPC device on which address is allocated
>>>    * @func_no: the endpoint function number in the EPC device
>>>    * @phys_addr: physical address of the local system
>>> + * @window: index to the window region where PCI address will be mapped
>>>    * @pci_addr: PCI address to which the physical address should be mapped
>>>    * @size: the size of the allocation
>>>    *
>>>    * Invoke to map CPU address with PCI address.
>>>    */
>>>   int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
>>> -                  phys_addr_t phys_addr, u64 pci_addr, size_t size)
>>> +                  phys_addr_t phys_addr, int window,
>>> +                  u64 pci_addr, size_t size)
>>>   {
>>>        int ret;
>>>        unsigned long flags;
>>> @@ -376,7 +378,8 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
>>>                return 0;
>>>
>>>        spin_lock_irqsave(&epc->lock, flags);
>>> -     ret = epc->ops->map_addr(epc, func_no, phys_addr, pci_addr, size);
>>> +     ret = epc->ops->map_addr(epc, func_no, phys_addr,
>>> +                              window, pci_addr, size);
>>>        spin_unlock_irqrestore(&epc->lock, flags);
>>>
>>>        return ret;
>>> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
>>> index d2b174ce15de..c955f2c97944 100644
>>> --- a/drivers/pci/endpoint/pci-epc-mem.c
>>> +++ b/drivers/pci/endpoint/pci-epc-mem.c
>>> @@ -39,56 +39,77 @@ static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
>>>    * __pci_epc_mem_init() - initialize the pci_epc_mem structure
>>>    * @epc: the EPC device that invoked pci_epc_mem_init
>>>    * @phys_base: the physical address of the base
>>> - * @size: the size of the address space
>>> + * @num_windows: number of windows device supports
>>
>> struct pci_epc_mem_window is missing here.
> oops my bad will fix that.
> 
>>>    * @page_size: size of each page
>>>    *
>>>    * Invoke to initialize the pci_epc_mem structure used by the
>>>    * endpoint functions to allocate mapped PCI address.
>>>    */
>>> -int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_base, size_t size,
>>> -                    size_t page_size)
>>> +int __pci_epc_mem_init(struct pci_epc *epc, struct pci_epc_mem_window *windows,
>>> +                    int num_windows, size_t page_size)
>>>   {
>>> -     int ret;
>>> -     struct pci_epc_mem *mem;
>>> -     unsigned long *bitmap;
>>> +     struct pci_epc_mem *mem = NULL;
>>> +     unsigned long *bitmap = NULL;
>>>        unsigned int page_shift;
>>> -     int pages;
>>>        int bitmap_size;
>>> +     int pages;
>>> +     int ret;
>>> +     int i;
>>> +
>>> +     epc->mem_windows = 0;
>>> +
>>> +     if (!windows)
>>> +             return -EINVAL;
>>> +
>>> +     if (num_windows <= 0)
>>> +             return -EINVAL;
>>>
>>>        if (page_size < PAGE_SIZE)
>>>                page_size = PAGE_SIZE;
>>>
>>>        page_shift = ilog2(page_size);
>>> -     pages = size >> page_shift;
>>> -     bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
>>>
>>> -     mem = kzalloc(sizeof(*mem), GFP_KERNEL);
>>> -     if (!mem) {
>>> -             ret = -ENOMEM;
>>> -             goto err;
>>> -     }
>>> +     epc->mem = kcalloc(num_windows, sizeof(*mem), GFP_KERNEL);
>>> +     if (!epc->mem)
>>> +             return -EINVAL;
>>>
>>> -     bitmap = kzalloc(bitmap_size, GFP_KERNEL);
>>> -     if (!bitmap) {
>>> -             ret = -ENOMEM;
>>> -             goto err_mem;
>>> -     }
>>> +     for (i = 0; i < num_windows; i++) {
>>> +             pages = windows[i].phys_base >> page_shift;
>>> +             bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
>>>
>>> -     mem->bitmap = bitmap;
>>> -     mem->phys_base = phys_base;
>>> -     mem->page_size = page_size;
>>> -     mem->pages = pages;
>>> -     mem->size = size;
>>> +             mem = kzalloc(sizeof(*mem), GFP_KERNEL);
>>> +             if (!mem) {
>>> +                     ret = -ENOMEM;
>>> +                     goto err_mem;
>>> +             }
>>>
>>> -     epc->mem = mem;
>>> +             bitmap = kzalloc(bitmap_size, GFP_KERNEL);
>>> +             if (!bitmap) {
>>> +                     ret = -ENOMEM;
>>> +                     goto err_mem;
>>> +             }
>>> +
>>> +             mem->bitmap = bitmap;
>>> +             mem->window.phys_base = windows[i].phys_base;
>>> +             mem->page_size = page_size;
>>> +             mem->pages = pages;
>>> +             mem->window.size = windows[i].size;
>>> +             mem->window.map_size = 0;
>>> +
>>> +             epc->mem[i] = mem;
>>> +     }
>>> +     epc->mem_windows = num_windows;
>>>
>>>        return 0;
>>>
>>>   err_mem:
>>> -     kfree(mem);
>>> +     for (; i >= 0; i--) {
>>> +             kfree(mem->bitmap);
>>> +             kfree(epc->mem[i]);
>>> +     }
>>> +     kfree(epc->mem);
>>>
>>> -err:
>>> -return ret;
>>> +     return ret;
>>>   }
>>>   EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
>>>
>>> @@ -101,48 +122,126 @@ EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
>>>    */
>>>   void pci_epc_mem_exit(struct pci_epc *epc)
>>>   {
>>> -     struct pci_epc_mem *mem = epc->mem;
>>> +     struct pci_epc_mem *mem;
>>> +     int i;
>>> +
>>> +     if (!epc->mem_windows)
>>> +             return;
>>> +
>>> +     for (i = 0; i <= epc->mem_windows; i--) {
>>> +             mem = epc->mem[i];
>>> +             kfree(mem->bitmap);
>>> +             kfree(epc->mem[i]);
>>> +     }
>>> +     kfree(epc->mem);
>>>
>>>        epc->mem = NULL;
>>> -     kfree(mem->bitmap);
>>> -     kfree(mem);
>>> +     epc->mem_windows = 0;
>>>   }
>>>   EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
>>>
>>> +static int pci_epc_find_best_fit_window(struct pci_epc *epc, size_t size)
>>> +{
>>> +     size_t window_least_size = 0;
>>> +     int best_fit_window = -1;
>>> +     struct pci_epc_mem *mem;
>>> +     size_t actual_size;
>>> +     int i;
>>> +
>>> +     for (i = 0; i < epc->mem_windows; i++) {
>>> +             mem = epc->mem[i];
>>> +
>>> +             /* if chunk from this region is already used skip it */
>>> +             if (mem->window.map_size)
>>> +                     continue;
>>> +
>>> +             actual_size = ALIGN(size, mem->page_size);
>>> +
>>> +             if (best_fit_window == -1) {
>>> +                     best_fit_window = i;
>>> +                     window_least_size = mem->window.size;
>>> +             } else {
>>> +                     if (actual_size <= mem->window.size &&
>>> +                         mem->window.size < window_least_size) {
>>> +                             best_fit_window = i;
>>> +                             window_least_size = mem->window.size;
>>> +                     }
>>> +             }
>>> +     }
>>> +
>>> +     return best_fit_window;
>>> +}
>>> +
>>>   /**
>>>    * pci_epc_mem_alloc_addr() - allocate memory address from EPC addr space
>>>    * @epc: the EPC device on which memory has to be allocated
>>>    * @phys_addr: populate the allocated physical address here
>>> + * @window: populate the window here which will be used to map PCI address
>>>    * @size: the size of the address space that has to be allocated
>>>    *
>>>    * Invoke to allocate memory address from the EPC address space. This
>>>    * is usually done to map the remote RC address into the local system.
>>>    */
>>>   void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>>> -                                  phys_addr_t *phys_addr, size_t size)
>>> +                                  phys_addr_t *phys_addr,
>>> +                                  int *window, size_t size)
>>>   {
>>> +     int best_fit = PCI_EPC_DEFAULT_WINDOW;
>>> +     void __iomem *virt_addr = NULL;
>>> +     struct pci_epc_mem *mem;
>>> +     unsigned int page_shift;
>>>        int pageno;
>>> -     void __iomem *virt_addr;
>>> -     struct pci_epc_mem *mem = epc->mem;
>>> -     unsigned int page_shift = ilog2(mem->page_size);
>>>        int order;
>>>
>>> +     if (epc->mem_windows <= 0)
>>> +             return NULL;
>>> +
>>> +     if (epc->mem_windows > 1) {
>>> +             best_fit = pci_epc_find_best_fit_window(epc, size);
>>> +             if (best_fit < 0)
>>> +                     return NULL;
>>> +     }
>>> +
>>> +     mem = epc->mem[best_fit];
>>>        size = ALIGN(size, mem->page_size);
>>> +     if (size > (mem->window.size - mem->window.map_size))
>>> +             return NULL;
>>
>> Assume I have two mem regions, first region is of size 128MB and the second
>> region is of size 4GB. If there is a allocation request for 4GB, will the
>> allocation succeed?
>>
> yes it would succeed, the pci_epc_find_best_fit_window() would get the
> corresponding window.

Can you step through the algo again? pci_epc_find_best_fit_window() will 
return the first region which is of size 128MB.

Thanks
Kishon
