Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E901E31D5
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 00:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390639AbgEZV7y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 17:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389342AbgEZV7w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 17:59:52 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA36E20888;
        Tue, 26 May 2020 21:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590530389;
        bh=xSQFmzVdzoUxfcvu2wRUbVRudyOKHlC9Ggsne2O28nk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wIoyNl8sZb0rcAZMzv0xSyDN6VEKW1zxSlT9y1KKVv7b4drKBPKObOJIjaYLdlH/6
         IJ30cBvZwr+hEky74P74aVug6w/nwCgxCzshK8HMCbAM0Ry5ToAtS7mzxlvnAIjn/5
         dDku9Yd/sowosCqsh+m3Wmwooleh9Y1MWqHMkTQE=
Received: by mail-ot1-f45.google.com with SMTP id d26so17624626otc.7;
        Tue, 26 May 2020 14:59:49 -0700 (PDT)
X-Gm-Message-State: AOAM530octb8L1Xzn5XPXC3S/1ZDEVI4b8bWvA64TeaMCdiHI5UIHKMU
        eSVgUF+Kc7EqQHOTV84QhSfSxEjQIdZXvBP7Uw==
X-Google-Smtp-Source: ABdhPJxZ29D5JIphVKIB98kPYk/w2fSSW7w/Fywqa7ubkhWimWpMV3z0+WNoryqvUGnpR91IH6G4hNaVN6NQOoMFzv8=
X-Received: by 2002:a05:6830:18d9:: with SMTP id v25mr2269954ote.107.1590530388991;
 Tue, 26 May 2020 14:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200521080153.5902-1-kishon@ti.com>
In-Reply-To: <20200521080153.5902-1-kishon@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 26 May 2020 15:59:37 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+ZScKn1BJ9YWcs1uNEmLq5+XOdWfFNfF-S7cAqkYB1KA@mail.gmail.com>
Message-ID: <CAL_Jsq+ZScKn1BJ9YWcs1uNEmLq5+XOdWfFNfF-S7cAqkYB1KA@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: cadence: Use "dma-ranges" instead of
 "cdns,no-bar-match-nbits" property
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 2:02 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Cadence PCIe core driver (host mode) uses "cdns,no-bar-match-nbits"
> property to configure the number of bits passed through from PCIe
> address to internal address in Inbound Address Translation register.
> This only used the NO MATCH BAR.
>
> However standard PCI dt-binding already defines "dma-ranges" to
> describe the address ranges accessible by PCIe controller. Add support
> in Cadence PCIe host driver to parse dma-ranges and configure the
> inbound regions for BAR0, BAR1 and NO MATCH BAR. Cadence IP specifies
> maximum size for BAR0 as 256GB, maximum size for BAR1 as 2 GB.
>
> This adds support to take the next biggest region in "dma-ranges" and
> find the smallest BAR that each of the regions fit in and if there is
> no BAR big enough to hold the region, split the region to see if it can
> be fitted using multiple BARs.
>
> "dma-ranges" of J721E will be
> dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
> Since there is no BAR which can hold 2^48 size, NO_MATCH_BAR will be
> used here.
>
> Legacy device tree binding compatibility is maintained by retaining
> support for "cdns,no-bar-match-nbits".
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> The previous version of the patch can be found @
> https://lore.kernel.org/linux-arm-kernel/20200508130646.23939-5-kishon@ti.com/
>
> Changes from v3:
> *) The whole logic of how we select a BAR to fit a region from
> dma-ranges has been changed.
>   1) First select the biggest region in "dma-ranges" (after combining
>      adjacent regions)
>   2) Try to fit this region in a smallest available BAR whose size is
>      greater than the region size
>   3) If no such BAR is available try to find biggest availalbe BAR
>      whose size is lesser than the region size and only fit part of the
>      region in that BAR.
>   4) Repeat steps 3 and 4, to fit the remaining region size.
>  .../controller/cadence/pcie-cadence-host.c    | 254 +++++++++++++++++-
>  drivers/pci/controller/cadence/pcie-cadence.h |  28 +-
>  2 files changed, 265 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 6ecebb79057a..cf8b34b71b8f 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -11,6 +11,12 @@
>
>  #include "pcie-cadence.h"
>
> +static u64 bar_max_size[] = {
> +       [RP_BAR0] = _ULL(128 * SZ_2G),
> +       [RP_BAR1] = SZ_2G,
> +       [RP_NO_BAR] = _BITULL(63),
> +};
> +
>  void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>                                int where)
>  {
> @@ -106,6 +112,226 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>         return 0;
>  }
>
> +static int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
> +                                       enum cdns_pcie_rp_bar bar,
> +                                       u64 cpu_addr, u64 size,
> +                                       unsigned long flags)
> +{
> +       struct cdns_pcie *pcie = &rc->pcie;
> +       u32 addr0, addr1, aperture, value;
> +
> +       if (!rc->avail_ib_bar[bar])
> +               return -EBUSY;
> +
> +       rc->avail_ib_bar[bar] = false;
> +
> +       aperture = ilog2(size);
> +       addr0 = CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS(aperture) |
> +               (lower_32_bits(cpu_addr) & GENMASK(31, 8));
> +       addr1 = upper_32_bits(cpu_addr);
> +       cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR0(bar), addr0);
> +       cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar), addr1);
> +
> +       if (bar == RP_NO_BAR)
> +               return 0;
> +
> +       value = cdns_pcie_readl(pcie, CDNS_PCIE_LM_RC_BAR_CFG);

