Return-Path: <linux-pci+bounces-35889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDD0B52D4C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 11:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA9956149D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 09:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7152D3218;
	Thu, 11 Sep 2025 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtWet2gn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55732253B71;
	Thu, 11 Sep 2025 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583030; cv=none; b=Tc3NfmgrEP/8obdVq2b2OKkLL+9ufUjh2bwk1ULfd811K8AduVm0vZEp6YCv7m5RGOSuGD/woMEyFXZtqdYtVOO3X30F4gINESuwAXmyUX4/avQLVXhp2vLqCKT1OvXRExfAKaxNbvSp0yTIGcoZQDJb4VSWBNT9I9RVcLUN/2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583030; c=relaxed/simple;
	bh=XlD4WoOFeyYCMS23BhK7vxcJp2Nn2UT84D4twDMVang=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i0u5chzloFDqqH4nweNXcZ+nTfFJ4h7t2stEsEd8xbdH76fl0LxjxocXnTEa8YlK2rFiKLkh+zz/fw7buMcwe1V4Mja+yqmKkgrhFpYZFZd9a2BHwStdLorwl4RKuv1gBZQ9GqNntZDWFveMFWbqdxFAJbYNv0l0NzalJt7k31M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtWet2gn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C68C4CEF7;
	Thu, 11 Sep 2025 09:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757583030;
	bh=XlD4WoOFeyYCMS23BhK7vxcJp2Nn2UT84D4twDMVang=;
	h=From:To:Cc:Subject:Date:From;
	b=FtWet2gnnN5HpKYLZEDrkwvr1gA7DtHdix0DvbJsNaDiChQprN9AUHb6MK7Jrcgt0
	 CNBxI7aSfmEn5XN/Gk9y3TB9T9E5XUhhLySh5JufXB5mELaodbIFia2LX4IiffM2UD
	 0x7glvuIKcblHccUsh4lAaBE1Vtcf7CGvf6CyFLGLcaFL0Rc3zpRF4XbJhx5itrSRM
	 EtV3lNJvtfQ9WwTDWvGvITCxjI3G1zpmwGmn3ro8/mBcsCCO5F2A4nvm7jbOImzmkj
	 bd6cpnO3yNmc0R4xUKbDKHgP+d/ukNnoPuAspsMCBbqBKsOVSur2TFBT0wUUrTfz5R
	 AsvHgRvuMj/Gw==
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
	Nagarjuna Kristam <nkristam@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH] PCI: tegra194: Fix duplicate pll disable
Date: Thu, 11 Sep 2025 11:30:22 +0200
Message-ID: <20250911093021.1454385-2-cassel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1463; i=cassel@kernel.org; h=from:subject; bh=M648GLrR928m0wVvWYgbmCdhyWQ+VTim/YBmiK/5wC4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIOTVubvrunRvNWRYs+L5/NJ5n2L7nyxnru0wPknBk2r /RpDTPtKGVhEONikBVTZPH94bK/uNt9ynHFOzYwc1iZQIYwcHEKwET2ZjH8lW96raOozld69puK Widb3tXGxax3fix7xdiWrFq8n+P3f0aGjjVftjgzGvPOjvh/yMv9m07qP5kG/ydLUvN+TUu6az2 ZAQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Nagarjuna Kristam <nkristam@nvidia.com>

During PERST# assertion tegra_pcie_bpmp_set_pll_state() is currently
called twice.

pex_ep_event_pex_rst_assert() should do the opposite of
pex_ep_event_pex_rst_deassert(), so it is obvious that the duplicate
tegra_pcie_bpmp_set_pll_state() is a mistake, and that the duplicate
tegra_pcie_bpmp_set_pll_state() call should instead be a call to
tegra_pcie_bpmp_set_ctrl_state().

With this, the uninitialization sequence also matches that of
tegra_pcie_unconfig_controller().

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
[cassel: improve commit log]
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4f26086f25daf..0c0734aa14b68 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1722,9 +1722,9 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 				ret);
 	}
 
-	ret = tegra_pcie_bpmp_set_pll_state(pcie, false);
+	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, false);
 	if (ret)
-		dev_err(pcie->dev, "Failed to turn off UPHY: %d\n", ret);
+		dev_err(pcie->dev, "Failed to disable controller: %d\n", ret);
 
 	pcie->ep_state = EP_STATE_DISABLED;
 	dev_dbg(pcie->dev, "Uninitialization of endpoint is completed\n");
-- 
2.51.0


