Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0B356BB98
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 16:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbiGHOQd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 10:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbiGHOQc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 10:16:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED712CC85
        for <linux-pci@vger.kernel.org>; Fri,  8 Jul 2022 07:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657289791; x=1688825791;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iZLQVjFSXggQE428N4tHu/SyBhjlhiicG8E0uK2Ekhg=;
  b=QNBLIie2jLe+DDKpCt3pWTjvqABrRc7HAzhMiqDKL5Kj85fM76f/dC22
   m30Vp6xnjMW4e2/BjrwmFgz98qzHDxqU5X/bcNQ8c8/xGKyV2M5+XLdBc
   FfPf0GzC/jdc225ltUGxZ1fzbicyu8hu6J+Ef+wk2yxedQBEH6JWng9Nl
   UcwU7KrFjH70yUZ2+ti0Au2XmQ/2S8j1/x3pI0N66aCBA9nGZ+S/RDpkf
   aHz205XAx1XHzRJ0cef5b0wk7CWCEVLhH86YvlQyOSo5tZKciXD8h43jm
   l8wgM6ElwS14n/sTTRmX/ZesfPuaibnYOC9LPz2oyzBEfklGGcE9oPTl/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="284311469"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="284311469"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 07:16:30 -0700
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="651580480"
Received: from zcutrix-mobl.amr.corp.intel.com (HELO [10.209.97.87]) ([10.209.97.87])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 07:16:30 -0700
Message-ID: <ceca4535-d1c0-4d1a-b688-9bf6bc18590c@linux.intel.com>
Date:   Fri, 8 Jul 2022 07:16:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v5] PCI: Add save and restore capability for TPH config
 space
Content-Language: en-US
To:     Paul Luse <paul.e.luse@intel.com>, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, Jing Liu <jing2.liu@intel.com>
References: <20220708100516.2442-1-paul.e.luse@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220708100516.2442-1-paul.e.luse@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Paul,

On 7/8/22 3:05 AM, Paul Luse wrote:
> From: paul luse <paul.e.luse@intel.com>
> 
> The PCI subsystem does not currently save and restore the configuration
> space for the TPH (Transaction Layer Packet Processing Hints) capability,

May be Transaction Layer Packet Processing Hints (TPH) would be better?

> leading to the possibility of configuration loss in some scenarios. For
> more information please refer to PCIe r6.0 sec 6.17.
> 
> This was discovered working on the SPDK Project (Storage Performance
> Development Kit, see https://spdk.io/) where we typically unbind devices
> from their native kernel driver and bind to VFIO for use with our own
> user space drivers. The process of binding to VFIO results in the loss
> of TPH settings due to the resulting PCI reset.
> 
> Signed-off-by: Jing Liu <jing2.liu@intel.com>

Why about signed-off from Jing? Is this co-developed by Jing? If yes,
I think you should use Co-developed-by:

> Signed-off-by: paul luse <paul.e.luse@intel.com>
> ---

I think your version number is incorrect. Is this supposed to be v3?

Please include version log.

>  drivers/pci/pci.c             |  2 +
>  drivers/pci/pci.h             |  4 ++
>  drivers/pci/pcie/Makefile     |  1 +
>  drivers/pci/pcie/tph.c        | 93 +++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c           |  1 +
>  include/uapi/linux/pci_regs.h |  2 +
>  6 files changed, 103 insertions(+)
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
> index e10cdec6c56e..e6214c8e8cb7 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -514,6 +514,10 @@ static inline void pci_restore_ptm_state(struct pci_dev *dev) { }
>  static inline void pci_disable_ptm(struct pci_dev *dev) { }
>  #endif
>  
> +void pci_save_tph_state(struct pci_dev *dev);
> +void pci_restore_tph_state(struct pci_dev *dev);
> +void pci_tph_init(struct pci_dev *dev);

If you follow my following suggestion about moving tph.c contents to
pci.c, you don't need to declare above functions.
 

> +
>  unsigned long pci_cardbus_resource_alignment(struct resource *);
>  
>  static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index 5783a2f79e6a..1287ec65fb30 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for PCI Express features and port driver
>  
>  pcieportdrv-y			:= portdrv_core.o portdrv_pci.o rcec.o
> +obj-y                           += tph.o
>  
>  obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
>  
> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
> new file mode 100644
> index 000000000000..c0d2f20b7d53
> --- /dev/null
> +++ b/drivers/pci/pcie/tph.c

IMO, you don't need a separate file for this. This could be moved to
pci.c. Check for PCI_EXT_CAP_ID_LTR cap implementation.

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

Per PCIe spec r6.0, sec titled "TPH Requester Capability Register"

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

I think the above check is redundant. I believe following function
will return NULL if capability is not there.

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

pci_read_config_word(dev, tph + PCI_TPH_ST_TBL + 2*i, cap++) ?

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

Same as above

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

Same as above

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
> +	save_size = sizeof(int) + num_entries * sizeof(u16);
> +	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_TPH, save_size);
> +}

I think you can move pci_tph_init() to pci_allocate_cap_save_buffers().

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..1f5da3dbf128 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2464,6 +2464,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_aer_init(dev);		/* Advanced Error Reporting */
>  	pci_dpc_init(dev);		/* Downstream Port Containment */
>  	pci_rcec_init(dev);		/* Root Complex Event Collector */
> +	pci_tph_init(dev);              /* Transaction Layer Packet Processing Hints */
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

Follow same hex format as below? 0x08

> +#define PCI_TPH_ST_TBL          0xc     /* ST table offset */
>  #define PCI_TPH_BASE_SIZEOF	0xc	/* size with no ST table */
>  
>  /* Downstream Port Containment */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
