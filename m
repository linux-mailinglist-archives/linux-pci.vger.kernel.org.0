Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01CD3D25F3
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 16:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhGVOAM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 10:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232429AbhGVOAL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 10:00:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C66056128C;
        Thu, 22 Jul 2021 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626964846;
        bh=5i956wmocYZv/fXWLyy+L9k7cUXLx3EZOFVHb1Ot4MQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DiE6QIOCVuO+WT+Yye7PVSzICtVMmecpOXl0uCEe7x+4ITML7aez+uh7VV+3sGRrs
         NrwOVUBtFFaBI/9m08Gh6nHg0wRhi6A8SZqyzijM/hVla0gv5VGGLQpFBFdRZu/ri0
         5yGEGK4u0Ql4nKUxhEVwMHuavGpyTeWwDBSD2Oz8wSOwCQMp1TtVdptU6eFqmFv2Rm
         R4sOgOBjdkQnAnpXVyYegOd6N2GM8b4EiMGGIuJtZ0UPRv9+/tKVr4WdnMJMyuHV4s
         iEJei+tkZdfJynRmtXvAFs0ZX24Trzkws3T9oAeK/6sK0aGCsOwERrDlRnFup8QOYo
         PKhrlm4O3uN1Q==
Received: by pali.im (Postfix)
        id 01D9E13D6; Thu, 22 Jul 2021 16:40:44 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] PCI: pci-bridge-emul: Add PCIe Root Capabilities Register
Date:   Thu, 22 Jul 2021 16:40:40 +0200
Message-Id: <20210722144041.12661-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210722144041.12661-1-pali@kernel.org>
References: <20210624213345.3617-1-pali@kernel.org>
 <20210722144041.12661-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The 16-bit Root Capabilities register is at offset 0x1e in the PCIe
Capability. Rename current 'rsvd' struct member to 'rootcap'.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/pci-bridge-emul.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.h
index b31883022a8e..49bbd37ee318 100644
--- a/drivers/pci/pci-bridge-emul.h
+++ b/drivers/pci/pci-bridge-emul.h
@@ -54,7 +54,7 @@ struct pci_bridge_emul_pcie_conf {
 	__le16 slotctl;
 	__le16 slotsta;
 	__le16 rootctl;
-	__le16 rsvd;
+	__le16 rootcap;
 	__le32 rootsta;
 	__le32 devcap2;
 	__le16 devctl2;
-- 
2.20.1

