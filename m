Return-Path: <linux-pci+bounces-28279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E7CAC111A
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 18:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3AC37A497F
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 16:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25E72951C0;
	Thu, 22 May 2025 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="C+YhtKph"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E66251792;
	Thu, 22 May 2025 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931607; cv=none; b=uDus6H86Hld7W5/4yqqk20q+rQ7BA8LSKRknBcoqdloe2Q9lXvSC3amyduL/Uh+MkIIpoHv+zl/5X5ljosOwL5ChlbDdQ64049plKPumZ+Dg9YeYzxPIWTg8a6Ij3HwLty+yjsLxyAtVlrbyY0aL/GfnwSiFz/61gQ5i61k4hJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931607; c=relaxed/simple;
	bh=BNpi2nFBQAFV/WMKJHvYLfcwSSej3dZ3v1djNDve9jk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b2aCMdfvJBBhnvZltpgZsTbOyjUgmATHplAx2NkjHiYWloEO9Bt/nIqnhP171OEDcrLJ+jg/6WXQyHHbrvGTBDKaoLqSe7OZUaAr8RN6ZeDg4V//5AD+KPjEbpDvaYqgYL9GcnbSPo2xHXhHKUnq0zHqE9mqEw7PSXMggWZIVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=C+YhtKph; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=x3
	IEnvTJUGCZMysuw/nTm9ZVJwxYs3uYCivFSvi4Vsk=; b=C+YhtKphBx7XusaxS3
	VHugP6/eurb44OboiEEdxNB+oNmIu14murO4V6R3z7Ms9GMWHFoeLd65krr/uUPv
	4l2pusa4lBEwsemV9Teo+qk8Qsfew3x1Gzmz/pfKHy1maxzqPe5nA6a0GLHW+2VK
	08ckQnr9RdW06sZyGDhar3waw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3FVK0US9oZlrDDA--.28595S2;
	Fri, 23 May 2025 00:32:53 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	kwilczynski@kernel.org,
	manivannan.sadhasivam@linaro.org
Cc: ajayagarwal@google.com,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] i2c: tegra: Add missing kernel-doc for dma_dev member
Date: Fri, 23 May 2025 00:32:51 +0800
Message-Id: <20250522163251.399223-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3FVK0US9oZlrDDA--.28595S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr45Kry3trWDZw1rury7trb_yoWkXrgEvF
	n7WF47tr1q9rnIyF13WF4fXryjkrWYgF1ktas7t39aka4qqw15GF1DZrWfCrW8X3ZrtFsr
	Wr1DtFWIyrnxAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMjg4DUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxxVo2gvTnlNyQAAsF

Fix the kernel-doc warning by describing the 'dma_dev' member in
the tegra_i2c_dev struct.  This resolves the compilation warning:

drivers/i2c/busses/i2c-tegra.c:297: warning: Function parameter or struct member 'dma_dev' not described in 'tegra_i2c_dev'

Fixes: cdbf26251d3b ("i2c: tegra: Allocate DMA memory for DMA engine")
Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/i2c/busses/i2c-tegra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 87976e99e6d0..07bb1e7e84cc 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -253,6 +253,7 @@ struct tegra_i2c_hw_feature {
  * @dma_phys: handle to DMA resources
  * @dma_buf: pointer to allocated DMA buffer
  * @dma_buf_size: DMA buffer size
+ * @dma_dev: DMA device used for transfers
  * @dma_mode: indicates active DMA transfer
  * @dma_complete: DMA completion notifier
  * @atomic_mode: indicates active atomic transfer

base-commit: fee3e843b309444f48157e2188efa6818bae85cf
-- 
2.25.1


