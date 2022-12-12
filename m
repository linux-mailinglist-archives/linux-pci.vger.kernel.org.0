Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B045364A337
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 15:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiLLOZU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 09:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiLLOZT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 09:25:19 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399991146F
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 06:25:18 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso3777517wmp.3
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 06:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52hahNbuRY46XgQIVISXaE7JbKxYGWL9g99K9Ci+IBU=;
        b=xjna6vofYa36kDqm1KkQaqL6P7ic6GSEwQLiVUkL46IvkvCEQQIB9pCZGgtOVydMBF
         MbR+H12gasTuiTOlTWuj/Wb8F2gmE77a9yCFyjVrWXHccQZF/t7ZbEJ00uLlNSyxXc2p
         PGh+Ljh8QkuQIP1XqHo0d6gE8gdkMP0TR7tqdvu2pX7Xnh/2rwleOgybj3CoH1ZZ8XZ4
         N0JJR4DDvrp3dO4SxJS96Fr94Z1bkr+7+sneinQNGEOBuTwunSFkfaztSdYYTItaTaNj
         ycylFAHMG87FbbBerCACG0TjYaZUlOgnqd0OEkxKDG8v630n5bQuOuuBxBF06ILNtKnZ
         1vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52hahNbuRY46XgQIVISXaE7JbKxYGWL9g99K9Ci+IBU=;
        b=bzSuveQJ4I8AhznojfROXGBil5qatEjVlJLMZ4Suz2zhN+kdXy/ZZcCsWhV3F/HZ7h
         yo+YJwEUQFWfzyEVpsmxtzFABE/7AbPGBYrgr/UKvOhY0H+wdY8Dzrz3JgDFdgVwDgNb
         gVBYHY0seirkFXjEdG9KROl5RWWLWIVCxL516clj6RVPq4Uo1+3s2oZrFzBKVnZlL6YD
         6ygk7I+yMXKJo1g9+SxEHuYiaxms8pGiadgmrT00Uv2FrQhVgDDKMc0PPW0JK36x32Tj
         V/K65OkajnFN69tyoowm8gDvV/R8ghupwns9Ls9UJQEzWIz5VE+qV2MvWYLOIaDmJ/aT
         eohQ==
X-Gm-Message-State: ANoB5pntGxOnjJIpLuPJN+JERsB0f684U8D/cfz0ZTiJCpbwv2mUUuUh
        Je5FN0QUz6Ldl15WZZe1nW40/g==
X-Google-Smtp-Source: AA0mqf7Rbz+fsLVVWtiJM5oVf640BJBhVAU/1ZqVtTRZzGtLSTgeTmDr2NvJNFQJH9JioRd4yw+gKQ==
X-Received: by 2002:a05:600c:a11:b0:3d2:2a74:3a90 with SMTP id z17-20020a05600c0a1100b003d22a743a90mr1746339wmp.22.1670855116751;
        Mon, 12 Dec 2022 06:25:16 -0800 (PST)
Received: from localhost.localdomain (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
        by smtp.gmail.com with ESMTPSA id c1-20020a05600c0a4100b003d1e3b1624dsm10662692wmq.2.2022.12.12.06.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 06:25:16 -0800 (PST)
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-pci@vger.kernel.org,
        Alvaro Karsz <alvaro.karsz@solid-run.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/3] New PCI quirk for SolidRun SNET DPU.
Date:   Mon, 12 Dec 2022 16:24:53 +0200
Message-Id: <20221212142454.3225177-3-alvaro.karsz@solid-run.com>
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

The DPU advertises FLR, but it may cause the device to hang.
This only happens with revision 0x1.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 drivers/pci/quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 285acc4aacc..809d03272c2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5343,6 +5343,14 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
 
+/* FLR may cause the SolidRun SNET DPU (rev 0x1) to hang */
+static void quirk_no_flr_snet(struct pci_dev *dev)
+{
+	if (dev->revision == 0x1)
+		quirk_no_flr(dev);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOLIDRUN, 0x1000, quirk_no_flr_snet);
+
 static void quirk_no_ext_tags(struct pci_dev *pdev)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
-- 
2.32.0

