Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BB7650892
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 09:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiLSIfY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 03:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLSIfY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 03:35:24 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410CE95AB
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 00:35:23 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso5835648wmb.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 00:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqrrdFR0yGu0+OvA2xJ/WZwnDOsQc12K4sxW6RZEG+U=;
        b=1VPk/0j1vwFjcWXN+D7MN9A9coTcbbGH05rafVceAXxqmaBwKqo6xBTJjt9tMe5urA
         S0Luc573uI5EeSg9LaMBNk5uVBTXVKy/ogHmNkMwavwQuH7D3r2R1BlHganekPxjTEQA
         sbEBnQZoxyx10G9oNRS3NNvAeJzYCAeG+npl+a2d+ZdpoZj3noG0GPii0Ahg+n0c6f8n
         JqU+SnedH11PVOYhTM3hUAwJ2s9jQgYoWh1+yrOmp4P4e53eP489zO+vjXQee6Z84rUT
         gGHoPiw5owuL9k5Zzxr6eaADWxgt5rUqFauEmuS9FGCVLuGriEWB/8a2aWy99OwG8fjw
         G5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqrrdFR0yGu0+OvA2xJ/WZwnDOsQc12K4sxW6RZEG+U=;
        b=xdhlItuvqdnn2cjE8mE+rp7L2dYxWllAtDb489vEAO7wjcpWk2I85tvYsJOZQyVlrn
         eo4Ug6xlLaNB+a9CHoiXlYakFrd5tVX7yaHMKBOwYWPtsLINReaR49E8JVheQeWGK2S3
         +bDBQUxKAm/fBFSrQ+ACgWuvntjqbainz+pN/N2TeQz7rZnJyX7B7vrN8uiUytYQl+de
         ROftmCNsXsFXIwldQT+Iqln7QRUJePi8lRPSIEs6qtpyhl+wZz2YtTLOOTEfhKv3ueSM
         PpWFB0kmJBweV31XCaZmsJL0sfSaaQMmxeUjtLthvTEJgC/EzhLfGY2gLdpvCCMAi0RA
         KNTQ==
X-Gm-Message-State: ANoB5pnDa0oHi9p0OgalRlSo84vHWPp9CFebwQXgUZdahTQfzj7jbNo4
        x8PPdzwMM6yL7LIaVf+IqgQDaw==
X-Google-Smtp-Source: AA0mqf7iRpS6BZHAjXZ8g5DKrHj0jEqXC5AIJHXWWXnNyoD5pvIxVXDZ74K0NZgxcMersI3Dy67KKw==
X-Received: by 2002:a05:600c:538f:b0:3d0:2485:c046 with SMTP id hg15-20020a05600c538f00b003d02485c046mr31592306wmb.27.1671438921724;
        Mon, 19 Dec 2022 00:35:21 -0800 (PST)
Received: from localhost.localdomain (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
        by smtp.gmail.com with ESMTPSA id z22-20020a05600c0a1600b003cfd0bd8c0asm11364246wmp.30.2022.12.19.00.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 00:35:21 -0800 (PST)
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
To:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: [RESEND PATCH 1/3] Add SolidRun vendor id
Date:   Mon, 19 Dec 2022 10:35:09 +0200
Message-Id: <20221219083511.73205-2-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
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

