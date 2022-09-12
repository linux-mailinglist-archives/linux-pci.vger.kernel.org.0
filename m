Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8A55B62F2
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 23:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiILVp2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Sep 2022 17:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiILVpU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2022 17:45:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253AA40E39
        for <linux-pci@vger.kernel.org>; Mon, 12 Sep 2022 14:45:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5AEF612C8
        for <linux-pci@vger.kernel.org>; Mon, 12 Sep 2022 21:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD08C433C1;
        Mon, 12 Sep 2022 21:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663019118;
        bh=8tsLW9qESMS13t7yJx6iyrCILfdMi0ovKO+jCUYCoJw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=p22l1FBSiwCIU6zkF9AECHdn//mwws2/01Dr/L6zODEuhMM+1wjdFj7ehP5NZkrz7
         2+JUkG4XHmn0fSLYiVTI3xUshqDw4FJqRHxGQ0bGNNRXJc8rx2zu6eCRdZdMdQd34m
         wLAqZWgK1VAYPMmJX6ukcZjyf5E09aMxndgKo4U9fADTIyCJ8Jf8sEsBc2MCUGiz4y
         ccMBNIbPpWDm9GjibkUhDCoHJ6E3QlVeMo2mb+J0jD9dum+BFmMuvUdKrRY2QP76Sj
         dxv7KdSv6uo9pPcaNlSchiiQyUEVPaHj638FI9zS9JZA/5zoZ/FWoY+xgZEexOUUqG
         xgb2ocRymkbsQ==
Date:   Mon, 12 Sep 2022 16:45:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Paul Luse <paul.e.luse@intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jing Liu <jing2.liu@intel.com>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v7] PCI: Add save and restore capability for TPH config
 space
Message-ID: <20220912214516.GA538566@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712123641.2319-1-paul.e.luse@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 12, 2022 at 08:36:41AM -0400, Paul Luse wrote:
> From: paul luse <paul.e.luse@intel.com>
> 
> The PCI subsystem does not currently save and restore the configuration
> space for the Transaction Layer Processing Hints (TPH) capability,
> leading to the possibility of configuration loss in some scenarios. For
> more information please refer to PCIe r6.0 sec 6.17.

s/Transaction Layer Processing Hints/TLP Processing Hints/ here and
several places below.  This is to use the same terms as in the spec,
just to make searching easier.

