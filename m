Return-Path: <linux-pci+bounces-33476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D08BB1CC7B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 21:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398F53A59EF
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 19:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D1429B8DB;
	Wed,  6 Aug 2025 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Tl/7GjR+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hUj63bUM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E52917A2FC;
	Wed,  6 Aug 2025 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754508376; cv=none; b=aBTSttItWc8p2DZeUbDZeI2nlw4ZQwhfEdz9+5XEVMQt7hfh7KvVsishlt5bTClUuixSmXVcMgpIL3TfBYIYJtkPz2OiTE+0U9jOCo5EPcXcgUmiTo3v1rz1k+4IRCwDak/q9465QFf80SBsSQmMpzGwNl5UyqlcP+56qAywsn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754508376; c=relaxed/simple;
	bh=xvc5hFNS7Z6zcrxdcrA4tcs5ZEaUntpwt8lO6+LsrQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PIdW22Gw0E1GgJepMIdX/BTFs3UIX+ikhilNAO+9oL4qRI1spAMX0Nu0ardcL5Q6K9IDpO7QWPyVCVyzhbw0I1xRCKCbdc4AWLMnYtFBlsBF3CU9vhcaCgWgsKXOfRX1wxm8UD41njdqk5fuBK+pb54nGCLy1J7rpMnAO5azRsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Tl/7GjR+; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hUj63bUM; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4by0db6yyZz9ssJ;
	Wed,  6 Aug 2025 21:26:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754508372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=okpq16wZJ1PBT8jtFsjAhOLKucRrdW9hV+i5Zl3AUDc=;
	b=Tl/7GjR+xG1+VL2RjuxxvvkINXGfxKfJ/3i+Vom7qYPZ/SwD9ML+jyixS+KKWHVxi01ySe
	5m/BsmGYTuqb1udVxi2muJKZll++LycHQDP8pX4k1FdyJrejSYvMGNIhdOmn5sKMFH0amF
	TIwsIn+k1gR5H34hg58JQFRS7CzStxCBQUGFzL+VWIkVYja3u4c0lJAw3FV07a0k+cyRGQ
	esvUQYQl5Tbl0UBMPV1uRupX90Sjg+CUhUCK8eMeNZZ7P607L8jCVZT1JorB2fwr6nVqtM
	ODsV4V8G10no+c8ayTuC+84IJwQPJUVjOl6cn+lCwjv7NMXG3edO7eI8yTINpQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=hUj63bUM;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754508370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=okpq16wZJ1PBT8jtFsjAhOLKucRrdW9hV+i5Zl3AUDc=;
	b=hUj63bUM3Gm8UPVlzBD7oOsge3ENy9BNTQYEliZ89YdfPvFACNNZfRQx+ztPyH7uxXtp6T
	RUi/Jgv6WGZZxMAwyiR9/Jv0+SLrpakhpzn4O8HvLbNJIyzZdehXOGaGtrK6m+0pblTThH
	2KGjE8Q52k0qeSTy+ZiCOHfLStlDBXe42pYZpHvhuFBANmzSEuZMXfgKIFm1SbrfIKbU9y
	5hdf4+Jue5+wP61DQd+PG/IaTfxEnJS0WTgtBftBIe7Ly2ikb8QDlVsIMV9Cl+1Bx2lMLE
	0Ov2YgoLap73zmISkA1SKypXujPHgRxWGzBOmkzvDTM9SD4bf+ywa/DvF7Ga8A==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar-gen4: Fix PHY initialization
Date: Wed,  6 Aug 2025 21:25:18 +0200
Message-ID: <20250806192548.133140-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d7f6342ca1b98e28eff
X-MBO-RS-META: bkpk5xe59a6e33qtrgseuctgge79j7wk
X-Rspamd-Queue-Id: 4by0db6yyZz9ssJ

R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025
page 4581 Figure 104.3b Initial Setting of PCIEC(example) middle
of the figure indicates that fourth write into register 0x148 [2:0]
is 0x3 or GENMASK(1, 0). The current code writes GENMASK(11, 0)
which is a typo. Fix the typo.

Fixes: faf5a975ee3b ("PCI: rcar-gen4: Add support for R-Car V4H")
Cc: <stable@vger.kernel.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index f256ba12b84f..0ef95005b0f5 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -703,7 +703,7 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x148, GENMASK(23, 22), BIT(22));
 	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x148, GENMASK(18, 16), GENMASK(17, 16));
 	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x148, GENMASK(7, 6), BIT(6));
-	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x148, GENMASK(2, 0), GENMASK(11, 0));
+	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x148, GENMASK(2, 0), GENMASK(1, 0));
 	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x1d4, GENMASK(16, 15), GENMASK(16, 15));
 	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x514, BIT(26), BIT(26));
 	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x0f8, BIT(16), 0);
-- 
2.47.2


