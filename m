Return-Path: <linux-pci+bounces-1039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575D6813FDF
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 03:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE489B2192C
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 02:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCC181C;
	Fri, 15 Dec 2023 02:35:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437A0A4A;
	Fri, 15 Dec 2023 02:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.04,277,1695654000"; 
   d="scan'208";a="186553909"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Dec 2023 11:30:04 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D4F6B40121B3;
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
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 5/6] PCI: iproc: fix -Wvoid-pointer-to-enum-cast warning
Date: Fri, 15 Dec 2023 11:29:54 +0900
Message-Id: <20231215022955.3574063-6-yoshihiro.shimoda.uh@renesas.com>
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

From: Justin Stitt <justinstitt@google.com>

When building with clang 18 I see the following warning:
|       drivers/pci/controller/pcie-iproc-platform.c:55:15: warning: cast to smaller
|                integer type 'enum iproc_pcie_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
|          55 |         pcie->type = (enum iproc_pcie_type) of_device_get_match_data(dev);

To fix this issue, use uintptr_t instead.

Link: https://github.com/ClangBuiltLinux/linux/issues/1910
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
[shimoda: revise the commit description]
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/pcie-iproc-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
index acdc583d2980..83cbc95f4384 100644
--- a/drivers/pci/controller/pcie-iproc-platform.c
+++ b/drivers/pci/controller/pcie-iproc-platform.c
@@ -52,7 +52,7 @@ static int iproc_pltfm_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(bridge);
 
 	pcie->dev = dev;
-	pcie->type = (enum iproc_pcie_type) of_device_get_match_data(dev);
+	pcie->type = (uintptr_t) of_device_get_match_data(dev);
 
 	ret = of_address_to_resource(np, 0, &reg);
 	if (ret < 0) {
-- 
2.34.1


