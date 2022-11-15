Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F70062979B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 12:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiKOLjM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 06:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiKOLjK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 06:39:10 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724E1220F3
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 03:39:06 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y13so13867317pfp.7
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 03:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4GYd+XuMuFrBQd7Ms+Yla9p/SBc6iAh9srCyE9yM+I=;
        b=TSgSPmKAqX8fCpsZvN8gx2gMPWWBvhm1QsOAn/xx/Z59oRI2Le1IVsqsyqFcn4LFOr
         x5Lk3tvgB3+f2LDtDU35r1hbDzH03jJJxdLEl/UMG2wv4Mg39wAlclYfvOmUcHl1QrNH
         y9eiY8Izynf337IYjb3/24KLiMpEFnzZJNOrpbv5tRznIT8A4EPeLFKUo31MpFwyasN+
         QmVkM9V0/uEF8OZvboN/9IFSBgrxNKZs+6yDz554Bg6/o9cv4fhbFJ2yGI7n6dtt8eV1
         ms2X4upirF/2erN7nQycoXDvVlw/3D9he5aa3L4CAusqZHa9mJbyjlVMCcez1h4KGveS
         tQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4GYd+XuMuFrBQd7Ms+Yla9p/SBc6iAh9srCyE9yM+I=;
        b=nbK/zJFLF+oV20HzHSZDOd7S5R9IP7ALCOuCs8SvLBTZ1k7Wn9OMehD7Irx4LoEz1G
         xLnCCgu/bjuNyjEmgwxgydNeOjH+jxUQbPMLFac04zAT2PZ9RvqzBkm8m7P6hXxcvhqo
         uk2Ba4NIUFzVHJyBBLAe3URYPZkBgejQfo7tCaX3mt5OdZIal2WyP6t1e7/yhGW3l4vr
         qRyWuwgxc24EThlSVlps1z2sZAswBdLPTJIiqkCFGCch/02leb4h88BCabKSOnXhvnpn
         On411MQtF5LBZs3uy/uTC+Z76f0V7dfrKwNyh3N2CVzR93O1Uqi5cv85j15+p81fhyPM
         n7Nw==
X-Gm-Message-State: ANoB5pkKRaEODg7blf2AjqX5XOkUJte6qcbyz43bp4JgiiVRcVz5fs/B
        Xpucz0w7wDaXcmhE8CLnC/Q=
X-Google-Smtp-Source: AA0mqf7ffjEnJpj93VlPu7AfdPOiaMYyfhHACy9Yd7NX9faiFUvcomRq8dIgp2bfD/wbATafs/dAlA==
X-Received: by 2002:a63:d90f:0:b0:439:e030:3fa8 with SMTP id r15-20020a63d90f000000b00439e0303fa8mr15520723pgg.554.1668512345877;
        Tue, 15 Nov 2022 03:39:05 -0800 (PST)
Received: from localhost.localdomain ([220.244.252.98])
        by smtp.gmail.com with ESMTPSA id g12-20020a63fa4c000000b004768ce9e4fasm3338023pgk.59.2022.11.15.03.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 03:39:05 -0800 (PST)
From:   Albert Zhou <albert.zhou.50@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, lukas@wunner.de,
        mika.westerberg@linux.intel.com
Subject: [PATCH v4 1/2] pci: hotplug: add dependency info to Kconfig
Date:   Tue, 15 Nov 2022 22:38:56 +1100
Message-Id: <20221115113857.35800-2-albert.zhou.50@gmail.com>
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
recorded in the help message for HOTPLUG_PCI. Further, HOTPLUG_PCI is
defaulted to Y if USB4 is selected.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Albert Zhou <albert.zhou.50@gmail.com>
---
 drivers/pci/hotplug/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 840a84bb5ee2..0b396a09ae15 100644
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
+	  powered up and running. Thunderbolt/USB4 PCIe tunneling needs Native
+	  PCIe Hotplug to be enabled. PCIe Hotplug depends on PCI Hotplug.
 
 	  When in doubt, say N.
 
-- 
2.34.1

