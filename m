Return-Path: <linux-pci+bounces-22706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EF2A4AD66
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 19:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E22A3B66F5
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 18:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B91E32B7;
	Sat,  1 Mar 2025 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="k+8qDxWv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-74.smtpout.orange.fr [80.12.242.74])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E464223F37C;
	Sat,  1 Mar 2025 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740854657; cv=none; b=aeTa3hDl9BsH/rH4t+2V21/v8dXeZovFSMRanGO+G5E2XNmrsooafXwuTcHUTO1WMLDulCrKokmBF2qOR3SHSf1TOiA9zcu4Ej8ncauSaoX8/OVpLG3gB8UTRYgBkchFWSkmPsOpjmjtlT57a8EDbe0rLHqHsZT3621ca4JoAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740854657; c=relaxed/simple;
	bh=T433eUfkMrUo1Wprk9rrV953OoJLM5qrhVCq/CAQvvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E6rCKDQSlDIwifyJfdGXgoaArQBQ+fCktdmDs14Q645+ws1ImjUZ+PHEvblHrCVng0rzBohAwP9/dG+gm9lVnCkNt0TLCM7LOCy0SFWEmhYooBupQvHAQOg8Ykv0htMAOZQkr3axozY1mmHL5bNw/nn2BuB1ntnVAsFgy26DypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=k+8qDxWv; arc=none smtp.client-ip=80.12.242.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id oRndttkZclzKeoRngtwIir; Sat, 01 Mar 2025 19:43:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740854583;
	bh=kivS0j5YlRBr/NK4eTwHFGgQZng6nDYYZFuu6CKvKgs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=k+8qDxWvuRHPkPZSB2Uaccu3gZfp77O4E/sYM+P8NRjnFIP9uUEBpkZnnl8u2eLb0
	 6u9jmR90VAlyT42PfnGwq6/ow/Z5G8leuU/sJcLobMZQx7EKgn0EA9NJl0a98hrIaj
	 p1Kqk2pAh6hBPiyiz3pUYbck45ud5clerjXjAjZtW6nZTk/z+CObM5SUXuZ0am009R
	 RM3PoxRvMxQ4c/cRkX8hVZsZS0jATFscJ65ZBBss8PWxXV1QxgSEsR/8wQ1ICC1vb2
	 u1uEdqniDswEcUwN1sor0UR1reugBes7qeTI2cA7mwsIEOAbVFoO10SmEw786nALoz
	 ob14oIapN5qpw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 01 Mar 2025 19:43:03 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Shawn Guo <shawn.guo@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jianguo Sun <sunjianguo1@huawei.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: histb: Fix an error handling path in histb_pcie_probe()
Date: Sat,  1 Mar 2025 19:42:54 +0100
Message-ID: <8301fc15cdea5d2dac21f57613e8e6922fb1ad95.1740854531.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs after a successful phy_init() call, then phy_exit()
should be called.

Add the missing call, as already done in the remove function.

Fixes: bbd11bddb398 ("PCI: hisi: Add HiSilicon STB SoC PCIe controller driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is compile tested only.

It is also completly speculative. Review with care.
---
 drivers/pci/controller/dwc/pcie-histb.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 615a0e3e6d7e..63b701881357 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -409,16 +409,22 @@ static int histb_pcie_probe(struct platform_device *pdev)
 	ret = histb_pcie_host_enable(pp);
 	if (ret) {
 		dev_err(dev, "failed to enable host\n");
-		return ret;
+		goto err_exit_phy;
 	}
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");
-		return ret;
+		goto err_exit_phy;
 	}
 
 	return 0;
+
+err_exit_phy:
+	if (hipcie->phy)
+		phy_exit(hipcie->phy);
+
+	return ret;
 }
 
 static void histb_pcie_remove(struct platform_device *pdev)
-- 
2.48.1


