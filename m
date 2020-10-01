Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0538327FC27
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 11:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgJAJDz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 05:03:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2935 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725921AbgJAJDz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Oct 2020 05:03:55 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 62C62FBD81C4CC8D4B19;
        Thu,  1 Oct 2020 10:03:53 +0100 (IST)
Received: from localhost (10.52.127.250) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 1 Oct 2020
 10:03:52 +0100
Date:   Thu, 1 Oct 2020 10:02:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <seanvk.dev@oregontracks.org>
CC:     <bhelgaas@google.com>, <rafael.j.wysocki@intel.com>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@intel.com>, <qiuxu.zhuo@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: Re: [PATCH v7 03/13] PCI/RCEC: Cache RCEC capabilities in
 pci_init_capabilities()
Message-ID: <20201001090210.00004ed6@Huawei.com>
In-Reply-To: <20200930215820.1113353-4-seanvk.dev@oregontracks.org>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
        <20200930215820.1113353-4-seanvk.dev@oregontracks.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.250]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 30 Sep 2020 14:58:10 -0700
Sean V Kelley <seanvk.dev@oregontracks.org> wrote:

> From: Sean V Kelley <sean.v.kelley@intel.com>
> 
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/pci.h         | 17 +++++++++++
>  drivers/pci/pcie/Makefile |  2 +-
>  drivers/pci/pcie/rcec.c   | 59 +++++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c       |  2 ++
>  include/linux/pci.h       |  4 +++
>  5 files changed, 83 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/pcie/rcec.c
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fa12f7cbc1a0..88e27a98def5 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -449,6 +449,15 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>  #endif	/* CONFIG_PCIEAER */
>  
> +#ifdef CONFIG_PCIEPORTBUS
> +/* Cached RCEC Endpoint Association */
> +struct rcec_ea {
> +	u8		nextbusn;
> +	u8		lastbusn;
> +	u32		bitmap;
> +};
> +#endif
> +
>  #ifdef CONFIG_PCIE_DPC
>  void pci_save_dpc_state(struct pci_dev *dev);
>  void pci_restore_dpc_state(struct pci_dev *dev);
> @@ -461,6 +470,14 @@ static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
>  static inline void pci_dpc_init(struct pci_dev *pdev) {}
>  #endif
>  
> +#ifdef CONFIG_PCIEPORTBUS
> +int pci_rcec_init(struct pci_dev *dev);
> +void pci_rcec_exit(struct pci_dev *dev);
> +#else
> +static inline int pci_rcec_init(struct pci_dev *dev) {return 0;}
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
> index 000000000000..da02b0af442d
> --- /dev/null
> +++ b/drivers/pci/pcie/rcec.c
> @@ -0,0 +1,59 @@
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
> +#include <linux/pci.h>
> +#include <linux/pci_regs.h>
> +
> +#include "../pci.h"
> +
> +int pci_rcec_init(struct pci_dev *dev)
> +{
> +	struct rcec_ea *rcec_ea;
> +	u32 rcec, hdr, busn;
> +	u8 ver;
> +
> +	/* Only for Root Complex Event Collectors */
> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)
> +		return 0;
> +
> +	rcec = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_RCEC);
> +	if (!rcec)
> +		return 0;
> +
> +	rcec_ea = kzalloc(sizeof(*rcec_ea), GFP_KERNEL);
> +	if (!rcec_ea)
> +		return -ENOMEM;
> +	dev->rcec_ea = rcec_ea;
> +
> +	pci_read_config_dword(dev, rcec + PCI_RCEC_RCIEP_BITMAP, &rcec_ea->bitmap);
> +
> +	/* Check whether RCEC BUSN register is present */
> +	pci_read_config_dword(dev, rcec, &hdr);
> +	ver = PCI_EXT_CAP_VER(hdr);
> +	if (ver < PCI_RCEC_BUSN_REG_VER) {
> +		/* Avoid later ver check by setting nextbusn */
> +		rcec_ea->nextbusn = 0xff;
> +		return 0;
> +	}
> +
> +	pci_read_config_dword(dev, rcec + PCI_RCEC_BUSN, &busn);
> +	rcec_ea->nextbusn = PCI_RCEC_BUSN_NEXT(busn);
> +	rcec_ea->lastbusn = PCI_RCEC_BUSN_LAST(busn);
> +
> +	return 0;
> +}
> +
> +void pci_rcec_exit(struct pci_dev *dev)
> +{
> +	kfree(dev->rcec_ea);
> +	dev->rcec_ea = NULL;
> +}
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 03d37128a24f..25f01f841f2d 100644
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
> @@ -2400,6 +2401,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_ptm_init(dev);		/* Precision Time Measurement */
>  	pci_aer_init(dev);		/* Advanced Error Reporting */
>  	pci_dpc_init(dev);		/* Downstream Port Containment */
> +	pci_rcec_init(dev);		/* Root Complex Event Collector */
>  
>  	pcie_report_downtraining(dev);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 835530605c0d..2290439e8bc0 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -304,6 +304,7 @@ struct pcie_link_state;
>  struct pci_vpd;
>  struct pci_sriov;
>  struct pci_p2pdma;
> +struct rcec_ea;
>  
>  /* The pci_dev structure describes PCI devices */
>  struct pci_dev {
> @@ -326,6 +327,9 @@ struct pci_dev {
>  #ifdef CONFIG_PCIEAER
>  	u16		aer_cap;	/* AER capability offset */
>  	struct aer_stats *aer_stats;	/* AER stats for this device */
> +#endif
> +#ifdef CONFIG_PCIEPORTBUS
> +	struct rcec_ea	*rcec_ea;	/* RCEC cached endpoint association */
>  #endif
>  	u8		pcie_cap;	/* PCIe capability offset */
>  	u8		msi_cap;	/* MSI capability offset */


