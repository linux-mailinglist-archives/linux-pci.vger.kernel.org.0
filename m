Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A677F64158B
	for <lists+linux-pci@lfdr.de>; Sat,  3 Dec 2022 11:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiLCKFW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Dec 2022 05:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiLCKFV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Dec 2022 05:05:21 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D29084DE5;
        Sat,  3 Dec 2022 02:05:20 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id jn7so6764749plb.13;
        Sat, 03 Dec 2022 02:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x/r3VnLRNKlvnFOLPnqHI2MWeLV5SrohtoOoqqT5GvE=;
        b=hyLqiPkbvYSmVMwC6VBUIgwr8h0YBsagY8nmeJk5yE5kHhfaqHSwPEXHxg1OXXHWA3
         jg/QxCQmBcKtqcIhIXmRkke1+goIJX0puN6J0F9ryzhGDEfZIV3xH5rx3SSQCsdIshGy
         c5U/BCcn63Irkk7DWaUPw9IqKDnixOVHdNur8EcQz0j1KIn9i8zWx6nGWJEf9E3SOlkD
         ZJket1NQO86Ezj6us+7PWTm+rCl/jCYX2U2GBH3+Cr08k3D5g5RVk+K3Kz/BfnkU2FzB
         uXpdEDliCuhsurknN525qf7YAUeBNoj4asEvn6bOCaFrR5IQlUpnweTXOv8+P/Dj2Chb
         WTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/r3VnLRNKlvnFOLPnqHI2MWeLV5SrohtoOoqqT5GvE=;
        b=7e8XUTxmlHekOIHLv/eypIc51eI69swjqtFnJ5omMSesF/pGrht3qJ7+ROxd0q3DuB
         5MHpxYwgzQpVOm//7PHkdiLkbazIFn7OfQYRyStBJe+V2bLA1m1q3Ve12Nf9oWbuueQp
         phaOQ66geKrUDtOLVbqG4RbkNordwk5Tf6n58pC9oyqhQlHF2HhephckywJDAh84j2x2
         xmBueqTb0SRkp1v8gEkjSAyS2OzLcdXs9kYMRJhipfeebBeB49xLm15cfJTlDO5K9+R2
         EkpJhOzboAnyt2vZuAd3BYPJnI2Yrpq3DgbN65Hysrk8euL74uuUk6AKEWQnO8YpM/SZ
         x/FA==
X-Gm-Message-State: ANoB5pmoUnSHWqm2bvNkVq04EpjuAAqKULZb9njXURYniFoVppAnURqH
        kqF41cgQmk/bqeoAZ7qmtg4=
X-Google-Smtp-Source: AA0mqf7SzobPqbiOGmxwS/Pj7b6d3JJtTefcUFUOIy8gxFAnDU/PbeYpkIAJsVYXpvb9BMshrGNP+Q==
X-Received: by 2002:a17:90a:588b:b0:219:c40:e5f with SMTP id j11-20020a17090a588b00b002190c400e5fmr43075487pji.49.1670061919841;
        Sat, 03 Dec 2022 02:05:19 -0800 (PST)
Received: from debian.me (subs02-180-214-232-86.three.co.id. [180.214.232.86])
        by smtp.gmail.com with ESMTPSA id t68-20020a625f47000000b0056bbd286cf4sm6409661pfb.167.2022.12.03.02.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 02:05:19 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 2859710454E; Sat,  3 Dec 2022 17:05:14 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-next@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2] PCI/MSI: Use bullet lists in kernel-doc comments of api.c
Date:   Sat,  3 Dec 2022 17:05:11 +0700
Message-Id: <20221203100511.222136-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4457; i=bagasdotme@gmail.com; h=from:subject; bh=tMRwKw9TxrkL2IcmLsGSFrlkB1X/b5BgVI/JsijYRQ0=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMnd8uGbYy/Z2vE7HTOZcOBGeMb2rQkF6pIfbp7ayPW29eOs UMNXHaUsDGIcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjI80pGhjcrV1qwdskbOGhoOn8oad nuZH51e4z/l9uz1gW3PHx0YBIjw+ayP357p3fN3ZKxS+PxzByFsJWZ3pFuv69MsTFt7RJ+xA4A
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

Use bullet-list RST syntax for kernel-doc parameters' flags and
interrupt mode descriptions. Otherwise Sphinx produces "Unexpected
identation" errors and warnings.

Link: https://lore.kernel.org/r/20221121101245.23544-1-bagasdotme@gmail.com
Fixes: 5c0997dc33ac24 ("PCI/MSI: Move pci_alloc_irq_vectors() to api.c")
Fixes: 017239c8db2093 ("PCI/MSI: Move pci_irq_vector() to api.c")
Fixes: be37b8428b7b77 ("PCI/MSI: Move pci_irq_get_affinity() to api.c")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
[darwi@linutronix.de: Match subject-line with other subystem commits]
[darwi@linutronix.de: Remove verbose Sphinx log from commit log]
[darwi@linutronix.de: For C kernel-doc comments legibility, keep
 the flags and interrupt mode descriptions aligned.]
Acked-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---

 Changes since v1 [1]:
   * Slightly adjust patch subject to match other subsystem commits.
   * Add SoB from Ahmed S. Darwish due to applying his suggestions
     (is Co-developed-by: trailer more appropriate in this case?).

 [1]: https://lore.kernel.org/lkml/20221121101245.23544-1-bagasdotme@gmail.com/

 drivers/pci/msi/api.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 6c3ad4863850c3..2d46a0cfd54100 100644
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
+ *            * %PCI_IRQ_MSIX      Allow trying MSI-X vector allocations
+ *            * %PCI_IRQ_MSI       Allow trying MSI vector allocations
+ *
+ *            * %PCI_IRQ_LEGACY    Allow trying legacy INTx interrupts, if
+ *              and only if @min_vecs == 1
+ *
+ *            * %PCI_IRQ_AFFINITY  Auto-manage IRQs affinity by spreading
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
+ *         * MSI-X     the index in the MSI-X vector table
+ *         * MSI       the index of the enabled MSI vectors
+ *         * INTx      must be 0
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
+ *         * MSI-X     the index in the MSI-X vector table
+ *         * MSI       the index of the enabled MSI vectors
+ *         * INTx      must be 0
  *
  * Return: MSI/MSI-X vector affinity, NULL if @nr is out of range or if
  * the MSI(-X) vector was allocated without explicit affinity

base-commit: 3170a767052ac5432547a2d8c9d4753d82b45f38
-- 
An old man doll... just what I always wanted! - Clara

