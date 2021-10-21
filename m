Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F154365A5
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhJUPRU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhJUPRE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:17:04 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685B3C079783;
        Thu, 21 Oct 2021 08:14:08 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so776803pjb.3;
        Thu, 21 Oct 2021 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ueS5g3AKfHONQw39HmC4BG+JBhrOhxPXeZpNcIeTYs=;
        b=KywtvjBqhXdKM5saP8ozIqwgJ1NpLQLuxi/61QKyCXpnntRLwkq8K5y5JhWK9uoW6Z
         0jSWeu/SyIc02VfO8a6JoLBiYzlSPjWZ20SYexAhgBC/z07hAtVPJ7QgWkRncMdPGA31
         G+G4yvY8iittk/SzgGlbZwEKZfPj6GG+TH+ImdA82fnqP3CCUoiH7FO1xDdFjZdC3ZsJ
         /7d0DrNHCe9LDuYC1oGxvkMnosURXlrc7hTQEyDnk3SHVGRxWMLavT1EvQXPT21trhij
         Gel3YJCPzYH0Ffqi85lDLXSVjBnyeAPT4N8wWWz+kwPkAn/HDytKYVsugxca9gdebLex
         x3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ueS5g3AKfHONQw39HmC4BG+JBhrOhxPXeZpNcIeTYs=;
        b=rsx8tlU5jQbwEaerRSTXVG7mt7uueN1Kd0/Heu152Oi2/iqu8LEBuMCifBtpVb+Sax
         XkPCK6SY4FXXPSpCMgHbv27uS0aV2Kki3v3uYUtLVAjgSQGbA1qW4+p26HCbn9xo69i3
         0n77gqzcn6eIzUrJhheFYEmu7iXZwonJQj7orqC3aLKf2IU6Soh0d2fbg+aSxnNnM7xR
         CAMHcVEydxHnva7+gXz0ozfJxlEZuWCQONKLDVyMPEKzPzzTBD7uIDqtDit7JVO9t42h
         FV7WRpxK7GZomjeDu6WvkhrQG91v3iahxnm1+pisPgE7HYtUz/660AIYiYg4WO6LdyvU
         nVeg==
X-Gm-Message-State: AOAM530lrHFvQgjs6dwLRdwOLS3RyhnuaL2njzQBmIqlvKBoQTiZHyYh
        r/17N7It/2vF78WSCvVNVKuWr9YJzppQQs30
X-Google-Smtp-Source: ABdhPJy/rYBKMVB2biY8nPCP0z+l7gmEi9mx9wbhq8VWJmK58SGug5h7FWR8XUw6e5oMZab3QioSpg==
X-Received: by 2002:a17:902:b615:b0:13f:fc88:6479 with SMTP id b21-20020a170902b61500b0013ffc886479mr3621816pls.53.1634829247879;
        Thu, 21 Oct 2021 08:14:07 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:14:07 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org (open list:PCI ENHANCED ERROR HANDLING
        (EEH) FOR POWERPC)
Subject: [PATCH v3 19/25] PCI/DPC: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
Date:   Thu, 21 Oct 2021 20:37:44 +0530
Message-Id: <6e19df51a431da05dbd5577f11dd31d0c2801911.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
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
index c556e7beafe3..4a051a096075 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -79,7 +79,7 @@ static bool dpc_completed(struct pci_dev *pdev)
 	u16 status;
 
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS, &status);
-	if ((status != 0xffff) && (status & PCI_EXP_DPC_STATUS_TRIGGER))
+	if ((!RESPONSE_IS_PCI_ERROR(status)) && (status & PCI_EXP_DPC_STATUS_TRIGGER))
 		return false;
 
 	if (test_bit(PCI_DPC_RECOVERING, &pdev->priv_flags))
@@ -312,7 +312,7 @@ static irqreturn_t dpc_irq(int irq, void *context)
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 
-	if (!(status & PCI_EXP_DPC_STATUS_INTERRUPT) || status == (u16)(~0))
+	if (!(status & PCI_EXP_DPC_STATUS_INTERRUPT) || RESPONSE_IS_PCI_ERROR(status))
 		return IRQ_NONE;
 
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
-- 
2.25.1

