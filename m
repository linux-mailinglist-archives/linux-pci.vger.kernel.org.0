Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B215E70576C
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjEPTiH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEPTh7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:37:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A674EE1;
        Tue, 16 May 2023 12:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF33C63E89;
        Tue, 16 May 2023 19:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6AFC433EF;
        Tue, 16 May 2023 19:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265859;
        bh=wLf8lxCTTft8AHgx+lACsU6Y90fX557lCughigKxTwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzNvSRgB1AKUSR+3LeaTPh3l60rOTsZilQhWDzOcQ+x5oMBRGFpj+Je09FDcA2oKs
         bQKEk9CQaOZxW+LjeDZNGHoi1VyqvarfbYPZrFtOwIBWfmcUKXnPsDxk3K2zk5rI3y
         gwROMzkPtIsOFqQj7b/viChMDejdNvfGdFXbZ5vHvg75Pj4BpgPv1EfIB110tOzdqm
         cbrsbReFRHuvu0B87vAMax0fJ9PYXNdrYINAB0Gk032nABAs1PIVnq46ho2ehxCbAo
         4W56TKdQY4nVBka2U6Mo+efkQ7TvUoLDyo62gyH/6bIRgyrLCuMeysKv+AAj4wS8d9
         cMd2D7IKCRhyg==
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
Subject: [PATCH 15/20] x86: mce: add copy_mc_fragile_handle_tail prototype
Date:   Tue, 16 May 2023 21:35:44 +0200
Message-Id: <20230516193549.544673-16-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516193549.544673-1-arnd@kernel.org>
References: <20230516193549.544673-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

copy_mc_fragile_handle_tail() is only called from assembler,
but 'make W=1' complains about a missing prototype:

arch/x86/lib/copy_mc.c:26:1: warning: no previous prototype for ‘copy_mc_fragile_handle_tail’ [-Wmissing-prototypes]
   26 | copy_mc_fragile_handle_tail(char *to, char *from, unsigned len)

Add the prototype to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/mce.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 9646ed6e8c0b..180b1cbfcc4e 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -350,4 +350,7 @@ static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
 #endif
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
+
+unsigned long copy_mc_fragile_handle_tail(char *to, char *from, unsigned len);
+
 #endif /* _ASM_X86_MCE_H */
-- 
2.39.2

