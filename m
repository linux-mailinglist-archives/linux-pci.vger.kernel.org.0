Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA7570574A
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjEPThG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjEPThE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:37:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A24A24C;
        Tue, 16 May 2023 12:36:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0BC663E59;
        Tue, 16 May 2023 19:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CFFC433A1;
        Tue, 16 May 2023 19:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265798;
        bh=9077UjXDS1JwWtjrb4zvyxiWevrXkl5r2sPVXNElvI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nU4bcoQ15stgmO0CsrS+eCvsm+gCXhBNBFSdZUZJDZs6Fl6sPo6aQAEbL7HvpgQPw
         34YU/6UqjzMRVqANQ++OmNHESa6zNkcaFm2LUOgnGFvueZRpIj33bI3tKq9iIVMOE8
         GqW/XJRm7a1E2WWrjpdlejWdGAQtbuecvIZU5NAHZBM5oQh2e9un6it3oTQsqi/lTG
         5kxTBEILwkSTC+lRDq4IqynAvKjTaueAozerHdsQ+TGjB+//lEcb2OOHgN+9Q9axD4
         hkpT/62nrOrSL8vWP+nEXayygL8S/uqGna9VmOHK6w0B/JcOokBXElfO8XCeFSQKdo
         bT2kB6PN6dMAg==
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
Subject: [PATCH 05/20] x86: head: add dummy prototype for mk_early_pgtbl_32
Date:   Tue, 16 May 2023 21:35:34 +0200
Message-Id: <20230516193549.544673-6-arnd@kernel.org>
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

'make W=1' warns about a function without a prototype in the x86-32 head code:

arch/x86/kernel/head32.c:72:13: error: no previous prototype for 'mk_early_pgtbl_32' [-Werror=missing-prototypes]

This is called from assembler code, so it does not actually need a prototype.
I could not find an appropriate header for it, so just declare it in front
of the definition to shut up th warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/head32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index 10c27b4261eb..246a609f889b 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -69,6 +69,7 @@ asmlinkage __visible void __init __noreturn i386_start_kernel(void)
  * to the first kernel PMD. Note the upper half of each PMD or PTE are
  * always zero at this stage.
  */
+void __init mk_early_pgtbl_32(void);
 void __init mk_early_pgtbl_32(void)
 {
 #ifdef __pa
-- 
2.39.2

