Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8707CC9CD
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2019 14:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfJEMJn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Oct 2019 08:09:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46684 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfJEMJn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Oct 2019 08:09:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so10050346wrv.13
        for <linux-pci@vger.kernel.org>; Sat, 05 Oct 2019 05:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wBJD05NJvs43JSkNpE6CAGqMMhHik5oVKM6ZCLNUQNM=;
        b=iF6Uaxgby2MFy1x+4nsUpOiq42iVPRFlRA4pp/GuLjxNCBqVtSq1bNsnigtlfuq4tX
         acUrBJZ5XWxOYZMD0OZsAAYwRTXlaTsbue6iM+wgNmzwrLyov7Os5GjdFh+bvdatPDw4
         5ALCYk3gvU5oylBMw/QOfU5r4AGbuuAuv2oLoMOUi8W8pMLnXRBnNFq8LhNj540DJRoz
         KC5nCjWhkaGWLy1LoQyH2r3YxUtTJNkdlm/txdhACIgEW8oTi8uY/GsZ0XANOX3gswLM
         EYQjBcsCrsywNGtYRW+xKi+32v5awZJpUxADQr9d271ISXHdN8NPJae0HdzOQ2Y97h79
         cF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wBJD05NJvs43JSkNpE6CAGqMMhHik5oVKM6ZCLNUQNM=;
        b=LGCG2rYI9A0ctuClGReuFEbaenqrsQ4zRvfdAxITtQYUI6qgFAt3a9xu0Y0gC4Vv33
         l0yZPXZ+8YKTzj/UsxakXj5qBzoh4uRKh8Ql8I5jqoGHBqCT++AQSQfefh8Jfm8w3OdE
         ksJjTt0PxDaJzfFwXOVHjclVolyfhagI1cRa9qF5oEW+SN7busPi115vnpu3A1Z9/s3S
         ZMBO3FQkhfAXQzpeK83DzuBfSY9+pXSFcevE5kmjhFCbxl0d6avYLl5fHaZzrFYISfbC
         08r3KHZ6aT7NZ9AE7HqZ9lDG7vFWxwJsZp2RympuxOr/AeTau6VKDPuBls3dKc10ZAUW
         nPaw==
X-Gm-Message-State: APjAAAX5Y12GO7atsCcG3EnX6xmZKpOKHBPo1iTgfEODiZbTDVFOTg1b
        SRLgQ+SyPfIc5PwyaSdb7OMx2M2F
X-Google-Smtp-Source: APXvYqy2vCbH+YGg/lnQejX+FQ3/ObunCtgr0TQ2EsZafLGLywgmzgkewT9cZ4Ep+qHe9V8IRKIC+A==
X-Received: by 2002:a5d:694c:: with SMTP id r12mr14725679wrw.44.1570277381180;
        Sat, 05 Oct 2019 05:09:41 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:78ef:16af:4ef6:6109? (p200300EA8F26640078EF16AF4EF66109.dip0.t-ipconnect.de. [2003:ea:8f26:6400:78ef:16af:4ef6:6109])
        by smtp.googlemail.com with ESMTPSA id j1sm21050541wrg.24.2019.10.05.05.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Oct 2019 05:09:40 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v7 1/5] PCI/ASPM: Add L1 sub-state support to
 pci_disable_link_state
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e1c28e25-df18-16e1-3e9f-933f613ea858@gmail.com>
Message-ID: <d81f8036-c236-6463-48e7-ebcdcda85bba@gmail.com>
Date:   Sat, 5 Oct 2019 14:04:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e1c28e25-df18-16e1-3e9f-933f613ea858@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for disabling states L1.1 and L1.2 to
pci_disable_link_state(). Allow separate control of
ASPM and PCI PM L1 sub-states.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- allow separate control of ASPM and PCI PM L1 sub-states
---
 drivers/pci/pcie/aspm.c | 11 ++++++++++-
 include/linux/pci.h     | 10 +++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 652ef23bb..ed463339e 100644
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
index f9088c89a..9dc5bee14 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1544,9 +1544,13 @@ extern bool pcie_ports_native;
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


