Return-Path: <linux-pci+bounces-8002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900DB8D319D
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 10:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A53C5B2E7F2
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 08:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F322D16A36D;
	Wed, 29 May 2024 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvPQdGTU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66AE1802D8;
	Wed, 29 May 2024 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971374; cv=none; b=B/LgG7jgudwnHrOJNnQrdFyaAMsX7oG3++U69EihF3ff7sRe9xYh7ydDl3ofpmHbmf2dQaRZXnGcmPrSvmSvksx5agD37v9UMkCKZeX5x6t4sdApF6Y4w5kkyMHz7ug/hn/pMTaKyJXlCQvCVl1PaWhfTcr6LP+RRGbHkro1f7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971374; c=relaxed/simple;
	bh=DgDwrueIemNRUbe/G47rptzZcqdtSi36/c0CqD/3bpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k6rMUOckxAVoCSh4NRVQKz9u3qcsEjeMISgadJR+dBV38L8Tar5mA5GWWowNoO5zTQjVWyaNWvVGTzw72fsWommrYdaEgHMn5QUUWG72DIbTqhW8n3JJRC/8UsmpHqeCMaS0A6GYeuTAhC27K8H36f3pYDyiGuGXzIrb4SDiuJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvPQdGTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A56C2BD10;
	Wed, 29 May 2024 08:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716971374;
	bh=DgDwrueIemNRUbe/G47rptzZcqdtSi36/c0CqD/3bpc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lvPQdGTUaVlg1aqniVj6oGLXetp4BruksxRNlzdqZhWsTycgI43tlsgfYsWEJslbj
	 uZb/1QwyF2o91i4ZfK7bU7qZmuUqSP9G9fjt2AQ25W49F50qhrApiVV82LNSllGKA7
	 0q3BEvK8qSNHaPPxmxClcCimaM3Ig9pm5pJL7P78Io/a1sCqW+I1zqp2t9rEhZ9KGl
	 tvqBqG7jK8M4jO491Ev9C0mcz/NV9NCbjQVvSbgfqUJMXrr3NTlPac3yb0ydK2Ad41
	 OYBktfPb0/Ma77o7VwXNlZwj6GOOsYTv2cO17kCdyJ2lLQ1MRkErq7eQ/cYYtLxg4r
	 ueNsvzrkbAH7w==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 29 May 2024 10:28:59 +0200
Subject: [PATCH v4 05/13] dt-bindings: PCI: rockchip-dw-pcie: Fix
 description of legacy irq
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-rockchip-pcie-ep-v1-v4-5-3dc00fe21a78@kernel.org>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
In-Reply-To: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
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
 h=from:subject:message-id; bh=DgDwrueIemNRUbe/G47rptzZcqdtSi36/c0CqD/3bpc=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLCnofyPD2dFfy2tyLyxpPX9s3lddundb7ydDrQ3WTWf
 KdI74Z7RykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACZS4sLwv9hs4aovpT8M32wW
 2qrXJLHnv/TVVx7bZQ8dU0oqtZmr0crwV0Su3Vedx+1EWVbGS+UbP/a7GDWp3VE+mbY54ZaHptk
 6dgA=
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
2.45.1


