Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C70626F48
	for <lists+linux-pci@lfdr.de>; Sun, 13 Nov 2022 12:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiKML2W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 06:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKML2V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 06:28:21 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA96FD1D
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2022 03:28:20 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so11409738pjk.2
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2022 03:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8IYj8S1w5iP1o57NjFkBuEASFp8JRqWmn4mV20/Zro=;
        b=K5iXlELAgy2DodiUBEqsV/ZKH7It/jS1a3XTwLIA+GXVut4+S3pfqdc6jxpaymLOMH
         k5Q1E7wty0il6bXrJQSsdRgD6tD1L/+Jrt7XH9m9sZd/S80tdoBCDnG9AYwM0mrZcI81
         LHWCrW5VenN3kLrDTnTdBVsmPQLKLUY41zGHIFlO31LiOBbMpsNNt+wE0JOpg5NlS3wT
         ie4cW3qeUnhDxh3kqPwRNyAcZDaJozjd+aku3THqn9/iIZV9C43GMKFW9eYQUsrayOwI
         +6p59wJwbVRrEr7dCZhlcc2xa5GDkWCpB0RDgjSpVQVY0tgW5PnsXz8TY9rrHeZbLIPW
         ykTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8IYj8S1w5iP1o57NjFkBuEASFp8JRqWmn4mV20/Zro=;
        b=KLh9wDp63MN+RQroSE0mPPV8Jxsoshy/GAqBbAQf6QAIhjJda2kKmNQ1/rAs3hiAgf
         mbceEED72dq2EH//kl7FZD5iKAhV9sFsurnVOT5yYf4U8a70yWoyEdioMiXp3nIwDZgu
         uS+2ULqiN70QUOHaUVCDIljTIMtWpkOu4OB65XjsCIAecOcWkI6VQhWxyjnstiKGXdxC
         wBF6y3vowTWzdeewG0WlWI6TMizBhBHO4gaXq78uR5oaJV8xfigRuEpFEzzPxUrDPa0n
         rEIa88zTBoBLDtPdK91zXO9EZlNxsj2g5xcg1syeTRNOkOVDIVhhM+QYWLz5nc0bRkQL
         kw3Q==
X-Gm-Message-State: ANoB5pkR+/KPFyI6cFj4qEKhIWFmsryi7HatSkTpi4C41tLAhvtzdZ7R
        PzMdQ41WggTOBHicZ5N1AgvuA5JRD0L4pg==
X-Google-Smtp-Source: AA0mqf7ykW7hymZu6ntYYPGPTnzrAn4+dxnaHudYv7Oqw9g6OCcyUiQ9zfQfasYN22/W8MIvsHP8Xg==
X-Received: by 2002:a17:902:f7cf:b0:186:8a1e:9b46 with SMTP id h15-20020a170902f7cf00b001868a1e9b46mr9546164plw.80.1668338900451;
        Sun, 13 Nov 2022 03:28:20 -0800 (PST)
Received: from localhost.localdomain ([220.244.252.98])
        by smtp.gmail.com with ESMTPSA id z68-20020a633347000000b0046fe658a903sm3987439pgz.94.2022.11.13.03.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:28:20 -0800 (PST)
From:   Albert Zhou <albert.zhou.50@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, lukas@wunner.de,
        mika.westerberg@linux.intel.com
Subject: [PATCH v2 1/2] pci: hotplug: add dependency info to Kconfig
Date:   Sun, 13 Nov 2022 22:28:10 +1100
Message-Id: <20221113112811.22266-2-albert.zhou.50@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112811.22266-1-albert.zhou.50@gmail.com>
References: <20221113112811.22266-1-albert.zhou.50@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thunderbolt and USB4 PCI cards require the hotplug feature. This is now
recorded in the help message for HOTPLUG_PCI. Further, HOTPLUG_PCI is
defaulted to Y if USB4 is selected.

Signed-off-by: Albert Zhou <albert.zhou.50@gmail.com>
---
 drivers/pci/hotplug/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 840a84bb5ee2..06cc373834f5 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -6,10 +6,12 @@
 menuconfig HOTPLUG_PCI
 	bool "Support for PCI Hotplug"
 	depends on PCI && SYSFS
+	default y if USB4
 	help
 	  Say Y here if you have a motherboard with a PCI Hotplug controller.
 	  This allows you to add and remove PCI cards while the machine is
-	  powered up and running.
+	  powered up and running. Thunderbolt and USB4 PCI cards require
+	  Hotplug.
 
 	  When in doubt, say N.
 
-- 
2.34.1

