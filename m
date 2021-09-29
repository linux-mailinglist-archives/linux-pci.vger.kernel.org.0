Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E9941BBE1
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 02:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243461AbhI2Ap6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 20:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243541AbhI2Apt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 20:45:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8249DC06161C;
        Tue, 28 Sep 2021 17:44:09 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v18so1861747edc.11;
        Tue, 28 Sep 2021 17:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X2Mmz28tKhpY4RMXplVTUDjM+WhReCF+5Gp4Be7Q0+M=;
        b=C38lruJrbEQdQFBuhCDUllgqyqvwtKlnFnUiUraiVteyzHhCyQIchG2wViImyPMFxN
         /xLwshv5L+XIti+VG7lEFKQWAkwH0oUKXTDtp7Q8paHZ2LK58kc3N/UE8ullgwAK4Y8u
         9hWHUyH9I3LCRYv2R8EuexrFjz0wmpTxp9pY4zif5ps1N956BkrvZc+xkhHHW9Ci4FoQ
         rC+qHP3Jdv1suHJS+QzpBzAwh2yPv1oF34iC5E5k8Jdjuef1ZSF1POVdnjGsVigZPqPy
         xTNXuYIWCEjkmQ3FSBzSPpCvJw7oWlYe8SyJGEnp4fg6gscsl/XlgEh8WJTLtaWv9cuq
         KbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X2Mmz28tKhpY4RMXplVTUDjM+WhReCF+5Gp4Be7Q0+M=;
        b=asx6Ps5pgDwcxkOQ3mHhxPXYaiQxUtTgcyk3zsI3lupVeWFG9Qgp+QNzA3vaIYCDBW
         Ps54NLW9pzWh/N2239LPQCq1fY6gFofttKe/Hopb7xQizuyYw31ozGe6ROYtMwyHoXMR
         2BSOb5LEJ5oX3DCZvGc2ju2si9pxiqpFb3sYxy7DUemDXKtCzX4Xm6BAWepY/aP/x6e0
         CNYAPwkgpfwJFvl8saoaNYpT59ovlKbfOf/ev3tIU9pawfRe7W9PDOmUDSNx8czoAVmj
         m8UDhWpQqcM0wWHOu2RZyS4kptL9PVkCEQfq+A6Jeu//NuEUo7d/eCGNU72LSfEUXKX+
         mp7Q==
X-Gm-Message-State: AOAM531gC8n7PACFk0egU6v4b7pbr9gH5+wvBtBoYPMAUMOilbYNRNsE
        +ZPReK7yXguqcTkItn3EPMQ=
X-Google-Smtp-Source: ABdhPJxmBED0hNvbWqZMqlIqKCeHMg/jW59rSW1kEZC3IA7cmN9FNDperiMTAjH6vW6zzkOWdJnYuQ==
X-Received: by 2002:a50:ab18:: with SMTP id s24mr11622300edc.88.1632876248070;
        Tue, 28 Sep 2021 17:44:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:10f:c9f0:35c7:3af0:a197:61d0])
        by smtp.googlemail.com with ESMTPSA id r19sm383578edt.54.2021.09.28.17.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 17:44:07 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 4/4] PCI/ASPM: Remove struct pcie_link_state.clkpm_disable
Date:   Wed, 29 Sep 2021 02:44:00 +0200
Message-Id: <20210929004400.25717-5-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929004400.25717-1-refactormyself@gmail.com>
References: <20210929004400.25717-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

The clkpm_disable member of the struct pcie_link_state indicates
if the Clock PM state of the device is disabled. There are two
situations which can cause the Clock PM state disabled.
1. If the device fails sanity check as in pcie_aspm_sanity_check()
2. By calling __pci_disable_link_state()

It is possible to set the Clock PM state of a device ON or OFF by
calling pcie_set_clkpm(). The state can be retieved by calling
pcie_get_clkpm_state().

pcie_link_state.clkpm_disable is only accessed in pcie_set_clkpm()
to ensure that Clock PM state can be reenabled after being disabled.

This patch:
  - add pm_disable to the struct pcie_link_state, to indicate that
    the kernel has marked the device's AS and Clock PM states disabled
  - removes clkpm_disable from the struct pcie_link_state
  - removes all instance where clkpm_disable is set
  - ensure that the Clock PM is always disabled if it is part of the
    states passed into __pci_disable_link_state(), regardless of the
    global policy

Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 368828cd427d..e6ae00daa7ae 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -60,8 +60,7 @@ struct pcie_link_state {
 	u32 aspm_default:7;		/* Default ASPM state by BIOS */
 	u32 aspm_disable:7;		/* Disabled ASPM state */
 
-	/* Clock PM state */
-	u32 clkpm_disable:1;		/* Clock PM disabled */
+	u32 pm_disabled:1;		/* Disabled AS and Clock PM ? */
 
 	/* Exit latencies */
 	struct aspm_latency latency_up;	/* Upstream direction exit latency */
@@ -198,7 +197,7 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 	 * Don't enable Clock PM if the link is not Clock PM capable
 	 * or Clock PM is disabled
 	 */
-	if (!capable || link->clkpm_disable)
+	if (enable && (!capable || link->pm_disabled))
 		enable = 0;
 	/* Need nothing if the specified equals to current state */
 	if (pcie_get_clkpm_state(link->pdev) == enable)
@@ -206,11 +205,6 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 	pcie_set_clkpm_nocheck(link, enable);
 }
 
-static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
-{
-	link->clkpm_disable = blacklist ? 1 : 0;
-}
-
 static bool pcie_retrain_link(struct pcie_link_state *link)
 {
 	struct pci_dev *parent = link->pdev;
@@ -952,8 +946,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	 */
 	pcie_aspm_cap_init(link, blacklist);
 
-	/* Setup initial Clock PM state */
-	pcie_clkpm_cap_init(link, blacklist);
+	link->pm_disabled = blacklist;
 
 	/*
 	 * At this stage drivers haven't had an opportunity to change the
@@ -1129,8 +1122,8 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	if (state & PCIE_LINK_STATE_CLKPM)
-		link->clkpm_disable = 1;
-	pcie_set_clkpm(link, policy_to_clkpm_state(link));
+		pcie_set_clkpm(link, 0);
+
 	mutex_unlock(&aspm_lock);
 	if (sem)
 		up_read(&pci_bus_sem);
@@ -1301,7 +1294,6 @@ static ssize_t clkpm_store(struct device *dev,
 	down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 
-	link->clkpm_disable = !state_enable;
 	pcie_set_clkpm(link, policy_to_clkpm_state(link));
 
 	mutex_unlock(&aspm_lock);
-- 
2.20.1

