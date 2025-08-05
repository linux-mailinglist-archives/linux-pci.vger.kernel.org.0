Return-Path: <linux-pci+bounces-33411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59722B1AC8F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 04:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196646218B7
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 02:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E63B1D63F5;
	Tue,  5 Aug 2025 02:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="jRm2RC6H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1120.securemx.jp [210.130.202.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86B51607A4;
	Tue,  5 Aug 2025 02:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754362409; cv=none; b=ULp9atgKhq1VfRMHl7Sx/pF+eCYnULNt2lr0jovmg9o6gs2XTdrmDPCV3Cq6Bl07NAZydJNkNr784E9awhn8WCH/PRP2NKQFF00jLYM1hfRnWfeuYt0KhZQiCrcVbmWKoCAzUOnjYZ/TN5c4piaV1xTQFtBtHXUvrol9qbZZDxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754362409; c=relaxed/simple;
	bh=pGq8OghSRkoVpKXdQVPo3XwOy10QtKXSakuHLC/l4X0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=P1jQ7zKINieV8oFrVQRzOJrN95jmmm/jOxhDPoKrZw9bLYMIEsKvVps8XG1rI5/w7lx1de/Ejz/JFzAN1rQ1O2jCVswgvJqBc9UeM1pIPaPPnnt5LkjF3bhiHbr1f23GszDnp4vVmNHc4my+nIAwU3FCnP2xWqfvTODF5qP1kCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=jRm2RC6H; arc=none smtp.client-ip=210.130.202.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1120) id 5751lilm1323521; Tue, 5 Aug 2025 10:47:44 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1754358432;x=1755568032;bh=pGq8
	OghSRkoVpKXdQVPo3XwOy10QtKXSakuHLC/l4X0=;b=jRm2RC6HD8TzM4etmwwj+8IvAJHHnMB+Dg
	ZmDQbcWi9cZzvvDvoUvWDKyx2FSC/ICUTRY7Oe/x61ogo/+o5HwQi9AJUwlX7H6f4asPgz3y69R4z
	p0+iL72HsjfUC4SP+k6KsY4lc9FewdGM0pV6py8LrwQGS3u0Cue82omNZKzKnbdBWEtDITwT2kRZu
	tiwEBPALmGTOhpCHzFYnceXk8T2g9ceJCRMlkwSmsO0WbEaYpCVr8RezDGd3YZAxNLZ1e2CLjC3nF
	V3/zHl+vKorLuUbFMwxFDH81sHczixY9zRPjM1lRUtqpFRZa1Nb5ED0BlHc7w4tpqSFFz1VFmyMhQ
	==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 5751lAjP3375559; Tue, 5 Aug 2025 10:47:10 +0900
X-Iguazu-Qid: 2rWhSHZE8neFYwT8dx
X-Iguazu-QSIG: v=2; s=0; t=1754358429; q=2rWhSHZE8neFYwT8dx; m=Vy0RmsCaLnFpSTmT4FGM0wu37Shjywsl5PqDNukgIcc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 5751l7gS037751
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 5 Aug 2025 10:47:08 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH v2 2/2] PCI: dwc: visconti: Remove cpu_addr_fix() after DTS fix ranges
Date: Tue,  5 Aug 2025 10:47:01 +0900
X-TSB-HOP2: ON
Message-Id: <1754358421-12578-3-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1754358421-12578-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1754358421-12578-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
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
---
v2:
  No Update.

 drivers/pci/controller/dwc/pcie-visconti.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
index 2a724ab587f78..d8765e57147af 100644
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
-- 
2.49.0



