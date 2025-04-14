Return-Path: <linux-pci+bounces-25795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 320F0A87954
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 09:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B8F3B46EB
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 07:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB4C1A9B48;
	Mon, 14 Apr 2025 07:44:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4CC19597F;
	Mon, 14 Apr 2025 07:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616640; cv=none; b=TTt4XDOrY6K0mzXf7/3cr69NrPNm/xz7S8FGAX+Eh1o03FfDwXzkfoGEr4HDFvbYgaHRqiMaTX7jdTMYwxnJLS7OwAPVv2tEjNSZlqwMmAWS2t5M74wbE69qEugF1XZgMuAky0HY58jhw7z4BG5BjvisdbE4ZmeAmzY85DN2wtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616640; c=relaxed/simple;
	bh=3jKNDEail7lAtKlGJ6h6oq+Jys87QBcw4F/gbjH06po=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r1SwsLGjlwPy0Gkc9J0dAevn6kGk7lOc2UjHmYmyvPacLBetE9xQ2azV4wQp5+jtHivaTmOSSSNCKHeCvP26LdFxDCgtFsg3WMYywFt6twUZFgyCiKTbQdtoRFLJcC/+lLOQyUIoLeSGHkHupTz6IUAgQUhBL+RJXMBBI4UOW7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAAHQwuwvPxn49_nCA--.16546S2;
	Mon, 14 Apr 2025 15:43:44 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: Zhiqiang.Hou@nxp.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] PCI: ls-gen4: Use to_delayed_work()
Date: Mon, 14 Apr 2025 15:42:41 +0800
Message-Id: <20250414074241.3954081-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHQwuwvPxn49_nCA--.16546S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw1xJF43Zw1DurWUuF4fGrg_yoWDXFX_u3
	yqkF9FkFyYk3s5J34akrW3ZFykA34xXw1kKFs5KFZ8Zay7Jr1jy348ZFWDAFW8Kr45XF13
	CF9xCF13C3yDAjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbf8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbVHq3UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Use to_delayed_work() instead of open-coding it.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
index 5af22bee913b..09dff6bf824f 100644
--- a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
+++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
@@ -174,8 +174,7 @@ static int ls_g4_pcie_interrupt_init(struct mobiveil_pcie *mv_pci)
 
 static void ls_g4_pcie_reset(struct work_struct *work)
 {
-	struct delayed_work *dwork = container_of(work, struct delayed_work,
-						  work);
+	struct delayed_work *dwork = to_delayed_work(work);
 	struct ls_g4_pcie *pcie = container_of(dwork, struct ls_g4_pcie, dwork);
 	struct mobiveil_pcie *mv_pci = &pcie->pci;
 	u16 ctrl;
-- 
2.25.1


