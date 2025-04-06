Return-Path: <linux-pci+bounces-25344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617AEA7CE75
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 16:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0846E3B04A4
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 14:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1CA19DF53;
	Sun,  6 Apr 2025 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="En8A0ggU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jq/4MFd9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2698A20330;
	Sun,  6 Apr 2025 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743950953; cv=none; b=pWcsF9iAkoApjA9G2NIJKypAxEuHJKUHpkWYjMX6lSmnoDeITnNMsb04fRIOOhKJ5BTrkU7Hbe0c5eazKbVloOpjgD6vpDJBDfG/sPguun3/chDuhilLufjmiI2qHpkb/2c3G9lq9lIO/zQ4hmPoRlSgB1p23K5soM8ienv/USk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743950953; c=relaxed/simple;
	bh=tE3lC9OPXGFWS1kwcJCk6bHYTeEZVn7wMLR8hYx4LE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jHWCioms7fEMRbVMx87N34CDKv+g+34JsFz+C5PNVwDzOZnjpYvwBHHFsSBYduBMHk5uNO4sJSeqpykvf2nWu1yIRflsRZ8Z2KazopvcdPv0pNcZxos98NC2ydl/+1daS0BDXwz5EFQzx/fl+b/PhZK5c5os0kNolB4wceeWHRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=En8A0ggU; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jq/4MFd9; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZVwG64vF5z9tLv;
	Sun,  6 Apr 2025 16:49:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743950942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ouSo7FlRFCn9kPXMwokD5Qs7NISOOu4zypPQBTuY4SI=;
	b=En8A0ggUjT68sKruXxIgdm+Wz8dunHe0VfBFuXmWyLucfLQ+4d460RH9NVBkGAmF0ss6x/
	SA8b//Pq0IqtceVtV5pdZmPf3YL8GydKDOnAjq81ABbJJnbpIdvqpWS+ExknfFEaY+B3m+
	WxWbUnRY1/9YrfTfrnLMOWSN1ujPUOJ/rLu5sz3aHHLJWpAcvCPCAxK3hCyl2wilfSuU8E
	dVfbxdK2Q9j+WK8YGNamEe8O3ZFt+aqBtGdgdqZCMTQoRhoF0BgC1drcBIJXgTmXhq40GR
	3ir2rbk5dpSMdIJbEamfI4LkADhP+X3TjjVgdJIw2IQClVB9euPG66ncdbb2Dg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743950940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ouSo7FlRFCn9kPXMwokD5Qs7NISOOu4zypPQBTuY4SI=;
	b=jq/4MFd9ypv83vVVduk1mXXb3uryRPKi9/b5jFpbp9qkvPYXxnytlXwldOu5il0GNzKFtl
	ZzTxuhT/1jYuFbfD4n6Peg6EgZxnskuW5rwvAC+GsDsbk8Rc9iSZbJYEPwRq+O6WDj8Cb0
	7M4+aICSNYep3EF1I8WMlG/7V3gvqWO3HPxD9QF4kzTj0WyMZG/vOd8hlC+Obr4ShvdCAD
	88msxmiX6dzBPR1Ru0mCH7t7k00UBQ13SXLIPCr3LFvznC08U7cR355Q5py8mcNN57pZ8H
	7F+Q3mT0JomFWGHlzZTf3e88CwLB50sswgwFeDuCr71NXCCEheVlnSovwLc6Rg==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Heiko Stuebner <heiko@sntech.de>,
	Junhao Xie <bigfoot@classfun.cn>,
	Kever Yang <kever.yang@rock-chips.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 0/4] arm64: dts: renesas: r8a779g3: Add Retronix R-Car V4H Sparrow Hawk board support
Date: Sun,  6 Apr 2025 16:45:20 +0200
Message-ID: <20250406144822.21784-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: x5etaarnsacp4g3atghkao78dekbpsoz
X-MBO-RS-ID: cce39108303713c226b

Add Retronix R-Car V4H Sparrow Hawk board based on Renesas R-Car V4H ES3.0
(R8A779G3) SoC. This is a single-board computer with single gigabit ethernet,
DSI-to-eDP bridge, DSI and two CSI2 interfaces, audio codec, two CANFD ports,
micro SD card slot, USB PD supply, USB 3.0 ports, M.2 Key-M slot for NVMe SSD,
debug UART and JTAG.

The board uses split clock for PCIe controller and device, which requires
slight extension of rcar-gen4-pci-host.yaml DT schema, to cover this kind
of description. The DWC PCIe controller driver already supports this mode
of clock operation, hence no driver change is needed.

Marek Vasut (4):
  dt-bindings: PCI: rcar-gen4-pci-host: Document optional aux clock
  dt-bindings: vendor-prefixes: Add Retronix Technology Inc.
  dt-bindings: soc: renesas: Document Retronix R-Car V4H Sparrow Hawk
    board support
  arm64: dts: renesas: r8a779g3: Add Retronix R-Car V4H Sparrow Hawk
    board support

 .../bindings/pci/rcar-gen4-pci-host.yaml      |   9 +-
 .../bindings/soc/renesas/renesas.yaml         |   7 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/renesas/Makefile          |   4 +
 .../r8a779g3-sparrow-hawk-fan-pwm.dtso        |  43 ++
 .../dts/renesas/r8a779g3-sparrow-hawk.dts     | 685 ++++++++++++++++++
 6 files changed, 747 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk-fan-pwm.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts

---
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: "Rafał Miłecki" <rafal@milecki.pl>
Cc: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Junhao Xie <bigfoot@classfun.cn>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org

-- 
2.47.2


