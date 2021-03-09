Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22197331D42
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 04:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhCIDBg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 22:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhCIDBZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 22:01:25 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7144C06175F
        for <linux-pci@vger.kernel.org>; Mon,  8 Mar 2021 19:01:25 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id y67so8569662pfb.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Mar 2021 19:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F7buwKY8MjxUAqEk7jUYBTTks8KQaYnNtOOELg5e79I=;
        b=q5nLn8kKw/gYdrH1lCiRkep1A+QCVlGPHwuYveE6xtpdF+OK1w0n5WGIZm7GGPaUFB
         gzpzVyDcgx+DxA2Ucfy2lL3A33V899Dev1GXxSvL7P2KncjjNJpSPvwVh9mApR5/3C86
         4fMVysdO/22+Iro+fZDM3YmFB/H0wPZhTWTjgaOjM0oXO1FQS7kcbBL+K4VaeSDuOtyb
         /UwUzHf+/0OjLKFiV6NT+FNTbHQ9nCdVBudXUJgnvzWnShypbms4UQWggidrXmLoHgEl
         6yrB6keC1LknwaHb4CvUlo7Eh2iaIlbADIgHk/9GgBiDDwQv1B2iciMQXadcfVHHU2fN
         rBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F7buwKY8MjxUAqEk7jUYBTTks8KQaYnNtOOELg5e79I=;
        b=UBnAVLEHVARJNvOzG1JpwL3IE9Eeh813Rv6ukhmYjCOnMT2SaA0rbHpAwKBgRgOBA4
         CMEfaOMx6Yf0hqNZAbJkVforwlr7TEYfAjM8vqACglR8xDaXEP4kyOiAbvBYyJuWJLUc
         Gvzibd1K5h+hRnsgSWpU//SBcuUs/BEoOJgay9fTW1e33K3si4D9scRCVUVyo03tiyoQ
         NFK2silJu0/M/QAuGmL1LAZOsU68Q+QP4TFXcVX9BbAIJduqH7IzLikh2f1qiFtiOdq7
         EnpAH5kqRlhrwrceXhYiD57ulejew12Dy09iavzEop/6nWthbqkIE8QYaGikKxKzay+j
         4lOQ==
X-Gm-Message-State: AOAM532qVO9bX9JYK2AU5Aoifuw3tn9BbtbZfAI34tFyMt+ChMtoGUG4
        S2kybxqIS+bPJfYWn+ZxfsKKQw==
X-Google-Smtp-Source: ABdhPJzjhdKhRy0M+FqwKVzYU2PmHGpbirTvEbdRzsc1JI7zCJe+fZttcis/LpLWAoLpZ04Hyus3dw==
X-Received: by 2002:aa7:9202:0:b029:1f2:9439:f4b4 with SMTP id 2-20020aa792020000b02901f29439f4b4mr12567264pfo.12.1615258885416;
        Mon, 08 Mar 2021 19:01:25 -0800 (PST)
Received: from localhost.localdomain ([240e:362:435:6a00:e593:6e0:bfb4:a65f])
        by smtp.gmail.com with ESMTPSA id y24sm3162782pfn.213.2021.03.08.19.01.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 19:01:25 -0800 (PST)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        kw@linux.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v3 2/3] PCI: Add a quirk to set pasid_no_tlp for HiSilicon chips
Date:   Tue,  9 Mar 2021 11:00:36 +0800
Message-Id: <1615258837-12189-3-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615258837-12189-1-git-send-email-zhangfei.gao@linaro.org>
References: <1615258837-12189-1-git-send-email-zhangfei.gao@linaro.org>
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
index 653660e..873d27f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1825,6 +1825,20 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quir
 
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
2.9.5

