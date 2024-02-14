Return-Path: <linux-pci+bounces-3459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 577B0855055
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 18:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5AAE1F22201
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 17:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C2686625;
	Wed, 14 Feb 2024 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3PYMsdV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26957C0BF;
	Wed, 14 Feb 2024 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931733; cv=none; b=V9W83z5EFU1tx0HHxe1uGsW0Eq6Lk/0r4Pp0LgXHgrQAlYFU2O2R2ItGgjHmJzrWeIfiWO5fCVYRXdWBJsnr07lKDIzbgu57dmVolUhTNdEKIudjDiSQLzasrcO/LRtybyuU5ujUDrwl8o5skP7anAy5k8Quw0N7C5aCLSYoCcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931733; c=relaxed/simple;
	bh=z/Z3tUAhkNPM1isKp5PxN2lNkWklpFN1TdodOMmS8Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XP4rYTXdGhVtsIwNGVsa6jVXhnY9VM21gtsIXTOt/NEbS+TYsM8I2CKjqYWcXztBmtFF6zL7dW3imLsn4b2J9EEtDJKUbDZA/jO0tqgOCUEFDzV1eaRVu7zBeh80CqLe7iRkgN/RoqC9np+NhyrX9JfK5PLVwwUehlLl78zGKkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3PYMsdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C8FC433F1;
	Wed, 14 Feb 2024 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707931733;
	bh=z/Z3tUAhkNPM1isKp5PxN2lNkWklpFN1TdodOMmS8Fo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Z3PYMsdVlDSq8wn9D611pcLUcO29LG0YdLKdDPDkPLb0wGbxZ8Iql6JKonfStLOZm
	 mysp/+4SEys+bCmXCBrujjpUbzu3NvPg+G8H282PtGTamEIsr9oqx8pVkFqWU2XANS
	 Tm2uP7GybEG09qzknssirkrAT6oJgEBAOaPtPK7HCiUOC6Si23j1BQnw5qhvQM4ZGp
	 B3vsLjF+UfhIDECpBeZCdpH4oXGbaDOdqU08bodZwaGMKjjl+s9L6xcgA52mbl5Wap
	 vhyzXFHHS4rFXoCzFMaqYq7gYYEEvUif/xAhJXnDs25IEhomFqKgRB52dPabeF9ALv
	 oE4ZY/2Q2lvKg==
Date: Wed, 14 Feb 2024 11:28:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	richardcochran@gmail.com, horms@kernel.org,
	vinicius.gomes@intel.com, vadim.fedorenko@linux.dev,
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, lcherian@marvell.com, hkelam@marvell.com,
	sbhatta@marvell.com, Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net-next PATCH v2] octeontx2: Add PTP clock driver for Octeon
 PTM clock.
Message-ID: <20240214172851.GA1258497@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214130853.1321836-1-saikrishnag@marvell.com>

On Wed, Feb 14, 2024 at 06:38:53PM +0530, Sai Krishna wrote:
> The PCIe PTM(Precision time measurement) protocol provides precise
> coordination of events across multiple components like PCIe host
> clock, PCIe EP PHC local clocks of PCIe devices. This patch adds
> support for ptp clock based PTM clock. We can use this PTP device
> to sync the PTM time with CLOCK_REALTIME or other PTP PHC
> devices using phc2sys.

