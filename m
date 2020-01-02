Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFC9812E4A8
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2020 11:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgABKAW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jan 2020 05:00:22 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38730 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgABKAV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jan 2020 05:00:21 -0500
Received: by mail-ot1-f67.google.com with SMTP id d7so51945238otf.5;
        Thu, 02 Jan 2020 02:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BG5L039Enng5tZBAdUgQnnrLke6E+rkVOYpNyO1y3TE=;
        b=ZwO4GV0rYroeGRpVZfsiV0xTD7khc+fB98eqotYGZFZf9HRIM1lGE88ZBiDOAge/mX
         dKGMnJ3i863dvIBy9d2X72T4AnSiKusTJ6U5R6gHaIHBsThH3XKezuGqo5GzmG/NcsqE
         awX7RzxsAm2m4u+ifnFqdNAnsPGuuhhj8NbzULTVQetFvrw3ZaTgEAyAhbIrtxYKaqw7
         LpH2TaqEehe35Vn3+mTTE4k0KNZ80ct+4gmohlrqFzVJBRjGhnd+ZR8XahVN8hANdCi3
         p0o/87YjbJR9fDJm/v0w5936svg++/Cs5S9v3vzsmTpsdnrLnQIA3SUK0dODNITgfJQS
         QFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BG5L039Enng5tZBAdUgQnnrLke6E+rkVOYpNyO1y3TE=;
        b=lM9X1orDkZdClXWDVe9g4x1Q7lptHP9oiEsxLLZME2HYhdsduSWOZs0TJW7OrSzDMQ
         c1TXr9t746Rk1gFWqfyAWPv5rxcKKf/gA2ez1L2vTOx7G90gD13aJnRr7Kz7VEc8ghiS
         NOOPFa9ISXpqiNRUf/L+dShl0aKoZUn0rJeyknciID7nCXl3PozpBrsNWEryydZsJpIM
         hj+RsC1aoWJqKqBBPf8x+vH0BljI0EbrpRkmFKh1aZiIJibjJNiGrt18d51DnarXHUXp
         p4giXua9wKjwQRZz/SK5qcGWF3AKhjlzeuG3uImy68JraSxNyetZ6Pe2rwIyupRckAfb
         MB2Q==
X-Gm-Message-State: APjAAAVMXjbilcAQFmQQ4EmidWzT4E68oX4GqysZ1Y504/F0CLESxuTp
        OpMT/re4sqr4NePlMcRgOXaqSZGcMsttkcQEMVw=
X-Google-Smtp-Source: APXvYqzbiPS5mrnJtAVqbHskvdTyKBkYWlEkZpW24ThIMFHsbJMI2RZWBNIv3hEK+NDggeSieo9J7xG7O4WOPWIWaj8=
X-Received: by 2002:a05:6830:1d4c:: with SMTP id p12mr94090738oth.198.1577959219727;
 Thu, 02 Jan 2020 02:00:19 -0800 (PST)
MIME-Version: 1.0
References: <20191213084748.11210-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20191213084748.11210-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <5f363a99-3642-cc1e-52fc-2f866c53344c@ti.com> <CA+V-a8vFrA7-4Emw4h0khxptOo9mCXMSrYsyc3Yw1X6ZEaujdw@mail.gmail.com>
 <c36e89a8-798f-8beb-8ee1-6fe1723f7842@ti.com>
