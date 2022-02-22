Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8779B4BFEAC
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 17:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbiBVQdD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 11:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbiBVQcp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 11:32:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC7E9F6D6;
        Tue, 22 Feb 2022 08:32:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A5CF60AD5;
        Tue, 22 Feb 2022 16:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B707C340E8;
        Tue, 22 Feb 2022 16:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645547538;
        bh=noZwsblHcDT7C+RKpR6Tj+jb4VJ1dFTmYgUlTlh8XV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HXUBB+00deAcDdVfq5zGiYf6j01m4wW4P/Oo9MJhonsuF3gUg0koxUbHu1sHN2ML9
         tddeFqUnlNXfZZcahUFGkvnoIHGaGJ4ZJ9xNxjED0cViMt6LQ1DV+60g5k0ZV/Uu4I
         NF2HAJw8rsEXaSQGvfgvBEi/fEImPEmLVh7f1bIlYONrbgItwlJC6Yfu/E3VOfRh3D
         A6DEcCwDuU6GN4jxLcDI7krzyOCJdnZQpqS7h6sLXf0E1JYL+4lXyIFSBQN4L5eD+a
         fN6ZIR+tNFcUt0Kr1NDbeo1PfyC0fwiyMdUpp4zxZM10juwHGMNrPrjseYbxUOdp5L
         WCr59kLpYlpiw==
Received: by pali.im (Postfix)
        id 45C923FAC; Tue, 22 Feb 2022 17:32:16 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] PCI: Add PCI_EXP_SLTCAP_*_SHIFT macros
Date:   Tue, 22 Feb 2022 17:31:54 +0100
Message-Id: <20220222163158.1666-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220222163158.1666-1-pali@kernel.org>
References: <20220222163158.1666-1-pali@kernel.org>
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

These macros allows to easily compose and extract Slot Power Limit and
Physical Slot Number values from Slot Capability Register.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 include/uapi/linux/pci_regs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 108f8523fa04..3fc9a4cac630 100644
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
2.20.1

