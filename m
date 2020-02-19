Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4FCA16400F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2020 10:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgBSJPS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Feb 2020 04:15:18 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41776 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgBSJPS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2020 04:15:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so22407583otc.8;
        Wed, 19 Feb 2020 01:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z94offAhiTXYY7d3Gv4jh9oiGyU1GlKrXhs1YviG/Gc=;
        b=ap/R9lgavtm5U29KILyGxw4cpVKlMU1fvpcu4zhodabXZ2A3q5ahExzUaA5bXpASE7
         3NtLkRab0PD5GoEg6P+Ai6fneRaJ3b3gAwWfm8PucFfBOsN0g7nYvQPhLzRng70WqskD
         m6tHlUQoMdeLj9yBtx+R+afRZSzucgg91TaP2Jdbho6JQ0WaDHV9sa+LZgDRgT9BXLvg
         mpKpSuuouEeXR0LdC/zmzcoWE1MqYuktKjfuQrdyxJqQyPxRv2E2u5PYhkvSXwPbiTAj
         bQSCnvfMEo9HfxCgRzu5LjDIaaaW+bi0ADKA+Ru0dwLkdYQhzPWCMtSY0aO+zL3OAV1c
         /kKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z94offAhiTXYY7d3Gv4jh9oiGyU1GlKrXhs1YviG/Gc=;
        b=rCGF3icFwv2bbtEqVDdvaEvVs448/ZUDfGzXHOWYSDNnBuDBe2VpdkKBnCMgBrKPWa
         Rpzot+1wwZYPAMuqG6vKnUGkDnUQhiymyHQL2Np5hFxDioe4bUIfWFeW17RuTqfBYmu8
         tBwx7PX/5nL4DH+hWncfrj5+zWM0mEoT3+Wr8x3KxAQ8Khf8oImMPbLMdz9oPxa0MMGT
         xRQhwltwdGLxl0oAMZtOH9CJYgWUsUy2wp/Ri2lVw3IYLWXeQjOIo3S2wLF0Zqxmkbje
         n9ODqXb4/S3LVyEnweXynlcBff9dJ+lTYDx8LY8cc/SRZHt8jjvwZC82G+AU7IKeyQ6b
         69ug==
X-Gm-Message-State: APjAAAVgwQresd1ODtsH+97+Hmt6nUy4ukQ2wS3n7JaSGQD5hhZwoHm7
        qkRLLpdSzTGEbDf7YffXdd2IcGEizEuSrHeiMT8=
X-Google-Smtp-Source: APXvYqz6uqsPQCH/4m4O4finc9kCSI3MtsNYG7mfYy6DWIVoxSbUx+2rNysJOG1Bpt/wTx67ppdhgGef8tUfCaqwB+U=
X-Received: by 2002:a9d:64ca:: with SMTP id n10mr19003495otl.325.1582103714392;
 Wed, 19 Feb 2020 01:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200208183641.6674-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200208183641.6674-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 19 Feb 2020 09:14:48 +0000
Message-ID: <CA+V-a8t1gKZxK8xSYBnZP9cNhcVTdQvNRiwCmVROMGRfoSOw=A@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] PCI: endpoint: Add support to handle multiple base
 for mapping outbound memory
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On Sat, Feb 8, 2020 at 6:36 PM Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> R-Car PCIe controller has support to map multiple memory regions for
> mapping the outbound memory in local system also the controller limits
> single allocation for each region (that is, once a chunk is used from the
> region it cannot be used to allocate a new one). This features inspires to
> add support for handling multiple memory bases in endpoint framework.
>
> With this patch pci_epc_mem_init() now accepts multiple regions, also
> page_size for each memory region is passed during initialization so as
> to handle single allocation for each region by setting the page_size to
> window_size.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c |   7 +-
>  drivers/pci/controller/dwc/pcie-designware-ep.c  |  29 ++--
>  drivers/pci/controller/pcie-rockchip-ep.c        |   7 +-
>  drivers/pci/endpoint/pci-epc-mem.c               | 166 ++++++++++++++++-------
>  include/linux/pci-epc.h                          |  39 ++++--
>  5 files changed, 168 insertions(+), 80 deletions(-)
>
Could you please review the patch, as I intend to post a v5 with minor
tweaks for patch 01/06.
It would be good if I get your Ack on this patch.