s/PTM(/PTM (/   # space before open paren is conventional as in file comment
s/ptp/PTP/      # not sure if you intend "ptp" to be different from "PTP"?

Perhaps expand "PTP"?  I guess it must be "Precision Time Protocol",
which obviously would be well-known to all clock people since it's in
"drivers/ptp/" :)

> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>

Strictly speaking, I think the sender's Signed-off-by should be last
here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.6#n396

> ---
> v2:
>     - Addressed review comments given by Vadim Fedorenko, Vinicius, Simon Horman
> 	1. Driver build restricted to ARM64 and COMPILE_TEST+64BIT
>         2. Fixed Sparse complaints by using readq/writeq like else where
>         3. Modified error conditions, clode cleanup
>         4. Forwarding to linux-pci maintainers as suggested by Jakub 
> 
>  drivers/ptp/Kconfig          |  11 ++
>  drivers/ptp/Makefile         |   1 +
>  drivers/ptp/ptp_octeon_ptm.c | 243 +++++++++++++++++++++++++++++++++++
>  3 files changed, 255 insertions(+)
>  create mode 100644 drivers/ptp/ptp_octeon_ptm.c
> 
> diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
> index 604541dcb320..3256b12842a6 100644
> --- a/drivers/ptp/Kconfig
> +++ b/drivers/ptp/Kconfig
> @@ -224,4 +224,15 @@ config PTP_DFL_TOD
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called ptp_dfl_tod.
>  
> +config PTP_CLOCK_OCTEON
> +	tristate "OCTEON PTM PTP clock"
> +	depends on PTP_1588_CLOCK

I guess this can't even be compile-tested without PTP_1588_CLOCK?
Some subsystems supply stubs to allow compile testing even when the
subsystem is not enabled, but maybe ptp does not.

> +	depends on (64BIT && COMPILE_TEST) || ARM64

Why the 64BIT dependency?  Is it not even compile-testable without it?

> +	default n
> +	help
> +	  This driver adds support for using Octeon PTM device clock as
> +	  a PTP clock.

Another possible place to expand PTM and/or PTP.

> +	  To compile this driver as a module, choose M here: the module
> +	  will be called ptp_octeon_ptm.
>  endmenu
> diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
> index 68bf02078053..19e2ab4c7f1b 100644
> --- a/drivers/ptp/Makefile
> +++ b/drivers/ptp/Makefile
> @@ -21,3 +21,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_MOCK)	+= ptp_mock.o
>  obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
>  obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
>  obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
> +obj-$(CONFIG_PTP_CLOCK_OCTEON)		+= ptp_octeon_ptm.o
> diff --git a/drivers/ptp/ptp_octeon_ptm.c b/drivers/ptp/ptp_octeon_ptm.c
> new file mode 100644
> index 000000000000..6867c1d28f17
> --- /dev/null
> +++ b/drivers/ptp/ptp_octeon_ptm.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell PTP PHC clock driver for PCIe PTM (Precision Time Measurement) EP
> + *
> + * Copyright (c) 2024 Marvell.
> + *

Spurious blank line.

> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +
> +#include <linux/ptp_clock_kernel.h>
> +
> +#include "ptp_private.h"
> +
> +#define PEMX_PFX_CSX_PFCFGX(pem, pf, _offset)	({typeof(_offset) (offset) = (_offset); \
> +						((0x8e0000008000 | (u64)(pem) << 36 \
> +						| (pf) << 18 \
> +						| (((offset) >> 16) & 1) << 16 \
> +						| ((offset) >> 3) << 3) \
> +						+ ((((offset) >> 2) & 1) << 2)); })
> +
> +#define PEMX_CFG_WR(a)			(0x8E0000000018ull | (u64)(a) << 36)
> +#define PEMX_CFG_RD(a)			(0x8E0000000020ull | (u64)(a) << 36)
> +
> +/* Octeon CSRs   */
> +#define PEMX_CFG                        0x8e00000000d8ULL
> +#define PEMX_PTM_CTL			0x8e0000000098ULL
> +#define PEMX_PTM_CTL_CAP		BIT_ULL(10)
> +#define PEMX_PTM_LCL_TIME		0x8e00000000a0ULL /* PTM time */
> +#define PEMX_PTM_MAS_TIME		0x8e00000000a8ULL /* PTP time */
> +
> +struct oct_ptp_clock {
> +	struct ptp_clock *ptp_clock;
> +	struct ptp_clock_info caps;
> +	bool cn10k_variant;
> +};
> +
> +static struct oct_ptp_clock oct_ptp_clock;
> +static void __iomem *ptm_ctl_addr;
> +static void __iomem *ptm_lcl_addr;
> +
> +/* Config space registers   */

Spurious spaces at end of comment.

