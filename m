Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5AB4BEFB
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 18:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfFSQvg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 12:51:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36844 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSQvg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2019 12:51:36 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so128714ioh.3
        for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2019 09:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FFjC6CZpi0wJ+pIwQc4j+iYpRFyiXs/VvQdVulnO5iw=;
        b=USx+Oae19Zisth6D5xHMcGnmEMbZij3He6bC/ywRcIReP143qOjW0h2XjHSv2v74QN
         LW0ZJ2KoST8mAfyjCQGnDaPDP5wuy8XdOJSojep2PoIRSknwqC+hMtKA/N8XkXxx1u1i
         hv27Y//K2pxRHfA3fjkqNWC19boADlhY94Z584xglbcTYt3nmje1E/0/AMRGW3Pl+tFR
         QwXwYMlTVe/Xnvl0mbpK4YRy2sW9y/JISUf7yyLuZIyqVuebkIGXlvxAE9WMOCuOkYOH
         DTPrtkJwjEqPw8JTdyESUz88oVmYz9f9B7ScdpKa5/STK7PVlIXPOk5stjkKCGfmp8tu
         TMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FFjC6CZpi0wJ+pIwQc4j+iYpRFyiXs/VvQdVulnO5iw=;
        b=WIA++tS10l9pCTzx9/jDnqu11kdYxAwIXCOrxpstwHbjUaxdahwTM4c8B84oL5ckwC
         pRIWdZvNegGyfhjPmX+Gz5HKfBDY2kETpUk4fbB5fJLJDncFYvyy2GdbsAUkbxjVZdst
         T5AKNZhIHEvO2nJ+pcjzt6hdLjGRdmztv/KJwp8APYx0+NpPGRMF2r3mhYslXdg2EDPC
         HjCt7e9rhhfJixGXSAueM27yuxGcxS09A4oT4Z5uK86YIJosMTbI7lbSsrkme4uLcWdV
         B2btL83dTWLCbRCVQ7NOvt0kVFA9kvFu7lXqotvt2Pi7tHD2Nmjnu9mALvgrTF2vAa5E
         uy3g==
X-Gm-Message-State: APjAAAVm/XZtT13UcppOsARZzHCDhTLkuvuy1JNveA8Lye/M+W9Qx7D9
        wl/0AC+agSGlZnuPa3x5IXFyMXUiQ9RvXQ==
X-Google-Smtp-Source: APXvYqxy1pMm5DTeMcuVPWcfqF/XwCZAubscRhnJYVi0IebtkaLlYiAFIcoETLanuteaFLuLPCNMeg==
X-Received: by 2002:a5d:9047:: with SMTP id v7mr179842ioq.18.1560963095027;
        Wed, 19 Jun 2019 09:51:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id f4sm17863408iok.56.2019.06.19.09.51.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 09:51:34 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, mj@ucw.cz,
        bjorn@helgaas.com, skunberg.kelsey@gmail.com
Subject: [PATCH v4 2/3] lspci: Remove unnecessary !verbose check in show_range()
Date:   Wed, 19 Jun 2019 10:48:57 -0600
Message-Id: <20190619164858.84746-3-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619164858.84746-1-skunberg.kelsey@gmail.com>
References: <20190619164858.84746-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove 'if (!verbose)' code in show_range() due to not being called.
show_range() will only be called when verbose is true. Additional call
to check for verbosity within show_range() is dead code.

!verbose was used so nothing would print if the range behind a bridge
had a base > limit and verbose == false. Since show_range() will not be
called when verbose == false, not printing bridge information is
still accomplished.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 lspci.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/lspci.c b/lspci.c
index 937c6e4..7418b07 100644
--- a/lspci.c
+++ b/lspci.c
@@ -376,17 +376,11 @@ show_size(u64 x)
 static void
 show_range(char *prefix, u64 base, u64 limit, int is_64bit)
 {
-  if (base > limit)
+  if (base > limit && verbose < 3)
     {
-      if (!verbose)
-	return;
-      else if (verbose < 3)
-	{
-	  printf("%s: None\n", prefix);
-	  return;
-	}
+      printf("%s: None\n", prefix);
+      return;
     }
-
   printf("%s: ", prefix);
   if (is_64bit)
     printf("%016" PCI_U64_FMT_X "-%016" PCI_U64_FMT_X, base, limit);
-- 
2.20.1

