Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521B82F9BA8
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 10:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbhARJAm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 04:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388143AbhARJAb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jan 2021 04:00:31 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5A0C061574
        for <linux-pci@vger.kernel.org>; Mon, 18 Jan 2021 00:59:50 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id cq1so9061798pjb.4
        for <linux-pci@vger.kernel.org>; Mon, 18 Jan 2021 00:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9B2PVOVnOELjLgkcHAdN8FpGUrzQFsXja3st3wEc+Q8=;
        b=dNqsNvn7Th69ICKOZ4PqclJ4BxS4IlEVc2ELk/8RYSoO0eXr2Z4k87c+XMOTxIXIDo
         L8BO3vi/zfNo3nbl4XTlk/7cmYIQMcQfjjZwMzUQiy38qh5tAXV9JnNMFLYmBLrNK63B
         Z1iCWqlmVoNll+jybMK3KAjQdfbFu1fICjeJFVlEDHMxbfGjsCaYPFvqXBeQ7rcKzFvr
         Oo+Ngl3y+L+9kyYaJ+MOBs8jzJZ58bC/Lz7iX08rJ1ueLK5SllIA/EQ0BbVyUJIYAur8
         lR93RY9ryBTVLcVqgKVJVBioHSYW61NyUBOkdhcN8MFqgACXjebZrp7C8JhP2GP2MZoX
         f+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9B2PVOVnOELjLgkcHAdN8FpGUrzQFsXja3st3wEc+Q8=;
        b=YxzFEdZCRVXVk12bbiggZXDn5i4rSqChu5LJw0mzWcDe7/re8xsCQzW1scpc/GdZKy
         ISJmDMFnUDAz3v1GXhuZ/eF8TlZYjaM79qSQ54yALU7nSzcCXD0sROeUHaAAV4KBOUjK
         iScc2c8PAmCAvKdZc24JdgtUxK/8za2+hqe0KlAw9a3aqphwlPffXO6a9HrAkMGZYOJg
         MYj0ne69wXyE7iFq7EoXe3HbC4670p9qQBmiU5LPM0fRKGZ/MMGMCZjYKMtRebL1o5Jb
         Hb4p+x2DDQgRKFtQuYIIJpaIo02ScBVFt8A1aESjl/meDMbAQ3NWy5sJexzo1QIhrQ78
         6Kpg==
X-Gm-Message-State: AOAM5318szt5BThJETcBoXm+NVVpVBF+o/Yyrz7iQgzXSx3nOyI5g788
        vMVtMIdgi6JwBfXZ6zFhhMvUKQ==
X-Google-Smtp-Source: ABdhPJxy/I2MeZ2RrVcPkVPENDSR9vOWbGu/M681vhJdvErhPE69foe0FxawlOCapAD4MoARFc4eCQ==
X-Received: by 2002:a17:90a:4dcd:: with SMTP id r13mr25430175pjl.74.1610960390625;
        Mon, 18 Jan 2021 00:59:50 -0800 (PST)
Received: from localhost.localdomain ([240e:362:42c:4800:8459:4fa0:20cc:1141])
        by smtp.gmail.com with ESMTPSA id c23sm16087162pgc.72.2021.01.18.00.59.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 00:59:50 -0800 (PST)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, wangzhou1@hisilicon.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2 2/3] PCI: Add a quirk to set pasid_no_tlp for HiSilicon chip
Date:   Mon, 18 Jan 2021 16:58:35 +0800
Message-Id: <1610960316-28935-3-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610960316-28935-1-git-send-email-zhangfei.gao@linaro.org>
References: <1610960316-28935-1-git-send-email-zhangfei.gao@linaro.org>
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
2.7.4

