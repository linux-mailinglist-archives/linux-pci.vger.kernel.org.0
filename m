Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44E1421171
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 16:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbhJDOen (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 10:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbhJDOen (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 10:34:43 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8B8C061745;
        Mon,  4 Oct 2021 07:32:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id k26so14666936pfi.5;
        Mon, 04 Oct 2021 07:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+NqgXClATM2+U/6pmcAe6ttC1b34HIq6gozyTG/Fag=;
        b=EJDTKmB+cmlmsr0qIKuAtTN/kN6cR8NvESH2dE/tM4QMvhT+19A2eI1YW2jVOSY+FZ
         eiDjdPe9DjppdcR7db8XYN0/V/uedFNAuaLwvnEv321Y/Ij90byXHSCpyb+JuOND5Hdz
         YJQo2uGXJZrhDN8SKWrXEBQTVl0cVyR8cclU3PtMwvn2hpBlSBlD/s+fXuqwM8gs7ld/
         ol3BjZv+ZtKv9OB2xcbjxBJlRjgBwnjKjlmdIkpUcPD0F+8+XM8n+0im4gea4L/gm7hF
         jzePJqS/kVm33ThvcVCf5pSqNeySxMvtmKAqpw/qlF7MH10zQnXRvqeseglTqpgowhKq
         jZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+NqgXClATM2+U/6pmcAe6ttC1b34HIq6gozyTG/Fag=;
        b=h1Gjezi2MuPTGBIhQIMwh4BqMdtzPP1Yjf2U+vvsJzlCcur+aUi3/vpWw+fkyD0i2K
         pJyfFHRjXmzWELo/etqXoUdbATMsk2MwCKUidfn+Jw4lS/3gfBp6WUK9s5yMArHpb/bq
         BKhieWwNVBU7h0EKwp2KTvZwxHvrF2aP5mv973pFA2FxmGxJYdXCSgOQFxd5oqaA+/WO
         HOjO5mZkPT/ASWOx3eAe6rb/IMtpDywnsSaYZ5KBavWPGgBgPJ+CRvWcC/hTkxablM5n
         h1jXF/ekjC2HH2WsTPwRnGe4j5+TZJEh6zszd9/dgFKvsjXlKOLltsePTxnyatoC87XW
         lE5A==
X-Gm-Message-State: AOAM5308lL6orCNP09CrwoLofLZHDeU8bST6DIUgMWTysxCOdIABYBem
        O47291/iIpSGLR0cBWP63f4=
X-Google-Smtp-Source: ABdhPJyNtlOm4ZKV7xBauAFvuyKhP0xBlVqGl0Lwgnj5beZB9aLsTPCzwRlA8XscSgq5TtTA4RK1Gg==
X-Received: by 2002:a65:44c4:: with SMTP id g4mr11266103pgs.254.1633357973671;
        Mon, 04 Oct 2021 07:32:53 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id q3sm14489146pgf.18.2021.10.04.07.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:32:53 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 5/8] PCI/DPC: Converge EDR and DPC Path of clearing AER registers
Date:   Mon,  4 Oct 2021 20:00:01 +0530
Message-Id: <14df904c301dc417485f5a7563053b81ab1d3c76.1633357368.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633357368.git.naveennaidu479@gmail.com>
References: <cover.1633357368.git.naveennaidu479@gmail.com>
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

