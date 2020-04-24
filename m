Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2491B7A18
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 17:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgDXPjV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 11:39:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728563AbgDXPjU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 11:39:20 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A40462084D;
        Fri, 24 Apr 2020 15:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587742759;
        bh=o2G1fhO9mfnDxsTYV4mQJ3o5E7ZbLZJaB4mk12TAxv8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=F/fqTaOfxUobMJfy57HVQDrHukVVqZb7pbnFpsEneqJacKiXoNxxD5s3dOIiJg40m
         UxPWZF8ZC0vOJtq7B5+TQ6SF3XM6Ahymazp5pnAeVHk6QOCrWq/4ELVI4ASHTNzDzI
         V/AAmnHlFeawGA7LdAH7AJviOx4PY9qYNcVqMmUU=
Received: by pali.im (Postfix)
        id D0DD682E; Fri, 24 Apr 2020 17:39:17 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v3 06/12] PCI: aardvark: Add FIXME comment for PCIE_CORE_CMD_STATUS_REG access
Date:   Fri, 24 Apr 2020 17:38:52 +0200
Message-Id: <20200424153858.29744-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424153858.29744-1-pali@kernel.org>
References: <20200424153858.29744-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This register is applicable only when the controller is configured for
Endpoint mode, which is not the case for the current version of this
driver.

Attempting to remove this code though caused some ath10k cards to stop
working, so for some unknown reason it is needed here.

This should be investigated and a comment explaining this should be put
before the code, so we add a FIXME comment for now.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 9e2f44213b5e..8e1f61d82c21 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -439,6 +439,13 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 
 	advk_pcie_train_link(pcie);
 
+	/*
+	 * FIXME: The following register update is suspicious. This register is
+	 * applicable only when the PCI controller is configured for Endpoint
+	 * mode, not as a Root Complex. But apparently when this code is
+	 * removed, some cards stop working. This should be investigated and
+	 * a comment explaining this should be put here.
+	 */
 	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
 	reg |= PCIE_CORE_CMD_MEM_ACCESS_EN |
 		PCIE_CORE_CMD_IO_ACCESS_EN |
-- 
2.20.1

