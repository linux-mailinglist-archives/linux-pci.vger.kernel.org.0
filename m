Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E549201CEA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jun 2020 23:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392154AbgFSVMM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jun 2020 17:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392091AbgFSVMJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2020 17:12:09 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B483FC06174E;
        Fri, 19 Jun 2020 14:12:07 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gl26so11616376ejb.11;
        Fri, 19 Jun 2020 14:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KMBNaqmBbj9htNDag97z0bn7cN5DmjB31K/2q35ybKs=;
        b=Xt+ERAczMjZ5VwzchOiLz2WSckbRaMvRMHmHlkReP29Uod92e0e1ioG8V+RkzSEgWJ
         V3GXll6AHBebYlNtGn8Y7vr3xKZgY+Q15a5kdw3I0KGzFfUevDuvQbLf0/A8tbew17H7
         HAhJENkAawKNsnVCqTrA2Ky5TRisZXzzcF9UcGhSrVTuVBN2DgQQZJQVp4mkR5cP7MQO
         O4MUeE8X1kUgc9lz8/iwEeoKEyOt+8vQd3HIJoAqYvjdPJkqf40Uo7WIqiE7F5YaZBvV
         NNEo7fNmqIZY0ABGTXXp+Q60EGeLbeJobHd5NMY4nyfJlKGd0vdpImuh//P+baFQ+vk6
         oXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KMBNaqmBbj9htNDag97z0bn7cN5DmjB31K/2q35ybKs=;
        b=D3flwsY1TN6cx+xyZqdJeADpt1IG1yIpVE17HR/U3Iq04ofxtXSTFip+cM2z3Yssf0
         gelo5OpA35YmYf0KR5rNXm29TAB4FFL0andEc2h7g/WOyBQ8BPlNeUJpJ3JGxrQNrtT1
         GcSn/wFmnvBrPS4S5XfFk3bQRxEsTelHKZMhl2KP0mx2vkaj5SF8KjSor7kL+l0npLzy
         NNq28jl8IP3w18GndjO+375e9+XjNY8FyHZb7I+ZKSeEvKUFvX0f/FrLxiDMa2uqwuIi
         38aTTdGRh+yV5XRLmQzs6BvSz493Uktprch0VGUy9K6N8YWEZK6ue2s/1Lyr62XzQT22
         2Jzg==
X-Gm-Message-State: AOAM532TbEYewY6BBzd4wN0HTqxNDeSdodiEPHy82uTyaiJuX0bg82hj
        uYZV4j4emkyssqHC1sFtkc0=
X-Google-Smtp-Source: ABdhPJyhe2+WW0hS1ywIY94bX4KQCWNto2I3Plf2M3dquuOAxpUzYIJyWAHUvLTbyMt1mGxsoLKAKA==
X-Received: by 2002:a17:907:7294:: with SMTP id dt20mr5300331ejc.355.1592601126447;
        Fri, 19 Jun 2020 14:12:06 -0700 (PDT)
Received: from net.saheed (54001B7F.dsl.pool.telekom.hu. [84.0.27.127])
        by smtp.gmail.com with ESMTPSA id kt10sm5485833ejb.54.2020.06.19.14.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 14:12:05 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: pciehp: Fix wrong failure check on pcie_capability_read_*()
Date:   Fri, 19 Jun 2020 22:12:19 +0200
Message-Id: <20200619201219.32126-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200619201219.32126-1-refactormyself@gmail.com>
References: <20200619201219.32126-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On failure, pcie_capabiility_read_*() will set the status value,
its last parameter to 0 and not ~0.
This bug fix checks for the proper value.

Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 53433b37e181..c1a67054948a 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -89,7 +89,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 
 	do {
 		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-		if (slot_status == (u16) ~0) {
+		if (slot_status == (u16)0) {
 			ctrl_info(ctrl, "%s: no response from device\n",
 				  __func__);
 			return 0;
@@ -165,7 +165,7 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	pcie_wait_cmd(ctrl);
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
-	if (slot_ctrl == (u16) ~0) {
+	if (slot_ctrl == (u16)0) {
 		ctrl_info(ctrl, "%s: no response from device\n", __func__);
 		goto out;
 	}
@@ -236,7 +236,7 @@ int pciehp_check_link_active(struct controller *ctrl)
 	int ret;
 
 	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)~0)
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)0)
 		return -ENODEV;
 
 	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
@@ -440,7 +440,7 @@ int pciehp_card_present(struct controller *ctrl)
 	int ret;
 
 	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	if (ret == PCIBIOS_DEVICE_NOT_FOUND || slot_status == (u16)~0)
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || slot_status == (u16)0)
 		return -ENODEV;
 
 	return !!(slot_status & PCI_EXP_SLTSTA_PDS);
@@ -592,7 +592,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 
 read_status:
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
-	if (status == (u16) ~0) {
+	if (status == (u16)0) {
 		ctrl_info(ctrl, "%s: no response from device\n", __func__);
 		if (parent)
 			pm_runtime_put(parent);
-- 
2.18.2

