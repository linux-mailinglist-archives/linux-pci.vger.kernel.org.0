Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BCA4658A0
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 22:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353253AbhLAVzW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 16:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353206AbhLAVzE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 16:55:04 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3FCC061756;
        Wed,  1 Dec 2021 13:51:36 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so2170077wmc.2;
        Wed, 01 Dec 2021 13:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RaIl7xQSoXsxAYdLKywvcuTT4Blwc6PXsDlGAUvpoKY=;
        b=Vj/NKn43nd8bESAwtHAudpnpTXDWLx0rOLw71QiY2Ci0KdOZ0wO9EqdBz+niamJIKc
         lOATqAmTW1L+f4zVIbRtC8o0deS/CHm5o4YEeDd23YZrDeugg8gx4QDSlSKjpL4btdV6
         zu6rYNDZ0Fuw4ikKwxPrYuCksRUhmi7V+GJFWBIUqfWj86pV20ERuzbGs5QGGqwhzifP
         QrUeXaiPsknbo5hraf7IWzRIYJxjU+BEF0O3xXJm/gUJgkRNepICYzWf404JAPgVNDG1
         qlLtsyJgMAxEXO0e+FtqRAUiG6TBo7njyoBxfv3Pz1IlwKIg6KSaq74RSK0d/vn2zGK9
         Lo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RaIl7xQSoXsxAYdLKywvcuTT4Blwc6PXsDlGAUvpoKY=;
        b=sWbYgyl04HccYAMKvA417dNo5oY6mw8JikNZHbzuturitIUEq/MapA1aNVtVK79gQa
         olZD/0CUf9RQNehELQi+HBVzrJhw5u386TxzpFfl1MORlHV5Fpww3IhqPkpXUCZ3NWba
         34aipeOE4kOZ2bTfpj/Xry8lG8DvqDjoAUzm3AKSKapK10ys2MdPcEOYgOMKoLpPQmdj
         CFyqad02OaOBtTY2rfIf/PHLxrec+091uHJonX7RDWHYvfcxlgzXd5JMzU8YnUYwgZHt
         KMFDyJQcpTrPJImUo/1x3FaWSIEUWgtL7954c5STmzoOhjrl+yglygKhT9kanLpCmJGs
         Gb8g==
X-Gm-Message-State: AOAM530/HqMiPoMsr8Q9CY+LH8fIiHw5u1xWiJGoEKrCrPkI52AgeXOg
        bCP8wl3vud0msrVlA5zbGq0ls7vQR9U=
X-Google-Smtp-Source: ABdhPJyhgRaVIDmlqKXjN6DihVN0a0iVYb5bKJ6jNsc9qvyWz0kQXtXSqPG2vzDclnEscJiqFM+yoQ==
X-Received: by 2002:a05:600c:b43:: with SMTP id k3mr1033589wmr.159.1638395495199;
        Wed, 01 Dec 2021 13:51:35 -0800 (PST)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id c10sm877879wrb.81.2021.12.01.13.51.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 13:51:34 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, arnd@arndb.de,
        linux@roeck-us.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] PCI: mt7621: Kconfig: Allow COMPILE_TEST for all arches
Date:   Wed,  1 Dec 2021 22:51:27 +0100
Message-Id: <20211201215127.23550-6-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211201215127.23550-1-sergio.paracuellos@gmail.com>
References: <20211201215127.23550-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since all MIPS specific code has been moved from the controller driver side
there is no more stoppers to enable the driver to be completely enable for
'COMPILE_TEST'. Hence, remove MIPS conditional statement.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/controller/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 93b141110537..18d41d2b0392 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -333,7 +333,7 @@ config PCIE_APPLE
 
 config PCIE_MT7621
 	tristate "MediaTek MT7621 PCIe Controller"
-	depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
+	depends on (RALINK && SOC_MT7621) || COMPILE_TEST
 	select PHY_MT7621_PCI
 	default SOC_MT7621
 	help
-- 
2.33.0

