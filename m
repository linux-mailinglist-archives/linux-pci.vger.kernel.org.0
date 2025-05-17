Return-Path: <linux-pci+bounces-27910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19133ABAAE6
	for <lists+linux-pci@lfdr.de>; Sat, 17 May 2025 17:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 263977A8257
	for <lists+linux-pci@lfdr.de>; Sat, 17 May 2025 15:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDDE1F463A;
	Sat, 17 May 2025 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YK+rJJsQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC91188006;
	Sat, 17 May 2025 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747497026; cv=none; b=qmO1YRF/P53JL/IDGFPd6bI0WqT3H+mpZFsUpzC5rTd3msrU2A1RurwNmo5Xp+2nrH0/skjSMF9PzXOEPqX5wpnXA5F1bUi0wWqigt2QSPugLWacoxqEKbJpNFHa7LY55lmX8UAWBfg58epgTmkG/FWS8rBaY9Jhj2SFf+G/cs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747497026; c=relaxed/simple;
	bh=Xws1kjhDiU04G4wBV58t3/FYwJxcP3RBAIHx4fpVgwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H51+qGUOgjZy1QRieA4z5pczU6K/fQ2iRVkHkzzmqSwuOp33JLNa5ux/XfvdAOD3GGl4PnZDwlqPJ7FEKF2pH9jw84sM4QI3V0Wq+xEMvYWlbmBYdL1Jn3eAAu4pdDoFn+THP6EiYESTdcx38YCziQchCWc9heifq2wT9CUFeJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YK+rJJsQ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ey
	Kx6/uXroylg9WsUk9eGlYvyXmYNrjKr5GppJiMOOo=; b=YK+rJJsQGucguGL2eD
	NAMgJqs7us87eCD1efpOoPMD9IyR0ZvQvsIhPBFn7dnlPQCdAqkWQ4mSMLGRJO8U
	hYuhflXQOp9v29Y3nmFsaCqaP4y97NGOUbNLWd6Kow80dFEb5tj6eWF7wWKbprQq
	/4PwFPRjhwCOlEPDhyiPkHkds=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wBHc5kVsChoBHRqCA--.24311S2;
	Sat, 17 May 2025 23:49:42 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	kwilczynski@kernel.org,
	manivannan.sadhasivam@linaro.org
Cc: ilpo.jarvinen@linux.intel.com,
	jhp@endlessos.org,
	daniel.stodden@gmail.com,
	ajayagarwal@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI/ASPM: Use boolean type for aspm_disabled and aspm_force
Date: Sat, 17 May 2025 23:49:39 +0800
Message-Id: <20250517154939.139237-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHc5kVsChoBHRqCA--.24311S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw18JryxXr48WFW8trW5Wrg_yoW8GFWfpF
	ZrCFn2kF18Za1IvF4DJa4DuF15G39xt342y3s09w13ZanxAr1DXFn7XF1FqF18XrW8X3W7
	KF1fJFyUJF4fCr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEdb1wUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgFQo2gorSM6vgAAsC

The aspm_disabled and aspm_force variables are used as boolean flags.
Change their type from int to bool and update assignments to use
true/false instead of 1/0. This improves code clarity.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pcie/aspm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 29fcb0689a91..98b3022802b2 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -245,7 +245,7 @@ struct pcie_link_state {
 	u32 clkpm_disable:1;		/* Clock PM disabled */
 };
 
-static int aspm_disabled, aspm_force;
+static bool aspm_disabled, aspm_force;
 static bool aspm_support_enabled = true;
 static DEFINE_MUTEX(aspm_lock);
 static LIST_HEAD(link_list);
@@ -1712,11 +1712,11 @@ static int __init pcie_aspm_disable(char *str)
 {
 	if (!strcmp(str, "off")) {
 		aspm_policy = POLICY_DEFAULT;
-		aspm_disabled = 1;
+		aspm_disabled = true;
 		aspm_support_enabled = false;
 		pr_info("PCIe ASPM is disabled\n");
 	} else if (!strcmp(str, "force")) {
-		aspm_force = 1;
+		aspm_force = true;
 		pr_info("PCIe ASPM is forcibly enabled\n");
 	}
 	return 1;
@@ -1734,7 +1734,7 @@ void pcie_no_aspm(void)
 	 */
 	if (!aspm_force) {
 		aspm_policy = POLICY_DEFAULT;
-		aspm_disabled = 1;
+		aspm_disabled = true;
 	}
 }
 

base-commit: fee3e843b309444f48157e2188efa6818bae85cf
-- 
2.25.1


