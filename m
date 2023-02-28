Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39296A526B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 05:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjB1ErC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 23:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB1ErC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 23:47:02 -0500
X-Greylist: delayed 578 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Feb 2023 20:47:00 PST
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6761C311;
        Mon, 27 Feb 2023 20:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1677559041;
        bh=m0XcrIM1rbnBFNvtyeHvQ8Hb1eIxnxGXZLNlR7KHvwk=;
        h=From:To:Cc:Subject:Date:From;
        b=mMPjLB2JcXBVoOlRsJ7QRK6rPJJRbsS10Hxj6C7KGI5WW75q+0Dvt0+L0oeZNWtuB
         pAGZMmPMgNX6vdgDZfDOwRVYlDYn5PLWP6ecZ1UeRXkbpwNxMcQt+YGVDCChvguv4f
         mNr85f6SQyHrNLvDtjZ8w9G/A5NHpCmfAq4Zro6k=
Received: from stargazer.. (unknown [IPv6:240e:358:1178:d600:dc73:854d:832e:3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id CA0EA65B60;
        Mon, 27 Feb 2023 23:37:17 -0500 (EST)
From:   Xi Ruoyao <xry111@xry111.site>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@huawei.com>,
        Xi Ruoyao <xry111@xry111.site>, stable@vger.kernel.org
Subject: [PATCH] PCI: kirin: Select REGMAP_MMIO for PCIE_KIRIN
Date:   Tue, 28 Feb 2023 12:34:24 +0800
Message-Id: <20230228043423.19335-1-xry111@xry111.site>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie-kirin.c invokes devm_regmap_init_mmio, so it's necessary to select
REGMAP_MMIO or vmlinux fails to link with "undefined reference to
`__devm_regmap_init_mmio_clk`.

Cc: stable@vger.kernel.org # at least for 6.1 and 6.2
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 drivers/pci/controller/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 434f6a4f4041..d29551261e80 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -307,6 +307,7 @@ config PCIE_KIRIN
 	tristate "HiSilicon Kirin series SoCs PCIe controllers"
 	depends on PCI_MSI
 	select PCIE_DW_HOST
+	select REGMAP_MMIO
 	help
 	  Say Y here if you want PCIe controller support
 	  on HiSilicon Kirin series SoCs.
-- 
2.39.2

