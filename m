Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 198101A83E
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2019 17:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfEKPdb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 May 2019 11:33:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43662 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbfEKPda (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 May 2019 11:33:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so10751072wro.10
        for <linux-pci@vger.kernel.org>; Sat, 11 May 2019 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nHrA0dH4hVlnCR8yFujqWLhxmwfnpSqBK4iJHIyvqN4=;
        b=bjaZe1VOVx/DqnO2MgiHVgHMA9CCo3KOsFFBJaVRXsOCAK3G1bRsJKPLksgQDVJglG
         lEVWM3G8hb9QHf7hdRxyPVFM0fSKkrmJzI0xUr3sL2mIUdmqC+ypoDWR6sX6HWn+/3xY
         ddK0PfRboP0pA0qdObkdDRpSSlP2S+zqRY1t2C7m7tAd2WOrongEVdh+RkTNxX8hr5kf
         nM2zf0IWbTrYkz+2e3pzh0RONnKsfBPgaLSvodpAuIucflVq0AOTh/PofztPxvpUrmtJ
         +c4V/ToxCu61sYYmggVHk+Yop4zKfU5R7efRXPgZsKR5OcLniVcGV7sIEUiQODSfVVGn
         fHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nHrA0dH4hVlnCR8yFujqWLhxmwfnpSqBK4iJHIyvqN4=;
        b=a0tCKK1cwW3I8G8S2W1tWjRGCD/SQApI9TvmqZpts5+XdRWozM8q2SxSbnhYOyjvIU
         ObIsnitAeUg89aqG4oUk1pI61yD+o0RzmbkLPuUjBCnd5G1NFrzXM4LMizWirlmSRFQH
         j4UgvbmBv6G/9KLeC7ik02gnO1zUqyePM8SAybA9+5e1qsSw5VkkoT2nAb3NwEgpg2pM
         3vQ44wgCWRaYaFz1ADrYbFiIYS6mYHxAOeKcNyjph+MFnjod7A3N0micdGYGuB/9qzOd
         eoYaKCO2QafiFr26IxbF7Tnze/+CZ3oSb+Q+zn9niD83lfmVCGC4dEmJIjNUY6cUY5Gz
         NyGQ==
X-Gm-Message-State: APjAAAWXAJkvOBkoeTG74SyFej3V9Fl58Byx0R5oZTwkNEudajljqjJ9
        NCIbGgJis9m2WTIaUnIhLM8yAQMmTjs=
X-Google-Smtp-Source: APXvYqx//ZbvA4nB5FfKzli3oCHgKAOl3b4p61FKTHMZjBBe/T7Zt1PiJ2iaunb13i7R6V2Yof0pGw==
X-Received: by 2002:adf:e690:: with SMTP id r16mr11195993wrm.193.1557588808945;
        Sat, 11 May 2019 08:33:28 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:152f:e071:7960:90b9? (p200300EA8BD45700152FE071796090B9.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:152f:e071:7960:90b9])
        by smtp.googlemail.com with ESMTPSA id r2sm19403320wrr.65.2019.05.11.08.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 08:33:28 -0700 (PDT)
Subject: [PATCH RFC v2 1/3] PCI/ASPM: add L1 sub-state support to
 pci_disable_link_state
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e041842a-55ed-91e3-75c2-c1a0267b74e5@gmail.com>
Message-ID: <3cb8c24e-28f3-b134-4367-cf5ae5a28383@gmail.com>
Date:   Sat, 11 May 2019 17:31:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e041842a-55ed-91e3-75c2-c1a0267b74e5@gmail.com>
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
v2:
- no change
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