Why do you need to read this first? If you do, don't you need to clear
out any fields you're potentially writing?

> +       if (size + cpu_addr >= SZ_4G) {
> +               if (!(flags & IORESOURCE_PREFETCH))
> +                       value |= LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar);
> +               value |= LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
> +       } else {
> +               if (!(flags & IORESOURCE_PREFETCH))
> +                       value |= LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
> +               value |= LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
> +       }
> +
> +       value |= LM_RC_BAR_CFG_APERTURE(bar, aperture);
> +       cdns_pcie_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
> +
> +       return 0;
> +}
> +
> +static enum cdns_pcie_rp_bar
> +cdns_pcie_host_find_min_bar(struct cdns_pcie_rc *rc, u64 size)
> +{
> +       enum cdns_pcie_rp_bar bar, sel_bar;
> +
> +       sel_bar = RP_BAR_UNDEFINED;
> +       for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++) {
> +               if (!rc->avail_ib_bar[bar])
> +                       continue;
> +
> +               if (size <= bar_max_size[bar]) {
> +                       if (sel_bar == RP_BAR_UNDEFINED) {
> +                               sel_bar = bar;
> +                               continue;
> +                       }
> +
> +                       if (bar_max_size[bar] < bar_max_size[sel_bar])
> +                               sel_bar = bar;
> +               }
> +       }
> +
> +       return sel_bar;
> +}
> +
> +static enum cdns_pcie_rp_bar
> +cdns_pcie_host_find_max_bar(struct cdns_pcie_rc *rc, u64 size)
> +{
> +       enum cdns_pcie_rp_bar bar, sel_bar;
> +
> +       sel_bar = RP_BAR_UNDEFINED;
> +       for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++) {
> +               if (!rc->avail_ib_bar[bar])
> +                       continue;
> +
> +               if (size >= bar_max_size[bar]) {
> +                       if (sel_bar == RP_BAR_UNDEFINED) {
> +                               sel_bar = bar;
> +                               continue;
> +                       }
> +
> +                       if (bar_max_size[bar] > bar_max_size[sel_bar])
> +                               sel_bar = bar;
> +               }
> +       }
> +
> +       return sel_bar;
> +}
> +
> +static int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
> +                                    struct resource_entry *entry)
> +{
> +       u64 cpu_addr, pci_addr, size, winsize;
> +       struct cdns_pcie *pcie = &rc->pcie;
> +       struct device *dev = pcie->dev;
> +       enum cdns_pcie_rp_bar bar;
> +       unsigned long flags;
> +       int ret;
> +
> +       cpu_addr = entry->res->start;
> +       pci_addr = entry->res->start - entry->offset;
> +       flags = entry->res->flags;
> +       size = resource_size(entry->res);
> +
> +       if (entry->offset) {
> +               dev_err(dev, "PCI addr: %llx must be equal to CPU addr: %llx\n",
> +                       pci_addr, cpu_addr);
> +               return -EINVAL;
> +       }
> +
> +       while (size > 0) {
> +               /*
> +                * Try to find a minimum BAR whose size is greater than
> +                * or equal to the remaining resource_entry size. This will
> +                * fail if the size of each of the available BARs is less than
> +                * the remaining resource_entry size.
> +                * If a minimum BAR is found, IB ATU will be configured and
> +                * exited.
> +                */
> +               bar = cdns_pcie_host_find_min_bar(rc, size);
> +               if (bar != RP_BAR_UNDEFINED) {
> +                       ret = cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr,
> +                                                          size, flags);
> +                       if (ret)
> +                               dev_err(dev, "IB BAR: %d config failed\n", bar);
> +                       return ret;
> +               }
> +
> +               /*
> +                * If the control reaches here, it would mean the remaining
> +                * resource_entry size cannot be fitted in a single BAR. So we
> +                * find a maximum BAR whose size is less than or equal to the
> +                * remaining resource_entry size and split the resource entry
> +                * so that part of resource entry is fitted inside the maximum
> +                * BAR. The remaining size would be fitted during the next
> +                * iteration of the loop.
> +                * If a maximum BAR is not found, there is no way we can fit
> +                * this resource_entry, so we error out.
> +                */
> +               bar = cdns_pcie_host_find_max_bar(rc, size);
> +               if (bar == RP_BAR_UNDEFINED) {
> +                       dev_err(dev, "No free BAR to map cpu_addr %llx\n",
> +                               cpu_addr);
> +                       return -EINVAL;
> +               }
> +
> +               winsize = bar_max_size[bar];
> +               ret = cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr, winsize,
> +                                                  flags);
> +               if (ret) {
> +                       dev_err(dev, "IB BAR: %d config failed\n", bar);
> +                       return ret;
> +               }
> +
> +               size -= winsize;
> +               cpu_addr += winsize;
> +       }
> +
> +       return 0;
> +}
> +
> +static int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc)
> +{
> +       struct resource_entry *entry, *ib_range[CDNS_PCIE_RP_MAX_IB];
> +       struct cdns_pcie *pcie = &rc->pcie;
> +       struct device *dev = pcie->dev;
> +       struct device_node *np = dev->of_node;
> +       struct pci_host_bridge *bridge;
> +       u32 no_bar_nbits = 32;
> +       int i = 0, j = 0, err;
> +       u64 size;
> +
> +       bridge = pci_host_bridge_from_priv(rc);
> +       if (!bridge)
> +               return -ENOMEM;
> +
> +       if (list_empty(&bridge->dma_ranges)) {
> +               of_property_read_u32(np, "cdns,no-bar-match-nbits",
> +                                    &no_bar_nbits);
> +               err = cdns_pcie_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
> +                                                  (u64)1 << no_bar_nbits, 0);
> +               if (err)
> +                       dev_err(dev, "IB BAR: %d config failed\n", RP_NO_BAR);
> +               return err;
> +       }
> +
> +       memset(ib_range, 0x00, sizeof(ib_range));
> +       /* Sort the resource entries in descending order by resource size */

