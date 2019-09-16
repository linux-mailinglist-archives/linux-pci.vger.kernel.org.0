Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1EBB4258
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 22:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391441AbfIPUrd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 16:47:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39044 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfIPUrd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:47:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so836298wrj.6;
        Mon, 16 Sep 2019 13:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=epEuwg1xdHKPnwPm1RSe5GQMDsYIT9iwwxBPtEKOzsY=;
        b=VH/BPBRoJc2UtuPBlt6h893+Rb9g0zeYgYN+IGMRAoi1+e2d3EHKAr6Fgwk6fPENN6
         +JXy+fEBrgtbId09z3/S3BKJQlr9XkHysn+cSrq6PhRt+U4M1Zc35IAHaw3vUxEBBubV
         42C4P60Q1W2jLtiP7sr5ehVCMMbsbRqk4z10rpMJLNEgAmHjuzlEGvKxsFhx9SnTCNUV
         3WSfIpOrOWzpGv/VJTKLZOCaaK4PnPtCNHQCc2Q9lgD0lSXq12TVRTBbr4VpDTWZ7Pcq
         1G8ETfuPaAguNOwm8rGNfH10nJ6B1SgxyIAFevQsQ1zgaaVYZZ/0L7z7tOyuvSDC80hr
         EN7g==
X-Gm-Message-State: APjAAAXK8slm0U3Uqb+VDWcqAMxFffDwPR+YAsnYrM6CkeqTRK+35g6s
        KU2jr7jm3dwEEhuOFTEMHZg=
X-Google-Smtp-Source: APXvYqzUQ8ilo7HfmXcpWyMR/2qbH1CpYDfMJItElWXHm2aMMFZcq3bt10sbQbWR1+fPh2AtB2M7Mw==
X-Received: by 2002:adf:ab0b:: with SMTP id q11mr212288wrc.336.1568666851199;
        Mon, 16 Sep 2019 13:47:31 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:47:30 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        linux-scsi@vger.kernel.org, Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v3 18/26] scsi: pm80xx: Use PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:50 +0300
Message-Id: <20190916204158.6889-19-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the magic constant (6) with define PCI_STD_NUM_BARS representing
the number of PCI BARs.

Cc: Jack Wang <jinpu.wang@cloud.ionos.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c  | 2 +-
 drivers/scsi/pm8001/pm8001_init.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 68a8217032d0..1a3661d6be06 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -1186,7 +1186,7 @@ static void pm8001_hw_chip_rst(struct pm8001_hba_info *pm8001_ha)
 void pm8001_chip_iounmap(struct pm8001_hba_info *pm8001_ha)
 {
 	s8 bar, logical = 0;
-	for (bar = 0; bar < 6; bar++) {
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		/*
 		** logical BARs for SPC:
 		** bar 0 and 1 - logical BAR0
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 3374f553c617..aca913490eb5 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -401,7 +401,7 @@ static int pm8001_ioremap(struct pm8001_hba_info *pm8001_ha)
 
 	pdev = pm8001_ha->pdev;
 	/* map pci mem (PMC pci base 0-3)*/
-	for (bar = 0; bar < 6; bar++) {
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		/*
 		** logical BARs for SPC:
 		** bar 0 and 1 - logical BAR0
-- 
2.21.0

