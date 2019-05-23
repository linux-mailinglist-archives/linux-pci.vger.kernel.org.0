Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75FC928B3B
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 22:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbfEWUFt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 16:05:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43731 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbfEWUFt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 16:05:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id t7so7289355wrr.10
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2019 13:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kzu+IErrOKTjkX/at7kkRf5eNsPGEAisB7hOvORvAyU=;
        b=RCdh0RYqWGQrJZJD11U9Nh8vZBbPCgulFCh7jH5dTQgMOO9taP3l6GrXpbJye2nMHr
         m3ybaKaBSSC7tIJehcnpCTR3IExfO2pTOosYPmnCu/RruluAKQmCheHtyqkZwhWy0MuC
         5O3QIddRXmS1ssOfaSNWmpPIKQPr2092cBN2o1LyBKtjiYnn87POvWnaHh8SUpPB1Azy
         Yy/ji4Hlf2P2zvTcpknp3wiV96Fv4IJzWuwEFNqoEIxebHJ4zQ5eTHf7ac3sfg8HTRay
         WWjlgaHtPNBJ6Pzfjs3jH5roGWTjrfM9MWu4UtN9Q1iDE0PaAJGcNU3gTJcujS9UOEjM
         fdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kzu+IErrOKTjkX/at7kkRf5eNsPGEAisB7hOvORvAyU=;
        b=DGJEfSZMt8F/nJDg4LU3ZJ3Jfd5LoMAxk2D0viZijRCBxvtjK6NiJ1Y2Voo0hQ7W8g
         0ecm2zTCyPIPx1RpgcCOGP7Ly3khJgjUO9CnqHYFlBJBJq+Wei3vyr4qxOAg2wlEdx7O
         HfvhLuAnw186mvtWwZvsVjlaAaZ/XeBDGUgnceIgWn8NiKrRMcG/wMFQWO50vvQDK4SJ
         yIZZx4nxO4GHJRY9DPPM7SnQvX3UuxY6s6FWWMxgLPcqCIiOju32GcfLabrkzP/gM7/E
         l/n3QPmhKI/d0Ro+FMO98lwgfSuER4CJFx0A/JCFvK5zxOo2mbMOglL9fbBIWkAo27ap
         ONLQ==
X-Gm-Message-State: APjAAAUWXCIOjaspKR/4S/nSymrv/jEtNTwcTN+pZ0TUpDXCPRRpgleq
        Go6AcpLv8lOtSssuaRYZSbeO2L6P
X-Google-Smtp-Source: APXvYqxUzbW/XlK7vVoAUgPNbwBILV0YjHUwPUrEACS+5QfMLFVjsej8W+lME//BTW7XND1lLgkoig==
X-Received: by 2002:adf:edce:: with SMTP id v14mr55926977wro.94.1558641947165;
        Thu, 23 May 2019 13:05:47 -0700 (PDT)
Received: from ?IPv6:2003:ea:8be9:7a00:3cd1:e8fe:d810:b3f0? (p200300EA8BE97A003CD1E8FED810B3F0.dip0.t-ipconnect.de. [2003:ea:8be9:7a00:3cd1:e8fe:d810:b3f0])
        by smtp.googlemail.com with ESMTPSA id f24sm276599wmb.16.2019.05.23.13.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 13:05:46 -0700 (PDT)
Subject: [PATCH 1/3] PCI/ASPM: add L1 sub-state support to
 pci_disable_link_state
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <7a6d2f14-f2a6-99ad-3a93-fdaa0726ce86@gmail.com>
Message-ID: <6b01bb7d-8ed7-89f0-46e1-5f8a34d68f79@gmail.com>
Date:   Thu, 23 May 2019 22:03:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7a6d2f14-f2a6-99ad-3a93-fdaa0726ce86@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for disabling states L1.1 and L1.2 to pci_disable_link_state.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pcie/aspm.c  | 13 ++++++++++---
 include/linux/pci-aspm.h |  8 +++++---
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index fd4cb7508..511f3e018 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -35,9 +35,9 @@
 #define ASPM_STATE_L1_1_PCIPM	(0x20)	/* PCI PM L1.1 state */
 #define ASPM_STATE_L1_2_PCIPM	(0x40)	/* PCI PM L1.2 state */
 #define ASPM_STATE_L1_SS_PCIPM	(ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1_2_PCIPM)
+#define ASPM_STATE_L1_1_MASK	(ASPM_STATE_L1_1 | ASPM_STATE_L1_1_PCIPM)
 #define ASPM_STATE_L1_2_MASK	(ASPM_STATE_L1_2 | ASPM_STATE_L1_2_PCIPM)
-#define ASPM_STATE_L1SS		(ASPM_STATE_L1_1 | ASPM_STATE_L1_1_PCIPM |\
-				 ASPM_STATE_L1_2_MASK)
+#define ASPM_STATE_L1SS		(ASPM_STATE_L1_1_MASK | ASPM_STATE_L1_2_MASK)
 #define ASPM_STATE_L0S		(ASPM_STATE_L0S_UP | ASPM_STATE_L0S_DW)
 #define ASPM_STATE_ALL		(ASPM_STATE_L0S | ASPM_STATE_L1 |	\
 				 ASPM_STATE_L1SS)
@@ -1094,8 +1094,15 @@ static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 	link = parent->link_state;
 	if (state & PCIE_LINK_STATE_L0S)
 		link->aspm_disable |= ASPM_STATE_L0S;
-	if (state & PCIE_LINK_STATE_L1)
+	if (state & PCIE_LINK_STATE_L1) {
 		link->aspm_disable |= ASPM_STATE_L1;
+		/* sub-states require L1 */
+		link->aspm_disable |= ASPM_STATE_L1SS;
+	}
+	if (state & PCIE_LINK_STATE_L1_1)
+		link->aspm_disable |= ASPM_STATE_L1_1_MASK;
+	if (state & PCIE_LINK_STATE_L1_2)
+		link->aspm_disable |= ASPM_STATE_L1_2_MASK;
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	if (state & PCIE_LINK_STATE_CLKPM) {
diff --git a/include/linux/pci-aspm.h b/include/linux/pci-aspm.h
index df28af5ce..e66c3e3d8 100644
--- a/include/linux/pci-aspm.h
+++ b/include/linux/pci-aspm.h
@@ -19,9 +19,11 @@
 
 #include <linux/pci.h>
 
-#define PCIE_LINK_STATE_L0S	1
-#define PCIE_LINK_STATE_L1	2
-#define PCIE_LINK_STATE_CLKPM	4
+#define PCIE_LINK_STATE_L0S	BIT(0)
+#define PCIE_LINK_STATE_L1	BIT(1)
+#define PCIE_LINK_STATE_CLKPM	BIT(2)
+#define PCIE_LINK_STATE_L1_1	BIT(3)
+#define PCIE_LINK_STATE_L1_2	BIT(4)
 
 #ifdef CONFIG_PCIEASPM
 void pci_disable_link_state(struct pci_dev *pdev, int state);
-- 
2.21.0


