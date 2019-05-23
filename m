Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65BDB28B61
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 22:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387408AbfEWUOu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 16:14:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44512 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387615AbfEWUOt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 16:14:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id c5so3179707pll.11
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2019 13:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6gkDN24DEHNecikQAfO3DJ7JR/wol/teQBJzyAbylPE=;
        b=glbLShSIWuwKWWNiYhxijT7zHQDg2YZ+rDfTZTICpfYRPoA2m+b9+2p9hVRGRimcxe
         eyTeN8BJfaSRNof3f+rSO8Q6Y5r+DC7BQumsOMB+vY6JTMxr3AMXY9qboUlWfI6CQatR
         RylunzRKwzVdC7jhqX63X30pBuTszUi6agnZU8dleumrBOdefDl8rJxIQQRf+pg9RSGk
         MumkhQ7VvAK9YJUvaD1POeHSJcTuxtyFa6NgXyfARjRYXQ2ngVgmtkuTipU0JtnRXNPS
         gEgHoRYLxf0qCOVMpP5iUz37oWaN94Cg/WyEklcQ43f3pVG3bvny2aghocXc6PLNru6A
         erXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6gkDN24DEHNecikQAfO3DJ7JR/wol/teQBJzyAbylPE=;
        b=QqyJc1a475gwjlVPHi4Xltxu5yh53lLXoUAlVxdPVIcZsrnGgRveptEs9hyxlKhTft
         +D4nNmfKYnhhwgT0SGk0W8OmSKAV8mPAdOm2Jl7eti6AAKZvzVy3qdpb3chM6eCL3jqW
         fgUZO4YWLy7qlxouP7ez7qGYD0vMbFg0kQBTxxOI/ibIhN7a0mGGHwn2/+ouVf3TMi4c
         j9TPsSdY9rwwb0TnqXvwLAxsn2UB5XjSTQ5JO+PgqGTueeSfcj7aCZrNgxki+pxPfTPQ
         yQytHD8+pHmmW3IzfNjZEuiPJtmt+mWYG/oorpMgWlUp+UiTs3yL96rWoC+T860ULQRl
         rzPQ==
X-Gm-Message-State: APjAAAXPmJu65WS+WNRnKYbgti5PqpZqc/WfIZqbXlw6oxPtSW505cyz
        QDYmCaEbf2sPeEVV8x0Kc4ZCIB3SL0M=
X-Google-Smtp-Source: APXvYqwmtyNKChwhcovf4WtzVC9Nt812fpxIHPfh5q19R6jEFHGMxxk0MguAJEM/AnwyhJv8Fd+XkA==
X-Received: by 2002:a17:902:9343:: with SMTP id g3mr100265540plp.260.1558642488578;
        Thu, 23 May 2019 13:14:48 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.2])
        by smtp.gmail.com with ESMTPSA id i12sm180839pgb.61.2019.05.23.13.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 13:14:47 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH 1/2] tools: PCI: Fix broken pcitest compilation
Date:   Thu, 23 May 2019 13:14:23 -0700
Message-Id: <1558642464-9946-2-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558642464-9946-1-git-send-email-alan.mikhak@sifive.com>
References: <1558642464-9946-1-git-send-email-alan.mikhak@sifive.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Fixes: fef31ecaaf2c ("tools: PCI: Fix compilation warnings")

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

