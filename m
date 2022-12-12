Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4513964A336
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 15:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiLLOZS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 09:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiLLOZR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 09:25:17 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC47711820
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 06:25:15 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so5317587wms.2
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 06:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqrrdFR0yGu0+OvA2xJ/WZwnDOsQc12K4sxW6RZEG+U=;
        b=0aCBUTRzSEqtv3war4tiQjO8gLQAecP3Rq+FM+pk8d6ahiKZ/FRiP6hTfXwhcl4wAC
         DNePOiV3bh+FLaQ9qn0fFJ4SPqT6V9FMf52UoOfOQaWIzgwmvzMhHuEDivWhA49AS2QM
         DNfioG+QVP42HUOI8tG2ELcZCgxj4CtR74Bad7/v7xG5tuC98+ahRq879AupJtpOGLsa
         FKB3e74lv1OOgSZRl+vl5ipNVco8u0GUCY8HbSpkQmQeXBMQIkyC6DZiaSZtIiLD0/rJ
         0MQotRjVQL2QD3hV6/j2nMaeE7IcCua3rsZgKl6vQx20JhtmcZGzb8UYq3iSLw1mzS86
         VlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqrrdFR0yGu0+OvA2xJ/WZwnDOsQc12K4sxW6RZEG+U=;
        b=5EVm/w1Z4TVnKDHXflTv7gwReTaDNXeuN7TRBVGwnZYZ2rZcUYo4W/rdaTEDZJ2P3i
         pd7nN25H3OXdrgnN8atLvMN/aw6bbDnIcIQ8XdR8gI4zqSAEg4ey1B6B07YAtv2Xx2wx
         kLeksK4Sq6KhDLRAAMUvxykCQs3OIbxIolMx02VfpKSLCw3M4cBqRUoI4uL6yczcsE2u
         iMt2Q3WzIhIlRNQ6pmd79cGiLY3DWpIgE7Ghazl2w63U4kIT2BmcAmHtrNOneBJRNPm0
         wqx6jsMe7sS7mWEWJrk3bPeSz3aAFGAN51kAYbyO2BSdrdq/lklSsa1BiHq76qugT7XA
         lcnQ==
X-Gm-Message-State: ANoB5pmP7e8j+4ubjDOKzyuSwxHMth3w7EFhGtMV/6wWbd4zQRWwua/P
        aW2dNh+tQaKaiTQ15ceDJjH6sg==
X-Google-Smtp-Source: AA0mqf4lHJ54ollxf7pUgiXEQKYXLDUubLj+Mrtu+pwLBBEIh7QSTP3lZwqAmg8AxTu8TUfvl2l33g==
X-Received: by 2002:a05:600c:1da2:b0:3cf:5fd2:87a0 with SMTP id p34-20020a05600c1da200b003cf5fd287a0mr12010376wms.40.1670855114403;
        Mon, 12 Dec 2022 06:25:14 -0800 (PST)
Received: from localhost.localdomain (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
        by smtp.gmail.com with ESMTPSA id c1-20020a05600c0a4100b003d1e3b1624dsm10662692wmq.2.2022.12.12.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 06:25:13 -0800 (PST)
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-pci@vger.kernel.org,
        Alvaro Karsz <alvaro.karsz@solid-run.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/3] Add SolidRun vendor id
Date:   Mon, 12 Dec 2022 16:24:52 +0200
Message-Id: <20221212142454.3225177-2-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
References: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The vendor id is used in 2 differrent source files,
the SNET vdpa driver and pci quirks.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b362d90eb9b..33bbe3160b4 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3115,4 +3115,6 @@
 
 #define PCI_VENDOR_ID_NCUBE		0x10ff
 
+#define PCI_VENDOR_ID_SOLIDRUN		0xd063
+
 #endif /* _LINUX_PCI_IDS_H */
-- 
2.32.0

