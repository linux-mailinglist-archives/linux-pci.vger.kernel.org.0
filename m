Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5102B1AC87
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2019 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfELNzI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 May 2019 09:55:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41642 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfELNzI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 May 2019 09:55:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id d12so12331991wrm.8
        for <linux-pci@vger.kernel.org>; Sun, 12 May 2019 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6hZxOGP8G8oggFS1YREanO5aqFcGpl9yHjthuSm4vBw=;
        b=JB07z+01In//FiGHFergFnKVhl+tYDy3uMPsMzJA+vr+aOo+VMrp0F5owuPscwdjwv
         4deMACSHgToDhESPmT7q14lYzwulTwYhU3+2UfBzuhPtPOLD0YZLvuNS6QqCzn2BU0c2
         wpnVG+m1P3Sa4qQRQtqUOYCsWeSXqfsm11HOprqD51R/qcR4c0tlNZe9cqsw50arRFWI
         bIL5ZclMW3cx/pKRDXqgBH00FZIuQ9XLqP24rzVQHEDGT1vrLp3QZOJQU+DDc83HSKGt
         CS99cTkOoiDoX8h6eUrRWQjdzF8tY5uGjs7qPfKNqyy399/hQHNAzJvojj74Seaim22/
         IO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6hZxOGP8G8oggFS1YREanO5aqFcGpl9yHjthuSm4vBw=;
        b=DCkMLqt/qVVnJ4Uj5bICM+y7necwTQ3QIms8Lw4NDpRN71t178eZxybtbqrEr8rh9u
         Ub6d17BDizxiLI1TKJEzo63K2jfCY/E39Udks+GGWfsCQ7ySfMTypBN1vVRtAPi+XYYW
         szyZo7EzJBrtBnCvyf+EKK/KRR0tto4BWnFtP2XfHRf/WLPeOzECWM8xCb/CIvgZR9hg
         QbQDYdjbTuzzWF5bFpswoabEc7nyW4Uiw5/i64Xg5NagbH4dIKJLUqAV0DBtRbRMN4EP
         2EYswqwKzWOKN4+p/K47xJfLXsdxQtIu6FbadHxNw+e2hq2/Uz97sNvvRT4QI1hY80cl
         EF4A==
X-Gm-Message-State: APjAAAVHvhG7RUcNV+ylB4OUfwgH0GNF85zGI79NkL6bR85C/IWenr4y
        ERhbmHhRO+ke9NSwrjpXGR3NNrVutII=
X-Google-Smtp-Source: APXvYqyfgen85N0l8Vy3bvKwfc+G2sciFM6SMkRrdkmECdqhKT1brQ0dc4krEZu6CNm8Fowc68e7Lg==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr13487897wrn.108.1557669305967;
        Sun, 12 May 2019 06:55:05 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:9c27:51d8:9ed5:dad3? (p200300EA8BD457009C2751D89ED5DAD3.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:9c27:51d8:9ed5:dad3])
        by smtp.googlemail.com with ESMTPSA id d3sm16513387wmf.46.2019.05.12.06.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 06:55:05 -0700 (PDT)
Subject: [PATCH RFC v3 1/3] PCI/ASPM: add L1 sub-state support to
 pci_disable_link_state
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <bde6db67-b432-f23c-5a44-d2cbb794ad40@gmail.com>
Message-ID: <3dd8d88e-949f-6c37-aac9-9ce8c1198b47@gmail.com>
Date:   Sun, 12 May 2019 15:53:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bde6db67-b432-f23c-5a44-d2cbb794ad40@gmail.com>
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
v3:
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


