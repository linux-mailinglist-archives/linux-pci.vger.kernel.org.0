Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6080E422F14
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 19:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhJERXZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 13:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbhJERXT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 13:23:19 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824D0C06174E;
        Tue,  5 Oct 2021 10:21:28 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h1so93967pfv.12;
        Tue, 05 Oct 2021 10:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUEhHrxHzVocYPRDueBy4ZqExPBHlS+x/5Sx/kTwk+s=;
        b=JP4gIP+Xb2Q6TkPHIfeumXmQUTQM17CwINF6D+7nmzq16aS1vPgePsP8BRCUigjzjG
         Al4+7ftcW2GwjqZcP9+dkFrmj1r1wBDmul9nRYtpL5ATiC7z9W7WguIxb6QpbYQ1c0Qe
         qzGsbcr1kbkr/DPjeUspYL7M43luiZspVkmyToKxKnw5C4VREjeBfaRQF27NFw29zK0v
         ItDvybqnRyupN9N1yxQBTQYmHEBI0F3DVSNHkMBn6gEos/E6IbLFxtOIFeujcIC1o8a3
         vze4ogNFU3y+AIIZixi5K9sk1daKGlbVraVVAyZ8XdRuTqC7LsIb4fI+ulFXVGcr9cuB
         bbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUEhHrxHzVocYPRDueBy4ZqExPBHlS+x/5Sx/kTwk+s=;
        b=V8LfLTsZoznX2fyq7smKkzE2gapcT+7D/fW7ghsIJnvbiw0Ow49t5cCfD57nFPfwTx
         4nRWmRTRG1gKUijtRzvA3udNHCzb/ZYDvdRYnJW22yUGiHtQwND9N0X7Yfff24mEZMFo
         04miO68ZSk4biUhFCMoBuRyAo0FrZLw6J8iYDtBbimAA/LBJ7M407h/graywJ+3EA8g8
         25Z0uYOk4FIEmXdtAj18S9yVD6ptrl6sWXxiCmPtDicbY4bol1gR3DAoLlgcgHzrrLju
         bVagMwfomnujRSITj2h3ZJRAr6GydswfCcrc3z2zIbF1g0HIGOOYnInGNFIWUVse2g5N
         jitA==
X-Gm-Message-State: AOAM532QqAPJNiHhLAEWwIcjEXvGvwKGHl5+P3/xfeWL0odgSz2g/UIw
        lJSMRjeZr0iG3SAYr/xm7fE=
X-Google-Smtp-Source: ABdhPJzpUctZDHkmHmyClSYtwn2nBGa87nLISvzaVn9xSDa20lc4X8Z/Nz6W5DkbxezIRHkmIryqeg==
X-Received: by 2002:a62:445:0:b0:44c:3b5b:f680 with SMTP id 66-20020a620445000000b0044c3b5bf680mr19133758pfe.30.1633454488012;
        Tue, 05 Oct 2021 10:21:28 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:f69:1127:b4ce:ef67:b718])
        by smtp.gmail.com with ESMTPSA id f25sm18476722pge.7.2021.10.05.10.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:21:27 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 7/8] PCI/ERR: Remove redundant clearing of AER register in pcie_do_recovery()
Date:   Tue,  5 Oct 2021 22:48:15 +0530
Message-Id: <326a608cf8ca983442849045c8c7bf95fc2ba084.1633453452.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633453452.git.naveennaidu479@gmail.com>
References: <cover.1633453452.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_do_recovery() is shared across the following paths:
 - ACPI APEI
 - Native AER path
 - EDR
 - DPC

ACPI APEI
==========

  ghes_handle_aer()
    aer_recover_queue()
      kfifo_in_spinlocked(aer_recover_ring)

  aer_recover_work_func()
    while (kfifo_get(aer_recover_ring))
      pcie_do_recovery()

In this path the system firmware clears the AER registers before
handing off the record to the OS in ghes_handle_aer()

Native AER
==========

 aer_irq()
   aer_add_err_devices_to_queue()
     kfifo_put(&rpc->aer_fifo, *e_dev)
     clear_error_source_aer_registers()   <---- AER registers are cleard

 aer_isr()
   aer_isr_one_error()
    handle_error_source()
      pcie_do_recovery()

The AER registers are cleared during the handling of IRQ, i.e before we
the recovery starts.

DPC
=====

  dpc_handler()
    dpc_process_error()
    pci_aer_clear_status()       <---- AER registers are cleared
    pcie_do_recovery()

EDR
====

  edr_handle_event()
    dpc_process_error()
    pci_aer_raw_clear_status()  <---- AER registers are cleared
    pcie_do_recovery()

In all the above paths, the AER registers are cleared before
pcie_do_recovery(). The non fatal status AER registers are again cleared
in pcie_do_recovery(). This is redundant.

Remove redundant clearing of AER register in pcie_do_recovery()

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/err.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index b576aa890c76..fe04b0ae22f4 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -231,14 +231,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	/*
 	 * If we have native control of AER, clear error status in the device
-	 * that detected the error.  If the platform retained control of AER,
-	 * it is responsible for clearing this status.  In that case, the
-	 * signaling device may not even be visible to the OS.
+	 * that detected the error.
 	 */
-	if (host->native_aer || pcie_ports_native) {
+	if (host->native_aer || pcie_ports_native)
 		pcie_clear_device_status(dev);
-		pci_aer_clear_nonfatal_status(dev);
-	}
+
 	pci_info(bridge, "device recovery successful\n");
 	return status;
 
-- 
2.25.1

