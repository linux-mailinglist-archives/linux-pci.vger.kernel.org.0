Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B2C4BEFC
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 18:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbfFSQvh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 12:51:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33196 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbfFSQvh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2019 12:51:37 -0400
Received: by mail-io1-f65.google.com with SMTP id u13so184867iop.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2019 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9/VY+/HxtJ6r/tUKypc3sQ2VNbSxhUCs/lSBxOu+yqE=;
        b=dc9GnjCnvJh9dC+V8gpqT+JQQD6h1Hmf+iN3ekFQd8nAGGK6QkK4M3UciNprQk3uwr
         YglJ/BkpLBqBnfaa1P18rkWcyHMrSguRGb9YBstvaVFYqNl37SwsUIGH4omGiE+S24Qt
         eQJYJxtgGAXDoSnqSAdOM09GIbPzoNt3fKN4Igy7cP/yDKjyGoacTwPFhVmfWqxJXsmT
         LVU2PUqGVWBnWV770Pc1NtaVsbh6IlKzRClqgDPEOvJoiY+TxiYXedo1z2IfCt3JjK12
         zONUvnIbkmwgUfGahSZuqug5NJwrR2SloWkFc0bqKFj0UKSZkFkotxO7JCJhniP6JGc+
         BlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9/VY+/HxtJ6r/tUKypc3sQ2VNbSxhUCs/lSBxOu+yqE=;
        b=Z8jo2bD8pIV6+c1Q2DnWl3qhqj70xOXWt9On5t5eO+TB4eg9x2t9FkTB4ofY0C4KWq
         4tivW+hqiHpL5f0Z84WN++91R78wYgK0F0mbMhZklDFT7QMklNDnE1lQypq5GuOi202p
         +x0XeVJH0EgbZqE4oO3CDZcz1xYk3xi85LQb5VdoYyNrIqhPZ2e/+sgJBOnaMjzFhqmk
         fjOvo441LI/9xbJ+dnLKL9YBuBEMkpZIkLSmObscjKKqI/YNGsGOMvrLM09stcmEPqSu
         xWWtQZ5Qi46XvL+mR2wr5XVvqJbNCXYz5sHO7f8re8mXGD83fgmszsJRnqrDvFa77Igp
         jpmA==
X-Gm-Message-State: APjAAAWl6AHjI7k1Jfde0euNdPIsFBpCJeXXrrI+ARiAyCLhNUyqIcVm
        oz8MvWAkE0NNkMfXSuUmWUO/NJuoXP7jsg==
X-Google-Smtp-Source: APXvYqxg6VzUUrpqS273dZtQJuvzSd+ZGiVXGnaXKV1stmSzkQ9fxDRhPFIN4/MtXX+tw/vhMKqj4Q==
X-Received: by 2002:a02:1006:: with SMTP id 6mr100102148jay.47.1560963096306;
        Wed, 19 Jun 2019 09:51:36 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id f4sm17863408iok.56.2019.06.19.09.51.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 09:51:35 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, mj@ucw.cz,
        bjorn@helgaas.com, skunberg.kelsey@gmail.com
Subject: [PATCH v4 3/3] lspci: Change output for bridge with empty range to "[disabled]"
Date:   Wed, 19 Jun 2019 10:48:58 -0600
Message-Id: <20190619164858.84746-4-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619164858.84746-1-skunberg.kelsey@gmail.com>
References: <20190619164858.84746-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change output displayed for memory behind bridge when the range is
empty to be consistent between each verbosity level. Replace "None" and
"[empty]" with "[disabled]". Old and new output examples listed below
for each verbosity level.

Show_range() is not called unless verbose == true. No output given
unless a verbose argument is provided.

OLD output for -v and -vv which uses "None" and -vvv uses "[empty]":

  Memory behind bridge: None                          # lspci -v
  Memory behind bridge: None                          # lspci -vv
  Memory behind bridge: 0000e000-0000efff [empty]     # lspci -vvv

NEW output for -v, -vv, and -vvv to use "[disabled]":

  Memory behind bridge: [disabled]                       # lspci -v
  Memory behind bridge: [disabled]                       # lspci -vv
  Memory behind bridge: 0000e000-0000efff [disabled]     # lspci -vvv

Advantage is consistent output regardless of verbosity level chosen and
to simplify the code.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 lspci.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/lspci.c b/lspci.c
index 7418b07..525bb82 100644
--- a/lspci.c
+++ b/lspci.c
@@ -376,20 +376,18 @@ show_size(u64 x)
 static void
 show_range(char *prefix, u64 base, u64 limit, int is_64bit)
 {
-  if (base > limit && verbose < 3)
+  printf("%s:", prefix);
+  if (base <= limit || verbose > 2)
     {
-      printf("%s: None\n", prefix);
-      return;
+      if (is_64bit)
+        printf(" %016" PCI_U64_FMT_X "-%016" PCI_U64_FMT_X, base, limit);
+      else
+        printf(" %08x-%08x", (unsigned) base, (unsigned) limit);
     }
-  printf("%s: ", prefix);
-  if (is_64bit)
-    printf("%016" PCI_U64_FMT_X "-%016" PCI_U64_FMT_X, base, limit);
-  else
-    printf("%08x-%08x", (unsigned) base, (unsigned) limit);
   if (base <= limit)
     show_size(limit - base + 1);
   else
-    printf(" [empty]");
+    printf(" [disabled]");
   putchar('\n');
 }
 
-- 
2.20.1

