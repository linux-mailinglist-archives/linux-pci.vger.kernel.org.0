Return-Path: <linux-pci+bounces-27514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B3BAB19AD
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 18:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3450316AF71
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A92F23771C;
	Fri,  9 May 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ER59UXA3"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819782376EC;
	Fri,  9 May 2025 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806190; cv=none; b=C3ftPMjEi/d+Ae4y1JgnF+CXaxz0Cll8eJt4fLM3TUs1RNYL4e95xyJ8aMjPbZZ7KDrlvrY+wzOWCJ/74PoqVqermGPyL8cfg/NS9ZLDPtfLV6qwW9sfABz2PVIQLjYjm83HNgrvafw3VouyH2GgkiX14sOcoE2rNZNiXcVO9vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806190; c=relaxed/simple;
	bh=xDL4SR8iE4eZctXxjrMatTXbEPFSbQwDhG+e/Jrir5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o0lsHdPyyPpqzi2Xw+uYNXZf2mINNHgCiV1fK5FFrL0wTd6ooUObwd82OAwB2T7UZBPt8M/UcPo7k92qYG4xt75Dgl+3h0RL2GYT36k05MV1ghzH2rx6Q+JAC5EDNZ/xU/fCq6wX5dMRkeovQldxRD860uEg38mpEz5CZw6l2CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ER59UXA3; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ht
	oycmPbpqBasA/drBUodysvfnREG7Bsxmru8dbrqNw=; b=ER59UXA31khSY9WbeL
	MDhFLDWNjr3qr0JvmCSTZWQ4aqQk+QFeHeEHlgP56JaN8q4p0orern3cx25Od9Qo
	FtX+f923x9siPOlQyZzxBm5i01bl1fKzTIlI4RCnrxSc57E6D1KCc0jQzMn4ekxR
	cmoTNvAYZ/3VcLKMr6PTR8L+g=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCH+a9CJR5oqYT+AA--.23731S6;
	Fri, 09 May 2025 23:54:45 +0800 (CST)
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
Subject: [PATCH 4/4] PCI: rockchip-host: Remove unused header includes
Date: Fri,  9 May 2025 23:54:02 +0800
Message-Id: <20250509155402.377923-5-18255117159@163.com>
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
X-CM-TRANSID:_____wCH+a9CJR5oqYT+AA--.23731S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1fWw17JryxuryDCrW5Awb_yoW8GF1UpF
	WqkFWxJrZ5AF1UCFnruF1qkr1Yqw4DZw17J342ga47Z342yr1vq395Crnxtr1kAFW2gF15
	Cay3trs5CrW5XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pKiiT5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxxIo2geIgCSFQAAsr

Clean up the driver by removing unnecessary header includes
(e.g., <linux/clk.h>, <linux/reset.h>) that are no longer referenced
after refactoring. This improves code readability and build efficiency.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ba1f7832bda5..e2c603634bda 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -12,26 +12,17 @@
  */
 
 #include <linux/bitrev.h>
-#include <linux/clk.h>
-#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
-#include <linux/kernel.h>
-#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
-#include <linux/pci.h>
-#include <linux/pci_ids.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
-#include <linux/reset.h>
-#include <linux/regmap.h>
 
 #include "../pci.h"
 #include "pcie-rockchip.h"
-- 
2.25.1


