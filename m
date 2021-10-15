Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9146642F610
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240785AbhJOOsf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240919AbhJOOsa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:48:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832E6C061570;
        Fri, 15 Oct 2021 07:46:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so7409414pjb.5;
        Fri, 15 Oct 2021 07:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tHENHhkpkZLornjDw8P+cbQvSFGcu3v2lE8jdyEkvRc=;
        b=jvM5FjUOHTW4ZreWTNBrvcABxHTLtUwWgRZDjd0whn9aFrDhCENr73DWOHCxS5Fdkd
         qYr3Gcg+spaxksfjJrdlRHZsUccCng6zSdQRFt/mxs62ScyVAXmUaje7lK6uScfmUDsT
         lGbps+qki+QJGnSsqPGbnqpMb6m4fBQUHeHd/EswL3xnKPEESAf+zq58QLLatwmqqQXH
         n0zftEEaVPt+TW6yHN/5ySBqBmB/hW5lKXfPJr+DXYlPyb76LOjYCmNf5Q86iHIr4cN3
         6dwSlsKu7/hPuTC2UYJ8NE6goJaJKxUeHJGcDJCi9Z2MR77/3lEPZ+2usS0Ix1qA5Y1T
         rUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tHENHhkpkZLornjDw8P+cbQvSFGcu3v2lE8jdyEkvRc=;
        b=qFfiUnzVRxESQcSpYujY6SFwXaJWgatS+3Lv2gW164NZhpwSue1xGwUg6RZqBRwn9B
         41Um819setErjcFFnFkSb/3F9IXEY8ShHxTfhLknnKNs9hHlvBEez5l2/xcJPiVj+EFG
         enYK0pAsATAoJjng11kaV2jcDX4Kt81w2rmucAwnciVvk92obn9DaV6g+j61b8fwUz86
         21xP/Il71frj2Rgqhvi38MrBMm2r7oOkegEK9kBweO/XJ4RTdIoU68UpWm9TUkrd/c08
         bYuECos/M9U1qr+Es9fblbn1gd+LaFkVsZmGfmwpWHuds0ts4G2iFi0gTzZIYb2gc0Z/
         6q4g==
X-Gm-Message-State: AOAM530EManM6yrCgiDS1gTamUj4lm4Ar8+CMNPCK6K3DH0GndmrQa23
        yTfw2BFYVmUEj8yGM4F2r8Q=
X-Google-Smtp-Source: ABdhPJz6Gwr1+vYiSF57ZmI6jf24pGsKXmwV6yIHG2L6BRqU1OKaExlx4wVky+9XnlcXwmw/z3FEuA==
X-Received: by 2002:a17:90a:4b4d:: with SMTP id o13mr28221614pjl.236.1634309183942;
        Fri, 15 Oct 2021 07:46:23 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:46:23 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org (open list:PCI ENHANCED ERROR HANDLING
        (EEH) FOR POWERPC)
Subject: [PATCH v2 19/24] PCI/DPC: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
Date:   Fri, 15 Oct 2021 20:09:00 +0530
Message-Id: <26d5188e961b91eca52b97f8d8107348538d1401.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
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

