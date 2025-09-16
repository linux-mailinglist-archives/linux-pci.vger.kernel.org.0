Return-Path: <linux-pci+bounces-36275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 134FAB59D42
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 18:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E38F324644
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 16:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BB02BEFF2;
	Tue, 16 Sep 2025 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqP6tQTV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35DD2BCF68;
	Tue, 16 Sep 2025 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039190; cv=none; b=d1aAG4+cVsfHkTqAlF/zz9TUZmUwEcClGuK0RmAznIEAg3WaYYhdbomZ2yOEbbT/ZF3QAmkdXMT5StFklTjUEkecXOW8SYtvx4a4W/F0pYV5d8VTtV8cXSDvTl0KM7yW+yx2+qsEwfBlm+0B5fRKRK2dD5uoWoYzaQRjPAs8Vf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039190; c=relaxed/simple;
	bh=tyF9RyC9mlZfesTeOG2MGENxPeqAg1Ywr3CxNrP9p5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j89C3bwu1tHZ8FFurYaU0jmwEOtqbT7CEX+Rk5haVsDKTknTXwd5j5acvURBHAL7xJNPSNzszRb3knGJR4U4Q7RbmaMTSUhYZW00XkF2PnQxmda4DAPuIeETUEUMxtN3kSBkpHmU1JD4SElPoRdmoXOQ/7xCV7MW7MKiXFZZWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqP6tQTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EE72C4CEEB;
	Tue, 16 Sep 2025 16:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758039190;
	bh=tyF9RyC9mlZfesTeOG2MGENxPeqAg1Ywr3CxNrP9p5M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KqP6tQTV6M4LQbrZ1x0BKHHupF5fyZopiu736LwPlzZIjD6obds7XDHQOiNKTiC/0
	 +/DfEytKgRkE2AF7zMJuz0zrj8wW08JZmBN+co3R1QPhuw+Zs4WND5q7cEMpdVIXLm
	 TmE9MknkFaQ4SIJzlGt8nIjXgJgOy93S00xApwUmcOH0DsnsFTRxSkTSsHuqFBX22K
	 GB8yIvu8l0Oedb6Nk8pZ/NqHCaaDwY+NY9hL1Rcz5Wg15T1DGUqj/8+N1LLMm1zDyi
	 L3QCN8uQXytri7cLTBHliL9QPN1/nabM5AhkSoEbgdg0MKIP+N15sxMMCB+8fRsK6u
	 m883DgZR23scQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACD1CAC599;
	Tue, 16 Sep 2025 16:13:10 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 16 Sep 2025 21:42:52 +0530
Subject: [PATCH 1/2] PCI/ASPM: Override the ASPM and Clock PM states set by
 BIOS for devicetree platforms
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-pci-dt-aspm-v1-1-778fe907c9ad@oss.qualcomm.com>
References: <20250916-pci-dt-aspm-v1-0-778fe907c9ad@oss.qualcomm.com>
In-Reply-To: <20250916-pci-dt-aspm-v1-0-778fe907c9ad@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6096;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=mb8JVPsHMaTMVCXcaz6UM3OfVWvgWcj7i6rK1yWo59s=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYsg42TNlR9tF76aMB4UPJlbkiSgeC5RKX+pzWEs/IeXtj
 ErLjS6nOxmNWRgYuRhkxRRZ0pc6azV6nL6xJEJ9OswgViaQKQxcnAIwkUhT9v9xy4/rcfk+/TEh
 PinXYatCnKD3D+X33p7zWead+NL+V3WhUd+reyWNF42dYhONynT0d27YujRT8/pp04hygZyD2wR
 /NZQkOtjZ1df9y7/5o7c1/3mVILusvtN7G4+eyNfWBgfkX9o9OJjp7B3akVF27sjN379WaPxvjz
 1gWL6Ue6Ov8ne1utgMq+Wr0vsYmOf7NWpLRqXc4Ht/2eXa7T7ulFzpx5eEIzXPxqj5PGGN10gNn
 e+yZF2v9mKeEHPL/xa7j4XWd3hLvuiSrPhhWtD8/lFYUPGzfwxyUyY0sXc5aTrXuLHxvSzu3pan
 knXh7/pnhc4N085mpN6uibI8pGx+cMXuE3FR62zVp6UAAA==
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

So far, the PCI subsystem has honored the ASPM and Clock PM states set by
the BIOS (through LNKCTL) during device initialization. This was done
conservatively to avoid issues with the buggy devices that advertise
ASPM capabilities, but behave erratically if the ASPM states are enabled.
So the PCI subsystem ended up trusting the BIOS to enable only the ASPM
states that were known to work for the devices.

But this turned out to be a problem for devicetree platforms, especially
the ARM based devicetree platforms powering Embedded and *some* Compute
devices as they tend to run without any standard BIOS. So the ASPM states
on these platforms were left disabled during boot and the PCI subsystem
never bothered to enable them, unless the user has forcefully enabled the
ASPM states through Kconfig, cmdline, and sysfs or the device drivers
themselves, enabling the ASPM states through pci_enable_link_state() APIs.

