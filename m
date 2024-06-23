Return-Path: <linux-pci+bounces-9129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52914913792
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 05:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D67EAB2202E
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 03:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48654C133;
	Sun, 23 Jun 2024 03:40:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284A32F3E;
	Sun, 23 Jun 2024 03:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719114003; cv=none; b=ga0iv+pWQBc0XGUwRSc+4T0u8pKTGQjRKASpGXv3dYu/iFkJh3dICsafssmII5lmFnay2UYUYHzLT8lOwe4GTEeqSXAdrq8bnhepjhIf6kfw657vXlsmnyg5Cc6oU/cwPUQN/sqwI7rmLDmJMfYSP7q0fVkUNpc7wh7VcykmvxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719114003; c=relaxed/simple;
	bh=Qc3CeTYvV1MZkceXws1jwevQaWSoCuVCP2eU2GhHEuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WBxJINT7iRMMB2uupnuNYIrAuh13Epo8IwIeWfXbIbXGfUy/ub8XWVQOfwNU7tzOivPEnfCPgUSlLGUgIZoGkUuQuFnTW0qaWN9suKaYGZdpYVmrah9iXSH9cEj93qiVboaTLJUNEsR+aBst3zrFHb8SzUEOocYCMLYe0ysz348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D82DC2BD10;
	Sun, 23 Jun 2024 03:39:59 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: PM: Fix PCIe MRRS restoring for Loongson
Date: Sun, 23 Jun 2024 11:39:40 +0800
Message-ID: <20240623033940.1806616-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't limit MRRS during resume, so that saved value can be restored,
otherwise the MRRS will become the minimum value after resume.

Cc: <stable@vger.kernel.org>
Fixes: 8b3517f88ff2983f ("PCI: loongson: Prevent LS7A MRRS increases")
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 35fb1f17a589..bfc806d9e9bd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -31,6 +31,7 @@
 #include <asm/dma.h>
 #include <linux/aer.h>
 #include <linux/bitfield.h>
+#include <linux/suspend.h>
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -5945,7 +5946,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 
 	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
 
-	if (bridge->no_inc_mrrs) {
+	if (bridge->no_inc_mrrs && (pm_suspend_target_state == PM_SUSPEND_ON)) {
 		int max_mrrs = pcie_get_readrq(dev);
 
 		if (rq > max_mrrs) {
-- 
2.43.0


