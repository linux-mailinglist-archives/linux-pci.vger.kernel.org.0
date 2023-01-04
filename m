Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D316165CE80
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 09:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjADIn0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 03:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbjADInZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 03:43:25 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198B518B08
        for <linux-pci@vger.kernel.org>; Wed,  4 Jan 2023 00:43:24 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bs20so30117212wrb.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Jan 2023 00:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NbUaUyK4DKiN/LpC1zIoNCyihOmH2oj+soivrwgnCFw=;
        b=zD2tk5KYVwqDd0XbyT9/dIPgu1n+ubbYN50TYIDXU6wtuc/7Nqcd5uHMm0dog4vZWs
         SwtYwVudA9Vq1wO3L8t5YwDA1XW6oGyERTtwKrAyJn6oGzbomMa5jpXCDNXMQacOpVks
         W6Z4HPwp7CNq8bXhGufEj+hoyNULWkWS9Wg1DBeEIxA6i6+ae2tAHLTB3a/UPjtnzzVs
         zxLhsOLLBL2sw9A/rlkhIbY4szxSYDEW/9+fypw9UVqCdfU0JxNH5vw5EeTt+GyKSzT7
         a1ls1O4y3v9paGX7vJaJSKR7fgGtX8ptwhEl2U8aqJVPRc7remEAbxZm4b+nIi3PIdcX
         kLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbUaUyK4DKiN/LpC1zIoNCyihOmH2oj+soivrwgnCFw=;
        b=lyeBKB/OGoa2NHd1KEzSp132e8Ww6UU3iE5maa+xAc3277KFLXJhv80w4mcsnxcxNI
         DN40lxPHQ8jMcFwgvSrdJcfhKdgMgahNq3zB91xeWD/rvbjdBSTTo9UZsRQvcReQsQDh
         vidnmi3QeYSGdMgf/C6G033vf/dKvHCh6LYWp5D3coVvzbYYOvBUC6B3OUP3keUkM0e+
         xrcCtwPDVJm3crvukgH8qwfNKaAE2VEKoKWrl5V3RdswFS3a8u2YL+KxeJPyj+fT5aF7
         3UpeMCeSPoFQLXBoeZ5ZnJjw3rYEXpq25yXEvo8jedNIrnIRAUwbnVU+8JYYzmO0eXmG
         nNIQ==
X-Gm-Message-State: AFqh2krUTkJNyyUJa2O2eMyc4YbaAXF2h7OVKKk8eeElkgZZLSi0K6+d
        DQ/ifpuia+Vcd/b3rhZgP6ppqODBXC1i+wao
X-Google-Smtp-Source: AMrXdXvKI2KtgTMvsitFeIbf8S31N5ntyLmhr055G3WQ4mc6X6RxeEknD7F+5dP4wOj4/S3KEeQo1w==
X-Received: by 2002:adf:ecc8:0:b0:26a:5040:78f6 with SMTP id s8-20020adfecc8000000b0026a504078f6mr31955983wro.46.1672821802627;
        Wed, 04 Jan 2023 00:43:22 -0800 (PST)
Received: from localhost.localdomain (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d468d000000b00275970a85f4sm31176189wrq.74.2023.01.04.00.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 00:43:21 -0800 (PST)
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
To:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, mst@redhat.com,
        Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: [PATCH v2 2/3] PCI: Avoid FLR for SolidRun SNET DPU rev 1
Date:   Wed,  4 Jan 2023 10:43:19 +0200
Message-Id: <20230104084319.3424462-1-alvaro.karsz@solid-run.com>
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
--
v2:
	- Update patch subject to be more meaningful and similar to
	  previous quirks.
	- Update the commit log to describe better what the patch does.
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

