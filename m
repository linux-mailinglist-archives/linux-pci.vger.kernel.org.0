Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD504210FF
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 16:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhJDOLC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 10:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbhJDOLC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 10:11:02 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552F5C061746;
        Mon,  4 Oct 2021 07:09:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so67642pjb.1;
        Mon, 04 Oct 2021 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUEhHrxHzVocYPRDueBy4ZqExPBHlS+x/5Sx/kTwk+s=;
        b=Si7JSd/KCOLunLi8xM0VLOx2PfEG1rYw8Zg126ccHtdjh+YTOhxwYlmk3G+Z+iOuCf
         MHWlQfDnN9L3IAYokhBuv6RzMXNEwGLY39mOQKAm8xzjypeTvKVCQTCx8KM/NezRyTGI
         TSa03Y3eVG7e/CJ/pJUta1TShaEHhnDHumTQlJwYJCf3Q/8DVlgTE815cyGKa8qtRTXc
         AlfIFxKrM1KIkTARnCET6lxWANzMKgN1pEKjXGsMgdHENp5Cl8NwGBRFQCzr1Myh4Isq
         Ut5lkCVNfJF0Ebmmzx6NwBkhmaW5aH0OLSSbRBazBfBfQ9eZBBVpn0zOlK0pEBRJiJnb
         iP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUEhHrxHzVocYPRDueBy4ZqExPBHlS+x/5Sx/kTwk+s=;
        b=UunAz5UicH1Da6LoQSaTBI09yuD50Nq9Ij3PJTtACCpJvPbxgyqb3JXyG6bveEHMbT
         rK9UzOH9KbETBQarGI6x8G4M5K1PKJYiQsejDDYozHXq8xR35JV9DEIqoemKe08I/dnT
         EGXUqaFUes3rT4pRQP5IjzlhOqCWB+rZBKQJm3jTM88ydcTqnpUp/13p6d0TmhaWEhuN
         IQfeYYQd3ld+hVLX6xTR6yktoeCJ8+T9ifC9IwgfGLSEtJpP1lb1bUD1FZBP4nuiN5x+
         8n6WQ4gW/SLyjqSesMEUtDE+LrVxdwfxkgfnlViDWrV7Bo8UYXXn3Y/Hm6LXIN4iSvz1
         GzdA==
X-Gm-Message-State: AOAM533umiXU9wVPoDOkBDXQx6CwU6MQUVxkTxn2W2l1RsqKdimouEec
        NuHYCQh+fr5hYpE//+h+kkM=
X-Google-Smtp-Source: ABdhPJzZI+MfrURo1cZfuN3jk5UmArmhStUAiLlG7jckDZv+60lz4zNDTU5W6sSrwZ9tVHHecR8OSQ==
X-Received: by 2002:a17:902:7ec8:b0:13b:9d7a:6396 with SMTP id p8-20020a1709027ec800b0013b9d7a6396mr23741711plb.86.1633356552819;
        Mon, 04 Oct 2021 07:09:12 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id p2sm15274135pgd.84.2021.10.04.07.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:09:12 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 7/8] PCI/ERR: Remove redundant clearing of AER register in pcie_do_recovery()
Date:   Mon,  4 Oct 2021 19:36:33 +0530
Message-Id: <2360908d0f8406ed63a17a733c4d1defb49ee3d3.1633353468.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633353468.git.naveennaidu479@gmail.com>
References: <cover.1633353468.git.naveennaidu479@gmail.com>
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

