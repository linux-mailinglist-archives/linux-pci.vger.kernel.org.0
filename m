Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D696646B9
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 17:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbjAJQ5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 11:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238603AbjAJQ5A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 11:57:00 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D481CF3
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 08:56:59 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d17so12470884wrs.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 08:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NOZUXey1qu1DXnDXCB3ax9qkfzwnIbFIlklzJ8G9G0=;
        b=pgfxQPhMkMsZ65vs7lXnIMK6H9EDoUjlucyTmQvsBs3zKpN1hGy19i72uLMus0rH5t
         ZDVRD6gjUG/Vi6IvdUV72+3M0js87j55xbvEFEO888B12k9SbW8UndIA1qQhYCPYv30/
         XawQv4lNdYdPjQtim8RBz2bKGOwBaDVQq6Yh0y1NzWTNTwkfVLNqUKrCvh2HR0jlJSob
         v14D+6CYR4Mxjd4itPFvxIFyUC7a6zaITdWgfaTzdwm2Izm94qX8I72Q3JzyArbhVEde
         jYm4E861NOkFeWidecEvymZwTVuig0SuccjjUjfqmIUZSeM/5tqL+GXvX6XSH7pHNoVK
         xfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NOZUXey1qu1DXnDXCB3ax9qkfzwnIbFIlklzJ8G9G0=;
        b=pq8w1QsFki20//Llu5t0A9fx/rgo000os3qFaO45LgxuQwTL5/IEbHwnvblP7s7OuE
         bVurwPbbzKY0V22fjqDQGb/GV9gv88oKySvtwjGZTbnRQ6BQ5pLBhT0oTRpHmPKd1IzK
         j2MsRGAJrRRymaBxOlL18VbQkoFwf7NANyA71RfAC3Z9ejpQwLqL7m0BEom6dn7obPdS
         6Kqp4kXQaw3faVFFlXgz9J6NARAtHiDz7b10q3bu5sw1gOu33+LLmdMH6EH1GVvklGRw
         fXT6ugyuIlTGfigBvJ9TOlD69TMdW+CPc4PFV5Aub+AyxN6ChNcc3uRzu7HQfVual6Ag
         brww==
X-Gm-Message-State: AFqh2kriP5ymohv/Q1asBfZnzG26LRLa7nr/hYJzKiWiYfd8EM4DxTQn
        Y7sdIJKKwbCJAHqfiP0DOKSCK/Ie3doByHhl
X-Google-Smtp-Source: AMrXdXtEGQl0JOhK8lc5tXKJn3oaRaXcptGLzyKh48IRPbE+dHREc6xHFYg3ICRAIJ36/0T/f0YTkQ==
X-Received: by 2002:a05:6000:d0:b0:29a:555d:2436 with SMTP id q16-20020a05600000d000b0029a555d2436mr19454603wrx.31.1673369817200;
        Tue, 10 Jan 2023 08:56:57 -0800 (PST)
Received: from localhost.localdomain (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
        by smtp.gmail.com with ESMTPSA id q11-20020adf9dcb000000b00268aae5fb5bsm11918066wre.3.2023.01.10.08.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:56:56 -0800 (PST)
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
To:     linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, helgaas@kernel.org,
        Alvaro Karsz <alvaro.karsz@solid-run.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v9 2/3] PCI: Avoid FLR for SolidRun SNET DPU rev 1
Date:   Tue, 10 Jan 2023 18:56:37 +0200
Message-Id: <20230110165638.123745-3-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230110165638.123745-1-alvaro.karsz@solid-run.com>
References: <20230110165638.123745-1-alvaro.karsz@solid-run.com>
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

This patch fixes a FLR bug on the SNET DPU rev 1 by setting the
PCI_DEV_FLAGS_NO_FLR_RESET flag.

As there is a quirk to avoid FLR (quirk_no_flr), I added a new quirk
to check the rev ID before calling to quirk_no_flr.

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

