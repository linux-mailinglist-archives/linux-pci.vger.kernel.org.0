Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1368C5F4DF6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Oct 2022 04:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiJEC6Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Oct 2022 22:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJEC6W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Oct 2022 22:58:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB12F4D157;
        Tue,  4 Oct 2022 19:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66DF46155E;
        Wed,  5 Oct 2022 02:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3362C433C1;
        Wed,  5 Oct 2022 02:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664938700;
        bh=mm3PVLnR7PvroJVH9u2FBC+N86N77tt3CLlFz8nWPPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cjC66djVUDVZ0t1wvPPUUGyJmVjoDpSgX+tXRrWJgu8b6BFhxE7AZ61Z4C0q/JFX2
         Wzfs5jNwwEJxB+VNn6IlL4GYG8BO5WufIgq06xW0HLPsueLKARgIrypyNkOMoptvKn
         ay7/ndRENbmXyGeMfzGU2oi7rr72BPiR5NnzSMwbBrUI+0StvFgjJZPSZsdGIba3D7
         RflUzcTHEK+3ls/EULzG1t/i5wtsO05/AnWC06bx5i5C6YY1gVGme9poB18xeS3Od5
         5iXpJBIq+wIIn+MehFendTxSrGHe6WXfKNBnADx/zFGGAf2MOg9tRq7CQ5yVg4FrW5
         RMpL0+Yr5OaXg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        "Saheed O . Bolarinwa" <refactormyself@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        "Kenneth R . Crudup" <kenny@panix.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Vidya Sagar <sagar.tv@gmail.com>, sagupta@nvidia.com,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/3] PCI/ASPM: Ignore L1 PM Substates if device lacks capability
Date:   Tue,  4 Oct 2022 21:58:08 -0500
Message-Id: <20221005025809.2247547-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005025809.2247547-1-helgaas@kernel.org>
References: <20221005025809.2247547-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

187f91db8237 ("PCI/ASPM: Remove struct aspm_register_info.l1ss_cap")
inadvertently removed a check for existence of the L1 PM Substates (L1SS)
Capability before reading it.

If there is no L1SS Capability, this means we mistakenly read PCI_COMMAND
and PCI_STATUS (config address 0x04) and interpret that as the PCI_L1SS_CAP
register, so we may incorrectly configure L1SS.

Make sure the L1SS Capability exists before trying to read it.

Fixes: 187f91db8237 ("PCI/ASPM: Remove struct aspm_register_info.l1ss_cap")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 4535228e4a64..f12d117f44e0 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -560,6 +560,9 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
 	u32 parent_l1ss_cap, child_l1ss_cap;
 	u32 parent_l1ss_ctl1 = 0, child_l1ss_ctl1 = 0;
 
+	if (!parent->l1ss || !child->l1ss)
+		return;
+
 	/* Setup L1 substate */
 	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CAP,
 			      &parent_l1ss_cap);
-- 
2.25.1

