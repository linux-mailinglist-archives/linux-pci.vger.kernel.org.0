Return-Path: <linux-pci+bounces-23860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBC8A6325C
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 21:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BDD51747C5
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 20:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266D6204C26;
	Sat, 15 Mar 2025 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCec3JEo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8B0204C03;
	Sat, 15 Mar 2025 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742069767; cv=none; b=gkJ2I1ujsVBsGJdQjUJ45hxP9YN+4D4ONhBYf5vQt4isn4G69qm2LRoCI25rQErcifADadAcIiGtxroaiSNPzDZmwpoIjfBJ4k1HCsxlg+Gz+FenbmSavIkSzkqOssp0lnW4nA2kBd2yWQfGfGruz9edndwMfZxPFBhHoaz+824=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742069767; c=relaxed/simple;
	bh=5Pyw4V6nrG7uOLsGfG1KhPT4b0176A60wcej/LAZzgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0UU48eERhNRO/2JU+l/AJfEEXe2xIF6157EqPLmmoz6G6el6LOyseuBEG51HX80loYvVHG1/XwueJXTpYqINnTW4dwJmEmLwlvgVCIhMyqnRq/vAax1Qiel3tBG0rkAXNYWbrgJkuo0WveHNrjtmKYdFS4+Pg1TQ0LtUvqiwaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCec3JEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1950C4CEE5;
	Sat, 15 Mar 2025 20:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742069766;
	bh=5Pyw4V6nrG7uOLsGfG1KhPT4b0176A60wcej/LAZzgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BCec3JEoZKMeMnRTJoQjnM9mnbf7uxET98j5vgJnwJW9tGF1OmEgR0E19rMKxM7Aw
	 ym7Weps4wLJNnjrFDBW8b1F6PS7rQ44rf+gLNrL9pCszBhDPlwhxSupb9NXKyUX4bR
	 RypzZFVYd4YjeXJfWOe+iiqfNnjYr+nWmutUjjmaCdjFNeE672XIe1lQIAwOyTF4Wc
	 m6gEZu5LUfr8wNdh0zY5pflqO6ix28Omy9lJiRwuLS+U/LUKv3HmQpNw3613Y2iUcJ
	 CwC0YHQIO8zGhA1z0comY+hV7Qd7ZjsrQHidzPJ2fM/9v06EVDeVvRDl4l0meVwyiC
	 kGC1gfRq4Dgyg==
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
Subject: [PATCH v12 07/13] PCI: dwc: Use devicetree 'reg[config]' to derive CPU -> ATU addr offset
Date: Sat, 15 Mar 2025 15:15:42 -0500
Message-Id: <20250315201548.858189-8-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250315201548.858189-1-helgaas@kernel.org>
References: <20250315201548.858189-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

The 'ranges' property of a PCI controller's parent can indicate address
translation information. Most system use 1:1 map between CPU physical and
PCI controller input addresses.

But some hardware, like i.MX8QXP, doesn't use 1:1 map.  See below diagram:

              ┌─────────┐                    ┌────────────┐
   ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
   │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
   └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
    CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
  0x7ff8_0000─┼───┘  │  │             │   │  │            │
              │      │  │             │   │  │            │   PCI Addr
  0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
              │         │             │      │            │    0
  0x7000_0000─┼────────►├─────────┐   │      │            │
              └─────────┘         │   └──────► CfgSpace  ─┼────────────►
               Bus Fabric         │          │            │    0
                                  │          │            │
                                  └──────────► MemSpace  ─┼────────────►
                          IA: 0x8000_0000    │            │  0x8000_0000
                                             └────────────┘

  bus@5f000000 {
          compatible = "simple-bus";
          #address-cells = <1>;
          #size-cells = <1>;
          ranges = <0x80000000 0x0 0x70000000 0x10000000>;

          pcie@5f010000 {
                  compatible = "fsl,imx8q-pcie";
                  reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
                  reg-names = "dbi", "config";
                  ...
          };
  };

Intermediate address (IA) here means the PCIe controller input address.
The pcie@5f010000 'reg[config]' address is the parent bus (PCIe controller
input) address of CfgSpace.

The ATU in MemSpace is not explicitly described via devicetree, so we
assume the offset from CPU address to intermediate MemSpace address is the
same as that for CfgSpace.

We could use bus@5f000000 'ranges' for the same purpose.

Set parent_bus_offset using dw_pcie_init_parent_bus_offset().  The
parent_bus_offset is not used yet, so no functional change intended.

Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-6-01d2313502ab@nxp.com
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++++++
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9ce06b1ee266..9e38ac7d1bcb 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -452,6 +452,12 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 		pp->io_base = pci_pio_to_address(win->res->start);
 	}
 
+	/*
+	 * visconti_pcie_cpu_addr_fixup() uses pp->io_base, so we have to
+	 * call dw_pcie_parent_bus_offset() after setting pp->io_base.
+	 */
+	pci->parent_bus_offset = dw_pcie_parent_bus_offset(pci, "config",
+							   pp->cfg0_base);
 	return 0;
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f08d2852cfd5..741c46926ce2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -445,6 +445,7 @@ struct dw_pcie {
 	void __iomem		*atu_base;
 	resource_size_t		atu_phys_addr;
 	size_t			atu_size;
+	resource_size_t		parent_bus_offset;
 	u32			num_ib_windows;
 	u32			num_ob_windows;
 	u32			region_align;
-- 
2.34.1


