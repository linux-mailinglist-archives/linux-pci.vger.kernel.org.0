Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA6FA98297
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 20:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfHUSTA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 14:19:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43402 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbfHUSTA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2019 14:19:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id y8so2927635wrn.10
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2019 11:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dk/6LfmE1oX8xh4qZCF6iNA2M7CxlYcaWLLLz9LpGWU=;
        b=sE1ZITFoLaXnVvOf00ZCcBprI80GZcyK6+BjLcyxxOoX3OEXh+qUtA2VYbJc+Bf35f
         xQioq0aWHGCIAU9AWoFn3f8umoi3FcobCdFgODDqwd/8yZ9KY2MwKvQIMv3u5g5N1h9a
         c5v6tk3NXz5xplIixP5VdeYRcEyOX00/ZCIWEFY1Iw2xwIOCoaS+c3qaVfqTsCT8KBtD
         GoduqrVe2ZAXndtCkOlNY5TDGuJkmOLH0OKW6P7mtYVnjSAAcwOoKFeYN/zp6nnzwqcS
         jFhCzi90NsWwzH2XPTmC15dtL83zfQyMqpcQBsokjd31sHHlFEt93lPxFno1lkXGvQgf
         lgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dk/6LfmE1oX8xh4qZCF6iNA2M7CxlYcaWLLLz9LpGWU=;
        b=AdfGzJzU2mUY5wLTo83+tfsIKTpNoFqk+GlGs7D2D3yTD4a0wBnPddjTjCANj2ys/b
         xE9tW6lgWshKp6uYu4xGba4gqZyYQfsB0yjAX3W3/8ZoIZjWmA2rC2tMRw05zq9U6JTN
         L2Ob06TzWsXYFaluFyXD3gL0Gp/FhX/7xFoo6aIZDypcnJVQuGcDDFnuFiyVYGvvO5lj
         gohClgUR2jYbPrtjT0z3RSwQnIbc8XQQ69F9Bx0x/ZA8MVF0i5DU0H9JuHPx32BYCnuZ
         A7Cz59giDZys/v3m450OcboZ7e3abWXpJOpHylHhKMzEmny+/xFOmSmCZCMH04Z1gmmS
         JE/w==
X-Gm-Message-State: APjAAAU0EjyQpcSWKG1+ug4XrQcF42704wBXnqIO4EqBbQe0eHJya9C6
        ey59Fct7rLGVBgkA8DdaukyEKRET
X-Google-Smtp-Source: APXvYqwrhZIN8S/Zy4D1JUDpmQvu42E0UJiuK0ahISA2XNMziho9gIa42/ud7ao44D9JfnsZpf2msw==
X-Received: by 2002:adf:91c2:: with SMTP id 60mr44581140wri.334.1566411537593;
        Wed, 21 Aug 2019 11:18:57 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:3d5d:5315:9e29:1daf? (p200300EA8F047C003D5D53159E291DAF.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:3d5d:5315:9e29:1daf])
        by smtp.googlemail.com with ESMTPSA id g65sm1922108wma.21.2019.08.21.11.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 11:18:56 -0700 (PDT)
Subject: [PATCH v2 1/3] PCI/ASPM: add L1 sub-state support to
 pci_disable_link_state
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <b4b1518a-d0e8-9534-5211-115107e770e1@gmail.com>
Message-ID: <caa2c135-1fb3-f19e-a2e9-66edaf79b73e@gmail.com>
Date:   Wed, 21 Aug 2019 20:17:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b4b1518a-d0e8-9534-5211-115107e770e1@gmail.com>
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


