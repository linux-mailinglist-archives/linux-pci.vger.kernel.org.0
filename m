Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AFA271FBF
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 12:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgIUKKx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 06:10:53 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2898 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbgIUKKw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 06:10:52 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 78D01D3B24CC3F853F26;
        Mon, 21 Sep 2020 11:10:49 +0100 (IST)
Received: from localhost (10.52.121.13) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 21 Sep
 2020 11:10:49 +0100
Date:   Mon, 21 Sep 2020 11:09:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>
CC:     <bhelgaas@google.com>, <rafael.j.wysocki@intel.com>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@intel.com>, <qiuxu.zhuo@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 03/10] PCI/RCEC: Cache RCEC capabilities in
 pci_init_capabilities()
Message-ID: <20200921110910.0000154b@Huawei.com>
In-Reply-To: <20200918204603.62100-4-sean.v.kelley@intel.com>
References: <20200918204603.62100-1-sean.v.kelley@intel.com>
        <20200918204603.62100-4-sean.v.kelley@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.13]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 18 Sep 2020 13:45:56 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

> Extend support for Root Complex Event Collectors by decoding and
> caching the RCEC Endpoint Association Extended Capabilities when
> enumerating. Use that cached information for later error source
> reporting. See PCI Express Base Specification, version 5.0-1,
> section 7.9.10.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>

Hi Sean,

A few comments inline.

Thanks,

Jonathan

> ---
>  drivers/pci/pci.h         | 18 ++++++++++++++
>  drivers/pci/pcie/Makefile |  2 +-
>  drivers/pci/pcie/rcec.c   | 52 +++++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c       |  3 ++-
>  include/linux/pci.h       |  4 +++
>  5 files changed, 77 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pci/pcie/rcec.c
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fa12f7cbc1a0..83670a6425d8 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -449,6 +449,16 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>  #endif	/* CONFIG_PCIEAER */
>  
> +#ifdef CONFIG_PCIEPORTBUS
> +/* Cached RCEC Associated Endpoint Extended Capabilities */
> +struct rcec_ext {
> +	u8		ver;
> +	u8		nextbusn;
> +	u8		lastbusn;
> +	u32		bitmap;
> +};
> +#endif
> +
>  #ifdef CONFIG_PCIE_DPC
>  void pci_save_dpc_state(struct pci_dev *dev);
>  void pci_restore_dpc_state(struct pci_dev *dev);
> @@ -461,6 +471,14 @@ static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
>  static inline void pci_dpc_init(struct pci_dev *pdev) {}
>  #endif
>  
> +#ifdef CONFIG_PCIEPORTBUS
> +void pci_rcec_init(struct pci_dev *dev);
> +void pci_rcec_exit(struct pci_dev *dev);
> +#else
> +static inline void pci_rcec_init(struct pci_dev *dev) {}
> +static inline void pci_rcec_exit(struct pci_dev *dev) {}
> +#endif
> +
>  #ifdef CONFIG_PCI_ATS
>  /* Address Translation Service */
>  void pci_ats_init(struct pci_dev *dev);
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index 68da9280ff11..d9697892fa3e 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -2,7 +2,7 @@
>  #
>  # Makefile for PCI Express features and port driver
>  
> -pcieportdrv-y			:= portdrv_core.o portdrv_pci.o err.o
> +pcieportdrv-y			:= portdrv_core.o portdrv_pci.o err.o rcec.o
>  
>  obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
>  
> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> new file mode 100644
> index 000000000000..519ae086ff41
> --- /dev/null
> +++ b/drivers/pci/pcie/rcec.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Root Complex Event Collector Support
> + *
> + * Authors:
> + *  Sean V Kelley <sean.v.kelley@intel.com>
> + *  Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> + *
> + * Copyright (C) 2020 Intel Corp.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>

I guess it might come in during later patches, but I can't see any
use of errno.h in here.  If it does, good to introduce the header
in the patch where it becomes relevant.

> +#include <linux/bitops.h>
No obvious use of bitops.h either.

> +#include <linux/pci.h>
> +#include <linux/pci_regs.h>
> +
> +#include "../pci.h"
> +
> +void pci_rcec_init(struct pci_dev *dev)
> +{
> +	u32 rcec, hdr, busn;
> +
> +	/* Only for Root Complex Event Collectors */
> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)
> +		return;
> +
> +	dev->rcec_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_RCEC);
> +	if (!dev->rcec_cap)
> +		return;
> +
> +	dev->rcec_ext = kzalloc(sizeof(*dev->rcec_ext), GFP_KERNEL);
> +
> +	rcec = dev->rcec_cap;
> +	pci_read_config_dword(dev, rcec + PCI_RCEC_RCIEP_BITMAP, &dev->rcec_ext->bitmap);

Given number of uses of dev->rcec_ext perhaps worth a local variable for
readability?

> +
> +	/* Check whether RCEC BUSN register is present */
> +	pci_read_config_dword(dev, rcec, &hdr);
> +	dev->rcec_ext->ver = PCI_EXT_CAP_VER(hdr);
> +	if (dev->rcec_ext->ver < PCI_RCEC_BUSN_REG_VER)
> +		return;

As there are values for nextbusn and lastbusn defined to mean
that there are no additional bus numbers, could we just fill them
in with dummy values for the case of the capability version being
too old? I think it ends up representing the same thing as them not
being there at all?

nextbusn = 0xFF
lastbusn = 0 (set by kzalloc anyway).

> +
> +	pci_read_config_dword(dev, rcec + PCI_RCEC_BUSN, &busn);
> +	dev->rcec_ext->nextbusn = PCI_RCEC_BUSN_NEXT(busn);
> +	dev->rcec_ext->lastbusn = PCI_RCEC_BUSN_LAST(busn);
> +}
> +
> +void pci_rcec_exit(struct pci_dev *dev)
> +{
> +	kfree(dev->rcec_ext);
> +	dev->rcec_ext = NULL;
> +}
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 03d37128a24f..16bc651fecb7 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2201,6 +2201,7 @@ static void pci_configure_device(struct pci_dev *dev)
>  static void pci_release_capabilities(struct pci_dev *dev)
>  {
>  	pci_aer_exit(dev);
> +	pci_rcec_exit(dev);
>  	pci_vpd_release(dev);
>  	pci_iov_release(dev);
>  	pci_free_cap_save_buffers(dev);
> @@ -2400,7 +2401,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_ptm_init(dev);		/* Precision Time Measurement */
>  	pci_aer_init(dev);		/* Advanced Error Reporting */
>  	pci_dpc_init(dev);		/* Downstream Port Containment */
> -
> +	pci_rcec_init(dev);		/* Root Complex Event Collector */

Nice to avoid changing the layout and leave a blank line here.
Slightly reduces noise in the diff as well!

>  	pcie_report_downtraining(dev);
>  
>  	if (pci_probe_reset_function(dev) == 0)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 835530605c0d..5c5c4eb642b6 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -326,6 +326,10 @@ struct pci_dev {
>  #ifdef CONFIG_PCIEAER
>  	u16		aer_cap;	/* AER capability offset */
>  	struct aer_stats *aer_stats;	/* AER stats for this device */
> +#endif
> +#ifdef CONFIG_PCIEPORTBUS
> +	u16		rcec_cap;	/* RCEC capability offset */
> +	struct rcec_ext *rcec_ext;	/* RCEC cached assoc. endpoint extended capabilities */
>  #endif
>  	u8		pcie_cap;	/* PCIe capability offset */
>  	u8		msi_cap;	/* MSI capability offset */


