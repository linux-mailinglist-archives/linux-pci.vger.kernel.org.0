Return-Path: <linux-pci+bounces-29139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8346AD0E57
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 18:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 245E87A5BE3
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 16:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB2916FF37;
	Sat,  7 Jun 2025 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hf6nk5Ci"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6982DA95E;
	Sat,  7 Jun 2025 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749312160; cv=none; b=ilihcx1U5IGOn7P5zUeQgyWXkDw1JmaOOfz1sAG6+PywK6uyzoRfNhERR6LdMThqqXLU6xMN12qsBuPE7/GEvzOgatnJSpwSescoDzhPH2PriesJkRciroeYvO6X33VfNACvi1ghnSWowhhpAOCwQ70S0xSC6yXjiKMSZNtPr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749312160; c=relaxed/simple;
	bh=TboKj+n+JMofyR3StoxBtmki4DwVKXfKbO8hJ/yAM1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uC2cJ8riPiM3NZcKTfkQNOGXqKDkNj3UoJYg5EZjotbX5WaDV+QGR4SWxMVEugOaF3RzsIlH6uHRh0DDKE1hF74k1199ef+FlD0sIG4ihfArIfCRGteezUnjQzu/NmZVjmfV0n1Exo3Wec8LQFSk7v0j9iuRfNcpc7Qs1k04Hr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hf6nk5Ci; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=KB
	u/QHNze4ZdkHD8l42VpSgTfDV6Fy1D7Y0zPXIgzpI=; b=hf6nk5CihF7kMjhqyg
	5Akw1mKIgJWxGICf//qXGlEXCV4C+Kziahc/Ydw8E/MFhfUyDZ5hiaXozTKzpvlP
	NUxtLwhSCgUZoIdSqfAal0KVcZZhMJH65VWRvjldGRZ/eRvWPh2XFEWg5V433N6T
	k0AnXYhWN3NnVLs7DVk0W/Lgg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBnk_V6YkRoJ9qHGg--.28203S3;
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
Subject: [PATCH v3 1/3] PCI: rockchip-host: Fix "Unexpected Completion" log message
Date: Sun,  8 Jun 2025 00:01:59 +0800
Message-Id: <20250607160201.807043-2-18255117159@163.com>
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
X-CM-TRANSID:_____wBnk_V6YkRoJ9qHGg--.28203S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrWrWF4xXF15urWfJw1xAFb_yoWkZrbE9r
	n8u3W7Zw45KrW3A3Wvy3yIvryrAas09a1IkayftF1ayas2vr10q34v93y8J3Z8ur1DXF9r
	tw1qyF4xW3srZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNhL05UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwBlo2hEWUbcBwABsg

Fix the debug message for the PCIE_CORE_INT_UCR interrupt to clearly
indicate "Unexpected Completion" instead of a duplicate "malformed TLP"
message. This improves error log accuracy.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
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


