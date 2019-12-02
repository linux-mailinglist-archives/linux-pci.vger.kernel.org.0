Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBDE10E93E
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2019 12:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfLBLBz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Dec 2019 06:01:55 -0500
Received: from foss.arm.com ([217.140.110.172]:52892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfLBLBy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Dec 2019 06:01:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3F03328;
        Mon,  2 Dec 2019 03:01:53 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D5FB3F68E;
        Mon,  2 Dec 2019 03:01:52 -0800 (PST)
Date:   Mon, 2 Dec 2019 11:01:45 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     robh+dt@kernel.org, frowand.list@gmail.com, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, andrew.murray@arm.com,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Zhiqiang.Hou@nxp.com
Subject: Re: [PATCH] PCI: layerscape: Add the SRIOV support in host side
Message-ID: <20191202110145.GA1496@e121166-lin.cambridge.arm.com>
References: <20191202104506.27916-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202104506.27916-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 02, 2019 at 06:45:06PM +0800, Xiaowei Bao wrote:
> GIC get the map relations of devid and stream id from the msi-map
> property of DTS, our platform add this property in u-boot base on
> the PCIe device in the bus, but if enable the vf device in kernel,
> the vf device msi-map will not set, so the vf device can't work,
> this patch purpose is that manage the stream id and device id map
> relations dynamically in kernel, and make the new PCIe device work
> in kernel.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
>  drivers/of/irq.c                            |  9 +++
>  drivers/pci/controller/dwc/pci-layerscape.c | 94 +++++++++++++++++++++++++++++
>  drivers/pci/probe.c                         |  6 ++
>  drivers/pci/remove.c                        |  6 ++
>  4 files changed, 115 insertions(+)

NAK

If u-boot is broken it should be fixed, we won't apply core PCI/OF
changes to paper over it.

Thanks,
Lorenzo

> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index a296eaf..791e609 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -576,6 +576,11 @@ void __init of_irq_init(const struct of_device_id *matches)
>  	}
>  }
>  
> +u32 __weak ls_pcie_streamid_fix(struct device *dev, u32 rid)
> +{
> +	return rid;
> +}
> +
>  static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
>  			    u32 rid_in)
>  {
> @@ -590,6 +595,10 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
>  		if (!of_map_rid(parent_dev->of_node, rid_in, "msi-map",
>  				"msi-map-mask", np, &rid_out))
>  			break;
> +
> +	if (rid_out == rid_in)
> +		rid_out = ls_pcie_streamid_fix(parent_dev, rid_in);
> +
>  	return rid_out;
>  }
>  
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index f24f79a..c1b3675 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -22,6 +22,8 @@
>  
>  #include "pcie-designware.h"
>  
> +#define FSL_PEX_STREAM_ID_START	7
> +#define FSL_PEX_STREAM_ID_END	22
>  /* PEX1/2 Misc Ports Status Register */
>  #define SCFG_PEXMSCPORTSR(pex_idx)	(0x94 + (pex_idx) * 4)
>  #define LTSSM_STATE_SHIFT	20
> @@ -33,8 +35,16 @@
>  #define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
>  #define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
>  
> +/* LUT registers */
> +#define PCIE_LUT_UDR(n)         (0x800 + (n) * 8)
> +#define PCIE_LUT_LDR(n)         (0x804 + (n) * 8)
> +#define PCIE_LUT_ENABLE         (1 << 31)
> +#define PCIE_LUT_ENTRY_COUNT    32
> +
>  #define PCIE_IATU_NUM		6
>  
> +unsigned long *stream_id_map;
> +
>  struct ls_pcie_drvdata {
>  	u32 lut_offset;
>  	u32 ltssm_shift;
> @@ -49,6 +59,7 @@ struct ls_pcie {
>  	struct regmap *scfg;
>  	const struct ls_pcie_drvdata *drvdata;
>  	int index;
> +	unsigned long *lut_reg_map;
>  };
>  
>  #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
> @@ -291,6 +302,77 @@ static int __init ls_add_pcie_port(struct ls_pcie *pcie)
>  	return 0;
>  }
>  
> +u32 ls_pcie_streamid_fix(struct device *dev, u32 rid)
> +{
> +	u32 lut_idx, streamid, val;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct ls_pcie *pcie = platform_get_drvdata(pdev);
> +
> +	for (lut_idx = 0; lut_idx < PCIE_LUT_ENTRY_COUNT; lut_idx++) {
> +		val = ioread32(pcie->lut + PCIE_LUT_UDR(lut_idx)) >> 16;
> +		if (val == rid) {
> +			streamid = ioread32(pcie->lut + PCIE_LUT_LDR(lut_idx)) &
> +				   (~PCIE_LUT_ENABLE);
> +			break;
> +		}
> +	}
> +
> +	return streamid;
> +}
> +
> +void ls_pcie_remove_streamid(struct pci_bus *bus, struct pci_dev *pdev)
> +{
> +	struct pcie_port *pp = bus->sysdata;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct ls_pcie *pcie = to_ls_pcie(pci);
> +	u32 lut_idx, streamid, rid, val;
> +
> +	rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
> +
> +	for (lut_idx = 0; lut_idx < PCIE_LUT_ENTRY_COUNT; lut_idx++) {
> +		val = ioread32(pcie->lut + PCIE_LUT_UDR(lut_idx)) >> 16;
> +		if (val == rid) {
> +			streamid = ioread32(pcie->lut + PCIE_LUT_LDR(lut_idx)) &
> +				   (~PCIE_LUT_ENABLE);
> +			break;
> +		}
> +	}
> +
> +	if (lut_idx >= PCIE_LUT_ENTRY_COUNT) {
> +		pr_err("Don't find the streamid relate to the rid !\n");
> +		return;
> +	}
> +
> +	iowrite32(0, pcie->lut + PCIE_LUT_UDR(lut_idx));
> +	iowrite32(0, pcie->lut + PCIE_LUT_LDR(lut_idx));
> +
> +	clear_bit(streamid, stream_id_map);
> +	clear_bit(lut_idx, pcie->lut_reg_map);
> +}
> +
> +void ls_pcie_add_streamid(struct pci_bus *bus, struct pci_dev *pdev)
> +{
> +	u32 free_lut, free_streamid, rid;
> +	struct pcie_port *pp = bus->sysdata;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct ls_pcie *pcie = to_ls_pcie(pci);
> +
> +	rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
> +
> +	free_streamid = find_first_zero_bit(stream_id_map,
> +					    FSL_PEX_STREAM_ID_END);
> +
> +	free_lut = find_first_zero_bit(pcie->lut_reg_map,
> +				       PCIE_LUT_ENTRY_COUNT);
> +
> +	iowrite32(rid << 16, pcie->lut + PCIE_LUT_UDR(free_lut));
> +	iowrite32(free_streamid | PCIE_LUT_ENABLE,
> +		  pcie->lut + PCIE_LUT_LDR(free_lut));
> +
> +	set_bit(free_streamid, stream_id_map);
> +	set_bit(free_lut, pcie->lut_reg_map);
> +}
> +
>  static int __init ls_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -298,6 +380,7 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
>  	struct ls_pcie *pcie;
>  	struct resource *dbi_base;
>  	int ret;
> +	u32 id;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
> @@ -324,6 +407,17 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
>  	if (!ls_pcie_is_bridge(pcie))
>  		return -ENODEV;
>  
> +	stream_id_map = devm_kcalloc(dev,
> +				     BITS_TO_LONGS(FSL_PEX_STREAM_ID_END),
> +				     sizeof(long), GFP_KERNEL);
> +
> +	for (id = 0; id < FSL_PEX_STREAM_ID_START; id++)
> +		set_bit(id, stream_id_map);
> +
> +	pcie->lut_reg_map = devm_kcalloc(dev,
> +					 BITS_TO_LONGS(PCIE_LUT_ENTRY_COUNT),
> +					 sizeof(long), GFP_KERNEL);
> +
>  	platform_set_drvdata(pdev, pcie);
>  
>  	ret = ls_add_pcie_port(pcie);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 512cb43..d4729b4 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2380,6 +2380,10 @@ static void pci_set_msi_domain(struct pci_dev *dev)
>  	dev_set_msi_domain(&dev->dev, d);
>  }
>  
> +void __weak ls_pcie_add_streamid(struct pci_bus *bus, struct pci_dev *pdev)
> +{
> +}
> +
>  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  {
>  	int ret;
> @@ -2417,6 +2421,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	ret = pcibios_add_device(dev);
>  	WARN_ON(ret < 0);
>  
> +	ls_pcie_add_streamid(bus, dev);
> +
>  	/* Set up MSI IRQ domain */
>  	pci_set_msi_domain(dev);
>  
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index e9c6b12..af6cc7f 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -62,11 +62,17 @@ void pci_remove_bus(struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pci_remove_bus);
>  
> +void __weak ls_pcie_remove_streamid(struct pci_bus *bus, struct pci_dev *pdev)
> +{
> +}
> +
>  static void pci_stop_bus_device(struct pci_dev *dev)
>  {
>  	struct pci_bus *bus = dev->subordinate;
>  	struct pci_dev *child, *tmp;
>  
> +	ls_pcie_remove_streamid(dev->bus, dev);
> +
>  	/*
>  	 * Stopping an SR-IOV PF device removes all the associated VFs,
>  	 * which will update the bus->devices list and confuse the
> -- 
> 2.9.5
> 
