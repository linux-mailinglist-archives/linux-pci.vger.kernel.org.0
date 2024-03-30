Return-Path: <linux-pci+bounces-5431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584D7892915
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 04:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2971F2224A
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 03:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F378663CB;
	Sat, 30 Mar 2024 03:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQA6GcFP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9781878
	for <linux-pci@vger.kernel.org>; Sat, 30 Mar 2024 03:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711770645; cv=none; b=Ivgmbu6OQjHHOTJazImkDt23GDXy3QQytt6q5RD8A+rTatoXV3ebPXMokaL5peRgbPGUkoYlNN0IWEtIZ08EklfdkauvwOaC8fdHYKxUtRvxV9hjVe9ANlgVdAQd2funFMLYxI//huYL7SJxhhL1MHsDdmWqh6vC14PD7Arc61w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711770645; c=relaxed/simple;
	bh=9vfnCaBKXtRgcv8F/e2Tdm9el/hk1aeDzoQ8fr5kZVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BeOUuT19UOmYI4Pxmo43klqO+PIOPPHflNe3ehqQtoawk2SoWFPqy7Stfg/9xqMelrTtMLiKNk/UOxcqszzTDy03dOn1Nca5HjAN9/zpq0kCLcMMscc47bFwAWuf0r/XKgSEp/vgDstdj9lAxVC6awoJ65W/3QZC/2N4zxv+TbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQA6GcFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B46FC433C7;
	Sat, 30 Mar 2024 03:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711770645;
	bh=9vfnCaBKXtRgcv8F/e2Tdm9el/hk1aeDzoQ8fr5kZVQ=;
	h=From:To:Cc:Subject:Date:From;
	b=uQA6GcFPKYREp76Y3XplqgC946g7Qj2DQ5d0cxAX0A65rXq457pclwXd8q9/b3ruC
	 rxPd0RTlXTBqT4GOQ5h0UNp5T+62XgIEXKGtyBlpo78SEJBODeWhO6KdxlKnnFs+Tc
	 jJEOKe7IUgFjgHiGdEubAwXzf3Hlg3vNoprDtzQSZq+rq/t6GUTHMGcsezRDoDGidJ
	 k5Hq/D8o2QZz+o6Na4MEbmXqy7aLQoPNRxCICMdnMWWbqwsDSwNBUeya+SnrUpIrad
	 IPXbPYDwAZtsXYpt+3VB32bDo93snv9LB5rZkmKi2i8HSD8+DzPdB/M+jvG6yzrDyv
	 /0Q1J3xPFGg7w==
From: Damien Le Moal <dlemoal@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] PCI: rockchip-host: Fix rockchip_pcie_host_init_port() PERST# handling
Date: Sat, 30 Mar 2024 12:50:43 +0900
Message-ID: <20240330035043.1546087-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe specifications (PCI Express Electromechanical Specification rev
2.0, section 2.6.2) mandate that the PERST# signal must remain asserted
for at least 100 usec (Tperst-clk) after the PCIe reference clock
becomes stable (if a reference clock is supplied), for at least 100 msec
after the power is stable (Tpvperl).

In addition, the PCI Express Base SPecification Rev 2.0, section 6.6.1
state that the host should wait for at least 100 msec from the end of a
conventional reset (PERST# is de-asserted) before accessing the
configuration space of the attached device.

Modify rockchip_pcie_host_init_port() by adding two 100ms sleep, one
before and after bringing back PESRT signal to high using the ep_gpio
GPIO. Comments are also added to clarify this behavior.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---

Changes from v1:
 - Add more specification details to the commit message.
 - Add missing msleep(100) after PERST# is deasserted.

 drivers/pci/controller/pcie-rockchip-host.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 300b9dc85ecc..ff2fa27bd883 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -294,6 +294,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	int err, i = MAX_LANE_NUM;
 	u32 status;
 
+	/* Assert PERST */
 	gpiod_set_value_cansleep(rockchip->ep_gpio, 0);
 
 	err = rockchip_pcie_init_port(rockchip);
@@ -322,8 +323,19 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
+	/*
+	 * PCIe CME specifications mandate that PERST be asserted for at
+	 * least 100ms after power is stable.
+	 */
+	msleep(100);
 	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
 
+	/*
+	 * PCIe base specifications rev 2.0 mandate that the host wait for
+	 * 100ms after completion of a conventional reset.
+	 */
+	msleep(100);
+
 	/* 500ms timeout value should be enough for Gen1/2 training */
 	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
 				 status, PCIE_LINK_UP(status), 20,
-- 
2.44.0


