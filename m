Return-Path: <linux-pci+bounces-42980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F82ACB78D0
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 02:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7AE95300386B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 01:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E582926B0B7;
	Fri, 12 Dec 2025 01:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fCOa2Mey"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m19731115.qiye.163.com (mail-m19731115.qiye.163.com [220.197.31.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C379524DD09
	for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2025 01:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765503535; cv=none; b=TRhtd2qe4aelVsHSA3DOhy6rj3T9COypuzmeSJkLzXRM3pD/jvQY3Lt7WqgCe+FP6jB1B0JNarlDSM1bbfaGlsshTTcY6h5Wtb+YXi+L5aaC4MpmHTH5HAniqLbJNUOluWurceoClgvXemxnYvJSVIgb+Y+Oy4TxR78WTxKXDTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765503535; c=relaxed/simple;
	bh=54YjvT8zadJlH/wUakOlLOjWbxtOOEqmtUDUfFTLCvE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Lfcw6RnmY97/FFDDUtA00UkyoUgZ0NAkIz8NDttLPnpiKC+5fK8GagSss45q/uAyKb2cx2emcmV0IIuQFF8CQMuNU5/qxUPzD6MsdJrJG4WryMEECWF6zpjyxn1nk7Jvpj6tgwtLLxxjIkCriBZxz6Gwfcwm03vTcW6TxIue+NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fCOa2Mey; arc=none smtp.client-ip=220.197.31.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ced0dd3b;
	Fri, 12 Dec 2025 09:33:39 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/2] PCI: dwc: Add L1 Substates context to ltssm_status of debugfs
Date: Fri, 12 Dec 2025 09:33:24 +0800
Message-Id: <1765503205-22184-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9b1031344709cckunm8cda450e102e55
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR8eHlZMH0lJQx9JGhgfTkhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fCOa2MeyETAxpRKmhV6LDnR4bUUDlzZsFIbiLkG5dg168ZnD7bA23o82S7YHhb4BX+UdNwJT6sv09MofoUwMiKphzfBZ9RexaUugL51BTyt3ZOmKwCicfvp890eQFLoQjnOyefJtSNErK9MIRjG/GGh2JaFn7aI03akCWvwUmpY=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=myFdiZSeIHrA4E5OIQehoVWzGwxt0OZArwYqs8UXtI8=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

dwc core couldn't distinguish LTSSM status among L1.0, L1.1 and L1.2.
But the variant driver may implement additional register to tell them
apart. Add two pseudo definitions for variant drivers to translate their
internal L1 Substates for debugfs to show.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2:
- fix the commit log and subject(Bjorn)
- Add space for code comment(Bjorn)

 drivers/pci/controller/dwc/pcie-designware-debugfs.c | 2 ++
 drivers/pci/controller/dwc/pcie-designware.h         | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index 0fbf86c..df98fee 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -485,6 +485,8 @@ static const char *ltssm_status_string(enum dw_pcie_ltssm ltssm)
 	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ1);
 	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ2);
 	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ3);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_1);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_2);
 	default:
 		str = "DW_PCIE_LTSSM_UNKNOWN";
 		break;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 3168595..2526664 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -388,6 +388,10 @@ enum dw_pcie_ltssm {
 	DW_PCIE_LTSSM_RCVRY_EQ2 = 0x22,
 	DW_PCIE_LTSSM_RCVRY_EQ3 = 0x23,
 
+	/* Variant drivers provide pseudo L1 substates from get_ltssm() */
+	DW_PCIE_LTSSM_L1_1 = 0x141,
+	DW_PCIE_LTSSM_L1_2 = 0x142,
+
 	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
 };
 
-- 
2.7.4


