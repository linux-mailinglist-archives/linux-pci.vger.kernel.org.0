Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDCA5EDAF3
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 13:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiI1LBp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 07:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbiI1LA4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 07:00:56 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096C0A1A67
        for <linux-pci@vger.kernel.org>; Wed, 28 Sep 2022 04:00:29 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f193so11933697pgc.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Sep 2022 04:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TvC/ALrxAJSA8jgElYrPaDlRpGjWvJ+S5PU3u9AGQW0=;
        b=wC+q4gRayIrrojd5NNz/4k7eSkzCZifqS791bKfvn1KPZjMCq4khGbNFBM+HJO9Moh
         SDZIxqn2z1ZKYCLxC+8vBo+XConeT223VVXe2zkEJ3WNxA47YbRu87WrN1Xu0y76Y4XU
         WHH7KC6eNBVqibeF+Y+M7JWgrw0pPmjVRDWLSvzU2XUb5Jm/cJSyUSwvOmgOhPEiNOTS
         jHAY5J9OTHvpi4EMLOq6zkJ+Al16ABpJ0+awGZonyn0TdixlwEhZzu/OtcwnRHT2Chr/
         tyDl8tzD+WlEFr9PKwgHpJyh5RB/1G1+t7YHi3WFxpkjrrCGfOTY216lm4YjBX6ZrOfK
         bqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TvC/ALrxAJSA8jgElYrPaDlRpGjWvJ+S5PU3u9AGQW0=;
        b=d9BvpKyt8qJMt+fAAGhQaoD82++4QeYBStrMgFc+mvnrU5NfX1q08WbXI9eJKlPRBu
         Qhwa5Y6LZJ42VE/emoo7oBeWVdvYHIvp4e00UipKoJri+RlmdCyjd3mO8rWYPgrqNyX3
         idk7fr5qMIoDxAjyR04W+ktKnKeMfRRwciJ63YovYyh3go0OseykcGusNpraA16jgLHC
         Obt/JLYfckHAAfamC8vnMrUdga2yka/pRDkNdDPEcnpnBr2tdqs6I3UFcb9AVIVWV3iM
         weUYNvG4Sy/y+U+UMK/aXw7fMxmTyPwkO8PeKoUTgoFG8KCeBQcYQTvK2bYhtbCX+oIC
         Zg5Q==
X-Gm-Message-State: ACrzQf0bygvkyLAzOvmEUexF7j57wimHaFOtXXTEJ2wdo1TnwfVtlfdc
        KkPC6viukWHklEJMHwhNrAGHjQ==
X-Google-Smtp-Source: AMsMyM7bWfktbsleKoDwZH3+i0nno4js4FOHZ9d6s4pKKsRup/J0ok5b6UIhDd+31p7y1B8DxaaKWg==
X-Received: by 2002:a63:4408:0:b0:439:befa:3d47 with SMTP id r8-20020a634408000000b00439befa3d47mr27860398pga.64.1664362829108;
        Wed, 28 Sep 2022 04:00:29 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d50d00b00177efb56475sm1539524plg.85.2022.09.28.04.00.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:00:28 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: [PATCH v3 4/9] scsi: lpfc: Change to use pci_aer_clear_uncorrect_error_status()
Date:   Wed, 28 Sep 2022 18:59:41 +0800
Message-Id: <20220928105946.12469-5-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
References: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
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

lpfc_aer_cleanup_state() requires clearing both fatal and non-fatal
uncorrectable error status. But using pci_aer_clear_nonfatal_status()
will only clear non-fatal error status. To clear both fatal and
non-fatal error status, use pci_aer_clear_uncorrect_error_status().

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/scsi/lpfc/lpfc_attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 09cf2cd0ae60..d835cc0ba153 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -4689,7 +4689,7 @@ static DEVICE_ATTR_RW(lpfc_aer_support);
  * Description:
  * If the @buf contains 1 and the device currently has the AER support
  * enabled, then invokes the kernel AER helper routine
- * pci_aer_clear_nonfatal_status() to clean up the uncorrectable
+ * pci_aer_clear_uncorrect_error_status() to clean up the uncorrectable
  * error status register.
  *
  * Notes:
@@ -4715,7 +4715,7 @@ lpfc_aer_cleanup_state(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	if (phba->hba_flag & HBA_AER_ENABLED)
-		rc = pci_aer_clear_nonfatal_status(phba->pcidev);
+		rc = pci_aer_clear_uncorrect_error_status(phba->pcidev);
 
 	if (rc == 0)
 		return strlen(buf);
-- 
2.30.1 (Apple Git-130)

