Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1491429682
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 20:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhJKSKy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 14:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbhJKSKy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 14:10:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3078C061570;
        Mon, 11 Oct 2021 11:08:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id g9so1429914plo.12;
        Mon, 11 Oct 2021 11:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tHENHhkpkZLornjDw8P+cbQvSFGcu3v2lE8jdyEkvRc=;
        b=Br70NNJ34I4Yegy0eEKartu/w5zPNCFTVWKFcc+0SH9riN481Yw03dpvxVCyDtFDXl
         SAGytifw3UMmpq3lnw8ankHQcppUplykvHGQN3JYCCcGRPSFfUvVibqUQWk6LKV4jSAx
         vwuTdXxOL0wPIJfLv2QZAKykGNtc07syqHF+0tjqKVLvwKPqq21ziVPb/FpNrBNI1gwA
         kWniU6LOcTTwgTMTNq5y8zxlj65oBXev1Y4/2VArihAVHVhSq82Ax4vyAq0S1YGr0b1t
         nbpb5I7m3Gm1ep5Ukn4lB4YDMTGjThfuBcygzwFGLdlN0zU2wX+Q7ZyxL3t82eKCMNPD
         vogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tHENHhkpkZLornjDw8P+cbQvSFGcu3v2lE8jdyEkvRc=;
        b=xPmd5zzjvqBnNFPaQ3jRZecZCSSCgO9NDCgQXOePzSlgKgbRAtI/vb3penvPku9nYv
         9JNCCH1fDl0Z4wTh654p7LYMHFvZvaeWC6TClWIRFSPtHVB+buvM5DBUhhhuwQ+YPDbB
         EZ7p0I6xmFmp/gW0s07iRJ1hkzS1/AszuzytOOLLQ46clozyNb4wxzXQ3DBRYNJrM4F9
         KsBaW7uKQe9VX6od4H+FJQM6E1ti35/bjXBJbLtbh32B9mXFGDq5S1Oht2Yn6EV/iPLc
         4ZrfRylwS57rn39+gXGxuW5wsYSlsXPWVIO2Wo8Y2RWJ++D6JfmHRHfsB1tyDMY1jm+v
         SscQ==
X-Gm-Message-State: AOAM533JP2SF0TmCoWg0nRfccUetboDeuYancoTpw+npAhYeqF19ob2o
        509NfxTVnzf/Y0mrew18wLwGhayuQj0do+nr
X-Google-Smtp-Source: ABdhPJxg6bu3T2mprP33rb4kjg4OQn9iK/yPDYAEI5T0dMHwN1Br2zmBANHMy1ks/11wEZhbExnAkg==
X-Received: by 2002:a17:90a:9f95:: with SMTP id o21mr515839pjp.21.1633975733419;
        Mon, 11 Oct 2021 11:08:53 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id u74sm8480423pfc.87.2021.10.11.11.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:08:53 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org (open list:PCI ENHANCED ERROR HANDLING
        (EEH) FOR POWERPC)
Subject: [PATCH 17/22] PCI/DPC: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
Date:   Mon, 11 Oct 2021 23:38:27 +0530
Message-Id: <8de64c63fa1559929c83a94a0da8e8f42f0b5377.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633972263.git.naveennaidu479@gmail.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use RESPONSE_IS_PCI_ERROR() to check the response we get when we read
data from hardware.

This helps unify PCI error response checking and make error checks
consistent and easier to find.

Compile tested only.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/dpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index c556e7beafe3..561c44d9429c 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -79,7 +79,7 @@ static bool dpc_completed(struct pci_dev *pdev)
 	u16 status;
 
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS, &status);
-	if ((status != 0xffff) && (status & PCI_EXP_DPC_STATUS_TRIGGER))
+	if ((!RESPONSE_IS_PCI_ERROR(&status)) && (status & PCI_EXP_DPC_STATUS_TRIGGER))
 		return false;
 
 	if (test_bit(PCI_DPC_RECOVERING, &pdev->priv_flags))
@@ -312,7 +312,7 @@ static irqreturn_t dpc_irq(int irq, void *context)
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 
-	if (!(status & PCI_EXP_DPC_STATUS_INTERRUPT) || status == (u16)(~0))
+	if (!(status & PCI_EXP_DPC_STATUS_INTERRUPT) || RESPONSE_IS_PCI_ERROR(&status))
 		return IRQ_NONE;
 
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
-- 
2.25.1

