Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3848318C764
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 07:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgCTGY6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 02:24:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35894 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgCTGY6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 02:24:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id z72so2571288pgz.3;
        Thu, 19 Mar 2020 23:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ea1Gl53lAIVaAGNsB6v6FTznzesNiyM2e4xkz9is1KQ=;
        b=EmAYBy9IalRpEpvkaxh7LR4ZFW5G306ReU8nu8KZ/FyV0E3MrB4FiSJjrJJa8iGy7d
         Nq/Gqlt/5OHESCaG6OLhYoDAgiTs1UyXG2cL+Czt0IMveJSTNKsufPoZ2pK+HlKDcN11
         Vfzl0A/vsT4wrRGwkx3uOP8+6ENZ8rj6Zr3xD8SON9p3KN8RNLnbSKXrmDXXtQ4YzwgQ
         tn1hU0UY8yDp2taUHNH0M80Cway1uqLo9UVpYV4zl6jBulvaqV7ei0SJIesoxU12iVZ2
         /138xd7i9KQ/HeZ7IWZ9OrpFnbdRQ6BEyyqy42MhmuoE8J3tjRbvpUcGM+yVQOt4gpHS
         V0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ea1Gl53lAIVaAGNsB6v6FTznzesNiyM2e4xkz9is1KQ=;
        b=WfinIzMsRg9KtJ3vbQPPvvgz1b7Si5wxhG/goChoL55d+MelMNBc67kX9MGML8ZDDg
         KBWwoPZu4tTCWgwKEv/4EYovEPrJvIW6ZpYaqZirjjlo4BCOLJvbOm20KEGcwEIEq0e6
         UxFzYWnh88X64jV+w2f8dSIERkNC+kORJ6E8FgfWeUM2GnlMvsu+75XMbE0kVsKiLezv
         4/oiGe8X8QvEjZqcPMbFm8jd0ZLWeO7ZdAFVHB8mkHc9bjUsALZdNTtoUeD2l1W0Kj4v
         MTq4uH85kV5q89gav8+M8pKY3aExi4m2zyNEJMARpbjlqUiogU5/oYzM4njqG4PTMrRT
         JD5Q==
X-Gm-Message-State: ANhLgQ12eRwmMtZZt570K93X1JTbdKtBjfylfC0Pv+RJvLHvRGj1AEfT
        aBgBTi14SJzT99/aOwSUTYE=
X-Google-Smtp-Source: ADFU+vv3iEBLKcocZStjA8/MoeoZJUffW564ulxiLWHYN9gLTnsB8Vp7iTvBwa5tq1w6DX7PoyVLwg==
X-Received: by 2002:a62:27c2:: with SMTP id n185mr7858093pfn.203.1584685495047;
        Thu, 19 Mar 2020 23:24:55 -0700 (PDT)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id m9sm757659pff.93.2020.03.19.23.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 23:24:54 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     lorenzo.pieralisi@arm.com, anders.roxell@linaro.org,
        vidyas@nvidia.com
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        amurray@thegoodpenguin.co.uk, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH v2] PCI: dwc: fix compile err for pcie-tagra194
Date:   Fri, 20 Mar 2020 14:24:50 +0800
Message-Id: <1584685490-8170-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

make allmodconfig
ERROR: modpost: "dw_pcie_ep_init" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
ERROR: modpost: "dw_pcie_ep_init_notify" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
ERROR: modpost: "dw_pcie_ep_init_complete" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
ERROR: modpost: "dw_pcie_ep_linkup" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
make[2]: *** [__modpost] Error 1
make[1]: *** [modules] Error 2
make: *** [sub-make] Error 2

need to export the symbols.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 4233c43..1cdcbd1 100644
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
@@ -629,3 +632,4 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 
 	return dw_pcie_ep_init_complete(ep);
 }
+EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
-- 
1.8.3.1

