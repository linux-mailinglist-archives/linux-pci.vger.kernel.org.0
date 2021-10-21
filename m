Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0CB43653C
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhJUPNY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhJUPNX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:13:23 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6408C061348;
        Thu, 21 Oct 2021 08:11:07 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r2so574072pgl.10;
        Thu, 21 Oct 2021 08:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2kMW7De0WUTFR8R6pbmw+v+DfoEFjJfFZEPmx6TpIo=;
        b=bzWdSeZQujO32b5BMXmzC0hhRwPksEaiJE/YCATPkO92U0l+nmR4WGg3cVxc0hTdyz
         FEiwDhNx3vFODZnaOwNJgeNx0e8s9VBE4HACA2WQtqadySltUFMRd4kiTbex9lmpKjce
         4OU4FX1VyEsIA2rp6LEjNuvr7zj4dR/48s7cnxdC1nFzwHVkbFVZFqn+L/n6KvocLObi
         /Xro4uDDTsrKtYwU2fe5EgmulOTv0YFTQt/SrAZ4iN2CbapeYV6/AF9/iayp6Gix1gdW
         QIyfLJ+azZ1EVH0YzaszjJDw32Rygn46IcE9+H14XdELtLHoCGDulU6jFktpuLeWb6z4
         Z1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2kMW7De0WUTFR8R6pbmw+v+DfoEFjJfFZEPmx6TpIo=;
        b=bnktslb/yZKDnPpuodKVtxCo2+hsAt2L3V4odwZ8rb4/qneJ86NhKZjSH61JqKVfMd
         EnbS7IwYj8K4e9Rcmte1vH6zE0Kvahd7Yj8eUzCjIJ/+cxZybpj5vuVPwzKmtSwKYa4r
         Vo75xV1YUpKGcK5UE011k3qdVxIzWXus2sF6ba7q/2mfTQscuI5l6LS/BDUjx4KpOMrh
         9fJaLLRhqnDhtbs/72hKopFbycfTcDT12wJpXPX63iHdHx5v7sdf4uBIVp6kOfgFjBMj
         6oDrxFqFRVHQFTl6qPT2nZs4bnKMILUrAgvIN/Hz0d6yQhCPWYOOuB6fo9I56xX4E9lP
         PVLw==
X-Gm-Message-State: AOAM531FP1b3rMOFVxCCLHuCnSIEqe1Vec4z7b/qkEHhlPdWDc2qAWk5
        McUcrtH+IU7nj/+JXkU2N5Q=
X-Google-Smtp-Source: ABdhPJxg0pcHZ6TPn2MFYXLLISmkE9s8HA75KNL2gwUrIwqR1ZdHdF+RKfas5XSIW73ZAHG7QCE0Lw==
X-Received: by 2002:a05:6a00:b45:b0:44d:c4c4:409b with SMTP id p5-20020a056a000b4500b0044dc4c4409bmr6124670pfo.3.1634829067053;
        Thu, 21 Oct 2021 08:11:07 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:11:06 -0700 (PDT)
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
Subject: [PATCH v3 07/25] PCI: mediatek: Remove redundant error fabrication when device read fails
Date:   Thu, 21 Oct 2021 20:37:32 +0530
Message-Id: <bbd3536dedffb092c82da7cfbbfa7abbe3f3f379.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
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

