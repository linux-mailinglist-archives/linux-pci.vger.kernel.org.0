Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F36626F49
	for <lists+linux-pci@lfdr.de>; Sun, 13 Nov 2022 12:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiKML20 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 06:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbiKML20 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 06:28:26 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8033139
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2022 03:28:23 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p21so7752812plr.7
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2022 03:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoeJ7l1SeItyiH/i7rqoeuzAnNEGB7ufNahWeuc/2i8=;
        b=hyRwbqJypEjLrhxR1mu7l25ZMVFjClGBDwQGLpvf3LTQ1Iauz5AuSeMzA3GBRFTqRK
         8om0JGLmWPKYHmWNBE988cTx1O3hAL87jF6sNn8xBaGusH1nn2BXNf6Dbh1DB+YaKKPY
         lwNlMxYSYzn6I2lwYZp7lm/L4H18u8HPGTAPisIfW56HkK7crOrs3vN9rXnM+bWoa78G
         TdFHhQIHeAO+OS6Xc7VV6dcxFmrU9s1AZq5q/AfjreEK008Kb/5zz7CJ7pF1MIXs05GH
         NFomB2yCJ5g1WbQNP9nmFCVag+ZdZgJBgltPxp4fIE7TJpviL6eSBGCGoUkLJmBVZ0oI
         dprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoeJ7l1SeItyiH/i7rqoeuzAnNEGB7ufNahWeuc/2i8=;
        b=VMZJ7B1us8jDr3FVj9bSfjB7EKH4E/8Ah4J3eTly+M80txOevSqTA1NIqE5TBoF4YE
         9OWCr3PbG5oJQwGbLlY/XT+QPfRzNFI679HdZ20OORoWF4k8Hh+y2jKQfgbRwXgnTrAX
         hEwKIZAm37Z2vNuXJiHH24fTimfnS0QhvoqMEqWLNKzKJYBQdvmMj4V4shpINccHG/f3
         C5csuOT/NZxU7AkShJUAzNF/PRpOCK5f6TUrKTEpkVniaiW670cK48qF2G6cgJrh5XBe
         QKh6nM1l8VhnL0ZwgCY8fX4UMG0tO0feINqOu3PCE0b9Lo3QErtEgZSEonv56ePnWoV/
         qxMw==
X-Gm-Message-State: ANoB5pnBDtlnQxDbY8PKGsWNfRwi0IQDiHTHsNU2+st1Q4jP8ACFcMZB
        h0owa23fMOpAMqWCCKMBgA8=
X-Google-Smtp-Source: AA0mqf72/Y93b6xSZtxf8dHURrAphQabFGOERypD9D3ZogVxzmX2Y01HF3XnLFbZHIvDd+Dd3LuB5A==
X-Received: by 2002:a17:903:324d:b0:180:4030:1c7d with SMTP id ji13-20020a170903324d00b0018040301c7dmr9703173plb.99.1668338903293;
        Sun, 13 Nov 2022 03:28:23 -0800 (PST)
Received: from localhost.localdomain ([220.244.252.98])
        by smtp.gmail.com with ESMTPSA id z68-20020a633347000000b0046fe658a903sm3987439pgz.94.2022.11.13.03.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:28:22 -0800 (PST)
From:   Albert Zhou <albert.zhou.50@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, lukas@wunner.de,
        mika.westerberg@linux.intel.com
Subject: [PATCH v2 2/2] pci: pcie: add dependency info to Kconfig
Date:   Sun, 13 Nov 2022 22:28:11 +1100
Message-Id: <20221113112811.22266-3-albert.zhou.50@gmail.com>
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

Thunderbolt and USB4 PCIe cards require the hotplug feature. This is now
recorded in the help message for HOTPLUG_PCI_PCIE. Further, PCIEPORTBUS
and HOTPLUG_PCI_PCIE are defaulted to Y if USB4 is selected.

Signed-off-by: Albert Zhou <albert.zhou.50@gmail.com>
---
 drivers/pci/pcie/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 788ac8df3f9d..6c54a4512e2b 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -4,20 +4,21 @@
 #
 config PCIEPORTBUS
 	bool "PCI Express Port Bus support"
+	default y if USB4
 	help
 	  This enables PCI Express Port Bus support. Users can then enable
 	  support for Native Hot-Plug, Advanced Error Reporting, Power
 	  Management Events, and Downstream Port Containment.
-
 #
 # Include service Kconfig here
 #
 config HOTPLUG_PCI_PCIE
 	bool "PCI Express Hotplug driver"
 	depends on HOTPLUG_PCI && PCIEPORTBUS
+	default y if USB4
 	help
 	  Say Y here if you have a motherboard that supports PCI Express Native
-	  Hotplug
+	  Hotplug. Thunderbolt and USB4 PCIe cards require Hotplug.
 
 	  When in doubt, say N.
 
-- 
2.34.1

