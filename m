Return-Path: <linux-pci+bounces-12370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0051F962DFA
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 18:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30DC91C21B2B
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 16:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4111A4B9F;
	Wed, 28 Aug 2024 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rh1O4V0y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99330481B3;
	Wed, 28 Aug 2024 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864380; cv=none; b=Xm9dTZZebM2UpHheAVV28GyRS6b2mkqdFxVaGrmt6ceE1ly4bNh7fkjYvbB5QDhwa0TtoRJc0YHAJ+Ayo8PYwTG/ZkA/NzWEoMDzQ3yUtCDThYl2RonVuoM3Tv71B2JmyyitI/pawFQOuFkJncxzAr3DBfzIa6SvPWB3bXknSwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864380; c=relaxed/simple;
	bh=U5xX3GKkr2d12yI98udKBMU21MXMZn5AJOW3Mtt8gfg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Gu2DEj8Qx/BdfiBYWyNPT0NysIEOMX3G2CsK/WvXWHTokXccWRap3ydQeClSzuIOx3g127YYesQ7GDI2YJ8MY1oXtrDUo4n6l3gv7Fvfjv/A6PQ/RB/lcC3wejvTxD6MCPL0jfQBS1oc20EKEZwv+tUoHRaSc6f42jhzFgfEhvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rh1O4V0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E450BC4CEC4;
	Wed, 28 Aug 2024 16:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724864380;
	bh=U5xX3GKkr2d12yI98udKBMU21MXMZn5AJOW3Mtt8gfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rh1O4V0yAJ1jqMwSkI6kFQAL+oedHMuMG43hvZ20PlfiNLn34GoWBHKOl4EI6tLYB
	 n17cv2alts3tH8KfcpM4Nj+VHTHcSQVv9TGEdB64IMcutNsG6rYz3lsQqx3O8rU05Y
	 NM3d9VI3ZXuBknjEPZyoFu8OamdZIgZlOuGszoBG9iY8i4Eu+KwvVRVqh20V2KY5Ww
	 4Bb/pwcvPMolcKsSTZ/y3eTMfa0+o8/qIUR3KDj73tWf/yIsCMzkqjdFCpcOPhAXlB
	 aO9nD1ooe9tPNNQRcW3XT8NJYhYZJrXy3mGphNFp1GtBEiqeaClR8RHyOg4pwoXLZJ
	 40mFdxedxJlDg==
Date: Wed, 28 Aug 2024 11:59:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:PCI DRIVER FOR IMX6" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR IMX6" <linux-arm-kernel@lists.infradead.org>,
	"open list:PCI DRIVER FOR IMX6" <imx@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] MAINTAINERS: PCI: Add mail list imx@lists.linux.dev
 for NXP PCI controller
Message-ID: <20240828165937.GA26021@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826202740.970015-1-Frank.Li@nxp.com>

On Mon, Aug 26, 2024 at 04:27:39PM -0400, Frank Li wrote:
> Add imx mail list imx@lists.linux.dev for PCI controller of NXP chips
> (Layerscape and iMX).
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied to for-linus for v6.11, thanks!

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 11272143484ca..22125a392251b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17545,6 +17545,7 @@ M:	Roy Zang <roy.zang@nxp.com>
>  L:	linuxppc-dev@lists.ozlabs.org
>  L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +L:	imx@lists.linux.dev
>  S:	Maintained
>  F:	drivers/pci/controller/dwc/*layerscape*
>  
> @@ -17571,6 +17572,7 @@ M:	Richard Zhu <hongxing.zhu@nxp.com>
>  M:	Lucas Stach <l.stach@pengutronix.de>
>  L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +L:	imx@lists.linux.dev
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
>  F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> -- 
> 2.34.1
> 

