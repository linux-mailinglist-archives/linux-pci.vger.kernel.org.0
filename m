Return-Path: <linux-pci+bounces-7231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 774338BFE3F
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 15:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191391F23352
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 13:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34DB7D3E3;
	Wed,  8 May 2024 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0wYh7Ka"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6397CF1D;
	Wed,  8 May 2024 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174041; cv=none; b=kKSGeN8UTbR9KYQDi0dEn2/cmzCwY+jCspEL6jKlnydwBxL9IiwjRrI+l/kM+9MMYb8Xn9ljR0Oqx9w3eZdXgQMosqASjDArMCLdY6jxA92b2kyzp3WL6Hr+nfRmnT77hX2fM3BNT4Rg2A1Fh7G9lFGFZtTYE2hjBIO2a9atNpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174041; c=relaxed/simple;
	bh=YpLt9USx5MURRWMvfXQdjc9NJxoYWfsGJds9NsR6Umk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZrINFViXnaNaUMtARwwPY7MI+shROtl3C+8nS+PuG0YSClia7UVexJ6E4J28PrXRxvzBKtqVfE+CpTr0dj8vqfZLmKo25KRmgQm5WjDAXQKmkM9UHAfXmvh+CX+qGVr7G3rRP11Mxc3ZT+GqFTm2/deVmkQsjJ3w9rgIIkoBxlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0wYh7Ka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7493FC4DDE4;
	Wed,  8 May 2024 13:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715174041;
	bh=YpLt9USx5MURRWMvfXQdjc9NJxoYWfsGJds9NsR6Umk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H0wYh7KaCRrAG+cKWahvCLwp79Q2AGVnlROAOVO2eyLg9sENMMfpgUZGOD2Zy2EZb
	 HBnkgjcXNZmZo8wifh+dBMte4SP61q+yvbn0IpX5GVlblmNkXl2Zxi/3M+EshVLCND
	 rnKHXcvWiy8gVDYbqrk0xKFV/EhjaV8smNaQOCTd/4fNABVaMxkJZAQU9cpkgbadGE
	 lVrzahZ1wNtMDo9UlcKurlT+v/CxUdscIxFres0grmzIQn39uwSOGy2BTVgaZWrYIK
	 eoVU+o8vAN/QPSO6qi7sSqvwKV16rVCdqp0tJdlCB3WPxTDvyteEhGcQL58lnDKjSw
	 J9yFaadk8wHOg==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 08 May 2024 15:13:36 +0200
Subject: [PATCH v3 05/13] dt-bindings: PCI: rockchip-dw-pcie: Fix
 description of legacy irq
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-rockchip-pcie-ep-v1-v3-5-1748e202b084@kernel.org>
References: <20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org>
In-Reply-To: <20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1950; i=cassel@kernel.org;
 h=from:subject:message-id; bh=YpLt9USx5MURRWMvfXQdjc9NJxoYWfsGJds9NsR6Umk=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKsq+r99xff/v4yIuJXplz1RMOjJesWS6wu8r6i0DU3b
 E3N8ds2HSUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjI63SG747LeL5oWlZdNjZd
 N/eI5dIHgg/WZPodDVtz2tlgl4rRVkaGF8Epy/UNDV41itmF/W7xmdT3b++rPqbVE/OOJ5c5Chx
 gBQA=
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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


