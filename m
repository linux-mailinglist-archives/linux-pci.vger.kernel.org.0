Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBB24FC477
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 21:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349302AbiDKTDi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 15:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349276AbiDKTDh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 15:03:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A003205D;
        Mon, 11 Apr 2022 12:01:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E12AB81868;
        Mon, 11 Apr 2022 19:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B2CC385AB;
        Mon, 11 Apr 2022 19:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649703679;
        bh=vzWBAbR4Oux6P/RO30qmN2wLxTgTR+gOm30Ed6V+lZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHuJekjx19FT/keE+1R4DIQ8Jz+1gcHqZg2/bAuB0klme4/BrBu5vC2iXC/NfOXDg
         JBoF4xKgt0TzFP/tFB4bQ0Ak4oeU0pPCfz34QVPveLP0s95Nocz1kQZZ+Haocp6dPx
         CKqeDjrj6ZmgjapVsRdg4SzzU+rnsMZUz9okzAgnVilQfmJRToW9IQF+c7LwVw0aHx
         sWVb6HhXD64MtEqx8m8MN7rkpW5HkuL+K4Anznshau3Ywo7H9M4fsTD1IoN6kPwQ2s
         O3hML44BT2xloOIYtIGJBLvd8u34dBo0EOqm7rDq+cVC1nCFDnV5RYf+tHPXR4VZxu
         WQYP6xdK6EOdg==
Received: by pali.im (Postfix)
        id 63E4A9F9; Mon, 11 Apr 2022 21:01:16 +0200 (CEST)
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
Subject: [PATCH v4 1/4] PCI: Add PCI_EXP_SLTCTL_ASPL_DISABLE macro
Date:   Mon, 11 Apr 2022 20:58:56 +0200
Message-Id: <20220411185859.32722-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220411185859.32722-1-pali@kernel.org>
References: <20220411185859.32722-1-pali@kernel.org>
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

