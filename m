Return-Path: <linux-pci+bounces-6875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F6E8B7538
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 14:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795931C22C44
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 12:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5BB13D270;
	Tue, 30 Apr 2024 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcfFiRxp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F3E13D26D;
	Tue, 30 Apr 2024 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478538; cv=none; b=Z2D8EZ5wLlBY9W9WYYbmSrN3apuQNI4z13PMft4QnVfMIkbk+mAgMKA2wNcUXr8OT2belohMpMfefFTZvALdkxw9sCX8ALV1pwIvFn0lXaAdsiGQkLOVFiLJdw0eqdG9rZg6evgdiz+nBrqAyPvrx44839YTZmj14+5hRAWRxag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478538; c=relaxed/simple;
	bh=SXHxPE8zdJjZdXXAcX4rmqThuC0XgqJgg4dqgMQmx28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KlOaO0HygShgqvSf6zzNXTDIn+z/7OcjhYVVmTF7ogUFndYBtvfv5wJklMzi+4vFbybuM4Cvm/8cotqlSXzyk6/Znvw6Xe84yemQzrYd4N4OL9Aw/bSLXKyCKXkYI6lgDOTQqzvANa1enHaIhDtaRKeJVmw3pQ6B/cWyHSROPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcfFiRxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3A1C4AF18;
	Tue, 30 Apr 2024 12:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714478538;
	bh=SXHxPE8zdJjZdXXAcX4rmqThuC0XgqJgg4dqgMQmx28=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jcfFiRxp5K7LfbIMniYp++vMuQbnDaFXF0YR0h5thqTf9lraoZA1Y/Eyv0yNcpQ4B
	 ZyjF0pW6E6uCtmuUmRSmUxQv4yhNP2VHl8MMsaIHzUhwruFscnYx5SIeRw2MHvUEdX
	 iQE5rGBZR7fWh8eMo05TmvrEaAr+7zYDWF0pnKBFBQjTAel+GbLy2eDpKcCTDCAGez
	 6qhUIM2lgG0PsERpLlibUovx99bOmrmPv6wY2cp/MoCyw9UVzLIayHN3QzLUBf1ud8
	 GTs6/5es9P/Y3VL1ibb9DXXgjYVdqVTuEpxAFcgGQ+RwK/0NZ+E4OQuuqXN7pyTR6l
	 jKcOcqEI2Rq2A==
From: Niklas Cassel <cassel@kernel.org>
Date: Tue, 30 Apr 2024 14:01:02 +0200
Subject: [PATCH v2 05/14] dt-bindings: PCI: rockchip-dw-pcie: Fix
 description of legacy irq
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-rockchip-pcie-ep-v1-v2-5-a0f5ee2a77b6@kernel.org>
References: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
In-Reply-To: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Damien Le Moal <dlemoal@kernel.org>, Jon Lin <jon.lin@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1900; i=cassel@kernel.org;
 h=from:subject:message-id; bh=SXHxPE8zdJjZdXXAcX4rmqThuC0XgqJgg4dqgMQmx28=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIM7m441tzTf77xz82K1Zr9X+013sfoxBo0de7ceEPkz
 wSnu2fLOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjARXmdGhiUMygeTJisba9x3
 neDwdPECtyONrOd2Hrsja2hoU7VAxILhn33z8w+HQvlCzOxsZ5XzPqipX5bNc6h8TZrXHPv9GY6
 CHAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

The descriptions of the combined interrupt signals (level1) mention
all the lower interrupt signals (level2) for each combined interrupt,
regardless if the lower (level2) signal is RC or EP specific.

E.g. the description of "Combined system interrupt" includes rbar_update,
which is EP specific, and the description of "Combined message interrupt"
includes obff_idle, obff_obff, obff_cpu_active, which are all EP specific.

The only exception is the "Combined legacy interrupt", which for some
reason does not provide an exhaustive list of the lower (level2) signals.

Add the missing lower interrupt signals: tx_inta, tx_intb, tx_intc, and
tx_intd for the "Combined legacy interrupt", as per the rk3568 and rk3588
Technical Reference Manuals, such that the descriptions of the combined
interrupt signals are consistent.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
index 60d190a77580..ec5e6a3d048e 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
@@ -56,7 +56,8 @@ properties:
           pm_pme, pm_to_ack, pm_turnoff, obff_idle, obff_obff, obff_cpu_active
       - description:
           Combined legacy interrupt, which is used to signal the following
-          interrupts - inta, intb, intc, intd
+          interrupts - inta, intb, intc, intd, tx_inta, tx_intb, tx_intc,
+          tx_intd
       - description:
           Combined error interrupt, which is used to signal the following
           interrupts - aer_rc_err, aer_rc_err_msi, rx_cpl_timeout,

-- 
2.44.0


