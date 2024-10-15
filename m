Return-Path: <linux-pci+bounces-14590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE54199FAC9
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 00:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECF91F22854
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 22:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED361B0F0E;
	Tue, 15 Oct 2024 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiF3dOBd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1659338DE9;
	Tue, 15 Oct 2024 22:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729029776; cv=none; b=ZUsbabl/7Wy3iUQUKsYo+u81kQ6ZJON6gAnpRN+bxn7jCm9crceCvO80P7CJghN4BHvABVVO+Uza66JOOwWyfmDfjbkk970rHgq51UKs9K+j24mVvump4OJxyNQcnNSt1RKojDX/to8D+z2t0ExMBYXfCOltm7SiAZwvkurQzMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729029776; c=relaxed/simple;
	bh=X0Rvixf1qnnNpSRTwWM3Y7ex5D+CLcnHZdWnoTkBnOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9dcALDLvWvBLtGZR1G/4BtjbzfCxCZitEZY2sWp7qhmmrzFQ7vNTbHgOmlXed4EPANMLLVxuRCQZ5nU/rbJjK8ZyFnARmG0eoJLbB910lEaIuiGL7ynw6AzsE9RnTL0Sef63cOBe4HnYbrnfhqLp8FTsNz4Cft68waAJ+/igdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiF3dOBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6983BC4CEC6;
	Tue, 15 Oct 2024 22:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729029775;
	bh=X0Rvixf1qnnNpSRTwWM3Y7ex5D+CLcnHZdWnoTkBnOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hiF3dOBdou3YJeiimqjqktlFcGC3xTWFSYi3iiRH14EElSzaxuQRIFjig3nWAQJR9
	 Yn0qPTypg2kFBuzobhfecjvXj2ZCFONb8j87WZ6vuK9r858p/v9vL+aYZP9z7JShV9
	 p0w3tFXAgjsv79QtH6ywDokn2B39Z4NAoMbpZQdRzS0lyIC3E9HzRR3e4QvFWDkgPH
	 54/tvUBLJXxm27/QG0C1KF4VHla8LfBJr2cwGQF98IxHDbw3a+b+wMLqSGydSwdj5G
	 TkWXp6Bp8zaVKmsqjTVxM6RxZt2AvAiNqSkW9lQNxRiIcwyCziM08c3nQTYZVB0zCv
	 8ZLOs75QQEoXQ==
Date: Tue, 15 Oct 2024 17:02:54 -0500
From: Rob Herring <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com, Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 net-next 03/13] dt-bindings: net: add bindings for
 NETC blocks control
Message-ID: <20241015220254.GA2025619-robh@kernel.org>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-4-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015125841.1075560-4-wei.fang@nxp.com>

On Tue, Oct 15, 2024 at 08:58:31PM +0800, Wei Fang wrote:
> Add bindings for NXP NETC blocks control. Usually, NETC has 2 blocks of
> 64KB registers, integrated endpoint register block (IERB) and privileged
> register block (PRB). IERB is used for pre-boot initialization for all
> NETC devices, such as ENETC, Timer, EMIDO and so on. And PRB controls

EMIDO or EMDIO? 

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
> ---
>  .../bindings/net/nxp,netc-blk-ctrl.yaml       | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
> new file mode 100644
> index 000000000000..18a6ccf6bc2e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
> @@ -0,0 +1,107 @@
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
> +
> +  clocks:
> +    items:
> +      - description: NETC system clock

Just 'maxItems: 1' is enough. The description doesn't add much.
> +
> +  clock-names:
> +    items:
> +      - const: ipg_clk

Just 'ipg'

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
> +  - "#address-cells"
> +  - "#size-cells"
> +  - reg
> +  - reg-names
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
> +            compatible = "nxp,imx95-netc-blk-ctrl";
> +            reg = <0x0 0x4cde0000 0x0 0x10000>,
> +                  <0x0 0x4cdf0000 0x0 0x10000>,
> +                  <0x0 0x4c81000c 0x0 0x18>;
> +            reg-names = "ierb", "prb", "netcmix";
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges;
> +            clocks = <&scmi_clk 98>;
> +            clock-names = "ipg_clk";
> +            power-domains = <&scmi_devpd 18>;
> +
> +            pcie@4cb00000 {
> +                compatible = "pci-host-ecam-generic";
> +                reg = <0x0 0x4cb00000 0x0 0x100000>;
> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +                device_type = "pci";
> +                bus-range = <0x1 0x1>;
> +                ranges = <0x82000000 0x0 0x4cce0000  0x0 0x4cce0000  0x0 0x20000
> +                          0xc2000000 0x0 0x4cd10000  0x0 0x4cd10000  0x0 0x10000>;
> +
> +                mdio@0,0 {
> +                    compatible = "pci1131,ee00";
> +                    reg = <0x010000 0 0 0 0>;
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.34.1
> 

