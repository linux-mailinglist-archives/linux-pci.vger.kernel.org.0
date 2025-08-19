Return-Path: <linux-pci+bounces-34261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DBAB2BBE0
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 10:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24273A7F43
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 08:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF09320E6E2;
	Tue, 19 Aug 2025 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJnBqq+B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD2D18BC3D;
	Tue, 19 Aug 2025 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592215; cv=none; b=oamwFjXi+eEiH4YsgNErke30PZFyi19NluaGrbkUR9NPGkbsQLUgoPJ7iB90or3vMDduaOpbTTfw/IEnKKq9Btei1fUhqR3cU76HPQ49pihs1Woq2FGJy473dLgdu+440Bunj3JC15UrUHcVFD3QiKBLk+PDP+UOK/kMj5IwXQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592215; c=relaxed/simple;
	bh=Te4KR24g5JjkMDypQM9+bPiHN5Txeoy3EKnAS8A9PSg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=H7rsdjc9ZmuuezNLdrz8cdtd+85mEqZLE+qgmEnLusAzDhvS8ffskO6k/VrDq9lGbeUv5XvzY99LH0WxSLPg5Ak9gppfxBqIi63rCufR+ADA5Nup3ycLTGgB97nQ7ZeEn6++z9/1ud+I1MvFZwukrhATEOETMpqivDOl5ZLysO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJnBqq+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F558C4CEF1;
	Tue, 19 Aug 2025 08:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755592215;
	bh=Te4KR24g5JjkMDypQM9+bPiHN5Txeoy3EKnAS8A9PSg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=nJnBqq+B/PdXH9viS/GMk4WqVJqq9qFcvHBiU9+51wPiv7pVivxoDS1sz8OpK5Dmf
	 zVLVrO+IskEs/LCan2a+U3wm5yzRFPhoE/4twSKu6Ftt2nTQ9HelxEceH5Wride50M
	 1izQC9ofV/Q0M21R74s2F2u/evVE3EYMbNNPvS5vO7WDpB633TXxr1kJYBWx8Fox87
	 jWEK3QgZJNJS1FhWkluwIwVq8QayJ/UCmrhyr0eqO7TKhO3b7O3cTRt1QW8kMczExL
	 20w/HDS1u8z6EmAk1yVqvPNBxbVIptaW+Pod3U6hNkSipPTP4iFwLUbFtMk56nO60b
	 QKAOKCCwAjHrQ==
Date: Tue, 19 Aug 2025 03:30:14 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: festevam@gmail.com, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, krzk+dt@kernel.org, s.hauer@pengutronix.de, 
 lpieralisi@kernel.org, shawnguo@kernel.org, frank.li@nxp.com, 
 l.stach@pengutronix.de, bhelgaas@google.com, mani@kernel.org, 
 conor+dt@kernel.org, kernel@pengutronix.de, kwilczynski@kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
To: Richard Zhu <hongxing.zhu@nxp.com>
In-Reply-To: <20250819071630.1813134-2-hongxing.zhu@nxp.com>
References: <20250819071630.1813134-1-hongxing.zhu@nxp.com>
 <20250819071630.1813134-2-hongxing.zhu@nxp.com>
Message-Id: <175559221431.3513325.13023489258693158920.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: dwc: Add vaux regulator


On Tue, 19 Aug 2025 15:16:29 +0800, Richard Zhu wrote:
> Refer to PCIe CEM r6.0, sec 2.3 WAKE# Signal, WAKE# signal is only
> asserted by the Add-in Card when all its functions are in D3Cold state
> and at least one of its functions is enabled for wakeup generation.
> 
> The 3.3V auxiliary power (+3.3Vaux) must be present and used for wakeup
> process. Since the main power supply would be gated off to let Add-in
> Card to be in D3Cold, add the vaux and keep it enabled to power up WAKE#
> circuit for the entire PCIe controller lifecycle when WAKE# is supported.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250819071630.1813134-2-hongxing.zhu@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


