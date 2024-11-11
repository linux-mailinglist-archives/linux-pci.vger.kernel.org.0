Return-Path: <linux-pci+bounces-16404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1619C35CE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 02:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5411C20FB7
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 01:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A668468;
	Mon, 11 Nov 2024 01:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M/YFbQOk"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0237FA939;
	Mon, 11 Nov 2024 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731287389; cv=none; b=sNCBYTvYLy7R1Jrn3RbQX9TsYjo6GyyJxS6HBGVItZIEcuj6hk2Xtk+5Ud23x5wELSH7P46dyWs2P967Ohnb5JMsiH9/sPW80EkyzcNBiV2M3nLSNJVXeVbB1PyP2xgnGBEudOz7z06Kw8xQUHcNM0QCm3ycxd8j+Q4hn4YITxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731287389; c=relaxed/simple;
	bh=0zYTzNj5Iops5jUhzqiLqkicXyrqr9n2kKTVn6PUpRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L6D/obCnXawiW8EsCpQvJOYuEdX13awyCRs1EGjHMR6ywN/ezMZ76h6OhulvLbyjppNpR3/VPc52WaguUs+bFYeAMHGV1gVwoMfV4lNz4r7541YhQGASkTfdPD9wAFxzJ6W6Uhpz3ZJYGdVyU35k5M2gXbge8gGOtKJchdW5ZJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M/YFbQOk; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731287377; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MERdRrDohXR5+nResFYaTjHMcHXpDsj2YAXyi7y7AvQ=;
	b=M/YFbQOk9B+NbXiqhf+lRfeqwAY82ZAJxXYUoWjMmpUL35x9EfNtd/OsJXJ/RAgmSpax7AwhUzVU2G3XyWeARHg1VHPQF1fG6FKmUwNPoXXHoW8Xhp8TM/ZNhRxCFD4+xpmMI4vsJFj/MGvmw/RaSn7OKreF7HiRZBlq74Um/NE=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WJ3iJNr_1731287376 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 09:09:37 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	kw@linux.com
Cc: linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] PCI: mediatek-gen3: Remove unneeded semicolon
Date: Mon, 11 Nov 2024 09:09:35 +0800
Message-Id: <20241111010935.20208-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes an redundant semicolon.

./drivers/pci/controller/pcie-mediatek-gen3.c:414:2-3: Unneeded
semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11789
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index f333afb92a21..be52e3a123ab 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -411,7 +411,7 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 		if (pcie->num_lanes > 1)
 			val |= FIELD_PREP(PCIE_SETTING_LINK_WIDTH,
 					  GENMASK(fls(pcie->num_lanes >> 2), 0));
-	};
+	}
 	writel_relaxed(val, pcie->base + PCIE_SETTING_REG);
 
 	/* Set Link Control 2 (LNKCTL2) speed restriction, if any */
-- 
2.32.0.3.g01195cf9f


