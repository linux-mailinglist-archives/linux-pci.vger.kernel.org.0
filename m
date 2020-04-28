Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701FC1BC3D6
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 17:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgD1Pgs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Apr 2020 11:36:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39890 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgD1Pgs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Apr 2020 11:36:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id b11so25162409wrs.6;
        Tue, 28 Apr 2020 08:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gDQQvbPT3Kzf63XvecjBNGYEsk2bb2xd9NhLfULiqJg=;
        b=SUMpmmDX5YCXEq7htWjwhumb3JYP70c6FIYvFkaULiBW+zwMFV05VyLdwMKQyGx4Qh
         LdeizPZwOo1SoiBClsWPVNwAVARqkL1IgTcVYXQEmo2SgAN29qz4BCaLuJCgVCEZJqEc
         Uv97FgTi0AOC3XBbGmkCnj/6bQy6ekdCUVH1rP1MvX0ETXghToDKnmgPc3Fdphh0Onbj
         H8Jebl4cqwhPaeccxoV9UMz07BKQjtjmMs6HDKWUNwnk+sN01Bs3CvgUbkKbAhT2JMyh
         OjG8sD3PuQbS4b/5eaxa4NiPKrDQJrAcYU91QT9g/XIU1tl+9eH5q5YSdI46DAQ7Z1R5
         uBTA==
X-Gm-Message-State: AGi0Pub0+T/iNjuMlANL5fdhTAo3UBI2ejSQ1hrrG3bZPmRYl86lgJYF
        wdL3+C13HpaIzjnEBSnI2anbPJlV
X-Google-Smtp-Source: APiQypIOusuwAcr33CB5Ldy0/gal7sLr8hHFrxFgnuMNsSelBzKOp9T5ByiX4HEIJfDkRsL82eG/gw==
X-Received: by 2002:adf:84c2:: with SMTP id 60mr33197060wrg.65.1588088204974;
        Tue, 28 Apr 2020 08:36:44 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id w12sm25355384wrk.56.2020.04.28.08.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 08:36:43 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     linux-pci@vger.kernel.org,
        Xen Development List <xen-devel@lists.xenproject.org>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, x86@kernel.org,
        sstabellini@kernel.org, Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [PATCH] x86/xen: drop an unused parameter gsi_override
Date:   Tue, 28 Apr 2020 15:36:40 +0000
Message-Id: <20200428153640.76476-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All callers within the same file pass in -1 (no override).

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/pci/xen.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 91220cc25854..e3f1ca316068 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -60,8 +60,7 @@ static int xen_pcifront_enable_irq(struct pci_dev *dev)
 }
 
 #ifdef CONFIG_ACPI
-static int xen_register_pirq(u32 gsi, int gsi_override, int triggering,
-			     bool set_pirq)
+static int xen_register_pirq(u32 gsi, int triggering, bool set_pirq)
 {
 	int rc, pirq = -1, irq = -1;
 	struct physdev_map_pirq map_irq;
@@ -94,9 +93,6 @@ static int xen_register_pirq(u32 gsi, int gsi_override, int triggering,
 		name = "ioapic-level";
 	}
 
-	if (gsi_override >= 0)
-		gsi = gsi_override;
-
 	irq = xen_bind_pirq_gsi_to_irq(gsi, map_irq.pirq, shareable, name);
 	if (irq < 0)
 		goto out;
@@ -112,12 +108,12 @@ static int acpi_register_gsi_xen_hvm(struct device *dev, u32 gsi,
 	if (!xen_hvm_domain())
 		return -1;
 
-	return xen_register_pirq(gsi, -1 /* no GSI override */, trigger,
+	return xen_register_pirq(gsi, trigger,
 				 false /* no mapping of GSI to PIRQ */);
 }
 
 #ifdef CONFIG_XEN_DOM0
-static int xen_register_gsi(u32 gsi, int gsi_override, int triggering, int polarity)
+static int xen_register_gsi(u32 gsi, int triggering, int polarity)
 {
 	int rc, irq;
 	struct physdev_setup_gsi setup_gsi;
@@ -128,7 +124,7 @@ static int xen_register_gsi(u32 gsi, int gsi_override, int triggering, int polar
 	printk(KERN_DEBUG "xen: registering gsi %u triggering %d polarity %d\n",
 			gsi, triggering, polarity);
 
-	irq = xen_register_pirq(gsi, gsi_override, triggering, true);
+	irq = xen_register_pirq(gsi, triggering, true);
 
 	setup_gsi.gsi = gsi;
 	setup_gsi.triggering = (triggering == ACPI_EDGE_SENSITIVE ? 0 : 1);
@@ -148,7 +144,7 @@ static int xen_register_gsi(u32 gsi, int gsi_override, int triggering, int polar
 static int acpi_register_gsi_xen(struct device *dev, u32 gsi,
 				 int trigger, int polarity)
 {
-	return xen_register_gsi(gsi, -1 /* no GSI override */, trigger, polarity);
+	return xen_register_gsi(gsi, trigger, polarity);
 }
 #endif
 #endif
@@ -491,7 +487,7 @@ int __init pci_xen_initial_domain(void)
 		if (acpi_get_override_irq(irq, &trigger, &polarity) == -1)
 			continue;
 
-		xen_register_pirq(irq, -1 /* no GSI override */,
+		xen_register_pirq(irq,
 			trigger ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE,
 			true /* Map GSI to PIRQ */);
 	}
-- 
2.20.1

