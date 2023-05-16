Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBE4705789
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjEPTjO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEPTjN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:39:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46ABD2DD;
        Tue, 16 May 2023 12:38:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C3E563E87;
        Tue, 16 May 2023 19:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E563AC433EF;
        Tue, 16 May 2023 19:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265877;
        bh=BMgSzYPnqUEEoyY2VRZWSxLxvLKRRE/JigFmOP6CVm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NpGBW3oQfGokP+EqO9HPXqgBNDkoc36H1oosSB5XjEzBOg7yBtWPUSvXBHiX4Rn4Q
         nPdmLvbLNil6YudLmIUT16A//m5E1l/d5GoNjyYA+FGYUUcB0t2DXV/Y8FzJPsCm/g
         WSjrQhVBlok700vqB4usp49fWyRCAVJCMtG/hOkniDZfEqspZMur4GNXocMx9PVPyv
         JJe6IYAyEollD++tusMr4MFE1ysVhpCHJNBmX4uqv8rrV1pvWM156/dMfMSZOF9/ow
         oYS4tnWysUdqiVHzAJ2DPP9MsHPpjO23QeTGlMaWQS4Y+XN+rqnjj3iE0utAy7m/f2
         S+exm0cd8OABA==
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
Subject: [PATCH 18/20] x86: ioremap: add early_memremap_pgprot_adjust prototype
Date:   Tue, 16 May 2023 21:35:47 +0200
Message-Id: <20230516193549.544673-19-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516193549.544673-1-arnd@kernel.org>
References: <20230516193549.544673-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

early_memremap_pgprot_adjust() is a __weak function with a local
prototype, but x86 has a custom implementation that does not
see the prototype, causing a W=1 warning:

arch/x86/mm/ioremap.c:785:17: error: no previous prototype for 'early_memremap_pgprot_adjust' [-Werror=missing-prototypes]

Move the declaration into the global linux/io.h header to avoid this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/io.h | 5 +++++
 mm/internal.h      | 6 ------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index 308f4f0cfb93..7304f2a69960 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -68,6 +68,11 @@ void *devm_memremap(struct device *dev, resource_size_t offset,
 		size_t size, unsigned long flags);
 void devm_memunmap(struct device *dev, void *addr);
 
+/* architectures can override this */
+pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
+					unsigned long size, pgprot_t prot);
+
+
 #ifdef CONFIG_PCI
 /*
  * The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
diff --git a/mm/internal.h b/mm/internal.h
index 68410c6d97ac..e6029d94bdb2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -178,12 +178,6 @@ extern unsigned long highest_memmap_pfn;
  */
 #define MAX_RECLAIM_RETRIES 16
 
-/*
- * in mm/early_ioremap.c
- */
-pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
-					unsigned long size, pgprot_t prot);
-
 /*
  * in mm/vmscan.c:
  */
-- 
2.39.2

