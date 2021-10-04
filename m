Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8DD4210FB
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 16:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhJDOKy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 10:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbhJDOKw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 10:10:52 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C3DC061783;
        Mon,  4 Oct 2021 07:09:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id b22so11199639pls.1;
        Mon, 04 Oct 2021 07:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+NqgXClATM2+U/6pmcAe6ttC1b34HIq6gozyTG/Fag=;
        b=Ozwj5eo+JQr13kbgISfT/YYcy0EwCY30LXLUlWlbVkJd67t6s5mPWeUrFyYkyLrScw
         QE30Lg2AZumU/Mp/g+pSA4HdJXE5l4IgxgYCrtImGnxcdEtEgn31D4eskl5WNWLfmoiP
         dwSqeOT1wboM4W0ANBUZwjRBI9rpiG7hFCcqlsROuhtqYyrXOjk7zuSd+Ijok4MTEt/8
         w4lb6EAAX7Fe0Frs8sNL9k/0JYK2UkkTdD1D0cj2HqZgpxjOjGHa7KywPAQ+vt5wkMcd
         Z+6A3E5K8CejOdX7iWB+K5ko0IFiqV343d0OD2eUzDncwhqD8kIy7on3eSNpIFI1BHle
         3woA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+NqgXClATM2+U/6pmcAe6ttC1b34HIq6gozyTG/Fag=;
        b=8DLJtJhMwcAkaoRXGEshEbDteXVq6OHqsRwk1wGDMidRM1+drdvJodJ028A4vXS7Iu
         fxAyiG1XYLxmrsKB6w/gDPKthVdiA05AAufBEMMclI8/lvZoUvUc0z2tsQGQbQt/hFlO
         4LrMSSWkQpRvIgQcZi3iBPgTAatK4b1sdey66J3ijWNCA2cdCAkLhNRoGGWoK8SHlnFc
         ZvhC0oRWUUU9hXetShJH9HGI0XG6JPzsFIz2wclwem5XyeFkM1Z3YFYzDbiGixDT6qm/
         H5Xfi62hqMhdzsoYX6v1uR+dQLVklNGwbHYuVtSOI9W4OUbUvwLrpf/vcWjCoYt219Hp
         qFoA==
X-Gm-Message-State: AOAM5308Je7LRweL2th6HmjrQFJr42r2eVVpossGILdlp9I69DWYY+71
        w+WN6Y6Z8PmFqanbIR8/LNDXqU6FbqL28oT+
X-Google-Smtp-Source: ABdhPJz9tTa1vY09/ksLF7xk0Y6tU/8x10h8zOlbMuBmOEpd9L/4e0/Z5IuE/XsKNuFAeKf6CCpFYg==
X-Received: by 2002:a17:902:b691:b029:12d:2b6:d116 with SMTP id c17-20020a170902b691b029012d02b6d116mr23418269pls.71.1633356541150;
        Mon, 04 Oct 2021 07:09:01 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id p2sm15274135pgd.84.2021.10.04.07.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:09:00 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 5/8] PCI/DPC: Converge EDR and DPC Path of clearing AER registers
Date:   Mon,  4 Oct 2021 19:36:31 +0530
Message-Id: <14df904c301dc417485f5a7563053b81ab1d3c76.1633353468.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633353468.git.naveennaidu479@gmail.com>
References: <cover.1633353468.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the EDR path, AER registers are cleared *after* DPC error event is
processed. The process stack in EDR is:

  edr_handle_event()
    dpc_process_error()
    pci_aer_raw_clear_status()
    pcie_do_recovery()

But in DPC path, AER status registers are cleared *while* processing
the error. The process stack in DPC is:

  dpc_handler()
    dpc_process_error()
      pci_aer_clear_status()
    pcie_do_recovery()

In EDR path, AER status registers are cleared irrespective of whether
the error was an RP PIO or unmasked uncorrectable error. But in DPC, the
AER status registers are cleared only when it's an unmasked uncorrectable
error.

This leads to two different behaviours for the same task (handling of
DPC errors) in FFS systems and when native OS has control.

Bring the same semantics for clearing the AER status register in EDR
path and DPC path.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/dpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index faf4a1e77fab..68899a3db126 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -288,7 +288,6 @@ void dpc_process_error(struct pci_dev *pdev)
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
-		pci_aer_clear_status(pdev);
 	}
 }
 
@@ -297,6 +296,7 @@ static irqreturn_t dpc_handler(int irq, void *context)
 	struct pci_dev *pdev = context;
 
 	dpc_process_error(pdev);
+	pci_aer_clear_status(pdev);
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
 	pcie_do_recovery(pdev, pci_channel_io_frozen, dpc_reset_link);
-- 
2.25.1

