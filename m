Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026EB3C68AF
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 04:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhGMC57 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 22:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbhGMC56 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 22:57:58 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00CAC0613EE
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 19:55:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v14so3389538plg.9
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 19:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x0Ksi9PRt4mrd/JIujX8i3+8flQYtHwm36Rm4DgFGtg=;
        b=VB/TVSa+0erdImiVKnK59BcEhIuFoMyKClow/e6MIYz0p1xRdZw1/CagzQtxIet/Su
         8rIl79udcybxa9zyj7h696A4Cx5OUJHyRpsWh8MigWpSSXnFHqwyuEtQlcp75WVnJ30r
         rco2DXtRB82OxVRmpMDrQDuOV95mDzl1WLpoe6iggkZ0rQjnEbNqSG1gHXJZwalyq3r7
         IBvZipl3yjw5Is5riMgCVL/Dww/cdjmJJ5BSqEjLALpFpzn0YMCE9FNNq0uKMKmJQNQY
         t0NTiv8R4rJ927rHeBq6BbLdKMfYWQ1iznOgMG8wrC8X6HkWEFmHrpjkfOmhqVsoFLlv
         6vOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x0Ksi9PRt4mrd/JIujX8i3+8flQYtHwm36Rm4DgFGtg=;
        b=cEI6PzX+6QZ/9UFCPj6u0V+8UiF4FqctmWBq+zQkdL+8igJUikBkeFJo7FK5OEXGHH
         JPnzFt+W37YJDlvFyZROmbu0FJcFVU7/uD37XV4ME/h4L8YnBB0iIE2ZJy++yAF71DWv
         SO5o1/t/6u1NM5uwwtfmqSdU4fjrhsMVxJNfdn17n24js8Ylz8KKsKmk6XU72Li7jEne
         ZIlV8sn3M8/xSUwDt+gAC4ONDF81GigcGCsjpuwosSHMCW/RDuTWZgv6wdCF1cb/Rmn5
         7nLv/t46a4otQ70P9/9ZW4HnhfoAdwY4mT/eGiyDmS1kal36tkPHDWrl8oYdOfTG+tEy
         aOIQ==
X-Gm-Message-State: AOAM531QOq0QY3DdHFr6pqTgxrwgfFtwjaXAiPmedS3mCQxMa0/6BB6j
        Cw1O4fduM0V5XAq6h1/2LQq8nQ==
X-Google-Smtp-Source: ABdhPJwBrrWb3C7wUXb/62VCJmxTZpswwVdd0IjoLoA/8yiXi4EnQP5kPu51WG8vFoERwQhyi0OptA==
X-Received: by 2002:a17:902:bd04:b029:11f:d602:56f3 with SMTP id p4-20020a170902bd04b029011fd60256f3mr1713341pls.33.1626144909416;
        Mon, 12 Jul 2021 19:55:09 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.134])
        by smtp.gmail.com with ESMTPSA id r14sm19303344pgm.28.2021.07.12.19.55.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jul 2021 19:55:08 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v5 2/3] PCI: Add a quirk to set pasid_no_tlp for HiSilicon chips
Date:   Tue, 13 Jul 2021 10:54:35 +0800
Message-Id: <1626144876-11352-3-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626144876-11352-1-git-send-email-zhangfei.gao@linaro.org>
References: <1626144876-11352-1-git-send-email-zhangfei.gao@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
actually on the AMBA bus. These fake PCI devices have PASID capability
though not supporting TLP.

Add a quirk to set pasid_no_tlp for these devices.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/quirks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6d74386..5d46ac6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1821,6 +1821,20 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quir
 
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI, 8, quirk_pcie_mch);
 
+static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
+{
+	if (pdev->revision != 0x21 && pdev->revision != 0x30)
+		return;
+
+	pdev->pasid_no_tlp = 1;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
+
 /*
  * It's possible for the MSI to get corrupted if SHPC and ACPI are used
  * together on certain PXH-based systems.
-- 
2.7.4

