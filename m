Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF95E457723
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 20:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbhKSTmg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 14:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbhKSTmf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 14:42:35 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97293C061574;
        Fri, 19 Nov 2021 11:39:25 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id o20so2527987eds.10;
        Fri, 19 Nov 2021 11:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rj93QcILIz19ZRcferyP1zIgd4/v1Pg6xmThPg4ZhjY=;
        b=OU6etl9KFjHr03VjZ6y6xiPNTKIUTGC1OzimdFOyNhldGtfHxGyfGZLape0ShqVD9V
         kNow3h9taNCWnzGBwquufYv0aVYj9gfNNmFV/z/0ZL8UcF37P2dXybEVOWs9+Omxg60L
         ZqT+QCmDOMBenEukECm98y6TbGcLXP2yBh07Qi3M6QLxMOcoDCTSgcp5tT44pucyPSc7
         uf195PY2MrUI8QmmIuBjR6cTT9i7uaWjpuw1+Y/lxkVCak54rV1mB+XDxi3nW5rKC1Ln
         uaUv1nlHnTm8axfBAqdjMp8YwsUB8ZRDdhi9M5kJyIqsSvi+ALzQ43e0QyFTpTahYh4v
         DvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rj93QcILIz19ZRcferyP1zIgd4/v1Pg6xmThPg4ZhjY=;
        b=JT/NxNgYX9GxF/ANykyf6av6PyEwnX7LDjhab0oPG8wADszHYmczkd8X1WzQhBhdYx
         JRtVoVWo7qi7vPF7fjh2lN4dUs6kfXRjSTIaD4IKykGauihugIPjoCMVC4DLACCaZE52
         Zz4hk04id5ua2tgW0LJh47Fl9IEuIZ3x0n1GMuCg0y76wR3mLpZfOKPI+z+sbBl76gWP
         XS0mlqKHG8Wx5Y01iekuK0fRaJErI7So2XKwMi9mP1PQK3WQsfSzrnsbXc1FIdzhSLrK
         D0+g+oYafSeQ+o8S1Yc5YrXA/6fOFzcBlmnhfTR/nldKMu1GVc4ZKANmNz05NsJZCldm
         kt7g==
X-Gm-Message-State: AOAM533n++dFxtkcfbqeGtr06zOtLukzkWrYgnTotY27WreGGQ5rEkrI
        S5x7PMFxEtm1Znr4X4u3CR8x0+YhTdI=
X-Google-Smtp-Source: ABdhPJxsnLHK8nf41r2F1legqgBx8dyP3FklJ4cjYLXI7yNFdoPkh1ZO6mfE9M+YPWzbRNyDlR7utw==
X-Received: by 2002:a17:907:764b:: with SMTP id kj11mr81552ejc.307.1637350764197;
        Fri, 19 Nov 2021 11:39:24 -0800 (PST)
Received: from localhost.localdomain (catv-176-63-2-222.catv.broadband.hu. [176.63.2.222])
        by smtp.googlemail.com with ESMTPSA id sb19sm327521ejc.120.2021.11.19.11.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 11:39:23 -0800 (PST)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de
Subject: [RFC PATCH v5 3/4] PCI/ASPM: Remove struct pcie_link_state.acceptable
Date:   Fri, 19 Nov 2021 20:37:31 +0100
Message-Id: <20211119193732.12343-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211119193732.12343-1-refactormyself@gmail.com>
References: <20211119193732.12343-1-refactormyself@gmail.com>
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
 drivers/pci/pcie/aspm.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 1b8933e0afb2..a8821fe1ffe7 100644
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
@@ -389,7 +383,8 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-	u32 latency, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
+	u32 reg32, latency, encoding, lnkcap_up, lnkcap_dw;
+	u32 l1_switch_latency = 0;
 	struct aspm_latency latency_up, latency_dw;
 	struct aspm_latency *acceptable;
 	struct pcie_link_state *link;
@@ -400,7 +395,13 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
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
 		struct pci_dev *dev = pci_function_0(
@@ -669,22 +670,11 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
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

