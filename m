Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFEB33AFF0
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 11:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhCOK0e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 06:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhCOK0T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Mar 2021 06:26:19 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD58AC061574;
        Mon, 15 Mar 2021 03:26:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so16158666wmj.2;
        Mon, 15 Mar 2021 03:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MhjChi8adV9zE8HooQpYK0obJpzO9BGi18QfVDbxySg=;
        b=Xqq0ZaONFNtwRhUi25JakKAiu6etnZPtB9T9P1ntVbMbyv+zeh/hIB+zLrguYdJrk1
         LtyvJilNtNrZXXTGNnBCd4OW8sXIT+diq9p6DW04jgspC1FSl9q6nr4cYNmF3AKwqg+c
         iMAaPmjw3OenG9hAGjjKehWVEIauBP3HTAq2twv0yiWUPQ8jDFzID2IsPrg3E/x6zx9Y
         /x/lSLk83KCot3GEpBCijEWp3lfnsAQp4A52kW4GILfpJwelC1aqhhCugaOH8yCa/Syn
         l02rzIh5/mMyBrjRKJtRBn5S1v31wa2EvS0VXr0j4LLLJNZ3A8WsWEmd9FW7Inv1spmQ
         TxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MhjChi8adV9zE8HooQpYK0obJpzO9BGi18QfVDbxySg=;
        b=YzumZHZPzSvMnCCX5Nkj31GoCL1tURPNV8+mvSEgDIYsvYeqskQvRtujR165Nos1UJ
         T5w9VRjY96lQZ+BUqBSi7qIwdKcyekFafwz9nxDlaJS1NOmFRStz5QD0siwkGIDlXH/5
         Iu9QAi1r2sIimH5AOf4cqOhHgyIb8E/eDUrMVIWHFKw55e8OMKCJMjPHJ4ejabPjiDCv
         vqMS7eZvAQDMCbAcPC3IRL+t5bQcoaS1KbnEdGl+6id458iECNi2jhuLAM3kUVLujri8
         S+p/63O3Lbo+5S2ekyFwDbS9au65XQG3wuTqzwLhzaVMuNCWfunIQs5Kr1QVLBe2Azej
         /4aQ==
X-Gm-Message-State: AOAM5316QuM5ThFm4SxzKSbGDLAp0ndeSN+Qmx4lRQ6S3o/VRs3bPomr
        kUDiL962DeCyfrnrX2R50og=
X-Google-Smtp-Source: ABdhPJxcfRREOkcyxRTdNp54Py5puhptKO8792lReZ15gEhDjS24g+eGQYfM1kuw3Vid1bu940w//A==
X-Received: by 2002:a1c:7901:: with SMTP id l1mr25880765wme.114.1615803976521;
        Mon, 15 Mar 2021 03:26:16 -0700 (PDT)
Received: from localhost ([168.61.80.221])
        by smtp.gmail.com with ESMTPSA id e1sm19033628wrd.44.2021.03.15.03.26.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 03:26:16 -0700 (PDT)
From:   =?UTF-8?q?Antti=20J=C3=A4rvinen?= <antti.jarvinen@gmail.com>
To:     helgaas@kernel.org
Cc:     alex.williamson@redhat.com, antti.jarvinen@gmail.com,
        bhelgaas@google.com, kishon@ti.com, kw@linux.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        m-karicheri2@ti.com
Subject: [PATCH v4] PCI: Add quirk for preventing bus reset on TI C667X
Date:   Mon, 15 Mar 2021 10:26:06 +0000
Message-Id: <20210315102606.17153-1-antti.jarvinen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210312210917.GA2290948@bjorn-Precision-5520>
References: <20210312210917.GA2290948@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some TI KeyStone C667X devices do not support bus/hot reset. Its PCIESS
automatically disables LTSSM when secondary bus reset is received and
device stops working. Prevent bus reset by adding quirk_no_bus_reset to
the device. With this change device can be assigned to VMs with VFIO,
but it will leak state between VMs.

Reference: https://e2e.ti.com/support/processors/f/791/t/954382
Signed-off-by: Antti Järvinen <antti.jarvinen@gmail.com>
---
 drivers/pci/quirks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..d9201ad1ca39 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3578,6 +3578,16 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
 
+/*
+ * Some TI keystone C667X devices do no support bus/hot reset.
+ * Its PCIESS automatically disables LTSSM when secondary bus reset is
+ * received and device stops working. Prevent bus reset by adding
+ * quirk_no_bus_reset to the device. With this change device can be
+ * assigned to VMs with VFIO, but it will leak state between VMs.
+ * Reference https://e2e.ti.com/support/processors/f/791/t/954382
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, 0xb005, quirk_no_bus_reset);
+
 static void quirk_no_pm_reset(struct pci_dev *dev)
 {
 	/*
-- 
2.17.1

