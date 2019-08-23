Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20D979A77A
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2019 08:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404340AbfHWGQO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Aug 2019 02:16:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37903 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404301AbfHWGQN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Aug 2019 02:16:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so7517079wrr.5
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2019 23:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dk/6LfmE1oX8xh4qZCF6iNA2M7CxlYcaWLLLz9LpGWU=;
        b=SP9yc7Lrvwg8ldBYtiSTFfd6aUnMY3DobSVDCF5DDtlqVz/RIMISiB3UAn2qqDXLfb
         jgLuaA13xvqvzPbXIUXJ4rTE2IvgzAEf7y2dWqrql5jBOynNZ4mz/ZZTyfsVfohvyndN
         Qlr1tzEMB/X/8tWEtVGCL89BM94tY+Ak7QYlXyP9VG2NXF66nrxKY3UhjIdqYbIGMMHZ
         TvOh7zoMLzcVYFEtQ/bEH612Au9p4FdV2NFAfEL7MEJwA5ML47+oAKBI+u5+TPvMFJrb
         ivovHahxcgKebh5gP1n5qOkKftcJFMnkoJSKlbhpsWBt6VHzrBRxEz4WJratWMMrN858
         RWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dk/6LfmE1oX8xh4qZCF6iNA2M7CxlYcaWLLLz9LpGWU=;
        b=QBIwoCEr33qzfOweA2LaeT7i7AavlDDsgmzKAySqYr95UKHkkFN9LzmLa6wQJ11Tvn
         mnT28z85QoJJLod0E4+T+OjjahBjnhzvOWqtCpI5SN7KYFlvNd1yTLKXEkf9Tsy+YJm3
         D+CfgejxHeavkgPoyB2VYkolrvX//nrYMgr/gCYkrXqsB6kvx3Yxu9s1Uv0qw2CC3L7t
         ybD6PdlhD8HQ6y0GgLHOIxYORY9bHB9si32lfhf1o9O2dsFA0fRzFQeD71kfXJu8tzi3
         rIqKCqR+XmluB7iau3w1Y3Zg3xASX847dsaWOBv96iI1TwcQ+f3WvAScHk1qj+/el51c
         BA4g==
X-Gm-Message-State: APjAAAUI7vb+UFzaUxNm+UDSmVpn7ohqxiAv3FSgey2cwhV8kH1MvlIy
        6O3ALPbfO1Hnj+fn/G7HpyiRT2r+
X-Google-Smtp-Source: APXvYqwuRoOaxYwYo0CQYQJKWCyWtXGL4DAUg/aPeACBcnV5CeMY8/HToVtFCcWk532ZuPDG4nHDjA==
X-Received: by 2002:a5d:5183:: with SMTP id k3mr3045633wrv.270.1566540971406;
        Thu, 22 Aug 2019 23:16:11 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:34d1:4088:cd1d:73a7? (p200300EA8F047C0034D14088CD1D73A7.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:34d1:4088:cd1d:73a7])
        by smtp.googlemail.com with ESMTPSA id e11sm4013125wrc.4.2019.08.22.23.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 23:16:10 -0700 (PDT)
Subject: [PATCH v3 1/4] PCI/ASPM: add L1 sub-state support to
 pci_disable_link_state
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <9e5ef666-1ef9-709a-cd7a-ca43eeb9e4a4@gmail.com>
Message-ID: <69c8c402-b34e-8eac-9b79-24c5f13c84dd@gmail.com>
Date:   Fri, 23 Aug 2019 08:12:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9e5ef666-1ef9-709a-cd7a-ca43eeb9e4a4@gmail.com>
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


