Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CA47107AC
	for <lists+linux-pci@lfdr.de>; Thu, 25 May 2023 10:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbjEYIga (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 May 2023 04:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240167AbjEYIgL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 04:36:11 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BFC171F;
        Thu, 25 May 2023 01:35:40 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d604cc0aaso1512572b3a.2;
        Thu, 25 May 2023 01:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685003722; x=1687595722;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwxYuZAaDrbWvA6fNvvfa3UTwfQ09LwU2WlVlYLVfbE=;
        b=OI4KQNs0Vu1mrj91oIqkWUzpeXRr0QJ9eEwkadPD2CL2y6GsKvDqvnbWBpG3CNT4Dn
         r9iDQyKXs1IBFmRDsad/RRGqhQrI2g93M1m0fy/jEMKkJkxb2wHpzUHPaU2q+5RwsDni
         F3arDPu3mhEBTz5Tfs6YjoPtW9TkCVF/CG0xnJh4P/5WEO0t1W4hlU0MNQLYbTjLhSgP
         j9gOCSCRTaoXmOib23ugSq1IaY+NVgf8uZUPrSAcpNjz0dNouMuDyff1+Ty41IblF2sW
         JwcqJvBsYOE3I9zHc2mmIl/MGAwFO/D4RdtL3rNrSLF+dqAqyvamQt4BEEhTJ21wLqfs
         /J1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685003722; x=1687595722;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwxYuZAaDrbWvA6fNvvfa3UTwfQ09LwU2WlVlYLVfbE=;
        b=M0b4W+6HnhSf0etHKyD5B5xFZGgH3dduzkhmHY7akUw7utbnTkHtCgeeLfNxXAKJOn
         gJtjs8nJWCBEXIwn3TM7JS5uOu0IHI2x/Q/e68C32B5tBI7mBk/O7vPFUy9bpq7MAI8c
         T8EojQ7gXf/mXq3xvWwMyJcajpvj7UuUMbhfFfNCwyQg8AquS4vcfmSNnrF7sQWPnpRi
         p+3ICwfDCt7nbIFNYpWfm/Bc9oZH9iyGf5XyZ/kAlJ1c4PGYNpgxjd+52hBrRf+EvTiW
         6vdLkJ72FcjKrZpeWvQmjdDxEfLFENa1gYVlBlJnHlnZwG2m34lsMu/xIP8ot2zTQVR4
         JYjw==
X-Gm-Message-State: AC+VfDx/F2nmLnGZatmLxwc/RM+0+ZT+CuBVD7AzCLm6pHNSowNE+H5M
        nDGRAYuYViz1xsFp+7oa1C5a02ewCt0=
X-Google-Smtp-Source: ACHHUZ4+5SxtRm9CgY7J+ueqXlkL6tT7R6vQIICSqjLkt0XTKenkbef6qa/gd03b1V7gqjhSk0CDxA==
X-Received: by 2002:a05:6a00:2d09:b0:64f:4019:ec5b with SMTP id fa9-20020a056a002d0900b0064f4019ec5bmr9014927pfb.7.1685003722494;
        Thu, 25 May 2023 01:35:22 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e2ae-cfb3-c8e7-b613-8fc3-c8f3.emome-ip6.hinet.net. [2001:b400:e2ae:cfb3:c8e7:b613:8fc3:c8f3])
        by smtp.gmail.com with ESMTPSA id x7-20020a056a00270700b0062bc045bf4fsm747951pfv.19.2023.05.25.01.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 01:35:21 -0700 (PDT)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bob Moragues <moragues@google.com>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@google.com>,
        Stephen Boyd <swboyd@chromium.org>, Harvey <hunge@google.com>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v1] drivers: pci: quirks: Add suspend fixup for SSD on sc7280
Date:   Thu, 25 May 2023 16:35:12 +0800
Message-Id: <20230525163448.v1.1.Id388e4e2aa48fc56f9cd2d413aabd461ff81d615@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Implement this workaround until Qualcomm fixed the
 correct NVMe suspend process.

Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

 drivers/pci/quirks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f4e2a88729fd..b57876dc2624 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5945,6 +5945,16 @@ static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
 
+/* In Qualcomm 7c gen 3 sc7280 platform. Some of the SSD won't enter
+ * the correct ASPM state properly. Therefore. Implement this workaround
+ * until Qualcomm fixed the correct NVMe suspend process*/
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

