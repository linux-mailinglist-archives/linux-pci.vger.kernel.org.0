Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E57665851
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 10:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjAKJ5e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 04:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbjAKJ4z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 04:56:55 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4688CC9;
        Wed, 11 Jan 2023 01:54:11 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id jo4so35476599ejb.7;
        Wed, 11 Jan 2023 01:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8kExCUKRNhblEbW+B8lIqskfGoABqtXBunGasaq1Oo=;
        b=kgSSuMjCic6AcTBc/EZpLz9gNiQVLoTJMu/wm4fQcLczNMuXE85aCL4ohw1hQ9EXfk
         basT8jf5u5sfV7woGgAfTsqpVUyQ6ZCtNcVtBfyck925RBBQpVTySHotWywXi9DJ/43P
         VZzbzyWJnJOl4E4c5w/taxrV4y46mWDR85QOzEjj3WbkA9A7uI6eaZ666/5DzoCnt4w1
         OWGTRiSpz0+g5KyNK/NtTCJPHLO6HozLwy1VLB5tutOoQsWV+1+e7A4s98p15+BRS8fw
         wl8q9eMMgAqLrKVQRNHQy4C6a8ptWtjConGv7DLdYhNo15EeHole0REU5fKmr1KSxdaR
         zHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8kExCUKRNhblEbW+B8lIqskfGoABqtXBunGasaq1Oo=;
        b=2pSlnhkB3ZVPDknK6FkH+ZU5a5ru1bwJUyH9IY/R3Jm3aHB6kTPFTPKVRs0wKCJ4DE
         WzO15bR//Gksirqrs3Imiz/DMOq5qDkZOufVt0NH8uILHkgcTOS35myPlehM+ZZj7h70
         PubhFICDQcuahisgLot3VxKPwohOy1Q9yWEptwXNPP6f4hIfile8frSnrlHdDKgZ2Ebz
         1RKz92PvKeeLeLvJ1CMgtluBYghFUPE7k/d0iu0TAxuM1lK8xB3tvb6OLeoQA1rf9z8N
         oMyLKSeXr/gnwnvHPyQjvYz/fXRez+jdf1KbT1KVwydKjxhrQe9mOfaRStU/POae3kAo
         6OYw==
X-Gm-Message-State: AFqh2ko1hxuOZC21xBq28KTm6w7JDBYDhXLkVwb9VOyRoGtu/kOGOmRZ
        UGuID7dvuNL6Tix1qSivMVQ=
X-Google-Smtp-Source: AMrXdXviwQ9qBVfsVUAk9RIHULDycXIVNWkW/bbCw0pNuqvVggqjD4WexAU7d9BEgpVYjulNSCTIWg==
X-Received: by 2002:a17:906:3513:b0:7ff:7205:414e with SMTP id r19-20020a170906351300b007ff7205414emr54002294eja.69.1673430849942;
        Wed, 11 Jan 2023 01:54:09 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:a47e:7f3e:6b25:bafb])
        by smtp.gmail.com with ESMTPSA id k2-20020a17090632c200b007b47749838asm5891101ejk.45.2023.01.11.01.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 01:54:09 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] PCI: dwc: remove redundant config PCI dependency for config PCIE_DW_PLAT_EP
Date:   Wed, 11 Jan 2023 10:54:01 +0100
Message-Id: <20230111095401.17071-1-lukas.bulwahn@gmail.com>
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

While reviewing dependencies in some Kconfig files, I noticed the redundant
dependency "depends on PCI && PCI_MSI". The config PCI_MSI has always,
since its introduction, been dependent on the config PCI. So, it is
sufficient to just depend on PCI_MSI, and know that the dependency on PCI
is implicitly implied.

Reduce the dependencies of config PCIE_DW_PLAT_EP.
No functional change and effective change of Kconfig dependendencies.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/pci/controller/dwc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 99ec91e2a5cf..ff2e478e48b5 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -67,7 +67,7 @@ config PCIE_DW_PLAT_HOST
 
 config PCIE_DW_PLAT_EP
 	bool "Platform bus based DesignWare PCIe Controller - Endpoint mode"
-	depends on PCI && PCI_MSI
+	depends on PCI_MSI
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	select PCIE_DW_PLAT
-- 
2.17.1

