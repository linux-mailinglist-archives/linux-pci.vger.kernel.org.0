Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F1E375762
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhEFPff (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235690AbhEFPdx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0526E61469;
        Thu,  6 May 2021 15:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315174;
        bh=zi+PML1cWSulO/GYWf9yak7a3W+RSD4MegJIQ/xyX/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EqDJhLO1Hbf8GkvCKJD0Nzd3ZOEPegQ4Ex2n1YeJtatlQl6Tr4bvmFR9YYqpgSfqb
         BX4/PEJZLywUrkQrde7yaSPg/j5lrsNr8UlJ44x1jVDO5GS4GPG+/eJo+sGYb+OKro
         GQHHh13UH+UCZ2TOlXFdq696tTnU9DaAsE3hhTnwH33W047YxWZ2ZixmzjtoF4AoqO
         N7q6gFcsJOkOEEnUjLywFP7y/SJT+kIm4jDnurpRFmXqfb9+XYfe2YcR6Z/vsTru6I
         lz+ngyp3uxxpZmbe5h7lWGZT1u1XE1WJLPaklxoistVSrSAkZsUXFwxF7xmFgyJC2U
         GtL62ZeX3tDUA==
Received: by pali.im (Postfix)
        id B509A8A1; Thu,  6 May 2021 17:32:53 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 32/42] PCI: pci-bridge-emul: Add description for class_revision field
Date:   Thu,  6 May 2021 17:31:43 +0200
Message-Id: <20210506153153.30454-33-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make it clear why there is bitshift by 16 and rewrite the code to align
with the new description.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/pci-bridge-emul.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index fdaf86a888b7..2b6ea84f25af 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -265,7 +265,11 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
 {
 	BUILD_BUG_ON(sizeof(bridge->conf) != PCI_BRIDGE_CONF_END);
 
-	bridge->conf.class_revision |= cpu_to_le32(PCI_CLASS_BRIDGE_PCI << 16);
+	/*
+	 * class_revision: Class is high 24bits and revision is low 8bit
+	 * Class for PCI Bridge Normal Decode has 24bit value (PCI_CLASS_BRIDGE_PCI << 8)
+	 */
+	bridge->conf.class_revision |= cpu_to_le32((PCI_CLASS_BRIDGE_PCI << 8) << 8);
 	bridge->conf.header_type = PCI_HEADER_TYPE_BRIDGE;
 	bridge->conf.cache_line_size = 0x10;
 	bridge->conf.status = cpu_to_le16(PCI_STATUS_CAP_LIST);
-- 
2.20.1

