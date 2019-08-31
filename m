Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32630A4629
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2019 22:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfHaUVO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Aug 2019 16:21:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40831 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfHaUVO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Aug 2019 16:21:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id t9so10816542wmi.5
        for <linux-pci@vger.kernel.org>; Sat, 31 Aug 2019 13:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BiNwWT0M1OAy06tKN+bdr+MkdmbD4pT3atZheplZ5JA=;
        b=Os/QglKstOeNdN/bWZ/naaa43JTlGch3XxTV8AhcWHGMx4WFJOM92xmome6OFKEG7K
         a7H1rkVBksZGR/SGMrdpV/7CyQkBqgOdk6ZMgJgN497jtvjp2S353Gcee79kkEIbkUQ6
         olWzz1Y/+/Xx9vstW1B0ujJ0dM+ce5SeluDOUjz0fy8V8p3vF2z7Ba4mgZ3IjuiMUY29
         XsTNONDMF3f41XUOYSBAHSsRMZ5OBiY+2wW7lF6LlcQEoWLA61ooQi53+W2xsFYk81px
         AjxQ2N4CyQfPVqkQXnXdnQ8sRq60s/tdc2LDS3OSQv2c2oHAyDLbKLGc/7uzkZPxUs4z
         cb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BiNwWT0M1OAy06tKN+bdr+MkdmbD4pT3atZheplZ5JA=;
        b=ilZY75mY4wQUwVosZK3Uxiw/YibsyNDB7d3N1nXW/ACl/+iFfbv35zyltEhHD+UvW4
         jXHMCEIjXHAiViFHsayKcGieZIH1U4ZEzXczSlnwopwaMQ0wsKX+dkGtmD9nemgxE4xk
         gDxRbbj8QQHDzV8QcUZB5w1CqFoiXO0X1L12MVEgvCKu6F9cCwv9BMDAu3hwXCNZVHOw
         RL1SCLudDJXT94OQBCb4HXojuFsWK1+a4AuodBi38hM9xzNnn2xPjknC9HnvEjcc7Gfe
         68DbyczqzONbnOgBmF4G/2yfB2zIqweMRRVdSt2Bqoa65BHlf38pHkqQqvRjqqcLQmDS
         nKEg==
X-Gm-Message-State: APjAAAVrVq+D2ejCnY1yYDqYhM1WTNSbP3CS/Lg7u+lNNwAvSrd1283d
        8gXdeSjlU5YT8E7HbpDVpxbB8H+X
X-Google-Smtp-Source: APXvYqyqhJCvKm8EH9IU82cCNKjWJjxEhsY2oLyJWFgLjT2ET3Dp9S8YJYvYTneFg8T31bGiXbLPIA==
X-Received: by 2002:a1c:5451:: with SMTP id p17mr21366607wmi.103.1567282871883;
        Sat, 31 Aug 2019 13:21:11 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:9586:e556:3a4d:c04? (p200300EA8F047C009586E5563A4D0C04.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:9586:e556:3a4d:c04])
        by smtp.googlemail.com with ESMTPSA id d1sm10543625wrs.71.2019.08.31.13.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 13:21:11 -0700 (PDT)
Subject: [PATCH v5 1/4] PCI/ASPM: add L1 sub-state support to
 pci_disable_link_state
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <c63f507f-7f52-7164-dbc5-07fc18e433b8@gmail.com>
Message-ID: <18f323f1-89a9-f624-1cef-a226e257b69a@gmail.com>
Date:   Sat, 31 Aug 2019 22:15:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c63f507f-7f52-7164-dbc5-07fc18e433b8@gmail.com>
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
v5:
- rebased to latest pci/next
---
 drivers/pci/pcie/aspm.c | 11 ++++++++++-
 include/linux/pci.h     | 10 +++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index ad6259ec5..6de7a597a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1094,7 +1094,16 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
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
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 67303262f..054345eed 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1553,9 +1553,13 @@ extern bool pcie_ports_native;
 #define pcie_ports_native	false
 #endif
 
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


