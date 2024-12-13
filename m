Return-Path: <linux-pci+bounces-18355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E059F0505
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 07:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A26161230
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 06:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C1818CC08;
	Fri, 13 Dec 2024 06:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ClVzhtY3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m1973189.qiye.163.com (mail-m1973189.qiye.163.com [220.197.31.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B1D18C03B
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734072456; cv=none; b=OKYXfK0CZsrwdDSG6FCIk5JkcM4ZM6nGppXJN/oldWjD+cucA+kOpVgG8Cu6zme/FEiiOR36c8Ms76LOpqBZi/lyYUV5zLpx2j1HozKFpbmTiiIzstLoV6cClOSxazn4G8cllM268Tl7I0OM+TxJQyyn12nFqxdgkbHfZ08Xm8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734072456; c=relaxed/simple;
	bh=PfFBxxqBsrfSTPD05tZ98ztyI/YLGrFgtqa+ZxVUFjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TKXHxn7Likzjk14kfZnynZpsOBFE/JlNJDtsuT2/losS93CTOvS9u9NUnPo+uVbhxwas3rnWxfwC3w8z2D2xbXToks3zy4WK8Y8L8wdRs/BqcyKxJI2XmdMu2kPaEccj79Z5yDS2/k0TFh8NMO47a1VlTrJ/XbBjfO9UmTna75w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ClVzhtY3; arc=none smtp.client-ip=220.197.31.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 59d5a5dd;
	Fri, 13 Dec 2024 12:25:03 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 2/2] perf/dwc_pcie: Add support for Rockchip SoCs
Date: Fri, 13 Dec 2024 12:24:03 +0800
Message-Id: <1734063843-188144-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1734063843-188144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1734063843-188144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0MaT1ZOT09LGEIYGR1DQkhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCS0
	NVSktLVUpCWQY+
X-HM-Tid: 0a93be4352e409cckunm59d5a5dd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MT46NDo*IzIWSSgeOksIQxIL
	GkIwCT1VSlVKTEhPS01IQktPSE9PVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlOSk43Bg++
DKIM-Signature:a=rsa-sha256;
	b=ClVzhtY3Z3mh8wYBSeZJbJo20gPm9FFsLjh62S17Yn/Ymh9g9Yn4iuE6Gysag15Z65H0qdi5JUARUZPlhDUFK18MS4BiLliH8LE9q06wWa2z6wJ0ypmBYbuLmoz28EgI62cu1URsxrMFW4MOBB1tNFyvc/aAB/6kuWzmu3cCkTQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Cshq1RwCXcGI6mKIyJp7j0jn9Uct0z6UaFLXnK3Sd5Y=;
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

Changes in v3: None
Changes in v2:
- rebase on Bejorn's new patch about Qualifing VSEC Capability by Vendor, Revision

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