In-Reply-To: <c36e89a8-798f-8beb-8ee1-6fe1723f7842@ti.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 2 Jan 2020 09:59:53 +0000
Message-ID: <CA+V-a8u=-pEQcYH7W0bhv31i=gUR+qh5D70uM+NWWHC9yqZUfg@mail.gmail.com>
Subject: Re: [v2 2/6] pci: endpoint: add support to handle features of
 outbound memory
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
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
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On Thu, Jan 2, 2020 at 9:43 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Prabhakar,
>
> On 18/12/19 10:53 PM, Lad, Prabhakar wrote:
> > Hi Kishon,
> >
> > On Mon, Dec 16, 2019 at 11:34 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>
> >> Hi Prabhakar,
> >>
> >> On 13/12/19 2:17 pm,  wrote:
> >>> From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>>
> >>> rcar pcie controller has support to map multiple memory regions
> >>> for mapping the outbound memory in local system, this feature
> >>> inspires to add support for handling such features in endpoint
> >>> framework. similar features exists on other controllers where
> >>> outbound regions can be specifically used for low/high priority
> >>> transactions, and regions can be flagged and used for allocation
> >>> of large/small memory allocations.
> >>> This patch adds support to handle such features, where the
> >>> properties described for outbound regions are used whenever a
> >>> request to memory is made.
> >>>
> >>> Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>> ---
> >>>   drivers/pci/controller/dwc/pcie-designware-ep.c |  30 ++--
> >>>   drivers/pci/controller/pcie-cadence-ep.c        |  11 +-
> >>>   drivers/pci/controller/pcie-rockchip-ep.c       |  13 +-
> >>>   drivers/pci/endpoint/functions/pci-epf-test.c   |  47 ++++--
> >>>   drivers/pci/endpoint/pci-epc-core.c             |   7 +-
> >>>   drivers/pci/endpoint/pci-epc-mem.c              | 216 +++++++++++++++++++-----
> >>>   include/linux/pci-epc.h                         |  72 ++++++--
> >>>   7 files changed, 307 insertions(+), 89 deletions(-)
> >>>
> >>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> >>> index 3dd2e26..be6aa94 100644
> >>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> >>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> >>> @@ -195,7 +195,7 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no,
> >>>   }
> >>>
> >>>   static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
> >>> -                            phys_addr_t addr,
> >>> +                            phys_addr_t addr, int window,
> >>>                              u64 pci_addr, size_t size)
> >>>   {
> >>>       int ret;
> >>> @@ -367,6 +367,7 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> >>>       unsigned int aligned_offset;
> >>>       u16 msg_ctrl, msg_data;
> >>>       u32 msg_addr_lower, msg_addr_upper, reg;
> >>> +     int window = PCI_EPC_DEFAULT_WINDOW;
> >>>       u64 msg_addr;
> >>>       bool has_upper;
> >>>       int ret;
> >>> @@ -390,11 +391,11 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> >>>               reg = ep->msi_cap + PCI_MSI_DATA_32;
> >>>               msg_data = dw_pcie_readw_dbi(pci, reg);
> >>>       }
> >>> -     aligned_offset = msg_addr_lower & (epc->mem->page_size - 1);
> >>> +     aligned_offset = msg_addr_lower & (epc->mem[window]->page_size - 1);
> >>>       msg_addr = ((u64)msg_addr_upper) << 32 |
> >>>                       (msg_addr_lower & ~aligned_offset);
> >>> -     ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
> >>> -                               epc->mem->page_size);
> >>> +     ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, window,
> >>> +                               msg_addr, epc->mem[window]->page_size);
> >>>       if (ret)
> >>>               return ret;
> >>>
> >>> @@ -416,6 +417,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> >>>       u32 reg, msg_data, vec_ctrl;
> >>>       u64 tbl_addr, msg_addr, reg_u64;
> >>>       void __iomem *msix_tbl;
> >>> +     int window = PCI_EPC_DEFAULT_WINDOW;
> >>>       int ret;
> >>>
> >>>       reg = ep->msix_cap + PCI_MSIX_TABLE;
> >>> @@ -452,8 +454,8 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> >>>               return -EPERM;
> >>>       }
> >>>
> >>> -     ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
> >>> -                               epc->mem->page_size);
> >>> +     ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, window,
> >>> +                               msg_addr, epc->mem[window]->page_size);
> >>>       if (ret)
> >>>               return ret;
> >>>
> >>> @@ -466,10 +468,11 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> >>>
> >>>   void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> >>>   {
> >>> +     int window = PCI_EPC_DEFAULT_WINDOW;
> >>>       struct pci_epc *epc = ep->epc;
> >>>
> >>>       pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> >>> -                           epc->mem->page_size);
> >>> +                           epc->mem[window]->page_size);
> >>>
> >>>       pci_epc_mem_exit(epc);
> >>>   }
> >>> @@ -499,9 +502,12 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >>>       u32 reg;
> >>>       void *addr;
> >>>       u8 hdr_type;
> >>> +     int window;
> >>>       unsigned int nbars;
> >>>       unsigned int offset;
> >>>       struct pci_epc *epc;
> >>> +     size_t msi_page_size;
> >>> +     struct pci_epc_mem_window mem_window;
> >>>       struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >>>       struct device *dev = pci->dev;
> >>>       struct device_node *np = dev->of_node;
> >>> @@ -574,15 +580,17 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >>>       if (ret < 0)
> >>>               epc->max_functions = 1;
> >>>
> >>> -     ret = __pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
> >>> -                              ep->page_size);
> >>> +     mem_window.phys_base = ep->phys_base;
> >>> +     mem_window.size = ep->addr_size;
> >>> +     ret = __pci_epc_mem_init(epc, &mem_window, 1, ep->page_size);
> >>>       if (ret < 0) {
> >>>               dev_err(dev, "Failed to initialize address space\n");
> >>>               return ret;
> >>>       }
> >>>
> >>> -     ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> >>> -                                          epc->mem->page_size);
> >>> +     msi_page_size = epc->mem[PCI_EPC_DEFAULT_WINDOW]->page_size;
> >>> +     ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys, &window,
> >>> +                                          msi_page_size, 0x0);
> >>>       if (!ep->msi_mem) {
> >>>               dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
> >>>               return -ENOMEM;
> >>> diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
> >>> index def7820..2410706 100644
> >>> --- a/drivers/pci/controller/pcie-cadence-ep.c
> >>> +++ b/drivers/pci/controller/pcie-cadence-ep.c
> >>> @@ -172,7 +172,7 @@ static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
> >>>   }
> >>>
> >>>   static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, phys_addr_t addr,
> >>> -                              u64 pci_addr, size_t size)
> >>> +                              int window, u64 pci_addr, size_t size)
> >>>   {
> >>>       struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> >>>       struct cdns_pcie *pcie = &ep->pcie;
> >>> @@ -434,12 +434,14 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
> >>>   {
> >>>       struct device *dev = &pdev->dev;
> >>>       struct device_node *np = dev->of_node;
> >>> +     struct pci_epc_mem_window mem_window;
> >>>       struct cdns_pcie_ep *ep;
> >>>       struct cdns_pcie *pcie;
> >>>       struct pci_epc *epc;
> >>>       struct resource *res;
> >>>       int ret;
> >>>       int phy_count;
> >>> +     int window;
> >>>
> >>>       ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> >>>       if (!ep)
> >>> @@ -502,15 +504,16 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
> >>>       if (of_property_read_u8(np, "max-functions", &epc->max_functions) < 0)
> >>>               epc->max_functions = 1;
> >>>
> >>> -     ret = pci_epc_mem_init(epc, pcie->mem_res->start,
> >>> -                            resource_size(pcie->mem_res));
> >>> +     mem_window.phys_base = pcie->mem_res->start;
> >>> +     mem_window.size = resource_size(pcie->mem_res);
> >>> +     ret = pci_epc_mem_init(epc, &mem_window, 1);
> >>>       if (ret < 0) {
> >>>               dev_err(dev, "failed to initialize the memory space\n");
> >>>               goto err_init;
> >>>       }
> >>>
> >>>       ep->irq_cpu_addr = pci_epc_mem_alloc_addr(epc, &ep->irq_phys_addr,
> >>> -                                               SZ_128K);
> >>> +                                               &window, SZ_128K, 0x0);
> >>>       if (!ep->irq_cpu_addr) {
> >>>               dev_err(dev, "failed to reserve memory space for MSI\n");
> >>>               ret = -ENOMEM;
> >>> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> >>> index d743b0a..828052c 100644
> >>> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> >>> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> >>> @@ -256,8 +256,8 @@ static void rockchip_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
> >>>   }
> >>>
> >>>   static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn,
> >>> -                                  phys_addr_t addr, u64 pci_addr,
> >>> -                                  size_t size)
> >>> +                                  phys_addr_t addr, int window,
> >>> +                                  u64 pci_addr, size_t size)
> >>>   {
> >>>       struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
> >>>       struct rockchip_pcie *pcie = &ep->rockchip;
> >>> @@ -562,11 +562,13 @@ static const struct of_device_id rockchip_pcie_ep_of_match[] = {
> >>>
> >>>   static int rockchip_pcie_ep_probe(struct platform_device *pdev)
> >>>   {
> >>> +     struct pci_epc_mem_window mem_window;
> >>>       struct device *dev = &pdev->dev;
> >>>       struct rockchip_pcie_ep *ep;
> >>>       struct rockchip_pcie *rockchip;
> >>>       struct pci_epc *epc;
> >>>       size_t max_regions;
> >>> +     int window;
> >>>       int err;
> >>>
> >>>       ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> >>> @@ -614,15 +616,16 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
> >>>       /* Only enable function 0 by default */
> >>>       rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
> >>>
> >>> -     err = pci_epc_mem_init(epc, rockchip->mem_res->start,
> >>> -                            resource_size(rockchip->mem_res));
> >>> +     mem_window.phys_base = rockchip->mem_res->start;
> >>> +     mem_window.size = resource_size(rockchip->mem_res);
> >>> +     err = pci_epc_mem_init(epc, &mem_window, 1);
> >>>       if (err < 0) {
> >>>               dev_err(dev, "failed to initialize the memory space\n");
> >>>               goto err_uninit_port;
> >>>       }
> >>>
> >>>       ep->irq_cpu_addr = pci_epc_mem_alloc_addr(epc, &ep->irq_phys_addr,
> >>> -                                               SZ_128K);
> >>> +                                               &window, SZ_128K, 0x0);
> >>>       if (!ep->irq_cpu_addr) {
> >>>               dev_err(dev, "failed to reserve memory space for MSI\n");
> >>>               err = -ENOMEM;
> >>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> >>> index 1cfe368..4768d54 100644
> >>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> >>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> >>> @@ -84,8 +84,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
> >>>       struct pci_epc *epc = epf->epc;
> >>>       enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> >>>       struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> >>> -
> >>> -     src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
> >>> +     int window;
> >>> +
> >>> +     src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr,
> >>> +                                       &window, reg->size,
> >>> +                                       PCI_EPC_WINDOW_FLAG_LARGE_ALLOC |
> >>> +                                       PCI_EPC_WINDOW_FLAG_SMALL_ALLOC |
> >>> +                                       PCI_EPC_WINDOW_FLAG_HIGH_PRI_ALLOC |
> >>> +                                       PCI_EPC_WINDOW_FLAG_LOW_PRI_ALLOC);
> >>>       if (!src_addr) {
> >>>               dev_err(dev, "Failed to allocate source address\n");
> >>>               reg->status = STATUS_SRC_ADDR_INVALID;
> >>> @@ -93,15 +99,20 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
> >>>               goto err;
> >>>       }
> >>>
> >>> -     ret = pci_epc_map_addr(epc, epf->func_no, src_phys_addr, reg->src_addr,
> >>> -                            reg->size);
> >>> +     ret = pci_epc_map_addr(epc, epf->func_no, src_phys_addr, window,
> >>> +                            reg->src_addr, reg->size);
> >>>       if (ret) {
> >>>               dev_err(dev, "Failed to map source address\n");
> >>>               reg->status = STATUS_SRC_ADDR_INVALID;
> >>>               goto err_src_addr;
> >>>       }
> >>>
> >>> -     dst_addr = pci_epc_mem_alloc_addr(epc, &dst_phys_addr, reg->size);
> >>> +     dst_addr = pci_epc_mem_alloc_addr(epc, &dst_phys_addr,
> >>> +                                       &window, reg->size,
> >>> +                                       PCI_EPC_WINDOW_FLAG_LARGE_ALLOC |
> >>> +                                       PCI_EPC_WINDOW_FLAG_SMALL_ALLOC |
> >>> +                                       PCI_EPC_WINDOW_FLAG_HIGH_PRI_ALLOC |
> >>> +                                       PCI_EPC_WINDOW_FLAG_LOW_PRI_ALLOC);
> >>>       if (!dst_addr) {
> >>>               dev_err(dev, "Failed to allocate destination address\n");
> >>>               reg->status = STATUS_DST_ADDR_INVALID;
> >>> @@ -109,8 +120,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
> >>>               goto err_src_map_addr;
> >>>       }
> >>>
> >>> -     ret = pci_epc_map_addr(epc, epf->func_no, dst_phys_addr, reg->dst_addr,
> >>> -                            reg->size);
> >>> +     ret = pci_epc_map_addr(epc, epf->func_no, dst_phys_addr, window,
> >>> +                            reg->dst_addr, reg->size);
> >>>       if (ret) {
> >>>               dev_err(dev, "Failed to map destination address\n");
> >>>               reg->status = STATUS_DST_ADDR_INVALID;
> >>> @@ -146,8 +157,13 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
> >>>       struct pci_epc *epc = epf->epc;
> >>>       enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> >>>       struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> >>> +     int window;
> >>>
> >>> -     src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
> >>> +     src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, &window, reg->size,
> >>> +                                       PCI_EPC_WINDOW_FLAG_LARGE_ALLOC |
> >>> +                                       PCI_EPC_WINDOW_FLAG_SMALL_ALLOC |
> >>> +                                       PCI_EPC_WINDOW_FLAG_HIGH_PRI_ALLOC |
> >>> +                                       PCI_EPC_WINDOW_FLAG_LOW_PRI_ALLOC);
> >>>       if (!src_addr) {
> >>>               dev_err(dev, "Failed to allocate address\n");
> >>>               reg->status = STATUS_SRC_ADDR_INVALID;
> >>> @@ -155,8 +171,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
> >>>               goto err;
> >>>       }
> >>>
> >>> -     ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->src_addr,
> >>> -                            reg->size);
> >>> +     ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, window,
> >>> +                            reg->src_addr, reg->size);
> >>>       if (ret) {
> >>>               dev_err(dev, "Failed to map address\n");
> >>>               reg->status = STATUS_SRC_ADDR_INVALID;
> >>> @@ -193,13 +209,18 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
> >>>       void __iomem *dst_addr;
> >>>       void *buf;
> >>>       phys_addr_t phys_addr;
> >>> +     int window;
> >>>       struct pci_epf *epf = epf_test->epf;
> >>>       struct device *dev = &epf->dev;
> >>>       struct pci_epc *epc = epf->epc;
> >>>       enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> >>>       struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> >>>
> >>> -     dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
> >>> +     dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, &window, reg->size,
> >>> +                                       PCI_EPC_WINDOW_FLAG_LARGE_ALLOC |
> >>> +                                       PCI_EPC_WINDOW_FLAG_SMALL_ALLOC |
> >>> +                                       PCI_EPC_WINDOW_FLAG_HIGH_PRI_ALLOC |
> >>> +                                       PCI_EPC_WINDOW_FLAG_LOW_PRI_ALLOC);
> >>>       if (!dst_addr) {
> >>>               dev_err(dev, "Failed to allocate address\n");
> >>>               reg->status = STATUS_DST_ADDR_INVALID;
> >>> @@ -207,8 +228,8 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
> >>>               goto err;
> >>>       }
> >>>
> >>> -     ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->dst_addr,
> >>> -                            reg->size);
> >>> +     ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, window,
> >>> +                            reg->dst_addr, reg->size);
> >>>       if (ret) {
> >>>               dev_err(dev, "Failed to map address\n");
> >>>               reg->status = STATUS_DST_ADDR_INVALID;
> >>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> >>> index 2091508..289c266 100644
> >>> --- a/drivers/pci/endpoint/pci-epc-core.c
> >>> +++ b/drivers/pci/endpoint/pci-epc-core.c
> >>> @@ -358,13 +358,15 @@ EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
> >>>    * @epc: the EPC device on which address is allocated
> >>>    * @func_no: the endpoint function number in the EPC device
> >>>    * @phys_addr: physical address of the local system
> >>> + * @window: index to the window region where PCI address will be mapped
> >>>    * @pci_addr: PCI address to which the physical address should be mapped
> >>>    * @size: the size of the allocation
> >>>    *
> >>>    * Invoke to map CPU address with PCI address.
> >>>    */
> >>>   int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
> >>> -                  phys_addr_t phys_addr, u64 pci_addr, size_t size)
> >>> +                  phys_addr_t phys_addr, int window,
> >>> +                  u64 pci_addr, size_t size)
> >>>   {
> >>>       int ret;
> >>>       unsigned long flags;
> >>> @@ -376,7 +378,8 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
> >>>               return 0;
> >>>
> >>>       spin_lock_irqsave(&epc->lock, flags);
> >>> -     ret = epc->ops->map_addr(epc, func_no, phys_addr, pci_addr, size);
> >>> +     ret = epc->ops->map_addr(epc, func_no, phys_addr,
> >>> +                              window, pci_addr, size);
> >>>       spin_unlock_irqrestore(&epc->lock, flags);
> >>>
> >>>       return ret;
> >>> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> >>> index 2bf8bd1..4b610cd 100644
> >>> --- a/drivers/pci/endpoint/pci-epc-mem.c
> >>> +++ b/drivers/pci/endpoint/pci-epc-mem.c
> >>> @@ -39,56 +39,78 @@ static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
> >>>    * __pci_epc_mem_init() - initialize the pci_epc_mem structure
> >>>    * @epc: the EPC device that invoked pci_epc_mem_init
> >>>    * @phys_base: the physical address of the base
> >>> - * @size: the size of the address space
> >>> + * @num_windows: number of windows device supports
> >>>    * @page_size: size of each page
> >>>    *
> >>>    * Invoke to initialize the pci_epc_mem structure used by the
> >>>    * endpoint functions to allocate mapped PCI address.
> >>>    */
> >>> -int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_base, size_t size,
> >>> -                    size_t page_size)
> >>> +int __pci_epc_mem_init(struct pci_epc *epc, struct pci_epc_mem_window *windows,
> >>> +                    int num_windows, size_t page_size)
> >>>   {
> >>> -     int ret;
> >>> -     struct pci_epc_mem *mem;
> >>> -     unsigned long *bitmap;
> >>> +     struct pci_epc_mem *mem = NULL;
> >>> +     unsigned long *bitmap = NULL;
> >>>       unsigned int page_shift;
> >>> -     int pages;
> >>>       int bitmap_size;
> >>> +     int pages;
> >>> +     int ret;
> >>> +     int i;
> >>> +
> >>> +     epc->mem_windows = 0;
> >>> +
> >>> +     if (!windows)
> >>> +             return -EINVAL;
> >>> +
> >>> +     if (num_windows <= 0)
> >>> +             return -EINVAL;
> >>>
> >>>       if (page_size < PAGE_SIZE)
> >>>               page_size = PAGE_SIZE;
> >>>
> >>>       page_shift = ilog2(page_size);
> >>> -     pages = size >> page_shift;
> >>> -     bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> >>>
> >>> -     mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> >>> -     if (!mem) {
> >>> -             ret = -ENOMEM;
> >>> -             goto err;
> >>> -     }
> >>> +     epc->mem = kcalloc(num_windows, sizeof(*mem), GFP_KERNEL);
> >>> +     if (!epc->mem)
> >>> +             return -EINVAL;
> >>>
> >>> -     bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> >>> -     if (!bitmap) {
> >>> -             ret = -ENOMEM;
> >>> -             goto err_mem;
> >>> -     }
> >>> +     for (i = 0; i < num_windows; i++) {
> >>> +             pages = windows[i].phys_base >> page_shift;
> >>> +             bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> >>>
> >>> -     mem->bitmap = bitmap;
> >>> -     mem->phys_base = phys_base;
> >>> -     mem->page_size = page_size;
> >>> -     mem->pages = pages;
> >>> -     mem->size = size;
> >>> +             mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> >>> +             if (!mem) {
> >>> +                     ret = -ENOMEM;
> >>> +                     goto err_mem;
> >>> +             }
> >>>
> >>> -     epc->mem = mem;
> >>> +             bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> >>> +             if (!bitmap) {
> >>> +                     ret = -ENOMEM;
> >>> +                     goto err_mem;
> >>> +             }
> >>> +
> >>> +             mem->bitmap = bitmap;
> >>> +             mem->window.phys_base = windows[i].phys_base;
> >>> +             mem->page_size = page_size;
> >>> +             mem->pages = pages;
> >>> +             mem->window.size = windows[i].size;
> >>> +             mem->window.map_size = 0;
> >>> +             mem->window.flags = windows[i].flags;
> >>> +
> >>> +             epc->mem[i] = mem;
> >>> +     }
> >>> +     epc->mem_windows = num_windows;
> >>>
> >>>       return 0;
> >>>
> >>>   err_mem:
> >>> -     kfree(mem);
> >>> +     for (; i >= 0; i--) {
> >>> +             kfree(mem->bitmap);
> >>> +             kfree(epc->mem[i]);
> >>> +     }
> >>> +     kfree(epc->mem);
> >>>
> >>> -err:
> >>> -return ret;
> >>> +     return ret;
> >>>   }
> >>>   EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
> >>>
> >>> @@ -101,48 +123,152 @@ EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
> >>>    */
> >>>   void pci_epc_mem_exit(struct pci_epc *epc)
> >>>   {
> >>> -     struct pci_epc_mem *mem = epc->mem;
> >>> +     struct pci_epc_mem *mem;
> >>> +     int i;
> >>> +
> >>> +     if (!epc->mem_windows)
> >>> +             return;
> >>> +
> >>> +     for (i = 0; i <= epc->mem_windows; i--) {
> >>> +             mem = epc->mem[i];
> >>> +             kfree(mem->bitmap);
> >>> +             kfree(epc->mem[i]);
> >>> +     }
> >>> +     kfree(epc->mem);
> >>>
> >>>       epc->mem = NULL;
> >>> -     kfree(mem->bitmap);
> >>> -     kfree(mem);
> >>> +     epc->mem_windows = 0;
> >>>   }
> >>>   EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
> >>>
> >>> +static int pci_epc_find_best_fit_window(struct pci_epc *epc, size_t size,
> >>> +                                     u32 flags)
> >>> +{
> >>> +     size_t window_least_size = 0;
> >>> +     int best_fit_window = -1;
> >>> +     struct pci_epc_mem *mem;
> >>> +     size_t actual_size;
> >>> +     size_t avail_size;
> >>> +     u32 win_flags;
> >>> +     int i;
> >>> +
> >>> +     for (i = 0; i < epc->mem_windows; i++) {
> >>> +             mem = epc->mem[i];
> >>> +             win_flags = mem->window.flags;
> >>> +
> >>> +             actual_size = ALIGN(size, mem->page_size);
> >>> +             avail_size = mem->window.size - mem->window.map_size;
> >>> +
> >>> +             if (win_flags == 0x0) {
> >>> +                     if (best_fit_window == -1) {
> >>> +                             if (actual_size <= avail_size) {
> >>> +                                     best_fit_window = i;
> >>> +                                     window_least_size = mem->window.size;
> >>> +                             }
> >>> +                     } else {
> >>> +                             if (actual_size <= avail_size &&
> >>> +                                 mem->window.size < window_least_size) {
> >>> +                                     best_fit_window = i;
> >>> +                                     window_least_size = mem->window.size;
> >>> +                             }
> >>> +                     }
> >>> +             } else {
> >>> +                     if (mem->window.map_size &&
> >>> +                         (win_flags | PCI_EPC_WINDOW_FLAG_NON_MULTI_ALLOC))
> >>> +                             continue;
> >>> +
> >>> +                     if (!(win_flags | flags))
> >>> +                             continue;
> >>> +
> >>> +                     if (best_fit_window == -1) {
> >>> +                             if (actual_size <= avail_size) {
> >>> +                                     best_fit_window = i;
> >>> +                                     window_least_size = mem->window.size;
> >>> +                             }
> >>> +                     } else {
> >>> +                             if (actual_size <= avail_size &&
> >>> +                                 mem->window.size < window_least_size) {
> >>> +                                     best_fit_window = i;
> >>> +                                     window_least_size = mem->window.size;
> >>> +                             }
> >>> +                     }
> >>> +             }
> >>> +     }
> >>> +
> >>> +     return best_fit_window;
> >>> +}
> >>> +
> >>>   /**
> >>>    * pci_epc_mem_alloc_addr() - allocate memory address from EPC addr space
> >>>    * @epc: the EPC device on which memory has to be allocated
> >>>    * @phys_addr: populate the allocated physical address here
> >>> + * @window: populate the window here which will be used to map PCI address
> >>>    * @size: the size of the address space that has to be allocated
> >>> + * @flags: look for window as requested in flags
> >>>    *
> >>>    * Invoke to allocate memory address from the EPC address space. This
> >>>    * is usually done to map the remote RC address into the local system.
> >>>    */
> >>>   void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
> >>> -                                  phys_addr_t *phys_addr, size_t size)
> >>> +                                  phys_addr_t *phys_addr,
> >>> +                                  int *window, size_t size, uint32_t flags)
> >>>   {
> >>> +     int best_fit = PCI_EPC_DEFAULT_WINDOW;
> >>> +     void __iomem *virt_addr = NULL;
> >>> +     struct pci_epc_mem *mem;
> >>> +     unsigned int page_shift;
> >>>       int pageno;
> >>> -     void __iomem *virt_addr;
> >>> -     struct pci_epc_mem *mem = epc->mem;
> >>> -     unsigned int page_shift = ilog2(mem->page_size);
> >>>       int order;
> >>>
> >>> +     if (epc->mem_windows <= 0)
> >>> +             return NULL;
> >>> +
> >>> +     if (epc->mem_windows > 1) {
> >>> +             best_fit = pci_epc_find_best_fit_window(epc, size, flags);
> >>> +             if (best_fit < 0)
> >>> +                     return NULL;
> >>> +     }
> >>> +
> >>> +     mem = epc->mem[best_fit];
> >>>       size = ALIGN(size, mem->page_size);
> >>> +     if (size > (mem->window.size - mem->window.map_size))
> >>> +             return NULL;
> >>> +     page_shift = ilog2(mem->page_size);
> >>>       order = pci_epc_mem_get_order(mem, size);
> >>>
> >>>       pageno = bitmap_find_free_region(mem->bitmap, mem->pages, order);
> >>>       if (pageno < 0)
> >>>               return NULL;
> >>>
> >>> -     *phys_addr = mem->phys_base + (pageno << page_shift);
> >>> +     *phys_addr = mem->window.phys_base + (pageno << page_shift);
> >>>       virt_addr = ioremap(*phys_addr, size);
> >>> -     if (!virt_addr)
> >>> +     if (!virt_addr) {
> >>>               bitmap_release_region(mem->bitmap, pageno, order);
> >>> +     } else {
> >>> +             mem->window.map_size += size;
> >>> +             *window = best_fit;
> >>> +     }
> >>>
> >>>       return virt_addr;
> >>>   }
> >>>   EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
> >>>
> >>> +static int pci_epc_get_matching_window(struct pci_epc *epc,
> >>> +                                    phys_addr_t phys_addr)
> >>> +{
> >>> +     struct pci_epc_mem *mem;
> >>> +     int i;
> >>> +
> >>> +     for (i = 0; i < epc->mem_windows; i++) {
> >>> +             mem = epc->mem[i];
> >>> +
> >>> +             if (mem->window.phys_base == phys_addr)
> >>> +                     return i;
> >>> +     }
> >>> +
> >>> +     return -EINVAL;
> >>> +}
> >>> +
> >>>   /**
> >>>    * pci_epc_mem_free_addr() - free the allocated memory address
> >>>    * @epc: the EPC device on which memory was allocated
> >>> @@ -155,16 +281,26 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
> >>>   void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
> >>>                          void __iomem *virt_addr, size_t size)
> >>>   {
> >>> +     struct pci_epc_mem *mem;
> >>> +     unsigned int page_shift;
> >>> +     int window = 0;
> >>>       int pageno;
> >>> -     struct pci_epc_mem *mem = epc->mem;
> >>> -     unsigned int page_shift = ilog2(mem->page_size);
> >>>       int order;
> >>>
> >>> +     if (epc->mem_windows > 1) {
> >>> +             window = pci_epc_get_matching_window(epc, phys_addr);
> >>> +             if (window < 0)
> >>> +                     return;
> >>> +     }
> >>> +
> >>> +     mem = epc->mem[window];
> >>> +     page_shift = ilog2(mem->page_size);
> >>>       iounmap(virt_addr);
> >>> -     pageno = (phys_addr - mem->phys_base) >> page_shift;
> >>> +     pageno = (phys_addr - mem->window.phys_base) >> page_shift;
> >>>       size = ALIGN(size, mem->page_size);
> >>>       order = pci_epc_mem_get_order(mem, size);
> >>>       bitmap_release_region(mem->bitmap, pageno, order);
> >>> +     mem->window.map_size -= size;
> >>>   }
> >>>   EXPORT_SYMBOL_GPL(pci_epc_mem_free_addr);
> >>>
> >>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> >>> index f641bad..bee6f65 100644
> >>> --- a/include/linux/pci-epc.h
> >>> +++ b/include/linux/pci-epc.h
> >>> @@ -48,7 +48,8 @@ struct pci_epc_ops {
> >>>       void    (*clear_bar)(struct pci_epc *epc, u8 func_no,
> >>>                            struct pci_epf_bar *epf_bar);
> >>>       int     (*map_addr)(struct pci_epc *epc, u8 func_no,
> >>> -                         phys_addr_t addr, u64 pci_addr, size_t size);
> >>> +                         phys_addr_t addr, int window,
> >>> +                         u64 pci_addr, size_t size);
> >>>       void    (*unmap_addr)(struct pci_epc *epc, u8 func_no,
> >>>                             phys_addr_t addr);
> >>>       int     (*set_msi)(struct pci_epc *epc, u8 func_no, u8 interrupts);
> >>> @@ -64,17 +65,57 @@ struct pci_epc_ops {
> >>>       struct module *owner;
> >>>   };
> >>>
> >>> +#define PCI_EPC_DEFAULT_WINDOW               0
> >>> +
> >>> +/**
> >>> + * enum pci_epc_window_flags - flags info for pci_epc_mem_window
> >>> + *
> >>> + * This enum defines how the endpoint controller window should be used
> >>> + * for allocations.
> >>> + *
> >>> + * @PCI_EPC_WINDOW_FLAG_MULTI_ALLOC: Indicates multiple chunks of memory can be
> >>> + *                                allocated from same window
> >>> + * @PCI_EPC_WINDOW_FLAG_NON_MULTI_ALLOC: Indicates only single memory allocation
> >>> + *                                    is possible on the window
> >>
> >> Instead of NON_MULTI_ALLOC, we could simply have different page_size for
> >> different windows. For a platform that doesn't allow multiple alloc,
> >> page size will be equal to the window size.
> >>
> > I would still prefer this flag and not go with page size = window size
> > as we could allocate unnecessary memory
>
> Nor sure I understand you here. If you have
> PCI_EPC_WINDOW_FLAG_NON_MULTI_ALLOC, wouldn't it mean, you cannot have
> more than 1 allocation in the entire window. Setting page size same as
> window size will also mean the same thing.
> > that might not be used and also the window sizes might be too large.
>
> IMHO We could still have flags to provide a type for a window and
> directing the allocation to a particular window with a type. But
> at-least for the use case that you are trying to solve, it's simpler to
> have page_size = window_size and the allocation algorithm need not change.
>
this will make things simpler, I'll drop all the above flags and OF
code to parse the regions,
and go with just setting page-size = window-size for my use case.

Cheers,
--Prabhakar
