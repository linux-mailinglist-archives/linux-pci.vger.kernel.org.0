Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2906F62979C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 12:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiKOLjO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 06:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiKOLjL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 06:39:11 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4160624BE9
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 03:39:09 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 4so12954158pli.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 03:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XU1hQesl5SOGn3dm/Hk18iU0Vy+Ocg6apiXe2S/o8U=;
        b=B7QQXesLiGTJ0rCA5rns/6J5AMTK0mgTfNfBE0Mh/ZEWzZLJdbWrc8HqPHbxxRVLzo
         7CXAjH8PBgTcZJDHAM+Wh2GaV5pnkVFBVVODdjqrOKfjJ/ziw13vqc//V5gLdgumFcj6
         d/ZogDXmNfVDmnd3JVyfU93ZOKLHMxuSbk0mvSLFPf02YLQ6HnNkiy0brORbVT1UhRpg
         7Slw6vjZhTijdNbmPEVU751iq8tPa1FXLp6kpX2tMeJwm6jvDy9+5n9pmadjxGJtYGO0
         7NlQqPgwcE4OGbZwrwdm/UoeAXOVatFmYVfzYU+hHv9Hpi/T9UxoCU9DDzp/CNoMQtlG
         TsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XU1hQesl5SOGn3dm/Hk18iU0Vy+Ocg6apiXe2S/o8U=;
        b=yE6Rm6TlMF5mEVY1r0bSsIvoIacC8iqX+95JpYsnU93E0C+UcmPDGtY127GWvE3V5Q
         6URLxTpM494ag10hFqkBCMl8coClr6kXAz2vlmMk6yOg3KiOoxgtoB8NslPc5WW5o5l4
         dpmzuYwgskUSnB0ILkBZowRH0a3D9U0TuxyeRWKg2ZFlTr3R7ZJZpv58b4vydjz5Y71N
         fPEHD3SBkJoe86eJ9PK2AWvy5dvgLSjjIB8hpowuvEnXCkl1S2EDErPFa+BpI3wB8Z/G
         OB77EKwUc5Z9Emc2/8yn4mXL5TtY4J4IyaaYtjQbQtTV7xWCgd3TC1b93iMcUW8r2NSv
         SvrA==
X-Gm-Message-State: ANoB5pmN8Ry6hwhn8f4WRDZMU+qq+Khway2gQd99kWvzBuFN97fmc9ii
        BxGW7a5gnUS8dgmC2XflFcE=
X-Google-Smtp-Source: AA0mqf5PDAPpI9BXBHVjqOvPJNz2LSEz1c0zh2qxnNwM3WtSPtSee8DL5IH78wiNTsWNQejdBOZA7g==
X-Received: by 2002:a17:90a:1a19:b0:20a:6468:9bf0 with SMTP id 25-20020a17090a1a1900b0020a64689bf0mr1902067pjk.31.1668512348688;
        Tue, 15 Nov 2022 03:39:08 -0800 (PST)
Received: from localhost.localdomain ([220.244.252.98])
        by smtp.gmail.com with ESMTPSA id g12-20020a63fa4c000000b004768ce9e4fasm3338023pgk.59.2022.11.15.03.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 03:39:08 -0800 (PST)
From:   Albert Zhou <albert.zhou.50@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, lukas@wunner.de,
        mika.westerberg@linux.intel.com
Subject: [PATCH v4 2/2] pci: pcie: add dependency info to Kconfig
Date:   Tue, 15 Nov 2022 22:38:57 +1100
Message-Id: <20221115113857.35800-3-albert.zhou.50@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115113857.35800-1-albert.zhou.50@gmail.com>
References: <20221115113857.35800-1-albert.zhou.50@gmail.com>
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

Thunderbolt/USB4 PCIe tunneling require the Hotplug feature. This is now
recorded in the help message for HOTPLUG_PCI_PCIE. Further, PCIEPORTBUS
and HOTPLUG_PCI_PCIE are defaulted to Y if USB4 is selected.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Albert Zhou <albert.zhou.50@gmail.com>
---
 drivers/pci/pcie/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 788ac8df3f9d..32cc9a31e228 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -4,20 +4,22 @@
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
+	  Hotplug. Thunderbolt/USB4 PCIe tunneling needs Native PCIe Hotplug to
+	  be enabled
 
 	  When in doubt, say N.
 
-- 
2.34.1

