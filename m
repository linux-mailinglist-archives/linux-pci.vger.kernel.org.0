Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A573E3310B1
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 15:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCHOWL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 09:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhCHOVz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 09:21:55 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C84C06174A;
        Mon,  8 Mar 2021 06:21:54 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l12so11647448wry.2;
        Mon, 08 Mar 2021 06:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=llTHel6Tau+2wt9oH3Ox8lQza6rjfyc6wVJ3sfruCT8=;
        b=ktXfmaT1JBfUylKJF3pAHwWC089SQJ3xX4kZGjdgl32VWtVke2QvnWziNw9i0brCX5
         6ycc21AUWWgl75pdc3mJ4y+HhlYfwwQPsPWU4tut9f+QdU4DsDEuJLN7kalEr91K/WK6
         Gt61Eid3eSqk2k92ADR21hxJlISRKTFWp7I2LnefYbO8uBi1K1YkB23nXYxWmp0/Nr+c
         f/ny5OxjCRRLAY1WxDnLBuMaZFwhCbzBDOzXD/t/EnqVICy9M9hYau5y7cBoBtfioasC
         z0W85vzAIZ4QU1QNW1qzAjB6XYepv4mfon4QajugKTA5qo9dsoWMCaEpgc0E3hF5leTf
         JFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=llTHel6Tau+2wt9oH3Ox8lQza6rjfyc6wVJ3sfruCT8=;
        b=EWMWn/C9dKvhOu1x8IGevad73mWrKLbF/TA4OxVf0Z7PeWQx/0J7Lrq93qheW+l4FB
         7/hLU/t1q85qlvxoknFPdteKB+SBVVsiAfdnMJLFGIQ4ARcIUsPUEL3/cHfPGLOyIWVg
         dRfugekaJVYpfMeyXowqgmhXPhAOo0h2QFD05MszXdMonC7x/YuFhuLGKUbrycnJtZZ0
         KeKiEb01zu7PZK/A6rsimT4i9qg/KAFVHdwNLldJealqORkwRY+fuwQ5f6IdnSL7wyqn
         mZsi/ZaPqHkPE+s6wENSRgK+FBfs4PeWQbYWyS8XagK0y/bhcQnAowMySHOclnRQWFWM
         21bA==
X-Gm-Message-State: AOAM533ZR/v6+iGBf4FvQrDYuDVPNWi54fy1mGsbdQJBmhcvQsbtwCvf
        g+z5G7/O9/GRnLs/b0Xgtn4=
X-Google-Smtp-Source: ABdhPJwvOEFuopemwNn4jZEhHn4qLjY6VlvhMsyBLxHU4tZ/21Mg2qSMjrhIQa/cNb8n0DM49nOMiA==
X-Received: by 2002:adf:ef4a:: with SMTP id c10mr22463339wrp.427.1615213313349;
        Mon, 08 Mar 2021 06:21:53 -0800 (PST)
Received: from localhost ([168.61.80.221])
        by smtp.gmail.com with ESMTPSA id h20sm18102481wmp.38.2021.03.08.06.21.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 06:21:52 -0800 (PST)
From:   =?UTF-8?q?Antti=20J=C3=A4rvinen?= <antti.jarvinen@gmail.com>
To:     kw@linux.com
Cc:     alex.williamson@redhat.com, antti.jarvinen@gmail.com,
        bhelgaas@google.com, helgaas@kernel.org, kishon@ti.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        m-karicheri2@ti.com
Subject: [PATCH v3] PCI: Add quirk for preventing bus reset on TI C667X
Date:   Mon,  8 Mar 2021 14:21:30 +0000
Message-Id: <20210308142130.13835-1-antti.jarvinen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YEQcyBVLIaGWb4sk@rocinante>
References: <YEQcyBVLIaGWb4sk@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some TI KeyStone C667X devices do no support bus/hot reset. Its PCIESS
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

