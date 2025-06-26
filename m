Return-Path: <linux-pci+bounces-30787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 383B8AEA1ED
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 17:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BAE4E703E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040E32FE362;
	Thu, 26 Jun 2025 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ajBbWyTK"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8759F2FE303;
	Thu, 26 Jun 2025 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949547; cv=none; b=axvG1Ljhl6HYnXtZAzMhv7kgbWdOfplpLjj9jWoxsRMSE9TRIW8Fl0MkKzD20M2Zi3AVL+jf2HcHh2xq8K8vWQFCEnoJg8q8IETxHUJREyYBtyMKdLowKOXaLM8Onflfd8PYLcoJ9nhL0KGqfH5WgrHD2vU5rC2fY5z09xMQp/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949547; c=relaxed/simple;
	bh=QsvVTVjEukMOXgp7vsAJHkEP4QuiyFrtI+Q8YTeyeFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FNSVafzCpeoUkUpD95U/4oVqb54A4wjgpwNmKhuZmqhw76ufTWMLZtfSDWe2Jj6v93vxDbqIYtXYbDgDObcZ3eM/kL1EDaLhjOvKJurn5qrVdOEHTQjxP4wdfLOvUB+fRdjWan/JhONy0XDe4bCmMule84TQYhhIyOIbVPOPWUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ajBbWyTK; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=04
	fcvJHUcanUs3BderAdxY1w8bpBTNk29ppsje+kwjk=; b=ajBbWyTKmY4iQgup3S
	zgsSDOzp54PvAdwYCngBrGEIqnKeJ6lESENlv3H+a2D9Pu9qo3muvnDFFI77mRb4
	+WDeNmRMI1HjniNmNCGKoBoW/jAxsucXD4/qbqAJd2BBFNzfRyomSWZRhYPJktRr
	Q1YVvOtGdO3BJpY8cV0MQg7o8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wB3nPiWXl1o6RnqAg--.56622S4;
	Thu, 26 Jun 2025 22:52:08 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 07/13] PCI: bt1: Refactor code by using dw_pcie_clear_and_set_dword()
Date: Thu, 26 Jun 2025 22:50:34 +0800
Message-Id: <20250626145040.14180-8-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250626145040.14180-1-18255117159@163.com>
References: <20250626145040.14180-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3nPiWXl1o6RnqAg--.56622S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry8Xw4xCw48Gr45uF4xXrb_yoW8ArW7pa
	9IkF92kF12ya1Y9a1Ut3Z7ZFyYgan5CayjgFn7Kw1IgF9Iyr9rWFyrKFy3trZxJr4Iqr1a
	9w1UtFW7uan8ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_eOJ9UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgR4o2hdWexpZgABsr

Baikal-T1 PCIe driver contains a direct register write to initiate
speed change during link training. The current implementation sets
the PORT_LOGIC_SPEED_CHANGE bit via read-modify-write without using
the standard bit manipulation helper.

Replace manual bit set operation with dw_pcie_clear_and_set_dword() to
enable speed change. The helper clearly expresses the intent to modify
a specific bit while preserving others, eliminating the need for explicit
read-before-write.

Using the standardized interface improves consistency with other
DesignWare drivers and reduces the risk of unintended bit modifications.
The change also simplifies future updates to link training logic.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-bt1.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
index 1340edc18d12..7cbaeeed033d 100644
--- a/drivers/pci/controller/dwc/pcie-bt1.c
+++ b/drivers/pci/controller/dwc/pcie-bt1.c
@@ -289,9 +289,8 @@ static int bt1_pcie_start_link(struct dw_pcie *pci)
 	 * attempt to reach a higher bus performance (up to Gen.3 - 8.0 GT/s).
 	 * This is required at least to get 8.0 GT/s speed.
 	 */
-	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val |= PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+	dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
+				    0, PORT_LOGIC_SPEED_CHANGE);
 
 	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_PMSC, val,
 				       BT1_CCU_PCIE_LTSSM_LINKUP(val),
-- 
2.25.1


