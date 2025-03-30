Return-Path: <linux-pci+bounces-24990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4DFA75C09
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 21:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A1E164C05
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 19:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2421DE3C7;
	Sun, 30 Mar 2025 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="W4wWM/8H";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="W+nTWuoD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37A44207F;
	Sun, 30 Mar 2025 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743364720; cv=none; b=t0ON7iWAVD/izmwufpEl9QevaM066D2qAi5nOhRoenZvgdCjXDNGeUfwpjUPHDekf2r9DklHFcAsgc7oGitaY9Z6GlWQ5QrWqu84P1C6LVcTxwy0uf6uod+5MV1GkV4/Gx21COzS/lKB6+HNCl7a4vQ+bPyWy4WFRcqoIMbDv44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743364720; c=relaxed/simple;
	bh=m7PnrqsqzFunqQJwY3pECLfjH4Bcbn7nTA+PEcVo1Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f1E8d5MwMET49GzEIFYKNCDBlbZWOfYEO1rn6Qz6oGGI+vliV2znr/AUM8lOoKr+1tvVNmJYtS4KYrpBlvj4xxcJnJr4LpBZyMHiS9hTRhk+6NN2JL1Ndmk7os+OFM2F+QJp7jRjsqqHFKxqPUT4acp5jF+tyjRArHeAJySXWEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=W4wWM/8H; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=W+nTWuoD; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZQlSQ2VPJz9vKQ;
	Sun, 30 Mar 2025 21:58:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743364710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e+DgFYFBUC1JfQz2ac791s6PLHOH76kUTC4Uk6Yz1q0=;
	b=W4wWM/8HXm/dUmCtiZelwrogbXO8+QsqDg551MA7BbwA/BQbD1ZPRumqNps9/+Kwc+J+w4
	AOUN7NSuCmpzG1aIvoyflZX9H0psX177BxcyE6q8vA23IzcJiY5jr5jHlWv+OulRHo3xnd
	3cZzIeOQuSkkHWpbOM8vOs0zPd8q0/fT4m8wl2nVlF0nZKpcKlzT/Lx2+VJFTzzdOi5RGP
	WI3UzO3csBfwPppKDWUkY9GzNfsxNfnWd7ahlxc8EOaXjNEEaLYLbVoOpa/LFhtfA5L+YB
	QfobxB1X7WVoFYNKnBoMoRTMGbgWtFXDCRwtcWN8iUzzN3obru/wNymfJFrwQA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743364708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e+DgFYFBUC1JfQz2ac791s6PLHOH76kUTC4Uk6Yz1q0=;
	b=W+nTWuoDcqty3Vnpq5gzNRsu9xLWYbPPnClczDtderzm2izRpt9O2oa+fqm/rMj2XaVNWp
	suJTQvQv677BQROHd1ptz/xxyruwmWrEwrS+V+SVazp5p5NLhlPT5Tr2Jcg3NRVTyJJZDq
	4703B8SuNKGdqmv8zJxM/jLpYyO6C4Ty1RNlzUc0ulHwwgkTFMbNWB5oVNUq4fm7s+nVfE
	QWSWjMgW+P6kB4cvVhy/BvvMntq7RF23rv+KnY6FOPGqelgoxgBMHNfkzr4uluQhrNA3ZK
	v+Lo08hA+LIt5tSakYe70zFiPPXcmTyscomIw16/ipD1/U4TbDWfir8L3OtotQ==
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
Subject: [PATCH 0/4] arm64: dts: renesas: r8a779g3: Add Renesas R-Car V4H Sparrow Hawk board support
Date: Sun, 30 Mar 2025 21:56:08 +0200
Message-ID: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 411346d026a677b7e90
X-MBO-RS-META: 43y5k787afq3cee6iy5rounnewkzdcey
X-Rspamd-Queue-Id: 4ZQlSQ2VPJz9vKQ

Add Renesas R-Car V4H Sparrow Hawk board based on R-Car V4H ES3.0 (R8A779G3)
SoC. This is a single-board computer with single gigabit ethernet, DSI-to-eDP
bridge, DSI and two CSI2 interfaces, audio codec, two CANFD ports, micro SD
card slot, USB PD supply, USB 3.0 ports, M.2 Key-M slot for NVMe SSD, debug
UART and JTAG.

The board uses split clock for PCIe controller and device, which requires
slight extension of rcar-gen4-pci-host.yaml DT schema, to cover this kind
of description. The DWC PCIe controller driver already supports this mode
of clock operation, hence no driver change is needed.

Marek Vasut (4):
  dt-bindings: PCI: rcar-gen4-pci-host: Document optional aux clock
  dt-bindings: vendor-prefixes: Add Retronix Technology Inc.
  dt-bindings: soc: renesas: Document Renesas R-Car V4H Sparrow Hawk
    board support
  arm64: dts: renesas: r8a779g3: Add Renesas R-Car V4H Sparrow Hawk
    board support

 .../bindings/pci/rcar-gen4-pci-host.yaml      |   8 +-
 .../bindings/soc/renesas/renesas.yaml         |   7 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 .../dts/renesas/r8a779g3-sparrow-hawk.dts     | 671 ++++++++++++++++++
 5 files changed, 687 insertions(+), 3 deletions(-)
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


