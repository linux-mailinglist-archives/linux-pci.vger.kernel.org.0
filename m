Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6645626E2F
	for <lists+linux-pci@lfdr.de>; Sun, 13 Nov 2022 08:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiKMHzd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 02:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMHzc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 02:55:32 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D23210B71
        for <linux-pci@vger.kernel.org>; Sat, 12 Nov 2022 23:55:31 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 130so8423639pfu.8
        for <linux-pci@vger.kernel.org>; Sat, 12 Nov 2022 23:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T4uD8BX3BTbrD8CUBFH4HzycR9pDFousN+7wrmW/Hm0=;
        b=fGULN1ouuQUIsQ/hcdURNJGXB0xDGNjKz02gyV4MyWV8mYbk0YZD+iQcjXb/2/fahE
         kYCYNso3wHBCF465FE9Eh/6MoNLvgX0AGcf/80ADHlgPLthoe8P/xysm6D/Mbejrs2IG
         7CRPjXzLStVE4OR5xQbimkynz3GOVRvDVWLIsPXHxI/RVV5s+aZfXw4e6in2/9zmTnFs
         hLYkjXZZuqCUv9Iq5Zs0o5RjQB+OImWaCqYcUOefi9fOe7GwGo1PZjRMNmXDPIsHqVJc
         dMOQAYWZS9AcOomwo0rwy3MdT+2wjActWp1TnywfS4xB14GzA6RK4eWsDKsyxjC7tsuW
         kPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4uD8BX3BTbrD8CUBFH4HzycR9pDFousN+7wrmW/Hm0=;
        b=aYX7tHlxADSbdut0F1+nMKDuNs+Fzq9LKpXoXfEHf9Czkv3fVG3Op7Vlsxlcn4HmFH
         oKwCssizbuMf7n43Gy6s+rIZrbdT23m0+yACYA0YL3gmfholT20Krh81gB/zRsOdNxRf
         Z5fjTisrVLtisRh4zHrZFM1pJgA1ZwA9rEyq3U94xbVORdNxCYPv2ZXsqm/B968zriL3
         dLqA9viFJeRE2x+jVKza1zyWyeBuafew0xPVIwT/kV+P7urvgDIYunYLVs7ihlbUnLq1
         qLyH71m2fK59rcs68lEuZDrDS2FDfALObA9MWbOm55FYGYPdOw8We0uys+ED6PkGRt/U
         QLoA==
X-Gm-Message-State: ANoB5pnU+BjSztRpzF4UMPT71QCqm8SkuRaGo7qdU9fkzilEHuB+S5fV
        31xTZJw8uUh34uHkCaAYtGbZAbGXz2Wouw==
X-Google-Smtp-Source: AA0mqf52Fr1a1ksQJnUM/4tHRlfllEkMHP6uMQnruPC5hLTvI70ThRp+m2kBTRgrRZ7Md6+WAk/bkA==
X-Received: by 2002:a62:7955:0:b0:56b:e64c:5c7e with SMTP id u82-20020a627955000000b0056be64c5c7emr9396214pfc.18.1668326131042;
        Sat, 12 Nov 2022 23:55:31 -0800 (PST)
Received: from localhost.localdomain ([220.244.252.98])
        by smtp.gmail.com with ESMTPSA id a2-20020a1709027e4200b001714e7608fdsm4650384pln.256.2022.11.12.23.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 23:55:30 -0800 (PST)
From:   Albert Zhou <albert.zhou.50@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH] pci: hotplug: add info to Kconfig
Date:   Sun, 13 Nov 2022 18:55:25 +1100
Message-Id: <20221113075525.2557-1-albert.zhou.50@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Add informative comment that Thunderbolt requires PCI Hotplug.
---
 drivers/pci/hotplug/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 840a84bb5ee2..a6dccb958254 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -9,7 +9,7 @@ menuconfig HOTPLUG_PCI
 	help
 	  Say Y here if you have a motherboard with a PCI Hotplug controller.
 	  This allows you to add and remove PCI cards while the machine is
-	  powered up and running.
+	  powered up and running. Thunderbolt requires PCI Hotplug.
 
 	  When in doubt, say N.
 

base-commit: fef7fd48922d11b22620e19f9c9101647bfe943d
-- 
2.34.1

