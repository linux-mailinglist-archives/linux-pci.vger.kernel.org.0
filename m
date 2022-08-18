Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD035984B7
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 15:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244720AbiHRNvx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 09:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245059AbiHRNvw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 09:51:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ED2606BF
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 06:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64A37B8218F
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 13:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D13AC43470;
        Thu, 18 Aug 2022 13:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660830709;
        bh=C2D3Jj4PCvtjMZxe3v8o6HA9+SpgibNASF4uxV6GlWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I+w0ABLf/nmw/TzhnhwhryYvr9P7ecUwG2oa/2kO2pw8fYBClPt27lOIgtra1q2Bj
         64lmFqYVUkOrnr6XujLONoa0XHuTUU7lTTaZM5SJ+CPmkQYlmtW5juiUJ9peXQ5x+C
         RcIT+NWTY1Yz5grVTzC3Ades2TS/THY985cTq/W0GDt54qEmJYsWH79t1RL8Y/t8Lv
         6RX2fWsaiV56joBzLX52jxZKXbuarRMxXAzpleF2Xtf6vuV0G8T/oc+r/ODuBdaL6a
         Xf32Fls9Md9pg1eZOLoTuaEbxunie8a/HforQU8c/EGye/l7M5b3Z+E1aj/lsT+BDG
         NxezwjkdqUggQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 02/11] PCI: pciehp: Enable Command Completed Interrupt only if supported
Date:   Thu, 18 Aug 2022 15:51:31 +0200
Message-Id: <20220818135140.5996-3-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818135140.5996-1-kabel@kernel.org>
References: <20220818135140.5996-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
---
Changes since batch 5:
- changed commit message, previously we wrote that the change is needed
  to fix a bug where kernel was waiting for an event which did not
  come. This turns out to be false. See
  https://lore.kernel.org/linux-pci/20220818142243.4c046c59@dellmb/T/#u
---
 drivers/pci/hotplug/pciehp_hpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 373bb396fe22..838eb6cc3ec7 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -817,7 +817,9 @@ static void pcie_enable_notification(struct controller *ctrl)
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

