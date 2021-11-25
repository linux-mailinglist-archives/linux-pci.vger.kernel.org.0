Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C06945DA4F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 13:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350512AbhKYMvv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 07:51:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347848AbhKYMtq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 07:49:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14572610FB;
        Thu, 25 Nov 2021 12:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637844395;
        bh=V49Dl6I3ETYyBXCva0Ab5YRCPF20sbpwGL5aEs5sgZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kvm31VUlPXoPnaVkKfH4RfPkFELOCasP8eM7ZRiPWKDrUYF7fe5tvMMhhoU+fzDiL
         7SzZkIR9yvX9tPU7K3+kjN21luO04b9pUjXPL5Cw7ylhZOaGVHSIlqrLL8z4kC744P
         5N1xI0mTznUKsgoDU6uyKayGJmQqqdWNSaQD9oOqNTZHMXhEKygg/PmVSu9R1yhrIa
         86E47HhNcRElH1tekn2OEFdJav3JxOh0pctuDBBBaF6lY/oxwLRcqFSVQb1Rx86Uqj
         t9PNgSBTw2pKnN768RVJIz5Y/1Ag84yCWZdkqzRhRE+KelYvIrbd2DfTeFXTJ5JGof
         To1vc5sTxiVaA==
Received: by pali.im (Postfix)
        id 6C55467E; Thu, 25 Nov 2021 13:46:34 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] PCI: mvebu: Handle invalid size of read config request
Date:   Thu, 25 Nov 2021 13:45:54 +0100
Message-Id: <20211125124605.25915-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125124605.25915-1-pali@kernel.org>
References: <20211125124605.25915-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Function mvebu_pcie_hw_rd_conf() does not handle invalid size. So correctly
set read value to all-ones and return appropriate error return value
PCIBIOS_BAD_REGISTER_NUMBER like in mvebu_pcie_hw_wr_conf() function.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-mvebu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 08274132cdfb..19c6ee298442 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -261,6 +261,9 @@ static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
 	case 4:
 		*val = readl_relaxed(conf_data);
 		break;
+	default:
+		*val = 0xffffffff;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
 	return PCIBIOS_SUCCESSFUL;
-- 
2.20.1

