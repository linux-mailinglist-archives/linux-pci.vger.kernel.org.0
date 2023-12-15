Return-Path: <linux-pci+bounces-1040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90934813FDE
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 03:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D53D282DD6
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 02:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C41E10E1;
	Fri, 15 Dec 2023 02:35:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77736A4C;
	Fri, 15 Dec 2023 02:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.04,277,1695654000"; 
   d="scan'208";a="190428764"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Dec 2023 11:30:05 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0181A40121AE;
	Fri, 15 Dec 2023 11:30:04 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com,
	mani@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 6/6] PCI: rcar-gen4: fix -Wvoid-pointer-to-enum-cast warning
Date: Fri, 15 Dec 2023 11:29:55 +0900
Message-Id: <20231215022955.3574063-7-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215022955.3574063-1-yoshihiro.shimoda.uh@renesas.com>
References: <20231215022955.3574063-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building with clang 18 with adding -Wvoid-pointer-to-enum-cast,
the following error happens:

drivers/pci/controller/dwc/pcie-rcar-gen4.c:439:15: error: cast to smaller integer type 'enum dw_pcie_device_mode' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
  439 |         rcar->mode = (enum dw_pcie_device_mode)of_device_get_match_data(&rcar->pdev->dev);
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
To fix this issue, use uintptr_t instead.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 70492f562e48..a1eb10e878f1 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -436,7 +436,7 @@ static void rcar_gen4_remove_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
 /* Common */
 static int rcar_gen4_add_dw_pcie(struct rcar_gen4_pcie *rcar)
 {
-	rcar->mode = (enum dw_pcie_device_mode)of_device_get_match_data(&rcar->pdev->dev);
+	rcar->mode = (uintptr_t)of_device_get_match_data(&rcar->pdev->dev);
 
 	switch (rcar->mode) {
 	case DW_PCIE_RC_TYPE:
-- 
2.34.1


