Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAF8631DE5
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 11:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiKUKNF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 05:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiKUKNA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 05:13:00 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCBFBF41;
        Mon, 21 Nov 2022 02:12:59 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id g10so10131132plo.11;
        Mon, 21 Nov 2022 02:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcrfVzbVII/ixGjW6CzVs+lFc79Nuwer3t6F4w1cDOc=;
        b=qe0/1odAvG1U4tkPC+b1tQpKv/R4kNC8LqG1JsbtP1wjrD1R7uiDuTHJlQG9s94tUN
         pSVcDGKuezB3YA0zR+DCbSpZKONwxdFDvlNZQyQfxDO2rS3lK50kZj7rhbykDHX6p8Dd
         019VpLsO1oJTAXVbjgB6UkPOnnFPQKhEhzZe8BSJ5rQgtT7bn5Nc6NeSmlLtxc3W+RLs
         GqdXaBn8ozP9QGmC0O9dp8YPwjffeSJOf6F9DiYVFshSP3TYFD1IQ/no/UM42zt6L/8Y
         7JMkOPXVaZ/lBtl43hfJ66qLauYVyuXgO7b5luKyUhAjuQpHQ2BIMwLSA629xGS2Q7jw
         Tliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcrfVzbVII/ixGjW6CzVs+lFc79Nuwer3t6F4w1cDOc=;
        b=42vxU9tZhska9TC4d0Oih3EYjrCIyz9PgSth/LwyRyok6NE1VMY0O4iVqjZlJASdhN
         lZjOURMhRP+F2rDJNtgYy+XKepElEt0MTCO9b4rIqHavoIUCVUox+OtMRML3VoTdTwOm
         1xIB0hesvMR8LlVQez3x1qMr4lKGx9Z8PXR33dSQeHOrRZ6pleDeZtNXBb1lapdayqIN
         uccbDeribD4cT8WBL299+Jaa57Hup6RDQttFUBgoAA1iG/7+qNaoV0t2sZVRMwz+oMQ4
         ax59uDo/9tNuHbuQ5Et2kBlHgrwGF4xN/xmujghuAQrCudxhOa6J2VyCBXRgS5J9V6HM
         tgYA==
X-Gm-Message-State: ANoB5pn9q33bHBZyCceLO0RjSuA4sAM59NCd/BNGCne/aU1gk1Uc8lK9
        mulHhQnR4LMkCBPdqi2KG0SMNjWGi4M=
X-Google-Smtp-Source: AA0mqf4X7XAJHYWZmsY4H/BNdfWBj2mucoOk/+euz4wnJWV5PHenEU1N5UF1Co84wGl8RXfwilPrwQ==
X-Received: by 2002:a17:902:e80f:b0:186:f4ba:a817 with SMTP id u15-20020a170902e80f00b00186f4baa817mr3271250plg.97.1669025578623;
        Mon, 21 Nov 2022 02:12:58 -0800 (PST)
Received: from debian.. (subs02-180-214-232-69.three.co.id. [180.214.232.69])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b0017f5ad327casm4522235plb.103.2022.11.21.02.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 02:12:58 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] PCI/MSI: api: Use bullet lists in kernel-doc comments
Date:   Mon, 21 Nov 2022 17:12:45 +0700
Message-Id: <20221121101245.23544-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121184100.0974cc35@canb.auug.org.au>
References: <20221121184100.0974cc35@canb.auug.org.au>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4119; i=bagasdotme@gmail.com; h=from:subject; bh=k7u8QF68GBXH09CAMJK6Ok/Q+l2nHiOrmGnVIIIvZXo=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMnV/rKHN1ycvSDhlCez8+YTRvVrnrVsuco0da2Tv90jjeO7 XLiWdJSyMIhxMMiKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiWV6MDAvCbO/P3zef/+jCnVUXuW 7nsszaV8Fw4XTT8fvca9Y1hlcz/BU+FuZ9XubSl2J79vBajXciHWpJvI/rxD5MmlKuteS8Ox8A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Stephen Rothwell reported htmldocs warnings when merging tip tree:

