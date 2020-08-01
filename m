Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E475A235213
	for <lists+linux-pci@lfdr.de>; Sat,  1 Aug 2020 14:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgHAMYs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Aug 2020 08:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbgHAMYr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Aug 2020 08:24:47 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9EFC06174A;
        Sat,  1 Aug 2020 05:24:47 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id o10so14440173edh.6;
        Sat, 01 Aug 2020 05:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y/Cb7GKK5mO5miGjoqukiO9DrcaVbTzBZ/XAaAsprek=;
        b=hgKqoCrsgEvqzZxuemcdmAGc7l+erLtC0MIMuinBU6Z7xRXXMH08QxW5iaYUUehX4a
         N2jhjFbh6KSNqPO6rdIXcBDOVF+TC3NA3OpVybZTUL2FZnmU5fe1xan0Ku0OsTsKgJBT
         2Bl+4Fm9qSzXFiD2qF5WRx67/ES4EZypV3beloZaZm672olY421KHi08EwsFRo3ualou
         ugM9j06fc7F2D6U3a6xTJCuLmhn+UiqI0N3tIwyBhgTUcLrRz0fNiyAjWlAKP6mHkIdm
         eTJXEvhx4KUsgrDhJUp31wqdm0zs7H8VlSv9shvME6ij/bBn32Wm2j3Nlw+fMdhGApwy
         SPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y/Cb7GKK5mO5miGjoqukiO9DrcaVbTzBZ/XAaAsprek=;
        b=YbJLGTo6YxT6L8bmdIauPy8HPPIuCImmPNMesgZ7TRwExace8oX/uQ0/WIua2FfWyy
         HmygaErDT1JrcKrflGFUgYeap9EtYT0rPKUEHiOURRZYT0zgqnLcsZAB6oU4Y4IXNAjA
         RXj9J139nNLxQpYQXxHeb1ejFGzWFyqHlRPGDStbsqgQbL9lGCeAF3DCqwpJ5yUA3k8I
         Uhaw6EcInVQy5ZbQWKYaov+xk5LEsQWkqjwPHpHmSTwmTOsN+R+yBM60nL696h7W2lwG
         TmcB/cwD9QuouqCu7kA2XFmz0aCJ0GYw5BPyjYDjKocACzGSfhC27vwAzEghJIPxF5+z
         Skog==
X-Gm-Message-State: AOAM530hhXu0epEh8X7/SgBGv8BwNslPvQPAERp5mXRnr7yStj0J872A
        r91U9PPIySUZ5/k7svlZ6CU=
X-Google-Smtp-Source: ABdhPJygCFTQRnLVaNC5h4/9yQOO7Dg3dB0ySHxdfO6WpfJvbhq/7rd7jFfxV5f6I7rAPQsprZz5+A==
X-Received: by 2002:a05:6402:13c4:: with SMTP id a4mr8165000edx.108.1596284686131;
        Sat, 01 Aug 2020 05:24:46 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id a101sm12083131edf.76.2020.08.01.05.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 05:24:45 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [RFC PATCH 16/17] mtd: Drop uses of pci_read_config_*() return value
Date:   Sat,  1 Aug 2020 13:24:45 +0200
Message-Id: <20200801112446.149549-17-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200801112446.149549-1-refactormyself@gmail.com>
References: <20200801112446.149549-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The return value of pci_read_config_*() may not indicate a device error.
However, the value read by these functions is more likely to indicate
this kind of error. This presents two overlapping ways of reporting
errors and complicates error checking.

It is possible to move to one single way of checking for error if the
dependency on the return value of these functions is removed, then it
can later be made to return void.

Remove all uses of the return value of pci_read_config_*().
Check the actual value read for ~0. In this case, ~0 is an invalid
value thus it indicates some kind of error.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/mtd/maps/ichxrom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/maps/ichxrom.c b/drivers/mtd/maps/ichxrom.c
index fda72c5fd8f9..04728d902e49 100644
--- a/drivers/mtd/maps/ichxrom.c
+++ b/drivers/mtd/maps/ichxrom.c
@@ -61,8 +61,8 @@ static void ichxrom_cleanup(struct ichxrom_window *window)
 	int ret;
 
 	/* Disable writes through the rom window */
-	ret = pci_read_config_word(window->pdev, BIOS_CNTL, &word);
-	if (!ret)
+	pci_read_config_word(window->pdev, BIOS_CNTL, &word);
+	if (word != (u16)~0)
 		pci_write_config_word(window->pdev, BIOS_CNTL, word & ~1);
 	pci_dev_put(window->pdev);
 
-- 
2.18.4

