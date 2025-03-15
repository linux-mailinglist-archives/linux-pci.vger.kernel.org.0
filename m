Return-Path: <linux-pci+bounces-23859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E34A63257
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 21:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D5A1897251
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 20:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056312040AF;
	Sat, 15 Mar 2025 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGgMzP+H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96FB1A0714;
	Sat, 15 Mar 2025 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742069765; cv=none; b=vC1mBzhAOuIxDYwILV3HmHIwFyoeZdgJvYA6zbXjhV48jcviB8uhpp909sxDxoRVRSg3Sb7IUbCsS22H1wfiakoqR9R8JwwbiIhxgWIsDmb/lgJekdnteBZxNeKgs4p4uZ3TiGJzdxHXOKIClMlleU6xcjt0H6jIv+IQOvBIpdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742069765; c=relaxed/simple;
	bh=E3PedX9sNZiQ1BV/O9EpA8C81OOjh20/lUaAHE3DtA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MYLx2BcWMtAGaYzo+HLx20FFIjtBp17u7MCjDfi8uRBs9gP0HCT+BQUl0Pj5D5DZ08BC3uIW+Inp6Qmvu+v2PlM3/ennRcA3Ac+uiNYp2z3RPSGxBIrxvt3cGb1auwxAehlUNfTMqTtLYij1/oA48Z7H2UktQiEscyo98k4hmP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGgMzP+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2545AC4CEE5;
	Sat, 15 Mar 2025 20:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742069765;
	bh=E3PedX9sNZiQ1BV/O9EpA8C81OOjh20/lUaAHE3DtA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LGgMzP+HyeYNsWRexcWS1UQy5lF7/SiT8kbmjpe0V7KGXVhC16quRuC6PDpAFVv3J
	 7w+uStJS3FCJ4bkMc/0iOORUEVi1OQVJtFB5WJinf2m2SU6tDXZ5zUCh42vhWdrCW0
	 Yv+aaNW/nNC2Zi6UoIXP1zy4ndb0F/zDRmWN/O/8/tXN6cnC+X5OQxm3nZZI5gvU+5
	 Ijt7NdgHQ3LXr0tkZ0QbfHjgN4egaV3qeB2CkxD7tonsKAEJGx+oA8M74Wn09lV7vm
	 LWqias3AKWqPReaiak0HsaqZY8zaUMcenOYMVxBk86KVqQ8HAzjT7S3HThlSojd66f
	 6h5r1Eh2j4/hg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v12 06/13] PCI: dwc: Add dw_pcie_parent_bus_offset() checking and debug
Date: Sat, 15 Mar 2025 15:15:41 -0500
Message-Id: <20250315201548.858189-7-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250315201548.858189-1-helgaas@kernel.org>
References: <20250315201548.858189-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

dw_pcie_parent_bus_offset() looks up the parent bus address of a PCI
controller 'reg' property in devicetree.  If implemented, .cpu_addr_fixup()
is a hard-coded way to get the parent bus address corresponding to a CPU
physical address.

Add debug code to compare the address from .cpu_addr_fixup() with the
address from devicetree.  If they match, warn that .cpu_addr_fixup() is
redundant and should be removed; if they differ, warn that something is
wrong with the devicetree.

If .cpu_addr_fixup() is not implemented, the parent bus address should be
identical to the CPU physical address because we previously ignored the
parent bus address from devicetree.  If the devicetree has a different
parent bus address, warn about it being broken.

[bhelgaas: split debug to separate patch for easier future revert, commit
log]
Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-5-01d2313502ab@nxp.com
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 26 +++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h | 13 ++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 0a35e36da703..985264c88b92 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1114,7 +1114,8 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
 	int index;
-	u64 reg_addr;
+	u64 reg_addr, fixup_addr;
+	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
 
 	/* Look up reg_name address on parent bus */
 	index = of_property_match_string(np, "reg-names", reg_name);
@@ -1126,5 +1127,28 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
 
 	of_property_read_reg(np, index, &reg_addr, NULL);
 
+	fixup = pci->ops->cpu_addr_fixup;
+	if (fixup) {
+		fixup_addr = fixup(pci, cpu_phy_addr);
+		if (reg_addr == fixup_addr) {
+			dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
+				 cpu_phy_addr, reg_name, index,
+				 fixup_addr, fixup);
+		} else {
+			dev_warn(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; devicetree is broken\n",
+				 cpu_phy_addr, reg_name,
+				 index, fixup_addr);
+			reg_addr = fixup_addr;
+		}
+	} else if (!pci->use_parent_dt_ranges) {
+		if (reg_addr != cpu_phy_addr) {
+			dev_warn(dev, "devicetree has incorrect translation; please check parent \"ranges\" property. CPU physical addr %#010llx, parent bus addr %#010llx\n",
+				 cpu_phy_addr, reg_addr);
+			return 0;
+		}
+	}
+
+	dev_info(dev, "%s parent bus offset is %#010llx\n",
+		 reg_name, cpu_phy_addr - reg_addr);
 	return cpu_phy_addr - reg_addr;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 16548b01347d..f08d2852cfd5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -465,6 +465,19 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+
+	/*
+	 * If iATU input addresses are offset from CPU physical addresses,
+	 * we previously required .cpu_addr_fixup() to convert them.  We
+	 * now rely on the devicetree instead.  If .cpu_addr_fixup()
+	 * exists, we compare its results with devicetree.
+	 *
+	 * If .cpu_addr_fixup() does not exist, we assume the offset is
+	 * zero and warn if devicetree claims otherwise.  If we know all
+	 * devicetrees correctly describe the offset, set
+	 * use_parent_dt_ranges to true to avoid this warning.
+	 */
+	bool			use_parent_dt_ranges;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
-- 
2.34.1