Documentation/PCI/msi-howto:380: drivers/pci/msi/api.c:148: ERROR: Unexpected indentation.
Documentation/PCI/msi-howto:380: drivers/pci/msi/api.c:149: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/PCI/msi-howto:380: drivers/pci/msi/api.c:236: ERROR: Unexpected indentation.
Documentation/PCI/msi-howto:380: drivers/pci/msi/api.c:259: ERROR: Unexpected indentation.

Use bullet lists syntax for pci_disable_msix flags and interrupt mode lists
to fix these warnings.

Link: https://lore.kernel.org/linux-next/20221121184100.0974cc35@canb.auug.org.au/
Fixes: 5c0997dc33ac24 ("PCI/MSI: Move pci_alloc_irq_vectors() to api.c")
Fixes: 017239c8db2093 ("PCI/MSI: Move pci_irq_vector() to api.c")
Fixes: be37b8428b7b77 ("PCI/MSI: Move pci_irq_get_affinity() to api.c")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/pci/msi/api.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 6c3ad4863850c3..d48c21295a88c6 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -142,12 +142,15 @@ EXPORT_SYMBOL(pci_disable_msix);
  * @min_vecs: minimum required number of vectors (must be >= 1)
  * @max_vecs: maximum desired number of vectors
  * @flags:    One or more of:
- *            %PCI_IRQ_MSIX      Allow trying MSI-X vector allocations
- *            %PCI_IRQ_MSI       Allow trying MSI vector allocations
- *            %PCI_IRQ_LEGACY    Allow trying legacy INTx interrupts, if
- *                               and only if @min_vecs == 1
- *            %PCI_IRQ_AFFINITY  Auto-manage IRQs affinity by spreading
- *                               the vectors around available CPUs
+ *
+ *            * %PCI_IRQ_MSIX - Allow trying MSI-X vector allocations
+ *            * %PCI_IRQ_MSI - Allow trying MSI vector allocations
+ *
+ *            * %PCI_IRQ_LEGACY - Allow trying legacy INTx interrupts, if
+ *              and only if @min_vecs == 1
+ *
+ *            * %PCI_IRQ_AFFINITY - Auto-manage IRQs affinity by spreading
+ *              the vectors around available CPUs
  *
  * Allocate up to @max_vecs interrupt vectors on device. MSI-X irq
  * vector allocation has a higher precedence over plain MSI, which has a
@@ -232,10 +235,11 @@ EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
  * pci_irq_vector() - Get Linux IRQ number of a device interrupt vector
  * @dev: the PCI device to operate on
  * @nr:  device-relative interrupt vector index (0-based); has different
- *       meanings, depending on interrupt mode
- *         MSI-X        the index in the MSI-X vector table
- *         MSI          the index of the enabled MSI vectors
- *         INTx         must be 0
+ *       meanings, depending on interrupt mode:
+ *
+ *         * MSI-X - the index in the MSI-X vector table
+ *         * MSI - the index of the enabled MSI vectors
+ *         * INTx - must be 0
  *
  * Return: the Linux IRQ number, or -EINVAL if @nr is out of range
  */
@@ -255,10 +259,11 @@ EXPORT_SYMBOL(pci_irq_vector);
  * pci_irq_get_affinity() - Get a device interrupt vector affinity
  * @dev: the PCI device to operate on
  * @nr:  device-relative interrupt vector index (0-based); has different
- *       meanings, depending on interrupt mode
- *         MSI-X        the index in the MSI-X vector table
- *         MSI          the index of the enabled MSI vectors
- *         INTx         must be 0
+ *       meanings, depending on interrupt mode:
+ *
+ *         * MSI-X - the index in the MSI-X vector table
+ *         * MSI - the index of the enabled MSI vectors
+ *         * INTx - must be 0
  *
  * Return: MSI/MSI-X vector affinity, NULL if @nr is out of range or if
  * the MSI(-X) vector was allocated without explicit affinity

base-commit: 15ce088a8698c22cf5a18799dda16f04ed1d1cb7
-- 
An old man doll... just what I always wanted! - Clara

