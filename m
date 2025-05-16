Return-Path: <linux-pci+bounces-27879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C60ABABA15C
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 18:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24EED1C0261B
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 16:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A07222592;
	Fri, 16 May 2025 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mUGyHCPE"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ACE222577;
	Fri, 16 May 2025 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414572; cv=none; b=bOnjdWYAtSCLWwKEeU2Qr6+JhNsEsT3S04w3Xbr0ZQ5PLTx9d2yRX3c64u+Ds7p/n9Ft7Xbqgs0m9ddSDh/7iMwd+0q/BlrUVE+LfkB8ox84vHRrdDI+C/X5eOlyXOOcjs8kKU8dzPQdEOrw9PsIRb5m/i0eJsAGAMzJ7j/DPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414572; c=relaxed/simple;
	bh=XuXxFMrT5gtouRubhK14krzd4IQ2zNIzGBP4HObi6n4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKubDr6zB/oI1EhH0079wl+uFJOcBVAZOMnV84yJOYBJ+XDfmL3JajQsxjpIxojZt4TgToHaGkr2rI4/sdIeOjwMXr5hAAj1fcjVuxkZF7swDD2LkiY/QV8p/iAnAMVtZO3VMmbxV+qNXsJDzQF9wdQBAOZ95Hh4owodv7/L0nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mUGyHCPE; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=74
	e2ez+NMjSxbCJcFI3DWZZ4H948dIsFZZ+N5kavxho=; b=mUGyHCPEgDfrXMi0jq
	P2CB3/AWyH8hJCzTLolqMhI0e4V4IGviCBt0At2utWdBLd65FOARJWRL4mrtOOY/
	CrakLOCLKCbBxFEtyBNBgi8NAGpwjMfyLR2HY01PNkx664iLsdRP/tI6JAQbqiaT
	kU54I8xefzQvnVO28rXejKLAo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wB3lOX6bSdoVElgBw--.64634S6;
	Sat, 17 May 2025 00:55:25 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	tglx@linutronix.de,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	mahesh@linux.ibm.com
Cc: oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH 4/4] PCI/AER: Trigger kernel panic on recovery failure if aer_panic is set
Date: Sat, 17 May 2025 00:55:18 +0800
Message-Id: <20250516165518.125495-5-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250516165518.125495-1-18255117159@163.com>
References: <20250516165518.125495-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3lOX6bSdoVElgBw--.64634S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFy8JF47WrW3ZF48Ww17Wrg_yoWDurb_Za
	y0vr97JrW0vF95Aa1Yvr15Zryjk3Z2g3y8uw10qFyrJFWayrnFga4DXFyayr98CrsYyFyD
	Awn8Zr1rAr18CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8_cTJUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwlPo2gnaDaNVQABsi

From: Hans Zhang <hans.zhang@cixtech.com>

Modify pcie_do_recovery() to panic the system when device recovery fails
and aer_panic is enabled via kernel command-line. This addresses scenarios
where PCIe link errors cause bus hangs requiring forced reboots.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/pcie/err.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31090770fffc..f0994f66d462 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -271,8 +271,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
 
-	/* TODO: Should kernel panic here? */
-	pci_info(bridge, "device recovery failed\n");
+	if (!pci_aer_panic_enabled())
+		pci_info(bridge, "%s: device recovery failed\n",
+			 pci_name(bridge));
+	else
+		panic("Kernel panic: %s: device recovery failed\n",
+		      pci_name(bridge));
 
 	return status;
 }
-- 
2.25.1


