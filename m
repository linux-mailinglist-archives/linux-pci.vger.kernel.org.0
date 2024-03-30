Return-Path: <linux-pci+bounces-5442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261FB89294E
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 05:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD723283698
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 04:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921EE79D8;
	Sat, 30 Mar 2024 04:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r++DN4JK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4BF2F25;
	Sat, 30 Mar 2024 04:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711772403; cv=none; b=Od/SNArw/om3266VyCJ14xX6E7pms8IvD7CHHAhChalwc2zLXTzN5RpEVE5bsab2d2SPCGr1gGCNyXK6O4ltI0ppJ4fyts4PDcSSTdWekQkN0pqIt1waLeuny3vzMoBg1foQMrqE6jtJgz7gK8CmWfsD3kI74POcVGY2pT0vLK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711772403; c=relaxed/simple;
	bh=YVMNoSiitz/dvs9qFfJ1kX3I4aXTOvXdrC9wLQgAmDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJzALF7Dr7+q7OS6DdBGAQQS/Z4rnNYK0fxsmDPvOSzB4aW6YUg5SWl1AgJ59s6ZebjFrv8tF1itv1wR9/TTPoulYMa+X1NtVIpWq8l5ODOpel8oInXZP+ieRoBhsaJq3gM85md1STfU9dc7xPbijOEqo14DQ2UqPCGLvRPAMYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r++DN4JK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C803C433B2;
	Sat, 30 Mar 2024 04:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711772403;
	bh=YVMNoSiitz/dvs9qFfJ1kX3I4aXTOvXdrC9wLQgAmDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r++DN4JKgFjDxY1iFwmqxRwzgZuTk4mNOJi+LYaCgWKyGIfs2D8XntjdRsaLyzAQH
	 TnQUZ1Cu50wjLhisu7iA1wemMxEUyPCXW5BZvCD7k5TsMAdaVlFZI3kFMAPOOHKM8R
	 X9jzFXQVA3N8U1g1F4Bg6WQ+7eeAQvbJBKSrskcIMG6OHO/uO8JiLpuLoQtu4c+1I8
	 hmaS1pBhmCcJ4c3n/1DLZPIeT6vLT5IaKs+hqs/UUT+KxtsMwUYm5ntmlOGgQP61IU
	 NlTCZhambH5YyHO/56Suv/kNVq44nvCJ5GwvquuCfwFpIdqkpJZN1s0cYL6sdkNQ8T
	 9V5pnLcZcQ34A==
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
Subject: [PATCH v2 10/18] PCI: rockchip-ep: Improve rockchip_pcie_ep_map_addr()
Date: Sat, 30 Mar 2024 13:19:20 +0900
Message-ID: <20240330041928.1555578-11-dlemoal@kernel.org>
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

Add a check to verify that the outbound region to be used for mapping an
address is not already in use.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 93c2466d6fef..36692e34ca31 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -245,6 +245,9 @@ static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 	struct rockchip_pcie *pcie = &ep->rockchip;
 	u32 r = rockchip_ob_region(addr);
 
+	if (test_bit(r, &ep->ob_region_map))
+		return -EBUSY;
+
 	rockchip_pcie_prog_ep_ob_atu(pcie, fn, r, addr, pci_addr, size);
 
 	set_bit(r, &ep->ob_region_map);
-- 
2.44.0


