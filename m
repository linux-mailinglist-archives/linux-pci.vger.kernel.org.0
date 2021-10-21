Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965F54365A3
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhJUPRS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhJUPQ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:16:59 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FB4C06118D;
        Thu, 21 Oct 2021 08:14:01 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h193so625631pgc.1;
        Thu, 21 Oct 2021 08:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fFyvKUbtJ36eD8qq3Sw3snLE98+exp6mRddv9aYASwg=;
        b=dCeQRVRtkxDnODjIXOWMmzpf2kAgNYRcm8f4Dc9UrzMunsuTMYL+1ESnryQwcLfpl4
         PpeERPP4oiIOc9hBrRTALHGIuwGNtoqXGE3qN5HFi9tqXWrFpaNhZ6Aoc9/9EbXrndp9
         6jgrAP3Up6IGBaU3gd3v6Zj8iOqsKfEUmUTH4Ss2KWjgrhq/weN5gqHUS6Nvlw0CSbeW
         5AjvBvc74EIi9fEiWLoPhAU5ZTvY4k9NeP96vQkXMFMTwLemgXDEEKlunk+emaWC2PKr
         Pcn7ZBFpMA6WmBfkPOeyO3WO5bWPPjKFTdwZ4Fss8VCpX5gp3KalFP4ZE2CEWQxOSltz
         tbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fFyvKUbtJ36eD8qq3Sw3snLE98+exp6mRddv9aYASwg=;
        b=SuJ4dPLZ1T0/3a724riZW38GnmD9CmbgwvCDLsC3VVVI4+WSh3qlTxzR/dKi2QPTjS
         XwTGAluRhVTDa18NAjzKorobwvzizLtWITyqoVlM6z/PgGpu4ONDSbV4GN2p82GLJmKy
         12BrJHp1TI17OkigfnIfathR4PRNtyk5konDkJx0H4ZweGZshWkWqpMukeaOnKT5tdpg
         jeP1DWd3ti8paFDFiN3VG7ANX7unbimxa1jfiVA1IaVLKDmoWC7F/3mZwgZCWGYSC/DB
         Z6aIoz4Cimm/InBOeRhEYXCIvOJcQLfvjgGqTIopRFQbzwrzXP3VeDm8q4Sj0p5Hb4zh
         W4Xg==
X-Gm-Message-State: AOAM532L0Y7owxMN+Z4R2ADr+ZmH2qhQhFIwYJ6occrSVJs47YyKbWYS
        uyPJvyulfvtGMeAu1xMmxek=
X-Google-Smtp-Source: ABdhPJzcdJDJSfmIXMqwEJoJ1dxoI1RQuM8PXDOH4ilX1IstwIRrPtadTf+JaP1DB3ma+YpF9KwFCA==
X-Received: by 2002:a05:6a00:24c8:b0:44c:654b:403b with SMTP id d8-20020a056a0024c800b0044c654b403bmr6052186pfv.55.1634829241058;
        Thu, 21 Oct 2021 08:14:01 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:14:00 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v3 18/25] PCI: pciehp: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
Date:   Thu, 21 Oct 2021 20:37:43 +0530
Message-Id: <c21290fe02a7a342a8b93c692586b6a2b6cde9e0.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use RESPONSE_IS_PCI_ERROR() to check the response we get when we read
data from hardware.

This helps unify PCI error response checking and make error checks
consistent and easier to find.

Compile tested only.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 3024d7e85e6a..f472f83f6cce 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -89,7 +89,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 
 	do {
 		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-		if (slot_status == (u16) ~0) {
+		if (RESPONSE_IS_PCI_ERROR(slot_status)) {
 			ctrl_info(ctrl, "%s: no response from device\n",
 				  __func__);
 			return 0;
@@ -165,7 +165,7 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	pcie_wait_cmd(ctrl);
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
-	if (slot_ctrl == (u16) ~0) {
+	if (RESPONSE_IS_PCI_ERROR(slot_ctrl)) {
 		ctrl_info(ctrl, "%s: no response from device\n", __func__);
 		goto out;
 	}
@@ -236,7 +236,7 @@ int pciehp_check_link_active(struct controller *ctrl)
 	int ret;
 
 	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)~0)
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || RESPONSE_IS_PCI_ERROR(lnk_status))
 		return -ENODEV;
 
 	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
@@ -443,7 +443,7 @@ int pciehp_card_present(struct controller *ctrl)
 	int ret;
 
 	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	if (ret == PCIBIOS_DEVICE_NOT_FOUND || slot_status == (u16)~0)
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || RESPONSE_IS_PCI_ERROR(slot_status))
 		return -ENODEV;
 
 	return !!(slot_status & PCI_EXP_SLTSTA_PDS);
@@ -621,7 +621,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 
 read_status:
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
-	if (status == (u16) ~0) {
+	if (RESPONSE_IS_PCI_ERROR(status)) {
 		ctrl_info(ctrl, "%s: no response from device\n", __func__);
 		if (parent)
 			pm_runtime_put(parent);
-- 
2.25.1

