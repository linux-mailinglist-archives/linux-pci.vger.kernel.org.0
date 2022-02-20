Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC384BD0FD
	for <lists+linux-pci@lfdr.de>; Sun, 20 Feb 2022 20:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244630AbiBTTeY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Feb 2022 14:34:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244638AbiBTTeX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Feb 2022 14:34:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18244507B
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 11:34:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DF0F60EEA
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 19:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044FDC340F0;
        Sun, 20 Feb 2022 19:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645385640;
        bh=x6E3D82tqL8Ev1zPGRI/lFqMDrlznXp6H35OeL2E27Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8UDTcco8ZCyUNIJx27v+4gXNzR74zpi5CpSw1tPEF9t5MojKTsX3fRoRABWpYh14
         73gRtBxWnU+YMiTCaA0NhoPlAV7hoGRA6FxZdISIoAhA68uhqq6iP/Vpge2/OIcglM
         WZvMpPmkdX6Ko5e5RgpC+tJ7ipXT2vOBj44UOswTe3NliAvtScdxODG85l+3/Y7FRl
         U6IWtk+Iqz8W3J3kMww9rgmHuvLpmUtDKkUT31hxQMuWhFXc89cMscp0oYYm4H4P2m
         KoMzYOg//qMBih/JpL3uavsBtw64tr82TywEf0hRGE8zThbrxfUP8E/qGBRGwt69Zq
         ah/pz/jk1rq2Q==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 04/18] PCI: Add PCI_EXP_SLTCAP_*_SHIFT macros
Date:   Sun, 20 Feb 2022 20:33:32 +0100
Message-Id: <20220220193346.23789-5-kabel@kernel.org>
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

These macros allows to easily compose and extract Slot Power Limit and
Physical Slot Number values from Slot Capability Register.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 include/uapi/linux/pci_regs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index bee1a9ed6e66..d825e17e448c 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -591,10 +591,13 @@
 #define  PCI_EXP_SLTCAP_HPS	0x00000020 /* Hot-Plug Surprise */
 #define  PCI_EXP_SLTCAP_HPC	0x00000040 /* Hot-Plug Capable */
 #define  PCI_EXP_SLTCAP_SPLV	0x00007f80 /* Slot Power Limit Value */
+#define  PCI_EXP_SLTCAP_SPLV_SHIFT	7  /* Slot Power Limit Value shift */
 #define  PCI_EXP_SLTCAP_SPLS	0x00018000 /* Slot Power Limit Scale */
+#define  PCI_EXP_SLTCAP_SPLS_SHIFT	15 /* Slot Power Limit Scale shift */
 #define  PCI_EXP_SLTCAP_EIP	0x00020000 /* Electromechanical Interlock Present */
 #define  PCI_EXP_SLTCAP_NCCS	0x00040000 /* No Command Completed Support */
 #define  PCI_EXP_SLTCAP_PSN	0xfff80000 /* Physical Slot Number */
+#define  PCI_EXP_SLTCAP_PSN_SHIFT	19 /* Physical Slot Number shift */
 #define PCI_EXP_SLTCTL		0x18	/* Slot Control */
 #define  PCI_EXP_SLTCTL_ABPE	0x0001	/* Attention Button Pressed Enable */
 #define  PCI_EXP_SLTCTL_PFDE	0x0002	/* Power Fault Detected Enable */
-- 
2.34.1

