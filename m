Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC613DB64D
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 11:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbhG3Juc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 05:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238089AbhG3Jub (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 05:50:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2187D60C3F;
        Fri, 30 Jul 2021 09:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627638627;
        bh=4kJwUPRKeGLBwI2WzJnMM0YnGarv+bmqdgovPFzu4EI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H/Xl/bIa/RuewzioEv8t2LEOIXG5O2cUG0QI0JbZoFtspaxFR6ktgdtiLQ2V/SyjE
         PczFwKE6XNa3CZB2QObF2Qfwl5WiD4/piCr6r+hz+LgODTrxsk8f98ZXCHj2PY4yIb
         UwuFqJNXU8mC2JOpLIVDL1k+KPcilA/Xk2eHS/gKm6RSD1yy/twmkjj0eEjtNjb4Vn
         q714yBk0f+JMLoKms/QrgDK422BCr9D51DrXHM+qazuwWBtbyY6bGKLGUTMGTD/exV
         6Ppw4r9m4j72oSvhfA1XFAjcg4CexSWbewWTVyOvNz8D9hJdjspntuj7cP+n6nGTDZ
         NcFRdplmMcshg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m9P9t-006s4E-Ce; Fri, 30 Jul 2021 11:50:25 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v8 06/11] PCI: kirin: Add Kirin 970 compatible
Date:   Fri, 30 Jul 2021 11:50:09 +0200
Message-Id: <85a48b47aa04060e8d5481385bc9c3123386c755.1627637745.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627637745.git.mchehab+huawei@kernel.org>
References: <cover.1627637745.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that everything is in place, add a compatible for Kirin 970.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index d5967cd227b6..b5f3ff543339 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -741,6 +741,10 @@ static const struct of_device_id kirin_pcie_match[] = {
 		.compatible = "hisilicon,kirin960-pcie",
 		.data = (void *)PCIE_KIRIN_INTERNAL_PHY
 	},
+	{
+		.compatible = "hisilicon,kirin970-pcie",
+		.data = (void *)PCIE_KIRIN_EXTERNAL_PHY
+	},
 	{},
 };
 
-- 
2.31.1

