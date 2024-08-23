Return-Path: <linux-pci+bounces-12070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FCE95C6D0
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 09:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7124D1F27533
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 07:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C6A3BBE9;
	Fri, 23 Aug 2024 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="agU1Kt/T"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881E13C9C0
	for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398952; cv=none; b=TgFV+sB6fFuig7ip/Qr+pTT588A7DhHzEYmq41j0gaE+pMNxhhONTrW34mDIL4pM0V5fg/IPXBuNQzF9vYxpXjAl7PjsGILaSsLfuPII/6lU+vAgpf9NLJUX54AjFQuJZBUzF+qJZGc06OwCXW+KvHwOwohcn7nJHbalqJiubZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398952; c=relaxed/simple;
	bh=+iTQXUwIBLBhFtVqRuJCkJcyLhUGjB9cLPVfYUzIE2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PHT0q1HUkV4oGqApH+94/TNEyFM8/uDkFe1WI9at2zR0HXqNy+reYEkwTWACT9mpOab141ViSTOKuBQl0RwKVWNZLW8kiLMe22wMMWCk4/9wKAa7gAQyuRPzoacCoqgK8OWTKGRIhcDF9M+AuElqsX799iQP21hPFFjpgfrowN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=agU1Kt/T; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724398948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N2beJE9EA/48PC40RaXnoPjnKHno18ahUxZsE/ycqxg=;
	b=agU1Kt/TuLilClNG7PJAk+YBMoZ3iDmezR19bfprdXk7VSPmJOQzqDCvWwM3d4rFAE5VS5
	CJI8utNPU1ehsAKZ5A6/zPHaehdlM+gfJ/QkADxCFm/GjGkUz4210HhAXOqe6lgUySNlZe
	QXc4TvJx55sGG2fOE7gzWhWvysmOxS0=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] PCI: Make pci_bus_type constant
Date: Fri, 23 Aug 2024 15:42:01 +0800
Message-ID: <20240823074202.139265-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the pci_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/pci/pci-driver.c | 2 +-
 include/linux/pci.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f412ef73a6e4..35270172c833 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1670,7 +1670,7 @@ static void pci_dma_cleanup(struct device *dev)
 		iommu_device_unuse_default_domain(dev);
 }
 
-struct bus_type pci_bus_type = {
+const struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
 	.uevent		= pci_uevent,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4246cb790c7b..0d6c1c089aca 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1098,7 +1098,7 @@ enum pcie_bus_config_types {
 
 extern enum pcie_bus_config_types pcie_bus_config;
 
-extern struct bus_type pci_bus_type;
+extern const struct bus_type pci_bus_type;
 
 /* Do NOT directly access these two variables, unless you are arch-specific PCI
  * code, or PCI core code. */
-- 
2.41.0