Cheers,
--Prabhakar

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 1c173da..90e32438 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -401,6 +401,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>         struct device *dev = ep->pcie.dev;
>         struct platform_device *pdev = to_platform_device(dev);
>         struct device_node *np = dev->of_node;
> +       struct pci_epc_mem_window mem_window;
>         struct cdns_pcie *pcie = &ep->pcie;
>         struct resource *res;
>         struct pci_epc *epc;
> @@ -449,8 +450,10 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>         if (of_property_read_u8(np, "max-functions", &epc->max_functions) < 0)
>                 epc->max_functions = 1;
>
> -       ret = pci_epc_mem_init(epc, pcie->mem_res->start,
> -                              resource_size(pcie->mem_res));
> +       mem_window.phys_base = pcie->mem_res->start;
> +       mem_window.size = resource_size(pcie->mem_res);
> +       mem_window.page_size = PAGE_SIZE;
> +       ret = pci_epc_mem_init(epc, &mem_window, 1);
>         if (ret < 0) {
>                 dev_err(dev, "failed to initialize the memory space\n");
>                 goto err_init;
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index cfeccd7..b150ef3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -195,8 +195,7 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no,
>  }
>
>  static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
> -                              phys_addr_t addr,
> -                              u64 pci_addr, size_t size)
> +                              phys_addr_t addr, u64 pci_addr, size_t size)
>  {
>         int ret;
>         struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> @@ -367,6 +366,7 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>         unsigned int aligned_offset;
>         u16 msg_ctrl, msg_data;
>         u32 msg_addr_lower, msg_addr_upper, reg;
> +       int window = PCI_EPC_DEFAULT_WINDOW;
>         u64 msg_addr;
>         bool has_upper;
>         int ret;
> @@ -390,11 +390,11 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>                 reg = ep->msi_cap + PCI_MSI_DATA_32;
>                 msg_data = dw_pcie_readw_dbi(pci, reg);
>         }
> -       aligned_offset = msg_addr_lower & (epc->mem->page_size - 1);
> +       aligned_offset = msg_addr_lower & (epc->mem[window]->page_size - 1);
>         msg_addr = ((u64)msg_addr_upper) << 32 |
>                         (msg_addr_lower & ~aligned_offset);
> -       ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
> -                                 epc->mem->page_size);
> +       ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys,
> +                                 msg_addr, epc->mem[window]->page_size);
>         if (ret)
>                 return ret;
>
> @@ -416,6 +416,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>         u32 reg, msg_data, vec_ctrl;
>         u64 tbl_addr, msg_addr, reg_u64;
>         void __iomem *msix_tbl;
> +       int window = PCI_EPC_DEFAULT_WINDOW;
>         int ret;
>
>         reg = ep->msix_cap + PCI_MSIX_TABLE;
> @@ -452,8 +453,8 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>                 return -EPERM;
>         }
>
> -       ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
> -                                 epc->mem->page_size);
> +       ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys,
> +                                 msg_addr, epc->mem[window]->page_size);
>         if (ret)
>                 return ret;
>
> @@ -466,10 +467,11 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>
>  void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  {
> +       int window = PCI_EPC_DEFAULT_WINDOW;
>         struct pci_epc *epc = ep->epc;
>
>         pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> -                             epc->mem->page_size);
> +                             epc->mem[window]->page_size);
>
>         pci_epc_mem_exit(epc);
>  }
> @@ -502,6 +504,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>         unsigned int nbars;
>         unsigned int offset;
>         struct pci_epc *epc;
> +       size_t msi_page_size;
> +       struct pci_epc_mem_window mem_window;
>         struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>         struct device *dev = pci->dev;
>         struct device_node *np = dev->of_node;
> @@ -574,15 +578,18 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>         if (ret < 0)
>                 epc->max_functions = 1;
>
> -       ret = __pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
> -                                ep->page_size);
> +       mem_window.phys_base = ep->phys_base;
> +       mem_window.size = ep->addr_size;
> +       mem_window.page_size = ep->page_size;
> +       ret = __pci_epc_mem_init(epc, &mem_window, 1);
>         if (ret < 0) {
>                 dev_err(dev, "Failed to initialize address space\n");
>                 return ret;
>         }
>
> +       msi_page_size = epc->mem[PCI_EPC_DEFAULT_WINDOW]->page_size;
>         ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> -                                            epc->mem->page_size);
> +                                            msi_page_size);
>         if (!ep->msi_mem) {
>                 dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
>                 return -ENOMEM;
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index d743b0a..5a97390 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -562,6 +562,7 @@ static const struct of_device_id rockchip_pcie_ep_of_match[] = {
>
>  static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>  {
> +       struct pci_epc_mem_window mem_window;
>         struct device *dev = &pdev->dev;
>         struct rockchip_pcie_ep *ep;
>         struct rockchip_pcie *rockchip;
> @@ -614,8 +615,10 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>         /* Only enable function 0 by default */
>         rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
>
> -       err = pci_epc_mem_init(epc, rockchip->mem_res->start,
> -                              resource_size(rockchip->mem_res));
> +       mem_window.phys_base = rockchip->mem_res->start;
> +       mem_window.size = resource_size(rockchip->mem_res);
> +       mem_window.page_size = PAGE_SIZE;
> +       err = pci_epc_mem_init(epc, &mem_window, 1);
>         if (err < 0) {
>                 dev_err(dev, "failed to initialize the memory space\n");
>                 goto err_uninit_port;
> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> index d2b174c..b3eedee 100644
> --- a/drivers/pci/endpoint/pci-epc-mem.c
> +++ b/drivers/pci/endpoint/pci-epc-mem.c
> @@ -38,57 +38,76 @@ static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
>  /**
>   * __pci_epc_mem_init() - initialize the pci_epc_mem structure
>   * @epc: the EPC device that invoked pci_epc_mem_init
> - * @phys_base: the physical address of the base
> - * @size: the size of the address space
> - * @page_size: size of each page
> + * @windows: pointer to windows supported by the device
> + * @num_windows: number of windows device supports
>   *
>   * Invoke to initialize the pci_epc_mem structure used by the
>   * endpoint functions to allocate mapped PCI address.
>   */
> -int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_base, size_t size,
> -                      size_t page_size)
> +int __pci_epc_mem_init(struct pci_epc *epc, struct pci_epc_mem_window *windows,
> +                      int num_windows)
>  {
> -       int ret;
> -       struct pci_epc_mem *mem;
> -       unsigned long *bitmap;
> +       struct pci_epc_mem *mem = NULL;
> +       unsigned long *bitmap = NULL;
>         unsigned int page_shift;
> -       int pages;
> +       size_t page_size;
>         int bitmap_size;
> -
> -       if (page_size < PAGE_SIZE)
> -               page_size = PAGE_SIZE;
> -
> -       page_shift = ilog2(page_size);
> -       pages = size >> page_shift;
> -       bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> -
> -       mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> -       if (!mem) {
> -               ret = -ENOMEM;
> -               goto err;
> -       }
> -
> -       bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> -       if (!bitmap) {
> -               ret = -ENOMEM;
> -               goto err_mem;
> +       int pages;
> +       int ret;
> +       int i;
> +
> +       epc->mem_windows = 0;
> +
> +       if (!windows)
> +               return -EINVAL;
> +
> +       if (num_windows <= 0)
> +               return -EINVAL;
> +
> +       epc->mem = kcalloc(num_windows, sizeof(*mem), GFP_KERNEL);
> +       if (!epc->mem)
> +               return -EINVAL;
> +
> +       for (i = 0; i < num_windows; i++) {
> +               page_size = windows[i].page_size;
> +               if (page_size < PAGE_SIZE)
> +                       page_size = PAGE_SIZE;
> +               page_shift = ilog2(page_size);
> +               pages = windows[i].size >> page_shift;
> +               bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> +
> +               mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> +               if (!mem) {
> +                       ret = -ENOMEM;
> +                       goto err_mem;
> +               }
> +
> +               bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> +               if (!bitmap) {
> +                       ret = -ENOMEM;
> +                       goto err_mem;
> +               }
> +
> +               mem->bitmap = bitmap;
> +               mem->window.phys_base = windows[i].phys_base;
> +               mem->page_size = page_size;
> +               mem->pages = pages;
> +               mem->window.size = windows[i].size;
> +               epc->mem[i] = mem;
>         }
> -
> -       mem->bitmap = bitmap;
> -       mem->phys_base = phys_base;
> -       mem->page_size = page_size;
> -       mem->pages = pages;
> -       mem->size = size;
> -
> -       epc->mem = mem;
> +       epc->mem_windows = num_windows;
>
>         return 0;
>
>  err_mem:
> -       kfree(mem);
> +       for (; i >= 0; i--) {
> +               mem = epc->mem[i];
> +               kfree(mem->bitmap);
> +               kfree(mem);
> +       }
> +       kfree(epc->mem);
>
> -err:
> -return ret;
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
>
> @@ -101,11 +120,21 @@ EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
>   */
>  void pci_epc_mem_exit(struct pci_epc *epc)
>  {
> -       struct pci_epc_mem *mem = epc->mem;
> +       struct pci_epc_mem *mem;
> +       int i;
> +
> +       if (!epc->mem_windows)
> +               return;
> +
> +       for (i = 0; i <= epc->mem_windows; i++) {
> +               mem = epc->mem[i];
> +               kfree(mem->bitmap);
> +               kfree(mem);
> +       }
> +       kfree(epc->mem);
>
>         epc->mem = NULL;
> -       kfree(mem->bitmap);
> -       kfree(mem);
> +       epc->mem_windows = 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
>
> @@ -121,20 +150,30 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
>  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>                                      phys_addr_t *phys_addr, size_t size)
>  {
> -       int pageno;
> -       void __iomem *virt_addr;
> -       struct pci_epc_mem *mem = epc->mem;
> -       unsigned int page_shift = ilog2(mem->page_size);
> +       void __iomem *virt_addr = NULL;
> +       struct pci_epc_mem *mem;
> +       unsigned int page_shift;
> +       int pageno = -EINVAL;
>         int order;
> +       int i;
>
> -       size = ALIGN(size, mem->page_size);
> -       order = pci_epc_mem_get_order(mem, size);
> +       for (i = 0; i < epc->mem_windows; i++) {
> +               mem = epc->mem[i];
> +               size = ALIGN(size, mem->page_size);
> +               order = pci_epc_mem_get_order(mem, size);
> +
> +               pageno = bitmap_find_free_region(mem->bitmap, mem->pages,
> +                                                order);
> +               if (pageno >= 0)
> +                       break;
> +       }
>
> -       pageno = bitmap_find_free_region(mem->bitmap, mem->pages, order);
>         if (pageno < 0)
>                 return NULL;
>
> -       *phys_addr = mem->phys_base + ((phys_addr_t)pageno << page_shift);
> +       page_shift = ilog2(mem->page_size);
> +       *phys_addr = mem->window.phys_base +
> +                    ((phys_addr_t)pageno << page_shift);
>         virt_addr = ioremap(*phys_addr, size);
>         if (!virt_addr)
>                 bitmap_release_region(mem->bitmap, pageno, order);
> @@ -143,6 +182,22 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
>
> +struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *epc,
> +                                               phys_addr_t phys_addr)
> +{
> +       struct pci_epc_mem *mem;
> +       int i;
> +
> +       for (i = 0; i < epc->mem_windows; i++) {
> +               mem = epc->mem[i];
> +
> +               if (mem->window.phys_base == phys_addr)
> +                       return mem;
> +       }
> +
> +       return NULL;
> +}
> +
>  /**
>   * pci_epc_mem_free_addr() - free the allocated memory address
>   * @epc: the EPC device on which memory was allocated
> @@ -155,13 +210,20 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
>  void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
>                            void __iomem *virt_addr, size_t size)
>  {
> +       struct pci_epc_mem *mem;
> +       unsigned int page_shift;
>         int pageno;
> -       struct pci_epc_mem *mem = epc->mem;
> -       unsigned int page_shift = ilog2(mem->page_size);
>         int order;
>
> +       mem = pci_epc_get_matching_window(epc, phys_addr);
> +       if (!mem) {
> +               pr_err("failed to get matching window\n");
> +               return;
> +       }
> +
> +       page_shift = ilog2(mem->page_size);
>         iounmap(virt_addr);
> -       pageno = (phys_addr - mem->phys_base) >> page_shift;
> +       pageno = (phys_addr - mem->window.phys_base) >> page_shift;
>         size = ALIGN(size, mem->page_size);
>         order = pci_epc_mem_get_order(mem, size);
>         bitmap_release_region(mem->bitmap, pageno, order);
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 56f1846..dde42e5 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -64,17 +64,29 @@ struct pci_epc_ops {
>         struct module *owner;
>  };
>
> +#define PCI_EPC_DEFAULT_WINDOW         0
> +
> +/**
> + * struct pci_epc_mem_window - address window of the endpoint controller
> + * @phys_base: physical base address of the PCI address window
> + * @size: the size of the PCI address window
> + * @page_size: size of each page
> + */
> +struct pci_epc_mem_window {
> +       phys_addr_t     phys_base;
> +       size_t          size;
> +       size_t          page_size;
> +};
> +
>  /**
>   * struct pci_epc_mem - address space of the endpoint controller
> - * @phys_base: physical base address of the PCI address space
> - * @size: the size of the PCI address space
> + * @window: address window of the endpoint controller
>   * @bitmap: bitmap to manage the PCI address space
> - * @pages: number of bits representing the address region
>   * @page_size: size of each page
> + * @pages: number of bits representing the address region
>   */
>  struct pci_epc_mem {
> -       phys_addr_t     phys_base;
> -       size_t          size;
> +       struct pci_epc_mem_window window;
>         unsigned long   *bitmap;
>         size_t          page_size;
>         int             pages;
> @@ -85,7 +97,8 @@ struct pci_epc_mem {
>   * @dev: PCI EPC device
>   * @pci_epf: list of endpoint functions present in this EPC device
>   * @ops: function pointers for performing endpoint operations
> - * @mem: address space of the endpoint controller
> + * @mem: array of address space of the endpoint controller
> + * @mem_windows: number of windows supported by device
>   * @max_functions: max number of functions that can be configured in this EPC
>   * @group: configfs group representing the PCI EPC device
>   * @lock: spinlock to protect pci_epc ops
> @@ -94,7 +107,8 @@ struct pci_epc {
>         struct device                   dev;
>         struct list_head                pci_epf;
>         const struct pci_epc_ops        *ops;
> -       struct pci_epc_mem              *mem;
> +       struct pci_epc_mem              **mem;
> +       unsigned int                    mem_windows;
>         u8                              max_functions;
>         struct config_group             *group;
>         /* spinlock to protect against concurrent access of EP controller */
> @@ -128,8 +142,8 @@ struct pci_epc_features {
>  #define devm_pci_epc_create(dev, ops)    \
>                 __devm_pci_epc_create((dev), (ops), THIS_MODULE)
>
> -#define pci_epc_mem_init(epc, phys_addr, size) \
> -               __pci_epc_mem_init((epc), (phys_addr), (size), PAGE_SIZE)
> +#define pci_epc_mem_init(epc, windows, num_windows)    \
> +               __pci_epc_mem_init((epc), windows, num_windows)
>
>  static inline void epc_set_drvdata(struct pci_epc *epc, void *data)
>  {
> @@ -159,8 +173,7 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
>  void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
>                        struct pci_epf_bar *epf_bar);
>  int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
> -                    phys_addr_t phys_addr,
> -                    u64 pci_addr, size_t size);
> +                    phys_addr_t phys_addr, u64 pci_addr, size_t size);
>  void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
>                         phys_addr_t phys_addr);
>  int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts);
> @@ -178,8 +191,8 @@ unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
>  struct pci_epc *pci_epc_get(const char *epc_name);
>  void pci_epc_put(struct pci_epc *epc);
>
> -int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_addr, size_t size,
> -                      size_t page_size);
> +int __pci_epc_mem_init(struct pci_epc *epc, struct pci_epc_mem_window *window,
> +                      int num_windows);
>  void pci_epc_mem_exit(struct pci_epc *epc);
>  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>                                      phys_addr_t *phys_addr, size_t size);
> --
> 2.7.4
>
