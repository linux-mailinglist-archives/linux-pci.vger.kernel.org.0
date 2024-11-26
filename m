Return-Path: <linux-pci+bounces-17304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37E99D903E
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 03:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 526C2B26ABE
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 02:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84809B672;
	Tue, 26 Nov 2024 02:05:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE7D8F58
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 02:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732586712; cv=none; b=YiR8FCWdoVfWbzlAPCFGLs8+fok6e8iYKwokMHRirBMQdlvkEkRR4mtPR0S/WNMgDrhaIIKTHjNwaE7RmxairGsq6OVHMmud6EFWdl58mP6F5JjzTL2I0vNwQwS23eGOOOpji5rmAR8z8fzD2vvvzqyNXz5WHn5T9fdzEFPM41E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732586712; c=relaxed/simple;
	bh=pbIP6to7snXPoldEA8252A31Jw7RdwP1YFSDTSWuvjc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iD4Hqwhds+9HCDEmvFMzBddLayu/SF07mUhJ+rHxc72uwMN240TaAuHqz+n24Wap332DKvEIRenQtvQAaYxVPyuPLTbZyCzctIaw9UZacRipvaN8GwbhlmsZK9OI8WdTRwgjIJwVLGvNgaKzZ5AEJMlWatDcNXSevMA7GlmT4EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Xy5T03wQ3zqSn6;
	Tue, 26 Nov 2024 10:03:16 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id C106A180087;
	Tue, 26 Nov 2024 10:05:06 +0800 (CST)
Received: from huawei.com (10.67.175.69) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Nov
 2024 10:05:06 +0800
From: Zhang Kunbo <zhangkunbo@huawei.com>
To: <bhelgaas@google.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>
CC: <linux-pci@vger.kernel.org>, <liaochang1@huawei.com>,
	<chris.zjh@huawei.com>
Subject: [PATCH v2] x86: fix missing declaration of x86_apple_machine
Date: Tue, 26 Nov 2024 01:56:36 +0000
Message-ID: <20241126015636.3463994-1-zhangkunbo@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100007.china.huawei.com (7.202.181.92)

arch/x86/kernel/quirks.c should include 
include/linux/platform_data/x86/apple.h
 for declaration of x86_apple_machine. This fixes the sparse warning:

arch/x86/kernel/quirks.c:662:6: warning: symbol 'x86_apple_machine' was not declared. Should it be static?

Signed-off-by: Zhang Kunbo <zhangkunbo@huawei.com>
---
v2:
- fix some typos
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


