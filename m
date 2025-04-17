Return-Path: <linux-pci+bounces-26111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EB1A91F77
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 16:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E0067A82A9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 14:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F35824E4AA;
	Thu, 17 Apr 2025 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="epf/QWi0"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0A72512FD
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899778; cv=none; b=YDrM8AVRmdZ+iJ87+BqNwdtIEQpubK5qy9BgYvUm3Itr82iDQQxaJnuIurjcUzJhexQab7CD03feCYlvsKTWqUTUTGl2AW96N9xxLCtNQYZce2JIy/TSJv5Re8kRwp9xQNYjF3T926lyk78GjXo0/x0xbt4J3rvpzUi0AE7wito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899778; c=relaxed/simple;
	bh=9FSKpxCPd9i3UM5rQhSSgYxqhu8htOS3MLmDsJB3+dM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=koa4c7/62btSha++nyKN9dT7yXBA7ftWM84J0ieQubGugHbTX+Tiw0+v13ribwR8qoN0WTNdBNqCtjcf1QsGjqmnOgMG/ux0dlKQWHAAQtsqgYNEH8sIG0YKf+J5+GPF5bJd2Wfx1V7eAnzyFltUhNFJ54SsUxNZikMBjXxaiGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=epf/QWi0; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1744899764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i674xOwrjdf/AAf3vaDDj/zXNM7PUpgpfGixq0BvJVM=;
	b=epf/QWi0fEMbAePO0z2eV4VX/swstqahqUqzcygHP0DUZtjjOHcjgeViy27Yytj7Be690M
	ySo035j0wLDy5r1/hXLft9L0MrK9XDkOFsUqji7vLGPO61zUiowfKaBPniuXs+3/0Zpmge
	/5NGI5R7h5IKsgJFebHve85QL3fvfN3cbdxlh4MwZZjNj2I0w74cWJlNksgOGqz6GoDZam
	KcBBqm3QSadwVwLWZnfrrJV14r45Vng8AottX3TkeiReqBt+kG/Mit/xfgHyEWPskklxNw
	v/fAQ33/TVTWCXevtP/iPE/iy9iMwZKKGJP8IwxryliX6s6W21Hl7qPPTUQQRw==
From: Diederik de Haas <didi.debian@cknow.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Dragan Simic <dsimic@manjaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: dw-rockchip: Fix function call sequence in rockchip_pcie_phy_deinit
Date: Thu, 17 Apr 2025 16:21:18 +0200
Message-ID: <20250417142138.1377451-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The documentation for the phy_power_off() function explicitly says

  Must be called before phy_exit().

So let's follow that instruction.

Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
Cc: stable@vger.kernel.org	# v5.15+
Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index c624b7ebd118..4f92639650e3 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -410,8 +410,8 @@ static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
 
 static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
 {
-	phy_exit(rockchip->phy);
 	phy_power_off(rockchip->phy);
+	phy_exit(rockchip->phy);
 }
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-- 
2.49.0


