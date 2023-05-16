Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21763705764
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjEPTiE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjEPThx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:37:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F8093FA;
        Tue, 16 May 2023 12:37:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92CDE63EAB;
        Tue, 16 May 2023 19:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57333C4339B;
        Tue, 16 May 2023 19:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265847;
        bh=J5EKXsQ8JpkrI9Gz8p7tvN4WBF349kQdKYOIvFSrsNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XIN+eFgSG5axh0khDn+f/DfiFa2fy/Gl7HlqCu4DFGR/Gh/jJBZE6kogRn1pGLSf0
         H7p3sJKdHoW15hlgh4PqRp1aSRxoJGu8xkUBD8UOV/7Wc3R0dnNCmKZ0BDGWJZb8D1
         oH2yP6PbTSse4jjfW7V1Oui8ScgC+ip8wsTfipPJG3h+KlhBMS7cqSGZFq5vDlKiy0
         RswG11Urln0rfwHreMBoCRqO+yKcqFn55K7Ppwg4ukMOh1RtnbSr9DTsibIdx1NEsh
         DnzXMlfpiLzkeqt66J/wTfnFD+0D1bBh1mk3F7Als3cmaZdCeWg7QJDwUyVhPN3vUW
         T784GEZx+Ea6A==
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
Subject: [PATCH 13/20] x86: hibernate: declare global functions in suspend.h
Date:   Tue, 16 May 2023 21:35:42 +0200
Message-Id: <20230516193549.544673-14-arnd@kernel.org>
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

Three functions that are defined in x86 specific code to override
generic __weak implementations cause a warning because of a missing
prototype:

arch/x86/power/cpu.c:298:5: error: no previous prototype for 'hibernate_resume_nonboot_cpu_disable' [-Werror=missing-prototypes]
arch/x86/power/hibernate.c:129:5: error: no previous prototype for 'arch_hibernation_header_restore' [-Werror=missing-prototypes]
arch/x86/power/hibernate.c:91:5: error: no previous prototype for 'arch_hibernation_header_save' [-Werror=missing-prototypes]

Move the declarations into a global header so it can be included
by any file defining one of these.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/suspend.h | 4 ++++
 kernel/power/power.h    | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 7ec73e77e652..bc911fecb8e8 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -452,6 +452,10 @@ extern struct pbe *restore_pblist;
 int pfn_is_nosave(unsigned long pfn);
 
 int hibernate_quiet_exec(int (*func)(void *data), void *data);
+int hibernate_resume_nonboot_cpu_disable(void);
+int arch_hibernation_header_save(void *addr, unsigned int max_size);
+int arch_hibernation_header_restore(void *addr);
+
 #else /* CONFIG_HIBERNATION */
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
 static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
diff --git a/kernel/power/power.h b/kernel/power/power.h
index b83c8d5e188d..a6a16faf0ead 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -26,9 +26,6 @@ extern void __init hibernate_image_size_init(void);
 /* Maximum size of architecture specific data in a hibernation header */
 #define MAX_ARCH_HEADER_SIZE	(sizeof(struct new_utsname) + 4)
 
-extern int arch_hibernation_header_save(void *addr, unsigned int max_size);
-extern int arch_hibernation_header_restore(void *addr);
-
 static inline int init_header_complete(struct swsusp_info *info)
 {
 	return arch_hibernation_header_save(info, MAX_ARCH_HEADER_SIZE);
@@ -41,8 +38,6 @@ static inline const char *check_image_kernel(struct swsusp_info *info)
 }
 #endif /* CONFIG_ARCH_HIBERNATION_HEADER */
 
-extern int hibernate_resume_nonboot_cpu_disable(void);
-
 /*
  * Keep some memory free so that I/O operations can succeed without paging
  * [Might this be more than 4 MB?]
-- 
2.39.2