> +#define PCIEEPX_PTM_REQ_STAT		(oct_ptp_clock.cn10k_variant ? 0x3a8 : 0x474)
> +#define PCIEEPX_PTM_REQ_T1L		(oct_ptp_clock.cn10k_variant ? 0x3b4 : 0x480)
> +#define PCIEEPX_PTM_REQ_T1M		(oct_ptp_clock.cn10k_variant ? 0x3b8 : 0x484)
> +#define PCIEEPX_PTM_REQ_T4L		(oct_ptp_clock.cn10k_variant ? 0x3c4 : 0x490)
> +#define PCIEEPX_PTM_REQ_T4M		(oct_ptp_clock.cn10k_variant ? 0x3c8 : 0x494)
> +
> +#define PCI_VENDOR_ID_CAVIUM			0x177d
> +#define PCI_DEVID_OCTEONTX2_PTP			0xA00C
> +#define PCI_SUBSYS_DEVID_95XX			0xB300
> +#define PCI_SUBSYS_DEVID_95XXN			0xB400
> +#define PCI_SUBSYS_DEVID_95XXMM			0xB500
> +#define PCI_SUBSYS_DEVID_96XX			0xB200
> +#define PCI_SUBSYS_DEVID_98XX			0xB100
> +#define PCI_SUBSYS_DEVID_CN10K_A		0xB900
> +#define PCI_SUBSYS_DEVID_CN10K_B		0xBD00
> +#define PCI_SUBSYS_DEVID_CNF10K_A		0xBA00
> +#define PCI_SUBSYS_DEVID_CNF10K_B		0xBC00

Random mixture of upper-case and lower-case hex above.  Also random
usage of "ull" vs "ULL".

> +static bool is_otx2_support_ptm(struct pci_dev *pdev)
> +{
> +	return (pdev->subsystem_device == PCI_SUBSYS_DEVID_96XX ||
> +		pdev->subsystem_device == PCI_SUBSYS_DEVID_95XX ||
> +		pdev->subsystem_device == PCI_SUBSYS_DEVID_95XXN ||
> +		pdev->subsystem_device == PCI_SUBSYS_DEVID_98XX ||
> +		pdev->subsystem_device == PCI_SUBSYS_DEVID_95XXMM);
> +}
> +
> +static bool is_cn10k_support_ptm(struct pci_dev *pdev)
> +{
> +	return (pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_A ||
> +		pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_A ||
> +		pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_B ||
> +		pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_B);
> +}
> +
> +static int ptp_oct_ptm_adjtime(struct ptp_clock_info *ptp, s64 delta)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int ptp_oct_ptm_settime(struct ptp_clock_info *ptp,
> +			       const struct timespec64 *ts)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static u32 read_pcie_config32(int ep_pem, int cfg_addr)
> +{
> +	void __iomem *addr;
> +	u64 val;
> +
> +	if (oct_ptp_clock.cn10k_variant) {
> +		addr = ioremap(PEMX_PFX_CSX_PFCFGX(ep_pem, 0, cfg_addr), 8);

These ioremap()s look like things that should be done at probe-time
and retained for the life of the module since (I assume) this will be
called many times.

> +		if (!addr) {
> +			pr_err("PTM_EP: Failed to ioremap Octeon CSR space\n");
> +			return -1U;
> +		}
> +		val = readl(addr);
> +		iounmap(addr);
> +	} else {
> +		addr = ioremap(PEMX_CFG_RD(ep_pem), 8);
> +		if (!addr) {
> +			pr_err("PTM_EP: Failed to ioremap Octeon CSR space\n");
> +			return -1U;
> +		}
> +		val = ((1 << 15) | (cfg_addr & 0xfff));
> +		writeq(val, addr);
> +		val = readq(addr) >> 32;
> +		iounmap(addr);
> +	}
> +	return (val & 0xffffffff);
> +}
> +
> +static uint64_t octeon_csr_read(u64 csr_addr)
> +{
> +	void __iomem *addr;
> +	u64 val;
> +
> +	addr = ioremap(csr_addr, 8);
> +	if (!addr) {
> +		pr_err("PTM_EP: Failed to ioremap CSR space\n");
> +		return -1UL;
> +	}
> +	val = readq(addr);
> +	iounmap(addr);
> +	return val;
> +}
> +
> +static int ptp_oct_ptm_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
> +{
> +	u64 ptp_time, val64;
> +	u32 val32;
> +
> +	/* Check for valid PTM context */
> +	val32 = read_pcie_config32(0, PCIEEPX_PTM_REQ_STAT);
> +	if (!(val32 & 0x1)) {
> +		pr_err("PTM_EP: ERROR: PTM context not valid: 0x%x\n", val32);
> +
> +		ts->tv_sec = 0;
> +		ts->tv_nsec = 0;
> +
> +		return -EINVAL;
> +	}
> +
> +	/* Trigger PTM/PTP capture */
> +	val64 = readq(ptm_ctl_addr);
> +	val64 |= PEMX_PTM_CTL_CAP;
> +	writeq(val64, ptm_ctl_addr);
> +	/* Read PTM/PTP clocks  */
> +	ptp_time = readq(ptm_lcl_addr);
> +
> +	*ts = ns_to_timespec64(ptp_time);
> +
> +	return 0;
> +}
> +
> +static int ptp_oct_ptm_enable(struct ptp_clock_info *ptp,
> +			      struct ptp_clock_request *rq, int on)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct ptp_clock_info ptp_oct_caps = {
> +	.owner		= THIS_MODULE,
> +	.name		= "OCTEON PTM PHC",
> +	.max_adj	= 0,
> +	.n_ext_ts	= 0,
> +	.n_pins		= 0,
> +	.pps		= 0,

Initialization to zero is unnecessary, but maybe it's the local
drivers/ptp/ style.

> +	.adjtime	= ptp_oct_ptm_adjtime,
> +	.gettime64	= ptp_oct_ptm_gettime,
> +	.settime64	= ptp_oct_ptm_settime,
> +	.enable		= ptp_oct_ptm_enable,
> +};
> +
> +static void __exit ptp_oct_ptm_exit(void)
> +{
> +	iounmap(ptm_ctl_addr);
> +	iounmap(ptm_lcl_addr);
> +	ptp_clock_unregister(oct_ptp_clock.ptp_clock);
> +}
> +
> +static int __init ptp_oct_ptm_init(void)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
> +			      PCI_DEVID_OCTEONTX2_PTP, pdev);

