Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B19F3894B3
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 19:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhESRhT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 13:37:19 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:43719 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhESRhT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 13:37:19 -0400
Received: by mail-lf1-f42.google.com with SMTP id i22so20175349lfl.10
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 10:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9W9UbeNPGlntCpfEQEfgw9MwtT+hIuBZFj/QB3P/FI0=;
        b=SzrZA5Yysk/jZSZJ3DLTbCrNgwQJKv+ktFE4HIQRpdYydRk12+wvnmTOjHBgp/NPbY
         h/vYsCJxXk8gS5ItD8nK9gj2BvCiXsr2e3JT5vicmzYOx+YhV4Mae9sSeCKgTW+PUL2x
         3js4fuaPeSYy3oAV4qlp7w47bDVW3H6YrAJX2yoNswRV23Rvtxm2tn87L4i6t8ISuKGy
         8B6WmQN3+kFH/Fj2/Llwvz2Y/akAhq7i7hrtpjURXKR1XIVJZfgKjEhmnSruQAJCK3d0
         uZaThGlLzyEdtRz+xfujNwFzBJKmOVFJ5DXYG0YEd8CGLl8CJ0KgrlsEfrv0M+Wh3qLn
         6Cgg==
X-Gm-Message-State: AOAM532qKLsb3E29bdg8LCPh2dtfRBkTu0nmUeJkIlfsy9yBq/dORrOz
        T03B6iR2nYXGUVv/vyBduHk=
X-Google-Smtp-Source: ABdhPJzgZUp5LdjGxirjPY4edZK6QDFJPL34whb2F2+KTR36k5aTWKS+KvdBnsSqa0sIIvVAxCM6zQ==
X-Received: by 2002:a05:6512:2116:: with SMTP id q22mr403968lfr.654.1621445758247;
        Wed, 19 May 2021 10:35:58 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y3sm3762458ljj.121.2021.05.19.10.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 10:35:57 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Ray Jui <rjui@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: iproc: Fix a non-compliant kernel-doc
Date:   Wed, 19 May 2021 17:35:56 +0000
Message-Id: <20210519173556.163360-1-kw@linux.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Correct a non-compliant kernel-doc at the top of the pcie-iproc-mci.c
file, and resolve build time warning related to kernel-doc:

  drivers/pci/controller/pcie-iproc-msi.c:52: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/pci/controller/pcie-iproc-msi.c:68: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pcie-iproc-msi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index eede4e8f3f75..65ea83d2abfa 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -49,14 +49,14 @@ enum iproc_msi_reg {
 struct iproc_msi;
 
 /**
- * iProc MSI group
- *
- * One MSI group is allocated per GIC interrupt, serviced by one iProc MSI
- * event queue.
+ * struct iproc_msi_grp - iProc MSI group
  *
  * @msi: pointer to iProc MSI data
  * @gic_irq: GIC interrupt
  * @eq: Event queue number
+ *
+ * One MSI group is allocated per GIC interrupt, serviced by one iProc MSI
+ * event queue.
  */
 struct iproc_msi_grp {
 	struct iproc_msi *msi;
@@ -65,10 +65,7 @@ struct iproc_msi_grp {
 };
 
 /**
- * iProc event queue based MSI
- *
- * Only meant to be used on platforms without MSI support integrated into the
- * GIC.
+ * struct iproc_msi - iProc event queue based MSI
  *
  * @pcie: pointer to iProc PCIe data
  * @reg_offsets: MSI register offsets
@@ -89,6 +86,9 @@ struct iproc_msi_grp {
  * @eq_cpu: pointer to allocated memory region for MSI event queues
  * @eq_dma: DMA address of MSI event queues
  * @msi_addr: MSI address
+ *
+ * Only meant to be used on platforms without MSI support integrated into the
+ * GIC.
  */
 struct iproc_msi {
 	struct iproc_pcie *pcie;
-- 
2.31.1

