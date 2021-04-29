Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9016F36F2D0
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 01:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhD2XIo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 19:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhD2XIn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 19:08:43 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AD3C06138B
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 16:07:56 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id y6so1332645ilq.10
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 16:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fatalsyntax-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PyGv+yp8//v/HbpkhYW49V4szC/UoJYYhYRBhyxZAOM=;
        b=YcYmtc/1yJdq417y4j0Vknz8h6kXS1rgZMJQcb7DFDfL0TAw3rm5Vva3gUGco94BeZ
         FmqoYsls6tk42b4VyILHI0FHIPxIXGkRxEwqDakqWeHtao0VztTQmjJRZXXAJzN11Tc7
         sGcR0G2FMT7kfPADwHTwcbtD4pIXboX1ZD9iRb8Xf+YBPaDrNA75teRzk66+p78klRwe
         033H3hgPDo9wyoH31LzDIC8y5GuG3rE6lqTPdaZybX28mif6crr7Fts+L3RSInxrQOme
         HPHGGWPppw57rXUShRNQ+bnbxICXAzkeew2TNzQ1VT3yiAD7v1dAtcNuWGEVXyiLQfXK
         C/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PyGv+yp8//v/HbpkhYW49V4szC/UoJYYhYRBhyxZAOM=;
        b=ZTJlj6iJ7lkN2lju0J6/qpc1VsKQG+PGFvpKHLxhqoed5Fh3YQbUIdwngjYNf+IV39
         d40TXyFLLIUbs9qef60FN9HHAEGEvqeg3tEDauMOZspr4vh89r9+IB9QcxSOKNukLca3
         e970KDubCusS4XFQJCI/LlA3CZQce4/7SBmKZ1GRcyn4UUWM/VnYAX15jdoKJ/Treq4e
         5vwYjGnszGgoMMW5BG0P7vrDHwLYzjovA//D+hA+TcT4slkDKMYX4aZEJ/G+EiFItVCg
         zHWJWwhEYhwYahc1VI6ajmSy8WtkGqnX4QwiVH0lpM+cYLYmAzNwLw9VFAupQ0f8FyyH
         q1/g==
X-Gm-Message-State: AOAM5333wBWBmhZImsfbHOX9AEuZLkoGnxqozUBstdJDi35A+4eSLVCD
        2fe9enYcYXmka3GcYtdXSL5xZA==
X-Google-Smtp-Source: ABdhPJwmWt4/XFHJ73YQHH6fUR+TGUzu+8184rhiHWLR5FCNhGUdmK5LxliPxnlE5vPkN6Q9GwXBzA==
X-Received: by 2002:a05:6e02:13d0:: with SMTP id v16mr1766583ilj.8.1619737675830;
        Thu, 29 Apr 2021 16:07:55 -0700 (PDT)
Received: from nagato.condo.fsyn.dev (2603-6000-ca08-f310-6401-a7ff-fe3c-3150.res6.spectrum.com. [2603:6000:ca08:f310:6401:a7ff:fe3c:3150])
        by smtp.gmail.com with ESMTPSA id e3sm577358iov.55.2021.04.29.16.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 16:07:55 -0700 (PDT)
From:   Robert Straw <drbawb@fatalsyntax.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Straw <drbawb@fatalsyntax.com>
Subject: [PATCH] pci: add NVMe FLR quirk to the SM951 SSD
Date:   Thu, 29 Apr 2021 18:07:30 -0500
Message-Id: <20210429230730.201266-1-drbawb@fatalsyntax.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SM951/PM951, when used in conjunction with the vfio-pci driver and
passed to a KVM guest, can exhibit the fatal state addressed by the
existing `nvme_disable_and_flr` quirk. If the guest cleanly shuts down
the SSD, and vfio-pci attempts an FLR to the device while it is in this 
state, the nvme driver will fail when it attempts to bind to the device 
after the FLR due to the frozen config area, e.g:

  nvme nvme2: frozen state error detected, reset controller
  nvme nvme2: Removing after probe failure status: -12

By including this older model (Samsung 950 PRO) of the controller in the
existing quirk: the device is able to be cleanly reset after being used
by a KVM guest.

Signed-off-by: Robert Straw <drbawb@fatalsyntax.com>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3b..e339ca238 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3920,6 +3920,7 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_ivb_igd },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
 		reset_ivb_igd },
+	{ PCI_VENDOR_ID_SAMSUNG, 0xa802, nvme_disable_and_flr },
 	{ PCI_VENDOR_ID_SAMSUNG, 0xa804, nvme_disable_and_flr },
 	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
 	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
-- 
2.31.1