> This was discovered working on the SPDK Project (Storage Performance
> Development Kit, see https://spdk.io/) where we typically unbind devices
> from their native kernel driver and bind to VFIO for use with our own
> user space drivers. The process of binding to VFIO results in the loss
> of TPH settings due to the resulting PCI reset.

I'm curious about how you're using this, since I don't think the PCI
core has any support for enabling TPH in devices or for discovering
values to use in the ST Table.

Is this completely platform-specific for discovering Steering Tag
values and device-specific for programming ST Tables and enabling TPH?
I looked at the SPDK git tree but didn't see anything about TPH there
either.

I'd like to have some kind of shared infrastructure for this.  There
is some recent work by the PCI SIG firmware group on a _DSM (I think
it showed up in PCI Firmware Spec r3.3), but as far as I know, there's
no OS implementation yet.

> Co-developed-by: Jing Liu <jing2.liu@intel.com>
> Signed-off-by: Jing Liu <jing2.liu@intel.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: paul luse <paul.e.luse@intel.com>
> ---
> Log: v1-v3: Misc review feedback before I knew to add a log
>  V4: Changed tph declaration from int to u16
>  V5: Removed TPH as a kernel option
>  V6: Updated commit message per feedback, added log
>  V7: Added kernel option back in, one minor sizeof change
> 
>  drivers/pci/pci.c             |  2 +
>  drivers/pci/pci.h             | 10 ++++
>  drivers/pci/pcie/Kconfig      |  8 +++
>  drivers/pci/pcie/Makefile     |  1 +
>  drivers/pci/pcie/tph.c        | 93 +++++++++++++++++++++++++++++++++++

I see Kuppuswamy's comment about possibly moving this to pci.c, but I
think it probably does deserve its own file because I hope we
eventually get more TPH infrastructure here.

But I would personally put this one level up in drivers/pci/,
alongside ats.c, doe.c, ecam.c, iov.c, and similar PCIe code.  We're
going to end up with more PCIe-specific stuff than PCI-specific, and
it seems like a little overkill to have both "pci" and "pcie" in the
paths.

>  drivers/pci/probe.c           |  1 +
>  include/uapi/linux/pci_regs.h |  2 +
>  7 files changed, 117 insertions(+)
>  create mode 100644 drivers/pci/pcie/tph.c
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index cfaf40a540a8..158712bf3069 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1670,6 +1670,7 @@ int pci_save_state(struct pci_dev *dev)
>  	pci_save_dpc_state(dev);
>  	pci_save_aer_state(dev);
>  	pci_save_ptm_state(dev);
> +	pci_save_tph_state(dev);
>  	return pci_save_vc_state(dev);
>  }
>  EXPORT_SYMBOL(pci_save_state);
> @@ -1782,6 +1783,7 @@ void pci_restore_state(struct pci_dev *dev)
>  	pci_restore_rebar_state(dev);
>  	pci_restore_dpc_state(dev);
>  	pci_restore_ptm_state(dev);
> +	pci_restore_tph_state(dev);
>  
>  	pci_aer_clear_status(dev);
>  	pci_restore_aer_state(dev);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index e10cdec6c56e..0c9151e150a3 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -514,6 +514,16 @@ static inline void pci_restore_ptm_state(struct pci_dev *dev) { }
>  static inline void pci_disable_ptm(struct pci_dev *dev) { }
>  #endif
>  
> +#ifdef CONFIG_PCIE_TPH
> +void pci_save_tph_state(struct pci_dev *dev);
> +void pci_restore_tph_state(struct pci_dev *dev);
> +void pci_tph_init(struct pci_dev *dev);
> +#else
> +static inline void pci_save_tph_state(struct pci_dev *dev) { }
> +static inline void pci_restore_tph_state(struct pci_dev *dev) { }
> +static inline void pci_tph_init(struct pci_dev *dev) { }
> +#endif
> +
>  unsigned long pci_cardbus_resource_alignment(struct resource *);
>  
>  static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 788ac8df3f9d..16c95b859023 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -142,3 +142,11 @@ config PCIE_EDR
>  	  the PCI Firmware Specification r3.2.  Enable this if you want to
>  	  support hybrid DPC model which uses both firmware and OS to
>  	  implement DPC.
> +
> +config PCIE_TPH
> +	bool "PCI TPH (Transaction Layer Processing Hints) capability support"

To match similar entries:

  bool "PCI Express TLP Processing Hints support"

> +	help
> +	  This enables PCI Express TPH (Transaction Layer Processing Hints) by
> +	  making sure they are saved and restored across resets. Enable this if your
> +	  hardware uses the PCI Express TPH capabilities. For more information please
> +	  refer to PCIe r6.0 sec 6.17.

Use the expanded version first, then the initialism:

  This enables PCI Express TLP Processing Hints (TPH) support ...

How would a user know if the hardware uses TPH?  I think the question
is really whether the hardware supports TPH *and* the OS (or maybe
BIOS) and device driver support and enable it.

Wrap so this fits in 80 columns like the rest of the file.

> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index 5783a2f79e6a..c91986da9337 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_PME)		+= pme.o
>  obj-$(CONFIG_PCIE_DPC)		+= dpc.o
>  obj-$(CONFIG_PCIE_PTM)		+= ptm.o
>  obj-$(CONFIG_PCIE_EDR)		+= edr.o
> +obj-$(CONFIG_PCIE_TPH)		+= tph.o
> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
> new file mode 100644
> index 000000000000..d4fd30aea69c
> --- /dev/null
> +++ b/drivers/pci/pcie/tph.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCI Express Transaction Layer Packet Processing Hints
> + * Copyright (c) 2022, Intel Corporation.
> + */
> +
> +#include "../pci.h"
> +
> +static unsigned int pci_get_tph_st_num_entries(struct pci_dev *dev, u16 tph)
> +{
> +	int num_entries = 0;
> +	u32 cap;
> +
> +	pci_read_config_dword(dev, tph + PCI_TPH_CAP, &cap);
> +	if ((cap & PCI_TPH_CAP_LOC_MASK) == PCI_TPH_LOC_CAP) {
> +		/* per PCI spec, table entries is encoded as N-1 */

  /* Per PCIe r6.0, sec 7.9.13.2, ST Table size encoded as N-1 */

> +		num_entries = ((cap & PCI_TPH_CAP_ST_MASK) >> PCI_TPH_CAP_ST_SHIFT) + 1;
> +	}
> +
> +	return num_entries;
> +}
> +
> +void pci_save_tph_state(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	int num_entries, i, offset;
> +	u16 *st_entry, tph;
> +	u32 *cap;
> +
> +	tph = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_TPH);
> +	if (!tph)
> +		return;

