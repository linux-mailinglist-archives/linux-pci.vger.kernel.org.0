Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887672FD9AC
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 20:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbhATTWW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 14:22:22 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:36995 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388671AbhATSsy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jan 2021 13:48:54 -0500
Received: by mail-wm1-f45.google.com with SMTP id c128so3759073wme.2
        for <linux-pci@vger.kernel.org>; Wed, 20 Jan 2021 10:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uxPmbiajECo9YExCxiewn6BUGuPfDNtaPp5Y2cOf+vw=;
        b=UKxlCiRSJDq4U13Cp5Eii6miOwNPrU9cZLiCptY7X/jdRhB+XkeoHOkIWoVnZJAlPr
         jY63oCpJrrOBi4Bc+tq+Qdl1Rbuje7rj9MoSMQ1x5yvBHUhV8ak9thEfbfxmUrh0sE+R
         67dCHyHb0t000AT1aUc5MI/FiEyj+sj/Jze68uSKOXZvgYgw0dWLgB3JmF0QaMljBaNs
         tt5q21fKYvkunuWhxpUP+yYwWjZ9kHtBbbPWIr3lWzsnq4nHFDPNUaMRQ2eKDU/TB37g
         BZTmFMQFje5e1NNhkoQzkaiUa0WUaTp8U/8TbllLs0sxW4TJ+tL6q5MQd77i3yIZRfK+
         yhzw==
X-Gm-Message-State: AOAM53016P27wkqIguveE5v0guoACS9hrHDsUdo1vaFN/loJUWJBdYLl
        DFmBiHBTtK2tQ7hyPPG7wck=
X-Google-Smtp-Source: ABdhPJwtn2xpshugzYAvflARryBYa82pNPYQWztaOHR67Bzcg8Dpc4zdRyBK9jvQ3DfPLD+GcFYXig==
X-Received: by 2002:a1c:c90c:: with SMTP id f12mr5726969wmb.98.1611168492620;
        Wed, 20 Jan 2021 10:48:12 -0800 (PST)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id v11sm5466474wrt.25.2021.01.20.10.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:48:11 -0800 (PST)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: mediatek: Add missing of_node_put() to fix reference leak
Date:   Wed, 20 Jan 2021 18:48:10 +0000
Message-Id: <20210120184810.3068794-1-kw@linux.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The for_each_available_child_of_node helper internally makes use of the
of_get_next_available_child() which performs an of_node_get() on each
iteration when searching for next available child node.

Should an available child node be found, then it would return a device
node pointer with reference count incremented, thus early return from
the middle of the loop requires an explicit of_node_put() to prevent
reference count leak.

To stop the reference leak, explicitly call of_node_put() before
returning after an error occurred.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pcie-mediatek.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index cf4c18f0c25a..23548b517e4b 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1035,14 +1035,14 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 		err = of_pci_get_devfn(child);
 		if (err < 0) {
 			dev_err(dev, "failed to parse devfn: %d\n", err);
-			return err;
+			goto error_put_node;
 		}
 
 		slot = PCI_SLOT(err);
 
 		err = mtk_pcie_parse_port(pcie, child, slot);
 		if (err)
-			return err;
+			goto error_put_node;
 	}
 
 	err = mtk_pcie_subsys_powerup(pcie);
@@ -1058,6 +1058,9 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 		mtk_pcie_subsys_powerdown(pcie);
 
 	return 0;
+error_put_node:
+	of_node_put(child);
+	return err;
 }
 
 static int mtk_pcie_probe(struct platform_device *pdev)
-- 
2.30.0

