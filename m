Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93647327280
	for <lists+linux-pci@lfdr.de>; Sun, 28 Feb 2021 14:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhB1Nx7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Feb 2021 08:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhB1Nx7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Feb 2021 08:53:59 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9993EC06174A;
        Sun, 28 Feb 2021 05:53:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l22so1583878wme.1;
        Sun, 28 Feb 2021 05:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2oIwWi1iuHOKuAMOebM+Y52Z/7RvFaXsTIQjnr0jMfc=;
        b=f6JS53aD784G4/zqHlNnWLi/AhS7N1WfHEPj6MFEBizaq1id2Ihrx4pZad4Xi5i+Qa
         m7Mkqm9vr88yG4nCQ4CF/ezPnLsoE+umnRyhCMM/tk9dU4IMwYYv4RCdJ/ASeBQbqbN9
         6sCW6EqIPGUD/YJ1SofXnFl5jNIvlFz1B9YBD6bEdUFZ/dClFbUTXVr43YJv1F/en6dx
         vWkj08Bm7HkmvQoHJlja4UGOpEom0IKK23Sys0FJb2qFWmwaODWEDqfhORpB97E0kx0d
         Zyg2smBG3TNjAUkcMX7mxbsZ5WGb2eoQehAuMJ3KpzA/tKWDrrwgg/kaMrsHv2aTGoLP
         YSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2oIwWi1iuHOKuAMOebM+Y52Z/7RvFaXsTIQjnr0jMfc=;
        b=PThQw5oMCzw+rjWDW58Wg1R4qOIqwcvThEhPLr+8+/mc972rc8y7LoZf8ouciOjobu
         7S86AnhQ/pvWIl5OGs6yIAY6o9dIRRLIVWFiGRK+7hDCdKLDHz1u2PhUccCoeokLmbEm
         UFL87/QH202DXYVsanTS5jS2krtQ8F8qYNYS9XQJs6JhC7I842TRG5GvOXwVSEcQYAR6
         cmr+mmFgsc0eqO7NaXaThqKnB3BltB/SvLLuMUViwbYYk7LYOcsgsSTpbZb0fNy6twD3
         ZiYM9QuFS2yeMdAL7k3ccpJVmZnUjMwSQ2BQabKTSg3hOwbwM/goZKZshGb8zfcVehJX
         GIlw==
X-Gm-Message-State: AOAM533BnCtQB4M0+hqlvNdtoHqrcyRAp8b6HW8LjDyUdS6WXIWNnhND
        s06hBCXkFBPjriOjgnazlj4=
X-Google-Smtp-Source: ABdhPJwX+o3U/8mqXWSknRmCalM3SkJ8jvecMDcfOyeuydwyyb4SilOgO52z4DqpRMunAZtQ6TsuLg==
X-Received: by 2002:a05:600c:4eca:: with SMTP id g10mr11602506wmq.149.1614520397160;
        Sun, 28 Feb 2021 05:53:17 -0800 (PST)
Received: from localhost ([168.61.80.221])
        by smtp.gmail.com with ESMTPSA id z188sm12220803wme.32.2021.02.28.05.53.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Feb 2021 05:53:16 -0800 (PST)
From:   =?UTF-8?q?Antti=20J=C3=A4rvinen?= <antti.jarvinen@gmail.com>
To:     helgaas@kernel.org
Cc:     alex.williamson@redhat.com, antti.jarvinen@gmail.com,
        bhelgaas@google.com, kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, m-karicheri2@ti.com
Subject: [PATCH v2] PCI: quirk for preventing bus reset on TI C667X
Date:   Sun, 28 Feb 2021 13:53:11 +0000
Message-Id: <20210228135311.668-1-antti.jarvinen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210217211817.GA914074@bjorn-Precision-5520>
References: <20210217211817.GA914074@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some TI keystone C667X devices do no support bus/hot reset. Its PCIESS
automatically disables LTSSM when secondary bus reset is received and
device stops working. Prevent bus reset by adding quirk_no_bus_reset to
the device. With this change device can be assigned to VMs with VFIO,
but it will leak state between VMs.

Reference https://e2e.ti.com/support/processors/f/791/t/954382

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

