Return-Path: <linux-pci+bounces-27291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC771AACC47
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 19:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38131B61323
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFAF2857CA;
	Tue,  6 May 2025 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fwJNIuGv"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC07E285407;
	Tue,  6 May 2025 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552953; cv=none; b=pw/jyIgLZkGHM69BvuRqI9087QnBqBs99L/zoVaoI/QXj5SB2kUiQ7WLPw8nUo3S5ofI3YFy86iCWFQ9cNyZZZwyChTx108VrTuB1Mi/twLwYTjJFGYHAsK5AeqShaOvm+rTzttodAFUb5JfoUwGj4vXrS64UbWEtRVMAe/kqjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552953; c=relaxed/simple;
	bh=6PpeytAq0ZIKuJp8mHxX/IX4SA59S0aTD3J/khpCVBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sfUDeG9negQXvM5d/QtRq3LSMOsw4SVtBenKWWXa0RqpR7eve9UHG7adTLSMyfNlJ2TxrvVY/O8+eyByXOcTSMY+TB7679FnKTUh5In0VM7vKKR8W87q+0yPKifoZgKDH2Bi9T8BQB8QXmwxAvvii1czrsoNBPt4Av5iNFcEiI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fwJNIuGv; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fhcsu
	unrHkitcMq06j2dmcMWJJ4ZWepHigEVMlm5Ntc=; b=fwJNIuGvotdgzmFf5WEWY
	JVCiZ1xHK5eZxGb3NshUF4fsNCa3MLCjYHdfJosbPj0Q+XnmEqb64o2gCmefFxAj
	rjbqWOncap4VArENcJX2E6CzZxQAKRhJwysOX2saxVITpsLzrCdR8TZiMk1P37k4
	XRQsDGF5G6JifXIc4o6MIg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAX_U4ySBpoVmZeEw--.15363S5;
	Wed, 07 May 2025 01:34:46 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de,
	manivannan.sadhasivam@linaro.org,
	yue.wang@Amlogic.com
Cc: pali@kernel.org,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 3/3] PCI: aardvark: Remove redundant MPS configuration
Date: Wed,  7 May 2025 01:34:39 +0800
Message-Id: <20250506173439.292460-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250506173439.292460-1-18255117159@163.com>
References: <20250506173439.292460-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAX_U4ySBpoVmZeEw--.15363S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr47trWUAFWUCF43Gr4kJFb_yoW8Xry8pF
	9xXF4xtF4ftr15u3ZrA3WkKry3JasFkFy5W398W3yfZF9xtryUGFyayryrAayxJr4kGFyj
	y34YyrWFy3W3twUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UeGQDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhVFo2gaREltogAAs5

The Aardvark PCIe controller enforces a fixed 512B payload size via
PCI_EXP_DEVCTL_PAYLOAD_512B, overriding hardware capabilities and PCIe
core negotiations.

Remove explicit MPS overrides (PCI_EXP_DEVCTL_PAYLOAD and
PCI_EXP_DEVCTL_PAYLOAD_512B). MPS is now determined by the PCI core
during device initialization, leveraging root port configurations and
device-specific capabilities.

Aligning Aardvark with the unified MPS framework ensures consistency,
avoids artificial constraints, and allows the hardware to operate at
its maximum supported payload size while adhering to PCIe specifications.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pci-aardvark.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index a29796cce420..d8852892994a 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -549,9 +549,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
 	reg &= ~PCI_EXP_DEVCTL_RELAX_EN;
 	reg &= ~PCI_EXP_DEVCTL_NOSNOOP_EN;
-	reg &= ~PCI_EXP_DEVCTL_PAYLOAD;
 	reg &= ~PCI_EXP_DEVCTL_READRQ;
-	reg |= PCI_EXP_DEVCTL_PAYLOAD_512B;
 	reg |= PCI_EXP_DEVCTL_READRQ_512B;
 	advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
 
-- 
2.25.1


