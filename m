Return-Path: <linux-pci+bounces-29142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA19AD0E60
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 18:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FE1169BA9
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 16:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C852120B7EC;
	Sat,  7 Jun 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fmU3hE99"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ECD1FF7C5;
	Sat,  7 Jun 2025 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749312166; cv=none; b=Qh3mZaQsfGtvno9uadiU+HLxdBbjKKEqUWyF6rDoPPGktuDKvG+bfGUb71ZktmeUEkQIBuBrGwMse814udptSEREN/wqEfAYCGPd5xgE3EqvIKkm4bvKSMiYUyKj0vG1QTByhJ1puq9D4eS8NEfEFvvBubACrsazIIvngiqPEsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749312166; c=relaxed/simple;
	bh=a/4uwrsPZgXYF17hEfJZOGKFRrRvrs6PPr5TJ8HkYi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=icwtLqJ/np5JNc5vuD+hJyYpRF/lprDh4Yv8QRUigQLNEA86UxiXSL+FSKTromJANvW+KQx+H3VvBPg+No6knD3kdBTlcTGcEa0QC4Fi9KhXVI1CfWGpk6uSAtrdsVIcqW6V9osHoxfKPPSrr3XXbxhQW6O0DMKh5p5z42Qm7rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fmU3hE99; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ie
	pwYhicwFdcRl1yUElPZ9m5c8epfncSb8mYKYdMO50=; b=fmU3hE99QWEFp0nC7k
	D7+kuIiEyiIGMyzSQf0eTHPDGJQ7dKijrzov+VlMPeZRz8XhpI7Ihln2aBN+DF4M
	VGdj4whiCl7iajlJlEZGDy1G/G4fLAqRCqKlKCSPvy58wZbU4oKtONeTj1Bh5rmG
	Xxk5+DAr44fuiS56SLwPjCXq8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBnk_V6YkRoJ9qHGg--.28203S4;
	Sun, 08 Jun 2025 00:02:04 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: shawn.lin@rock-chips.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de,
	mani@kernel.org
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 2/3] PCI: rockchip-host: Correct non-fatal error log message
Date: Sun,  8 Jun 2025 00:02:00 +0800
Message-Id: <20250607160201.807043-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250607160201.807043-1-18255117159@163.com>
References: <20250607160201.807043-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnk_V6YkRoJ9qHGg--.28203S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr4ruF1fCr4DAry5tFyrWFg_yoWkArbE9r
	1jva47Zw4UGr9ag3Zay3ySqr9xAasF9r1Iya18KF13Aa47Xr1Fq348Zwn8JF1kCr15tF9x
	t3sFyF45ur43ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRZJ5rJUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDw9lo2hEWUbcLQAAsE

Correct the debug message for PCIE_CLIENT_INT_NFATAL_ERR from
"no fatal error" to "non fatal error interrupt received" to match the
actual interrupt semantics. This avoids confusion in log interpretation.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
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


