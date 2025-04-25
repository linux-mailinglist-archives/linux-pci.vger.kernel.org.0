Return-Path: <linux-pci+bounces-26780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B81A9CEF5
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 18:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45911C02B44
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 16:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DBC1D88AC;
	Fri, 25 Apr 2025 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="piAoeaTg"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B742919CC02;
	Fri, 25 Apr 2025 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599756; cv=none; b=clpQVyQrRKe5dzLsrMBRsrlI/vWOE4oAJyN3RpDyTl/t8DSOHMtLT7m4j34QVxnKUtZzzCUt8uC7ev8cngvt4gfEXEqXN9sWHpcfeVy6P5hsRPo3gq3VWBitAYOBtzpOWCQ46MIgaW617rcNdCoYehyH+RZIoEMNfLfkQIpMuQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599756; c=relaxed/simple;
	bh=wQE9WdJzXZBOo/GroJnHU/0E12e9y0x2yxl6f7fVlvQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ctg53EM+LmxuFEqRECK/oeRjvKtkF3cQRBfSaErbh0z8H2zGf0yYMJJG+a/1ep+UbSCawaYPWup6iMQlxRSURI4WkTl04bXA2kAQfkoaBqZZj6vLjSTPQpXhK6VTXg5NBMdDrzl+kMzD13DsphYNcNpVgcI2jZ9r7LUjiKD1d1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=piAoeaTg; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53PGn0I22208205
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 11:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745599740;
	bh=CcJG284w2m3gCfLTb2MZORhpn/XGXidDI0i7Eg4Ksyg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=piAoeaTgI7HOnONAxBmoi5OVBpkp/Oiavxt1KG6XljgCojsxHxBygpCgvqpxu7tN2
	 Eq2IiPunm6t4JwXoxgc/0kYDYhKdVh1ao/vwXW1NX6XhwzRTZSObgoDickFAksvNjp
	 0FxAIYzxnl9kZa3uiiMmglzbg45qGhqyv8FvtiSI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53PGn0bY047956
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Apr 2025 11:49:00 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 11:48:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 11:48:59 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53PGmw2G069879;
	Fri, 25 Apr 2025 11:48:59 -0500
Date: Fri, 25 Apr 2025 22:18:58 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <huaqian.li@siemens.com>
CC: <helgaas@kernel.org>, <baocheng.su@siemens.com>, <bhelgaas@google.com>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <diogo.ivo@siemens.com>, <jan.kiszka@siemens.com>, <kristo@kernel.org>,
        <krzk+dt@kernel.org>, <kw@linux.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <lpieralisi@kernel.org>, <nm@ti.com>,
        <robh@kernel.org>, <s-vadapalli@ti.com>, <ssantosh@kernel.org>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v8 4/7] PCI: keystone: Add support for PVU-based DMA
 isolation on AM654
Message-ID: <7c8c29ee-2600-4eea-866f-8fe2d533418e@ti.com>
References: <aa3c8d033480801250b3fb0be29adda4a2c31f9e.camel@siemens.com>
 <20250422061406.112539-1-huaqian.li@siemens.com>
 <20250422061406.112539-5-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250422061406.112539-5-huaqian.li@siemens.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Apr 22, 2025 at 02:14:03PM +0800, huaqian.li@siemens.com wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The AM654 lacks an IOMMU, thus does not support isolating DMA requests
