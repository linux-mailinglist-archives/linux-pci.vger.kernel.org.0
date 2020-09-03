Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED9025CA68
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 22:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgICUbd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 16:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgICUbN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 16:31:13 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17F1C06123B
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 13:31:03 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id c5so2914431qtd.12
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 13:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wTbIhLiuyTm+XoSeGxmt2GAAo+IvKYWaIE8cYk7ZU44=;
        b=ppe0VpEZBeDfsEU5ITwny6NkcdkxKAFIdZQ3UQnzTBxYV1ctHU67inW4vW137h4gBv
         nWXa8buMLxkA1rBskFYK1Eq0jsE+Qw/6BSGfBW65fCge+eKI/kv4A55AD2s+47ypACRJ
         cVE0+4wdwaCT6SrkHGr9ymZTLU8/wNLASZe7MqnKgh8hB4+OUomA4eJmR7t0BZXrjJW/
         LOvoQCoshN1779crEt6wAJjVHKmUtlw45dC2cFZP8uDI0DaAgpfMMNr88O/e/upP1nRo
         CSOVQI7ODlZsWF9jyXFOiYjx8Wwf0ptZxrDsx86udsnr+hYtU3KnXTgcc4ezeQUCHDis
         66oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wTbIhLiuyTm+XoSeGxmt2GAAo+IvKYWaIE8cYk7ZU44=;
        b=Rgn+K6PG+Rrp5Tm+LhN4s63wwaq8i+7b+r7lCUtJw/rrI48C5YmvkR6NmfOeV8iNTz
         W/pul7dxB3hITj00ZiIW7jfC7xm4d/Jz1VqfxSDmjCvrlr+on8M64krkpAsIjvQ9iKLW
         bRCzX+uwf4MgYYsCPdKGumQRtks/L3IMsBCHsZ142iflGzu4G+nrduqRaUS6yNot4VeT
         Sk0jW6SA1C8GxrC+/YWIOU7IUjDXp9daCGgP74s9bLOVhOwxfCORyJkZQgHjcPctgLS7
         pQNGa8t8veINe/Mkbb3yTQqiVM3ZCG1YVM3cSaKiiZosTy5GxP93XOm3/lpS+vSv0EQb
         Cw+w==
X-Gm-Message-State: AOAM531NnILELnx93wYsk99KX3uyapXg+0Rcg4e1qIZliwM71mBsky1U
        PMYWee30yHz/6C4V4I6NKlojDroGQBA4UHT3n5k=
X-Google-Smtp-Source: ABdhPJyv9bEdV3xRGJWnQr7fgcxwXMprdZ7rQuE4G3j1pIhhWyO6nI10INeeai4ZhUeY9OF61z4g8Dh58X2KMzWpmUw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:a342:: with SMTP id
 u60mr3554884qvu.2.1599165062979; Thu, 03 Sep 2020 13:31:02 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:29 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 04/28] RAS/CEC: Fix cec_init() prototype
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Luca Stefani <luca.stefani.ge1@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Luca Stefani <luca.stefani.ge1@gmail.com>

late_initcall() expects a function that returns an integer. Update the
function signature to match.

 [ bp: Massage commit message into proper sentences. ]

Fixes: 9554bfe403nd ("x86/mce: Convert the CEC to use the MCE notifier")
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lkml.kernel.org/r/20200805095708.83939-1-luca.stefani.ge1@gmail.com
---
 drivers/ras/cec.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 569d9ad2c594..6939aa5b3dc7 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -553,20 +553,20 @@ static struct notifier_block cec_nb = {
 	.priority	= MCE_PRIO_CEC,
 };
 
-static void __init cec_init(void)
+static int __init cec_init(void)
 {
 	if (ce_arr.disabled)
-		return;
+		return -ENODEV;
 
 	ce_arr.array = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!ce_arr.array) {
 		pr_err("Error allocating CE array page!\n");
-		return;
+		return -ENOMEM;
 	}
 
 	if (create_debugfs_nodes()) {
 		free_page((unsigned long)ce_arr.array);
-		return;
+		return -ENOMEM;
 	}
 
 	INIT_DELAYED_WORK(&cec_work, cec_work_fn);
@@ -575,6 +575,7 @@ static void __init cec_init(void)
 	mce_register_decode_chain(&cec_nb);
 
 	pr_info("Correctable Errors collector initialized.\n");
+	return 0;
 }
 late_initcall(cec_init);
 
-- 
2.28.0.402.g5ffc5be6b7-goog

