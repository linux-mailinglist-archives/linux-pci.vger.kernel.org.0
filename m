Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128223A0AB4
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 05:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbhFIDjS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 23:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhFIDjR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 23:39:17 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AE6C061574
        for <linux-pci@vger.kernel.org>; Tue,  8 Jun 2021 20:37:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k7so548281pjf.5
        for <linux-pci@vger.kernel.org>; Tue, 08 Jun 2021 20:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BgTgfv/nbAL6AaANvS5S9avysGK7LQx6xjZbQt/4m4U=;
        b=eP6KFjinoup+SnZrZQPiI5JxLEpYOFmbZHru2ThiWgVWQwWHjLlk/hnIcLGe6TIeZZ
         d8v+tHTXq1b2IV5ugjljh/Z4OztWDDnXwgrEBYfaf4A+rPuV7tPJ5McchX2Ft9+n4WBi
         QvTc9sHOX681fEnMHo1gueI6zK77i2hkVz/A9QuFWNZjjxk0UP5OY5ZUwDlnrRVLxV4S
         AuzrfBv860JsyHussb1qcZFL/+HcPWxuTHGBZ2JpxyrmehpQryV9K9KZsNHgWryUHNNc
         ZyTjNsDSGB/kMtqcMLfqrCEgmvkmK0fgQFZimzyPhNJxK+X2W39AQaax54SMCLOgS1G1
         0e5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BgTgfv/nbAL6AaANvS5S9avysGK7LQx6xjZbQt/4m4U=;
        b=Ipczw+7WeX5i0blpH9jtK/Yk+6an4zjfdolPC7NjYAXKhyUhOx4GTdcixSdCAQbEr1
         +ePsMsXXFTV5hL+e/k2F6u5sigesbsrrzgVwyyNRkZPGzw4Zc/5493JFHI5wKU1O7n1e
         pw3XV5O1NoAF5cJUNfloertuxXoEQbkcNY/OYJxsi74og67EwxZZAO0TV7QoZE3kgD+4
         ZMfa3t9KgyGTyxcCDgtBrfTEQpi2fYUWYXvqSz7MEc1JrBjeOujCDjr90yCrXQOto9hE
         e4nUjuK9AlIRaQqrn+aLa4RVCN0g897vORx+CJclEAVJ4vwfIyPWY6FPsK1/odrIq8yV
         qEBw==
X-Gm-Message-State: AOAM530eOZFa5U8PJV4CoeQKhZFqlNJEI50xPHIkO8PIh2PlQKgRss2Q
        ZhyTQPzbyPzG5DefobQxOsG5AA==
X-Google-Smtp-Source: ABdhPJz7Re/hjduCZ651NbV8lcM94Ct6gHgCDhyDNxGsi7hEVb9iiXPgrjZHKpctznB+tUR1C5KEow==
X-Received: by 2002:a17:90a:df13:: with SMTP id gp19mr29763761pjb.11.1623209830357;
        Tue, 08 Jun 2021 20:37:10 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.135])
        by smtp.gmail.com with ESMTPSA id t24sm3473904pji.56.2021.06.08.20.37.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 20:37:10 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v4 2/3] PCI: Add a quirk to set pasid_no_tlp for HiSilicon chips
Date:   Wed,  9 Jun 2021 11:36:40 +0800
Message-Id: <1623209801-1709-3-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623209801-1709-1-git-send-email-zhangfei.gao@linaro.org>
References: <1623209801-1709-1-git-send-email-zhangfei.gao@linaro.org>
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
index dcb229d..9331113 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1820,6 +1820,20 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quir
 
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

