Return-Path: <linux-pci+bounces-44908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD70D22D7A
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 08:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E33B307C9F0
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 07:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88D332D0F5;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADnpznMa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F22B32B9AE;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462152; cv=none; b=scoHiy7bzTkIZD3keqhV92zFZriQmcA/K5r0cAjiwXGe0rms4zgMTUhop/y7WGfTiR/PIJOmlPAju73t0S0eyz3AKebEkiSfYEIO1SUnluAHzkibqTGtv1RPq9P3O8zmcIVAHipSiJP8g4B0ryx7EjmXmqLEr+irUUGFNr8+Zbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462152; c=relaxed/simple;
	bh=EE/OPJ/wo3lj7QFm4jJOi5bK3Fluo0f9Sd+lo6xGEn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CscUy4G3ZoFIvHyOVeDaxXCeDjDig79dinwJwV9snX3nd6UGwRZfxldJmd2G6G4dzPdCq71yu6OsCHIw/jqkiwOlA7Q9Ywld9T2mPZbscCmZ6+7gS3fP/6eB4Au7b5OnZ2Y19K9/XQXiFaVfTU89wFOhCw/6Jkq+kgVImbfHwOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADnpznMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F59DC2BCFF;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768462152;
	bh=EE/OPJ/wo3lj7QFm4jJOi5bK3Fluo0f9Sd+lo6xGEn0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ADnpznMasR13LrFplbIwkzL7eVbkSXEHwiphpqZanD6qkdB4rzTBwa/pebJ2wIR3N
	 eHE3YGccTEul9x7QbxlQ4In2v3keoTAM1aYoXnYOQaMUY0VWMJ7fvAO9d084CdbBgm
	 TXwUvO8tQLLbQ4+Ne9s4AQcHQ93RNAZTkA85x29xzaxviANylCKDCveT/S+TluCG4F
	 X7lVPGZYKUkOkk61//gPABR0sjVZhgWnbIofSU0qWDAKumxRG3Y+5nhhAEAM6uea2f
	 jjZ2jHXAmjUp5M62lZko8ztIVt3Nko6vBWgyH+F7ZgkRyyiQgsFE/X0bok8LFflEdQ
	 G3lY0wkTmFIVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16178D3CCB8;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 15 Jan 2026 12:59:06 +0530
Subject: [PATCH v5 14/15] PCI: Drop the assert_perst() callback
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pci-pwrctrl-rework-v5-14-9d26da3ce903@oss.qualcomm.com>
References: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com>
In-Reply-To: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=898;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=cfL35gxA0UiloYcpl6gZdQR72MeSRBnIzACUOVo0Zsk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpaJdC5y3osX6wTzwLGN+mHd/QX6p7wZXEYRQX9
 dvOO3Y/4vCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWiXQgAKCRBVnxHm/pHO
 9bvZB/90gYFo02YchiatjpJMZoKMifnlzwemLO7JZ1lA4avkDCt0nl5vTMGXfVxBcfhE2f2K1Bd
 AjXpknYv2CSXx30J+14ujU7comNQR8wMsMyLniK8jzJ7syge+HmfnV6PooEy6nqw9YqhJ6MnzUv
 zrROiRylZZp7sBwU3a/13BGFGPJD7WtCr6Ilb3RZj4+swNWzs8ab9r1NfB0A+JAkdfFR/es64YO
 ZoP3ngX71Rz/DAEf2ZHseN+zoIzVZgDwj/h1Mt9DOUA/lnUXfSRnAVmBzx2NmnlKvYZ6uPqSyGV
 gg/x9A4IuOmZe/1vGaF9GIFiypl0ktEfjtcQAuxu7ROQzUrq
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Now since all .assert_callback() implementations have been removed from the
controller drivers, drop the .assert_callback callback from pci.h.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 include/linux/pci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..3eb8fd975ad9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -854,7 +854,6 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
-	int (*assert_perst)(struct pci_bus *bus, bool assert);
 };
 
 /*

-- 
2.48.1



