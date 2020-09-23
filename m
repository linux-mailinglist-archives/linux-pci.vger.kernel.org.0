Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3BE2764ED
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 02:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgIXAOv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 20:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIXAOv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 20:14:51 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B615C0613CE
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 17:14:51 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id k14so1605294edo.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 17:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7kHwfcAazeBg+h2uEVovJwlfIIrEWzUTpgb6sW8h8RI=;
        b=XhX2ZhKOexKs7QyhyEZso/Cywth1bItGzMPp0erbG0jVgRgR/Z7byFWwRy5QIusmUt
         w4IAkdAqOJgAvap6BA3IxCpeBhBaQK75Thxl7jTBwq75dsyEoWh13Hnn1T/QzMFPexDA
         nW2P8Vy3svJiYA5FYG26tk4SImu7Ev3i+pT+pDaBHYlIpgrm9xeSY/FtzIPu4lcdAyUI
         EkeNyS3qTmfT62uMLluF9HK6fiOAKOUDnD1Pzuxvw1307C70cAq41oD61VBcJv3HtfeR
         KXyfDi0OEV4Qlclz5VmQjiOHbmAF1jS56EslnJSYpUNETzuXq3QmstUc6TFT7saejmaf
         hZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7kHwfcAazeBg+h2uEVovJwlfIIrEWzUTpgb6sW8h8RI=;
        b=AVo5d0TsC1yysfxWYEEMIsnbUDRSdNmxK8gPwldyf/rCok/6JMSl+x06sanhUjhqFU
         M5fOTeEIvbkKHjYzAlrggqj3HqYiH3E333dp7JvFiSLlMJ0VZXYYP1V10hPeUuu8lnTZ
         VBOAxtrRJey2+wuI+w42o++CWz3gRwyCUZDxXjhgrkEALlF//MEVvBPcJVN7hQlBAUrI
         XFyinApQSqn2cyO3vR4sRYVMJ69h4fnVXrwLfdIZC6m15mDdk0xZuHLO7iPkIVJSuS4P
         oP/pGrq4SWrHgKpl73XRApNST5YMsjR8uMpnxgjTL+tugOwpjcnzjJLpgdxzRJS4N2kj
         xp5w==
X-Gm-Message-State: AOAM533KQoD8BYYlZbH7ueH5RS/dhjekUw30ei6or42TTBIhtENXaFkM
        nmX/ib8iFeIM3XcFBmrxuVxCWVOmt4KnbQ==
X-Google-Smtp-Source: ABdhPJyFgW+fCsejGi9f0ZVVLvoMyaE4iTmgFDgjiXEXexRQVuKO8wLgEbCqRtjKwV1uyLzkeMoUEQ==
X-Received: by 2002:a05:6402:cb4:: with SMTP id cn20mr1884326edb.369.1600906489644;
        Wed, 23 Sep 2020 17:14:49 -0700 (PDT)
Received: from net.saheed (5402C65D.dsl.pool.telekom.hu. [84.2.198.93])
        by smtp.gmail.com with ESMTPSA id r9sm1026559ejc.102.2020.09.23.17.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 17:14:49 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/8] PCI/ASPM: Cache device's ASPM link capability in struct pci_dev
Date:   Thu, 24 Sep 2020 01:15:10 +0200
Message-Id: <20200923231517.221310-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200923231517.221310-1-refactormyself@gmail.com>
References: <20200923231517.221310-1-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_get_aspm_reg() reads LNKCAP to learn whether the device supports
ASPM L0s and/or L1 and L1 substates.

If we cache the entire LNKCAP word early enough, we may be able to
use it in other places that read LNKCAP, e.g. pcie_get_speed_cap(),
pcie_get_width_cap(), pcie_init(), etc.

 - Add struct pci_dev.lnkcap (u32)
 - Read PCI_EXP_LNKCAP in set_pcie_port_type() and save it
   in pci_dev.lnkcap
 - Use pdev->lnkcap instead of reading PCI_EXP_LNKCAP

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 7 ++-----
 drivers/pci/probe.c     | 1 +
 include/linux/pci.h     | 1 +
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 253c30cc1967..d7e69b3595a0 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -177,15 +177,13 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	int capable = 1, enabled = 1;
-	u32 reg32;
 	u16 reg16;
 	struct pci_dev *child;
 	struct pci_bus *linkbus = link->pdev->subordinate;
 
 	/* All functions should have the same cap and state, take the worst */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
-		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
-		if (!(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
+		if (!(child->lnkcap & PCI_EXP_LNKCAP_CLKPM)) {
 			capable = 0;
 			enabled = 0;
 			break;
@@ -397,9 +395,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
 			      struct aspm_register_info *info)
 {
 	u16 reg16;
-	u32 reg32;
+	u32 reg32 = pdev->lnkcap;
 
-	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &reg32);
 	info->support = (reg32 & PCI_EXP_LNKCAP_ASPMS) >> 10;
 	info->latency_encoding_l0s = (reg32 & PCI_EXP_LNKCAP_L0SEL) >> 12;
 	info->latency_encoding_l1  = (reg32 & PCI_EXP_LNKCAP_L1EL) >> 15;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 03d37128a24f..2d5898f05f89 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1486,6 +1486,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	pdev->pcie_flags_reg = reg16;
 	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
 	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
+	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &pdev->lnkcap);
 
 	parent = pci_upstream_bridge(pdev);
 	if (!parent)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 835530605c0d..5b305cfeb1dc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -375,6 +375,7 @@ struct pci_dev {
 						   bit manually */
 	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
+	u32		lnkcap;		/* Link Capabilities */
 
 #ifdef CONFIG_PCIEASPM
 	struct pcie_link_state	*link_state;	/* ASPM link state */
-- 
2.18.4

