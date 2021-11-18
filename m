Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467FD455D5F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhKROIw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbhKROIw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:08:52 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78982C061570;
        Thu, 18 Nov 2021 06:05:52 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id z6so6098263pfe.7;
        Thu, 18 Nov 2021 06:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2kMW7De0WUTFR8R6pbmw+v+DfoEFjJfFZEPmx6TpIo=;
        b=jmYMhdUPtwXlk7YxNRrEY39ARKEZzJckayE37oIVTUa4nPyIslNcR6XMOv+FjMg22s
         S/2TjPlBw5NarH79TxwrLYnoAVvWIZ0ppI9goUKtPGdcd0slD6cnqVcnAcmR2QXi6HrW
         8+7CI+lO7fFXcHknuE0JmXhZ9a5KqyZcFnX4cBMhbOQxCVWJJNIZaMOHFOcmYvr6vB1w
         pltr2d5RvAkg0R5l+YmyEilG8etz39ddfm+YhEh18pVpohNq8By50UkP5pvHXKBFDxd3
         9HBmaDizaekYvA2ywKzrnX+8OKZJm2K/jRoIj7A8oOVDYNxiGAyi68IMrf7PY9dIX6YG
         g3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2kMW7De0WUTFR8R6pbmw+v+DfoEFjJfFZEPmx6TpIo=;
        b=CbBmS0JFUZN442pT4Yrufare90DBND4H62r6GLW+M1Cgw71LBeJ+CwkkIUlEsQx/34
         C8g5z1uWECsTEWhyXo0thRN6fU7j3PbXT3fE08lwbTONeMacL7oj9oiG7Ll8wOuCtftn
         IZK/R0xcriFiXvtFJWkvN4nwOV3hHw753+x7FiYUV1R/iSbFqgMB942PQ1ec++cGAq2B
         Hj8V0Jn2wXz4Md35PsVB9f9yGeKEYgleX6ALON7bPuaWkxATxxPzqnyO73Wvb6GGZ1h6
         Oyc5aWY5pgUYWZHv7skekcMbVuUIM89Y0j2QsvtoapjNemGiUrpy/pqaZycBntMgEleo
         XUNA==
X-Gm-Message-State: AOAM531mYtsT4IIDIT8JWvPhSdFeEPDr8nXFZo4LpGAes6JV77pCqvD2
        X7HOJMbk5MCJupofacZxJB8=
X-Google-Smtp-Source: ABdhPJyV+0mLAR5xy7BosKaOERagEd3ZKVQwr7/RwK2rniXrlnNRhEmZz+hP+50EUyrGGs3nj1a7sw==
X-Received: by 2002:a63:b0d:: with SMTP id 13mr11503398pgl.190.1637244351963;
        Thu, 18 Nov 2021 06:05:51 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:05:51 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org (open list:PCIE DRIVER FOR MEDIATEK),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v4 07/25] PCI: mediatek: Remove redundant error fabrication when device read fails
Date:   Thu, 18 Nov 2021 19:33:17 +0530
Message-Id: <666127469482f9ca177805ff52aeb7bccb26e4c9.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

The host controller drivers sets the error response values (~0) and
returns an error when faulty hardware read occurs. But the error
response value (~0) is already being set in PCI_OP_READ and
PCI_USER_READ_CONFIG whenever a read by host controller driver fails.

Thus, it's no longer necessary for the host controller drivers to
fabricate any error response.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 2f3f974977a3..a19f8ec5d392 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -365,19 +365,12 @@ static int mtk_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 {
 	struct mtk_pcie_port *port;
 	u32 bn = bus->number;
-	int ret;
 
 	port = mtk_pcie_find_port(bus, devfn);
-	if (!port) {
-		*val = ~0;
+	if (!port)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-
-	ret = mtk_pcie_hw_rd_cfg(port, bn, devfn, where, size, val);
-	if (ret)
-		*val = ~0;
 
-	return ret;
+	return mtk_pcie_hw_rd_cfg(port, bn, devfn, where, size, val);
 }
 
 static int mtk_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
-- 
2.25.1

