Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC624E7021
	for <lists+linux-pci@lfdr.de>; Fri, 25 Mar 2022 10:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357786AbiCYJk1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Mar 2022 05:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357642AbiCYJk1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Mar 2022 05:40:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34B2117D;
        Fri, 25 Mar 2022 02:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 784C2B827E9;
        Fri, 25 Mar 2022 09:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11F6C36AE7;
        Fri, 25 Mar 2022 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648201130;
        bh=vzWBAbR4Oux6P/RO30qmN2wLxTgTR+gOm30Ed6V+lZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhSjlEziOo48SqLlNz4c5nQy4SgfqAcmhBze18cOf5PV93stYk1ufN7CsMazrxAOj
         v8uIiAT43dNkCCzbGzCIx5nhCFRL1CHm5l6qDUt9x3gRAPyey8oBhPbx08rIOZzNPa
         iKVAPvWerlApLFmekUg549a2vrUzeNRTAxxiGXo2MTfvn9UMLFoXESZIUzHA65lrAl
         WKhptYcr2sfnGOZpTKuGueTtzd3XEqXYqa0ewyMxXS5eCi/LiI8DPV5wNgWQ8MnAkv
         G65ReeF0KEDGXrAp+sRq/DR5lfISWevDtgs6PVM+PHZfBloeGg44lexextdKNYr+fu
         amhmDeOm+oksw==
Received: by pali.im (Postfix)
        id 123A19F5; Fri, 25 Mar 2022 10:38:48 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] PCI: Add PCI_EXP_SLTCTL_ASPL_DISABLE macro
Date:   Fri, 25 Mar 2022 10:38:24 +0100
Message-Id: <20220325093827.4983-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325093827.4983-1-pali@kernel.org>
References: <20220325093827.4983-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add macro defining Auto Slot Power Limit Disable bit in Slot Control
Register.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/uapi/linux/pci_regs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index bee1a9ed6e66..108f8523fa04 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -616,6 +616,7 @@
 #define  PCI_EXP_SLTCTL_PWR_OFF        0x0400 /* Power Off */
 #define  PCI_EXP_SLTCTL_EIC	0x0800	/* Electromechanical Interlock Control */
 #define  PCI_EXP_SLTCTL_DLLSCE	0x1000	/* Data Link Layer State Changed Enable */
+#define  PCI_EXP_SLTCTL_ASPL_DISABLE	0x2000 /* Auto Slot Power Limit Disable */
 #define  PCI_EXP_SLTCTL_IBPD_DISABLE	0x4000 /* In-band PD disable */
 #define PCI_EXP_SLTSTA		0x1a	/* Slot Status */
 #define  PCI_EXP_SLTSTA_ABP	0x0001	/* Attention Button Pressed */
-- 
2.20.1

