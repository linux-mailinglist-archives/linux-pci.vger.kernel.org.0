Return-Path: <linux-pci+bounces-8451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D189001BE
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 13:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FA21C2157E
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 11:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE9B18629A;
	Fri,  7 Jun 2024 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGEOQcp5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57EB14F11B;
	Fri,  7 Jun 2024 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758892; cv=none; b=m9IlZt1zEz7+KyRreyaxtPUEJqh1gIPR1GaO7zu7P9tgKTbehQ+/0c1vrDU7epr8D7eDWRcVh5ND5EcimKkpf+nGvykLZ0gf3RMewWlg/ZrOV0usE9o4l2jLCFLGIR36HjrVpxS74ktJKn9kbPWBO+/B/NcqcDA3PjmPuCNzs/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758892; c=relaxed/simple;
	bh=YBd0KTeYI4LPzEdWB+dde91dnzjhiAIa4BUjAunYhAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q0mI6Jxzz64q9xhBWq1bdtNSbr+ukKKYYj3LtXWLEpvBgv96Hje5ImpYTSfL4fSzqQ/eGQ6TCTzSh/R7B4nCKKy9jUsWjwqx543HiYsovCqV9OmkOZopOpShCJtjTPwT4bv6d4lYPrv5wBnSmiu5uip9mrmDRvdedIxHQ8I2ZFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGEOQcp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5281EC4AF09;
	Fri,  7 Jun 2024 11:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717758892;
	bh=YBd0KTeYI4LPzEdWB+dde91dnzjhiAIa4BUjAunYhAM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uGEOQcp5y24etqgOhR5hA7h68TvmWcAynZeBOdCiY/lzcm9nk9UPHqp1sByFT9sxn
	 bvzlQxvZIhXKKUUfWhZcatkpDZ74YEe8hF/8kL1new/Fj3ahYl1FUyRNZaknHjK0SM
	 MzyyPd6RFHsU467WLJcsVDIZrvrUjWeFD+KJrAozhK9mbNYM4N1JRcDeGMZcIa9uCi
	 jww/zGRsYrHUlJkLUaXYwCOmdh4VdHARA3csf1t1aheWuah52PQi8FxqeavKnIR/Q2
	 +joNoIdleKp1JjtkR8yHzQ/I7bDPk4wzi2c9SmceEIk+6zIBF/euxdA6JvcXlqPTHI
	 SNp5gxh3BlMNA==
From: Niklas Cassel <cassel@kernel.org>
Date: Fri, 07 Jun 2024 13:14:25 +0200
Subject: [PATCH v5 05/13] dt-bindings: PCI: rockchip-dw-pcie: Fix
 description of legacy irq
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-rockchip-pcie-ep-v1-v5-5-0a042d6b0049@kernel.org>
References: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
In-Reply-To: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2021; i=cassel@kernel.org;
 h=from:subject:message-id; bh=YBd0KTeYI4LPzEdWB+dde91dnzjhiAIa4BUjAunYhAM=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKSXk/kaP9wUJ/3zktWh4Zj/eGFBhZ+RldkYzbOuSs9L
 ffEo5XOHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZiIhDgjw+puyRtbmplmNXEm
 p/N4Rkh3f/1uuZw98gjr5ljf7UaHbjP8r+A59zlMsXV3vR2PdJOlz8vow3J+1meZknc+n3isO1C
 ZGwA=
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
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
2.45.2


