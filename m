Return-Path: <linux-pci+bounces-18083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC719EC28C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 03:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A097281E38
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 02:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44561FCCF5;
	Wed, 11 Dec 2024 02:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XuHNFvBt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m60107.netease.com (mail-m60107.netease.com [210.79.60.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB01B1FDE03
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 02:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733885624; cv=none; b=tSqPLBAs767+2n6FUebBoBcLb8c9hhcMkdQ37hIF5e4FZ7JTk1eXP1Cwb4o45Mp5o3WKeE8DnpjN1k7nYBaWAOQfv55V+hKZMWTa8NlmyrwokdvgodiTVFk8U6sYEo8fDGIYOsCL/sUO4XRsAQyn6EXBxT7DFH/oQrVeqEt7zRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733885624; c=relaxed/simple;
	bh=x8SO74fJb4PpwDazpfdzRqEVxnc+RNW9w806Q0PTTtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Bm4jPJz0a+i3PO6/quFXru/yraEpBEgKEUrcTM0ofAwTMx9FzE2WQ+YH2bMzeZHnpFP3mcV5fbKuS89pn6dPXCFyzmmMgG9hUXAh0kLttM4wKskXUBVxNfhJuvKmbBQUxNGXxvy0NPhbo0U8/nA28KiWV5Zvfbjq+bdIK4ydAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XuHNFvBt; arc=none smtp.client-ip=210.79.60.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 55b785c4;
	Wed, 11 Dec 2024 10:53:31 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] perf/dwc_pcie: Add support for Rockchip SoCs
Date: Wed, 11 Dec 2024 10:53:18 +0800
Message-Id: <1733885598-107771-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1733885598-107771-1-git-send-email-shawn.lin@rock-chips.com>
References: <1733885598-107771-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh1OGVZDGE1NQkxOSRkZTklWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a93b3a2ce1c09cckunm55b785c4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OD46GSo*EDIUDDM2Ig0KOAkq
	SzFPCwFVSlVKTEhIQ0NOTUpJT0JDVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlITUs3Bg++
DKIM-Signature:a=rsa-sha256;
	b=XuHNFvBt51b538dTPARTwQBFaIzY5e+hcu2Wh3VkAWsfYZk262+xnOj+gz8JY4nPwQJXkV+szavCSMwf1LF0Wa98uSphkNV15uxHAbcZx7Cq9HbH/kKkqNoL8zqahawEl7BjIkpCGIQBE2i9yfTludmnkjFVkfhVQpNl9lCk88U=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=7qmQhvZmQiM/quzTTe8aJ+NM05DrQgWeCx4JLMkCviM=;
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

 drivers/perf/dwc_pcie_pmu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 9cbea96..b3276b8 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -108,6 +108,7 @@ static const struct dwc_pcie_vendor_id dwc_pcie_vendor_ids[] = {
 	{.vendor_id = PCI_VENDOR_ID_ALIBABA },
 	{.vendor_id = PCI_VENDOR_ID_AMPERE },
 	{.vendor_id = PCI_VENDOR_ID_QCOM },
+	{.vendor_id = PCI_VENDOR_ID_ROCKCHIP },
 	{} /* terminator */
 };
 
@@ -256,12 +257,27 @@ static const struct attribute_group *dwc_pcie_attr_groups[] = {
 	NULL
 };
 
+static void dwc_pcie_pmu_lane_event_enable_for_rk(struct pci_dev *pdev,
+						  u16 ras_des_offset,
+						  bool enable)
+{
+	if (enable)
+		pci_write_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
+				       DWC_PCIE_CNT_ENABLE | DWC_PCIE_PER_EVENT_ON);
+	else
+		pci_clear_and_set_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
+				       DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_ON);
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
@@ -287,9 +303,14 @@ static u64 dwc_pcie_pmu_read_lane_event_counter(struct perf_event *event)
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


