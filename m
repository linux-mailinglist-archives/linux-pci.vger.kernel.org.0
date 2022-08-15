Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C065927E4
	for <lists+linux-pci@lfdr.de>; Mon, 15 Aug 2022 04:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiHOCuT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Aug 2022 22:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiHOCuS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Aug 2022 22:50:18 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1AB200
        for <linux-pci@vger.kernel.org>; Sun, 14 Aug 2022 19:50:17 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id q19so5680126pfg.8
        for <linux-pci@vger.kernel.org>; Sun, 14 Aug 2022 19:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=yKvSiFM2Z2v6eLI8oCzY6sadmmVPmFXasBhipDUgRaE=;
        b=3SrUlCqu/FfHPkPHGETs2xuZaiEmBR2hjG8FpU3sbVK7zU3ZTztCGcB8LZVWijXB5c
         +wTx/nXzxQwdcDJUvjOvTOYMX0JkrVBysxju3vEBEwk1LdtehGdOYOBO1P3T7unUm9Wp
         K9MUmNdWyClt4eqvsWgIsbM5pGGAyTgV2obw+WE68Zp8xRjaljdGLdBMGmBs+lmcbSOD
         ecGp6ifxvzACXV5LMBTAm84A0wznmHJZ2zn9NfG4mPeNOpQflejjUsQE82CWeMZjrsel
         UTX+M0qlu1YMG/XEwjHY/HheAHSrc4jhHo4Zg/zgVGshPjUz4fawTLQCwFlTbRknF6Ya
         TW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yKvSiFM2Z2v6eLI8oCzY6sadmmVPmFXasBhipDUgRaE=;
        b=OSHTTOI+UYKs0+wpOUXk1KAJrQjx0vqCAsqNseE92ODjs7COzTn9WEnucN/i1U1p+e
         6V32rAqe9pWphFYNrEH1y1L/enLpU3/BOYpJBVDc3ltf/SkPFWbJY92rsLX9BgV6rjpZ
         1tpKIAw/m9aSnJ6Wgp6AYhbHEeGwW1rkBGoSLxDH+wRV/lnpmEAq31FhK/0cgUEbB0cq
         fvzR1OyLAG2kN6MOhyisNiLk5BuBTzbScI8X/s026sKFCa2p/nH9t/237OhQG5ic8swv
         VDt0lnMg2CMzIc10WpKzPP3js1hYDDUuaQYdUFXtHtMzYxcE7q17qS4FXQaJtxUkvwdy
         mp3g==
X-Gm-Message-State: ACgBeo0bY29XwN3IKgtYs7yl/LDA8RJtKRAPoWQm07g9LLOg4+vrwYgL
        znn2rUmOjR1zdeQC5wThtjDdBgmc+ASszjnJ
X-Google-Smtp-Source: AA6agR6of8JTXX8O1oZ7QP80CVRr/7M2QW2zlJ9e3BFPk/j8sELuniNjCbY+WCkjjhAFuN7O6DQ+WQ==
X-Received: by 2002:a63:5550:0:b0:429:411b:225 with SMTP id f16-20020a635550000000b00429411b0225mr2262208pgm.352.1660531816648;
        Sun, 14 Aug 2022 19:50:16 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a0f1600b001f7a4ea4fd5sm3675065pjy.39.2022.08.14.19.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 19:50:16 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Jon Mason <jdmason@kudzu.us>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Shunsuke Mie <mie@igel.co.jp>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: fix Kconfig indent style
Date:   Mon, 15 Aug 2022 11:50:06 +0900
Message-Id: <20220815025006.48167-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change to follow the Kconfig style guide. This patch fixes to use tab
rather than space to indent, while help text is indented an additional
two spaces.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/pci/endpoint/functions/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index 295a033ee9a2..9fd560886871 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -27,13 +27,13 @@ config PCI_EPF_NTB
 	  If in doubt, say "N" to disable Endpoint NTB driver.
 
 config PCI_EPF_VNTB
-        tristate "PCI Endpoint NTB driver"
-        depends on PCI_ENDPOINT
-        depends on NTB
-        select CONFIGFS_FS
-        help
-          Select this configuration option to enable the Non-Transparent
-          Bridge (NTB) driver for PCIe Endpoint. NTB driver implements NTB
-          between PCI Root Port and PCIe Endpoint.
+	tristate "PCI Endpoint NTB driver"
+	depends on PCI_ENDPOINT
+	depends on NTB
+	select CONFIGFS_FS
+	help
+	  Select this configuration option to enable the Non-Transparent
+	  Bridge (NTB) driver for PCIe Endpoint. NTB driver implements NTB
+	  between PCI Root Port and PCIe Endpoint.
 
-          If in doubt, say "N" to disable Endpoint NTB driver.
+	  If in doubt, say "N" to disable Endpoint NTB driver.
-- 
2.17.1

