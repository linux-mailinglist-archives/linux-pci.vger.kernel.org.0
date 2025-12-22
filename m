Return-Path: <linux-pci+bounces-43499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB45CD4CFE
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 07:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7B533004CEB
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 06:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876B1327C1C;
	Mon, 22 Dec 2025 06:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKFFc1fv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECF322D780;
	Mon, 22 Dec 2025 06:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766385766; cv=none; b=Rb8yemKYyiePrWUzybUB5D/w3rhx7Tzp5O9aBUjvVoJ0sOx+gic0xfcYNFZEAxW4EK6dZdmzc0aQ/9YaKb8aBhSXn2RqCEHB5m18EeS+rc7O3bJulEfWqqMp4ZjrEyCL5ZwWtGHixvD6o3NLau8Zt5iVDXLTrEiSKtw2oz3adN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766385766; c=relaxed/simple;
	bh=mCKaL1IT3wM3F6Y1P5NiNrk1OIhHJDnRR2tUDzWQk1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUBxH5icQQKwhc87aLmyvAVWRENiOg/0hhlEn00AqM5zKuDzWmsv0bPFcBndQltWA6NQeodIphgCtQr5AQrNnXKRWN1uG0twiPs+FmZQe8NkMgR8Vj17P6365Pl5O+tsl/XrgIlxFXgTDwRSkdZX0DBIdCYz+sgqf7/hqflqEBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKFFc1fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CF2C4CEF1;
	Mon, 22 Dec 2025 06:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766385765;
	bh=mCKaL1IT3wM3F6Y1P5NiNrk1OIhHJDnRR2tUDzWQk1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKFFc1fvZ9Sp7X2PTGLUeIi5zDnTP82hBMgJiMks6VcBHBec915J/UqBVIGiy0L3v
	 CI7x+ZLFbD5SkxnDbBO1ymKsVbsBEc52fhGrJCY3EnUpKhtkyliW1/t08siSGbBJiL
	 V1epPxr3HR+BmCNbUU9fuPxCoI9+MHXgBBR/7Q0/F4Y6hNVeJarf0jVN5YqkY31K7N
	 ikpsgJbaDFgQfucwUy1XcjpBGQTBDyivRtn5Ekuw1098V3YLsjNbjfT6xsE6/eH/jE
	 PmtVNJBNgCVxSXalcCySz1p65UentN3eW0HNEIPL1e7ehlaZqVO/vq8BMnucn33X35
	 gvMpuVg8CmBNA==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 6/6] Revert "PCI: dwc: Don't wait for link up if driver can detect Link Up event"
Date: Mon, 22 Dec 2025 07:42:13 +0100
Message-ID: <20251222064207.3246632-14-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222064207.3246632-8-cassel@kernel.org>
References: <20251222064207.3246632-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4543; i=cassel@kernel.org; h=from:subject; bh=mCKaL1IT3wM3F6Y1P5NiNrk1OIhHJDnRR2tUDzWQk1Q=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI9XngEb9W9mJgzXWbrh+3c2ydbp2uZbvaKerrj3+ZZ/ 72vZu1e3FHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJqBgw/He/9DOsc2KJX0jn CfHt8+5/+yM74W6MVuHRv8fv2Wi2VigzMuyeKaLe8D759KELRx9vFgh8rDPzatexsKQws5O3goP OLWQBAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

This reverts commit 8d3bf19f1b585a3cc0027f508b64c33484db8d0d.

While this fake hotplugging was a nice idea, it has shown that this feature
does not handle PCIe switches correctly:
pci_bus 0004:43: busn_res: can not insert [bus 43-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:43: busn_res: [bus 43-41] end is updated to 43
pci_bus 0004:43: busn_res: can not insert [bus 43] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:00.0: devices behind bridge are unusable because [bus 43] cannot be assigned for them
pci_bus 0004:44: busn_res: can not insert [bus 44-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:44: busn_res: [bus 44-41] end is updated to 44
pci_bus 0004:44: busn_res: can not insert [bus 44] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:02.0: devices behind bridge are unusable because [bus 44] cannot be assigned for them
pci_bus 0004:45: busn_res: can not insert [bus 45-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:45: busn_res: [bus 45-41] end is updated to 45
pci_bus 0004:45: busn_res: can not insert [bus 45] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:06.0: devices behind bridge are unusable because [bus 45] cannot be assigned for them
pci_bus 0004:46: busn_res: can not insert [bus 46-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:46: busn_res: [bus 46-41] end is updated to 46
pci_bus 0004:46: busn_res: can not insert [bus 46] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:0e.0: devices behind bridge are unusable because [bus 46] cannot be assigned for them
pci_bus 0004:42: busn_res: [bus 42-41] end is updated to 46
pci_bus 0004:42: busn_res: can not insert [bus 42-46] under [bus 41] (conflicts with (null) [bus 41])
pci 0004:41:00.0: devices behind bridge are unusable because [bus 42-46] cannot be assigned for them
pcieport 0004:40:00.0: bridge has subordinate 41 but max busn 46

During the initial scan, PCI core doesn't see the switch and since the Root
Port is not hot plug capable, the secondary bus number gets assigned as the
subordinate bus number. This means, the PCI core assumes that only one bus
will appear behind the Root Port since the Root Port is not hot plug
capable.

This works perfectly fine for PCIe endpoints connected to the Root Port,
since they don't extend the bus. However, if a PCIe switch is connected,
then there is a problem when the downstream busses starts showing up and
the PCI core doesn't extend the subordinate bus number after initial scan
during boot.

The long term plan is to migrate this driver to the pwrctrl framework,
once it adds proper support for powering up and enumerating PCIe switches.

Cc: stable@vger.kernel.org
Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++--------
 drivers/pci/controller/dwc/pcie-designware.h      |  1 -
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 8c41b90a1db1..06c02fcc76c8 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -665,14 +665,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_remove_edma;
 	}
 
-	/*
-	 * Note: Skip the link up delay only when a Link Up IRQ is present.
-	 * If there is no Link Up IRQ, we should not bypass the delay
-	 * because that would require users to manually rescan for devices.
-	 */
-	if (!pp->use_linkup_irq)
-		/* Ignore errors, the link may come up later */
-		dw_pcie_wait_for_link(pci);
+	/* Ignore errors, the link may come up later */
+	dw_pcie_wait_for_link(pci);
 
 	ret = pci_host_probe(bridge);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index fc9cf8ce8629..a3a3f6e89a81 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -438,7 +438,6 @@ struct dw_pcie_rp {
 	bool			use_atu_msg;
 	int			msg_atu_index;
 	struct resource		*msg_res;
-	bool			use_linkup_irq;
 	struct pci_eq_presets	presets;
 	struct pci_config_window *cfg;
 	bool			ecam_enabled;
-- 
2.52.0


