Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579857153A0
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 04:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjE3C0k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 May 2023 22:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjE3C0k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 May 2023 22:26:40 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7BBB5;
        Mon, 29 May 2023 19:26:38 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d18d772bdso4538497b3a.3;
        Mon, 29 May 2023 19:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685413597; x=1688005597;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAAahBaMn+nQkxlo2jyGjD7UywZ1uY+eUgPrhQR+m0c=;
        b=jLXsDzr3l8+/CXE6bRVEgoMOnk35mGNy4jowWLXFuqtKPItF1q1tsJIJdn1r3Bl+xD
         3M+PGf3Wlq7JbZJZjnLgnfQSbRYch/7Oena1ItU7M1RKC+/QIYt69/l1wRFuzQDsmCEO
         DsTB+Y+QTn3LD6DV5eByYJ45QGTold6OMbiqz66ZVqY2hjZOZGeZERosawXhmOGH7j1M
         p8vjuuJpuuftyeG+rKjk+DLa5LZPHSlgmkZqE0lhCzogaeb/glSU23C1iWaLe8NhItoz
         qATBN58t+EYS3rG2YN6BtW0sKo/ADNSxkaSdzoO7grtdJNwR3nPVDz7TwcX+nFunPxkf
         r+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685413597; x=1688005597;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAAahBaMn+nQkxlo2jyGjD7UywZ1uY+eUgPrhQR+m0c=;
        b=GEc34DwZI8o5ViAm3KdxUlUniPv/CucJGEqlYxWGmmh5tKSPybdJ32OtXFgfumDDQn
         Fzw0iMppzI+ZOZFQCPRm500EA8niwn63vY9ww9rXrCeb4XqYaKbtNEvJIkFXhfNhnmnt
         Fk3efNNk1VwKyhi3rhTUJwJraOBg8u0sEourLzXkdjRLd2F7meXfgtUt3S3AN5Y9lwhw
         33VTHAN/waKpn5Orr3XCh0FoOMaIgV+sg363igxbXmn9mulhT4oLcuEXrCnZR702Vh7K
         Ci9Wsu1azhm+STgvWRC+pCR3yppCd2X7vawcOm3Kn+MeY+IkUJYilvxTwahdUdiKKtT9
         SvYA==
X-Gm-Message-State: AC+VfDzbfRjYVWqZlRMVZnjnIp8j1aA69LSn6YMeFJTVaEKmIPQd/a6C
        ZI33ZCN/r8iGqBy8fJPl701xmEt3uL4=
X-Google-Smtp-Source: ACHHUZ4k0v6JphsjLxf3HuTRFgopAAnAH+m3MMK3ecU4WdsZNd2BC3JwZOOssU+F1QNx/7CcxklG/A==
X-Received: by 2002:a05:6a20:2447:b0:10f:708b:bb28 with SMTP id t7-20020a056a20244700b0010f708bbb28mr1101202pzc.7.1685413597536;
        Mon, 29 May 2023 19:26:37 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e28a-e298-b178-677a-4430-e257.emome-ip6.hinet.net. [2001:b400:e28a:e298:b178:677a:4430:e257])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a005300b0025374fedab4sm10263350pjb.22.2023.05.29.19.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 19:26:37 -0700 (PDT)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Matthias Kaehlcke <mka@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, Harvey <hunge@google.com>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Bob Moragues <moragues@google.com>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v3] PCI: Add suspend fixup for SSD on sc7280
Date:   Tue, 30 May 2023 10:26:29 +0800
Message-Id: <20230530102613.v3.1.Id388e4e2aa48fc56f9cd2d413aabd461ff81d615@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Implement this workaround to correct NVMe suspend process.

SSD will randomly crashed at 100~250+ suspend/resume cycle. Phison and
Qualcomm found that its due to NVMe entering D3cold instead of L1ss.
https://partnerissuetracker.corp.google.com/issues/275663637

According to Qualcomm. This issue has been found last year and they have
attempt to submit some patches to fix the pci suspend behavior.
(ref:https://patchwork.kernel.org/project/linux-arm-msm/list/?
series=665060&state=%2A&archive=both).
But somehow these patches were rejected because of its complexity. And
we've got advise from Google that it will be more efficient that we
implement a quirks to fix this issue.

The DECLARE_PCI_FIXUP_SUSPEND function has already specify the PCI device
ID. And this SSD will only be used at our Chromebook device only.

Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

Changes in v3:
- Adjust comment about issue behavior, ASPM, and the sc7280 connection.
- Fix multi-line code comment.

Changes in v2:
- Fix subject line style from "drivers: pci: quirks:" to "PCI:"
- Adjust comment.

 drivers/pci/quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f4e2a88729fd..6d895a4da4b5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5945,6 +5945,21 @@ static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
 
+/* 
+ * In Qualcomm 7c gen 3 sc7280 platform. Some of the SSD will enter
+ * D3cold instead of L1ss.It cause the device will randomly crash after
+ * suspend within 100~250+ cycles of suspend/resume test.
+ *
+ * After adding this fixup.We've verified that 10 devices passed
+ * the suspend/resume 2500 cycles test.
+ */
+static void phison_suspend_fixup(struct pci_dev *pdev)
+{
+	msleep(30);
+}
+DECLARE_PCI_FIXUP_SUSPEND(0x1987, 0x5013, phison_suspend_fixup);
+DECLARE_PCI_FIXUP_SUSPEND(0x1987, 0x5015, phison_suspend_fixup);
+
 static void rom_bar_overlap_defect(struct pci_dev *dev)
 {
 	pci_info(dev, "working around ROM BAR overlap defect\n");
-- 
2.17.1

