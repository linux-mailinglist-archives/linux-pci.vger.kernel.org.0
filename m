Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDFF018B381
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 13:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgCSMg3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 08:36:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34402 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgCSMg3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2020 08:36:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id t3so1220798pgn.1;
        Thu, 19 Mar 2020 05:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pdHYIy4o/U7zj6pa8QGy+CYZwTBER01p++W9HOV4Snk=;
        b=glAn++hulKWCC2bZX9JB+TstjTHco70lcxIVZ3WB92ccXhR/Q/m08Lo6gP2F00mR37
         avscJpCY9o7S5nGCYrpc4MJyjp9+f3Ic9qOHzCWCWvnQ+MgSKhuDwRRj+yfjq2e61QiX
         enAMllnikltm56F+8Bzrse72lnVPuelFxg+7ulUosc5lIpetrITODuySnn3DTvwoCdsp
         2uGZBzNprdNkwv3OWSbX+f6iO2kebG8mVnaO2IgcWW59T2FNs9E7FHO3AvP5toXooEa6
         PjdFkB5ZxEeDiXQYl6Vu9NkP47/ILybP8N+K7DPP9bJXEQr8oY79co3ft5syrNAaBe9P
         AMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pdHYIy4o/U7zj6pa8QGy+CYZwTBER01p++W9HOV4Snk=;
        b=N0ALIt/6pcKK5um9FDUflDFCFLPCX5EMCCnowCaZejBuQ87Q6JpZC0cMkIY+ULSYYk
         Eu4aZh2ZY/y5/hQ6supKYdw9twhcCNqDsDbTKBUQ93Ps7YlO4bs6LQZjD5nwFgRKjRo3
         s/pPMNgSMV72EYfDhcfI8lnUe6j911lq9b1XsW3+37vJD3wuBxBG8jUYfBe+F3QU8Rne
         m663GJe4bYsN6Wgz4naIWAicupFT0T0Ln1rpMOlLaYDb0SKrAdIUr4xAvhTx/UWQ3m6q
         EKnNc90VelxlvM02Dp3VUk1cKvrf7xW7RKf072TW0YwdrOGDc3D62HHElq4g9b1LwQys
         xB6Q==
X-Gm-Message-State: ANhLgQ0TWiqco8YNZxSl1fwB+9kO0sJPU+EnixYpq0vmVskv/x06P6NR
        yKYVrouLQS4matzl5vJXZBdIBoxRGNQ=
X-Google-Smtp-Source: ADFU+vsG+MAQHKlLXXNGeX7DwUAEgv8pxBRw1RCT554zJHRPCVPeTeAGUR9JTNhzNDLSEAokKQ2nqw==
X-Received: by 2002:a63:3449:: with SMTP id b70mr3172554pga.242.1584621386668;
        Thu, 19 Mar 2020 05:36:26 -0700 (PDT)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id x188sm2400771pfx.198.2020.03.19.05.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 05:36:25 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        amurray@thegoodpenguin.co.uk, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH -next] PCI: dwc: fix compile err for pcie-tagra194
Date:   Thu, 19 Mar 2020 20:36:20 +0800
Message-Id: <1584621380-21152-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

make allmodconfig
ERROR: modpost: "dw_pcie_ep_init_notify" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
ERROR: modpost: "dw_pcie_ep_init_complete" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
ERROR: modpost: "dw_pcie_ep_linkup" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
make[2]: *** [__modpost] Error 1
make[1]: *** [modules] Error 2
make: *** [sub-make] Error 2

need to export the symbols.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 4233c43..60d62ef 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -18,6 +18,7 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
 
 	pci_epc_linkup(epc);
 }
+EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
 
 void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
 {
@@ -25,6 +26,7 @@ void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
 
 	pci_epc_init_notify(epc);
 }
+EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
 
 static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar,
 				   int flags)
@@ -535,6 +537,7 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
 
 int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
-- 
1.8.3.1

