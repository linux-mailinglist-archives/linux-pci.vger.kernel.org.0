Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E25F4BD0FF
	for <lists+linux-pci@lfdr.de>; Sun, 20 Feb 2022 20:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244637AbiBTTec (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Feb 2022 14:34:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244644AbiBTTeb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Feb 2022 14:34:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684AC522F0
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 11:34:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 203B1B80DBE
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 19:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09320C340F0;
        Sun, 20 Feb 2022 19:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645385647;
        bh=USBvD9DLVLa0KR+5ZLhHC1ELluxCbJ4w9lcGPdn0AU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJvjTbUR00QN1rQNyJHhLAo9fTawvaevOB6eBhO1uMOONaAONNo8DAGi1Kxva1wiO
         N5V3Q2QirT9sCQ6xB2jRSnLf8Tga1FNMm/vcBznJhpeLHKIDD+qFCy4hDnLIlXkkIu
         999t9G85C7vL9q+YSxyepGI/qD3iWk9XN+YcUskgcn4Xhn9O9pWsF1iSfITZEiDxSK
         5W7yvh/SUdIQU/xL6C/qDDPP6lfDKO2e6zO5KHt0Fk8GOfm1q0yyjERRzarO/jsZnI
         eJ2bdIK95sMkE5Ctsu7gu+Bbuqf/adW9Kk7z2bzobs4MfBsw/IMWVsiUyTieXUJXCC
         YG7SnxlP9XFvw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 07/18] PCI: pciehp: Enable Command Completed Interrupt only if supported
Date:   Sun, 20 Feb 2022 20:33:35 +0100
Message-Id: <20220220193346.23789-8-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220193346.23789-1-kabel@kernel.org>
References: <20220220193346.23789-1-kabel@kernel.org>
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

Enable this interrupt only in the case it is supported.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
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
2.34.1

