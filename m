Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5976B4D77F4
	for <lists+linux-pci@lfdr.de>; Sun, 13 Mar 2022 20:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiCMTa7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Mar 2022 15:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiCMTa6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Mar 2022 15:30:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F052F4D274
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 12:29:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 61E4ACE1021
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 19:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE88C340E8;
        Sun, 13 Mar 2022 19:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647199786;
        bh=iNcxdOwm0xt6nEOBuxqzmK2AJz/ainD+3ic1m54Aou0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SjF57+XE0LsgSRPhIhq6d9lt8g67ZourEqop+CpfPwT2I4w7DDjwJ47w1lz0K4xLs
         GLeUlo2KjngAMzdoeE4YNO+afVsuowEtnxFhq4+xoo+IOxhSdhPQStiq5q3GgYORxw
         VNW2zaNUAVWfr4jKxiNY0jDAf9RgNyTdtiS3LyuoeKr00EAiyKVBpiAHuiIzw2gTGi
         50lFeCSLzkx/v+n4TDUI3LSoOa/JdZr1A46p1W5j5ykzb+KIGJ1sDAVYp/anExNlcC
         RYA/Fgmw3gx42Tl4CNsG3oQia3EmT7a6auOS+WegfxoUm0Z9BXKtRhMHIY2xyFiYoN
         9lz+RvROQrjrQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/5] PCI: fu740: Remove unused assignments
Date:   Sun, 13 Mar 2022 14:29:31 -0500
Message-Id: <20220313192933.434746-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220313192933.434746-1-helgaas@kernel.org>
References: <20220313192933.434746-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

fu740_pcie_host_init() assigned "ret", but never used the value.  Drop it.

Found by Krzysztof Wilczyński <kw@linux.com> using cppcheck:

  $ cppcheck --enable=all --force
  unreadVariable drivers/pci/controller/dwc/pcie-fu740.c:227 Variable 'ret' is assigned a value that is never used.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pcie-fu740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 00cde9a248b5..43b7b8e18354 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -224,7 +224,7 @@ static int fu740_pcie_host_init(struct pcie_port *pp)
 	/* Clear hold_phy_rst */
 	writel_relaxed(0x0, afp->mgmt_base + PCIEX8MGMT_APP_HOLD_PHY_RST);
 	/* Enable pcieauxclk */
-	ret = clk_prepare_enable(afp->pcie_aux);
+	clk_prepare_enable(afp->pcie_aux);
 	/* Set RC mode */
 	writel_relaxed(0x4, afp->mgmt_base + PCIEX8MGMT_DEVICE_TYPE);
 
-- 
2.25.1