> from untrusted PCI devices to selected memory regions this way. Use
> static PVU-based protection instead. The PVU, when enabled, will only
> accept DMA requests that address previously configured regions.
> 
> Use the availability of a restricted-dma-pool memory region as trigger
> and register it as valid DMA target with the PVU. In addition, enable
> the mapping of requester IDs to VirtIDs in the PCI RC. Use only a single
> VirtID so far, catching all devices. This may be extended later on.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 106 ++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 76a37368ae4f..ea2d8768e333 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -19,6 +19,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/msi.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_pci.h>
>  #include <linux/phy/phy.h>
> @@ -26,6 +27,7 @@
>  #include <linux/regmap.h>
>  #include <linux/resource.h>
>  #include <linux/signal.h>
> +#include <linux/ti-pvu.h>
>  
>  #include "../../pci.h"
>  #include "pcie-designware.h"
> @@ -111,6 +113,16 @@
>  
>  #define PCI_DEVICE_ID_TI_AM654X		0xb00c
>  
> +#define KS_PCI_VIRTID			0
> +
> +#define PCIE_VMAP_xP_CTRL		0x0
> +#define PCIE_VMAP_xP_REQID		0x4
> +#define PCIE_VMAP_xP_VIRTID		0x8
> +
> +#define PCIE_VMAP_xP_CTRL_EN		BIT(0)
> +
> +#define PCIE_VMAP_xP_VIRTID_VID_MASK	0xfff
> +
>  struct ks_pcie_of_data {
>  	enum dw_pcie_device_mode mode;
>  	const struct dw_pcie_host_ops *host_ops;
> @@ -1137,6 +1149,94 @@ static const struct of_device_id ks_pcie_of_match[] = {
>  	{ },
>  };
>  
> +static int ks_init_vmap(struct platform_device *pdev, const char *vmap_name)
> +{
> +	struct resource *res;
> +	void __iomem *base;
> +	u32 val;
> +
> +	if (!IS_ENABLED(CONFIG_TI_PVU))
> +		return 0;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, vmap_name);
> +	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	writel(0, base + PCIE_VMAP_xP_REQID);
> +
> +	val = readl(base + PCIE_VMAP_xP_VIRTID);
> +	val &= ~PCIE_VMAP_xP_VIRTID_VID_MASK;
> +	val |= KS_PCI_VIRTID;

While it has been stated that we are going to start off with a single
VirtID for now and extend it later on, is there an example for how it may
be extended? The only option I see is that of associating one VirtID for
Low-Priority (LP) traffic and another for High-Priority (HP) traffic, in
which case, it might be better to define them upfront and use them like:
#define KS_PCI_LP_VIRTID	0
#define KS_PCI_HP_VIRTID	1

> +	writel(val, base + PCIE_VMAP_xP_VIRTID);
> +
> +	val = readl(base + PCIE_VMAP_xP_CTRL);
> +	val |= PCIE_VMAP_xP_CTRL_EN;
> +	writel(val, base + PCIE_VMAP_xP_CTRL);
> +
> +	return 0;
> +}
> +
> +static int ks_init_restricted_dma(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct of_phandle_iterator it;
> +	struct resource phys;
> +	int err;
> +
> +	if (!IS_ENABLED(CONFIG_TI_PVU))
> +		return 0;
> +
> +	/* Only process the first restricted DMA pool, more are not allowed */
> +	of_for_each_phandle(&it, err, dev->of_node, "memory-region",
> +			    NULL, 0) {
> +		if (of_device_is_compatible(it.node, "restricted-dma-pool"))
> +			break;
> +	}
> +	if (err)
> +		return err == -ENOENT ? 0 : err;
> +
> +	err = of_address_to_resource(it.node, 0, &phys);
> +	if (err < 0) {
> +		dev_err(dev, "failed to parse memory region %pOF: %d\n",
> +			it.node, err);
> +		return 0;
> +	}
> +
> +	/* Map all incoming requests on low and high prio port to virtID 0 */

The question I asked above applies here too. How is it planned to extend
support for multiple VirtIDs, if not on the basis of assigining one
VirtID to LP traffic and another to HP traffic? Since we have an option
of using different VirtIDs for LP and HP traffic, why not use it? Is
there going to be an issue with using VirtID 0 for LP traffic and VirtID 1
for HP traffic?

> +	err = ks_init_vmap(pdev, "vmap_lp");
> +	if (err)
> +		return err;
> +	err = ks_init_vmap(pdev, "vmap_hp");
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Enforce DMA pool usage with the help of the PVU.
> +	 * Any request outside will be dropped and raise an error at the PVU.
> +	 */
> +	return ti_pvu_create_region(KS_PCI_VIRTID, &phys);

Same as above, we are passing a single VIRTID and not an array, so it
isn't clear to me as to how it will be extended in the future.

> +}
> +
> +static void ks_release_restricted_dma(struct platform_device *pdev)
> +{
> +	struct of_phandle_iterator it;
> +	struct resource phys;
> +	int err;
> +
> +	if (!IS_ENABLED(CONFIG_TI_PVU))
> +		return;
> +
> +	of_for_each_phandle(&it, err, pdev->dev.of_node, "memory-region",
> +			    NULL, 0) {
> +		if (of_device_is_compatible(it.node, "restricted-dma-pool") &&
> +		    of_address_to_resource(it.node, 0, &phys) == 0) {
> +			ti_pvu_remove_region(KS_PCI_VIRTID, &phys);
> +			break;
> +		}
> +	}
> +}
> +
>  static int ks_pcie_probe(struct platform_device *pdev)
>  {
>  	const struct dw_pcie_host_ops *host_ops;
> @@ -1285,6 +1385,10 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto err_get_sync;
>  
> +	ret = ks_init_restricted_dma(pdev);
> +	if (ret < 0)
> +		goto err_get_sync;
> +

Shouldn't the above be moved into the case for "DW_PCIE_RC_TYPE" below? Or
is this valid even when the SoC is configured to act as an Endpoint?

>  	switch (mode) {
>  	case DW_PCIE_RC_TYPE:
>  		if (!IS_ENABLED(CONFIG_PCI_KEYSTONE_HOST)) {
> @@ -1366,6 +1470,8 @@ static void ks_pcie_remove(struct platform_device *pdev)
>  	int num_lanes = ks_pcie->num_lanes;
>  	struct device *dev = &pdev->dev;
>  
> +	ks_release_restricted_dma(pdev);
> +
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
>  	ks_pcie_disable_phy(ks_pcie);

Regards,
Siddharth.

