Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D438166918B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 09:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbjAMIrw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 03:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240492AbjAMIru (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 03:47:50 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D0FAE47;
        Fri, 13 Jan 2023 00:47:49 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id az20so31612894ejc.1;
        Fri, 13 Jan 2023 00:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zces+1O7hY7iJZIJRBo/L6sfY3J8Lf9pSZe8jUHoT4=;
        b=JKMm/rO/PyuWX0pLZaQ1Z9zOgUz9h7kRg514ktxGbI/sVGXPQvtQPPMjkXcxqRbEil
         aop0kvCe3t30/gZbUJh3bQtbtL2I2HJD2fi5mtBUve4uDiJ6v/YZyAmUCIvK+CucpN6T
         rQoR9sI836bFdld/HVmHIjSnPL1p+CvgEosOyoSOjHi2x5pEBYgVOho/n7nxzCECvnd9
         I4Vb2vktrjJWRVL5I4/C32a1/4uYwXjMRSDQnGePvquuPWwN625miLmunbBoqveDDP8Q
         FBCwHLRwwU0DgyPP65Sd4xrzNrw4dOvLTSGzWP9HAaJCmJxBWg4D+rhP9hq5danAgyLv
         40Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zces+1O7hY7iJZIJRBo/L6sfY3J8Lf9pSZe8jUHoT4=;
        b=KYoAJHpVa4N7VSjKtTPnPKg2cVusijISSvdO72zhr9gpYeaYa3dvz6I0KBTppAiiWu
         awA3sDG75upCA3hzu1kWMQxLXIlEX66mQ9tqzt/+o92J5RS5i0NhQTe7qapidu7w4NVH
         PZGnDNp2dPsDpjMhj5CAye+5GZDxVvFUiYRh8BXQC6KavtZ0/B0tbnJ5mk5WaL1oIEzf
         qWhz9RXyKtTrC9+GAWvW7TtFsRlrmMXNnporkbFJ+Is127Wfkoyse0qFSQADA7XwiwSS
         HE/mMR8NAOpy6+/mwILWyGebxoU6bwQBiTG47hIW9/xqCjZ2P2hvxlLKdFlqyjnO+LpN
         Lxog==
X-Gm-Message-State: AFqh2kod3lcj1/wBMkUWyYjE2eGd7gTpfRtBqQrqTo/2JHedt0WVL1xL
        okTFtoDJqIX3sMjrn7bmkvQ=
X-Google-Smtp-Source: AMrXdXuyvnC6igG9kOyuA9QRAEg1TACbQ37KDGwfThlkqWU+obPWH+wwN5ZNSRKl63VzcFqbtNAg+Q==
X-Received: by 2002:a17:906:19ce:b0:858:cccd:7c6a with SMTP id h14-20020a17090619ce00b00858cccd7c6amr10722125ejd.68.1673599667620;
        Fri, 13 Jan 2023 00:47:47 -0800 (PST)
Received: from felia.fritz.box (ipbcc1d920.dynamic.kabel-deutschland.de. [188.193.217.32])
        by smtp.gmail.com with ESMTPSA id q5-20020aa7d445000000b00482b3d0e1absm7944996edr.87.2023.01.13.00.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 00:47:47 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] PCI: rcar: avoid defines prefixed with CONFIG
Date:   Fri, 13 Jan 2023 09:45:16 +0100
Message-Id: <20230113084516.31888-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Defines prefixed with "CONFIG" should be limited to proper Kconfig options,
that are introduced in a Kconfig file.

Here, a definition for a bitmask to configure the SEND_ENABLE mode is named
CONFIG_SEND_ENABLE.

Rename this local definition to CONFIGURE_SEND_ENABLE to avoid defines
prefixed with "CONFIG".

No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/pci/controller/pcie-rcar-host.c | 4 ++--
 drivers/pci/controller/pcie-rcar.h      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index e4faf90feaf5..52fdafe5c877 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -219,9 +219,9 @@ static int rcar_pcie_config_access(struct rcar_pcie_host *host,
 
 	/* Enable the configuration access */
 	if (pci_is_root_bus(bus->parent))
-		rcar_pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE0, PCIECCTLR);
+		rcar_pci_write_reg(pcie, CONFIGURE_SEND_ENABLE | TYPE0, PCIECCTLR);
 	else
-		rcar_pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE1, PCIECCTLR);
+		rcar_pci_write_reg(pcie, CONFIGURE_SEND_ENABLE | TYPE1, PCIECCTLR);
 
 	/* Check for errors */
 	if (rcar_pci_read_reg(pcie, PCIEERRFR) & UNSUPPORTED_REQUEST)
diff --git a/drivers/pci/controller/pcie-rcar.h b/drivers/pci/controller/pcie-rcar.h
index 9bb125db85c6..a09f58ab04ca 100644
--- a/drivers/pci/controller/pcie-rcar.h
+++ b/drivers/pci/controller/pcie-rcar.h
@@ -11,7 +11,7 @@
 
 #define PCIECAR			0x000010
 #define PCIECCTLR		0x000018
-#define  CONFIG_SEND_ENABLE	BIT(31)
+#define  CONFIGURE_SEND_ENABLE	BIT(31)
 #define  TYPE0			(0 << 8)
 #define  TYPE1			BIT(8)
 #define PCIECDR			0x000020
-- 
2.17.1

