Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E70F2C40E9
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 21:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfJATTK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 15:19:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36418 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfJATTK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Oct 2019 15:19:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so16877979wrd.3
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2019 12:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wBJD05NJvs43JSkNpE6CAGqMMhHik5oVKM6ZCLNUQNM=;
        b=Q2dLu8yiAbNzKFXG1hyMOR/u8Gxn5HmfJkRX+xgZtfA2Pn+9qm6ubTeuqztRdOv975
         X/4dvds44Xe+tlrMrLdNHU4D8ZQIKToGz5eFyYAUuhYC0kP+I5QODHCgZHsDHdq9bWM7
         PKDT+ZMJzjwM7KXMpsscGCp3udRKVF4rEzN6O4H22J53Q/f0wY5Xa+vBTB0mazqBImXQ
         gZXM8A5x9Vrw27KW86Np2Ec6OCyC59c+x48iXxLWfctImhFWB2VSOUO5YXMA76K/dR2p
         KbkeR/pL/zdLwFdw7+QeD5jmWdzA/auI+sWGb1OKKJ/9jOtCyZHq4xnX6E8yBFIJIpUJ
         O7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wBJD05NJvs43JSkNpE6CAGqMMhHik5oVKM6ZCLNUQNM=;
        b=hwDPRi8KFIWXewyumb4lHXeBox2ixmWNoMqGylqgcqXQ4HcG6pSpIPMi3mfTfFTqqM
         hFV7gCm7f0/bogUxqlawiboucfNwbz8w3iCT53oNVSU4V3Sb/xn/tHv3j5jUHOxGmOGG
         2OKgSBmGaH/PCJ50tsAj9Esi3G+qkOL46pepWRPNzOxNsAzQQuHq4Tt7uRXkjAcz0KjQ
         vxr4aXRtc8nQfrxHH19TbAAPnG4oXPYJjvkG1z1Ahf/t18zJmLWbRdjS4SDX7kEUPVcm
         5nBItDENmHK538VC3pGbTCY8ECafQbPMmkr4hJEk239Hww9ekFfjhpx5hbxxSjn5MdO8
         RudA==
X-Gm-Message-State: APjAAAU7bnbZEogxKM/o8KL2tph2vR+k0yRpUBjRODJeeQXnhaZwLHLe
        Uk2NRxxhAfisMWcJIBKRijIg3hMU
X-Google-Smtp-Source: APXvYqyUg01jqa1vICxSAXLOraJMSwa5cP+8KGk/qn3ctNhxE4T1nqr+KmBkWQLWv//5/lYah7Us6w==
X-Received: by 2002:adf:ce83:: with SMTP id r3mr162617wrn.219.1569957548020;
        Tue, 01 Oct 2019 12:19:08 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:ad11:16fb:d8da:de15? (p200300EA8F266400AD1116FBD8DADE15.dip0.t-ipconnect.de. [2003:ea:8f26:6400:ad11:16fb:d8da:de15])
        by smtp.googlemail.com with ESMTPSA id o188sm8450183wma.14.2019.10.01.12.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 12:19:07 -0700 (PDT)
Subject: [PATCH v6 1/4] PCI/ASPM: Add L1 PM Substate support to
 pci_disable_link_state
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <0577b966-6290-0685-123d-c675baf97caa@gmail.com>
Message-ID: <c9d695e1-8a87-2d8a-abbc-e6428f82c63d@gmail.com>
Date:   Tue, 1 Oct 2019 21:16:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0577b966-6290-0685-123d-c675baf97caa@gmail.com>
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


