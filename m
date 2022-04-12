Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA33D4FDD30
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 13:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiDLK6z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 06:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377249AbiDLK43 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 06:56:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693B18FE4C;
        Tue, 12 Apr 2022 02:50:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F035C60BC8;
        Tue, 12 Apr 2022 09:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39744C385A8;
        Tue, 12 Apr 2022 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649757030;
        bh=vzWBAbR4Oux6P/RO30qmN2wLxTgTR+gOm30Ed6V+lZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IlSS1wmFKrWzkfJi4hldavcKISvxjfNC+VXxqhdNioR67UER5LhU1AAwVB0tbvlvq
         mnj+pv5tER0pKEBnvdr6hFBBBmW1I1Z8QnlISWvKeiVybuabAYtcnxWYy+oq1h4GhF
         Sg+FA+pB1xRO4S5fUfp7NKll8iY3fCfurs+ji78M+NbH9rdTb2PRlmgCmCL7wdi1rv
         F3OaMOm9BFdhM07XH5oQe4QkOp5vgnrr5oXAg+6yOSpF5f72B5y/YOHAhsgUIn/chz
         UnklEes3OVA89erBB/kCg9Dnp6+JDv1XHVlA+JGLDlsD67sgI+oePSR94CzXbEHxmL
         4IqDnvutV1j9g==
Received: by pali.im (Postfix)
        id D3C492AB2; Tue, 12 Apr 2022 11:50:27 +0200 (CEST)
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
Subject: [PATCH v5 1/4] PCI: Add PCI_EXP_SLTCTL_ASPL_DISABLE macro
Date:   Tue, 12 Apr 2022 11:49:43 +0200
Message-Id: <20220412094946.27069-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220412094946.27069-1-pali@kernel.org>
References: <20220412094946.27069-1-pali@kernel.org>
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

