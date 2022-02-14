Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802284B4E66
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 12:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347011AbiBNL2F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 06:28:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351329AbiBNL1z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 06:27:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7478B70921;
        Mon, 14 Feb 2022 03:04:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 309A0B80E19;
        Mon, 14 Feb 2022 11:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0F9C340E9;
        Mon, 14 Feb 2022 11:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644836662;
        bh=8zKQrxrSbs2sLa4lKKkzE4l1ysqU7kXTR92mFBlUseg=;
        h=From:To:Cc:Subject:Date:From;
        b=DFVNYgy4Y1EfP/LXNEojYxILPWcXVJRmdS5IQYHl0jL+yDDjDH5ZHMJtjRjPnoZtG
         ynmGqjpivDuybxbJ+Vuxafte8Q4c4EaxjtShz0d+atzK0Di2Fj9LBWfOf6i1OOJW5A
         9d7wuKgjOH3xd0+BRxnLFdhrO+bjO5FWioN1e2Q8FSC40rAYFyFIIfvBrsEn/+6gKV
         LKs7Hj2eTyYlaCMRqm+TG1b0XbDuo/z/t79ljDk4YYaxZAkPaOUWgRyGotQuV5Lati
         jzAM4VakOVZBHD2lCMd1o2u7iDcrJINvz8bCkG6Ffq3kC5jIDu8a28q9UlCslBzLU+
         DIh9gUnu1xaJA==
Received: by pali.im (Postfix)
        id EF5A4CAA; Mon, 14 Feb 2022 12:04:19 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jan Palus <jpalus@fastmail.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: mvebu: Fix merge conflicts in commit 91a8d79fc797
Date:   Mon, 14 Feb 2022 12:02:28 +0100
Message-Id: <20220214110228.25825-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 91a8d79fc797 ("PCI: mvebu: Fix configuring secondary bus of PCIe
Root Port via emulated bridge") was incorrectly applied from mailing list
patch [1] to the linux git repository [2] probably due to resolving merge
conflicts incorrectly. Fix it now.

[1] - https://lore.kernel.org/r/20211125124605.25915-12-pali@kernel.org
[2] - https://git.kernel.org/linus/91a8d79fc797

Fixes: 91a8d79fc797 ("PCI: mvebu: Fix configuring secondary bus of PCIe Root Port via emulated bridge")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215540
Reported-by: Jan Palus <jpalus@fastmail.com>
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 71258ea3d35f..f8e82c5e2d87 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1329,7 +1329,8 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		 * indirectly via kernel emulated PCI bridge driver.
 		 */
 		mvebu_pcie_setup_hw(port);
-		mvebu_pcie_set_local_dev_nr(port, 0);
+		mvebu_pcie_set_local_dev_nr(port, 1);
+		mvebu_pcie_set_local_bus_nr(port, 0);
 	}
 
 	pcie->nports = i;
-- 
2.20.1

