Return-Path: <linux-pci+bounces-26943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722B8A9F6EE
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 19:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFCE179F69
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 17:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FBF2797AB;
	Mon, 28 Apr 2025 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qRfgSULg"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57F327978F;
	Mon, 28 Apr 2025 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860312; cv=none; b=XYOBWq1kxdB/T7PnGqywc1jhNRwOJvD9y3g4A0G/Qt4Nz+gdgWwW7hY4vSsskgIq1RTD0ewD7t5d6clSCNmS8n/k+2F4B3rze1/7FdHEYB/ut572TFc776bQ/gFXo4+xa13LaL+kcp88r6+va4JUtkU4eAy1ApiexYWicwUd1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860312; c=relaxed/simple;
	bh=ClPZna7i5122Wr09xYbtgoqUCmhyRpCbBMozYYurono=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YgTQZc6n5gEnHIzBnhfupnjmou1/FoLcvkLgW+DpMHNWdXoGAnlVNpBDRgs4fb8Cxz8IYUxxMUai/yx49csx8mtu4ikPc5Y4XhqYlRk1QP6cr/D33sjnvLOSlb4d2xPmDBc+aw3dCgVUjmL3hFuTlz/Cdv8s0DDepS9wmt+ppvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qRfgSULg; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0l6Sm
	MR9BzhKNVS+UMt/7W8m+RHOtktucSCIuVkRrGU=; b=qRfgSULgVssfAF7kJPd3D
	ZITouP3cQhBbn3eqhGgRdFYM5bm5XaUukMRrFff/uQG9xJp1Tm+cds+Kfx5WLjKD
	pPKV/XgRT0fygzyGa8iPpGf5tvYO2K5gOLfMw1Zoh80F7HIpXRQc3856SNPlb14Q
	6SOR/Qrzwg/25gNgXBEtDY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCH4haitg9otPCfDA--.1694S5;
	Tue, 29 Apr 2025 01:11:01 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org
Cc: cassel@kernel.org,
	robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 3/3] PCI: cadence: Simplify j721e link status check
Date: Tue, 29 Apr 2025 01:10:27 +0800
Message-Id: <20250428171027.13237-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428171027.13237-1-18255117159@163.com>
References: <20250428171027.13237-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH4haitg9otPCfDA--.1694S5
X-Coremail-Antispam: 1Uf129KBjvdXoWruryDKrWxAr1kJF15ZFW5ZFb_yoWDArc_ZF
	1rZF4IyFsrurZIkFy2yF4ayFyrAayIva12ga93tF15AFyxJr4UCF1UZrWDWa4xua15AFn8
	Aw1qqFn8AryjyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjoUq5UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwM9o2gPr6StOAAAs-

Replace explicit if-else condition with direct return statement in
j721e_pcie_link_up(). This reduces code verbosity while maintaining
the same logic for detecting PCIe link completion.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index ef1cfdae33bb..bea1944a7eb2 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -153,11 +153,7 @@ static bool j721e_pcie_link_up(struct cdns_pcie *cdns_pcie)
 	u32 reg;
 
 	reg = j721e_pcie_user_readl(pcie, J721E_PCIE_USER_LINKSTATUS);
-	reg &= LINK_STATUS;
-	if (reg == LINK_UP_DL_COMPLETED)
-		return true;
-
-	return false;
+	return (reg & LINK_STATUS) == LINK_UP_DL_COMPLETED;
 }
 
 static const struct cdns_pcie_ops j721e_pcie_ops = {
-- 
2.25.1


