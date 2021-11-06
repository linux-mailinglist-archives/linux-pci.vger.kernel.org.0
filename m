Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE1A446F7B
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhKFRz7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbhKFRz6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:55:58 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11A8C061714;
        Sat,  6 Nov 2021 10:53:16 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id f8so44912128edy.4;
        Sat, 06 Nov 2021 10:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6exyrB9eI4Ukr7viowD1F2sVcUX7M9z1Yw2CZoS4oow=;
        b=BCWceeMyYA42nBlr9VPVnXxupqwV8ppJ5aEzz8Cv+ZMwvP6tXIYJgRB/rdOuLRe8Jw
         trQyZaqKXwS1oyYZ2dWJqVzOMzX5tUslCQHZqbWW/WRMhGO3BnL4MKgBROgmG4Vv6yUL
         nM4lO3+vAiyTgQRabf+25BVyjDVQk4ez0o1w0mXrdIrl+EbeIiHhb6V9azvun+oHzfhE
         1VlO48RVsBrk+Tr9o2Tzm6tS+FtcussABU27ThrOl9tLP6obnPPdopFPP3ZNpMaIOaVK
         AhrzFJB2c7mJofbFg1d67Lp/aX3DAhE5A8pcx8SwO9psB+bersFMCt5RUFh+WAShmvbw
         LjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6exyrB9eI4Ukr7viowD1F2sVcUX7M9z1Yw2CZoS4oow=;
        b=fm7LbXAHDVU4CUzQmpdBa3MpQZVde0g2ceAxfXtrtmsmkmio/78YBz2IQfxZW8TSeV
         fRxFztC7eob70Y6zgFDvqKRBKFI/bxT9lZ1ieYlJd7qRz0NFsiqYqEGNfbBp+C2WpB6B
         w5n39mhxN0Q2GMsuggMpQyiiQGA37/H9IbNmJ3/tUVhSPowyp+bAocDW9XLr+6USaEiH
         V4ymXgLGKxv02dOdzEo6j6CCVJ5qRi3vX9i2uGIiMG7a+zf8Q17xukQ5nGY3DP1+t6dH
         pgiQ+J70RpqgRLPgbFfHQx64KARCKhkURXX65r+SKuCP47nsiMpeWXq/+OSi+b9FhZCr
         8KcA==
X-Gm-Message-State: AOAM5310vSdRmIWyVJCHhZ+9QtaJ9BS19icH21DrtH7ljKYt4zuJaZuH
        mnzHlMiqHLk7YV6g5n+wIgU=
X-Google-Smtp-Source: ABdhPJyQj8bHzy5SOKI4lotIOvBoTAiWOxLCVdpoStd1VPhI3lCpA/4BaoYWU96kaoA11X5KzJTkGA==
X-Received: by 2002:a17:907:86a6:: with SMTP id qa38mr7286788ejc.286.1636221195202;
        Sat, 06 Nov 2021 10:53:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id g10sm6364857edr.56.2021.11.06.10.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:53:14 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 3/4] PCI/ASPM: Remove struct pcie_link_state.acceptable
Date:   Sat,  6 Nov 2021 18:53:04 +0100
Message-Id: <20211106175305.25565-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175305.25565-1-refactormyself@gmail.com>
References: <20211106175305.25565-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The acceptable latencies for each device on the bus are calculated within
pcie_aspm_cap_init() and cached in struct pcie_link_state.acceptable.
They are only used within pcie_aspm_check_latency() to validate actual
latencies. Thus, it is possible to avoid caching these values.

 - remove `acceptable` from struct pcie_link_state
 - calculate the acceptable latency for individual device directly
 - remove the calculations done within pcie_aspm_cap_init()

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 9e74df7b9dc0..6afbb86d07b8 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -65,12 +65,6 @@ struct pcie_link_state {
 	u32 clkpm_enabled:1;		/* Current Clock PM state */
 	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
 	u32 clkpm_disable:1;		/* Clock PM disabled */
-
-	/*
-	 * Endpoint acceptable latencies. A pcie downstream port only
-	 * has one slot under it, so at most there are 8 functions.
-	 */
-	struct aspm_latency acceptable[8];
 };
 
 static int aspm_disabled, aspm_force;
@@ -389,7 +383,7 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-	u32 latency, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
+	u32 reg32, latency, encoding, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
 	struct aspm_latency latency_up, latency_dw;
 	struct aspm_latency *acceptable;
 	struct pcie_link_state *link;
@@ -400,7 +394,13 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		return;
 
 	link = endpoint->bus->self->link_state;
-	acceptable = &link->acceptable[PCI_FUNC(endpoint->devfn)];
+	pcie_capability_read_dword(endpoint, PCI_EXP_DEVCAP, &reg32);
+	/* Calculate endpoint L0s acceptable latency */
+	encoding = (reg32 & PCI_EXP_DEVCAP_L0S) >> 6;
+	acceptable->l0s = calc_l0s_acceptable(encoding);
+	/* Calculate endpoint L1 acceptable latency */
+	encoding = (reg32 & PCI_EXP_DEVCAP_L1) >> 9;
+	acceptable->l1 = calc_l1_acceptable(encoding);
 
 	while (link) {
 		/* Read direction exit latencies */
@@ -663,22 +663,11 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	/* Get and check endpoint acceptable latencies */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
-		u32 reg32, encoding;
-		struct aspm_latency *acceptable =
-			&link->acceptable[PCI_FUNC(child->devfn)];
 
 		if (pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT &&
 		    pci_pcie_type(child) != PCI_EXP_TYPE_LEG_END)
 			continue;
 
-		pcie_capability_read_dword(child, PCI_EXP_DEVCAP, &reg32);
-		/* Calculate endpoint L0s acceptable latency */
-		encoding = (reg32 & PCI_EXP_DEVCAP_L0S) >> 6;
-		acceptable->l0s = calc_l0s_acceptable(encoding);
-		/* Calculate endpoint L1 acceptable latency */
-		encoding = (reg32 & PCI_EXP_DEVCAP_L1) >> 9;
-		acceptable->l1 = calc_l1_acceptable(encoding);
-
 		pcie_aspm_check_latency(child);
 	}
 }
-- 
2.20.1

