Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA968243F87
	for <lists+linux-pci@lfdr.de>; Thu, 13 Aug 2020 21:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHMT6t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Aug 2020 15:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgHMT6t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Aug 2020 15:58:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA65C061757;
        Thu, 13 Aug 2020 12:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:Cc:From:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=nJ8XtxrvF6PfqLWB3lP2qE8CmRj4uuFVhReQWgn4JaA=; b=Sa29hv4nZ2Yn/5b5d3KvgO97mE
        n6+plK6ybXlXKPZn8Gc/dbm1JOgkh0y7Ssx82Hf5ENZ1iCpHVK9U2TvObuV+QCmLYhVLLUe3CKiAY
        htX+7L4aQumZ/c0tMSjI7M7qhZo/Q0HjhKURc17Ry6VrfOJV7Gjp2F2YYDfYQ3kUxDISNd70d6t+M
        LnVZVm/SoTm391QP+ZPZmbKL7kxgB7QIZVIyv9rbB2Jwz4AxNPesb6yhyvWrWGck6oMjp5b4V7RED
        fr7tIOexZgh2EdYMfEZt+6bu0NvcMo4ELiZrei5w0+jVxOMzXHD6zKmk/Kgac52xE7ShQa7SYM1C8
        uaXoB1xg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6JN5-0006YD-3I; Thu, 13 Aug 2020 19:58:43 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, jsbarnes@google.com
From:   Randy Dunlap <rdunlap@infradead.org>
Cc:     Arjan van de Ven <arjan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] x86/pci: fix intel_mid_pci.c build error when ACPI is not
 enabled
Message-ID: <20952e3e-6b06-11e4-aff7-07dfbdc5ee18@infradead.org>
Date:   Thu, 13 Aug 2020 12:58:38 -0700
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

Fix build error when CONFIG_ACPI is not set/enabled by adding
the header file <asm/acpi.h> which contains a stub for the function
in the build error.

../arch/x86/pci/intel_mid_pci.c: In function ‘intel_mid_pci_init’:
../arch/x86/pci/intel_mid_pci.c:303:2: error: implicit declaration of function ‘acpi_noirq_set’; did you mean ‘acpi_irq_get’? [-Werror=implicit-function-declaration]
  acpi_noirq_set();

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jsbarnes@google.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-pci@vger.kernel.org
---
Found in linux-next, but applies to/exists in mainline also.

Alternative.1: X86_INTEL_MID depends on ACPI
Alternative.2: drop X86_INTEL_MID support

 arch/x86/pci/intel_mid_pci.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20200813.orig/arch/x86/pci/intel_mid_pci.c
+++ linux-next-20200813/arch/x86/pci/intel_mid_pci.c
@@ -33,6 +33,7 @@
 #include <asm/hw_irq.h>
 #include <asm/io_apic.h>
 #include <asm/intel-mid.h>
+#include <asm/acpi.h>
 
 #define PCIE_CAP_OFFSET	0x100
 

