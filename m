Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF5B28C3B
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 23:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbfEWVTO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 17:19:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41999 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387930AbfEWVTO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 17:19:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id 33so811838pgv.9
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2019 14:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MSZ9qLvgnuUWthhRIbf1Cjhkpu+CFOpygVqw6RbqY5U=;
        b=WIEVJh7TgDCASi/+YnUkSMzEwtd6hlDck+n8tN2K1tMOc34LB1Jh1QvKVxb0cutw3A
         DH4g4vh5nw8eXnfoR/heSxG5RvW1s4Cu7RyyZ6t4otZ8aHQMWiZqrWSxK+3N7aAy6R+4
         l8r6b9AvVpOk1jZ5i+uT/WsV3S0MArSerkECLKNwwo4gMVmHGwsbZ2PrkVXf3810gVjH
         4xz9PTduCE02rrpFhwTGSl93D/REB0grsaDhqd9PMcZVxOt1JnTht+mXI17goUcKY5W/
         MUmKkcNqR6rdY6EVi4f6uc5ZmjTB//hhHcF8odQI4bMn7jlRbjXi1cGld2z+oA2gXfiR
         dE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MSZ9qLvgnuUWthhRIbf1Cjhkpu+CFOpygVqw6RbqY5U=;
        b=c+Z0V/xTheohzEVtAFKeQ5h5D4EQ01etLjNUEvpCMsziz+vJPIIyt0/fvMTtCfP7Nr
         t3onUItLHIQpIc+HHwEL6FP6D7ah+L9wZDcdt5xzk9Bm8mvXLmD1vi21VK2upgwzp36u
         yfM8utoiLojY8xck5ytReXPCaXx6/e2S5iLeGhv0dgWhjcbXDJ4MLyV5PdZgzNqg+qeW
         EAlG4aW6KSpXD3/a7AeGU6Mpa9aj4PqEHF5azizoUGcJec/Nww2JF92176dot+1/oJN3
         y4nh3Xaq+3oOo9DLnW/Zpludi3uKniVS0ER80f5Bjn/t/xS58lMJqv7yHJJFIjBCHJSy
         v0ZQ==
X-Gm-Message-State: APjAAAUkfFRqdlj1l9CvBPvna8KNfMJ4DwrQFJjTkB2SKX9l4VIrYkhc
        GcGlQ5UU/eQFyFeXa+s39QFDOP9WhOo=
X-Google-Smtp-Source: APXvYqyUyOAczgUqoXWQtDMPqw03qjPB1y6pLPNlzLwxi361TeJoFHwIvI96nXB0BIicaNoroN8SrA==
X-Received: by 2002:a62:7610:: with SMTP id r16mr108209123pfc.69.1558646353373;
        Thu, 23 May 2019 14:19:13 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.2])
        by smtp.gmail.com with ESMTPSA id t5sm234092pgn.80.2019.05.23.14.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 14:19:12 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH v2 1/2] tools: PCI: Fix broken pcitest compilation
Date:   Thu, 23 May 2019 14:18:00 -0700
Message-Id: <1558646281-12676-2-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558646281-12676-1-git-send-email-alan.mikhak@sifive.com>
References: <1558646281-12676-1-git-send-email-alan.mikhak@sifive.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcitest is currently broken due to the following compiler error
and related warning. Fix by changing the run_test() function
signature to return an integer result.

pcitest.c: In function run_test:
pcitest.c:143:9: warning: return with a value, in function
returning void
  return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */

pcitest.c: In function main:
pcitest.c:232:9: error: void value not ignored as it ought to be
  return run_test(test);

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
Fixes: fef31ecaaf2c ("tools: PCI: Fix compilation warnings")
Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 tools/pci/pcitest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 5fa5c2bdd427..6dce894667f6 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -47,15 +47,15 @@ struct pci_test {
 	unsigned long	size;
 };
 
-static void run_test(struct pci_test *test)
+static int run_test(struct pci_test *test)
 {
-	long ret;
+	int ret = -EINVAL;
 	int fd;
 
 	fd = open(test->device, O_RDWR);
 	if (fd < 0) {
 		perror("can't open PCI Endpoint Test device");
-		return;
+		return -ENODEV;
 	}
 
 	if (test->barnum >= 0 && test->barnum <= 5) {
-- 
2.7.4

