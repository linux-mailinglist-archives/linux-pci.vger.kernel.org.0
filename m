Return-Path: <linux-pci+bounces-43496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D88CD4D04
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 07:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 448D23008881
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 06:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44650327C1E;
	Mon, 22 Dec 2025 06:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X57lv1A4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E09327C19;
	Mon, 22 Dec 2025 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766385756; cv=none; b=KBqvhwDi9J8oHmXPJu8Hc8XTAUlVk+RC3N9pc4yZaiAkt9HC0fuG96pjDeV7tBrYfq1NPT18nAyXObytH2aKiMth9pd4ZKDJXEnlS62CisDvnGFhiWifh0kDU7a6eH4i5PEXvFGa58t8UpZKjEa379hIJfKOJQ42WdhOLtuVPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766385756; c=relaxed/simple;
	bh=Fr4yk7k5y3uHh/YsR7yacBa/G6djF2KRQBIuPL+dvko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKDJOZDOWxyrmmpSeNdJZPZAXuxchSQMmtrIfl01IFqroAN/2THGDa6Xzr33PWmnumLMQY60ngqvbqG4ZNnG0fX9UUd5cjdKkKG86dGVDNHldFuucrJkjJKKTZkn9ti/T9P/wOhxcqfpg9mUjPQobQCGcwvXJfCWVBmKgyjDI5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X57lv1A4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033D2C4AF0C;
	Mon, 22 Dec 2025 06:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766385755;
	bh=Fr4yk7k5y3uHh/YsR7yacBa/G6djF2KRQBIuPL+dvko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X57lv1A4mTxJ+dhFtsC3faF482eMh877ithyBmrxZVMCATYIGH58JfRSAgZmlYxkk
	 N/dYXRPP4xWnBMsChjXAun8X4NTenHkI4NbnzEciNwIw19EacI3V4qaCIq7QM98r94
	 TryHA79FGNuIdNDPGMSixgEiEpedQIXYYzGIIGNHQHHIAy1hQuGCUabVuCpgdcw6Rl
	 fAWjrXo68V2nC4HPribPJIMVBpl4NR8FdEE4I4kHY89KFzfoaovwIZzIkBlI538J64
	 toh7GunZcYFByndz+dSJNR7MHMgiNODlVfcreH3VG3Uoz/04YrzTsLWEeSqQNykF4x
	 lzyRK2sXYm7uA==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
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
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 3/6] Revert "PCI: qcom: Don't wait for link if we can detect Link Up"
Date: Mon, 22 Dec 2025 07:42:10 +0100
Message-ID: <20251222064207.3246632-11-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222064207.3246632-8-cassel@kernel.org>
References: <20251222064207.3246632-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3982; i=cassel@kernel.org; h=from:subject; bh=Fr4yk7k5y3uHh/YsR7yacBa/G6djF2KRQBIuPL+dvko=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI9XrirLO+K7GhrX8RjqViuefKIeE4m197skwY6i/+9+ PQg83pHRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACayZxnDX5E9zu8d+eIzk8t4 +I/INm9U8PY7rOcTtbm3aKvqJE+/A4wMT7fv+PPwutTXR4XSy4qX3V4wsyvMteNSL/tl+blN3vz reAE=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

This reverts commit 36971d6c5a9a134c15760ae9fd13c6d5f9a36abb.

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
 drivers/pci/controller/dwc/pcie-qcom.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 60373fe1362f..e87ec6779d44 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1958,10 +1958,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
-	irq = platform_get_irq_byname_optional(pdev, "global");
-	if (irq > 0)
-		pp->use_linkup_irq = true;
-
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "cannot initialize host\n");
@@ -1975,6 +1971,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_host_deinit;
 	}
 
+	irq = platform_get_irq_byname_optional(pdev, "global");
 	if (irq > 0) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						qcom_pcie_global_irq_thread,
-- 
2.52.0


