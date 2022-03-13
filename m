Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F188C4D77F2
	for <lists+linux-pci@lfdr.de>; Sun, 13 Mar 2022 20:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiCMTaz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Mar 2022 15:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiCMTax (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Mar 2022 15:30:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3394D613
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 12:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3B8660A3C
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 19:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC91C340E8;
        Sun, 13 Mar 2022 19:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647199784;
        bh=7KVfacew+6JFbrQM7aODieqhQgGAJ0Y02YuqLB3O03k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VKMEtqAPqSKprpE16hTRIom4sSgMdtUxWhQojKge4shD4kKiI3GB9nWGp9soMIaws
         Kim29ELluew7dM/kGfMhr7d9DdjwGiq5aXq82PenTXc4wpApc3iWBVCXv0TC/ALYXt
         EGluQ/23q5w0BosXnRnDUwU1LjHWjObBeqB+N8nVHTS15vmfUNAiHS81HxBXlPC89j
         wv8yig+2HUHah65cIq7idiG9P7fCUCUApZybW6CjxF+HIS3Scxz7ex8fiEpEv8XvCz
         AlfDkSBMZf0s++C9VPdu55N965rXSxYtsoU1zxeQ08Q5wAOqB0XUB5VRoZcO0yM3FO
         FiHXRwdROOiKA==
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
Subject: [PATCH 2/5] PCI: kirin: Remove unused assignments
Date:   Sun, 13 Mar 2022 14:29:30 -0500
Message-Id: <20220313192933.434746-3-helgaas@kernel.org>
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

hi3660_pcie_phy_init() assigned "pdev", but never used the value.  Drop it.

Found by Krzysztof Wilczyński <kw@linux.com> using cppcheck:

  $ cppcheck --enable=all --force
  unreadVariable drivers/pci/controller/dwc/pcie-kirin.c:336 Variable 'pdev' is assigned a value that is never used.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index fa6886d66488..5b56cedebdf1 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -332,9 +332,6 @@ static int hi3660_pcie_phy_init(struct platform_device *pdev,
 	pcie->phy_priv = phy;
 	phy->dev = dev;
 
-	/* registers */
-	pdev = container_of(dev, struct platform_device, dev);
-
 	ret = hi3660_pcie_phy_get_clk(phy);
 	if (ret)
 		return ret;
-- 
2.25.1

