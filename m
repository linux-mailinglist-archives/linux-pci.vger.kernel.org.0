Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE571D6162
	for <lists+linux-pci@lfdr.de>; Sat, 16 May 2020 15:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgEPNhh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 May 2020 09:37:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36166 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgEPNhg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 May 2020 09:37:36 -0400
Received: by mail-qk1-f196.google.com with SMTP id y22so5562081qki.3
        for <linux-pci@vger.kernel.org>; Sat, 16 May 2020 06:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rHlQ0n6fppHgm/H6WszgLkI+e2yn+0+N8yRZSyZ3vyw=;
        b=tY390Z2rpjOBPrnA6Ab19Q38K8iJUHGmy6x7tZWJsbQZbkZm0rz9RQh+GtgaMms/b5
         D49eICf6z2BEJwzgSOi5+IqusV2gyB8t8VMXA7LTyLPRzpNAPBgrWH3/ZCRw2vtETP34
         SpA0nzj9lfLAfnTfKJBmxVlim0nZ0YYy+JBBmHAuxKHDvPvblj3UNDrFeTgATi6o2e16
         hEfLy33PhGNwOHHP63djBuzXhK+pTAfbqnpCxyUnGJkQ/XO/Qf0JYkBpRXgn46yIwMo5
         SgtBmeRLS0Pd30zWQLiMw7aaUiCWVg5EsFxHgxw483MilvPMAlQZNU6BGIs1N/YOaNUG
         SaHg==
X-Gm-Message-State: AOAM532/TAgf28dm0lkuiSJmQmr9qlvlGr5sV8jFabEZi0Iei8PJh7PS
        EKDBLFMV/Sf+RkfQ4HEgyD0nLiZxVhQ=
X-Google-Smtp-Source: ABdhPJxNiuJzkyhBsvUoJGnPN6vlFrXwhKdAKsvYXX7cVDfNfbiOx+alnxNTvjR9SLYC/yoeOw6iOw==
X-Received: by 2002:a37:4351:: with SMTP id q78mr6978428qka.242.1589636255294;
        Sat, 16 May 2020 06:37:35 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id d82sm3863860qke.81.2020.05.16.06.37.34
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 06:37:35 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id m44so4399820qtm.8
        for <linux-pci@vger.kernel.org>; Sat, 16 May 2020 06:37:34 -0700 (PDT)
X-Received: by 2002:aed:3b75:: with SMTP id q50mr8527093qte.23.1589636254629;
 Sat, 16 May 2020 06:37:34 -0700 (PDT)
MIME-Version: 1.0
From:   Marcos Scriven <marcos@scriven.org>
Date:   Sat, 16 May 2020 14:37:23 +0100
X-Gmail-Original-Message-ID: <CAAri2DpkcuQZYbT6XsALhx2e6vRqPHwtbjHYeiH7MNp4zmt1RA@mail.gmail.com>
Message-ID: <CAAri2DpkcuQZYbT6XsALhx2e6vRqPHwtbjHYeiH7MNp4zmt1RA@mail.gmail.com>
Subject: [PATCH] PCI: Avoid FLR for AMD Matisse HD Audio and USB Controllers
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch fixes an FLR bug on the following two devices:

AMD Matisse HD Audio Controller 0x1487
AMD Matisse USB 3.0 Host Controller 0x149c

As there was already such a quirk for an Intel network device, I have
renamed that method and updated the comments, trying to make it
clearer what the specific original devices that were affected are
(based on the commit message this was original done:
https://git.thm.de/mhnn55/eco32-linux-ba/commit/f65fd1aa4f9881d5540192d11f7b8ed2fec936db).

I have ordered them by hex product ID.

I have verified this works on a X570 I AORUS PRO WIFI (rev. 1.0) motherboard.


From 651176ab164ae51e37d5bb86f5948da558744930 Mon Sep 17 00:00:00 2001
From: Marcos Scriven <marcos@scriven.org>
Date: Sat, 16 May 2020 14:23:26 +0100
Subject: [PATCH] PCI: Avoid FLR for:

    AMD Matisse HD Audio Controller 0x1487
    AMD Matisse USB 3.0 Host Controller 0x149c

These devices advertise a Function Level Reset (FLR) capability, but hang
when an FLR is triggered.

To reproduce the problem, attach the device to a VM, then detach and try to
attach again.

Add a quirk to prevent the use of FLR on these devices.

Signed-off-by: Marcos Scriven <marcos@scriven.org>
---
 drivers/pci/quirks.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 28c9a2409c50..ff310f0cac22 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5129,13 +5129,23 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);

-/* FLR may cause some 82579 devices to hang */
-static void quirk_intel_no_flr(struct pci_dev *dev)
+/*
+ * FLR may cause the following to devices to hang:
+ *
+ * AMD Starship/Matisse HD Audio Controller 0x1487
+ * AMD Matisse USB 3.0 Host Controller 0x149c
+ * Intel 82579LM Gigabit Ethernet Controller 0x1502
+ * Intel 82579V Gigabit Ethernet Controller 0x1503
+ *
+ */
+static void quirk_no_flr(struct pci_dev *dev)
 {
     dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
 }
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_intel_no_flr);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_intel_no_flr);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);

 static void quirk_no_ext_tags(struct pci_dev *pdev)
 {
--
2.25.1
