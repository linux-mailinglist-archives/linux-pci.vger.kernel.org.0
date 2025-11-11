Return-Path: <linux-pci+bounces-40877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E3AC4D43B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 12:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8FEF4EBA2C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 10:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF973587C2;
	Tue, 11 Nov 2025 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Spw1Vepb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762A63587DF;
	Tue, 11 Nov 2025 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858293; cv=none; b=d3Ah/pWlkf+EeKlY36OUcB/YyVzQVk7fYMsntUUIGjKSksMQj3pK1VTlglx2DQvqe0s9YToegJcnQo/SMsHApbHzt8ijaURf39s05f6orjvRhp5bkPdjS2KNLf7oWabuFOx8xin3WeAi4fMkJlPfPH8mCxJ75oGPWMgyiVcKCKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858293; c=relaxed/simple;
	bh=mznq/LSPn3bmREJ0ouEWfsj5jUgppO6NSs3TveHRoIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfQEgtSRmJNQ4Gj5bBiip5WIylkMA2jXDATL+yyFD1gatRaOyu+zW255Ot2lQxT0eWE8D3UXYXcoZZAuxvuaU1X8BAWYz/8oEpnfGa0wkfzmhJs+qdxnjhqOA67KWNHtOhFBVj3Cbc3cy74UkfVfGF50oXMAM+uBnOQWbbHCpEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Spw1Vepb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D515C19425;
	Tue, 11 Nov 2025 10:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762858293;
	bh=mznq/LSPn3bmREJ0ouEWfsj5jUgppO6NSs3TveHRoIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Spw1VepbkeW+uMxeyrgguofdqOPsW9eV/wnzn+9dR/39+dwsq05FzWCL8l7x7U+Re
	 feTtNeBqylCrWQWlxkCR2zC7uYinXqjzkjZhBom5maDG5olyl/+awsqkkTTxEGCpWS
	 o+hhRKd1WOK4VDkTl1b0Il/vp9a4s63fUONZ+vJ9chhPIR09ZPZLlwJVj4MOIz7EQa
	 eawAKxTgF1A4sdtH7vDdFozLMUvMamT2Uwc0HfvcxDpgyb7JtmijHWxKDA6lna+H/r
	 A0VFa7k6Ov79FNER5XT2EtyyoTxeWYWaQ+fqpGSHOL6XTGqRzpUXdqz6aiASWwh6RI
	 XMPpr9w8Emdag==
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
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 6/6] Revert "PCI: dwc: Don't wait for link up if driver can detect Link Up event"
Date: Tue, 11 Nov 2025 11:51:06 +0100
Message-ID: <20251111105100.869997-14-cassel@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111105100.869997-8-cassel@kernel.org>
References: <20251111105100.869997-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4446; i=cassel@kernel.org; h=from:subject; bh=mznq/LSPn3bmREJ0ouEWfsj5jUgppO6NSs3TveHRoIE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKFRcX3z1p2yNnlIUfJ5dAEydvV+5j684z05zK2KW9Lv tjfV1nRUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgImUsDMyTImYfc7vF4PkSqPj 6rqHD0qocFpOCrZ9738/obTbcrvFE4b/QRnXzTxCfkzWq9ef+i7pyQahB3tC/D84ztlw45bOrAx 1JgA=
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
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++--------
 drivers/pci/controller/dwc/pcie-designware.h      |  1 -
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e92513c5bda5..f7e13dc16653 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -664,14 +664,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
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
index e995f692a1ec..640827e9d093 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -426,7 +426,6 @@ struct dw_pcie_rp {
 	bool			use_atu_msg;
 	int			msg_atu_index;
 	struct resource		*msg_res;
-	bool			use_linkup_irq;
 	struct pci_eq_presets	presets;
 	struct pci_config_window *cfg;
 	bool			ecam_enabled;
-- 
2.51.1


