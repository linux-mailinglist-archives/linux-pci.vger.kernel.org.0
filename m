Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41149467E2E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 20:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343802AbhLCT2X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 14:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244366AbhLCT2X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 14:28:23 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896C8C061751;
        Fri,  3 Dec 2021 11:24:58 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v11so7701579wrw.10;
        Fri, 03 Dec 2021 11:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EEFcmjLKAlBmlvjGylr08HbaXAdwYeLt+bnhHHuM/QA=;
        b=Q5EOPj26G6BGi1Vx6HjU5vFZiwOD/b28KX5HElgbB3rqlniY1nAR2JgZMCeHyCJwCX
         08RhA1oDjz77A5ZQewAcur2GNaVTPb7vWp8kTgF6ILvXMBfQ2LUDmFlR5m+3V6Ua7I7T
         dPcpI6T4HPD+K8Q3LzxZ8r8F4FAv2b9i9ndGTPMqtx5aau/A7Aa8ybxwQkk19vM9J/T1
         F4lBum0uOj5NctwNU594ZM7b1kEXoAEbSFAmJgDDJnqL4q+NzDeHGMeN1Nt6O+Gq+wG9
         11oYmM9IXMGuFQntsAQjiTypJAX0zhpfn2vehOJmlePGAuhumeP9fig7Y/cvDq84FVic
         1dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EEFcmjLKAlBmlvjGylr08HbaXAdwYeLt+bnhHHuM/QA=;
        b=46EruqQcKQq0HmZGk5oi48n1BkB2LyqOnGj5mbuprvP8mbiW2ZV+v5Y1bMpE0f0jJE
         Vny93nxMnA8LXCiXDqpySRrunDUHnL7Uv/MuuU46nh7rXopEazcs+c6R0JeKhismkgxg
         6DTBjpFz13b9ZROpbjLI88bxCOV4Eu0XW/iFo8bxWT4lYf/u5sodCD7vFZ5b/zCDF6m2
         sVxhn5i0gZcH9bMsazlzg14YB24RhBLQrAb/y1DbXuNfXBvDTXIsvW5/irT6nXxI0Rgs
         OHfcBHV6gL9XWE3kUzVq48Gz6YSmlQjyHANWXV9PCOO2Kq/nSmtsC41bn29lG5CNGmGr
         vOqA==
X-Gm-Message-State: AOAM531rkIwl2hKjf9YWNG5cm2ePnSX2hNcAJy+iNuRRKuv45ac/v6xb
        hm6ALmGXGMwAknRak9bWYJlRm18ZJpw=
X-Google-Smtp-Source: ABdhPJwosQq3KNkddLlDcOEwe6QDbVRHgXIklYKuzBslxrBUaOcVlQ/DRcATsz3724SdDkgV3Q82gA==
X-Received: by 2002:a5d:5251:: with SMTP id k17mr23681746wrc.482.1638559496865;
        Fri, 03 Dec 2021 11:24:56 -0800 (PST)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id 138sm6044818wma.17.2021.12.03.11.24.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Dec 2021 11:24:56 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, arnd@arndb.de, linux@roeck-us.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI: mt7621: Convert driver into 'bool'
Date:   Fri,  3 Dec 2021 20:24:54 +0100
Message-Id: <20211203192454.32624-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Driver is not ready yet to be compiled as a module since it depends on some
MIPS not exported symbols. We have the following current problems:

Building mips:allmodconfig ... failed
--------------
Error log:
ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!

Temporarily move from 'tristate' to 'bool' until a better solution is ready.

Also RALINK is redundant because SOC_MT7621 already depends on it. Hence,
simplify condition.

Fixes: 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver").
Reviewed-and-tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
Changes in v3:
 - Adjust subject to follow convention:
    s/PCI: mt7621: Kconfig:/PCI: mt7621:/
Changes in v2:
 - Add Guenter's 'Reviewed-and-tested-by'.
 - s/after/until
 drivers/pci/controller/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 93b141110537..7fc5135ffbbf 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -332,8 +332,8 @@ config PCIE_APPLE
 	  If unsure, say Y if you have an Apple Silicon system.
 
 config PCIE_MT7621
-	tristate "MediaTek MT7621 PCIe Controller"
-	depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
+	bool "MediaTek MT7621 PCIe Controller"
+	depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
 	select PHY_MT7621_PCI
 	default SOC_MT7621
 	help
-- 
2.33.0

