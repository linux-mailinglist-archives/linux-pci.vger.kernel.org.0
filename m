Return-Path: <linux-pci+bounces-34059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F03B26AF6
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 17:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0CCA5E2CC6
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 15:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243B921CC4B;
	Thu, 14 Aug 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOi5Voqp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE72C20B803;
	Thu, 14 Aug 2025 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184943; cv=none; b=F9Fy5YMaT4hp5KlbGfXQiKKo5xAbJGSbX3vaemGfEG1mROQ414kxN3qOgicDEY3xHkN3NwVUEhUI0IXhjdc3z57Um/5LtffbyNDBJW4OTviUefGLGB0BRkcyjvN5n6tuF3BA7Sg8IBv8Esg1lX5X2ppbP/YtYKOMjNQBpllyLb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184943; c=relaxed/simple;
	bh=3KfSQ8O/ataLDsoMWxXgl9kaTMxlJOnEMOR1Hr/aKkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THOJ/pOLCRrrHF4cbBFFjzwWk6XO5JkoPnawP9uvxxmYFwQ7+Z5HeDKy3hqnosXxPKrsUKJGBhlfcsSI1822rtqv2EVg5yIfVByMsinutOwG7s4vGVBV3IV6VjOW6nFM+z2sH1dLVtCEZ8XsH+ubiGlEwMO/kCdEacgroUiFaPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOi5Voqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ACBC4CEEF;
	Thu, 14 Aug 2025 15:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755184942;
	bh=3KfSQ8O/ataLDsoMWxXgl9kaTMxlJOnEMOR1Hr/aKkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EOi5VoqpMB4Yn+QHD14fOCtcjdhfHCPLZyGUF3elMfiiTuum67JeH4hjB7Alk9kC8
	 A24GIRgyYaCvayQbyq8+CyXrty/HVj8PfhLbssUm9csIfinEWxg0jvHmFKasUDh/XG
	 U0wiQYch39iMcokFVVWkt0eTRfB9dYiVUT5/ipyJo4icAFakpFDm9WVyYg+LVisxBb
	 MyqRV2Eul7B12Fl8WmNuROuHPmo6Ed7SKmZf4itKU/4u8r/sa4r1s3nVaHh09lUTSV
	 Nahr4esRts8SdaS3+/a4NZPk1pIr8aDh3tVJE0PZ8vrHxLHoKxL/agPPnlwwafee6F
	 vIeHVbjHycadA==
From: Niklas Cassel <cassel@kernel.org>
To: Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 12/13] PCI: rcar-gen4: Drop superfluous pci_epc_features initialization
Date: Thu, 14 Aug 2025 17:21:31 +0200
Message-ID: <20250814152119.1562063-27-cassel@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814152119.1562063-15-cassel@kernel.org>
References: <20250814152119.1562063-15-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=976; i=cassel@kernel.org; h=from:subject; bh=3KfSQ8O/ataLDsoMWxXgl9kaTMxlJOnEMOR1Hr/aKkY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLm/vspUDE58GHn03yfOEFbnRSh7ca7tRc/zta7ulP7e PSyg2x9HaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZiI1maGP3zRsllOfEu9ru3S 6DH/ENTMNCWhIvW8XvWZXQLPw95Mtmf4w89s0WN28GK/jMz1s0bzPFWUf9kb3vs1bf/9ilXPTur UsgEA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

struct pci_epc_features has static storage duration, so all struct members
are zero initialized implicitly. Thus, remove explicit zero initialization
of struct members.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 366e21bffcbe..d787f2a364d5 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -398,9 +398,7 @@ static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 }
 
 static const struct pci_epc_features rcar_gen4_pcie_epc_features = {
-	.linkup_notifier = false,
 	.msi_capable = true,
-	.msix_capable = false,
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
 	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256 },
-- 
2.50.1


