Return-Path: <linux-pci+bounces-40446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C341FC39060
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 04:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FCC189E9C7
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 03:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E10019E96D;
	Thu,  6 Nov 2025 03:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="LcNe6dPc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m93109.xmail.ntesmail.com (mail-m93109.xmail.ntesmail.com [103.126.93.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48DE18EAB
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 03:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.93.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762401136; cv=none; b=Gcy+tbyKEgAWdTLp4+DW/X4Vv9DugyXHSXsnvUtDwMUuVxNz90sW1mQAJu4k1oerrAdpCSwTnI5AqCQTg1YKfKPsq7mgEUwT+tHLxXHZdGTCJlmPc10xBa0lJMEcIQOn7tG8bU0LgmV0SUaLABsECF6IBxZedLyljzVBzeWpOag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762401136; c=relaxed/simple;
	bh=QdZfKLLaUCQarMI0wQTS8FPrv7+yrx7V4IJeOY7frRE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qlR/ONse69pIfFhxOtCVnuwM51YaSdByzdAL6cHkOXnHv/QwdkxV1qd5/WahJu2mQTNQXGMz/9yByScRnZSe+MJ1B5cYutJbYUUlGirt2TRKCsLf79UedoLKHww67hLGt87HComq/NzT2s9gFwWMqCoevNHPZnKxpEBOtUpQPo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=LcNe6dPc; arc=none smtp.client-ip=103.126.93.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28958a74a;
	Thu, 6 Nov 2025 11:52:02 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: Add ASPM quirk for Hi1105 PCIe Wi-Fi
Date: Thu,  6 Nov 2025 11:51:59 +0800
Message-Id: <1762401119-232631-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9a574af90209cckunmc10c5b4edfd220
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhodTVZDSk4eGhkZThoaS0hWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpMTU
	1VSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=LcNe6dPcznv0ogN4jyV/P9T2o5haKihe5jZHNhyKEPuUZsUwXE/FIlnRddS+LKvRbsq9oqMZg5ptwkPiJP+i6fjtDvi81WH50CjdpOlaDmWBSuq8GSeW9VYRfUo1j7foxvq+X9riL2Wklrns12V57FhmJso1CXEU90la1SxkVvo=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=KXVfLfjQl7Jc2uWt/iluuVv1/POOyLkrkqzuVKsR3Bg=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

This Wi-Fi advertises the L0s and L1 capabilities but actually
it doesn't support them. This's comfirmed by Hisilicon team in
actual productization.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 214ed06..67250d4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2526,6 +2526,12 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
 
 /*
+ * The Hi1105 PCIe Wi-Fi doesn't support L0s and L1 but advertise the capability.
+ * Disable both L0s and L1 for now.
+ */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1);
+
+/*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
  * Link bit cleared after starting the link retrain process to allow this
  * process to finish.
-- 
2.7.4


