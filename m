Return-Path: <linux-pci+bounces-36394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2930AB82B27
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 05:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF339178C82
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 03:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452D61A5B8A;
	Thu, 18 Sep 2025 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iHt8az7R";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Y+arRO55"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055933D984;
	Thu, 18 Sep 2025 03:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758164491; cv=none; b=uF8xFpJmPuzc2Mv2aOtoCpKAknSpjHDOiqzSj+7IC/T22PW+09s/SQUskHKP2TTDbkt9P5myhEJ3rek8uHtvpKSYzihcKbZM8oindfPJJeFdiL6APGC5GhOIM5V0PuRdJoM05R63yLqJ0PH7Jml5kODXGVOIHdCtRwyFpTqfqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758164491; c=relaxed/simple;
	bh=BO6SrqAA20xkccW+vNmsZQDKPzgNblJ1bTTjEhOfctg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=adQkpAbZbrpH8yrqyQgPuNh/kDzyREJVAe7IPfSPe/ZQGN2Hq9cJvrkMD/rPu0bNQJLMu83Wro8m9gATZ9UyN8TGnSxrC1o1Mto7ZrjL8OkJmDKUPt+hpnHNkzqIEgKe4h/T82z1Ah7u8B8CN+shREtNwA464OUPNLWYLqnQz2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=iHt8az7R; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Y+arRO55; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cS0lN1wbYz9tCf;
	Thu, 18 Sep 2025 05:01:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758164480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S3GAuvZrakaLKvdrywK46MUNS+Ijb2FFTim9amfwSH4=;
	b=iHt8az7RrIyxAnSHSIm5p/0vGSh053ezK/GNeqIXIP1guBB9mc+2j9pT77lg5xQyszq+rp
	M0Onilar3GYrbEcSXYWIWHGu7zQEhhBYAFc6fUrN+S5MKy547GR0CF6dvFx0Iy2HOjRm5k
	XS44LHqefQ7eHkDru5oOnAWmju86g0ADTsOfFKvkQo++fKSRWP7bpea0njy8NMRQN1Ngar
	alHYv0XD/SDIluuwRjt9aVbfvu/l4xbsg7vIwMAFy/bP4gW49OU9LIYZ8zYd0CXkOV14kS
	gEdN0q0Zkza3SpHS1xS1peRtgXPGekSusJSsdCwe6DR9Ybf7/cANfVgcR1Jtvw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758164478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S3GAuvZrakaLKvdrywK46MUNS+Ijb2FFTim9amfwSH4=;
	b=Y+arRO55gyBeUP4R5XrTiwVsWwnjfwqv+Co5Sgygfukd7lFvhaZzX5lI5rwDWH8aMmvLFp
	rFHSaN3KJmqpFAWM56klvsrO7VdYKjFRcEeUn7yjOfwzEIp7bCFTRlCJnFKqRQSVqX+b9E
	PNUr49dqqwHdfwCeR9ow/6kQvhg20q2u2mZEHEmFp/DiRWueFZJF3+LZCUiQNnTuqmGDSb
	JLDalGzEtazi5lQneYTB+1RmGU0Uwvm2RdSRKD6AI1+oaQHGm4vsJt24vWdNIeEtQ7g8WE
	PfFY2C90B8bHodv+ka+SR7udKi852J3ro3dOOf3oYqltJBBojlJIo9bP/clJ0A==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar-gen4: Add missing 1ms delay after PWR reset assertion
Date: Thu, 18 Sep 2025 05:00:26 +0200
Message-ID: <20250918030058.330960-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1b4xefz96otwf4sga8owzf6r765jcs9o
X-MBO-RS-ID: 9d77d2dd001a629b244

R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 585
Figure 9.3.2 Software Reset flow (B) indicates that for peripherals in HSC
domain, after reset has been asserted by writing a matching reset bit into
register SRCR, it is mandatory to wait 1ms.

Because it is the controller driver which can determine whether or not the
controller is in HSC domain based on its compatible string, add the missing
delay into the controller driver.

This 1ms delay is documented on R-Car V4H and V4M, it is currently unclear
whether S4 is affected as well. This patch does apply the extra delay on
R-Car S4 as well.

Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
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
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index de9fe2ed2423..8b39e014bc7c 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -182,8 +182,10 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 		return ret;
 	}
 
-	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
+	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
 		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
+		usleep_range(1000, 2000);
+	}
 
 	val = readl(rcar->base + PCIEMSR0);
 	if (rcar->drvdata->mode == DW_PCIE_RC_TYPE) {
-- 
2.51.0