In pci_tph_init(), you check both pci_is_pcie() and the existence of
the TPH capability.  I think all these should have equivalent tests.
I would probably trade off a "u16 tph_cap" in struct pci_dev so we
only have to search the capability list once, e.g.,

  void pci_save_tph_state(struct pci_dev *dev)
  {
    u16 tph = dev->tph;

    if (!tph)
      return;

    ...
  }

  void pci_tph_init(struct pci_dev *dev)
  {
    tph = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_TPH);
    if (!tph)
      return;

    dev->tph = tph;
    ...
  }

> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_TPH);
> +	if (!save_state)
> +		return;
> +
> +	/* Save control register as well as all ST entries */
> +	cap = &save_state->cap.data[0];
> +	pci_read_config_dword(dev, tph + PCI_TPH_CTL, cap++);
> +	st_entry = (u16 *)cap;
> +	offset = PCI_TPH_ST_TBL;
> +	num_entries = pci_get_tph_st_num_entries(dev, tph);
> +	for (i = 0; i < num_entries; i++) {
> +		pci_read_config_word(dev, tph + offset, st_entry++);
> +		offset += sizeof(u16);
> +	}
> +}
> +
> +void pci_restore_tph_state(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	int num_entries, i, offset;
> +	u16 *st_entry, tph;
> +	u32 *cap;
> +
> +	tph = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_TPH);
> +	if (!tph)
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_TPH);
> +	if (!save_state)
> +		return;
> +
> +	/* Restore control register as well as all ST entries */
> +	cap = &save_state->cap.data[0];
> +	pci_write_config_dword(dev, tph + PCI_TPH_CTL, *cap++);
> +	st_entry = (u16 *)cap;
> +	offset = PCI_TPH_ST_TBL;
> +	num_entries = pci_get_tph_st_num_entries(dev, tph);
> +	for (i = 0; i < num_entries; i++) {
> +		pci_write_config_word(dev, tph + offset, *st_entry++);
> +		offset += sizeof(u16);
> +	}
> +}
> +
> +void pci_tph_init(struct pci_dev *dev)
> +{
> +	int num_entries;
> +	u32 save_size;
> +	u16 tph;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	tph = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_TPH);
> +	if (!tph)
> +		return;
> +
> +	num_entries = pci_get_tph_st_num_entries(dev, tph);
> +	save_size = sizeof(u32) + num_entries * sizeof(u16);
> +	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_TPH, save_size);
> +}
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..d6e289a07416 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2464,6 +2464,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_aer_init(dev);		/* Advanced Error Reporting */
>  	pci_dpc_init(dev);		/* Downstream Port Containment */
>  	pci_rcec_init(dev);		/* Root Complex Event Collector */
> +	pci_tph_init(dev);              /* Transaction Layer Processing Hints */
>  
>  	pcie_report_downtraining(dev);
>  	pci_init_reset_methods(dev);
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 108f8523fa04..2d8b719adbab 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1020,6 +1020,8 @@
>  #define   PCI_TPH_LOC_MSIX	0x400	/* in MSI-X */
>  #define PCI_TPH_CAP_ST_MASK	0x07FF0000	/* ST table mask */
>  #define PCI_TPH_CAP_ST_SHIFT	16	/* ST table shift */
> +#define PCI_TPH_CTL             8       /* control offset */
> +#define PCI_TPH_ST_TBL          0xc     /* ST table offset */
>  #define PCI_TPH_BASE_SIZEOF	0xc	/* size with no ST table */
>  
>  /* Downstream Port Containment */
> -- 
> 2.34.3
> 
