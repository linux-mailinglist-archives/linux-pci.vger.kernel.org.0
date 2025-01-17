Return-Path: <linux-pci+bounces-20084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B805A1591B
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 22:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7307E3A2DB2
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 21:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3881AA792;
	Fri, 17 Jan 2025 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4CfQ94O"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F2C1AA1F1;
	Fri, 17 Jan 2025 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149893; cv=none; b=UMVu5QvNyqmOWjsprO7S4jHu2lTmWR7nUMUYZ8kP67fwD3AwIM8Hoc+tiHtRen7vLEA+i5sA0G6VnrZ+pRmH3qfl5V9yiEQBMze9Y/hDI+//wF4h8PyZxr4wmVKmj9fIyF/50+OfpWwWknri8xEJR+O4c9fCeelrEcv2OwAH1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149893; c=relaxed/simple;
	bh=HFQNhfd47610NSNP8MfcXIi0KpUPmKVTLUViSqR9iOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Yr8DKIQnOe7tcRtbLY1+XKiFvHhgY0tAdQ5lXA+dauWj+4RvlE7kNeXQD9QKpcJxaNlRp5v1nEs0+ri5JDtFOk2Bti8udGNrd+cKhtlzSz7I5IRGyi0J18MBjZXWDLaowahkeT7A6Ul13kaZRQcJbdaJMRedrGAt+wA+5PnNwiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4CfQ94O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979E6C4CEDD;
	Fri, 17 Jan 2025 21:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737149892;
	bh=HFQNhfd47610NSNP8MfcXIi0KpUPmKVTLUViSqR9iOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Q4CfQ94O2VZh4MeIwIt9KG+/zBOncA/41aDOsSSdnZ1m3cDwbQ56kg6GxLGNw20Cq
	 FARj4j83qiPiJvoUViFVpmuBSPwTnn/lwdAzIBnN7/xJie8etNOrrsDpczP4A3xUr3
	 qyBt0/FTF737KV8YO6de7MhEOVZEH0OAcUTmWUZM/ZhGUkIceK75OJhRX5hbRuOhok
	 RJKfvZoQf6k3tNQkoL3WhmnCdbNuaq/csmoPZ1EuvRpigwDey53ykTOck6v25lx4Lc
	 phiKD3gJGzAeL2Tfp9WeDupNHScVUHqLwLZWMgbGCXIFvLdGlyJ8UWuNzG3FOgW5eS
	 QoIp1tWR+4JNA==
Date: Fri, 17 Jan 2025 15:38:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:PCI DRIVER FOR IMX6" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR IMX6" <linux-arm-kernel@lists.infradead.org>,
	"open list:PCI DRIVER FOR IMX6" <imx@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: imx6: Add CONFIG_PCIE_DW_HOST check for
 suspend/resume
Message-ID: <20250117213810.GA656803@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117180722.2354290-1-Frank.Li@nxp.com>

On Fri, Jan 17, 2025 at 01:07:22PM -0500, Frank Li wrote:
> Add CONFIG_PCIE_DW_HOST check for suspend/resume to avoid build issue
> when CONFIG_PCIE_DW_HOST is not defined but CONFIG_PCIE_DW_EP defined.
> 
> Only host support suspend/resume at i.MX chips.

What would you think of inserting the following patch before
"[PATCH v7 08/10] PCI: imx6: Use dwc common suspend resume method"?

Then we wouldn't need to add #ifdefs in every driver that supports
both RC and EP mode and also supports power management for RC mode.

Bjorn


commit d3b04bf25988 ("PCI: dwc: Add dw_pcie_suspend_noirq(), dw_pcie_resume_noirq() stubs for !CONFIG_PCIE_DW_HOST")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Jan 17 15:03:04 2025 -0600

    PCI: dwc: Add dw_pcie_suspend_noirq(), dw_pcie_resume_noirq() stubs for !CONFIG_PCIE_DW_HOST
    
    Previously pcie-designware.h declared dw_pcie_suspend_noirq() and
    dw_pcie_resume_noirq() unconditionally, even though they were only
    implemented when CONFIG_PCIE_DW_HOST was defined.
    
    Add no-op stubs for them when CONFIG_PCIE_DW_HOST is not defined so
    drivers that support both Root Complex and Endpoint modes don't need
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 8c0222f019d7..f400f562700e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -500,9 +500,6 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);
 void dw_pcie_edma_remove(struct dw_pcie *pci);
 
-int dw_pcie_suspend_noirq(struct dw_pcie *pci);
-int dw_pcie_resume_noirq(struct dw_pcie *pci);
-
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
 	dw_pcie_write_dbi(pci, reg, 0x4, val);
@@ -680,6 +677,8 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
 }
 
 #ifdef CONFIG_PCIE_DW_HOST
+int dw_pcie_suspend_noirq(struct dw_pcie *pci);
+int dw_pcie_resume_noirq(struct dw_pcie *pci);
 irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp);
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
 int dw_pcie_host_init(struct dw_pcie_rp *pp);
@@ -688,6 +687,16 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp);
 void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 				       int where);
 #else
+static inline int dw_pcie_suspend_noirq(struct dw_pcie *pci)
+{
+	return 0;
+}
+
+static inline int dw_pcie_resume_noirq(struct dw_pcie *pci)
+{
+	return 0;
+}
+
 static inline irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
 {
 	return IRQ_NONE;

