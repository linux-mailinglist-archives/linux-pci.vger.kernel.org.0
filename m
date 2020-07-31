Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC8923451A
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 14:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733034AbgGaMC1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jul 2020 08:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733029AbgGaMCZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jul 2020 08:02:25 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CA1C061575;
        Fri, 31 Jul 2020 05:02:25 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id g19so17353807ejc.9;
        Fri, 31 Jul 2020 05:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+B0ZiRGGkQHGfacBVvFgt+7CbN36ujRN2OQHpeuEl8Q=;
        b=q1ELpRRFFJl8UZ7DlKSBerPXQVxyKAd4T3Rh0sn2R47QsC0y9Bjo6tJovpznNhS8yR
         1ky2nz6HbkWcz/wRA3cUSi86NBcbDAf4+sQAuPbHZ8KjHOPop1D8Cs+efmggmlP6kaTE
         cejWvPxN+7BdWCABfsSrVCZ4a5ZrEbPMMx43Rj6x8ChHzQReQfKVL+7BtF+0ppl8pHIg
         OL7ouoqnTXagdt4YbGlYplW9EAo5EKk4QJ1SbxuVOJbBf7HvSjYGpb3GROvrXv/pNevl
         XjTzuyStpqPFCaHph9dgTIXXlp1veqq0qMTJH3ugoZ/2xMD+1DQd5SwmH+/K6LZVIxpl
         iQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+B0ZiRGGkQHGfacBVvFgt+7CbN36ujRN2OQHpeuEl8Q=;
        b=fzWphx4Ujf37TII2q03MipMpictfkM3Yqkwu+mu6iJqcvNtjI1hRAN1DFt0nhonxCD
         ueXbWJ6Zu7fpFbW6j/GR2+pIBz78VZoOLuf2qhSx4z9BClPWf5+gaJxJJ7GRNoFep8P1
         W73nk9cEW10plqGsMffmWf7Njnh2yR4rGWKdtHIOQvYeg6cQTUXh/gPI4YCSoYAxkal9
         NxZlmpWE026lRKd/tMXuXG+2NIJMmHzK2uUMCnYdkSN5/FoGoq+Btp6sQJF5lsUA1J3f
         YxYZgGyLpIkV5Lfn0JdzbG80dgeD1WroAZRdinQKX4Kv2efl6cwXQQvZNZ6ImGk5qRNc
         NY4g==
X-Gm-Message-State: AOAM533IHQS426NleByawD7pFIc54XMruY2bLlX7YgoJTuhm0OSr3oeJ
        m5/iLipUg1ynm29iNl4VZjA=
X-Google-Smtp-Source: ABdhPJxgR17bqYSQeGy025fhxigm0MVrq5A7QiKas69UQZRDtn4IPk1fEsdjUzNRp0lVrz4itO5j9Q==
X-Received: by 2002:a17:906:3756:: with SMTP id e22mr3810103ejc.487.1596196944109;
        Fri, 31 Jul 2020 05:02:24 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id j5sm9091734ejk.87.2020.07.31.05.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:02:23 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/12] PCI: pciehp: Set "Power On" as the default get_power_status
Date:   Fri, 31 Jul 2020 13:02:33 +0200
Message-Id: <20200731110240.98326-6-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200731110240.98326-1-refactormyself@gmail.com>
References: <20200731110240.98326-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The default case of the switch statement is redundant since
PCI_EXP_SLTCTL_PCC is only a single bit.

Set the default case in the switch-statement to set status
to "Power On"

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 53433b37e181..b89c9ee4a3b5 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -400,14 +400,12 @@ void pciehp_get_power_status(struct controller *ctrl, u8 *status)
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
 
 	switch (slot_ctrl & PCI_EXP_SLTCTL_PCC) {
-	case PCI_EXP_SLTCTL_PWR_ON:
-		*status = 1;	/* On */
-		break;
 	case PCI_EXP_SLTCTL_PWR_OFF:
 		*status = 0;	/* Off */
 		break;
+	case PCI_EXP_SLTCTL_PWR_ON:
 	default:
-		*status = 0xFF;
+		*status = 1;	/* On */
 		break;
 	}
 }
-- 
2.18.4

