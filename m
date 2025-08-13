Return-Path: <linux-pci+bounces-33923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87959B23FD9
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4047B5E40
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA472BF01E;
	Wed, 13 Aug 2025 04:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EIkstUBz"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD652C159F;
	Wed, 13 Aug 2025 04:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755060364; cv=none; b=neb237mWYfQsGwY7HR7OQY7cqpi4+rYRtyc08/iJPHFwQP9m0hupEx2hCVzQChkcKHu6JPpnc/kTQkOTPnllfVA5SVqG9ajNvSvighS5oIcp7EMhZSpVTfhmqooSyuw1PQIJhR5CD7vrjgax1d3AVdxq1rKHi1O3Lrms4p7pw1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755060364; c=relaxed/simple;
	bh=Z2q/YjAtEQrUkNHvChoT20lsMUU0Uxe74MLieYSxuCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GqtW6VRY4PAhXpq/PjubUt1G/6jlAIhFHW1GCV+hz+TruI+X6tJnaMO77yn5euJGVf68vsXFQA58s+fL3g8Du/S40I+v4/gnuwJ7yHAj/BGSCcwKpfe5Kp8wDsvlPh3ckK0slzfk0pUtYvwDoHr+ft+7SoB6n/eiXHFQS09hv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EIkstUBz; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ju
	m7xd28Eqqn71swVEu6hB+f6uM122vBFG4Ae+dxAvM=; b=EIkstUBzLgeKI+aHUo
	I1XlEo0DfUyLZX5Mb+WYliHEGGcxlbjeaa5VC9SeQ7hmRr4HQMLrZxa7KqEgPlv2
	wfJAL9fpqcnREEjoL0XqwBSRXVKR2hSYRwLhp6sRHJ5gdSqPgW01PsIuVg2y4IVD
	FHPcNkcm+P1GeF1LCn2/LpXjQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnCKx4GJxoOGujAw--.23777S2;
	Wed, 13 Aug 2025 12:45:45 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v4 08/13] PCI: dw-rockchip: Refactor code by using dw_pcie_clear_and_set_dword()
Date: Wed, 13 Aug 2025 12:45:26 +0800
Message-Id: <20250813044531.180411-9-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250813044531.180411-1-18255117159@163.com>
References: <20250813044531.180411-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnCKx4GJxoOGujAw--.23777S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1rGr4Dtr1DJF1ruw18Grg_yoW8CrW5p3
	y3Aa4akF4fJw4rua1kAa97ZF13ta9xAFW7JF93G3WSqFy2kryDK3WYkryaqF1xGr42vF1a
	93yUt3yUZF43AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piKLvZUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhioo2icEADVjwABsW

Rockchip PCIe driver implements L0s capability enablement through
explicit register read-modify-write. The current approach reads the
LNKCAP register, modifies the ASPM_L0S bit, then writes back the
value with DBI write protection handling.

Refactor ASPM capability configuration using
dw_pcie_clear_and_set_dword(). The helper combines bit manipulation with
DBI protection in a single call, replacing three-step manual operations.
This simplifies the capability setup flow and reduces code complexity.

Adopting the standard helper improves maintainability by eliminating
local variables and explicit bitwise operations. The change also ensures
consistent handling of DBI write protection across capability modification
functions.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index b5f5eee5a50e..a49cf89e5e08 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -196,15 +196,14 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
 
 static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
 {
-	u32 cap, lnkcap;
+	u32 cap;
 
 	/* Enable L0S capability for all SoCs */
 	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	if (cap) {
-		lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
-		lnkcap |= PCI_EXP_LNKCAP_ASPM_L0S;
 		dw_pcie_dbi_ro_wr_en(pci);
-		dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
+		dw_pcie_clear_and_set_dword(pci, cap + PCI_EXP_LNKCAP,
+					    0, PCI_EXP_LNKCAP_ASPM_L0S);
 		dw_pcie_dbi_ro_wr_dis(pci);
 	}
 }
-- 
2.25.1


