Return-Path: <linux-pci+bounces-27142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216A6AA8F92
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 11:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0914F3BA436
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 09:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BC0202978;
	Mon,  5 May 2025 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oed7o53S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586E81FA15E
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437192; cv=none; b=tefMCdedEUKhQZsSGSQgu3Da0zhN/hl/MnwV2r00qm+1+jhlon3OV8xaV1TMSzeq4GP4zjFN1xy8O+1zsRrd9bC247hRFuJx2fGap4AHhW+WZdSaeoiw3vPRk1n3A2WgUKb/5UFTVt2i4d3d95IJ3xiYOCnh1/mb/zZstMi1toc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437192; c=relaxed/simple;
	bh=/qLNq6Ah1zBhiF3Gu9j00ITANtVDvo/o2g4ubZb++T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfJ/6Nvl3qJLLb6f0rzfvdVtXElGSkyLyphtYWjuSUiQceMnwA2ga2LAYsxsKNvINqHTeGF/z3QQQqqHevrflBJSkiJGeCkbW2sbvTsa48wWUoKhhGoCQ3pDEP5L6EuiBpUzp0THl5QWMNflXPbQcHD1cJp7GTwu9mAALbpgPgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oed7o53S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47554C4CEE4;
	Mon,  5 May 2025 09:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746437191;
	bh=/qLNq6Ah1zBhiF3Gu9j00ITANtVDvo/o2g4ubZb++T8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oed7o53SNZOICzTHjIxx3lU/LvGYFJSyr3zk4Mm0uKsC58q/g6J4bYRrpUyCFOGky
	 u+Dsk4KFA95NJqhONAYYx9429ML72bWY3XEw0QbltdI4UVM4Yegq+o2wA8YydeLgmT
	 PN4UWCSHMFxhwBSKTva1sLQzRtARDcLKvqZz+Yj0b+D1ogZ68AJ9/NiOQj8BmKjZoG
	 1TfcqheXj8x3V/AM4O1BiBNsYtjfrdq/iwuUyfNmSe8KMjjdC7G5QVlfEbJGjgHxHa
	 qy257ZXQIk4i5u+Xb510UleDEuDktjrAbEovYSroIMFgdh70crsPfzauh+a0K9Qkwt
	 VF+ukSPwCUQcg==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 3/4] PCI: dw-rockchip: Replace PERST sleep time with proper macro
Date: Mon,  5 May 2025 11:26:07 +0200
Message-ID: <20250505092603.286623-9-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505092603.286623-6-cassel@kernel.org>
References: <20250505092603.286623-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=860; i=cassel@kernel.org; h=from:subject; bh=/qLNq6Ah1zBhiF3Gu9j00ITANtVDvo/o2g4ubZb++T8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIkWnQcZa+xFjLu/Kpp9+rqJZkKjlOlyz3VuRq1jlY19 h2Nl7LqKGVhEONikBVTZPH94bK/uNt9ynHFOzYwc1iZQIYwcHEKwERq3Rj+WexRMlpU2ms6NWvn g09v5B4Ush9vir5ntYlLfFmOSOTT84wMT3+UBOZ533AROnHJTZ6L9/hCqffSYVGBzk9cbi04fPM GLwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Replace the PERST sleep time with the proper macro (PCIE_T_PVPERL_MS).
No functional change.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index ed8e3dfe80e0..eb2931b39f7a 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -231,7 +231,7 @@ static int rockchip_pcie_start_link(struct dw_pcie *pci)
 	 * We need more extra time as before, rather than setting just
 	 * 100us as we don't know how long should the device need to reset.
 	 */
-	msleep(100);
+	msleep(PCIE_T_PVPERL_MS);
 	gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
 
 	return 0;
-- 
2.49.0


