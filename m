Return-Path: <linux-pci+bounces-35624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A607EB4829E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 04:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606D717C3EF
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 02:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375C919E967;
	Mon,  8 Sep 2025 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b="GfIh0b05"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo-csw.securemx.jp (mo-csw1800.securemx.jp [210.130.202.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCD5AD51;
	Mon,  8 Sep 2025 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757298876; cv=none; b=H4QaALfHzLABVdlsy4p7h3lFkkmSskW5kNv3AjUtY+CqkDg4kxBnm/Oy+xzulhWfU6epGEvJkEHuOXJ9mm5rEqt8EvBCCmnMKAt5oGxivZxIBNBAF9Tvj46Ikz87gTOvGvvGNQaCSOSOIDTPSvaDhT7K7DBmnqQVCp76H+YopW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757298876; c=relaxed/simple;
	bh=Cn+UFmnrahnXPfI/xFTC/Llrkc3SwpQ8AAggw6a+87s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YkdsQJG1B9sU/IM59F3NR/CsApPtnltom7PAVhOnbwPeIWtQNKRvj3OOEmDrUqSQorG7ftSWeHaXfbtdyyX274lI+L/atAM5RFYFzV6shvlTxi8M5HtzBhxi1rjbpdZvngK+HyitHL5Tu5tBJjBM5a9ZeraEUW2jPUVzEixM11Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba; spf=pass smtp.mailfrom=mail.toshiba; dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b=GfIh0b05; arc=none smtp.client-ip=210.130.202.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1757298853;x=1758508453;bh=Cn
	+UFmnrahnXPfI/xFTC/Llrkc3SwpQ8AAggw6a+87s=;b=GfIh0b05pc36lpfpw0aJwBZ87gaTFbDU
	k5SJBsfZEVbYdlz4s+dSsu2XuOYXjjGCPTliudVWzxNMb0Xn2UWgmO3xMno1tqWbepmtBPDRzE2rk
	71KY1Pvyg9f4J+uJpHigA7OEv/I2iWO4ujRnox2AxDV/T2Nzu+lmma18eM2ZF63n+NABfqYbTqJ+C
	CgjUVZqK+NhmLXnnKzfNmehJaNAHwHvCIu5eHLPzY4LyptJr0FGNCUU7hq6JalcDrC/J9DDPjcuME
	ak1IUQf1oPTjAG2nL3rAFbrIP2xGiPX/+Oi+HiH5N48XB/GGamqS0y6SEgN46VpJLPI2xRhWDTyus
	mA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5882YDEo1108307; Mon, 8 Sep 2025 11:34:13 +0900
X-Iguazu-Qid: 2yAb1IXdsJfjEUpWwl
X-Iguazu-QSIG: v=2; s=0; t=1757298853; q=2yAb1IXdsJfjEUpWwl; m=8TY7ikGs11N172z+9r7QwcJzj7XKj68UXiS5kCERcg8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cKrch5kxZz1xnc; Mon,  8 Sep 2025 11:34:12 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        yuji2.ishikawa@toshiba.co.jp,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH v3 2/2] PCI: dwc: visconti: Remove cpu_addr_fix() after DTS fix ranges
Date: Mon,  8 Sep 2025 11:34:08 +0900
X-TSB-HOP2: ON
Message-Id: <1757298848-15154-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1757298848-15154-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1757298848-15154-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

From: Frank Li <Frank.Li@nxp.com>

Remove cpu_addr_fix() since it is no longer needed. The PCIe ranges
property has been corrected in the DTS, and the DesignWare common code now
handles address translation properly without requiring this workaround.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

---
v3:
  Add pci->use_parent_dt_ranges fixes.
  Update Signed-off-by address, because my company email address haschanged.

v2:
  No Update.
---
 drivers/pci/controller/dwc/pcie-visconti.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
index cdeac6177143c..d8765e57147af 100644
--- a/drivers/pci/controller/dwc/pcie-visconti.c
+++ b/drivers/pci/controller/dwc/pcie-visconti.c
@@ -171,20 +171,7 @@ static void visconti_pcie_stop_link(struct dw_pcie *pci)
 	visconti_mpu_writel(pcie, val | MPU_MP_EN_DISABLE, PCIE_MPU_REG_MP_EN);
 }
 
-/*
- * In this SoC specification, the CPU bus outputs the offset value from
- * 0x40000000 to the PCIe bus, so 0x40000000 is subtracted from the CPU
- * bus address. This 0x40000000 is also based on io_base from DT.
- */
-static u64 visconti_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
-{
-	struct dw_pcie_rp *pp = &pci->pp;
-
-	return cpu_addr & ~pp->io_base;
-}
-
 static const struct dw_pcie_ops dw_pcie_ops = {
-	.cpu_addr_fixup = visconti_pcie_cpu_addr_fixup,
 	.link_up = visconti_pcie_link_up,
 	.start_link = visconti_pcie_start_link,
 	.stop_link = visconti_pcie_stop_link,
@@ -310,6 +297,8 @@ static int visconti_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
+	pci->use_parent_dt_ranges = true;
+
 	return visconti_add_pcie_port(pcie, pdev);
 }
 
-- 
2.51.0



