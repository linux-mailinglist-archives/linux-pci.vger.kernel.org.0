Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FD346B97B
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 11:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbhLGKxI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 05:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbhLGKxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 05:53:05 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45E4C061574;
        Tue,  7 Dec 2021 02:49:34 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q3so28560754wru.5;
        Tue, 07 Dec 2021 02:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bxDrZ4uyh13errzvNoCy9OiKsed+5JgH8uT1va6lMpw=;
        b=jrfdMszTENiKdydeNNtc3jt3uzNAcgxaAfu0yUSmybiAA/dg7p6KGtwix4ND2PkOIu
         8DvXw/w3EhCAakYJbkJEslEMydgACdasmjTmFimCrtisahHY10vuuy0V8aeqvsra/XPW
         QdPdRAcH5iXio2u/T05aGqdcrpridL9FT8KL5nlZTRH6k0gou5Tll463MBY6ZLyifTwv
         rpmtI/QIsHaZ/5TWmsxh/U+4EQR2p3iCIy478vja1ujS3rIqILYmXb13xr9CPF3u8pMF
         YLxkf7CtoX37rgP2oM1ETTFizfHL0ATi4W/YdW4IhO6MaVvtGiLS5NFFPeujRZPmIOmQ
         HlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bxDrZ4uyh13errzvNoCy9OiKsed+5JgH8uT1va6lMpw=;
        b=UWisXrS4yCrinLjM7flUawxLDuFm60bf+hcBazVGvGDJk9mGzHCPdEe/nxnjcuRNfc
         xfycZtodjbCEbMW/dEZUypW/ER5WWQxNjaGfgsyWKwFox2RZ9KgTOcrebRVwsWhrVwzS
         E3H66Yo5FDdzQI4ocJCfLRJJs77e7uuiu650xogUTHYn6+JwOpesRpXijAdwFSK0SWVC
         s0rxTfItEJ6pmeUTe12+EJhSfNbLN8sRcJQnPCDKJnWlWZxbT5s1V+BNOFE+rhMhdOxd
         rqPdgG8TEeMG67CDnJ41llefHsvNZjOC2HTWCg72PVuP1hzbpd95Rf8DllDPBKTE+D4F
         iCUw==
X-Gm-Message-State: AOAM533sZE4HUJNXX9tcmPE8z0CQQOv2Gb/Cozfy0bsBgC81Ntbac2gB
        n969aDmSUx6+GtmRZMmHmx8pK7aEtyc=
X-Google-Smtp-Source: ABdhPJx+B1da5gS87V2uCFI1fq4c1MB+nmISFqQ4b9rQliUMAJ+FA/x1drbSa4J3XFwkPxiIGU9G0g==
X-Received: by 2002:a5d:548b:: with SMTP id h11mr50393984wrv.11.1638874173112;
        Tue, 07 Dec 2021 02:49:33 -0800 (PST)
Received: from localhost.localdomain (27.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.27])
        by smtp.gmail.com with ESMTPSA id z6sm13958561wrm.93.2021.12.07.02.49.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 02:49:32 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] PCI: mt7621: Allow COMPILE_TEST for all arches
Date:   Tue,  7 Dec 2021 11:49:24 +0100
Message-Id: <20211207104924.21327-6-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
References: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since all MIPS specific code has been moved from the controller driver side
there is no more stoppers to enable the driver to be completely enable for
'COMPILE_TEST'. So mark as tristate and remove MIPS conditional statement.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/controller/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 7fc5135ffbbf..2d5a86f9089c 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -332,8 +332,8 @@ config PCIE_APPLE
 	  If unsure, say Y if you have an Apple Silicon system.
 
 config PCIE_MT7621
-	bool "MediaTek MT7621 PCIe Controller"
-	depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
+	tristate "MediaTek MT7621 PCIe Controller"
+	depends on SOC_MT7621 || COMPILE_TEST
 	select PHY_MT7621_PCI
 	default SOC_MT7621
 	help
-- 
2.33.0

