Return-Path: <linux-pci+bounces-17277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B57659D85A7
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 13:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1FC286BE3
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 12:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06E51993B5;
	Mon, 25 Nov 2024 12:53:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DBB1714AC
	for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2024 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539180; cv=none; b=qzfF7N1pCQiVZXhja+vbMBP6mtbS+48nuRd+qjXclubRM5BC4g99WBAaHjPGfZNQnrQ9eYPSsFkvM9gVob8kUogk7IQ5eh8GRCrDATqQTh9KtJRyp+cQ7i4B+ESDZt7fMjRNvzeQwEu2pFQHXx4nWhULpc3VJC3PJkSKEEOQyZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539180; c=relaxed/simple;
	bh=Po5Ga7hOCYHRdjCqlgoSU9EL/b9tavFMgtajqhMEgP0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m8d6SzkyQzCZbqHIParOieuUxAQ6CiGy8I2OZW/1F0uz7m7YR0neVL5a1eDEttJPAtLA+ir+JCRQi02fZm0pQj7ROGodCfC8qiQs+agDpD//qY8uawMMK/KKWazSJrxwHGhIEitrGQ3Iz5LdGRbWmmY/8o0FfngV5Jzqoh8oc94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xxlst40wxzxWZg;
	Mon, 25 Nov 2024 20:50:10 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id B7ABA140257;
	Mon, 25 Nov 2024 20:52:55 +0800 (CST)
Received: from huawei.com (10.67.175.69) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Nov
 2024 20:52:55 +0800
From: Zhang Kunbo <zhangkunbo@huawei.com>
To: <bhelgaas@google.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>
CC: <linux-pci@vger.kernel.org>, <liaochang1@huawei.com>,
	<chris.zjh@huawei.com>
Subject: [PATCH] x86: fix missing declartion of x86_apple_machine
Date: Mon, 25 Nov 2024 12:44:19 +0000
Message-ID: <20241125124419.3307839-1-zhangkunbo@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh100007.china.huawei.com (7.202.181.92)

arch/x86/kernel/quirks.c should include 
include/linux/platform_data/x86/apple.h
 for declaration of x86_apple_machine. This fix the sparse warning:

arch/x86/kernel/quirks.c:662:6: warning: symbol 'x86_apple_machine' was not declared. Should it be static?

Signed-off-by: Zhang Kunbo <zhangkunbo@huawei.com>
---
 arch/x86/kernel/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 6d0df6a58873..a92f18db9610 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -10,6 +10,8 @@
 #include <asm/setup.h>
 #include <asm/mce.h>
 
+#include <linux/platform_data/x86/apple.h>
+
 #if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP) && defined(CONFIG_PCI)
 
 static void quirk_intel_irqbalance(struct pci_dev *dev)
-- 
2.34.1


