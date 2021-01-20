Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6632FCF64
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 13:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbhATLYf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 06:24:35 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:44453 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388295AbhATKxt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jan 2021 05:53:49 -0500
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2335C22727;
        Wed, 20 Jan 2021 11:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1611139983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BQVeTcT5ofSmzP64+CmbTYyNgf79aiI+Bl93C1bsim4=;
        b=PW4Z8urt2cjMzsaFhpulLr9QCshpjmvLDPg5W/SrjTTixsit7WTXvl1F3DCgOqzCoWCWUu
        bVVPZfoKZSsrBLE72+MAIcRleKklcGp8EQPJncZQmxr7z6USoRQNU0gRIWZP50bnHubkjH
        FkgPAdB1ZYys8y9oojOLjwtIXpropB0=
From:   Michael Walle <michael@walle.cc>
To:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] PCI: dwc: layerscape: convert to builtin_platform_driver()
Date:   Wed, 20 Jan 2021 11:52:46 +0100
Message-Id: <20210120105246.23218-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

fw_devlink will defer the probe until all suppliers are ready. We can't
use builtin_platform_driver_probe() because it doesn't retry after probe
deferral. Convert it to builtin_platform_driver().

Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/pci/controller/dwc/pci-layerscape.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 44ad34cdc3bc..5b9c625df7b8 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -232,7 +232,7 @@ static const struct of_device_id ls_pcie_of_match[] = {
 	{ },
 };
 
-static int __init ls_pcie_probe(struct platform_device *pdev)
+static int ls_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
@@ -271,10 +271,11 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 }
 
 static struct platform_driver ls_pcie_driver = {
+	.probe = ls_pcie_probe,
 	.driver = {
 		.name = "layerscape-pcie",
 		.of_match_table = ls_pcie_of_match,
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver_probe(ls_pcie_driver, ls_pcie_probe);
+builtin_platform_driver(ls_pcie_driver);
-- 
2.20.1

