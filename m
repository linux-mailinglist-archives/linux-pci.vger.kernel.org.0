Return-Path: <linux-pci+bounces-36451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4AAB87573
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 01:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72FBE3A6451
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 23:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80781DDC2C;
	Thu, 18 Sep 2025 23:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="q4lyQiyt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="C6P9UO8l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C46134BA57;
	Thu, 18 Sep 2025 23:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758237198; cv=none; b=nWWth5o9xliq8nCI5ysni+wTGp0DrWUJ65IP4DQUT7SRFNQj1CBrlMosWH0bm96M0y6t6l3jAF2IwdCDDoWtW4IIZSKWOjs7L+dehlZKpptn+go+pfkwjoSory4KzHVzCi6RkjTb1RALr2uBcgpP0PluaZ8CQYIJVnOLrMJlFE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758237198; c=relaxed/simple;
	bh=Gyr/JBffPV1ZPkyEcG8B3iE+/r/joIUcm6O3ZJNd/U8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dWvQ3xjy15JYt5wXQ0WAF3iq48ex9seMR/vFv1xEKZkwa5PxTYBDTejGYJRgCt1/z2XHvuPHGtwvJFMsT1mKcFIa/FBBNSBla5TxmxRJtu9eq0PIz1u+xRJLkI6wXIKdiRJ1vyXGunkBxQdHlax5k563oN+QpwzJ9uaDUROY6uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=q4lyQiyt; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=C6P9UO8l; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cSWdk1SkPz9sy4;
	Fri, 19 Sep 2025 01:13:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758237194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HHwYFuydEAllyR8DvcvC5Qfv0+3glfnx/nv1DoqMAfc=;
	b=q4lyQiytl6VO8P28QSTiXnL0T/aeqafKr71K+kWqrGoqTb/cXS2uKOZ5cyAI8JjKvcGVX3
	Nm7r4PzppwR7FkvK5Bur54o+uuqQB40+oX5jm7J4AEd3asQx5ES9lMif+da6yrz3KtTMI3
	ahUX2W5oZd0eUGDTkILeezlrGSZXpA6g67572M/L4KEskhJdAsw6P0tAgT/HTHdGUyEf4R
	2wTEZbDrP8Qy/E6LLArUVFDjdCS2Bk08m2gECNGn+i1Ms8SdZDVIxqYETvklay8LLkxmbX
	wOGhcX0XN3A9ZwW8dRPa7ksseZkQ6ZBoicVeqithd3SxbGtzlsqcMYHpGt5wag==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758237192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HHwYFuydEAllyR8DvcvC5Qfv0+3glfnx/nv1DoqMAfc=;
	b=C6P9UO8l9ReuHt5DPxMh9v4k2JYfN4hjHyUyNFxkM1PuGXyhWj8iT3fnHku/XcjIGn9nYo
	qgD/pGnBUBXzOOoawswahFcPRyAfsyws1zrHTd/KWGd2wHrzFhVsMHvF+UB+AYbFD9exeP
	S3OIioVdx1kEzW4BxozxStbuaatAD2EqllVMGEEdcHUsKEyPJ15JgJz0geqOGjWRfoPoex
	iYrsQAOqxvTuze5Olgldwk84GJoTrlrKOePT3QRmyPzZjIOjXi/ZYJLScrr9hyPzyeTW1H
	IzVhYCe2dXy2u3jOPMU2eVGB4pqfMzuXxUfJ6bzbI+BBvnquDPHw/jPx04hBPA==
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
Subject: [PATCH v2] PCI: rcar-gen4: Add missing 1ms delay after PWR reset assertion
Date: Fri, 19 Sep 2025 01:12:06 +0200
Message-ID: <20250918231253.189906-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c6d5611ac5cd729567b
X-MBO-RS-META: zrdxuq6ryubrww47ecmbkjfetwmghqji

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
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index de9fe2ed2423d..db2d30fb5d904 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -182,8 +182,10 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 		return ret;
 	}
 
-	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
+	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
 		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
+		fsleep(1000);
+	}
 
 	val = readl(rcar->base + PCIEMSR0);
 	if (rcar->drvdata->mode == DW_PCIE_RC_TYPE) {
-- 
2.51.0


