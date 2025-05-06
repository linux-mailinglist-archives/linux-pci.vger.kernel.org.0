Return-Path: <linux-pci+bounces-27261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF44AABC5A
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 10:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705D91B603B4
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 07:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDFD335BA;
	Tue,  6 May 2025 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BY5oyyjY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0AD4B1E56
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517191; cv=none; b=JPo3ZJC30i7iAqY01UqRUkizBpqwMmxQ7MDtmQg2BcjbZ4mps0hjsYcr+7a8GIimfp49LozhkNGTGyAw5Ea+egiuENc/wPmVZQM4fQF7fIoyVBG2TY/iFKl5tTGf0w6WzqEtKTN0vl4JzpaatizNOiITLkWH1g8TQL5bLi6/fT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517191; c=relaxed/simple;
	bh=fIF5C2JpTNsGgN9qtpaqxTEfCI6ag3WFonjPNfysbhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFO1w1QpXTqEYz0hjvxyXDlVQfWIXtZ/9Oxo5YP76uqYv6A/Rx/zVun+t/FuJLSOBdv+6RmApbAvxhk9S1WCcrypOiO1GMpcEYCp1kXtKikqq3WE8rpRp7fF1dfGky2YSWs7Pyv0LxCibCzT6xLFd8qF1Jw6FvIY+ZJFkM8SnH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BY5oyyjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB02EC4CEE4;
	Tue,  6 May 2025 07:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746517190;
	bh=fIF5C2JpTNsGgN9qtpaqxTEfCI6ag3WFonjPNfysbhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BY5oyyjYz3joPCmh2f6M4fyMhgk3oPt98s4yZ0DDFYZ73l8rP9psk2J14VCixd2qI
	 XKMz+rJ9NvRvgTdst/gAwzy5GypBn8JQF65TngFAjCBKbPwUCfDxcuMKSFNMETNEDa
	 X7Y/eG7zJS5qOoAjSLdDMnTyYS7GT+MYW9h6X3cv/UZPVag8rzITBiXQCmKcR3q2pl
	 O572i0AbsnGRi4m0888S+aMoZia5zRb543AJtf8QGu6IhM+48jwokbxVH5Fc7tPUCR
	 iuAnV1F5BeMgK//cw/TzK7JXn46XRNFzWCkAa2VsBm6cAtx4tXTYUfV9bXWXDji1n7
	 8B5aDpGJmCNqA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Niklas Cassel <cassel@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2 1/4] PCI: dw-rockchip: Do not enumerate bus before endpoint devices are ready
Date: Tue,  6 May 2025 09:39:36 +0200
Message-ID: <20250506073934.433176-7-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506073934.433176-6-cassel@kernel.org>
References: <20250506073934.433176-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2766; i=cassel@kernel.org; h=from:subject; bh=fIF5C2JpTNsGgN9qtpaqxTEfCI6ag3WFonjPNfysbhk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIk9+z+d2SSYt28t6I99eu378g+Ea1q+dXycaVGnnP6n OUZurv2dpSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiVrcZ/pdaJAhNrtypfsrI Y43vcoldXw1TSnMWVvItUzJ8fbmpLIKR4Y+SCVfgsyDWGsNHgjXKjFu/ih2qsJBsEz7Amnjw9IG JLAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can
detect Link Up") changed so that we no longer call dw_pcie_wait_for_link(),
and instead enumerate the bus when receiving a Link Up IRQ.

Laszlo Fiat reported (off-list) that his PLEXTOR PX-256M8PeGN NVMe SSD is
no longer functional, and simply reverting commit ec9fd499b9c6 ("PCI:
dw-rockchip: Don't wait for link since we can detect Link Up") makes his
SSD functional again.

It seems that we are enumerating the bus before the endpoint is ready.
Adding a msleep(PCIE_T_RRS_READY_MS) before enumerating the bus in the
threaded IRQ handler makes the SSD functional once again.

What appears to happen is that before ec9fd499b9c6, we called
dw_pcie_wait_for_link(), and in the first iteration of the loop, the link
will never be up (because the link was just started),
dw_pcie_wait_for_link() will then sleep for LINK_WAIT_SLEEP_MS (90 ms),
before trying again.

This means that even if a driver was missing a msleep(PCIE_T_RRS_READY_MS)
(100 ms), because of the call to dw_pcie_wait_for_link(), enumerating the
bus would essentially be delayed by that time anyway (because of the sleep
LINK_WAIT_SLEEP_MS (90 ms)).

While we could add the msleep(PCIE_T_RRS_READY_MS) after deasserting PERST,
that would essentially bring back an unconditional delay during synchronous
probe (the whole reason to use a Link Up IRQ was to avoid an unconditional
delay during probe).

Thus, add the msleep(PCIE_T_RRS_READY_MS) before enumerating the bus in the
IRQ handler. This way, we will not have an unconditional delay during boot
for unpopulated PCIe slots.

Cc: Laszlo Fiat <laszlo.fiat@proton.me>
Fixes: ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can detect Link Up")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 3c6ab71c996e..6a7ec3545a7f 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -23,6 +23,7 @@
 #include <linux/reset.h>
 
 #include "pcie-designware.h"
+#include "../../pci.h"
 
 /*
  * The upper 16 bits of PCIE_CLIENT_CONFIG are a write
@@ -458,6 +459,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
 	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
 		if (rockchip_pcie_link_up(pci)) {
 			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
+			msleep(PCIE_T_RRS_READY_MS);
 			/* Rescan the bus to enumerate endpoint devices */
 			pci_lock_rescan_remove();
 			pci_rescan_bus(pp->bridge->bus);
-- 
2.49.0


