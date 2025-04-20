Return-Path: <linux-pci+bounces-26310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10881A94885
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 19:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1E916EACF
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2777320C49E;
	Sun, 20 Apr 2025 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Xa49ZO7m";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tXXpbcOv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD94517A302;
	Sun, 20 Apr 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745170764; cv=none; b=m4KZDpkHSqZ7XcaayXoHeqVw8LoW9yUfyPgK9JNIUgzP17lSxiAgWldzRmkAQ0mlKuPdVM0eVmZaep8fNqjizwPgd7dNlD2TeoqE8jhPNEble8XE1dOHyhtn5IGvpCtZCSU6QxgDrh/5YJhnDPlI3s5HB3QJjj3R02lchef4kxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745170764; c=relaxed/simple;
	bh=jtek4/rg+Eurh88bBO1/Z4q8wbU0+obePN4diu3rLMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tp3iIbXdV/5CU5SfbK4jrjrDaof4X2jEtZOkLVTd94eoRm3K2n5pUHIv/Ry0R72toIYYT13VEwMxFIdreRICgBoTUBQTEu+U0yxBVEkQicG9LNixLtF+qug/ZJbDn642zwWhHCfnw0wMh3vDR3gvXAxezn/m1XHzamoX7BxTSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Xa49ZO7m; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tXXpbcOv; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZgbN15VYCz9ssT;
	Sun, 20 Apr 2025 19:39:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1745170753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fRJA/JYt7ejKUUo6YzXM95Gf2a+EjwbvNUzyDLCNMdQ=;
	b=Xa49ZO7mLFnaTe4og3Wjip45lb9gpPEqjqU+DTi4eU1hbrugD41XnGQfaV3TD3ThxJeCJ3
	bvD/n8LZZQgfLl/+Mk+OiY/VCbjLCeAw6yMDC7eRVRUNrvXMmZ5EtFyoqPPt2X3Gi/CBl/
	RVrAitObJyly1p6p2P4kOXosQVL34vfcK1WIdc97iS5WaPT1aAZaVljD+7nCFRzxxAJLWc
	dpKj5hwWInP8AU3n+3EtZC+AwXsvNZ/vVTMXw5d1KOGskNPdAGb0Tgm0HmhAb0GrFZcp5W
	6sNfrr1pp41OxFk7P6Ts8TMuN9CBd3v6iOonmONu9STJRVi0qY46SKQKfoxyIA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1745170751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fRJA/JYt7ejKUUo6YzXM95Gf2a+EjwbvNUzyDLCNMdQ=;
	b=tXXpbcOvMA9UBrpEM0+wUG2Ddos8KaiaqN71bEwryCjvLYowjMJTRenu6SJ1ZQg00gZ872
	IZGSn/cJtcrZbaeTR1FRWykO4+TXjw+I2BvOG1BBfeiJgpUEt0uGADxzEIQhea7APluhbf
	FWtu7xUnSB/kFHJQuxiNx4bJ8gyt/eqACm6zPZklG7g2KaLnBeFHH5TqnfW7nkJmRC5xM6
	HelEbohkPR/Srd3a0GyweuSrseTmw7Nj5zsa26ZNSlU1JtVP5XU1v22QrfgoHwSR6DNrHW
	PzSvNFpFKOVzXioA7Jhq5/x73HBC1/ncnxMXfLuq1b3eVCcug7d9jNgrtQWCyg==
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
Subject: [PATCH v3 0/3] arm64: dts: renesas: r8a779g3: Add Retronix R-Car V4H Sparrow Hawk board support
Date: Sun, 20 Apr 2025 19:36:26 +0200
Message-ID: <20250420173829.200553-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: up3uixkic6qyqabapkakkpbj9ge1zsse
X-MBO-RS-ID: 1bd87a255bce825d983

Add Retronix R-Car V4H Sparrow Hawk board based on Renesas R-Car V4H ES3.0
(R8A779G3) SoC. This is a single-board computer with single gigabit ethernet,
DSI-to-eDP bridge, DSI and two CSI2 interfaces, audio codec, two CANFD ports,
micro SD card slot, USB PD supply, USB 3.0 ports, M.2 Key-M slot for NVMe SSD,
debug UART and JTAG.

Marek Vasut (3):
  dt-bindings: vendor-prefixes: Add Retronix Technology Inc.
  dt-bindings: soc: renesas: Document Retronix R-Car V4H Sparrow Hawk
    board support
  arm64: dts: renesas: r8a779g3: Add Retronix R-Car V4H Sparrow Hawk
    board support

 .../bindings/soc/renesas/renesas.yaml         |   7 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/renesas/Makefile          |   4 +
 .../r8a779g3-sparrow-hawk-fan-pwm.dtso        |  43 ++
 .../dts/renesas/r8a779g3-sparrow-hawk.dts     | 666 ++++++++++++++++++
 5 files changed, 722 insertions(+)
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


