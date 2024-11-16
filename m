Return-Path: <linux-pci+bounces-16948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085659CFBEB
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 02:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B039C283A12
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 01:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389194400;
	Sat, 16 Nov 2024 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEdDdlEi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094A22114;
	Sat, 16 Nov 2024 01:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731718853; cv=none; b=SiBGq+zuzQjxLV4xhn+w5bHVjlpbY4RrxAQpgR0R7TrYmvTNx1g5Qpp2zbFrCfR96IrsaTAfOzIIIB1C6hDNjy+3ZHqzzLO2yvvJTAf4KKtVWneRkpFbMz0REiOorcF1n1eNzGYUzeH+a3CkpTK8r5R5FdOxcO8qKgEKpEZVxT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731718853; c=relaxed/simple;
	bh=UBdDBmt8ZlBFutpYAXacFPqijEw8kEDo7m/KsNO/SRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YLhjKHkqYlWNgAB9kA+6vIpbX7YbfR147aQEHV3wxkNTWhZeP4+VxvFJfqKvHB3w57G24TejFjruQsOQ8JRik03e8PbngGiHdvQPdGxgOkKuaDhQK4/Bcuxq6+NcP3ey/rISsVq2iyb8WFozMkFULAMAIFnUSwbrlHRRH16sV60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEdDdlEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2514DC4CECF;
	Sat, 16 Nov 2024 01:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731718852;
	bh=UBdDBmt8ZlBFutpYAXacFPqijEw8kEDo7m/KsNO/SRI=;
	h=From:To:Cc:Subject:Date:From;
	b=KEdDdlEijbHUcjU69cP4JtSO3BcupDk+sQJ0vbJZlC2Wlb9bup5zcCMqavvfjG9C3
	 6uM43A4Ro1exDMhCjwFTBySOhygwoqZMJ9W6FNUI1bTCLKlBZ33kXNPhCSEG3Z1QZ6
	 3AKHADpK+x28fpX05rRFU+Mt/o6gZDzwA4euK1OToJBvIaYJRgNW/q3VOODZwmkiuJ
	 LAk/ta6uuWqTvw+4/keKUfDxPGIXLanqFchZVxB6IRaZZZccJGB51eMUzLSObVyNJ8
	 rsEDjkEKR8VNc0L5n958vJM0FkpfqqsLzX5+LE43AB7Sg1MA93razAb/tIygqVJbOa
	 SpW7UBh0BHitA==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: dwc: ep: Fix advertised resizable BAR size again
Date: Sat, 16 Nov 2024 01:59:51 +0100
Message-ID: <20241116005950.2480427-2-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1492; i=cassel@kernel.org; h=from:subject; bh=UBdDBmt8ZlBFutpYAXacFPqijEw8kEDo7m/KsNO/SRI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLN37X9mrbzLkf9Ve/n/95+Ed87nzFpWeze872ruqx+1 3dN41vd0lHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJMMxg+Cvg3Vi3+TqLB9fD S1emhxu+3X5ZIHq54LJurZTTjKXrZpgz/OE9nJY9I7bXRfk9V/Kh2N8/0qxniLzJcGIvfX1a9qe uNzsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The advertised resizable BAR size was fixed in commit 72e34b8593e0 ("PCI:
dwc: endpoint: Fix advertised resizable BAR size").

Commit 867ab111b242 ("PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown() API
to handle Link Down event") was included shortly after this, and moved the
code to another function. When the code was moved, this fix was mistakenly
lost.

According to the spec, it is illegal to not have a bit set in
PCI_REBAR_CAP, and 1 MB is the smallest size allowed.

Set bit 4 in PCI_REBAR_CAP, so that we actually advertise support for a
1 MB BAR size.

Cc: stable@vger.kernel.org
Fixes: 867ab111b242 ("PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown() API to handle Link Down event")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 43ba5c6738df1..cc8ff4a014368 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -689,7 +689,7 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 		 * for 1 MB BAR size only.
 		 */
 		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
-			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
+			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, BIT(4));
 	}
 
 	dw_pcie_setup(pci);
-- 
2.47.0


