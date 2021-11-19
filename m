Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EC6456DE4
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 12:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhKSLDZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 06:03:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:13720 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231796AbhKSLDY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 06:03:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="214426373"
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="214426373"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 03:00:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="537070756"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 19 Nov 2021 03:00:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BB67E554; Fri, 19 Nov 2021 13:00:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] x86/quirks: Add missed include to satisfy static checker
Date:   Fri, 19 Nov 2021 13:00:15 +0200
Message-Id: <20211119110017.48510-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Static checker is not happy with

.../kernel/quirks.c:666:6: warning: symbol 'x86_apple_machine' was not declared. Should it be static?

This is due to missed inclusion. Add it to satisfy the static checker.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 1b10717c9321..c4bc0c3a5414 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -4,6 +4,7 @@
  */
 #include <linux/dmi.h>
 #include <linux/pci.h>
+#include <linux/platform_data/x86/machine.h>
 #include <linux/irq.h>
 
 #include <asm/hpet.h>
-- 
2.33.0

