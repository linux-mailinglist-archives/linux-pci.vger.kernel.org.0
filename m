Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6E73F3FAB
	for <lists+linux-pci@lfdr.de>; Sun, 22 Aug 2021 16:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhHVOCf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Aug 2021 10:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbhHVOCX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Aug 2021 10:02:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FEFC0613A4;
        Sun, 22 Aug 2021 07:01:36 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j14-20020a1c230e000000b002e748b9a48bso648127wmj.0;
        Sun, 22 Aug 2021 07:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cPtBI3PPGT+heXyTSOuBF8IkDPXmrhhweQDoLCyexsc=;
        b=uVg9Sku+7jGd+hrHzOD4hcHcYfiKMNT22+2nhv+9ANAVaMxiRnoh6YNMKgCBI0tuTv
         x12IcIENjQiQ3TClltNoBhp5A2koeXlVbvBmfTTIiQrAhL5yicxCcJYIgdEenlgy2SKD
         B88fr9VHJ6W8eLEQFUT8zJaWlLIZKjc/L5Ccr2EBIG0tTOeXBPnNxypB5SlMhaGqk/2k
         7/k4VEs0CGpq6vaJEJjjOIJ9PMNxRPV7V6YZWFKx5Kov58O8M0PZpweW3PYy5hiPiJbO
         cjpIkrQOZ8k2lSVcyRMP7fUu4rEXnMQ32iobbn6PZWaJx9YonRaOFuN1p4Pxbmv0aauD
         GfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cPtBI3PPGT+heXyTSOuBF8IkDPXmrhhweQDoLCyexsc=;
        b=SBJhUA5QYrdfaBC2u8hRAXO0hJNq66nB1ohN82N9wx4Kz6mPfrF0FHLkwpVLTFXSXN
         zaC4Yb1+tUf8et71DrcSRuNlEef8kbJGP1ia4eGdWr95xqGHYbHUdQMliSn7xIfcotcF
         tkhTzfIpxdy4vyxOYDkEU+vHjjMOnrku8iI39M8Q3N9S+FdeKOYx+8WnwGOBZ5CPeii/
         rCtRDJ9MsqF3ABu/k2ZzoIO7dVfz4f1CVrmjIUzfGo/TGUgrlEnY2SLIvf3rNB0XBubm
         X7Je+2L4ZEw6L+7Cz0zAqQlY1lN/ObDhPIwt8fKg2i1eRcYp70b7LL3CzrL5/lVGhY8R
         b3wQ==
X-Gm-Message-State: AOAM533mje3hUtr4WRZwQYmkhkkriXzkSEeFCvCvWoh4sESk2lItGlI9
        YZMRhpYnl9Ktx7FjTMoUDewJVyH57TMVpw==
X-Google-Smtp-Source: ABdhPJw7D1EYz8upsbDaCCTTIx2ihJoyPOIdRANdv35WHlosxJ2aoQY2Wb4ZnNUPQDUrFnaIj0IXgg==
X-Received: by 2002:a05:600c:35d2:: with SMTP id r18mr12354668wmq.116.1629640894947;
        Sun, 22 Aug 2021 07:01:34 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:fc53:5e22:f926:c43b? (p200300ea8f084500fc535e22f926c43b.dip0.t-ipconnect.de. [2003:ea:8f08:4500:fc53:5e22:f926:c43b])
        by smtp.googlemail.com with ESMTPSA id o14sm12033580wrw.17.2021.08.22.07.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 07:01:34 -0700 (PDT)
Subject: [PATCH 12/12] scsi: cxlflash: Search VPD with
 pci_vpd_find_ro_info_keyword()
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>
References: <1ca29408-7bc7-4da5-59c7-87893c9e0442@gmail.com>
Message-ID: <b5f71c97-61fb-86cb-6bec-84b042392ce7@gmail.com>
Date:   Sun, 22 Aug 2021 16:01:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1ca29408-7bc7-4da5-59c7-87893c9e0442@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use pci_vpd_find_ro_info_keyword() to search for keywords in VPD to
simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/scsi/cxlflash/main.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 2f1894588..b2730e859 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -1629,8 +1629,8 @@ static int read_vpd(struct cxlflash_cfg *cfg, u64 wwpn[])
 {
 	struct device *dev = &cfg->dev->dev;
 	struct pci_dev *pdev = cfg->dev;
-	int rc = 0;
-	int ro_start, ro_size, i, j, k;
+	int i, k, rc = 0;
+	unsigned int kw_size;
 	ssize_t vpd_size;
 	char vpd_data[CXLFLASH_VPD_LEN];
 	char tmp_buf[WWPN_BUF_LEN] = { 0 };
@@ -1648,24 +1648,6 @@ static int read_vpd(struct cxlflash_cfg *cfg, u64 wwpn[])
 		goto out;
 	}
 
-	/* Get the read only section offset */
-	ro_start = pci_vpd_find_tag(vpd_data, vpd_size, PCI_VPD_LRDT_RO_DATA);
-	if (unlikely(ro_start < 0)) {
-		dev_err(dev, "%s: VPD Read-only data not found\n", __func__);
-		rc = -ENODEV;
-		goto out;
-	}
-
-	/* Get the read only section size, cap when extends beyond read VPD */
-	ro_size = pci_vpd_lrdt_size(&vpd_data[ro_start]);
-	j = ro_size;
-	i = ro_start + PCI_VPD_LRDT_TAG_SIZE;
-	if (unlikely((i + j) > vpd_size)) {
-		dev_dbg(dev, "%s: Might need to read more VPD (%d > %ld)\n",
-			__func__, (i + j), vpd_size);
-		ro_size = vpd_size - i;
-	}
-
 	/*
 	 * Find the offset of the WWPN tag within the read only
 	 * VPD data and validate the found field (partials are
@@ -1681,11 +1663,9 @@ static int read_vpd(struct cxlflash_cfg *cfg, u64 wwpn[])
 	 * ports programmed and operate in an undefined state.
 	 */
 	for (k = 0; k < cfg->num_fc_ports; k++) {
-		j = ro_size;
-		i = ro_start + PCI_VPD_LRDT_TAG_SIZE;
-
-		i = pci_vpd_find_info_keyword(vpd_data, i, j, wwpn_vpd_tags[k]);
-		if (i < 0) {
+		i = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
+						 wwpn_vpd_tags[k], &kw_size);
+		if (i == -ENOENT) {
 			if (wwpn_vpd_required)
 				dev_err(dev, "%s: Port %d WWPN not found\n",
 					__func__, k);
@@ -1693,9 +1673,7 @@ static int read_vpd(struct cxlflash_cfg *cfg, u64 wwpn[])
 			continue;
 		}
 
-		j = pci_vpd_info_field_size(&vpd_data[i]);
-		i += PCI_VPD_INFO_FLD_HDR_SIZE;
-		if (unlikely((i + j > vpd_size) || (j != WWPN_LEN))) {
+		if (i < 0 || kw_size != WWPN_LEN) {
 			dev_err(dev, "%s: Port %d WWPN incomplete or bad VPD\n",
 				__func__, k);
 			rc = -ENODEV;
-- 
2.33.0


