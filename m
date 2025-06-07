Return-Path: <linux-pci+bounces-29140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89207AD0E59
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 18:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B373ACB8B
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 16:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35461EB5FA;
	Sat,  7 Jun 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Mx7aTzqi"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9251B35957;
	Sat,  7 Jun 2025 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749312161; cv=none; b=CrFFyw1diQk45XqDg26VeBQUN9aYzU3PdAzQV2TXePA3NTJ7VA15ouNtriVreRxMFZF25DG+1REOZleu+JtFufugsPFw+A10jlLT8qf2UUz4490osLQ4KQDE166RNqVgDls5hnUJsiQi5F/xbtDFC9mBK81aMHJd383Y2aYIwXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749312161; c=relaxed/simple;
	bh=Sy2qS/3HdXzg8WktgfhoYL1j7m4GS/3y9rwlz7NUVKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nq/ML6r8uDeJm9Aad8QMhhyXBpJlVeEKrEpl2KS9xmAW+2Qu3xjOSyKdCFr/z/XpIkwURCw5P5bnN2fAP9rNhbQ/txFEm6A8mECY0MJdeaN4j5J4AMYCJC6lxWEmLmTg/sK5+OzAkkRW81NCy8f+/8HT3srtzTs9JgDmi/ItJsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Mx7aTzqi; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dd
	3PBYCBCfNw9lxWikWA//qjDIn1DUBtp6UcFhFb8M8=; b=Mx7aTzqiUh1rV4a9cG
	k1AiZXhyQMeAA4vSO7iNUePeU6R7754WAwonXzxTQxMU+GcHkTmsbXfqx4Kx5JI+
	IF2NoXkRwBgKVTdbgqt0CGN1pYkg64liEj7BV+Mp2Uixy4ZdM4ypjyfF2J2fB6FN
	HT2NwkOmFNdA3B2RrfbgUdHlo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBnk_V6YkRoJ9qHGg--.28203S5;
	Sun, 08 Jun 2025 00:02:05 +0800 (CST)
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
Subject: [PATCH v3 3/3] PCI: rockchip-host: Remove unused header includes
Date: Sun,  8 Jun 2025 00:02:01 +0800
Message-Id: <20250607160201.807043-4-18255117159@163.com>
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
X-CM-TRANSID:_____wBnk_V6YkRoJ9qHGg--.28203S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1fWw17Jryxur15uw47XFb_yoW8Gw1kpF
	WqkF4xJrZ5AF1UCFnruF1jyFn0qa1DAr17J342ga47Z342yr1vq395urn3tr1DAFW2gF1U
	Cay3trs5CrW5XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRk9NPUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhxlo2hEXNqDCAAAsB

Clean up the driver by removing unnecessary header includes
(e.g., <linux/clk.h>, <linux/reset.h>) that are no longer referenced
after refactoring. This improves code readability and build efficiency.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-host.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 209eb94ece1b..ba360ed62afa 100644
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


