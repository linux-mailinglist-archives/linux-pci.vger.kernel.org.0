Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741E34844DC
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 16:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiADPiu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 10:38:50 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:39720 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiADPie (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 10:38:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DC71ACE1804;
        Tue,  4 Jan 2022 15:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE12C36AED;
        Tue,  4 Jan 2022 15:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641310711;
        bh=uG8b6cgDUIxA5J6r1/yrflQam4I3mKXv7eeo14u0x7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvjrDICeVUGx6VykznQC5Oic9ATMkvTaZ4VFqY+ekiAxw53IkUiLQ710i6ISZ02C5
         sqs0bfd5++kAlQV9mjjrY0x13WXuuVQdU+jZ1Yek6sRNHTINW6ekl/uzY+9X1XEc8R
         WCjqEel8Nc9+13qi3tEl/bpeuw6DCwDhThCr1oDmzrGErmuxRsteBvLBkKzD/lfB2v
         61ufPHQun/aNCEfyb9f8ozfcCZc5L1GcLBQy+wDJ5iXBJPpLq7+SmjY3rNxwUoG9rN
         zzYx8KJH32JaNUcP7kQiiFXQWWtl5J07yZmTFkviqvBqvhhBSfQPrkReI7STS8tls9
         UdEglEOXk0wvg==
Received: by pali.im (Postfix)
        id C442396B; Tue,  4 Jan 2022 16:38:30 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/11] PCI: mvebu: Update comment for PCI_EXP_LNKCAP register on emulated bridge
Date:   Tue,  4 Jan 2022 16:35:27 +0100
Message-Id: <20220104153529.31647-10-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220104153529.31647-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
 <20220104153529.31647-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reason for clearing this bit is because mvebu hw returns incorrectly this bit set to 1.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 94ef00b6d697..1aac65977b97 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -546,8 +546,8 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 
 	case PCI_EXP_LNKCAP:
 		/*
-		 * PCIe requires the clock power management capability to be
-		 * hard-wired to zero for downstream ports
+		 * PCIe requires that the Clock Power Management capability bit
+		 * is hard-wired to zero for downstream ports but HW returns 1.
 		 */
 		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP) &
 			 ~PCI_EXP_LNKCAP_CLKPM;
-- 
2.20.1

