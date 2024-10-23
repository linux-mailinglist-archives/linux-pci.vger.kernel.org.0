Return-Path: <linux-pci+bounces-15097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554419ABF61
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 08:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F301C21228
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 06:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB4114B06E;
	Wed, 23 Oct 2024 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVE5WCO5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A202622318;
	Wed, 23 Oct 2024 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666588; cv=none; b=YesP2fBPAy38BTQRtqiqynE/nsWnGR6A6N7mm6VALQRdt7RsYoq52LsRsgNfV0cKmkufgTCy/+ihKnfWnDDdO9NgBkVTlSQTnarlD68rfvf4SA54hzXwYl5X7MZoQQaK+Uo/R3v7P/f8l9MZX1ZvGpe0gsnRhQAbIWF6qYDi2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666588; c=relaxed/simple;
	bh=4qN2s5zoqbBxdDlMfTyfRaNHDkUJuWvdiUUIKG6VDd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkbcRsID6+rI0IXOpz7hGzMkxWDDjsjfxo1i/WKfB5qoxzaMgMh8idRzIoNINW5ZlgDzg7X+Q8Vz1zQn9RwozHdYqKMetaSNXDLZvwenJQhan28ZEheO6DCchnHn7FMnJTXQipgXcP9F5yKLHhzyR/VYMXFG7LYHVi6aqMNaRBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVE5WCO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B394C4CEC6;
	Wed, 23 Oct 2024 06:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729666588;
	bh=4qN2s5zoqbBxdDlMfTyfRaNHDkUJuWvdiUUIKG6VDd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YVE5WCO5DRwWkG+GV1aoV89agNuEAs2GEodGFVvE+MsGkHdnK5b/XaWcJ5fUxe3vu
	 sPxulQMsTQWdRANFmgkaQGGeN3fVFRTwWFqtwsuYFZiptRaZAwoAzhAYgLbWdFXtno
	 0eC2n3lEIVE+JI/Cs2Ct5QgtOt3/dPBN5+zPsPccvmT0KvrxAYYme92SocA+1/25OW
	 lkjNaOCjkGJkrKAxr6KwESPq0uO/H/cXZi/LA7ao8rDu7SsqcHeCnc9d5GNtrSscFY
	 PhCv245wOYnuTBn52IfMG60dxDDmSG5Q/tqSHKaNHzk0br0mIad0WjA4ZoWeL6vqlf
	 x958z8MBz1CCA==
Date: Wed, 23 Oct 2024 08:56:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vladimir.oltean@nxp.com, claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, Frank.Li@nxp.com, 
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk, bhelgaas@google.com, horms@kernel.org, 
	imx@lists.linux.dev, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, alexander.stein@ew.tq-group.com
Subject: Re: [PATCH v4 net-next 03/13] dt-bindings: net: add bindings for
 NETC blocks control
Message-ID: <xx4l4bs4iqmtgafs63ly2labvqzul2a7wkpyvxkbde257hfgs2@xgfs57rcdsk6>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-4-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022055223.382277-4-wei.fang@nxp.com>

On Tue, Oct 22, 2024 at 01:52:13PM +0800, Wei Fang wrote:
> Add bindings for NXP NETC blocks control. Usually, NETC has 2 blocks of
> 64KB registers, integrated endpoint register block (IERB) and privileged
> register block (PRB). IERB is used for pre-boot initialization for all
> NETC devices, such as ENETC, Timer, EMDIO and so on. And PRB controls
> global reset and global error handling for NETC. Moreover, for the i.MX
> platform, there is also a NETCMIX block for link configuration, such as
> MII protocol, PCS protocol, etc.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes:
> 1. Rephrase the commit message.
> 2. Change unevaluatedProperties to additionalProperties.
> 3. Remove the useless lables from examples.
> v3 changes:
> 1. Remove the items from clocks and clock-names, add maxItems to clocks
> and rename the clock.
> v4 changes:
> 1. Reorder the required properties.
> 2. Add assigned-clocks, assigned-clock-parents and assigned-clock-rates.
> ---
>  .../bindings/net/nxp,netc-blk-ctrl.yaml       | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
> new file mode 100644
> index 000000000000..0b7fd2c5e0d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/nxp,netc-blk-ctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NETC Blocks Control
> +
> +description:
> +  Usually, NETC has 2 blocks of 64KB registers, integrated endpoint register
> +  block (IERB) and privileged register block (PRB). IERB is used for pre-boot
> +  initialization for all NETC devices, such as ENETC, Timer, EMIDO and so on.
> +  And PRB controls global reset and global error handling for NETC. Moreover,
> +  for the i.MX platform, there is also a NETCMIX block for link configuration,
> +  such as MII protocol, PCS protocol, etc.
> +
> +maintainers:
> +  - Wei Fang <wei.fang@nxp.com>
> +  - Clark Wang <xiaoning.wang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,imx95-netc-blk-ctrl
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 3

You have one device, why this is flexible? Device either has exactly 2
or exactly 3 IO spaces, not both depending on the context.

> +
> +  reg-names:
> +    minItems: 2
> +    items:
> +      - const: ierb
> +      - const: prb
> +      - const: netcmix
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  ranges: true
> +  assigned-clocks: true
> +  assigned-clock-parents: true
> +  assigned-clock-rates: true

Drop these three.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: ipg
> +
> +  power-domains:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^pcie@[0-9a-f]+$":
> +    $ref: /schemas/pci/host-generic-pci.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        netc-blk-ctrl@4cde0000 {

system-controller? Don't use compatible as node name.

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Best regards,
Krzysztof


