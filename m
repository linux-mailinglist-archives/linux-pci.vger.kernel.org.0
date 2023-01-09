Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF295661F9F
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 09:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjAIIF0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 03:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjAIIF0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 03:05:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4401913D78
        for <linux-pci@vger.kernel.org>; Mon,  9 Jan 2023 00:05:25 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m7so7272629wrn.10
        for <linux-pci@vger.kernel.org>; Mon, 09 Jan 2023 00:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGPSxy7QLFpAMcyajFwTiQmrNr019Rt19d70cLX622A=;
        b=aQDUM7y3VoRimkBLQS+6D4F4ZZhqgi2OHhGkLKLLZZflWAvld4qDM8kamEtpgCSm+s
         kfRG4gKuhq5PN3Zb6sTqxkGm8p1bACjLaCXcvp6il7e0HmQ9qyFrxUiiUm3Mw0PZjjrd
         PycwgBeOSBwmiL7Zb00HJWwmL8gNJrxHAAsJBKhHsgIK7dtmusVH3FnDDGCeLIYJwR3h
         AkslaDFQR7WhZIbyYx0hKZl0eqdmQqFM2T68Hke8sEBBGha7gTx/wzc/5NBs/fTppEWH
         y7tHNKsbpZ8RCfGkHfMjUN0L+uDN0ok7Bg03U9AWO9aGUXIW5tgB21cTH5shLg4ZieeJ
         hQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGPSxy7QLFpAMcyajFwTiQmrNr019Rt19d70cLX622A=;
        b=kAcy/CFWHrVTTslw6+C8LksvPmLKVTYKDr81kjwsB/0QSmMPhcPusUaCnwWRfyW6Tx
         o7ODyJRHVUbX0h8YdRsKCoafgtT6nuIoHVtMtjST4OwuaHcDp6oNbtsoatfvPoKi7Dw/
         NOn75XZ7XtQ5NWDqVCa/5N07MIINcr6FXspZ2NGm2mK97Rqfa87PIf80wWiaSHcjkd5v
         Wo5ZkFA2C2Znd5h2wzWk6pH/4xJ46CXBrrYd6/CdTtzdJFLstfvVhh1/xA8NI5yCd5Ay
         ZYE+C3NfwlES9IxcEqRwEIRhCpDzT78OnhLJG3AgeOUfFDZuax+DapkZuS6VGL+qcTAf
         0Nfg==
X-Gm-Message-State: AFqh2kqEav0ZNDptw8KZHHZ7t5kMx125YO2M15Rm2vkpeWoTBG2xtv0L
        Vsvl9c4yVBjv8QjZPyQi1ByLRQ==
X-Google-Smtp-Source: AMrXdXv4NWKNzfM/eWUIfTwSf/GRmZt7LJRTM3llNMRyanTQj8SZn+0wFN15+7Gl2nyIn11zdd/3Ow==
X-Received: by 2002:a5d:4bc1:0:b0:2bb:7a1a:aeba with SMTP id l1-20020a5d4bc1000000b002bb7a1aaebamr4488868wrt.49.1673251523748;
        Mon, 09 Jan 2023 00:05:23 -0800 (PST)
Received: from localhost.localdomain (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
        by smtp.gmail.com with ESMTPSA id i2-20020adfdec2000000b002b9b9445149sm9191153wrn.54.2023.01.09.00.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 00:05:23 -0800 (PST)
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
To:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, mst@redhat.com,
        Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: [PATCH v8 2/3] PCI: Avoid FLR for SolidRun SNET DPU rev 1
Date:   Mon,  9 Jan 2023 10:05:20 +0200
Message-Id: <20230109080520.1155220-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
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

This patch fixes a FLR bug on the SNET DPU rev 1 by setting
the PCI_DEV_FLAGS_NO_FLR_RESET flag.

As there is a quirk to avoid FLR (quirk_no_flr), I added a new
quirk to check the rev ID before calling to quirk_no_flr.

Without this patch, a SNET DPU rev 1 may hang when FLR is applied.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
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
