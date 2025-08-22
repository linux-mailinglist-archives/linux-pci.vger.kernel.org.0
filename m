Return-Path: <linux-pci+bounces-34607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7F8B32037
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 18:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7671D62C9A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993FA2EE619;
	Fri, 22 Aug 2025 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bUePwKGl"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190513126AB;
	Fri, 22 Aug 2025 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878597; cv=none; b=kmmDqVRehGYhqRrer345GVmzg6MawMySCbaf8Ku+5Qvd6xpymbg80tAakTP8YK7L/wtA9bge3PFp9ldGolQ6nN8OHWQVRlYAvOW7T2aeRaoURB+wMIg7SvBEaZpEP95sEQRpbNekKTxerMd2ksOMc0wnDgCJ4HvXbP05ZVVW6ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878597; c=relaxed/simple;
	bh=z0no76dBMogDiUvbucFoBSnzUXVlDDTLAopwonD5Nro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iLrYxpuk7EGIpFXhmQOOtQiscXzIGt3gXrTpZ89TbEEZKnc4sMVc6xWXIj6SSesYFQ2mvsZLZij+9/PzUPlTW57XOt7PY6zS9OgY5oGaYeKkNYcyrKvhCD310pEMnS+csyWn+Rqzq++4MHbXWPBfD6gqT4GAYAhxtelUPQiJlNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bUePwKGl; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=T1
	dzvzCZGb5OI8B5vyqfywEGzjgFtbc5TyDi4nyFy9g=; b=bUePwKGlH7QFGQyJGW
	Za46JVY8PR4qfVgKUUzeWq9TfE1bEQvrtKdar+Sgk/fxbEWZfAKa3TaV/6sQQoB5
	4HgXgFePrXVsg/FEp08FHkkigmkbO343YzsaRKwosX5d+x295+ZEQpqdtxt8oDJt
	D6RAloEJKEfe9JMtx86oqUgZ4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnxDaplKho3jnHAA--.18200S6;
	Sat, 23 Aug 2025 00:02:53 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 4/7] PCI: brcmstb: Replace msleep(5) with usleep_range() for precise link up checking
Date: Fri, 22 Aug 2025 23:59:05 +0800
Message-Id: <20250822155908.625553-5-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250822155908.625553-1-18255117159@163.com>
References: <20250822155908.625553-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBnxDaplKho3jnHAA--.18200S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7GFyfGw48KrWkXw4xCFW5Awb_yoW8Jr1rpF
	Z3Ja1jyF17Ja98uw1jv3Z5uw1Yg3ZrZryDK3sFgw17W3ZIv34rGFy5GasYgrn29FWxGw4j
	vw1xt3W8Gay3AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_4SoLUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQwKxo2iokINYxQABsc

The msleep(5) in brcm_pcie_start_link() may sleep longer than intended
due to timer granularity, which can cause unnecessary delays in PCIe link
up detection. Replace it with usleep_range() for a more precise delay of
approximately 5ms.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9afbd02ded35..6e34a052b02e 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -214,6 +214,8 @@
 #define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_MASK		0x1
 #define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_SHIFT		0x0
 
+#define PCIE_LINK_UP_CHECK_US	5000
+
 /* Forward declarations */
 struct brcm_pcie;
 
@@ -1365,7 +1367,8 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	 * total of 100ms.
 	 */
 	for (i = 0; i < 100 && !brcm_pcie_link_up(pcie); i += 5)
-		msleep(5);
+		usleep_range(PCIE_LINK_UP_CHECK_US,
+			     PCIE_LINK_UP_CHECK_US + 100);
 
 	if (!brcm_pcie_link_up(pcie)) {
 		dev_err(dev, "link down\n");
-- 
2.25.1