Use list_sort()

> +       resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> +               if (i > CDNS_PCIE_RP_MAX_IB - 1) {
> +                       dev_err(dev, "Ranges exceed maximum supported %d\n",

s/Ranges/dma-ranges entries/

> +                               CDNS_PCIE_RP_MAX_IB);
> +                       return -EINVAL;
> +               }
> +
> +               j = i - 1;
> +               while (j >= 0) {
> +                       size = resource_size(ib_range[j]->res);
> +                       if (size < resource_size(entry->res)) {
> +                               ib_range[j + 1] = ib_range[j];
> +                               j--;
> +                       }
> +               }
> +               ib_range[j + 1] = entry;
> +               i++;
> +       }
> +
> +       for (i = 0; i < CDNS_PCIE_RP_MAX_IB; i++) {
> +               if (!ib_range[i])
> +                       break;
> +
> +               err = cdns_pcie_host_bar_config(rc, ib_range[i]);
> +               if (err) {
> +                       dev_err(dev, "Fail to configure IB using dma-ranges\n");
> +                       return err;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>  {
>         struct cdns_pcie *pcie = &rc->pcie;
> @@ -160,16 +386,9 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>                 r++;
>         }
>
> -       /*
> -        * Set Root Port no BAR match Inbound Translation registers:
> -        * needed for MSI and DMA.
> -        * Root Port BAR0 and BAR1 are disabled, hence no need to set their
> -        * inbound translation registers.
> -        */
> -       addr0 = CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS(rc->no_bar_nbits);
> -       addr1 = 0;
> -       cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR0(RP_NO_BAR), addr0);
> -       cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR1(RP_NO_BAR), addr1);
> +       err = cdns_pcie_host_map_dma_ranges(rc);
> +       if (err)
> +               return err;
>
>         return 0;
>  }
> @@ -179,10 +398,16 @@ static int cdns_pcie_host_init(struct device *dev,
>                                struct cdns_pcie_rc *rc)
>  {
>         struct resource *bus_range = NULL;
> +       struct pci_host_bridge *bridge;
>         int err;
>
> +       bridge = pci_host_bridge_from_priv(rc);
> +       if (!bridge)
> +               return -ENOMEM;
> +
>         /* Parse our PCI ranges and request their resources */
> -       err = pci_parse_request_of_pci_ranges(dev, resources, NULL, &bus_range);
> +       err = pci_parse_request_of_pci_ranges(dev, resources,
> +                                             &bridge->dma_ranges, &bus_range);
>         if (err)
>                 return err;
>
> @@ -228,6 +453,7 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>         struct device_node *np = dev->of_node;
>         struct pci_host_bridge *bridge;
>         struct list_head resources;
> +       enum cdns_pcie_rp_bar bar;
>         struct cdns_pcie *pcie;
>         struct resource *res;
>         int ret;
> @@ -239,9 +465,6 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>         pcie = &rc->pcie;
>         pcie->is_rc = true;
>
> -       rc->no_bar_nbits = 32;
> -       of_property_read_u32(np, "cdns,no-bar-match-nbits", &rc->no_bar_nbits);
> -
>         rc->vendor_id = 0xffff;
>         of_property_read_u32(np, "vendor-id", &rc->vendor_id);
>
> @@ -273,6 +496,9 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>         if (ret)
>                 dev_dbg(dev, "PCIe link never came up\n");
>
> +       for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++)
> +               rc->avail_ib_bar[bar] = true;
> +
>         ret = cdns_pcie_host_init(dev, &resources, rc);
>         if (ret)
>                 return ret;
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index f349f5828a58..a0be87ca9a3a 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -92,6 +92,20 @@
>  #define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS          0x6
>  #define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS 0x7
>
> +#define LM_RC_BAR_CFG_CTRL_DISABLED(bar)               \
> +               (CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED << (((bar) * 8) + 6))
> +#define LM_RC_BAR_CFG_CTRL_IO_32BITS(bar)              \
> +               (CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS << (((bar) * 8) + 6))
> +#define LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar)             \
> +               (CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS << (((bar) * 8) + 6))
> +#define LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar)        \
> +       (CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS << (((bar) * 8) + 6))
> +#define LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar)             \
> +               (CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS << (((bar) * 8) + 6))
> +#define LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar)        \
> +       (CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS << (((bar) * 8) + 6))
> +#define LM_RC_BAR_CFG_APERTURE(bar, aperture)          \
> +                                       (((aperture) - 2) << ((bar) * 8))
>
>  /*
>   * Endpoint Function Registers (PCI configuration space for endpoint functions)
> @@ -176,11 +190,19 @@
>  #define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
>
>  enum cdns_pcie_rp_bar {
> +       RP_BAR_UNDEFINED = -1,
>         RP_BAR0,
>         RP_BAR1,
>         RP_NO_BAR
>  };
>
> +#define CDNS_PCIE_RP_MAX_IB    0x3
> +
> +struct cdns_pcie_rp_ib_bar {
> +       u64 size;
> +       bool free;
> +};
> +
>  /* Endpoint Function BAR Inbound PCIe to AXI Address Translation Register */
>  #define CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
>         (CDNS_PCIE_AT_BASE + 0x0840 + (fn) * 0x0040 + (bar) * 0x0008)
> @@ -266,19 +288,19 @@ struct cdns_pcie {
>   * @bus_range: first/last buses behind the PCIe host controller
>   * @cfg_base: IO mapped window to access the PCI configuration space of a
>   *            single function at a time
> - * @no_bar_nbits: Number of bits to keep for inbound (PCIe -> CPU) address
> - *                translation (nbits sets into the "no BAR match" register)
>   * @vendor_id: PCI vendor ID
>   * @device_id: PCI device ID
> + * @avail_ib_bar: Satus of RP_BAR0, RP_BAR1 and        RP_NO_BAR if it's free or

typo

> + *                available
>   */
>  struct cdns_pcie_rc {
>         struct cdns_pcie        pcie;
>         struct resource         *cfg_res;
>         struct resource         *bus_range;
>         void __iomem            *cfg_base;
> -       u32                     no_bar_nbits;
>         u32                     vendor_id;
>         u32                     device_id;
> +       bool                    avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
>  };
>
>  /**
> --
> 2.17.1
>