This caused runtime power issues on those platforms. So a couple of
approaches were tried to mitigate this BIOS dependency without user
intervention by enabling the ASPM states in the PCI controller drivers
after device enumeration, and overriding the ASPM/Clock PM states
by the PCI controller drivers through an API before enumeration.

But it has been concluded that none of these mitigations should really be
required and the PCI subsystem should enable the ASPM states advertised by
the devices without relying on BIOS or the PCI controller drivers. If any
device is found to be misbehaving after enabling ASPM states that they
advertised, then those devices should be quirked to disable the problematic
ASPM/Clock PM states.

In an effort to do so, start by overriding the ASPM and Clock PM states set
by the BIOS for devicetree platforms first. Separate helper functions are
introduced to set the default ASPM and Clock PM states and they will
override the BIOS set states by enabling all of them if CONFIG_OF is
enabled. To aid debugging, print the overridden ASPM and Clock PM states.

In the future, these helpers could be extended to allow other platforms
like VMD, newer ACPI systems with a cutoff year etc... to follow the path.

Link: https://lore.kernel.org/linux-pci/20250828204345.GA958461@bhelgaas
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pcie/aspm.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 919a05b9764791c3cc469c9ada62ba5b2c405118..1e7218c5e9127699fdbf172c277aad3f847c43be 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -235,13 +235,15 @@ struct pcie_link_state {
 	u32 aspm_support:7;		/* Supported ASPM state */
 	u32 aspm_enabled:7;		/* Enabled ASPM state */
 	u32 aspm_capable:7;		/* Capable ASPM state with latency */
-	u32 aspm_default:7;		/* Default ASPM state by BIOS */
+	u32 aspm_default:7;		/* Default ASPM state by BIOS or
+					   override */
 	u32 aspm_disable:7;		/* Disabled ASPM state */
 
 	/* Clock PM state */
 	u32 clkpm_capable:1;		/* Clock PM capable? */
 	u32 clkpm_enabled:1;		/* Current Clock PM state */
-	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
+	u32 clkpm_default:1;		/* Default Clock PM state by BIOS or
+					   override */
 	u32 clkpm_disable:1;		/* Clock PM disabled */
 };
 
@@ -373,6 +375,20 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 	pcie_set_clkpm_nocheck(link, enable);
 }
 
+static void pcie_clkpm_set_default_link_state(struct pcie_link_state *link,
+					      int enabled)
+{
+	struct pci_dev *pdev = link->downstream;
+
+	link->clkpm_default = enabled;
+
+	/* Override the BIOS disabled Clock PM state for devicetree platforms */
+	if (IS_ENABLED(CONFIG_OF) && !enabled) {
+		link->clkpm_default = 1;
+		pci_info(pdev, "Clock PM state overridden\n");
+	}
+}
+
 static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	int capable = 1, enabled = 1;
@@ -394,7 +410,7 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 			enabled = 0;
 	}
 	link->clkpm_enabled = enabled;
-	link->clkpm_default = enabled;
+	pcie_clkpm_set_default_link_state(link, enabled);
 	link->clkpm_capable = capable;
 	link->clkpm_disable = blacklist ? 1 : 0;
 }
@@ -788,6 +804,29 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
 		aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
 }
 
+static void pcie_aspm_set_default_link_state(struct pcie_link_state *link)
+{
+	struct pci_dev *pdev = link->downstream;
+	u32 override;
+
+	/* Set BIOS enabled states as the default */
+	link->aspm_default = link->aspm_enabled;
+
+	/* Override the BIOS disabled ASPM states for devicetree platforms */
+	if (IS_ENABLED(CONFIG_OF)) {
+		link->aspm_default = PCIE_LINK_STATE_ASPM_ALL;
+		override = link->aspm_default & ~link->aspm_enabled;
+		if (override)
+			pci_info(pdev, "ASPM states overridden: %s%s%s%s%s%s\n",
+				 (override & PCIE_LINK_STATE_L0S) ? "L0s, " : "",
+				 (override & PCIE_LINK_STATE_L1) ? "L1, " : "",
+				 (override & PCIE_LINK_STATE_L1_1) ? "L1.1, " : "",
+				 (override & PCIE_LINK_STATE_L1_2) ? "L1.2, " : "",
+				 (override & PCIE_LINK_STATE_L1_1_PCIPM) ? "L1.1 PCI-PM, " : "",
+				 (override & PCIE_LINK_STATE_L1_2_PCIPM) ? "L1.2 PCI-PM" : "");
+	}
+}
+
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
@@ -865,8 +904,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);
 	}
 
-	/* Save default state */
-	link->aspm_default = link->aspm_enabled;
+	pcie_aspm_set_default_link_state(link);
 
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;

-- 
2.45.2



