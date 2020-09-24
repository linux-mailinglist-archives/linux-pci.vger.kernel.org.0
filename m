Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA5627741E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 16:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgIXOgY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 10:36:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14229 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727859AbgIXOgX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 10:36:23 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AA7356ED7F3D4B87A936;
        Thu, 24 Sep 2020 22:36:19 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 24 Sep 2020
 22:36:16 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <konrad.wilk@oracle.com>, <bhelgaas@google.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <x86@kernel.org>, <hpa@zytor.com>,
        <xen-devel@lists.xenproject.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] xen: Fix a previous prototype warning in xen.c
Date:   Thu, 24 Sep 2020 22:36:16 +0800
Message-ID: <1600958176-23406-1-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix the warning:
arch/x86/pci/xen.c:423:13: warning:
no previous prototype for ‘xen_msi_init’ [-Wmissing-prototypes]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Li Heng <liheng40@huawei.com>
---
 arch/x86/pci/xen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 89395a5..f663a5f 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -420,7 +420,7 @@ int __init pci_xen_init(void)
 }

 #ifdef CONFIG_PCI_MSI
-void __init xen_msi_init(void)
+static void __init xen_msi_init(void)
 {
 	if (!disable_apic) {
 		/*
--
2.7.4

