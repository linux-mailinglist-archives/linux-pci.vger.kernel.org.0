Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1035EC5CC
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 16:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiI0OTm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 10:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiI0OTi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 10:19:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109B013F25
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 07:19:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D8F8619EB
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 14:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD79C43141;
        Tue, 27 Sep 2022 14:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664288373;
        bh=OrKVJXEi8szo1hPh5xE6W+Cneq3FaibL95qCVvytrFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YpJLk43vHbkknbA/vtQbI3ZuQm6v/TldSs1KjQZlrFo25LJ63yd1wMNBr4hBFSYKy
         FoXeWNidnQwlea00LyNoSnOxiMgyLUSaQlOIXBMSZQ1DYNcsmHPgt1ecMyQTDVE7wO
         G1G3w0Jm/PQ6c8gVZqF7NHRGwV9rDjx22+Ctfvo8ypJiuh93IGgsuBVMdTXUKmrcOQ
         Ojzcf6FbewhvBf3rVYm2AW1HmllUFku9Kcf4hDF3dr649hb66UExASF64g+Dh+kAav
         gPztCPPhmmnbOBpN9cL01jXo0hxXxcvsP0tHWPEnHNfBSF7TWQWU8+0SIMkeJMQJ6h
         gvDgYiJ1UcKAw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>, pali@kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v2 01/10] PCI: pciehp: Enable Command Completed Interrupt only if supported
Date:   Tue, 27 Sep 2022 16:19:17 +0200
Message-Id: <20220927141926.8895-2-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927141926.8895-1-kabel@kernel.org>
References: <20220927141926.8895-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

The No Command Completed Support bit in the Slot Capabilities register
indicates whether Command Completed Interrupt Enable is unsupported.

We already check whether No Command Completed Support bit is set in
pcie_wait_cmd(), and do not wait in this case.

Let's not enable this Command Completed Interrupt at all if NCCS is set,
so that when users dump configuration space from userspace, the dump
does not confuse them by saying that Command Completed Interrupt is not
supported, but it is enabled.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_hpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 040ae076ec0e..10e9670eea0b 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -811,7 +811,9 @@ static void pcie_enable_notification(struct controller *ctrl)
 	else
 		cmd |= PCI_EXP_SLTCTL_PDCE;
 	if (!pciehp_poll_mode)
-		cmd |= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE;
+		cmd |= PCI_EXP_SLTCTL_HPIE;
+	if (!pciehp_poll_mode && !NO_CMD_CMPL(ctrl))
+		cmd |= PCI_EXP_SLTCTL_CCIE;
 
 	mask = (PCI_EXP_SLTCTL_PDCE | PCI_EXP_SLTCTL_ABPE |
 		PCI_EXP_SLTCTL_PFDE |
-- 
2.35.1

