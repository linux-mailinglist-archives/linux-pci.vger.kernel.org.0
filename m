Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC2251AC28
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 20:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353006AbiEDSGZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 14:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359841AbiEDSGM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 14:06:12 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC2E50446;
        Wed,  4 May 2022 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OkLWA35yCfirCuaQDiFaSQT4Boa4urpvOuCCHvvJHYY=; b=Ljz2K44kbkEWAxWCVMms4dlq58
        Zf1GNhVarsNZg5PEr4tVA2F/hWLZZ363qtIsvRrZlSHxPdFg+XbEoGrzvZsTN1Mb2Js49thPtdpdQ
        o09qHJ4QZPvawQpzqwEU2yG+0hi8VZe0VlG06ePUNMcj9siU9ZxcUkhgG4Ay8/j1je9I=;
Received: from p200300daa70ef200891a2ae4514fd280.dip0.t-ipconnect.de ([2003:da:a70e:f200:891a:2ae4:514f:d280] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nmIgs-0004Fq-Nr; Wed, 04 May 2022 19:21:30 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] PCI: mediatek-gen3: Change driver name to mtk-pcie-gen3
Date:   Wed,  4 May 2022 19:21:27 +0200
Message-Id: <20220504172128.27489-1-nbd@nbd.name>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

driver_register() will refuse to register another driver with the same name.
This change allows pcie-mediatek-gen3 to coexist with pcie-mediatek built into
the kernel.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 3e8d70bfabc6..2e665cd7e735 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1021,7 +1021,7 @@ static struct platform_driver mtk_pcie_driver = {
 	.probe = mtk_pcie_probe,
 	.remove = mtk_pcie_remove,
 	.driver = {
-		.name = "mtk-pcie",
+		.name = "mtk-pcie-gen3",
 		.of_match_table = mtk_pcie_of_match,
 		.pm = &mtk_pcie_pm_ops,
 	},
-- 
2.35.1

