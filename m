Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1169BEA0
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2019 17:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfHXPmV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Aug 2019 11:42:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37549 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfHXPmV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Aug 2019 11:42:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id d16so11846079wme.2
        for <linux-pci@vger.kernel.org>; Sat, 24 Aug 2019 08:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dk/6LfmE1oX8xh4qZCF6iNA2M7CxlYcaWLLLz9LpGWU=;
        b=t/4sfsSG8sjCEsNg6WFYZHxD/hZ5lb+pBrjALrpzyfcyDMNtA/EaBEYO3VTVTxR2b/
         jSlqKYgfN+sUssnYpHdcVXzTeKuTwttcBGQ5TjCtgrN8dNy4Ae35Q4Ya2KEqa1lU53c7
         EDP+BVIPMEECKZ5/rCOUVFtPuSqE5kByxKrwAuyvLxOKIZGRHtVnMAP9Qx+nK/ZcYLrw
         wpFiObjFo/nnmJVeZoZTKyqrATqK1rvT6d2c9BfBdrgjpkCVH3fqIH3vL5EbZ1VB00EW
         WLOqNxq7dy9S0IeTUWI2lOeEZOMoQJK7hCTyGeH1SBhuhJhRWNjYftHbQPh8S7YiBF41
         tUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dk/6LfmE1oX8xh4qZCF6iNA2M7CxlYcaWLLLz9LpGWU=;
        b=fCwpITI5OhwXJLgxQtI3ElqSqZv/cSUNZkzQhdqyAjLYR1+A3mlIZBO1L9QWkt5ZoB
         J9Y7aJmlDvDLj5il3FWa1bvrDJnOeasfVEMIa1/hjKAdNUlyjgPdnHao6MAfYk4V6yL1
         miGe8r8VP5NGGllewcWWEYTtWJ7ulFQU+MRYW/U0wImn4MeKSTzZrrJkkZ9ZFvKaweqo
         FZ0xHn/Q/mJu2t59OBacikeEiEiROYJsD8tRAKYG6x5Unww5gbJopDnfd2paP58uk1Li
         vwH2UrSO89RHamE97L7qG2I3a3OvfNwUcyW7jv262SCAq5xc6UOABfut0oRUI486Ge6s
         CBnQ==
X-Gm-Message-State: APjAAAUHUtFdSf9hkxumlhKBHXsn3Atj5fTgIDGTdK57BRxdmCMGlhLn
        PeS89uX0X61dMeQGOzQlVxw2IkL/
X-Google-Smtp-Source: APXvYqw84W5lpVmbiJSIlSFv6ZWNCx9ldeUy27SlM5snKLITBe2HknmKvpS2mFK+qa+/8ckN9cwp2w==
X-Received: by 2002:a1c:39c5:: with SMTP id g188mr11264342wma.167.1566661339011;
        Sat, 24 Aug 2019 08:42:19 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:2069:2121:113c:4840? (p200300EA8F047C0020692121113C4840.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:2069:2121:113c:4840])
        by smtp.googlemail.com with ESMTPSA id f197sm18304857wme.22.2019.08.24.08.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 08:42:18 -0700 (PDT)
Subject: [PATCH v4 1/4] PCI/ASPM: add L1 sub-state support to
 pci_disable_link_state
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <3797de51-0135-07b6-9566-a1ce8cf3f24e@gmail.com>
Message-ID: <d7640b34-00b5-ec40-38e6-46ef144f1e75@gmail.com>
Date:   Sat, 24 Aug 2019 17:40:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3797de51-0135-07b6-9566-a1ce8cf3f24e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for disabling states L1.1 and L1.2 to
pci_disable_link_state. Allow separate control of
ASPM and PCI PM L1 sub-states.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- allow separate control of ASPM and PCI PM L1 sub-states
---
 drivers/pci/pcie/aspm.c  | 11 ++++++++++-
 include/linux/pci-aspm.h | 10 +++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 464f8f926..1c1b9b7d6 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1095,7 +1095,16 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 	if (state & PCIE_LINK_STATE_L0S)
 		link->aspm_disable |= ASPM_STATE_L0S;
 	if (state & PCIE_LINK_STATE_L1)
-		link->aspm_disable |= ASPM_STATE_L1;
+		/* sub-states require L1 */
+		link->aspm_disable |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
+	if (state & PCIE_LINK_STATE_L1_1)
+		link->aspm_disable |= ASPM_STATE_L1_1;
+	if (state & PCIE_LINK_STATE_L1_2)
+		link->aspm_disable |= ASPM_STATE_L1_2;
+	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
+		link->aspm_disable |= ASPM_STATE_L1_1_PCIPM;
+	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
+		link->aspm_disable |= ASPM_STATE_L1_2_PCIPM;
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	if (state & PCIE_LINK_STATE_CLKPM) {
diff --git a/include/linux/pci-aspm.h b/include/linux/pci-aspm.h
index 67064145d..f635cbdff 100644
--- a/include/linux/pci-aspm.h
+++ b/include/linux/pci-aspm.h
@@ -19,9 +19,13 @@
 
 #include <linux/pci.h>
 
-#define PCIE_LINK_STATE_L0S	1
-#define PCIE_LINK_STATE_L1	2
-#define PCIE_LINK_STATE_CLKPM	4
+#define PCIE_LINK_STATE_L0S		BIT(0)
+#define PCIE_LINK_STATE_L1		BIT(1)
+#define PCIE_LINK_STATE_CLKPM		BIT(2)
+#define PCIE_LINK_STATE_L1_1		BIT(3)
+#define PCIE_LINK_STATE_L1_2		BIT(4)
+#define PCIE_LINK_STATE_L1_1_PCIPM	BIT(5)
+#define PCIE_LINK_STATE_L1_2_PCIPM	BIT(6)
 
 #ifdef CONFIG_PCIEASPM
 int pci_disable_link_state(struct pci_dev *pdev, int state);
-- 
2.23.0


