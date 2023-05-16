Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951B5705734
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjEPTgX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjEPTgW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:36:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F4D7ED2;
        Tue, 16 May 2023 12:36:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6382E63DB9;
        Tue, 16 May 2023 19:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3326DC4339C;
        Tue, 16 May 2023 19:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265779;
        bh=1y8qB7kv+xDWqxOYw4K9L6tE3JzzzyJ6tx4iNSAnwRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1TfAHj/hol7TROTcUR6gshmlOixx+65a3Ny2hHWBSJC5v+DkbnglNdZhuHcyHDF1
         TGrpdPBwNN+NswjZNBi8Y8axdkLspbxGTmhWJm3FISvx8uYKpFvWNvMYUCeI0BwiSq
         o2a0BV8veTqGfq/kZefozxrUC+JvKPGZDvIk8eukSQlrMDWDfPGou7ctUpolUaZ2wS
         VqKfOGtBPnd7AVKTmQ7p3HUnf7CiL3BOgYkssO0EHfiTrF/sy6ARFEYqTGdMUd/NC6
         B708eZZdFX4plzFfEgIC/q+8LA6b9xp6feRVGoJ6xTNav8yRpOnn1MkAw3aOWScHlE
         /IvgTFvadxfTQ==
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
Subject: [PATCH 02/20] x86: ce4100: Mark local functions as 'static'
Date:   Tue, 16 May 2023 21:35:31 +0200
Message-Id: <20230516193549.544673-3-arnd@kernel.org>
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

Two functions in this file are global but have no prototype in
a header and are not called from elsewhere, so they should
be static:

arch/x86/pci/ce4100.c:86:6: error: no previous prototype for 'sata_revid_init' [-Werror=missing-prototypes]
arch/x86/pci/ce4100.c:175:5: error: no previous prototype for 'bridge_read' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/pci/ce4100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/ce4100.c b/arch/x86/pci/ce4100.c
index 584c25b588b4..87313701f069 100644
--- a/arch/x86/pci/ce4100.c
+++ b/arch/x86/pci/ce4100.c
@@ -83,7 +83,7 @@ static void ehci_reg_read(struct sim_dev_reg *reg, u32 *value)
 		*value |= 0x100;
 }
 
-void sata_revid_init(struct sim_dev_reg *reg)
+static void sata_revid_init(struct sim_dev_reg *reg)
 {
 	reg->sim_reg.value = 0x01060100;
 	reg->sim_reg.mask = 0;
@@ -172,7 +172,7 @@ static inline void extract_bytes(u32 *value, int reg, int len)
 	*value &= mask;
 }
 
-int bridge_read(unsigned int devfn, int reg, int len, u32 *value)
+static int bridge_read(unsigned int devfn, int reg, int len, u32 *value)
 {
 	u32 av_bridge_base, av_bridge_limit;
 	int retval = 0;
-- 
2.39.2

