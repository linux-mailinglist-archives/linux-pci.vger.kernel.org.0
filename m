Return-Path: <linux-pci+bounces-18090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3674E9EC566
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 08:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50FA164289
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 07:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309DA1C5CBB;
	Wed, 11 Dec 2024 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="LeAzOnTS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m12779.qiye.163.com (mail-m12779.qiye.163.com [115.236.127.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F871BEF75
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 07:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733901236; cv=none; b=K74oKtPKZrTmqnARMt07C0/874ViuoL5yUkOlssWxRcB1ouIlsIAEMViW1J8PgbYVktbibBSGTUNxff311gGVyFlt9JfC9TlefqLV2WFV+EE2KprvTe2UmveAjzv1f/AV31fwqS7NBd2+vX21qiogJT15jlPYMV9+SgHBkySXoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733901236; c=relaxed/simple;
	bh=sJJ2HEtml+S2rTtF0THNeKsPBiYfDfw+rmo9cHnhQek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EDepsdb6LCASFo0YuusdS4UgQ0lRYAGvejcEAybun1C0vnQHd42p6CNpfIJ6ZWGvKzjjlabkKLLAEdukyNqGjRGpDURg041fO81D6UQsmmUnqZt4NKg+4YPZ8bMK6rgtc+W9355T089fqwiN8Rs36XGMMZxtxGYUOFbi51d9EyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=LeAzOnTS; arc=none smtp.client-ip=115.236.127.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5634f407;
	Wed, 11 Dec 2024 14:58:26 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/2] perf/dwc_pcie: Add support for Rockchip SoCs
Date: Wed, 11 Dec 2024 14:58:13 +0800
Message-Id: <1733900293-169419-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1733900293-169419-1-git-send-email-shawn.lin@rock-chips.com>
References: <1733900293-169419-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk5PGFZPQhhPT0NOQx8aTkpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a93b483080409cckunm5634f407
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxg6Thw*DTIXLjI8CD8LOBYo
	Ei0KFEhVSlVKTEhIQktLSEtMTEpLVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlOSEI3Bg++
DKIM-Signature:a=rsa-sha256;
	b=LeAzOnTS8vBdq+Q2Zb4zwJTntOzUPS7K3A8uGfWpE85T1xLHzvUgxHwulDiMSiBps4H2fi1ydyLijQWYPcT4Anqwh9fJEJn/AZigtam0a7KRLOkB2cUGgtukkZXTMGZEU+cZdWJ7mtLFGWSDap5T072ZhHuj9cSth+D4F9kqNMM=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=HnVsxA4UNvOmTwE3OXn/RuPvwFuGnbkJFWNI6/fiDk0=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add support for Rockchip SoCs by adding vendor ID to the vendor list.
And fix the lane-event based enable/disable/read process which is slightly
different on Rockchip SoCs, by checking vendor ID.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2:
- rebase on Bejorn's new patch: https://patchwork.kernel.org/project/linux-pci/patch/20241209222938.3219364-1-helgaas@kernel.org/

 drivers/perf/dwc_pcie_pmu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index d022f49..ba6d5116 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -116,6 +116,8 @@ static const struct dwc_pcie_pmu_vsec_id dwc_pcie_pmu_vsec_ids[] = {
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{ .vendor_id = PCI_VENDOR_ID_QCOM,
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_ROCKCHIP,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{} /* terminator */
 };
 
@@ -264,12 +266,27 @@ static const struct attribute_group *dwc_pcie_attr_groups[] = {
 	NULL
 };
 
+static void dwc_pcie_pmu_lane_event_enable_for_rk(struct pci_dev *pdev,
+						  u16 ras_des_offset,
+						  bool enable)
+{
+	if (enable)
+		pci_write_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
+				DWC_PCIE_CNT_ENABLE | DWC_PCIE_PER_EVENT_ON);
+	else
+		pci_clear_and_set_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
+				DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_ON);
+}
+
 static void dwc_pcie_pmu_lane_event_enable(struct dwc_pcie_pmu *pcie_pmu,
 					   bool enable)
 {
 	struct pci_dev *pdev = pcie_pmu->pdev;
 	u16 ras_des_offset = pcie_pmu->ras_des_offset;
 
+	if (pdev->vendor == PCI_VENDOR_ID_ROCKCHIP)
+		return dwc_pcie_pmu_lane_event_enable_for_rk(pdev, ras_des_offset, enable);
+
 	if (enable)
 		pci_clear_and_set_config_dword(pdev,
 					ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
@@ -295,9 +312,14 @@ static u64 dwc_pcie_pmu_read_lane_event_counter(struct perf_event *event)
 {
 	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
 	struct pci_dev *pdev = pcie_pmu->pdev;
+	int event_id = DWC_PCIE_EVENT_ID(event);
 	u16 ras_des_offset = pcie_pmu->ras_des_offset;
 	u32 val;
 
+	if (pdev->vendor == PCI_VENDOR_ID_ROCKCHIP)
+		pci_write_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
+				       event_id << 16);
+
 	pci_read_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_DATA, &val);
 
 	return val;
-- 
2.7.4


