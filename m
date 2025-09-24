Return-Path: <linux-pci+bounces-36825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A204B97F47
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 02:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D171AE1E14
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 00:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DA11C6FF4;
	Wed, 24 Sep 2025 00:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fD5eA8y8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="POK553pa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88B4317D;
	Wed, 24 Sep 2025 00:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758675400; cv=none; b=lGT1f38fMHNapNggOeJjBf2FUGGZit31kPwrCWsXlUyNAgZ3c/L/QLowVFio7MDmt80EsNXz3sxBwR58QPk3BzHbVobldgjnBlrUl8cI6ppzLD3hZ8Iwnm/7UPXZkDpy48VShcr82Tcfie/y4rK+zHffeW98wxO3aYXhVpNuxfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758675400; c=relaxed/simple;
	bh=h5B4nVDBKkIOt/SYkUqB08hyKfyqHezEC6iHC/y7nIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n18ZecgWT8mUvGmJklAF4qq69jhrtW65L1v1CosJ2+3iTvq0PapJpazmhK2GhwsNYc7tJis5uBse4w5F+GpZ0dpu4zBEost0Cbw92Qefg4ivtOXiUup1mvq54//5TzX3mTHCZOAguU4CgVS6rAghmINCT/HFk4tggZ4mOPlZpJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fD5eA8y8; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=POK553pa; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cWdhh3BBPz9srM;
	Wed, 24 Sep 2025 02:56:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758675396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rn/0FMRPcDVRztYJQXYHmmt13ZYGQUVJTDZXjxtKcSU=;
	b=fD5eA8y8m5zU99AmYz86mPzWr9Kg4viqwePDKh8GT4o9UcVTssZsnceqr2b0UPTszZMbZk
	6bYlVdlx3S27Qoe6bJtFuSWfWh3v9J3wwTsVf70Q5NwLX+rBBPxLL447cFh+h1PFnYkDtM
	ka62FczFl33uo7bLgR6IVdfnEyvMwhSZa21nU9GpmccxxkXdbCmu/gI4tL5ivcVe248U/p
	NXC+c+1/eEZOY8Meg2Wgn/Qy3efkmydLq0U9Tbnk5EwYB1C4jjHYYFsVRPaBTLXH0X5rgU
	pCmgOrmeb640W2iFfcfelNVzbMiLs3VAZKNX7Q1FupsWFoeOXk5oAX8vJVZwFg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758675394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rn/0FMRPcDVRztYJQXYHmmt13ZYGQUVJTDZXjxtKcSU=;
	b=POK553paPx6ow2DEhNXDeXKL2wUvmbR3RR1ffr8JGNHPwk2+K8UzxHpPNhhdah1tFW5I5t
	NSe2UhD4D1v7Ebvtf1k3RKtQnbQAgG3uuV6L11AC1xTyQHVdk1Gk+0QXshfJlZ1oTBcJqY
	ufK62zF94p6HZzMHYuDET6ocb9WPdMnGk6C1451QN3THAFvrDxp+WftPFBROQklRI/mtAk
	Eyh5324OoWQUFv/Unw1MrTg2fJzNVhT3FsfErYLOUsqfhAy4DyFH3NVsE7BbcIsjvUAW8J
	eOi7BZjuueuIe1LjXHH1p749/glfisZ1CvReFSGmfK+y3boME9Yr0RL/FB5F/w==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar-gen4: Assure reset occurs before DBI access
Date: Wed, 24 Sep 2025 02:55:45 +0200
Message-ID: <20250924005610.96484-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ruqytg5uht7js9ojxyoyqr3m5pg49pmg
X-MBO-RS-ID: a0412bb6b45355fdb66

Assure the reset is latched and the core is ready for DBI access.
On R-Car V4H, the PCIe reset is asynchronized and does not take
effect immediately, but needs a short time to complete. In case
DBI access happens in that short time, that access generates an
SError. Make sure that condition can never happen, read back the
state of the reset which should turn the asynchronized reset into
synchronized one, and wait a little over 1ms to add additional
safety margin.

Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
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
NOTE: This fix could be removed once the matching fix lands in linux-clk
      https://patchwork.kernel.org/project/linux-clk/patch/20250922162113.113223-1-marek.vasut+renesas@mailbox.org/
      This fix is implemented to assure PCIe is not broken in case the
      fix sent to linux-clk is applied asynchronized.
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 365dff6fe7f8f..dd74e46f13933 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -212,6 +212,19 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	if (ret)
 		goto err_unprepare;
 
+	/*
+	 * Assure the reset is latched and the core is ready for DBI access.
+	 * On R-Car V4H, the PCIe reset is asynchronized and does not take
+	 * effect immediately, but needs a short time to complete. In case
+	 * DBI access happens in that short time, that access generates an
+	 * SError. Make sure that condition can never happen, read back the
+	 * state of the reset which should turn the asynchronized reset into
+	 * synchronized one, and wait a little over 1ms to add additional
+	 * safety margin.
+	 */
+	reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
+	fsleep(1000);
+
 	if (rcar->drvdata->additional_common_init)
 		rcar->drvdata->additional_common_init(rcar);
 
-- 
2.51.0


