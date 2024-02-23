Return-Path: <linux-pci+bounces-3940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AECA38615A6
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 16:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E0AB23F9C
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53F9823BD;
	Fri, 23 Feb 2024 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSicxWO8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45BB12837F;
	Fri, 23 Feb 2024 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701814; cv=none; b=G6RTAZXc9FPHtw5kxEsNaV1IqkcxpcMWH1GeBQEMvCcEUhNHopM74AIUKXCdv2Zq3oCR3sC15KF1Z7yiwgy7m6C0RMNqw8gp6QLkkkkfg0iOV1HuklkMTmN3cFE2KKTe8BR0U6VNTugKgMq8sR+8GjaabRu+eKoc4SqlDYuCKEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701814; c=relaxed/simple;
	bh=Oo4aVLf/a0kVvy0C4MHK+lMmvRhOxhEviQGNLVunAqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYk8V/BF29kQqAQFMTKiFtNsvF0dysudfkQGX4yU7V9mBCfxL3IgaYz6jHAZGkBjyr2wbwBaruFqOfn5zXga7ffPuznk+eGJ+StPSEZTgZ7oGDsOLJg9KnyHV4Czv3pwpr/HliGmhhdwuO9eqyjk0h3So96dgsdCHLjjNla+RrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSicxWO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76841C433C7;
	Fri, 23 Feb 2024 15:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701813;
	bh=Oo4aVLf/a0kVvy0C4MHK+lMmvRhOxhEviQGNLVunAqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BSicxWO8D7WH67GAmQgA5La9V3x1VKQZ5bVa7eyiA0sM4zo80hefi/bx3tFF/4Nsk
	 86xDnkdU0HlxKL/j+gCbADcrO35ox0BA7yTqQQ/fhtyPt12WuOVSCS2ZegBA4xmqiU
	 iZwd5EWwIgcDvcOO5TUwxX17Km78v3C3d9x28RMMeXNyMQjB3xntv7DDjQmamBiRte
	 BV1ve0fzDUFVAOeKk0UpPtCPXBKn13AA69KxG3JGjDMfJoaz1S/5F8IeiJhrB4aAEz
	 OkVmTWEimbL8sfV3AdMQlc9jrJse2yBd33HyuKaK841MIFZEdE6mGIUc9Woz9ZKJJy
	 G3NN1J4U0Dlpw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Frank.li@nxp.com,
	bhelgaas@google.com,
	cassel@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v11 00/14] PCI: imx6: Clean up and add imx95 pci support
Date: Fri, 23 Feb 2024 16:23:24 +0100
Message-Id: <170870177640.190909.13423263048571416476.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220161924.3871774-1-Frank.Li@nxp.com>
References: <20240220161924.3871774-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 20 Feb 2024 11:19:10 -0500, Frank Li wrote:
> first 6 patches use drvdata: flags to simplify some switch-case code.
> Improve maintaince and easy to read code.
> 
> Then add imx95 basic pci host function.
> 
> follow two patch do endpoint code clean up.
> Then add imx95 basic endpont function.
> 
> [...]

Applied to enumeration, thanks!

[01/14] PCI: imx6: Simplify clock handling by using clk_bulk*() function
        https://git.kernel.org/pci/pci/c/6a4018583875
[02/14] PCI: imx6: Simplify phy handling by using IMX6_PCIE_FLAG_HAS_PHYDRV
        https://git.kernel.org/pci/pci/c/4e37c2f48712
[03/14] PCI: imx6: Simplify reset handling by using by using *_FLAG_HAS_*_RESET
        https://git.kernel.org/pci/pci/c/666a7beb942c
[04/14] PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
        https://git.kernel.org/pci/pci/c/cb7b0cd26d3a
[05/14] PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
        https://git.kernel.org/pci/pci/c/e35c3c580740
[06/14] PCI: imx6: Simplify switch-case logic by involve init_phy callback
        https://git.kernel.org/pci/pci/c/a6afefd72856
[07/14] dt-bindings: imx6q-pcie: Clean up irrationality clocks check
        https://git.kernel.org/pci/pci/c/0aa0c28fd259
[08/14] dt-bindings: imx6q-pcie: Restruct reg and reg-name
        https://git.kernel.org/pci/pci/c/0efd53a842c8
[09/14] dt-bindings: imx6q-pcie: Add imx95 pcie compatible string
        https://git.kernel.org/pci/pci/c/41b116c2cf24
[10/14] PCI: imx6: Add iMX95 PCIe Root Complex support
        https://git.kernel.org/pci/pci/c/98e97fb574b1
[11/14] PCI: imx6: Clean up get addr_space code
        https://git.kernel.org/pci/pci/c/b16b852e3175
[12/14] PCI: imx6: Add epc_features in imx6_pcie_drvdata
        https://git.kernel.org/pci/pci/c/e2f2029ddf3f
[13/14] dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
        https://git.kernel.org/pci/pci/c/4d80ef68c2c7
[14/14] PCI: imx6: Add iMX95 Endpoint (EP) support
        https://git.kernel.org/pci/pci/c/b73259dcd670

Thanks,
Lorenzo

