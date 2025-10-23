Return-Path: <linux-pci+bounces-39071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D171BFEF58
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 04:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74DA3A3AA6
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 02:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A98175BF;
	Thu, 23 Oct 2025 02:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="GmHy1OFh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3272.qiye.163.com (mail-m3272.qiye.163.com [220.197.32.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625372147FB
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 02:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761187913; cv=none; b=B7xD9WGyqbjKHCeiLueN45/KS0b6RIS8Fe6tm4PZN0bwSMZNhLewZfyxtv0YaLNlEO2gFgWvcCCOLj2/sAlRhOPdUky9j/Naw+y8eISSFU4RithAJRQzWC03sjFt4vYuAnz1YdYskfDfSeKSPuJoZWZFgzcy6Cgl55/mjY8mJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761187913; c=relaxed/simple;
	bh=69c0E6gygIEA3re/++luWNCa2xNUHUf2qk1JUzMhsNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WVgg6Ml/QVXfrrI+zmlvtQILOUztf2fg2HuI6pRC/X4i9Ejmgo1eQ5l+xZ6Vos3k31rbSGEr0xpGev+lFqJ/Dn9UIsoFCYreHnluVB+G9wwPaMeIkOkin0APO1kRfqwksPnqEaFD9BNM0oeHtYyYXF3xW6WBDv/OnifIQHxRoHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=GmHy1OFh; arc=none smtp.client-ip=220.197.32.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26dfa2410;
	Thu, 23 Oct 2025 10:51:37 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 2/2] arm64: dts: rockchip: Add PCIe clkreq stuff for RK3588 EVB1
Date: Thu, 23 Oct 2025 10:51:23 +0800
Message-Id: <1761187883-150120-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1761187883-150120-1-git-send-email-shawn.lin@rock-chips.com>
References: <1761187883-150120-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9a0efaa25c09cckunme7ff00708b36de
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUpCGFYaShkZGhlJSkJOTBpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=GmHy1OFhYzp3WpYB4ykv47pjz75+4p50sDMDRbgqI1HaQ0vnAGNTppQbkfOk44SZD7+71MYB9fgKrP1iceznBrkb5EIyZKB8NPPHtpfIPtZfXAuEZapxrB/+VOOX1MXkGLip/n7FVNnGq0kZUR/dVxzBvwxJFBjzm7JxoDI9TKI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=7dkBKVPD2kIXYX8+Kh9LsW0IxyCpICzSzCk1UxY/pHg=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add supports-clkreq and pinmux for PCIe ASPM L1 substates.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Hans Zhang <hans.zhang@cixtech.com>
---

Changes in v3:
- add Hans' tag

Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index ff1ba5e..c9d284c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -522,6 +522,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie2_0_rst>, <&pcie2_0_wake>, <&pcie2_0_clkreq>, <&wifi_host_wake_irq>;
 	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
+	supports-clkreq;
 	vpcie3v3-supply = <&vcc3v3_wlan>;
 	status = "okay";
 
@@ -545,7 +546,8 @@
 &pcie2x1l1 {
 	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie2_1_rst>, <&rtl8111_isolate>;
+	pinctrl-0 = <&pcie2_1_rst>, <&rtl8111_isolate>, <&pcie30x1m1_1_clkreqn>;
+	supports-clkreq;
 	status = "okay";
 };
 
@@ -555,7 +557,8 @@
 
 &pcie3x4 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie3_reset>;
+	pinctrl-0 = <&pcie3_reset>, <&pcie30x4m1_clkreqn>;
+	supports-clkreq;
 	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie30>;
 	status = "okay";
-- 
2.7.4


