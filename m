Return-Path: <linux-pci+bounces-27870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 028F4AB9F0A
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 16:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30A53B3043
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 14:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4591A76BC;
	Fri, 16 May 2025 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Qpn9pmf/"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DC713C914;
	Fri, 16 May 2025 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407389; cv=none; b=fBRowXelMUE1PuSX0/LBy/K5zVR0DUzaB/ljLChMs9UApgwgki4ZSS1/W9IOVtYmfDiMHuPUErW0kNxSJSO+ozHpt//N8d+JY3ejTlI5pC2klQypTfqrt1GyMejC2nQ1XBKWcv0BGaBnkWs1HQekDR/5BYQMrVRa9VuWXwtwhBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407389; c=relaxed/simple;
	bh=8oeZBsX5EC0b5DNou3U2gY7TL+OyZZNV32V+AEK5ox0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n9EB5kvqj+88xJsHLA+y7zQbrQIu8WcKFyBmBy0XRjLJVnVITtBw4bwDmwLDODgywOu55MlxVXT5G5YGYuImQdHfmnHLyLi/djIbqi7TvXQgMZa33me9auMsz398S9p/rjKfDLs1yotVy/Q2Pma8IkEOL6YDM2XyVO3iG+24tqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Qpn9pmf/; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0j
	oqUCbd9YvfR3Cm4Fm+cClE5ZXyYtYajQTs8EUIyUc=; b=Qpn9pmf/PmS+YDPrMB
	1doX8fxFQg+0WijijSwAlEhPPvP2t3sxj+9Ben1ViyNmx1bnK+HU7t/lXiQknnpC
	MJWUwFBuwdaG0Dqm3Ez3r8/MwukETUXNrbPie7KmvQY7lKsXaapU1NaUpixCjN/h
	j9iqXCP1f08WTNUwD+P3dD61E=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCXtfDyUSdoaTNOBw--.62835S5;
	Fri, 16 May 2025 22:55:49 +0800 (CST)
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
Subject: [PATCH v2 3/3] PCI: rockchip-host: Remove unused header includes
Date: Fri, 16 May 2025 22:55:44 +0800
Message-Id: <20250516145544.110516-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250516145544.110516-1-18255117159@163.com>
References: <20250516145544.110516-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXtfDyUSdoaTNOBw--.62835S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1fWw17JryxuF1DuryUZFb_yoW8GF1UpF
	WqkFWxJrZ5AF1UCFnruF1qkrn0va1DZr47J342ga47Z342yr1vq395Crnxtr1kAFW2gF1U
	Cay3trs5CrW5XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U1pBhUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgdPo2gnTU2UZQAAsv

Clean up the driver by removing unnecessary header includes
(e.g., <linux/clk.h>, <linux/reset.h>) that are no longer referenced
after refactoring. This improves code readability and build efficiency.

Signed-off-by: Hans Zhang <18255117159@163.com>
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


