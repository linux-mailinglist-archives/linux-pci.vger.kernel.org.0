Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EEB1EA461
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jun 2020 15:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgFANDl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 09:03:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbgFANDl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jun 2020 09:03:41 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87BFE2068D;
        Mon,  1 Jun 2020 13:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591016620;
        bh=3xN+KUHay1UXrM2e/q9Ewz774/uNEpSlG4BqrojgmRI=;
        h=From:To:Cc:Subject:Date:From;
        b=IqMBJBhQg9sgMy1Kj9AZ4jYM8Ip+nSuoT3fd6gBMgEx80FyJItuwxsBcoenoDpY15
         VOIxthju/gClsXmTLYHVrge9bc6iuzuFZmvQFnjq28zVFeYWP6rMrt1sXlnyOhrIDs
         WBGXWie/++Uuu/wovmm60x9u68QpuN24q8oiSnw8=
Received: by pali.im (Postfix)
        id BA9BDCB0; Mon,  1 Jun 2020 15:03:38 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: aardvark: Indicate error in 'val' when config read fails
Date:   Mon,  1 Jun 2020 15:03:15 +0200
Message-Id: <20200601130315.18895-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Most callers of config read do not check for return value. But most of the
ones that do, checks for error indication in 'val' variable.

This patch updates error handling in advk_pcie_rd_conf() function. If PIO
transfer fails then 'val' variable is set to 0xffffffff which indicates
failture.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 53a4cfd7d377..783a7f1f2c44 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -691,8 +691,10 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	advk_writel(pcie, 1, PIO_START);
 
 	ret = advk_pcie_wait_pio(pcie);
-	if (ret < 0)
+	if (ret < 0) {
+		*val = 0xffffffff;
 		return PCIBIOS_SET_FAILED;
+	}
 
 	advk_pcie_check_pio_status(pcie);
 
-- 
2.20.1

