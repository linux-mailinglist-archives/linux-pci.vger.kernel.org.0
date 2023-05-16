Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6FF705761
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjEPThx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjEPThp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:37:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1236D180;
        Tue, 16 May 2023 12:37:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BBCD63E9E;
        Tue, 16 May 2023 19:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2D1C433AC;
        Tue, 16 May 2023 19:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265822;
        bh=DMCbu5Ck8nL16laCe8gzQ409+Zy7oFJ6XN+76haQQGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3CPblb9vbnnqFuY1tw61aFfK9l0Nhj6hfccpdSnjngrZvApvgdIxViPf4vjP57Qt
         qFvGozg2KkPlPBN+rhtss57IV7tT1g8FtyasUBtWiN829+Muh+cn2shwW83ND+k0Cc
         FplnF09GMWMj2fcC0b4/jJX2TTCfua7UEdLt0MdxFgk7PQtYpG9Ml8CxcQcizGiZaB
         ZR03FhPL6TM5aGirSEx1n5ym6Z3bavzahWDpVyLa0GqRqs2Kjp4+nNz+wxsThyDUFs
         rdCC/oV4Ld02UzX5Lf0ab8U3AP0KQT6Q7EydXL76RrAs/+USlWya2sP3b0UpG2emEd
         pAwthPxEXYTPA==
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
Subject: [PATCH 09/20] x86: platform_quirks: include linux/pnp.h for arch_pnpbios_disabled
Date:   Tue, 16 May 2023 21:35:38 +0200
Message-Id: <20230516193549.544673-10-arnd@kernel.org>
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

arch_pnpbios_disabled() is defined in architecture code on x86, but this
does not include the appropriate header, causing a warning:

arch/x86/kernel/platform-quirks.c:42:13: error: no previous prototype for 'arch_pnpbios_disabled' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/platform-quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/platform-quirks.c b/arch/x86/kernel/platform-quirks.c
index b348a672f71d..b525fe6d6657 100644
--- a/arch/x86/kernel/platform-quirks.c
+++ b/arch/x86/kernel/platform-quirks.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/pnp.h>
 
 #include <asm/setup.h>
 #include <asm/bios_ebda.h>
-- 
2.39.2

