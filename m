Return-Path: <linux-pci+bounces-26526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4310A987EE
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 12:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD45A1B644F5
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 10:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F4D26F44D;
	Wed, 23 Apr 2025 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aIq/Vi1R"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E443326D4F2;
	Wed, 23 Apr 2025 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745405714; cv=none; b=mDsAvwYzySyyiM9YmLGXELIN+5PW7q5apld2NC4q14QloGncZd9BlugKiLkK3BKlZ0Hhby+12W+x0ekHCOKLQ0/zCQ6UtnjXTB6aiyz5MUo4zCPeOL70D/0yc3eljL0AIUeaNGjG2eyeLR8EuJhQRXM7UExadVWJooYUNik4WkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745405714; c=relaxed/simple;
	bh=HKLmHV0ZtG/a4Tkd0yHHJS/176AZM+g1/tCMQTabZzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HKOmKcljYKKUPo7fXZgQubIzKGuEM9R0Ad3Gp6x+2jMYwbiDPF7HKKYBbKLvnfdffLHvqNQbRFUTJVTcgA52XwfL0Tn4CnBmDXKp9DUDwxm4IJIr+F7p3qmNDx3VOn9HZvCHEz6KZCzTz9MgHTER4Mgig8f6PJQe9bgYEKc9F7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aIq/Vi1R; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EY9gG
	G+ynYNdnB1j3/6lY26zStHwpPSt9Msjmy1Whvk=; b=aIq/Vi1RZ9umh5TXnWfqp
	ho99u5DwjrwTC4TYqEmQfQSgxhiBVvEVcn4qQJmAXHYgfMWUpRvWZNk387DjgYiq
	gUngwA1HvcbJOPa79n6Sv23DPoL8o8q7CewSSHkx5FGu61jkINS14nVhaU82yC9o
	oSt7R9eO9NZucwwZMKbvNU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAnRTjYxghozJctBw--.58909S3;
	Wed, 23 Apr 2025 18:54:19 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de
Cc: manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	shawn.lin@rock-chips.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 1/3] PCI: dw-rockchip: Remove unused PCIE_CLIENT_GENERAL_DEBUG
Date: Wed, 23 Apr 2025 18:54:13 +0800
Message-Id: <20250423105415.305556-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250423105415.305556-1-18255117159@163.com>
References: <20250423105415.305556-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnRTjYxghozJctBw--.58909S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruw1kCw48Gw15WrykXrW8WFg_yoWkXrXE9r
	yUuF4xXryDKrWSk392yw4xZFn0yas7ur1xGFZYgFsIva47Kr4rXry8ZrWrX3WDGr43JFyf
	t34vyF4ruayxtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZeOp7UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwI4o2gIwTqxrQABsQ

The PCIE_CLIENT_GENERAL_DEBUG register offset is defined but never
used in the driver. Its presence adds noise to the register map and
may mislead future developers.

Remove this redundant definition to keep the register list minimal
and aligned with actual hardware usage.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 0e0c09bafd63..fd5827bbfae3 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -54,7 +54,6 @@
 #define PCIE_CLIENT_GENERAL_CONTROL	0x0
 #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
 #define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
-#define PCIE_CLIENT_GENERAL_DEBUG	0x104
 #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
 #define PCIE_CLIENT_LTSSM_STATUS	0x300
 #define PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
-- 
2.25.1


