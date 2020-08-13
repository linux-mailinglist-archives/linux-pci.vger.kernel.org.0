Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16012244196
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 01:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHMXBF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Aug 2020 19:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHMXBD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Aug 2020 19:01:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFC8C061757;
        Thu, 13 Aug 2020 16:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=LmFzg/3+uisMve0eTQ3IP8+ToCgU0urO4/G8i4AUQS4=; b=Nv/Y7PokL0eIVMWBaif9bsxXR3
        Q/CnuuAvJkH7OH1dTi7qSFmHvq+TJK6dEmv4dI1y+wW6TL8MpLX5RF1VdHmXg8A78kRyn4Wp3xhJ9
        YFILbPjLgmWcxMniMrAPxWwmHffuWItdgqGVz9s+7VAZMERfLTSIC7e2/ksCxWhM0+TN8CF41m5Qi
        BNFPjR1crmZXO6+9fUR0i/RMX80py4udxHsfPtcHYfIfyy8ipNd2afRbPyDTpKV/3RFyUBSn7pEYV
        8cKATufrLsz5VGFE5BPjQzc3/yeYOLO6zm3GGr5wQxp0VFFGHBkXIrdHJRZ1KJG6W18RzOHkaqzaf
        NjsihXKQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6MDN-0000R2-Ne; Thu, 13 Aug 2020 23:00:54 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel <xen-devel@lists.xenproject.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] x86/pci: fix xen.c build error when CONFIG_ACPI is not set
Message-ID: <a020884b-fa44-e732-699f-2b79c9b7d15e@infradead.org>
Date:   Thu, 13 Aug 2020 16:00:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build error when CONFIG_ACPI is not set/enabled:

../arch/x86/pci/xen.c: In function ‘pci_xen_init’:
../arch/x86/pci/xen.c:410:2: error: implicit declaration of function ‘acpi_noirq_set’; did you mean ‘acpi_irq_get’? [-Werror=implicit-function-declaration]
  acpi_noirq_set();

Fixes: 88e9ca161c13 ("xen/pci: Use acpi_noirq_set() helper to avoid #ifdef")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: xen-devel@lists.xenproject.org
Cc: linux-pci@vger.kernel.org
---
 arch/x86/pci/xen.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20200813.orig/arch/x86/pci/xen.c
+++ linux-next-20200813/arch/x86/pci/xen.c
@@ -26,6 +26,7 @@
 #include <asm/xen/pci.h>
 #include <asm/xen/cpuid.h>
 #include <asm/apic.h>
+#include <asm/acpi.h>
 #include <asm/i8259.h>
 
 static int xen_pcifront_enable_irq(struct pci_dev *dev)

