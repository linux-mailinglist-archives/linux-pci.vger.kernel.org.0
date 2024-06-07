Return-Path: <linux-pci+bounces-8453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB4E9001C5
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 13:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9891A289129
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 11:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F896187357;
	Fri,  7 Jun 2024 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVR9V6aJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED17814F11B;
	Fri,  7 Jun 2024 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758901; cv=none; b=bD7BTsNiC5PiZ40QFqciT/tRR5RZkqCnE771ifweXOaU1jJUHAh/qlX4a/zpyx/IQVL51PUARR/760fBQpYr0h+bWsFtPg1c3OyNxL1OizoQ141aG275KyKbK4yCqmjKaupVtM95NJByjzVJO+LDwWQ1yVGMrtONtJ7FbhWapi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758901; c=relaxed/simple;
	bh=HF1cT1n/j3H272zD21vdJUmtNKwy4TQb7n0YJPDctKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HYYgChHRXtOV91waaYaYfKQfp/FYhGT1yRNehwlFzjY762N+HpP5q8x2qtwOgB42xGImVY1TL4C4u4K2OaKjDQKpLrNB9fe0+HlyHrVUJkOxX1NrHy39z9zTWlnd70snL0/e51UW7FGXVgzRZGlFiJzZdrSuInqSFTxfcqVw+40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVR9V6aJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D24C32786;
	Fri,  7 Jun 2024 11:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717758900;
	bh=HF1cT1n/j3H272zD21vdJUmtNKwy4TQb7n0YJPDctKQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nVR9V6aJ51pUgq4zgYLaHTdrUaDbfoGQ/hsu9wKodvIhtorz1BUVH7gt9nbNs4ouJ
	 /c59uE4IdekYYJXUjpGlP0hgfG1dGH1fmVU8kWSUvnatiTeGLGyvlcwIlElmtoeIVb
	 XA749jNMAhHuVFfVps2aKTXk1Jg23DnuLN9LiR6EhcMJvHvpcGnZZJSF/IDROamJqV
	 q+1k6kzFFMkWOmkFjr/cT23/p9+QSEWklEhcL9jbHRiQhx9R5c2JC/kpPqr7s1PQKv
	 NIBHSHqomC+sRjdhB2slzsbQ0sxnTUTv3uzvK9Ohc3QQ3qhDIbk49UVRGsngponCPu
	 ncfWo86n1U9ew==
From: Niklas Cassel <cassel@kernel.org>
Date: Fri, 07 Jun 2024 13:14:27 +0200
Subject: [PATCH v5 07/13] PCI: dw-rockchip: Fix weird indentation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-rockchip-pcie-ep-v1-v5-7-0a042d6b0049@kernel.org>
References: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
In-Reply-To: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Damien Le Moal <dlemoal@kernel.org>, Jon Lin <jon.lin@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=cassel@kernel.org;
 h=from:subject:message-id; bh=HF1cT1n/j3H272zD21vdJUmtNKwy4TQb7n0YJPDctKQ=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKSXk/aFXN7u2O/Q9Oahz57K6K5YhiXF5XNeRJqqf6ho
 sr3/CrxjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzk0HpGhkdszgmN6fPkHsny
 xOfGCL+tidjLv69bVCMy1+Te8bkc3IwM7e/+cml9lb51bKGRcUjYR42s3xGJC1/dLkrt1Oq6Oom
 LFwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Fix the indentation of rockchip_pcie_{readl,writel}_apb() parameters to
match the opening parenthesis.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 61b1acba7182..3dfed08ef456 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -60,14 +60,13 @@ struct rockchip_pcie {
 	struct irq_domain		*irq_domain;
 };
 
-static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
-					     u32 reg)
+static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip, u32 reg)
 {
 	return readl_relaxed(rockchip->apb_base + reg);
 }
 
-static void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip,
-						u32 val, u32 reg)
+static void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip, u32 val,
+				     u32 reg)
 {
 	writel_relaxed(val, rockchip->apb_base + reg);
 }

-- 
2.45.2


