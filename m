Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5CB47C1F9
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 15:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbhLUO4w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 09:56:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38040 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238696AbhLUO4u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 09:56:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C523B8171F;
        Tue, 21 Dec 2021 14:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDB9C36AE9;
        Tue, 21 Dec 2021 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640098607;
        bh=xxyZnGOuH63mToYeFJtMrqvVZxip4BN1x7ap3lhZeHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=idtSM6rMG+OrXmXorvmrw2fZYYLnc+eEStSm/wS7s1kslRoLHbzSL6Sty8lOYWrnq
         L6ET6iT/H+SBW6t2KdOrIqQI2Ne6+WU4s5sKaZF03lRZD3BfxbacrSlD2vLtd0/SR6
         YdB5MWPvwMBivOufHymMy83vf27qs9XjPseSXHzaB7T/wGzBq8+ndkeJPoQk8qZpzB
         fqNdiCauJAN3khpLKyNQAq0vmA6G/N13omI+xyLEGV7Uk3J3S5CkW+FVscRVcQ4BHx
         0GVWk2kO30/4Zk8SFBLQB7+KOSPx63p4TlkwGzQTosuG5SxLqPVKbaukSpjhQ9Aon4
         l0uPHjpF1C3Ag==
Received: by pali.im (Postfix)
        id AAFD62ABF; Tue, 21 Dec 2021 15:18:16 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] PCI: mvebu: Update comment for PCI_EXP_LNKCTL register on emulated bridge
Date:   Tue, 21 Dec 2021 15:14:54 +0100
Message-Id: <20211221141455.30011-11-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211221141455.30011-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Logic and code for clearing PCI_EXP_LNKCTL_CLKREQ_EN bit is correct, but
comment describing it is misleading. PCI_EXP_LNKCTL_CLKREQ_EN bit should be
hardwired to zero but mvebu hw allows to change it.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 1aac65977b97..dffa330de174 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -663,10 +663,9 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 
 	case PCI_EXP_LNKCTL:
 		/*
-		 * If we don't support CLKREQ, we must ensure that the
-		 * CLKREQ enable bit always reads zero.  Since we haven't
-		 * had this capability, and it's dependent on board wiring,
-		 * disable it for the time being.
+		 * PCIe requires that the Enable Clock Power Management bit
+		 * is hard-wired to zero for downstream ports but HW allows
+		 * to change it.
 		 */
 		new &= ~PCI_EXP_LNKCTL_CLKREQ_EN;
 
-- 
2.20.1

