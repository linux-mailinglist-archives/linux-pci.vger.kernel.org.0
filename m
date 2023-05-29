Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991FF714406
	for <lists+linux-pci@lfdr.de>; Mon, 29 May 2023 08:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjE2GQY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 May 2023 02:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjE2GQX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 May 2023 02:16:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8689E1;
        Sun, 28 May 2023 23:15:53 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b02d0942caso8268945ad.1;
        Sun, 28 May 2023 23:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685340952; x=1687932952;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcQN8VgoDYPYnc3V4elXqbCt7D4H65Z/7XNtLl1+E5g=;
        b=pW5b94mZADa2C+g+WEXSfS2ewafvu3n4QW2Iq+3NdaSLsQ1FHZjHDLyMAxuTB3lvdj
         oXs6hnTYF2YOyCn2wMTrZIbMSVBD+WooJeik5bIFhA96vrrIBuVxfppRBoTKarwEsRSA
         oATEm20DWqFwD3oD4CLrGPFd4C9+mZ3+4TsF74un/s2M7leM8lCZ44UOIj5Q8C96botd
         SPB3TVN1E6XMljWMzS0WYxETPBKr2Ovc1tgiG9QTl1aeNywv6Y4CCxc4wrSzHycByEpj
         a+XKIEcYONdy+XshmkNkbbDv8zn7mnwmaokx3aFCktUJmh/afDSY/LScu1MUb/9WYUlu
         qcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685340952; x=1687932952;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcQN8VgoDYPYnc3V4elXqbCt7D4H65Z/7XNtLl1+E5g=;
        b=NkGql1Lgy3iA7C78mrR6NIGAL33c3rYG64CRyg18/vEW6u7vzkk3Wo0MrMdiLzuKfA
         L+p87N1+g8GRIAu6MfXoGOJAqs1RBR3gt+pyk0vbSgWZFbtpq2ge6M89G+tWHlx5CnRM
         owwmpvBd2b3SFCIRFCawOlkKUbcu9YjavnFzv0J3nBUkeD7gEZ1bMFnSoGfr8NSwLsDD
         mVIw3wd0sKoqlAtHKc80riD248N3V98AEJFPY7nKRr2Gwi6cPbH5hr4rNkMfR63xCTWf
         vGcwuBXjhE2Vr8SKyp+HY+Qb0a191ufrN6Z2dRpTFKCjUg1VEUzZQexdJhOqPAwf3UjX
         qSrA==
X-Gm-Message-State: AC+VfDzt81wrM79nzQ8EjJREZNdZhHKsA995AAGTkkPET787iy3QQf+O
        hkRZGIfGB/JJ7DDOxMNtkJ81p4b8cqw=
X-Google-Smtp-Source: ACHHUZ7asIUDUnelNdN6ELbB/y06Mv3zvsXl7aRIuHsGdgHEFGyNRVPWCl2peKuHKUUV0c9z6JEhqw==
X-Received: by 2002:a17:902:d2d0:b0:1ac:61ad:d6bd with SMTP id n16-20020a170902d2d000b001ac61add6bdmr13289840plc.65.1685340952171;
        Sun, 28 May 2023 23:15:52 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e28a-e298-44b2-039a-c888-7c56.emome-ip6.hinet.net. [2001:b400:e28a:e298:44b2:39a:c888:7c56])
        by smtp.gmail.com with ESMTPSA id p23-20020a170902a41700b001aaecc0b6ffsm7270393plq.160.2023.05.28.23.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 23:15:51 -0700 (PDT)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@google.com>, Harvey <hunge@google.com>,
        Bob Moragues <moragues@google.com>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Stephen Boyd <swboyd@chromium.org>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v1] PCI: Add suspend fixup for SSD on sc7280
Date:   Mon, 29 May 2023 14:15:41 +0800
Message-Id: <20230529141527.v1.1.Id388e4e2aa48fc56f9cd2d413aabd461ff81d615@changeid>
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

Implement this workaround to correct NVMe suspend process.

Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

 drivers/pci/quirks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f4e2a88729fd..3e7da7174f0c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5945,6 +5945,20 @@ static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
 
+/* In Qualcomm 7c gen 3 sc7280 platform. Some of the SSD will enter
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

