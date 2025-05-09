Return-Path: <linux-pci+bounces-27513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F7EAB19A2
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 18:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6072165819
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654182367CB;
	Fri,  9 May 2025 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K4TmGG/G"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD25323505D;
	Fri,  9 May 2025 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806138; cv=none; b=kgWlmddsyZoODjmodCegpdvuCZ8YY6dnRdWN4lpFaAWZsesHkC2T1TSAt1SAZL3cVs29ICZxxLECSQhIfAKR4QvOV+yO9HCuU/PNQ5PuQgcZjdM5eo6v4Yg4Fn1ObUvGl4WNHUdAeaBRJP3o/Zkn+003LJ0KvdsmQGu1nWMRtys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806138; c=relaxed/simple;
	bh=fj+CsMRTdhR1fX9gY8RgTc+l5nN9Ow3NT2nQ+WxKZ50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cjpCeB1fDE6rI9OJTd8uk1Fv+Y1sb/3aMObMvy20vyrexoJ5SoNN3usA3nNtX8PbclSjEB8Tv2OED3kh7m2Mzp+22c0Lsrd/UPjb2UmVpaxFtWx8AOYt+g4yLWUEoMpny/e/9dloVGNV37j5Z8x3XA4ZxT1QpZkLVio0hKby6yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K4TmGG/G; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=OK
	C2LPdw3n8i6eOmbAF8IdjSTk4530z62vZdkc/GbAE=; b=K4TmGG/Gh050AD01ci
	CGYzNi+IKjeMx3Ur2n6Sex5JqqZ62XFfjPjUkxYn762sl2+ZPxI424t0VffM5boi
	Blu1K+FDdxI3OcZ8Lkf0r1QUnQagracG39qcLK6fHpLn4cylGci/6DaotPrReWMV
	j7NOGV7GlfYR/U89vvwV+MVdU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCH+a9CJR5oqYT+AA--.23731S3;
	Fri, 09 May 2025 23:54:44 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: shawn.lin@rock-chips.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de,
	manivannan.sadhasivam@linaro.org
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 1/4] PCI: rockchip-host: Fix "Unexpected Completion" log message
Date: Fri,  9 May 2025 23:53:59 +0800
Message-Id: <20250509155402.377923-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509155402.377923-1-18255117159@163.com>
References: <20250509155402.377923-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH+a9CJR5oqYT+AA--.23731S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrWrWF4xXF4kArW3Cw1fCrg_yoWkGrcE9r
	n8u3W7Aw45KrW3A3Wqy3yxtryrAas09a1IkayrtF1ayas2vr10q34kZ3y8JF15ur1DXF9r
	Kw1qyr47WwnrZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRN73v5UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwdIo2geJBoynAABsQ

Fix the debug message for the PCIE_CORE_INT_UCR interrupt to clearly
indicate "Unexpected Completion" instead of a duplicate "malformed TLP"
message. This improves error log accuracy.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 6a46be17aa91..2804980bab86 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -439,7 +439,7 @@ static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
 			dev_dbg(dev, "malformed TLP received from the link\n");
 
 		if (sub_reg & PCIE_CORE_INT_UCR)
-			dev_dbg(dev, "malformed TLP received from the link\n");
+			dev_dbg(dev, "Unexpected Completion received from the link\n");
 
 		if (sub_reg & PCIE_CORE_INT_FCE)
 			dev_dbg(dev, "an error was observed in the flow control advertisements from the other side\n");
-- 
2.25.1


