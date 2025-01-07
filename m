Return-Path: <linux-pci+bounces-19386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4ACA038FB
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 08:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0EB188084A
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 07:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964A51E0E1A;
	Tue,  7 Jan 2025 07:46:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5A519E97C;
	Tue,  7 Jan 2025 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736235982; cv=none; b=VVjahycB07YuFJx0zgJV53GrcEMKTeSGBUKds+rY6jTGzaOxAIzgOE9/7xpoUdZxeL3PABdVt4vHZDx2SSR1SzZL3WRjps5DhKM0po9Ufz+97aFK3n0fnO6RU7CUkUONVW4NfK4BsfBCE67pQobMg4pUhlf3wOuQrN8Er8eOLsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736235982; c=relaxed/simple;
	bh=6uxjF68ejvzC85n6vN7XNZ3MoHIB91r3CM75/BOcHuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZdktNafqCodNfudRBb5knTz4xsvUFpOgLNaCL0H8kXvZklrhGktEZvzuLfod4PKicr+4/h8z1yT3pWrpAffzm1UGWqwMZ/wz/ffJAI6+w8577oNmCGdedrwmH/+pPJHDYKGLwHizD6H/xJiWUcmZOy9BeO1dQDfFrkQqZM+g5Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowACHj2+623xnzEnsBQ--.49551S2;
	Tue, 07 Jan 2025 15:46:09 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jpinto@synopsys.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: endpoint: Fix a double free in __pci_epc_create()
Date: Tue,  7 Jan 2025 15:46:01 +0800
Message-Id: <20250107074601.789649-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHj2+623xnzEnsBQ--.49551S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw15KF48AF4UZrW7tFy7ZFb_yoW3KFX_Ga
	4UZrZrWr4UXwn5K34Ygw4xAFWjkwnaqF4fAF1IqFyayF98urZrZw4avFZ8Grnru390vryD
	Ca4qvrs8Zw17JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

The put_device(&epc->dev) call will trigger pci_epc_release() which
frees "epc" so the kfree(epc) on the next line is a double free.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/pci/endpoint/pci-epc-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 46c9a5c3ca14..652350f054cf 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -818,7 +818,6 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 
 put_dev:
 	put_device(&epc->dev);
-	kfree(epc);
 
 err_ret:
 	return ERR_PTR(ret);
-- 
2.25.1


