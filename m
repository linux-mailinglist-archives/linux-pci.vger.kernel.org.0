Return-Path: <linux-pci+bounces-25605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6E4A8378E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 05:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64BFA8C0B01
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 03:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE721F0E50;
	Thu, 10 Apr 2025 03:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="c63JWdE+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m32110.qiye.163.com (mail-m32110.qiye.163.com [220.197.32.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033831EF080
	for <linux-pci@vger.kernel.org>; Thu, 10 Apr 2025 03:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744257534; cv=none; b=o4GbokV+fue/v1eZH9VOJ4xMHUgSBUIB+HWTHIRMlNM3s8Jc231tdqci1grrRny2VRF/Xw+k7YkNFAGcvduxcpYvFRHfI834enw8dA/y9ppKXzFVpt2kjCb0LD6rq5x7t0pZ8EODq/x4bXu2r4l2c002JOHQ+61RP8/U97EOIs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744257534; c=relaxed/simple;
	bh=G6SqJ1kHlbG45nw23w+/2pzdCmwoKF71xbqrA2mz8EI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=B4qv8muhelfcovGVz7n5w1x4gZZP0gPcZPS9ZdfBc14TmRMH2mYEhOD5A5x3NA7cBh3R3zakLfenfZKz4GpAnjYl9teh8qLDcbyVh8RiHvZsCNb6JzaoX5DeCmPI5q3z6JOCNWYrbiPLXsBMEq5gdOsDKoEXPsXuKYG7es3nQlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=c63JWdE+; arc=none smtp.client-ip=220.197.32.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 114e5ef60;
	Thu, 10 Apr 2025 09:36:28 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: dw-rockchip: Enable L0S capability
Date: Thu, 10 Apr 2025 09:36:21 +0800
Message-Id: <1744248981-43371-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hJGFZCGk5JSh0ZH0MZGBhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a961d5762ce09cckunm114e5ef60
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OFE6Ogw6KzJMCjIrEVEhMTki
	ETEKCVFVSlVKTE9PSU9DQkNCSENKVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlKS003Bg++
DKIM-Signature:a=rsa-sha256;
	b=c63JWdE+x5s5JZLvoHg6UMPUPNkG7t2QYXgQB4JaJp8bJTb0vlMVsaIk6TTrskzl/DfNzFSKQyKPkdVj489U/TUoNBsSpq+QECm2oWhjcd5L5KbEFIUs+vJ1QeG/gNow95W69MhjxznH7/gg/mI3Lslu630jpF+Q5QMI2GMVdRI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=oN7Fx3ZF2Uu3Okzovtu+9jYiTBMBTahqeqCbWdeeYlU=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

L0S capability isn't enabled on all SoCs by default, so enabling it
in order to make ASPM L0S work on Rockchip platforms. We have been
testing it for quite a long time and the default FTS number provided
by DWC core is broken since it fits only for DWC PHY IP but not for
other types of PHY IP from other vendors.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 21dc99c..56acfea 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -185,6 +185,20 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
 static int rockchip_pcie_start_link(struct dw_pcie *pci)
 {
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
+	u32 cap, lnkcap;
+
+	/* Enable L0S capability for all SoCs */
+	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	if (cap) {
+		/* Default fts number(210) is broken, override it */
+		pci->n_fts[0] = 255; /* Gen1 */
+		pci->n_fts[1] = 255; /* Gen2+ */
+		lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
+		lnkcap |= PCI_EXP_LNKCAP_ASPM_L0S;
+		dw_pcie_dbi_ro_wr_en(pci);
+		dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
+		dw_pcie_dbi_ro_wr_dis(pci);
+	}
 
 	/* Reset device */
 	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
-- 
2.7.4


