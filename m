Return-Path: <linux-pci+bounces-10831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C4393D06B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 11:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F8928435D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 09:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05BE17557B;
	Fri, 26 Jul 2024 09:29:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9293F29A5;
	Fri, 26 Jul 2024 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721986165; cv=none; b=efu3GqU42eHSMTdZnRbHjsodNyFLhDyoIzA2H1bItxnhGEIzD8yI7MRcnnkmaNMImp9cadN03wswFvSg/Sjc68goTV9vTi/vvZd9DcwjS54cJyE/5DlH7K976jtH1Qj/FYAcwdA1yQnYEUkaydqLWlwyWRVVNDi8pnMeW4dBtCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721986165; c=relaxed/simple;
	bh=sQLmHN1cuTK2TvL6pF6ownjeGN+LxsKt5tqVTB4MAXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=javZeupCSyc2+FyCDaDGWdNDcOjoOYGDIy0TzRan9Vh+HZARcwo7th2rYIq+nLg33VqUI7Sa7PYmgeJMNoKwzajXYJl99wZ7qyYel/fSgxVZQIsenZzXKpmkj4CgSEqW3VJtr1uFJTx7T12VSeEAX/WIpN3EDo9erF+5KaCGCVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B201C32782;
	Fri, 26 Jul 2024 09:29:19 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Haowei Zheng <zhenghaowei@loongson.cn>
Subject: [PATCH] PCI/ACPI: Increase the number of Loongson's PCI host up to 8
Date: Fri, 26 Jul 2024 17:29:11 +0800
Message-ID: <20240726092911.2042656-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Begin with Loongson-3C6000, the number of PCI host can be as many as 8
for multi-chip machines. To support these machines we also increase the
number of entries in mcfg_quirks up to 8.

Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/acpi/pci_mcfg.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 860014b89b8e..58e10a980114 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -181,6 +181,18 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	LOONGSON_ECAM_MCFG("LOONGSON", 0),
 	LOONGSON_ECAM_MCFG("\0", 1),
 	LOONGSON_ECAM_MCFG("LOONGSON", 1),
+	LOONGSON_ECAM_MCFG("\0", 2),
+	LOONGSON_ECAM_MCFG("LOONGSON", 2),
+	LOONGSON_ECAM_MCFG("\0", 3),
+	LOONGSON_ECAM_MCFG("LOONGSON", 3),
+	LOONGSON_ECAM_MCFG("\0", 4),
+	LOONGSON_ECAM_MCFG("LOONGSON", 4),
+	LOONGSON_ECAM_MCFG("\0", 5),
+	LOONGSON_ECAM_MCFG("LOONGSON", 5),
+	LOONGSON_ECAM_MCFG("\0", 6),
+	LOONGSON_ECAM_MCFG("LOONGSON", 6),
+	LOONGSON_ECAM_MCFG("\0", 7),
+	LOONGSON_ECAM_MCFG("LOONGSON", 7),
 #endif /* LOONGARCH */
 };
 
-- 
2.43.5


