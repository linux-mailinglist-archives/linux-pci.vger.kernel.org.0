Return-Path: <linux-pci+bounces-17303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EBF9D9038
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 03:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E80CFB20D9E
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 02:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D6FDF60;
	Tue, 26 Nov 2024 02:03:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF258F58
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732586633; cv=none; b=WYuvk00tMeYQuOermBB69DIWVxmp8ppEwCXnGyGc5ay6hrhhcY1SzdmLGLFwbm1Ivn9xZa/SUgP5fjaR79BhBAvLLeae8SsXX1XcNtuF1aov/qofLR8Ikwt2RpHrthtUZI9F4EvaNA0mJdEjN6kD0keujqYtLWbKYQ+xXwbnsk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732586633; c=relaxed/simple;
	bh=pbIP6to7snXPoldEA8252A31Jw7RdwP1YFSDTSWuvjc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kiJHZXQbDWeDo+nZ1wTkQSv/yD2coG9CeAiMQpdp0hHR7bf50xIaHbItM7Kgnjaoi1lzsVuxgAj1POcDp5d2DDG6PVAfOPJ4CLep3WEpKogzoIWOWv9lBpv8Be6XQnjW1qhGuy+RTO2Rt/OZqFvjZiIICYnG8GSsjshEPEqNqD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xy5RB3SxCz2Gbqh;
	Tue, 26 Nov 2024 10:01:42 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id A702A1A016C;
	Tue, 26 Nov 2024 10:03:48 +0800 (CST)
Received: from huawei.com (10.67.175.69) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Nov
 2024 10:03:47 +0800
From: Zhang Kunbo <zhangkunbo@huawei.com>
To: <bhelgaas@google.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>
CC: <linux-pci@vger.kernel.org>, <liaochang1@huawei.com>,
	<chris.zjh@huawei.com>
Subject: [PATCH v2] x86: fix missing declaration of x86_apple_machine
Date: Tue, 26 Nov 2024 01:54:57 +0000
Message-ID: <20241126015457.3463645-1-zhangkunbo@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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


