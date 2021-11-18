Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB33D455D8B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhKROMK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbhKROMJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:12:09 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883ADC061570;
        Thu, 18 Nov 2021 06:09:09 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id m14so6116125pfc.9;
        Thu, 18 Nov 2021 06:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gBBH/Q+4DT6MMFzudxxMo6qTH2zDvIqJYCuHRS/x8Gs=;
        b=h4pBbCLrdpXpef+w/kUpZbJP1X3ldT63Q8bGt/bh2RhSlt94aUaf0PVnzja8+EzyiX
         5iYMNQKu/SyG4Nub6ksbx6VzPbGJRE/BZuFwnSSp+NgUjuqj2NhPYTKPM4zl6GDf1tKk
         eK61KC8EUBYRAicc/ZNdM+7b7GmVwetmqBzyBFB975MngUwTm9aw4E2AL054rU9cFaPo
         j+lKkLALHvmJGsPT61Y0tz5nJQZn9IMSHtNRdhRP9Yeb4mcwTwBjq2MzY9LTbmoj3JWS
         x19JINYr4ISze+T9+hz9gOPl/KfmZVS+6YlJCCcOTFIQsQZYOt6jbkfEFPctsM8nThJQ
         wFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gBBH/Q+4DT6MMFzudxxMo6qTH2zDvIqJYCuHRS/x8Gs=;
        b=vckFNNi+hvDSmrTjVSzQOb8A9eay/0pWWnkRCMh/Zgd2gajakMSygP6HT9oQsgmjew
         F9qMwqrPdq4C1peWKL7QkDLjugEnHUvOKBO0VN90cvzCtAFQWJKCoiTUcJkuHRIyuy8K
         QmTie9M4/k6cgOTDvy/4aOo54VH5f7rqPvSIxC3GmAgxtjDilpcAm7OPyuJUK2YyVis3
         29BzCF5peJx8ziba4rsJztQcEUcCn85H21ftw1ezQRx2ME32jR14E5CPa8Q04wgLQiBc
         KUJEm9JJCYXU+F+Pj+9a9eBCF/0WHXuKGiGTigWd1UnIlqUWsPXaRSSiygCpF9JIaF3F
         EnYg==
X-Gm-Message-State: AOAM532upNzzD7W6kXTeH7cVryloHhpFX51Qy/9V8PxnlTso8/WcBnR7
        gQV2k9Ioi7MQzz2GyMBrz7w=
X-Google-Smtp-Source: ABdhPJx6pongqUzF2GCWPf3PPjoh1vz7OEj8FQ/voPke/8ceAr1mP50zFni4Hu2G4gWzSziUIk45mQ==
X-Received: by 2002:a63:ff23:: with SMTP id k35mr11505864pgi.28.1637244548964;
        Thu, 18 Nov 2021 06:09:08 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:09:08 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org (open list:PCI ENHANCED ERROR HANDLING
        (EEH) FOR POWERPC)
Subject: [PATCH v4 19/25] PCI/DPC: Use PCI_POSSIBLE_ERROR() to check read from hardware
Date:   Thu, 18 Nov 2021 19:33:29 +0530
Message-Id: <9b0632f1f183432149f495cf12bdd5a72cc597a4.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use PCI_POSSIBLE_ERROR() to check the response we get when we read
data from hardware.

This helps unify PCI error response checking and make error checks
consistent and easier to find.

Compile tested only.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/dpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index c556e7beafe3..3e9afee02e8d 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -79,7 +79,7 @@ static bool dpc_completed(struct pci_dev *pdev)
 	u16 status;
 
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS, &status);
-	if ((status != 0xffff) && (status & PCI_EXP_DPC_STATUS_TRIGGER))
+	if ((!PCI_POSSIBLE_ERROR(status)) && (status & PCI_EXP_DPC_STATUS_TRIGGER))
 		return false;
 
 	if (test_bit(PCI_DPC_RECOVERING, &pdev->priv_flags))
@@ -312,7 +312,7 @@ static irqreturn_t dpc_irq(int irq, void *context)
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 
-	if (!(status & PCI_EXP_DPC_STATUS_INTERRUPT) || status == (u16)(~0))
+	if (!(status & PCI_EXP_DPC_STATUS_INTERRUPT) || PCI_POSSIBLE_ERROR(status))
 		return IRQ_NONE;
 
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
-- 
2.25.1

