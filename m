Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717F770573C
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjEPTgg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjEPTge (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:36:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1193B93DD;
        Tue, 16 May 2023 12:36:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84061633A0;
        Tue, 16 May 2023 19:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CFDC433D2;
        Tue, 16 May 2023 19:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265786;
        bh=L/Qp31ZARnIa1bxC1DyJGeKMdFS5Wgtrq4kpQkQu2zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bB9/JNuGXy+CuuSmBA1mIJQRdm3PDhpA4MNWL9vDjPPUv0Axx1Q2VLtiOmu5h4wlO
         ZIiveTA4vEzmvtg6jqHfnB2IA/KyFoLv58fU1C/G4RLxDtlLb+qWaDnPLIHqxp+uJN
         YuIEMEzwPeJyaUbpe/498ig/Aj8SroIALwN5a9JdhgsmlVncnEE6j0ApQr0CD6wwpG
         uayon8hFFnce7FZ+xk3f501jDfoYnSDBCEasqeaP9EuAKAaVBUhLY0N+aATStZTdOq
         FxWM3nrGI7ppoWHfghhJ25EqNePfkhNvOQNgYm+lOBRhMsfTshiuFBM/UygrVqzdJr
         FaoOyV2QyNahg==
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
Subject: [PATCH 03/20] x86: apic: hide unused safe_smp_processor_id on UP
Date:   Tue, 16 May 2023 21:35:32 +0200
Message-Id: <20230516193549.544673-4-arnd@kernel.org>
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

When CONFIG_SMP is disabled, the prototype for safe_smp_processor_id()
is hidden, which causes a W=1 warning:

/home/arnd/arm-soc/arch/x86/kernel/apic/ipi.c:316:5: error: no previous prototype for 'safe_smp_processor_id' [-Werror=missing-prototypes]

Since there are no callers in this configuration, just hide the definition
as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/apic/ipi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 2a6509e8c840..9bfd6e397384 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -301,6 +301,7 @@ void default_send_IPI_mask_logical(const struct cpumask *cpumask, int vector)
 	local_irq_restore(flags);
 }
 
+#ifdef CONFIG_SMP
 /* must come after the send_IPI functions above for inlining */
 static int convert_apicid_to_cpu(int apic_id)
 {
@@ -329,3 +330,4 @@ int safe_smp_processor_id(void)
 	return cpuid >= 0 ? cpuid : 0;
 }
 #endif
+#endif
-- 
2.39.2

