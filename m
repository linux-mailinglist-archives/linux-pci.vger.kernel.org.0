Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDD6650893
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 09:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiLSIf1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 03:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiLSIf0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 03:35:26 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6406795AF
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 00:35:25 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m5-20020a7bca45000000b003d2fbab35c6so5790453wml.4
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 00:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52hahNbuRY46XgQIVISXaE7JbKxYGWL9g99K9Ci+IBU=;
        b=ZC2FKqerEx9qtzZe4J4ankTEh1eSrRfgETY+4/nQ0oIs8wjZB/j3Cl2rRu5mOQxl81
         2dQ0eldmSXHiDLFBg0ATvMwlUo1VVMG9Pr8Fzk9kMdZS0CB6U7jXFRKzxAMTulv7ZK5h
         8mkdyHWaHH4lzYBYsNAyGwOobpcicnii30ArLhIMP3Oejm4dg6HmzOrOIpuyU+dHGcEa
         9lDtew1A6vlKQxzEcwFShZPwLJ6V1ffzxkGhVuKLxVVb52Go7TL4qLNbNKqWIa5nynmW
         5PpzzvEEQaVxQnc8nFm/kxKJKdrixhWKfhrC5HmugUgKUXDm5ck10E97z004LUG7c8by
         VsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52hahNbuRY46XgQIVISXaE7JbKxYGWL9g99K9Ci+IBU=;
        b=zKnVz1sMClTkNQGcue/ivQH8/zYq0BwukpfeYnr4J4zrtdB0CihPBCYuQm+HkgACH+
         ClQtF4py3IJJPpriIS5ssBPVPrdMCcWMJjF8q5/+BN/kiyM3/PM6s5EVwYcRN3vLf0uk
         afraQyuaZLWJalSzrGXUtXZ9sIJZ7dXZmkhToSlZ54C/ibF/wmDyZ9VuzHOFUbcKj0mq
         eGE+FGYkZW54dibgWVO0WqcyMcepmrSa3y6VRSX89RV0+RMo6kZb/TNdGJ/AowuANrFx
         yYX5uAV11HkE0Ju22NKtqqEr0uJkBKKg12XTlRJracyMDuMDX1iLLDGT7drPWOHtIsgP
         BYCQ==
X-Gm-Message-State: ANoB5pkgDIAUKsz2DbbgGNYZFyHJUyAevFbuI4zpNbQxVimqwP7zw6vz
        n6qf2movwmkH98RK+WdKZpZf/TPAmhyRzjrK
X-Google-Smtp-Source: AA0mqf7hYnzbIjb0nIp00iP7pAjJnjsCKyBOTShmIdjjr3HBawJcGzuQHqMBYyp4OiBpU8AkoGI4dw==
X-Received: by 2002:a05:600c:3b93:b0:3d2:3e75:7bb9 with SMTP id n19-20020a05600c3b9300b003d23e757bb9mr12920522wms.34.1671438923815;
        Mon, 19 Dec 2022 00:35:23 -0800 (PST)
Received: from localhost.localdomain (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
        by smtp.gmail.com with ESMTPSA id z22-20020a05600c0a1600b003cfd0bd8c0asm11364246wmp.30.2022.12.19.00.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 00:35:23 -0800 (PST)
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
To:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: [RESEND PATCH 2/3] New PCI quirk for SolidRun SNET DPU.
Date:   Mon, 19 Dec 2022 10:35:10 +0200
Message-Id: <20221219083511.73205-3-alvaro.karsz@solid-run.com>
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

