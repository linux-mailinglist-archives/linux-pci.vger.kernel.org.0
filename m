Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12DA455D89
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhKROME (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbhKROMD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:12:03 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4006BC061570;
        Thu, 18 Nov 2021 06:09:03 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id m14so6115797pfc.9;
        Thu, 18 Nov 2021 06:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vbg/UnTog8RoKm/UkVGv08OHT0zawheRaXb/CoLLpao=;
        b=kpkiTq1voUXK2udIAm7nn8bKXcX8D9jsQpymoepWezzkgBKh4dCfxwmufnVK1hUXWD
         lMfY3DghFpDBEA3VHmQu+8e82/61zvDIZ/1sfhL7kpf8EG7uvn8bNc7j0jcviv6ISogU
         SOfEHOdIzgoJDzZArwAh7xtnctsnbOJ8B+GsNFOTYFhFbusdHxOcIPeJVScl4m9IzzyV
         Z+N3mBQdIKWG9GbQUa2OoW1RcuxHpf6o9R2YB6GCh+woBV0hktLQhO8TOo6nxngSaXhB
         byXxJsuqs5p8LC0gsKpgGMpUFM0tld81Jf/zbpl0IZZSa0dELmLnOgCUOgvGKU0powac
         0JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vbg/UnTog8RoKm/UkVGv08OHT0zawheRaXb/CoLLpao=;
        b=w5PnFd0Bqcqprz7s9ohgOV0vHBFu3i2A4kZoOLABY1IPg8po/OtYk8mgG89laEK9Oi
         sPPMuuTqh0YxqBDvalLrm4HMlb/thi68Pyqo5kD/F+Zvym3LPf0gKhwIrFlMVLDNSuBu
         VCMHnOK7/7G7Gw62yM41qQCWKCayTHWQYDtwSoxU9ao9di8pkIC6nEWnbJ+UN0M9PAds
         Kw6dYOaaIRPQW7l0iouzw2aIhgwmS76elKBK0pZ9wB0vsknbCAF0jfPOgQnmhepJGX9w
         e6WV71wMZPGYRBiW5q2cVkcQIYiHrhW27AqrHPc+SmnFATkDVtNX40h1Xc17iQlDYSID
         2Prg==
X-Gm-Message-State: AOAM530l64tWEvrasWOmmsIdeIaLOmhUVQBIJsH/cVUWnyoxa05U+UrM
        mt0D1bebVpSdaJ1/ZNgxnAc=
X-Google-Smtp-Source: ABdhPJwmm78uc+5YsW3BcjjnnfSmqDBvQIgonYyGNaRf+SElCcvORFbsZG99JbsJxmiT3Pf3TOKpmA==
X-Received: by 2002:a05:6a00:1ac9:b0:49f:b38d:fe7 with SMTP id f9-20020a056a001ac900b0049fb38d0fe7mr56900554pfv.63.1637244542719;
        Thu, 18 Nov 2021 06:09:02 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:09:02 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v4 18/25] PCI: pciehp: Use PCI_POSSIBLE_ERROR() to check read from hardware
Date:   Thu, 18 Nov 2021 19:33:28 +0530
Message-Id: <e185b052fbfd530df703a36dd31126cb870eed95.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use PCI_POSSIBLE_ERROR() to check the response we get when we read
data from hardware.

This helps unify PCI error response checking and make error checks
consistent and easier to find.

Compile tested only.

Acked-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 83a0fa119cae..e94914e50fca 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -89,7 +89,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 
 	do {
 		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-		if (slot_status == (u16) ~0) {
+		if (PCI_POSSIBLE_ERROR(slot_status)) {
 			ctrl_info(ctrl, "%s: no response from device\n",
 				  __func__);
 			return 0;
@@ -165,7 +165,7 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	pcie_wait_cmd(ctrl);
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
-	if (slot_ctrl == (u16) ~0) {
+	if (PCI_POSSIBLE_ERROR(slot_ctrl)) {
 		ctrl_info(ctrl, "%s: no response from device\n", __func__);
 		goto out;
 	}
@@ -236,7 +236,7 @@ int pciehp_check_link_active(struct controller *ctrl)
 	int ret;
 
 	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)~0)
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
 		return -ENODEV;
 
 	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
@@ -443,7 +443,7 @@ int pciehp_card_present(struct controller *ctrl)
 	int ret;
 
 	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	if (ret == PCIBIOS_DEVICE_NOT_FOUND || slot_status == (u16)~0)
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(slot_status))
 		return -ENODEV;
 
 	return !!(slot_status & PCI_EXP_SLTSTA_PDS);
@@ -621,7 +621,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 
 read_status:
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
-	if (status == (u16) ~0) {
+	if (PCI_POSSIBLE_ERROR(status)) {
 		ctrl_info(ctrl, "%s: no response from device\n", __func__);
 		if (parent)
 			pm_runtime_put(parent);
-- 
2.25.1

