Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0361B25868E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Sep 2020 05:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgIAD7Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Aug 2020 23:59:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43298 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbgIAD7Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Aug 2020 23:59:25 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DABCAF2F8F3543EB0523;
        Tue,  1 Sep 2020 11:59:20 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 11:59:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bhelgaas@google.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <x86@kernel.org>, <hpa@zytor.com>,
        <efremov@linux.com>, <andriy.shevchenko@linux.intel.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] x86/platform/intel-mid: Fix build error without CONFIG_ACPI
Date:   Tue, 1 Sep 2020 11:58:25 +0800
Message-ID: <20200901035825.25256-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

arch/x86/pci/intel_mid_pci.c: In function ‘intel_mid_pci_init’:
arch/x86/pci/intel_mid_pci.c:303:2: error: implicit declaration of function ‘acpi_noirq_set’; did you mean ‘acpi_irq_get’? [-Werror=implicit-function-declaration]
  acpi_noirq_set();
  ^~~~~~~~~~~~~~
  acpi_irq_get

Fixes: a912a7584ec3 ("x86/platform/intel-mid: Move PCI initialization to arch_init()")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/x86/pci/intel_mid_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 00c62115f39c..0aaf31917061 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -33,6 +33,7 @@
 #include <asm/hw_irq.h>
 #include <asm/io_apic.h>
 #include <asm/intel-mid.h>
+#include <asm/acpi.h>
 
 #define PCIE_CAP_OFFSET	0x100
 
-- 
2.17.1


