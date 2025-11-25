Return-Path: <linux-pci+bounces-42003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F127C830E8
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 02:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A44EB349FF5
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 01:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECFA86348;
	Tue, 25 Nov 2025 01:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Ltr4dsMh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49228.qiye.163.com (mail-m49228.qiye.163.com [45.254.49.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C166C189BB6
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764035961; cv=none; b=EQ0G5AjD/9Zbue7pzwXyhsonqh57D/Pmm4p0XZ2mLYDV/GFiA0o4YdmR/NlahPEVgiUIWSb41oPViJIL9OUmm688/VT3m07KWIfYPh+/Ibo0CVME/PuR6Y9PFCgDtQP3Udp9b6AbePWIeqm3X+cvHyOnXKyew0xS0dDy+KzsYKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764035961; c=relaxed/simple;
	bh=aHQTH9QFNGCxch0bBzDSaqqfhTYGGew0JbSDCbyFO9Y=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mk3z5aT59ccTfvnSQsnzKuYb8tw826brajTbvyrRo7bXTDlGveK+vyBZLOwB1kYxY/aXwPUeq5cr4FYVvulCHCb3Q/hIgAeQHVX2Ykfx2uFhJlWgKM/An2wUPeGw0Db8gjUfP1YRgN3yaeQ230SknH4uVGdYGE171Rz3cuMnYO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Ltr4dsMh; arc=none smtp.client-ip=45.254.49.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ac10622e;
	Tue, 25 Nov 2025 09:54:05 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/2] PCI: dwc: Add L1ss context to ltssm_status of debugfs
Date: Tue, 25 Nov 2025 09:53:51 +0800
Message-Id: <1764035632-180821-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9ab8b7cf3409cckunmc92cec9842edfc
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJIS1ZCGUoYSxpLSR9CTk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
	pVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Ltr4dsMh8wI/9sc7SmWE51Rge2BjwPSYVnyJWwUwPnGuhe+ntzNajECvRd5KVOPdNZ+AP2VVqOPydgMe61nAmuUlUx6WH1xGxncfnJZXj3il3qiFkVttcedopDr/lcJYAJl5iHg4htAp6aXjHA46YaH+5k2r2ptJf7TmkrmJ6i4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=gnPCKZrubDiKp9Ce3hoVnypxFgyrp1MpSGv7XHiWqo8=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

dwc core couldn't distinguish ltssm status among L1.0, L1.1 and L1.2.
But the variant driver may implement additional register to tell them
apart. So this patch adds two pseudo definitions for variant drivers to
transltae their internal L1 substates for debugfs to show.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
This patch is based on latest pci controller/dwc branch given that L1ss support
for Rockchip has been applied.

 drivers/pci/controller/dwc/pcie-designware-debugfs.c | 2 ++
 drivers/pci/controller/dwc/pcie-designware.h         | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index 0fbf86c0b97e..df98fee69892 100644
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
index d3dc0cd8e7b5..3f4611882e29 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -380,6 +380,10 @@ enum dw_pcie_ltssm {
 	DW_PCIE_LTSSM_RCVRY_EQ2 = 0x22,
 	DW_PCIE_LTSSM_RCVRY_EQ3 = 0x23,
 
+	/* Variant drivers provide pseudo L1 substates from get_ltssm()*/
+	DW_PCIE_LTSSM_L1_1 = 0x141,
+	DW_PCIE_LTSSM_L1_2 = 0x142,
+
 	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
 };
 
-- 
2.43.0


