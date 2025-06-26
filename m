Return-Path: <linux-pci+bounces-30835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DF9AEA873
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC226174C33
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF82238141;
	Thu, 26 Jun 2025 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8mwf/sY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB5202996;
	Thu, 26 Jun 2025 20:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750971137; cv=none; b=Bm35NAid4zvhT9WVIAwihTcFJvuI0mn93wJk1NSH9YKHm+YKk0zLmRkZTg4V6Fjig7OEfn64wv7dEBYsCxm0LQ3LQBlG2UjwjTFW5TrF64iwWoDgj1XG30NWtcmSWyPdlUpIfDfXEiRdWIs1fUB4XT55QvHZNnEBsetdyTen+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750971137; c=relaxed/simple;
	bh=VmwWCYokdlC8jOCvqCBe2YFOkmeSeW51FKReJ7zNPCs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G64j0PtQARJ9FxyLvx/hrNUT6V1XR3jV1rhj6inPsya2UrB4tElVpTSStv8mCLtp4PUIXaoDuuncfEGHzSehzun31vbnC5krACQE9K+hOgYABqXYbf7GvJgT4oCmQ9t1+w7qUxjXxRrR3rlZodLSsJcwVjMuZgPPu4ACpQEACiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8mwf/sY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFCCC4CEEB;
	Thu, 26 Jun 2025 20:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750971136;
	bh=VmwWCYokdlC8jOCvqCBe2YFOkmeSeW51FKReJ7zNPCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o8mwf/sY/ugHaVLtQcqpEx6Y9kqIp90rg2s1JYalvTwKDEEq/ypjpg1I+vPqxkNx9
	 HBiFigB1f2evT4WOS1D1FAOZ8wlp57AvJ8Xc39WnyWidZ32kBf7Xp2Mfr5QBo1ltK4
	 xlqGCNWZoUKUk9843ZdB6I2bflgcuzwbsArZBXIJrnFaFK8GWrOVb8Uk/RqYRqV5NJ
	 dtnHS2CaOfE+lkqIrytzBVaK3/Kwkj70tmOQD7FMgNpQAbTyyvFzUPq+ZLXltpDiX1
	 KlWP25g78Wh7Hv9R+SlMOsBcwuOOzmcQbee4nSq/Ot64SdfuJkZa6bxtAYd5Bn1yWp
	 JyJBRrBHWyvQQ==
Date: Thu, 26 Jun 2025 15:52:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: dwc: Add one more reference
 clock
Message-ID: <20250626205215.GA1639554@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626073804.3113757-2-hongxing.zhu@nxp.com>

On Thu, Jun 26, 2025 at 03:38:02PM +0800, Richard Zhu wrote:
> Add one more reference clock "extref" to be onhalf the reference clock
> that comes from external crystal oscillator.

s/to be onhalf the reference clock/for a reference clock/

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> index 34594972d8db..ee09e0d3bbab 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> @@ -105,6 +105,12 @@ properties:
>              define it with this name (for instance pipe, core and aux can
>              be connected to a single source of the periodic signal).
>            const: ref
> +        - description:
> +            Some dwc wrappers (like i.MX95 PCIes) have two reference clock
> +            inputs, one from internal PLL, the other from off chip crystal
> +            oscillator. Use extref clock name to be onhalf of the reference
> +            clock comes form external crystal oscillator.

Maybe:

  Some dwc wrappers (like i.MX95 PCIes) have two reference clock
  inputs, one from an internal PLL, the other from an off-chip crystal
  oscillator. If present, 'extref' refers to a reference clock from
  an external oscillator.

> +          const: extref
>          - description:
>              Clock for the PHY registers interface. Originally this is
>              a PHY-viewport-based interface, but some platform may have
> -- 
> 2.37.1
> 

