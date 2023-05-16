Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96577705754
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjEPThj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjEPThe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:37:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E6193ED;
        Tue, 16 May 2023 12:37:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E710B63E94;
        Tue, 16 May 2023 19:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1AFC4339C;
        Tue, 16 May 2023 19:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265816;
        bh=QhfcjWc94ABit5CqNae5vJwGdRyTTfKtDRBYc+KBnK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MvDSmMsr+ldstYZFWxt0d/Qx2DvIFE1q3iE1Bqb+M+VmlMkwcfXpUcl5LvraEDI6S
         HnWIuY+SqiBpKZk8dhmFw5ETZeXvKwhiOJcQGWdhuNVfBEaKkHmXH0FVPCeGls5BT5
         vQMZLkokAMdjoie4w/QtXptZ4gsEiXXyWgx+GJHuazf/GDKjvdN6Gt3EWJ4oMBeTkr
         FvGz1X+Q4Zbr9Q6Y3k/+TvHBSHypXy399/8SZG8zFY/uPkbqkgKPF1SzwLyfarV+rm
         t6q653S9gdfUGKRgliLv3S1pFZQjCqHtNzTcpq1utdvmK5duCxYK7yPT5e0S7iC690
         mE1gVTCKwKBiQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 08/20] x86: highmem: include asm/numa.h for set_highmem_pages_init
Date:   Tue, 16 May 2023 21:35:37 +0200
Message-Id: <20230516193549.544673-9-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516193549.544673-1-arnd@kernel.org>
References: <20230516193549.544673-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The set_highmem_pages_init() function is declared in asm/numa.h, which
must be included in the file that defines it to avoid a W=1 warning:

arch/x86/mm/highmem_32.c:7:13: error: no previous prototype for 'set_highmem_pages_init' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/mm/highmem_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/mm/highmem_32.c b/arch/x86/mm/highmem_32.c
index 2c54b76d8f84..d9efa35711ee 100644
--- a/arch/x86/mm/highmem_32.c
+++ b/arch/x86/mm/highmem_32.c
@@ -3,6 +3,7 @@
 #include <linux/export.h>
 #include <linux/swap.h> /* for totalram_pages */
 #include <linux/memblock.h>
+#include <asm/numa.h>
 
 void __init set_highmem_pages_init(void)
 {
-- 
2.39.2

