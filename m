Return-Path: <linux-pci+bounces-36478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08824B89BB1
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 15:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F8F17B4741
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 13:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDA41A76D4;
	Fri, 19 Sep 2025 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ATDs2My8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wRBRjrFT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614341DA3D;
	Fri, 19 Sep 2025 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758289635; cv=none; b=HfbT3fU9iNQudqupsG9IfBXrBS5lfxERtbCSZfw/dT9qMGHSM3/RANm3v2kUpu37Kc87GRzsOjh3SthnDyjw1Cs1Ydnnq78JrQWM2lKiolvYdkNI631mDU/p9d685sqx28Gvc36CHz2tUsPwf0tUE2yF90TqKhjseTecV+sSHks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758289635; c=relaxed/simple;
	bh=aH6L4G/60p2P3FLde7vOeojz/Mt8xQ2K4lRb+bjD7Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aAVjNYVlMLDevDohiaVecKa9j3hhQRQ2cih6hWiY5euXsJEhQ4jN611ZmV6hqtrbNe9YisHsRtPP56VFsQHbc6Ebzcpq6c8NaMX34rlDy0NRgEtBo0rnKD/DVBridutWebvTroSaspSQU7gZLi3a6qMqn4rZw6ABrQGvNmoq9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ATDs2My8; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wRBRjrFT; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cSv205hRlz9v4J;
	Fri, 19 Sep 2025 15:47:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758289624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xmZYWnx9iIgiCPdAdawd8OWCusZtxTTim84ckmIyVvk=;
	b=ATDs2My82ZETIqFjxQQaZZbz3m1aCfdPtn7ehr9SAPqtV4rzwY/4ODbZmhyhyPH8PTsmgR
	eXBgL439I+pb15LA3SgxF83nYgiKtwSWNUh3x6BK14xaQMWM7JXhMB2gftmaaE3lsgylkz
	WCDh6sAQqOp6NtjXJLrNUWRRYmJu6WlX0YNJXObRymu4H176w0jQs9DHke1yCNr/3q7Pza
	y39bWCiUWcEwgexXBOby5F1jhTZHSxTi99r87uwiCHdLXDQgpeiEzYmsKoM74QZ+n/5/5W
	PDzghC3BNHOsGlz+bnoEldd9q+NiLFKCPGbWRNZWAp4CUYHzwG/v99XuZFM2Zg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758289622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xmZYWnx9iIgiCPdAdawd8OWCusZtxTTim84ckmIyVvk=;
	b=wRBRjrFTOSqHNXy/YIN2q5r7OLpHrc1s/BZQZcSq/zGQpvMlW6TW6TAxSlSffwm1u44bwU
	JpIhqMef0a/fyckXLY0JYjO2zmqiNLbrR4ByO8+rbCbFlOD4zFrIK/j3ApPkkX6wzE9ClG
	+wTn3G0LdLBT348wbrleC7XQKaFEtl+9m0lTCJoxtGACITSA0cVPnuV97KP2n6F8n0WpQg
	Ch+OfWTwIFge8GwzAnRcIZ8GUfbNgn0fFXU6pdR8F5uu4FPMgawhVwIQ7Uu5FLdBiWIans
	rWn6ITRACZIjllbHuqPJtr4gEu6aM4dYRKwQcj1kQAIqX76nD5dqagRCh05k9w==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3] PCI: rcar-gen4: Add missing 1ms delay after PWR reset assertion
Date: Fri, 19 Sep 2025 15:45:58 +0200
Message-ID: <20250919134644.208098-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tkaaag5fh64en17kbo53esy8es1arnoq
X-MBO-RS-ID: 72214c4ba77247bbe17

R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 585
Figure 9.3.2 Software Reset flow (B) indicates that for peripherals in HSC
domain, after reset has been asserted by writing a matching reset bit into
register SRCR, it is mandatory to wait 1ms.

Because it is the controller driver which can determine whether or not the
controller is in HSC domain based on its compatible string, add the missing
delay into the controller driver.

This 1ms delay is documented on R-Car V4H and V4M, it is currently unclear
whether S4 is affected as well. This patch does apply the extra delay on
R-Car S4 as well.

Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: Use fsleep() instead of usleep_range()
V3: Add comment over the fsleep() clarifying its purpose
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index de9fe2ed2423d..365dff6fe7f8f 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -182,8 +182,16 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 		return ret;
 	}
 
-	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
+	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
 		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
+		/*
+		 * R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 585
+		 * Figure 9.3.2 Software Reset flow (B) indicates that for peripherals in HSC
+		 * domain, after reset has been asserted by writing a matching reset bit into
+		 * register SRCR, it is mandatory to wait 1ms.
+		 */
+		fsleep(1000);
+	}
 
 	val = readl(rcar->base + PCIEMSR0);
 	if (rcar->drvdata->mode == DW_PCIE_RC_TYPE) {
-- 
2.51.0


