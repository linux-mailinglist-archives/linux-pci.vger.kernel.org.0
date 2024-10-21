Return-Path: <linux-pci+bounces-14950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D339D9A72E0
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 21:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582D21F248AF
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 19:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3D21FBC98;
	Mon, 21 Oct 2024 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAC5eGI2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E761F942D;
	Mon, 21 Oct 2024 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537416; cv=none; b=tvyGwlryrIovJwdznX2QxXRfXrTt39ri/fmVP4W1xVnsq1EjnNxDXjgPPd0OdFAJZKhRwvELim0xGGEg2iSDQAL2MMmSKM2XKHR0pzOV9MfKyWeheEKrbWDnyyCTCzNLqV4Bf0M1lGXZAUjWU1D5oJsriTEWhHgKi6YhRLRlP+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537416; c=relaxed/simple;
	bh=rBGnIU2ChSzNbvZ5Xe+O+3llHRdoMbcsKIPRGW3IyNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeSI3Kz6rmBLn878AHMgXlQXpzSePs7jxqy/DZXdxkT7OZGRBVV5mn8MBQK9+z/mk8CqIbo7jmjIx1ub3IdxOUNHSJvbdFT+C5BfCtRT49p9oKHggcX94ULNSUS1eP5mptFyanBqxuHbsedW2r4ZTgSnqhuFoW4K5Ds6EuFIyCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAC5eGI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794AEC4CEC3;
	Mon, 21 Oct 2024 19:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729537415;
	bh=rBGnIU2ChSzNbvZ5Xe+O+3llHRdoMbcsKIPRGW3IyNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAC5eGI2h/vU8QtDowYR5TEPWsNlzjzTbJNgFcJV+n7COFotJ1Q7xfI84gbctw3b9
	 xlqtgRvkP7flzhq9MEQkb0t4Xg556IzWC/tm1+4LRsZaB3rmqHET8h76REqdPUnAqT
	 zJ7Zkwc72vXITR1iaOR5mlPEL9iT4HNXWjRxRVKO1DrkXdFjosjO8NCH80EERSeXsb
	 G6A8xN/lidTdzW1c1Ne0v8G73APArjVXQ+zP+CoCr/ZOivQbyscczPstZww+ZtW+05
	 +DOAV5G1iqMOQA2ub6TOuQLcX2gZn5iqlDbrZ/zFeKDS97V8jMsSxK1I9alECXvV0x
	 5hJaIEecAgl7g==
Date: Mon, 21 Oct 2024 14:03:34 -0500
From: Rob Herring <robh@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] RFC: dt bindings: Add property "brcm,gen3-eq-presets"
Message-ID: <20241021190334.GA953710-robh@kernel.org>
References: <20241018182247.41130-1-james.quinlan@broadcom.com>
 <20241018182247.41130-2-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018182247.41130-2-james.quinlan@broadcom.com>

On Fri, Oct 18, 2024 at 02:22:45PM -0400, Jim Quinlan wrote:
> Support configuration of the GEN3 preset equalization settings, aka the
> Lane Equalization Control Register(s) of the Secondary PCI Express
> Extended Capability.  These registers are of type HwInit/RsvdP and
> typically set by FW.  In our case they are set by our RC host bridge
> driver using internal registers.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 0925c520195a..f965ad57f32f 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -104,6 +104,18 @@ properties:
>      minItems: 1
>      maxItems: 3
>  
> +  brcm,gen3-eq-presets:
> +    description: |
> +      A u16 array giving the GEN3 equilization presets, one for each lane.
> +      These values are destined for the 16bit registers known as the
> +      Lane Equalization Control Register(s) of the Secondary PCI Express
> +      Extended Capability.  In the array, lane 0 is first term, lane 1 next,
> +      etc. The contents of the entries reflect what is necessary for
> +      the current board and SoC, and the details of each preset are
> +      described in Section 7.27.4 of the PCI base spec, Revision 3.0.

If these are defined by the PCIe spec, then why is it Broadcom specific 
property?

> +
> +    $ref: /schemas/types.yaml#/definitions/uint16-array

minItems: 1
maxItems: 16

Last I saw, you can only have up to 16 lanes.

Rob