pci_get_device() is a sub-optimal method for a driver to claim a
device.  pci_register_driver() is the preferred method.  If you can't
use that, a comment here explaining why not would be helpful.

> +	if (!pdev)
> +		return 0;
> +
> +	if (octeon_csr_read(PEMX_CFG) & 0x1ULL) {
> +		pr_err("PEM0 is configured as RC\n");

pci_err() or dev_err() etc. when possible.  Maybe #define dev_fmt or
pr_fmt as appropriate.

> +		return 0;
> +	}
> +
> +	if (is_otx2_support_ptm(pdev)) {
> +		oct_ptp_clock.cn10k_variant = 0;
> +	} else if (is_cn10k_support_ptm(pdev)) {
> +		oct_ptp_clock.cn10k_variant = 1;
> +	} else {
> +		/* PTM_EP: unsupported processor */
> +		return 0;
> +	}
> +
> +	ptm_ctl_addr = ioremap(PEMX_PTM_CTL, 8);

Hard-coded register addresses?  That can't be right.  Shouldn't this
be discoverable either as a PCI BAR or via DT or similar firmware
interface?

> +	if (!ptm_ctl_addr) {
> +		pr_err("PTM_EP: Failed to ioremap CSR space\n");
> +		return 0;
> +	}
> +
> +	ptm_lcl_addr = ioremap(PEMX_PTM_LCL_TIME, 8);
> +	if (!ptm_lcl_addr) {
> +		pr_err("PTM_EP: Failed to ioremap CSR space\n");
> +		return 0;
> +	}
> +
> +	oct_ptp_clock.caps = ptp_oct_caps;
> +
> +	oct_ptp_clock.ptp_clock = ptp_clock_register(&oct_ptp_clock.caps, NULL);
> +	if (IS_ERR(oct_ptp_clock.ptp_clock))
> +		return PTR_ERR(oct_ptp_clock.ptp_clock);
> +
> +	pr_info("PTP device index for PTM clock:%d\n", oct_ptp_clock.ptp_clock->index);
> +	pr_info("cn10k_variant %d\n", oct_ptp_clock.cn10k_variant);

Combine into single line; otherwise there's no hint in the dmesg log
of what "cn10k_variant" is connected to (though dev_fmt/pr_fmt would
also help with this).

> +	return 0;
> +}
> +
> +module_init(ptp_oct_ptm_init);
> +module_exit(ptp_oct_ptm_exit);
> +
> +MODULE_AUTHOR("Marvell Inc.");
> +MODULE_DESCRIPTION("PTP PHC clock using PTM");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 

