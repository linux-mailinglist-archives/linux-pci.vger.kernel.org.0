Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421B822EA64
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 12:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgG0Ku6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 06:50:58 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2531 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbgG0Ku5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 06:50:57 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id C5BEAD530574697C489D;
        Mon, 27 Jul 2020 11:50:55 +0100 (IST)
Received: from localhost (10.52.121.176) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 27 Jul
 2020 11:50:55 +0100
Date:   Mon, 27 Jul 2020 11:49:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>
CC:     <bhelgaas@google.com>, <rjw@rjwysocki.net>, <ashok.raj@kernel.org>,
        <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [RFC PATCH 3/9] PCI/portdrv: Add pcie_walk_rcec() to walk
 RCiEPs associated with RCEC
Message-ID: <20200727114932.00002c33@Huawei.com>
In-Reply-To: <20200724172223.145608-4-sean.v.kelley@intel.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
        <20200724172223.145608-4-sean.v.kelley@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.176]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 24 Jul 2020 10:22:17 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> When an RCEC device signals error(s) to a CPU core, the CPU core
> needs to walk all the RCiEPs associated with that RCEC to check
> errors. So add the function pcie_walk_rcec() to walk all RCiEPs
> associated with the RCEC device.
> 
> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>

A few trivial points inline. With those tidied up.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/pcie/portdrv.h      |  2 +
>  drivers/pci/pcie/portdrv_core.c | 82 +++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index af7cf237432a..c11d5ecbad76 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -116,6 +116,8 @@ void pcie_port_service_unregister(struct pcie_port_service_driver *new);
>  
>  extern struct bus_type pcie_port_bus_type;
>  int pcie_port_device_register(struct pci_dev *dev);
> +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
> +		    void *userdata);
>  #ifdef CONFIG_PM
>  int pcie_port_device_suspend(struct device *dev);
>  int pcie_port_device_resume_noirq(struct device *dev);
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 50a9522ab07d..bdcbb34764c2 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -14,6 +14,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/string.h>
>  #include <linux/slab.h>
> +#include <linux/bitops.h>
>  #include <linux/aer.h>
>  
>  #include "../pci.h"
> @@ -365,6 +366,87 @@ int pcie_port_device_register(struct pci_dev *dev)
>  	return status;
>  }
>  
> +static int pcie_walk_rciep_devfn(struct pci_bus *pbus, int (*cb)(struct pci_dev *, void *),
> +				 void *userdata, unsigned long bitmap)
> +{
> +	unsigned int dev, fn;
> +	struct pci_dev *pdev;
> +	int retval;
> +
> +	for_each_set_bit(dev, &bitmap, 32) {
> +		for (fn = 0; fn < 8; fn++) {
> +			pdev = pci_get_slot(pbus, PCI_DEVFN(dev, fn));
> +
> +			if (!pdev || pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
> +				continue;
> +
> +			retval = cb(pdev, userdata);
> +			if (retval)
> +				return retval;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/** pcie_walk_rcec - Walk RCiEP devices associating with RCEC and call callback.

/**
 * pcie...

> + *  @rcec     RCEC whose RCiEP devices should be walked.
> + *  @cb       Callback to be called for each RCiEP device found.
> + *  @userdata Arbitrary pointer to be passed to callback.
> + *
> + *  Walk the given RCEC. Call the provided callback on each RCiEP device found.
> + *
> + *  We check the return of @cb each time. If it returns anything
> + *  other than 0, we break out.
> + *
> + */
> +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
> +		    void *userdata)
> +{
> +	u32 pos, bitmap, hdr, busn;
> +	u8 ver, nextbusn, lastbusn;
> +	struct pci_bus *pbus;
> +	unsigned int bnr;
> +
> +	pos = pci_find_ext_capability(rcec, PCI_EXT_CAP_ID_RCEC);
> +	if (!pos)
> +		return;
> +
> +	pbus = pci_find_bus(pci_domain_nr(rcec->bus), rcec->bus->number);
> +	if (!pbus)
> +		return;
> +
> +	pci_read_config_dword(rcec, pos + PCI_RCEC_RCIEP_BITMAP, &bitmap);
> +
> +	/* Find RCiEP devices on the same bus as the RCEC */
> +	if (pcie_walk_rciep_devfn(pbus, cb, userdata, (unsigned long)bitmap))
> +		return;
> +
> +	/* Check whether RCEC BUSN register is present */
> +	pci_read_config_dword(rcec, pos, &hdr);
> +	ver = PCI_EXT_CAP_VER(hdr);
> +	if (ver < PCI_RCEC_BUSN_REG_VER)
> +		return;
> +
> +	pci_read_config_dword(rcec, pos + PCI_RCEC_BUSN, &busn);
> +	nextbusn = PCI_RCEC_BUSN_NEXT(busn);
> +	lastbusn = PCI_RCEC_BUSN_LAST(busn);
> +
> +	/* All RCiEP devices are on the same bus as the RCEC */
> +	if (nextbusn == 0xff && lastbusn == 0x00)
> +		return;
> +
> +	for (bnr = nextbusn; bnr < (lastbusn + 1); bnr++) {

Why not bnr <= lastbusn?  Seems more intuitive way of making it clear the
range is inclusive.


> +		pbus = pci_find_bus(pci_domain_nr(rcec->bus), bnr);
> +		if (!pbus)
> +			continue;
> +
> +		/* Find RCiEP devices on the given bus */
> +		if (pcie_walk_rciep_devfn(pbus, cb, userdata, 0xffffffff))
> +			return;
> +	}
> +}
> +
>  #ifdef CONFIG_PM
>  typedef int (*pcie_pm_callback_t)(struct pcie_device *);
>  


