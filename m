Return-Path: <linux-pci+bounces-18967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E69FAE49
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 13:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA8818833D8
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 12:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C297B199FA4;
	Mon, 23 Dec 2024 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nx6bZ0N7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9657418FDDC;
	Mon, 23 Dec 2024 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734957019; cv=none; b=WU7zTc769N3Yus6H0K6hsAcJQck0V2rLHXaNT0Oe5r/jBj1jQi1WKSUDynDTW+O533wp9kTeM/Y/CWT7lghgT+43qyFaZ69owhJaGAz3T0ekIHiNa1GFLRL0qbRjEn5MFHaDL5rXNupNrh7em2+ReJRlXf7p4CjJChn0W7hviq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734957019; c=relaxed/simple;
	bh=6nXbrL1gwIytwF5O4XWcHKIPCE3bZ8kGnps/owl0hCU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=rijpoe96lKpTngtBSjQA/2QqH/XlQuP9ab6g7+Ja2UL6xSJaxXTvIR/kl/oTnlq2uiXCu1hO4T1MCk08pG7c1vBrnLUyZ9JEhDcGyOGfN/7PiJ9KncEiF8sPMvMYkZZoS/wjGNCvxRXlXWBSeeJVKUTgGr78hlZhOpzHkYdG1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nx6bZ0N7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA429C4CED3;
	Mon, 23 Dec 2024 12:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734957019;
	bh=6nXbrL1gwIytwF5O4XWcHKIPCE3bZ8kGnps/owl0hCU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Nx6bZ0N7x9kx21ITNGRYUptWqADRtrtEc4CBIHp1Xvaxrr6eECiGHwPb3xejQFZaH
	 XxpAF9MuZFAqDe+xlJtkB9vH9AtesxBtCEckTZON9jjmenbNOlB3RbN2bh+pgJ2orJ
	 7hNt3RFqWznstdgwtEzvm0Tx335YFql2Vwn6ws8DfeqjpOZZ17SvCkLusIL8yZ3F0w
	 UDIBaDhZTiosKMOt+l49dUUliqaYavE80CtjMdwp0cSWH4fmv1nHpWj984tkUXDr6f
	 xU60eoVFgX3QPWuZ5L0zbkyNHYlX9Z4FiuUGntG7hPcvcsC4IFicjveCTieJx3nKwA
	 KKtMsrlNto5eQ==
Date: Mon, 23 Dec 2024 06:30:17 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, heiko@sntech.de, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Simon Xue <xxm@rock-chips.com>, 
 linux-rockchip@lists.infradead.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
To: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241223110637.3697974-3-kever.yang@rock-chips.com>
References: <20241223110637.3697974-1-kever.yang@rock-chips.com>
 <20241223110637.3697974-3-kever.yang@rock-chips.com>
Message-Id: <173495701750.480868.16123444058526675248.robh@kernel.org>
Subject: Re: [PATCH v3 2/7] dt-bindings: PCI: dw: rockchip: Add rk3576
 support


On Mon, 23 Dec 2024 19:06:32 +0800, Kever Yang wrote:
> rk3576 is using dwc controller, with msi interrupt directly to gic instead
> of to gic its, so
> - no its suport is required and the 'msi-map' is not need anymore,
> - a new 'msi' interrupt is needed.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v3:
> - Fix dtb check broken on rk3588
> - Update commit message
> 
> Changes in v2:
> - remove required 'msi-map'
> - add interrupt name 'msi'
> 
>  .../devicetree/bindings/pci/rockchip-dw-pcie-common.yaml      | 4 +++-
>  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml   | 4 +---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml:85:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241223110637.3697974-3-kever.yang@rock-chips.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


