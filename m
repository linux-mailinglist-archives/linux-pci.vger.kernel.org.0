Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2744142F5F1
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbhJOOqd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240659AbhJOOqb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:46:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7164AC061570;
        Fri, 15 Oct 2021 07:44:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lk8-20020a17090b33c800b001a0a284fcc2so9502942pjb.2;
        Fri, 15 Oct 2021 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3zEq2AfHmzmiP6iMn6OVsjvfYEnKpi8akIlRzP+t4I8=;
        b=dyAZT/p0dT9PasizXG2QMLWP9+YuqIWP99M5ACtaPFSadZhI9m8GHHkk/R4W7hP/5M
         +DNZp8rf5DzYFVHmNz6KFZCw4c7mbbAj9hvFDbEd6rifpLj/XHlbJ0t3iEx/Vi7lia6o
         wtxQwipx6zSrA3RauqaZM5GjsrkJaKrFH4zW4tv7gjYRhV4ePeatlUr2d64wt1+IrTwK
         MPtfpVvhV3iipgHqHHOOLXFg34TM8uHMn4KHgb96uTeftw23YinyaP+JWZ+3IjI3XLpI
         iy2mvee0AmgSDet/bU1TeLGQTGO9upb3jd6JhLmmLfN/I7jqkB7U/URY0+iLAe57JUY7
         Du6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3zEq2AfHmzmiP6iMn6OVsjvfYEnKpi8akIlRzP+t4I8=;
        b=iGk2N68NAlAEty/YU568gK4qq61y/3G/v4ufeppvA3/83Z3uwsOvMSGwOyckI+cgeC
         674DBSGpXM3KDTmAOyk7reEfZjZ22Kai4bCvyMzn7sO+UpHy0b+sV15Hc8hAu5AHk+GW
         my6kSUzuXjXX5j5BQKVdEK/SlNLu97OUWfg9G/eX6+OMEClTTLw5EijyV8/XuKlsnHOt
         7sLH03Xm3pyf4DANYqw+d/nOd62KiaiBaB0RJHYr9GUs/YFORGPq9rT3ASuLtRcP/y0X
         z/p4GS1wIDDAXC5HzyZNz6IRKLkAFW8ZHzzpk+1GvJuJynf4OlfZP3IskDvrq5++7P0g
         zUdQ==
X-Gm-Message-State: AOAM532DLMHNG9hD7Pt90KcJ8V7bkYV0fa1esRbpVdLUTaLUYa4LXiuT
        BcDiPhvJCXawDHeAnCy48p65XALHHpPO61Yo
X-Google-Smtp-Source: ABdhPJwN5vVjjcYaPoWE1cazSNXn7TZ2gWNzDqGt6lze4Za97JUo8BXigAYTP3PVi53Z4LxVs6VtIQ==
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr28519019pjg.118.1634309064982;
        Fri, 15 Oct 2021 07:44:24 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:44:24 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR
        AARDVARK (Marvell Armada 3700))
Subject: [PATCH v2 11/24] PCI: aardvark: Remove redundant error fabrication when device read fails
Date:   Fri, 15 Oct 2021 20:08:52 +0530
Message-Id: <f7965c41d74e0efd4f6f01eb19af90f99989346c.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
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
 drivers/pci/controller/pci-aardvark.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 596ebcfcc82d..1af772c76d06 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -893,10 +893,8 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	u32 reg;
 	int ret;
 
-	if (!advk_pcie_valid_device(pcie, bus, devfn)) {
-		*val = 0xffffffff;
+	if (!advk_pcie_valid_device(pcie, bus, devfn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	if (pci_is_root_bus(bus))
 		return pci_bridge_emul_conf_read(&pcie->bridge, where,
@@ -920,7 +918,6 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 			*val = CFG_RD_CRS_VAL;
 			return PCIBIOS_SUCCESSFUL;
 		}
-		*val = 0xffffffff;
 		return PCIBIOS_SET_FAILED;
 	}
 
@@ -955,16 +952,13 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 			*val = CFG_RD_CRS_VAL;
 			return PCIBIOS_SUCCESSFUL;
 		}
-		*val = 0xffffffff;
 		return PCIBIOS_SET_FAILED;
 	}
 
 	/* Check PIO status and get the read result */
 	ret = advk_pcie_check_pio_status(pcie, allow_crs, val);
-	if (ret < 0) {
-		*val = 0xffffffff;
+	if (ret < 0)
 		return PCIBIOS_SET_FAILED;
-	}
 
 	if (size == 1)
 		*val = (*val >> (8 * (where & 3))) & 0xff;
-- 
2.25.1

