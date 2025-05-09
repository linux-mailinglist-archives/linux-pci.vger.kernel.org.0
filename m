Return-Path: <linux-pci+bounces-27512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AA1AB199B
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 18:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F31017B0C8
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 15:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D782F236435;
	Fri,  9 May 2025 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XOezCR2K"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60FF22F3B0;
	Fri,  9 May 2025 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806130; cv=none; b=TkLvVwXY1KsFuUfQInCJq0ZWUK7MmM9578vbh+7zXZMhPg3lvJAdvETlp3z67TbG2hzQK5qrEz4QLHeEMdpAzcTMZKKCOl7B5Xdw+fhBIQtET2sJ4y5/5AptLDWVxapiZKtj5Ph0FTCQSVEK/CYHaxthHgxjd4cvrw1/MyJejow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806130; c=relaxed/simple;
	bh=RWQ4XGYVHDZycGxd62P1KIGqj+01EfPS/QKkS6xcxKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nhxovWMRVJ+/T7j/NXMkdkF+Ufgy5lEMWnMpIXkkwoNeGZoDI1ClCn4aJU1LT0rgJt2g0ukm+79RTK8q9AkhgtuUXaOJro9MXE0bWDOyf/S7EZThlIk+9jE/2NUkHUzbrTwhod0XPf3pMXWA7E/VB5PJqmg9Z/e/orlBvxnCLDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XOezCR2K; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7x
	riZp5G3YdXkIK9LD+KY/Qb8BNn8y/0CGxYnt75nvI=; b=XOezCR2KtqaqZL0aNI
	VjUl4PDOUfndplYFo2dTpD8zhFOqP3m9QLE+VuE2iqhrkE9sDvpyQjfn7JxoAnmz
	el/BVm3A4xP1tkPgtFxjVqvwCiwzt+ESgzUxYG/yCizYoiirttllG+9Qda3Cdtne
	cLNAIPHjuRkuHvqS6cUoZq9+Y=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCH+a9CJR5oqYT+AA--.23731S4;
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
Subject: [PATCH 2/4] PCI: rockchip-host: Correct non-fatal error log message
Date: Fri,  9 May 2025 23:54:00 +0800
Message-Id: <20250509155402.377923-3-18255117159@163.com>
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
X-CM-TRANSID:_____wCH+a9CJR5oqYT+AA--.23731S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr4ruF1fCr4DAry5tFyrWFg_yoWDKrcE9r
	1jva47Zw4UKr9ag3Zay3ySqr9xAasI9r4Iya1rKF1aya47Xr1Fq348Zwn8JFn5Cr15tF9F
	g3sFyFWUuF43ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRurWrJUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwxIo2geJBoy0wAAsV

Correct the debug message for PCIE_CLIENT_INT_NFATAL_ERR from
"no fatal error" to "non fatal error interrupt received" to match the
actual interrupt semantics. This avoids confusion in log interpretation.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 2804980bab86..209eb94ece1b 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -489,7 +489,7 @@ static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
 		dev_dbg(dev, "fatal error interrupt received\n");
 
 	if (reg & PCIE_CLIENT_INT_NFATAL_ERR)
-		dev_dbg(dev, "no fatal error interrupt received\n");
+		dev_dbg(dev, "non fatal error interrupt received\n");
 
 	if (reg & PCIE_CLIENT_INT_CORR_ERR)
 		dev_dbg(dev, "correctable error interrupt received\n");
-- 
2.25.1


