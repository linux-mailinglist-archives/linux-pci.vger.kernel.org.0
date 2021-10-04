Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0371E42117D
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 16:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhJDOgD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 10:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhJDOgC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 10:36:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFB9C061745;
        Mon,  4 Oct 2021 07:34:13 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k26so14670482pfi.5;
        Mon, 04 Oct 2021 07:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUEhHrxHzVocYPRDueBy4ZqExPBHlS+x/5Sx/kTwk+s=;
        b=OglssVBWqz1ma67y0gu+GnFYxKbR8UrZSNFzb1VSpAwJ565osNk7ubr9/rLTEwNHV4
         5fHuW2oeZeJmrMraXtZunmOTSvdnsSIt7nj3fpKdF2tOd17gou0m6YDlu5KhHFqTi3OL
         cg10zl6lhD3LABCJQHJBN+LFUAoAcnXZcLVTiTFNYsjFF2NmtSYSo1ko8euje1u8IJYL
         GyJVt3hr64dt/CSZmjalZP4Y0WTBIH3zs2Sn33bD9pvDqyZ9DfpC+4VikxSUPB2fR7Si
         QVtSwBu8jP0Mf81yRV7J7T9XLvknAuYRmpIPzGM4coiYnLzEw2HEg6gFoROgUf4uLdy7
         nExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUEhHrxHzVocYPRDueBy4ZqExPBHlS+x/5Sx/kTwk+s=;
        b=U0+vdS51tJTEzAq36fi1gpHsRX67rXyv3R2HWaGxWgZi2P6ZLVNagLa16IuqeAbUXA
         AeOOWhSQOQu5wpyj5UkTNfckLyenSfrOCVKOYj0+tBno1DYO4dBeC4VK5ttKwMwJu4Gc
         LcjqlqKW3c3Mv09bDY0H13zo/zvLDpFpS2zEWAxV4qBonljbc+hwfKHdltsIIF6bTQT2
         Wrx/YCIV1UqC/GId8QzDHiabh60u0ZMhabv0yIH0Lm2WKhWlvTxvZ8Liko9rbzbQwMiP
         Yq2G72ewaSYPa5/8E8PF937yUOJLZFlMBQrrjndv6oPqwSDIKBblycdT/b/LyttcLpZ0
         9dmw==
X-Gm-Message-State: AOAM531oCKrkgtywJeJxPdGus8zIu/h88Mz4dloi1p/7AGCB2dLQOE+1
        inTkn/9L+sB7KW927TSLENg=
X-Google-Smtp-Source: ABdhPJzjLYBRQDTslI0IIqtBZs81gYVXT7dnSJjcqkuDEn7jtUE0PDQzxony+UyDQB73L839jXleNQ==
X-Received: by 2002:a05:6a00:90:b0:44c:6029:7fcb with SMTP id c16-20020a056a00009000b0044c60297fcbmr5805654pfj.69.1633358052975;
        Mon, 04 Oct 2021 07:34:12 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id q3sm14489146pgf.18.2021.10.04.07.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:34:12 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 7/8] PCI/ERR: Remove redundant clearing of AER register in pcie_do_recovery()
Date:   Mon,  4 Oct 2021 20:00:03 +0530
Message-Id: <43142f249930243b072f2c37e3b6d72472c919ee.1633357368.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633357368.git.naveennaidu479@gmail.com>
References: <cover.1633357368.git.naveennaidu479@gmail.com>
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

