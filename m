Return-Path: <linux-pci+bounces-29132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E98AD0E3E
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 17:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DECBE7A5B79
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 15:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465791865EE;
	Sat,  7 Jun 2025 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K/TjeYsG"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494EFE55B;
	Sat,  7 Jun 2025 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749311400; cv=none; b=h5umZXt2DUa59Nvgc7h94k2XFoZce9gcBYQU72QbHMWuY3hu1ys7MnrGBxjkNvf55ht3v3AT6+72lLhgQh3lElIAqtGRV6byIra0fInJa1scvXWsVCehei02IqOjm0HGWJTsuLu8eDiIJqJ2gsczEiP/MSKd2ADSTkMnYTz+Mp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749311400; c=relaxed/simple;
	bh=uQ7s/v2AjGsOc05HnX/jIvUmXGAQx9UeU4+auFghVDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j9nP9nemP/MehENfhQixXUijsSfQd0MoGUa/TN8K4eHc46vj078GiNnSK4/NDIcgZKNaTJU2KcFX9aDCrgr/Fh1t0VfTTYOnFD5PnpyJPXeYoOG7sXNCvt2ILK8KMTzDu1jv7M2AwCbvRfrh3lNJwZCroBpBV5GXO5FQ077g+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K/TjeYsG; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3x
	nUcdBvnWiNCp7yTgWXorfhoxPJD3su6at4f5v/ffw=; b=K/TjeYsGv5+JF6ifSW
	Y3cHhH10l1uRzkq9k0XbVNyqRhDbAME4pjnZwgcNcjl5kt+RNDu9ROLYEWr7sZyp
	o6SdkzBGtn1OguVZhAB8ZUI/hdo082wOniDojQAaB20Pic+sJMx37UmZh/wVBYQk
	zTAiFsGXeOxFdk26sc89kUeRQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnzz17X0RoTZo8Gw--.4221S3;
	Sat, 07 Jun 2025 23:49:16 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	shawn.lin@rock-chips.com,
	heiko@sntech.de
Cc: robh@kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 1/2] PCI: cadence: Replace private message routing enums with PCI core definitions
Date: Sat,  7 Jun 2025 23:49:12 +0800
Message-Id: <20250607154913.805027-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250607154913.805027-1-18255117159@163.com>
References: <20250607154913.805027-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnzz17X0RoTZo8Gw--.4221S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWxXF4xXw4UKF1ktr1DZFb_yoW8KF4fpF
	W7KryfCF1fXrW5u3Z5Za4UGr13XasxC34xtw4vkw1xZF17CF15GFy29FyrGrW3GrZFqr12
	9398tr9rGF4ayFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE-BMJUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhNlo2hEXNoO6QACsg

The Cadence driver previously defined its own message routing enums (e.g.,
MSG_ROUTING_LOCAL) and message codes, which duplicated existing PCI core
macros (PCIE_MSG_TYPE_R_LOCAL, PCIE_MSG_CODE_ASSERT_INTA, etc.) in
drivers/pci/pci.h. These core definitions align with the PCIe r6.0 spec.

Remove the driver-specific enums and switch to the centralized PCI core
macros. This eliminates redundancy, ensures consistency, and simplifies
future updates. No functional changes are introduced.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 .../pci/controller/cadence/pcie-cadence-ep.c  |  2 +-
 drivers/pci/controller/cadence/pcie-cadence.h | 20 -------------------
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 8ab6cf70c18e..77c5a19b2ab1 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -353,7 +353,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
 	}
 	spin_unlock_irqrestore(&ep->lock, flags);
 
-	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
+	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(PCIE_MSG_TYPE_R_LOCAL) |
 		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code);
 	writel(0, ep->irq_cpu_addr + offset);
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index a149845d341a..1d81c4bf6c6d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -250,26 +250,6 @@ struct cdns_pcie_rp_ib_bar {
 
 struct cdns_pcie;
 
-enum cdns_pcie_msg_routing {
-	/* Route to Root Complex */
-	MSG_ROUTING_TO_RC,
-
-	/* Use Address Routing */
-	MSG_ROUTING_BY_ADDR,
-
-	/* Use ID Routing */
-	MSG_ROUTING_BY_ID,
-
-	/* Route as Broadcast Message from Root Complex */
-	MSG_ROUTING_BCAST,
-
-	/* Local message; terminate at receiver (INTx messages) */
-	MSG_ROUTING_LOCAL,
-
-	/* Gather & route to Root Complex (PME_TO_Ack message) */
-	MSG_ROUTING_GATHER,
-};
-
 struct cdns_pcie_ops {
 	int	(*start_link)(struct cdns_pcie *pcie);
 	void	(*stop_link)(struct cdns_pcie *pcie);
-- 
2.25.1


