Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2FE705780
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjEPTi5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjEPTiq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:38:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8909ED0;
        Tue, 16 May 2023 12:38:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D40863ED9;
        Tue, 16 May 2023 19:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28787C433EF;
        Tue, 16 May 2023 19:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265889;
        bh=xg0nY/5XuAoC5Y+aT1n09akQv/zFSJ5XVH0JIB0YwTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lJHg8XNuGiy8jTFn+IFpgUXTvuRIAwq7VY4K/2aG+9oDXR9V6HWZw9BoV/Iby3Y3D
         ciQJCcSCN88ZGK79OW2jW+p1Mcr53FymRzsq3aD57yhmrL6X5s0JHYpe2CHPA22HlU
         vtyjpMlDJ94LuFullCZvqENjJQpN0VpNDcwlo9gDKsPudVss3sLnvUVGlKZDHrWJKC
         9hYO4n8OiF35vwW0mCeLD6vxQ51+sc9aB2SOI5vmH0t/cuFzcMA5Ms2ki0dFUhjZ6z
         F+j0NZXOgRpsDihxxL0McykAWvZ3icJuNiaB3wLMzOKImpSeGeJaJv64l87FCV2Wpu
         UeiC9WTSfPICw==
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
Subject: [PATCH 20/20] x86: olpc: avoid missing-prototype warnings
Date:   Tue, 16 May 2023 21:35:49 +0200
Message-Id: <20230516193549.544673-21-arnd@kernel.org>
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

There are two functions in the olpc platform that have no prototype:

arch/x86/platform/olpc/olpc_dt.c:237:13: error: no previous prototype for 'olpc_dt_fixup' [-Werror=missing-prototypes]
arch/x86/platform/olpc/olpc-xo1-pm.c:73:26: error: no previous prototype for 'xo1_do_sleep' [-Werror=missing-prototypes]

The first one should just be marked 'static' as there are no other
callers, while the second one is called from assembler and is
just a false-positive warning that can be silenced by adding a
prototype.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/platform/olpc/olpc_dt.c | 2 +-
 include/linux/olpc-ec.h          | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/olpc_dt.c
index 75e3319e8bee..74ebd6882690 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -234,7 +234,7 @@ static int __init olpc_dt_compatible_match(phandle node, const char *compat)
 	return 0;
 }
 
-void __init olpc_dt_fixup(void)
+static void __init olpc_dt_fixup(void)
 {
 	phandle node;
 	u32 board_rev;
diff --git a/include/linux/olpc-ec.h b/include/linux/olpc-ec.h
index c4602364e909..3c2891d85c41 100644
--- a/include/linux/olpc-ec.h
+++ b/include/linux/olpc-ec.h
@@ -56,6 +56,8 @@ extern int olpc_ec_sci_query(u16 *sci_value);
 
 extern bool olpc_ec_wakeup_available(void);
 
+asmlinkage int xo1_do_sleep(u8 sleep_state);
+
 #else
 
 static inline int olpc_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *outbuf,
-- 
2.39.2

