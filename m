Return-Path: <linux-pci+bounces-35907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E19B5320A
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 14:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E622A05FCE
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 12:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9022320CD7;
	Thu, 11 Sep 2025 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erFcDGL2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9091C320CC4;
	Thu, 11 Sep 2025 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593659; cv=none; b=u7xwvCq+5ttuE/a2NUA4bBjzOBkJ4r4viyVtL0Q8Q7YyS8aKzmj77scu0O5STEk48Nkfr6er7yZ4gIrEbIIB/AqchQvHk46G5SMzm7GuSIlBYeKfv+2Jq1TtkotjCVd8bfNDIIgRxiXyES8Ci6AMYpQNzTVFYGss+98Vk9O8G9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593659; c=relaxed/simple;
	bh=ZN0jrV1KDnr77L3AhzHO29ED5A3EMFfATyOYYBJ/Qzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SDLU4qe8DZpn6hKr+qYngoAlQGncNrh+jzLycVyUd7N/rnmKMmEvTIjR1/5o5c4JJprxOqF7hHR3RFuSJ4uYN+Zs3REF0mDN25brbW6dl0WFG4itgux+/DmqYO8fHLU2F33Q5XrktyTMooClKLij69xSZ5TiT008yemyBCnV3rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erFcDGL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6271C4CEF0;
	Thu, 11 Sep 2025 12:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757593659;
	bh=ZN0jrV1KDnr77L3AhzHO29ED5A3EMFfATyOYYBJ/Qzc=;
	h=From:To:Cc:Subject:Date:From;
	b=erFcDGL2O6Bw0sWzbmCjC3CExFWCAY7zr9xNDiQKJ6imuFTk3QJIySRsaPH3rLfcx
	 2UZG+dBElG4lb4QzDvXphhMZYRxmVxsnWnRV7LUa1W/aoApUNrqnAjCfhkBJa5xWjs
	 grQ8kSxsXknjbJjr3MxcZuIDIjgXAH83Ui7wU9Jmcbtz/lZMf74AE5xtvNM+sCJEyD
	 HH2l0Jzj1LVa1qFHXxiV6d6Ed9D4RArxh3ec2TBuGvOCctpvPz9tvnz0+Nvj9X4X93
	 LiCGgXzadFqiAW5szE2NF3px5gFir9dRZKHoEZDqQRPuHfpcTbWiTrWgtJXmgHjcAt
	 z50U+xGjT+d1Q==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Vidya Sagar <vidyas@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH] PCI: tegra194: Handle errors in BPMP response
Date: Thu, 11 Sep 2025 14:27:29 +0200
Message-ID: <20250911122728.1465254-2-cassel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2909; i=cassel@kernel.org; h=from:subject; bh=r05IwKzlHB1eMgnm//wOddg5YVJk3SUUqByMk+/eZuU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIOHTCYZbTwvnvc26k2mav1puYcjuyYP/2O+jcR3/k+P R1KL5+adpSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAi01IZ/jtsrXQW4ReWjm+/ 6n/u5cWaZYtf8RevNMvk0U5IWXFz6UmG36xrYx4qujhEcq4U43g5ZxV79f7pW1quLTmpujonY0H uAW4A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Vidya Sagar <vidyas@nvidia.com>

The return value from tegra_bpmp_transfer() indicates the success or
failure of the IPC transaction with BPMP. If the transaction
succeeded, we also need to check the actual command's result code.

If a host deasserts PERST without providing a refclock, enabling the PHY
(via a tegra_bpmp_transfer() call) will silently fail, however, because
we are lacking error handling, pex_ep_event_pex_rst_deassert() will still
set pcie->ep_state = EP_STATE_ENABLED.

Because of this, any succeeding PERST deassertion will incorrectly be a
no-op (because of the pcie->ep_state == EP_STATE_ENABLED check in
pex_ep_event_pex_rst_deassert()), even if the host does provide a refclock
during the succeeding PERST deassertion.

Add error handling to tegra_bpmp_transfer(), such that the pcie->ep_state
can not get out of sync with reality, which will incorrectly cause the
driver to think that it has been successfully initialized, which
incorrectly makes future calls to pex_ep_event_pex_rst_deassert() a no-op.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
[cassel: improve commit log]
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0c0734aa14b68..8c5c370dbba5e 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1214,6 +1214,7 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 	struct mrq_uphy_response resp;
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
+	int err;
 
 	/*
 	 * Controller-5 doesn't need to have its state set by BPMP-FW in
@@ -1236,7 +1237,13 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 	msg.rx.data = &resp;
 	msg.rx.size = sizeof(resp);
 
-	return tegra_bpmp_transfer(pcie->bpmp, &msg);
+	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
+	if (err)
+		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
+
+	return 0;
 }
 
 static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
@@ -1245,6 +1252,7 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 	struct mrq_uphy_response resp;
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
+	int err;
 
 	memset(&req, 0, sizeof(req));
 	memset(&resp, 0, sizeof(resp));
@@ -1264,7 +1272,13 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 	msg.rx.data = &resp;
 	msg.rx.size = sizeof(resp);
 
-	return tegra_bpmp_transfer(pcie->bpmp, &msg);
+	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
+	if (err)
+		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
+
+	return 0;
 }
 
 static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
-- 
2.51.0


