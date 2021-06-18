Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C1A3AC405
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 08:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhFRGk7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 02:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhFRGk7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jun 2021 02:40:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9D2C061574;
        Thu, 17 Jun 2021 23:38:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k22-20020a17090aef16b0290163512accedso6695616pjz.0;
        Thu, 17 Jun 2021 23:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACxHVcK0Ryo9RIAxVD4v0if52uvGSzNC+4znNKdgqQc=;
        b=fVceLY8i+XTr2ehlpRUASqQbKHbdPcrWn2ltMuUoOxlaSstLq9oDHQwzM71ozgv//c
         54vXD9aEJP1qBvnYYab72d8XW15fggwjsMGIjPxzVuZsIPGHzUrfa4yO/o3+nDVzu5gr
         L8gWIQY/3IYpHQ7RLc7enQS0JjxvuC58DHgXQ3MoO1/0v/Ovy6uun/epGt8XzOu7UTqv
         L0540M6uTSJ0z28ColEmdULeHo7VykwubNCUY5wLZ5k8XiVQNsw91bX7a2Aw4b1WRUAF
         u1kMBOA6MVNjKfh4w7olDuiGjWLPioZ0f/jsjSsIcaL6D57YXpIdgJYmWNRrE26CIVok
         yD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACxHVcK0Ryo9RIAxVD4v0if52uvGSzNC+4znNKdgqQc=;
        b=AzwKrRMrUq/6k/ouMVSxTRWNe54491fZSEK300BVtBU1G75vehbdpIgog5siy5FXMy
         XPJxiS39EJ3rSq2XI57mitb9DKwKlg+gRr3EVlQQdCb2Bvy7CKp2DQIr60L/iIeZ8fNw
         lH/tyc9gN3gdHL361Bic2rLB51QkPkEhpLS+5Ye2BYal+MhLBuRVdSA1mq69ZT4GY58r
         4I/ddITpumKTgWlCINfhoJyIoLC/sGevC0QiIIICcElaRbrvydwtjmf/0RshLxgNZokU
         SoEsjIKKZYP3WbuGQd9esI/ruRsqhTyJLx+za7ouH/PwAF6xJ4y2KKL3+yzSJDH9X/0Q
         s3XQ==
X-Gm-Message-State: AOAM532Q1CA+N8qVJMl82DlmuwMlN3bmYoq9MMX6JG8noDXW2cpWWfZW
        TOAbWCcPyp+UPIBkuiZ5Zs8=
X-Google-Smtp-Source: ABdhPJypBALpu5GeFhgh8yLD19XLlfA/C7wvL5ldLBSZeGcMfkSKMcYTZD8PYh04Z5DtlYJo/JjxnA==
X-Received: by 2002:a17:90b:3001:: with SMTP id hg1mr20365432pjb.169.1623998329465;
        Thu, 17 Jun 2021 23:38:49 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id s1sm7612604pgg.49.2021.06.17.23.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 23:38:49 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     yue.wang@Amlogic.com, khilman@baylibre.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        jbrunet@baylibre.com, christianshewitt@gmail.com,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH] PCI: dwc: meson add quirk
Date:   Fri, 18 Jun 2021 14:38:21 +0800
Message-Id: <20210618063821.1383357-1-art@khadas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Device set same 256 bytes maximum read request size equal MAX_READ_REQ_SIZE
was find some issue with HDMI scrambled picture and nvme devices
at intensive writing...

[    4.798971] nvme 0000:01:00.0: fix MRRS from 512 to 256

This quirk setup same MRRS if we try solve this problem with
pci=pcie_bus_perf kernel command line param

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 686ded034f22..e2d40e5c2661 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -466,6 +466,33 @@ static int meson_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void meson_pcie_quirk(struct pci_dev *dev)
+{
+	int mrrs;
+
+	/* no need quirk */
+	if (pcie_bus_config != PCIE_BUS_DEFAULT)
+		return;
+
+	/* no need for root bus */
+	if (pci_is_root_bus(dev->bus))
+		return;
+
+	mrrs = pcie_get_readrq(dev);
+
+	/*
+	 * set same 256 bytes maximum read request size equal MAX_READ_REQ_SIZE
+	 * was find some issue with HDMI scrambled picture and nvme devices
+	 * at intensive writing...
+	 */
+
+	if (mrrs != MAX_READ_REQ_SIZE) {
+		dev_info(&dev->dev, "fix MRRS from %d to %d\n", mrrs, MAX_READ_REQ_SIZE);
+		pcie_set_readrq(dev, MAX_READ_REQ_SIZE);
+	}
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, meson_pcie_quirk);
+
 static const struct of_device_id meson_pcie_of_match[] = {
 	{
 		.compatible = "amlogic,axg-pcie",
-- 
2.25.1

