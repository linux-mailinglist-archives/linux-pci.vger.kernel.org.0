Return-Path: <linux-pci+bounces-40874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E5FC4D3D4
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 11:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA0918C2AD3
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 10:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4AB354716;
	Tue, 11 Nov 2025 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUuU0J24"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C2354AF4;
	Tue, 11 Nov 2025 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858283; cv=none; b=WpOAF7P1bgJOhesv9TDEICGmCf9hc5TuayPnBUClcTuo5eYIImz5ArzOdK9ruQLJOsZd75AO2aLoAXf+fzf1kAEFAarqwqk3XJrf6jlvYOjoBDgoycntSY+zgL3E5sJNYsgHoaICoM9abBeKQBEhvsA0oYWDyuyAq5sY0+ulTfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858283; c=relaxed/simple;
	bh=KQFcltA1YTOW8wFzTg1A74xu3BPlLmfOXmJrG/cc1Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X85RveTNLzZilAqiY5tHyNGesG2mD6oRA2+zfTgfqzVKTm67CIgTcfNKBObBcM75u4uhJE8uR6JtxQiji4vMf2znguZOM5o1jof2VfpMAAo+2uub0tv/+rVzTrj4Q2GTnvJYswc6qSoblfZqKdYbDED7pCpEQUHAH26m2cjDHXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUuU0J24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C185CC4CEFB;
	Tue, 11 Nov 2025 10:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762858283;
	bh=KQFcltA1YTOW8wFzTg1A74xu3BPlLmfOXmJrG/cc1Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MUuU0J24pljE3LDduRMqg2DDOn6BwPGb+n8YS+/7V/FNN5vam/OKzFLVSZrl9a68n
	 hGRb/c1JWfvbdaeYfNLiFt0vxNodVxMD1n0zqKq0b7C8Ug+Wm9djMNvFDjiihr85ip
	 SRB1/SPpEUkDncedSYq1ygqqczEi2XKmEvZwj0YJPcRno3CgzR7HZc2CsPZtSIwbVG
	 r8WsAnqMCgcuckObLYwZixSglxTBYqnyGhJw2RCVOBU9m/c2G/nnQVv9VBpPHRDA8Z
	 hNYaODtu5g96xjEI3Nl/eZSVp2kfSgfgBjBRAD9FqULvx6t3kgotlGniY/lH5vpFlA
	 uh7hGEPQ+e/gQ==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 3/6] Revert "PCI: qcom: Don't wait for link if we can detect Link Up"
Date: Tue, 11 Nov 2025 11:51:03 +0100
Message-ID: <20251111105100.869997-11-cassel@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111105100.869997-8-cassel@kernel.org>
References: <20251111105100.869997-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3885; i=cassel@kernel.org; h=from:subject; bh=KQFcltA1YTOW8wFzTg1A74xu3BPlLmfOXmJrG/cc1Sg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKFRUVvXN69fEPn6e4rOW0czzjfW7BkFkxJ6iznLRffd e1eLEtaRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACZid5Xhf8qTV3I67fq8l1T/ 3DjA4F1kvXT/t/A3wT6HVS43qR1s9mJk2L9TaovrWl+J6ItT7t8OYXrxR6aIW9r31Z9QjpPv0k6 v4gAA
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
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c48a20602d7f..70c0ae8b7523 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1927,10 +1927,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
-	irq = platform_get_irq_byname_optional(pdev, "global");
-	if (irq > 0)
-		pp->use_linkup_irq = true;
-
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "cannot initialize host\n");
@@ -1944,6 +1940,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_host_deinit;
 	}
 
+	irq = platform_get_irq_byname_optional(pdev, "global");
 	if (irq > 0) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						qcom_pcie_global_irq_thread,
-- 
2.51.1


