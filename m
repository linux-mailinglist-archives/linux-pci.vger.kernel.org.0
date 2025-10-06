Return-Path: <linux-pci+bounces-37617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B95BBE625
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 16:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C2A3B34BC
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 14:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB99C2D661C;
	Mon,  6 Oct 2025 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="q2ldwKH4";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="IacS/6YH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25CE1C7005;
	Mon,  6 Oct 2025 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761953; cv=none; b=NO98GrtXjkPlD22QECbUN5gw5xH3KzDxZF+WqCyPBma+agCj78e3gdKyPWBJBr/3/ovUHL+2OYIGqBG3dW/rgrt9GB1v9hOjXx891CHkxlbfLhpEIvNFrC9KY+0VNtHupgN71g2wTfdJWR3Aymhwet4WefpthiWEXCxcOqQ1daM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761953; c=relaxed/simple;
	bh=f2lVa86/wPKb30SHUxj2idQocPvFNcnOkh58cZ4fb+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkuMtrEPZbwQihViw/xW5tpAIHaHBBocPE2OWxT+O3+Yr6WEW5YmZ62SVHgbaMzNkDDOJQPpdq3RLuiLJOG76/US85gC5CH3+8ZluDRuCKoUy+3WHcyutBpFJIFNn5+ofQMe+Gh3d9grxUGcTzWvdTtudBhyeXN6nD024XluQWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=q2ldwKH4; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=IacS/6YH; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1759761455; bh=hT8aWyIDgjsEqbFovnN215l
	unAK8tXcDqNu8S0mbHIk=; b=q2ldwKH4+hjp03qV0nrXpPeSeG0O+ZVqdjqGnNN/WJCPUoTXIK
	AMCBfbklZQnYOpnUmlI+fWNlofqW3q3XlEJwNlSwtKrs5ZMpp3UviPVCH/tkecE9Sea0LeA7OF0
	BqoKPZSLRglUnFRS+rLAt2A2cJ3PEgetlF41zpIJJpC2MhPBLcw3NJKJwO5rWxlH2/hmLLKrRbU
	04ziV64hZuHKlBGWk5pT1aNiggV2yVVQoylVwB4sNe7GKW/YIr0Nbx+F6VqiRlTaPQZTQpb9rAY
	IDP/ELG+EO/TcIeIUfiw5H8ex+pRYhzO9ldEB/gAZs/IBe/Vj9i9Trkuhc0P7k07EjQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1759761455; bh=hT8aWyIDgjsEqbFovnN215l
	unAK8tXcDqNu8S0mbHIk=; b=IacS/6YHNGEDLiMIOi3bysrK9L7quIybRkuHaOZWNJhsHoJCWn
	7mZXe7pjFjDr2CNdpmyVC31w3irAGvzf9PDg==;
From: Victor Paul <vipoll@mainlining.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lukas Wunner <lukas@wunner.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	Daniel Martin <dmanlfc@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Paul <vipoll@mainlining.org>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: probe: fix typo: CONFIG_PCI_PWRCTRL -> CONFIG_PCI_PWRCTL
Date: Mon,  6 Oct 2025 18:37:14 +0400
Message-ID: <20251006143714.18868-1-vipoll@mainlining.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit
	8c493cc91f3a ("PCI/pwrctrl: Create pwrctrl devices only when CONFIG_PCI_PWRCTRL is enabled")
introduced a typo, it uses CONFIG_PCI_PWRCTRL while the correct symbol
is CONFIG_PCI_PWRCTL. As reported by Daniel Martin, it causes device
initialization failures on some arm boards.
I encountered it on sm8250-xiaomi-pipa after rebasing from v6.15.8
to v6.15.11, with the following error:
[    6.035321] pcieport 0000:00:00.0: Failed to create device link (0x180) with supplier qca6390-pmu for /soc@0/pcie@1c00000/pcie@0/wifi@0

Fix the typo to use the correct CONFIG_PCI_PWRCTL symbol.

Fixes: 8c493cc91f3a ("PCI/pwrctrl: Create pwrctrl devices only when CONFIG_PCI_PWRCTRL is enabled")
Cc: stable@vger.kernel.org
Reported-by: Daniel Martin <dmanlfc@gmail.com>
Closes: https://lore.kernel.org/linux-pci/2025081053-expectant-observant-6268@gregkh/
Signed-off-by: Victor Paul <vipoll@mainlining.org>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 19010c382864..7e97e33b3fb5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2508,7 +2508,7 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 }
 EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
 
-#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
+#if IS_ENABLED(CONFIG_PCI_PWRCTL)
 static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(bus);
-- 
2.51.0


