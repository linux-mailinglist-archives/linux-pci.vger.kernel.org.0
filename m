Return-Path: <linux-pci+bounces-5437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E459C892946
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 05:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5719CB224D4
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 04:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5258E2F25;
	Sat, 30 Mar 2024 04:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIpfUVs8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEFFB645;
	Sat, 30 Mar 2024 04:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711772388; cv=none; b=Ar87EMfi3UIYj3orw7KSLTUugzmnMqxHbNO6S8g3UVTtKahjfBBFkVcoc+HmBGfYJW7P9kUvuA2FgU2ACTP27n3oR/zyxHXQ7cfc/EiRQOIlwKwtMQ0YycoOiZhcLANnJgqmrazwkWje7uSSYDgE+Et4xKISDG4ibi8I5YqPHCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711772388; c=relaxed/simple;
	bh=3XQZJFnWiBCa0pKYKa49EaaDKQXO1nRdHx3kVp9W1t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDDyoLe3B/hwQgivrHLGa2y/ZCCqGPXsrERzjA6v4WA7ncm2J1Tgk1uqeWB76uv+2dXK2sUA8WnBM9Fa3Dh+tVIMpbQNrfn8sUmK5DkioDihayY9REEtqeLV6/AfMAZOII8bX6JM+QVD8fphTzy/lE8Z6kp9z9+zCgz31D3QiMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIpfUVs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF19C43142;
	Sat, 30 Mar 2024 04:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711772387;
	bh=3XQZJFnWiBCa0pKYKa49EaaDKQXO1nRdHx3kVp9W1t4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SIpfUVs8r5fCMYLpr0DqPZiS7/h9HDaAlucZ3PWu0yhGwc+/+5M3sDIglXFB2efR6
	 kE9LheQ66adzwszcQHewFuwV/Jo6tsBBOE5QKGQ3bjFWvTLHa/P4PRlMBsWaTslWRU
	 J+KJdj3xC7uihNTREoc63N/3BAMEV55Dej9FLP0cG5pyjWLy0hi0CyEEUjBpfZ1CxW
	 q9npUiSPglnrq1p/w2CIVcuGtqFCZ6E/TRDSu3h1nBU5k3UDSZFmjSMqgPEnYEXuLx
	 yz1QjWV4lW3MadTkAuwmUe0oYxJ4FS8oDUDbiNrRi5siA84poPe6R1EjrBfeHVyjv5
	 nSQ3eEFfQbzdA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 05/18] PCI: endpoint: test: Synchronously cancel command handler work
Date: Sat, 30 Mar 2024 13:19:15 +0900
Message-ID: <20240330041928.1555578-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330041928.1555578-1-dlemoal@kernel.org>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the call to cancel_delayed_work() with a call to
cancel_delayed_work_sync() in pci_epf_test_unbind(). This ensures that
the command handler is really stopped when proceeding with dma and bar
cleanup.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 0e285e539538..ab40c3182677 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -709,7 +709,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 	struct pci_epf_bar *epf_bar;
 	int bar;
 
-	cancel_delayed_work(&epf_test->cmd_handler);
+	cancel_delayed_work_sync(&epf_test->cmd_handler);
 	pci_epf_test_clean_dma_chan(epf_test);
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		epf_bar = &epf->bar[bar];
-- 
2.44.0


