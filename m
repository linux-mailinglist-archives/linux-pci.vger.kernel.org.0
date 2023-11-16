Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDD7EDAAB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Nov 2023 05:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344785AbjKPEXt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 23:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344761AbjKPEXr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 23:23:47 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA519B
        for <linux-pci@vger.kernel.org>; Wed, 15 Nov 2023 20:23:44 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc5b705769so3806285ad.0
        for <linux-pci@vger.kernel.org>; Wed, 15 Nov 2023 20:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1700108623; x=1700713423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tfi6NRQOM22knNhjOgbQ1iXjVU1a+hCH4TP0Rz3zjE=;
        b=c3N7i0zp1dxSzP5rQ2XdsiXDL0ryiMfW7/LMA2mTqo2nCDoEl5z4Khlu+eCnVe8ZWk
         UD9O/NWMCDOnolOA+GpNVD07cftfYHwNk5NeGenVk7ycJ05aIV96HMw30VB7+K8ilB+G
         npKjdbNkoIC4/q3MP/kHAc64sReh9f7yyYxQEA7B7RIQitSRLlJ6rfJNLqxsaSYjS7ae
         4gL5DmfLGk/9WMPbHWIpP8cgadhNOfC/uvrR60dEHM+Nt8lJCCgyf25wdtpRcuQNZ1d9
         jdDgkb7clNOttbHjDG5l3RurTtzgPPlpl66bwGTFqlhV5ze/ZXnUz6NbNTBDJsPNEJen
         DyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700108623; x=1700713423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tfi6NRQOM22knNhjOgbQ1iXjVU1a+hCH4TP0Rz3zjE=;
        b=e5Hlxm3So6hsxwZVZwg5ddTOYuvWcAh9pieVLsSXRjcRbfo/482x1S4eJzn8V9yq8N
         dyTHyN+HtGxsXdUG1uQhzbPkzlfwh15S7gWNjDF+12aEcCrs2es73KXnlbZ+O5DrFXm0
         LsWzymdzhNyuCVykzPqMTVNd5iD7eW/c3y6c9+tlLVH3iZVv52lnoRs4BtoMAfFj2yaY
         kuU26E1hqlUXymf0/U86H4Rr6x4zrwGPYmWyRrm/cJq/fIo2NQgekO5dhaOA2FHx7a1x
         r3AZHZNxsX9NLMq+M8RKsB6d4iNAN4zT5o6Xrzub+MVCVA3THzB41Dmzal0OM10ei8u5
         OMjQ==
X-Gm-Message-State: AOJu0YziX3JrS7uY5VAh2COS0AHEnbqbOSmx4BiW35BK5kgWReCs8+Xd
        KcJE+xSo8yobIxuRKYWT+pbHkg==
X-Google-Smtp-Source: AGHT+IHzBxlw3azAPv1GM8+3LinnNSc5RziOndfLf0G5tD2p3Ail72qhsqwEa4/GVaSlSDddzDUkDA==
X-Received: by 2002:a17:902:e5c3:b0:1cc:8cf4:d8a7 with SMTP id u3-20020a170902e5c300b001cc8cf4d8a7mr9683277plf.16.1700108623434;
        Wed, 15 Nov 2023 20:23:43 -0800 (PST)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id w13-20020a170902d3cd00b001c9bca1d705sm8190069plb.242.2023.11.15.20.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 20:23:42 -0800 (PST)
From:   Jian-Hong Pan <jhp@endlessos.org>
To:     Jonathan Bither <jonbither@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v3] rtlwifi: rtl8723be: Disable ASPM if RTL8723BE connects to Intel PCI bridge
Date:   Thu, 16 Nov 2023 12:18:35 +0800
Message-ID: <20231116041834.8310-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <ea1d2505-7396-92c0-4687-facad575d299@gmail.com>
References: <ea1d2505-7396-92c0-4687-facad575d299@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Disable RTL8723BE's ASPM in a PCI quirk and rtl8723be module if the
Realtek RTL8723BE PCIe Wireless adapter connects to some Intel PCI
bridges, such as Skylake and Kabylake. Otherwise, the PCI AER flood
hangs system:

pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
pcieport 0000:00:1c.5:    [ 0] RxErr                  (First)
pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
pcieport 0000:00:1c.5: AER: can't find device of ID00e5
pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
pcieport 0000:00:1c.5: AER: can't find device of ID00e5
pcieport 0000:00:1c.5: AER: Multiple Corrected error received: 0000:00:1c.5
pcieport 0000:00:1c.5: AER: can't find device of ID00e5

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218127
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
v2: Add the switch case's default condition with comment:
    "The ASPM has already been enabled by initializing
    rtl8723be_mod_params' aspm_support as 1."

v3: Rework with a PCI qurik which disables RTL8723BE PCIE's ASPM, if it
    connects to some Intel bridges, such as Skylake and Kabylake. Then,
    rtl8723be checks the PCIE ASPM is enabled, or not. If it is not,
    disables rtl8723be's aspm_support parameter.

 .../wireless/realtek/rtlwifi/rtl8723be/sw.c   |  6 ++++
 drivers/pci/quirks.c                          | 36 +++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
index 43b611d5288d..fe9acbaa879b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
@@ -26,6 +26,12 @@ static void rtl8723be_init_aspm_vars(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
+	/* Disable ASPM if the link control disables it */
+	if (!pcie_aspm_enabled(rtlpci->pdev)) {
+		pci_info(rtlpci->pdev, "PCIE ASPM is disabled\n");
+		rtlpriv->cfg->mod_params->aspm_support = 0;
+	}
+
 	/*close ASPM for AMD defaultly */
 	rtlpci->const_amdpci_aspm = 0;
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eeec1d6f9023..170321f4b23b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3606,6 +3606,42 @@ DECLARE_PCI_FIXUP_FINAL(0x1b7c, 0x0004, /* Ceton InfiniTV4 */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x8169,
 			quirk_broken_intx_masking);
 
+
+static void quirk_disable_int_bridge_sub_pci_aspm(struct pci_dev *dev)
+{
+	struct pci_dev *pdev;
+	u16 val;
+
+	if (dev->bus && dev->bus->self)
+		pdev = dev->bus->self;
+	else
+		return;
+
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
+		switch (pdev->device) {
+		case 0x9d15:
+		/* PCI bridges on Skylake */
+		case 0xa110 ... 0xa11f:
+		case 0xa167 ... 0xa16a:
+		/* PCI bridges on Kabylake */
+		case 0xa290 ... 0xa29f:
+		case 0xa2e7 ... 0xa2ee:
+			pci_info(dev, "quirk: disable the device's ASPM\n");
+			pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &val);
+			val &= ~PCI_EXP_LNKCTL_ASPMC;
+			pcie_capability_write_word(dev, PCI_EXP_LNKCTL, val);
+			break;
+		}
+	}
+}
+
+/*
+ * Disable Realtek RTL8723BE PCIE's ASPM, if it connects to some Intel bridges,
+ * such as Skylake and Kabylake. Otherwise, the PCI AER flood hangs system.
+ */
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_REALTEK, 0xb723,
+			quirk_disable_int_bridge_sub_pci_aspm);
+
 /*
  * Intel i40e (XL710/X710) 10/20/40GbE NICs all have broken INTx masking,
  * DisINTx can be set but the interrupt status bit is non-functional.
-- 
2.42.1

