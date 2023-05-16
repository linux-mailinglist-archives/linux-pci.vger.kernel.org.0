Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26C1705777
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjEPTif (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjEPTiW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:38:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE904A5DE;
        Tue, 16 May 2023 12:38:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B72EA63EB1;
        Tue, 16 May 2023 19:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B617C4339C;
        Tue, 16 May 2023 19:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265853;
        bh=VUIVbi0JrRPfajUkNZclAh0STTeBs9rnHGdAvoTKkf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mC+M7eKABjyFWUz3ahztx+5ej0UDKRHny6IDcOOkOBb7T8TKyoOo1fQHoeIhY+UJr
         sMwYJWriml+CN5IT55dh+Y3N4Qkk1jy6sqNrI9NQRSoJY9QmUi1UgvCpWOpG8IrCEn
         JOOcmypp8HYKXesh78Zw9Mn2B1hMfzJ5E0vHwnVhf9EWjHBjng/8AutDQDYVKbiQni
         nhbYm4YAKuzLx1TphcnEliNa7XAqoVH4gMMnVTi3+fU11+7fSp55kbWmoZSJxYHgWE
         bkp6SUDmTbzTpuvHIao5LyGY8w2RZRYUNYlNHTF5PTUou4JACCZ0eU58pOVKhjr1zj
         +aqQ1XVbdlOGQ==
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
Subject: [PATCH 14/20] x86: fbdev: include asm/fb.h as needed
Date:   Tue, 16 May 2023 21:35:43 +0200
Message-Id: <20230516193549.544673-15-arnd@kernel.org>
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

fb_is_primary_device() is defined as a global function on x86, unlike
the others that have an inline version. The file that defines is
however needs to include the declaration to avoid a warning:

arch/x86/video/fbdev.c:14:5: error: no previous prototype for 'fb_is_primary_device' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/video/fbdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/video/fbdev.c b/arch/x86/video/fbdev.c
index 9fd24846d094..9e9143085d19 100644
--- a/arch/x86/video/fbdev.c
+++ b/arch/x86/video/fbdev.c
@@ -10,6 +10,7 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/vgaarb.h>
+#include <asm/fb.h>
 
 int fb_is_primary_device(struct fb_info *info)
 {
-- 
2.39.2

