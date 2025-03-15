Return-Path: <linux-pci+bounces-23863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACC1A6326A
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 21:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C99C3A5389
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 20:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD0E2063E7;
	Sat, 15 Mar 2025 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKbN1Os1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B011A23BC;
	Sat, 15 Mar 2025 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742069773; cv=none; b=qldS6/FDk7uYO2/2nfiJ9upArD6zaZahq0rcAbJu3MKcsS8uj0IzumgngPNPMNPV29eYrw55dEjpqXf7FvXstpJ03QlEYGT1v1yeqehNY5JndZc1esysRAAODED8HalXDezgGdlfPjkhBhVrxMGGY9FbsjKa7Pg41whWx7b+Ycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742069773; c=relaxed/simple;
	bh=dNILN4r+Al7Iv9FjmzWJiSbivc2v5KyuqPxcL2Ik9V8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YkvVXlVxcbnxckM2fsOa1jycFUVw3qyTw7kf+8N/pmku2v4Ew7VJyy3igkNtiF8QUYfaXrxK1I0l1Ia1BuzDaVPgxRh4eg+pOxMVoKj/a9mDr5dJb0LeFiSI4zW3HsW5hh+L8ixFv7drkefmtb48F/8ExJmyeghePB+UCrr1Grc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKbN1Os1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5E3C4CEE9;
	Sat, 15 Mar 2025 20:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742069771;
	bh=dNILN4r+Al7Iv9FjmzWJiSbivc2v5KyuqPxcL2Ik9V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sKbN1Os1kX1zfvoEE4PVo/Stbjod7xR1zcdkRhxv4BlOdEO/4fwpcfcdgggliVL71
	 i/5YftVY4/rL8KGn6ael+PzvSKO3S96LcbzD0eMRKiLMMltfQwd8VqkS3uG7LmJU7t
	 Cg2zZ8mBFgfC8IWuh2JPrhvVFVvdwKNrFlRv4aHq+QhLz84qqsVG1Fscjya+K9diro
	 50GZujYjTjISuHfBuaZwF8U8Gum43DZk75V/NlkhobM91eaw0lLlhB3RUIAOKMi8r/
	 QO54o/J/cD9K/0D6WXVX45j0S8Lw1jEgl1pNHEHO8hnV7Q9BxgF1LffLKva7sMHPI0
	 ibgp6dG9soojw==
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
Subject: [PATCH v12 10/13] PCI: dwc: ep: Use devicetree 'reg[addr_space]' to derive CPU -> ATU addr offset
Date: Sat, 15 Mar 2025 15:15:45 -0500
Message-Id: <20250315201548.858189-11-helgaas@kernel.org>
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

                   Endpoint
  ┌───────────────────────────────────────────────┐
  │                             pcie-ep@5f010000  │
  │                             ┌────────────────┐│
  │                             │   Endpoint     ││
  │                             │   PCIe         ││
  │                             │   Controller   ││
  │           bus@5f000000      │             ┌────────►
  │           ┌──────────┐      │             │  ││dynamically
  │           │          │ Outbound Transfer  │  ││allocated
  │┌─────┐    │  Bus     ┼─────►│ ATU  ───────┘  ││PCI Addr
  ││     │    │  Fabric  │Bus   │                ││
  ││ CPU ├───►│          │Addr  │                ││
  ││     │CPU │          │0x8000_0000            ││
  │└─────┘Addr└──────────┘      │                ││
  │       0x7000_0000           └────────────────┘│
  └───────────────────────────────────────────────┘

  bus@5f000000 {
          compatible = "simple-bus";
          ranges = <0x80000000 0x0 0x70000000 0x10000000>;

          pcie-ep@5f010000 {
                  reg = <0x80000000 0x10000000>;
                  reg-names ="addr_space";
                  ...
          };
          ...
  };

In the diagram above, CPU writes data to outbound window address
0x7000_0000, and the bus fabric maps it to 0x8000_0000. The ATU uses
bus address 0x8000_0000 as input address and maps to some PCI address
dynamically allocated by a PCI device driver on the host side.

The pcie-ep@5f010000 'reg[addr_space]' is the parent bus address of the
PCIe controller input, including the ATU.

Set parent_bus_offset, the offset from the CPU address to the PCIe
controller input address using dw_pcie_init_parent_bus_offset().  The
parent_bus_offset is not used yet, so no functional change intended.

Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-7-01d2313502ab@nxp.com
Signed-off-by: Frank Li <Frank.Li@nxp.com>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 2db834345ec2..bb87d0c5c665 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -904,6 +904,13 @@ static int dw_pcie_ep_get_resources(struct dw_pcie_ep *ep)
 	ep->phys_base = res->start;
 	ep->addr_size = resource_size(res);
 
+	/*
+	 * artpec6_pcie_cpu_addr_fixup() uses ep->phys_base, so call
+	 * dw_pcie_parent_bus_offset() after setting ep->phys_base.
+	 */
+	pci->parent_bus_offset = dw_pcie_parent_bus_offset(pci, "addr_space",
+							   ep->phys_base);
+
 	ret = of_property_read_u8(np, "max-functions", &epc->max_functions);
 	if (ret < 0)
 		epc->max_functions = 1;
-- 
2.34.1


