Return-Path: <linux-pci+bounces-22409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 869B8A456B0
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 08:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1E43A2648
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 07:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF3A267F48;
	Wed, 26 Feb 2025 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orMVkifx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801F1624EA;
	Wed, 26 Feb 2025 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740555021; cv=none; b=QgwZf+p+ruMDSI4XvhPZGK9k30CF0H3EN3AKvzH1lCA02CuBQGE6QABZ5GtQzXWTvVvt5Vq1szE+Y9P4Q31G+M4zTHcAGysqOc+w7fi+ibGRIzuzW2EvOp+IJMH4ZXQQM6EJ2sL0wl4lyWfl0hROC/AQqB7XCCz0t9GP4JHtRhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740555021; c=relaxed/simple;
	bh=wtnd1/XXRkP1lzyc+LlUNzBBy4X9q2wxr2JDxp6SR3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpnQ+PgCL/Rq8OrxIlSojSdCSmGbi0ikhtF/KO/cFveRwbQw45ZwixmCKkr+ugx8HGfrGr5DiGM9vmBpGC8A735sPm+0IpbRD064s0cZFJLHjviNoS00561D9H0DMRqFJTTAPvcbCVggjwuhlnpAgzGmQOfVXTz3GSPd/MBu8cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orMVkifx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CC4C4CED6;
	Wed, 26 Feb 2025 07:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740555020;
	bh=wtnd1/XXRkP1lzyc+LlUNzBBy4X9q2wxr2JDxp6SR3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=orMVkifxynbHqu5sHKtW4cb/uJTJfB7a44IAbaj3ZXQkCAeosHqkkMqPZrOhEvrR+
	 NGnFdEzDXi08kkIcuvGdCZTLLE9ESStU0eAjM2QYxq42ofWpeYxSJs/xExW1EHwhYH
	 a3PwBkVulfHLqLAU/GZolDNNO3uYJCnQfoqZgjOU9SUphNnM2zlfCKKSyirz/rr+SD
	 NRXZ2WHbZQAMb4Ao9hbgsr9Onxs9nuTh2NP8dKw+IiSJb+fERUnsCvAYW4nIzfUHCw
	 d5IIP2FIAdEPHlChDxxz9AbUQEcDnDBQq6Dj02YDrYfdriUc4Y9xCFjXgaRLfNEiE+
	 JPOVNjOgvTocA==
Date: Wed, 26 Feb 2025 08:30:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	chaitanya chundru <quic_krichai@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com, 
	amitk@kernel.org, dmitry.baryshkov@linaro.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	jorge.ramirez@oss.qualcomm.com
Subject: Re: [PATCH v4 01/10] dt-bindings: PCI: Add binding for Toshiba
 TC956x PCIe switch
Message-ID: <20250226-eager-urchin-of-performance-b71ae4@krzk-bin>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-1-e08633a7bdf8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225-qps615_v4_1-v4-1-e08633a7bdf8@oss.qualcomm.com>

On Tue, Feb 25, 2025 at 03:03:58PM +0530, Krishna Chaitanya Chundru wrote:
> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> Add a device tree binding for the Toshiba TC956x PCIe switch, which
> provides an Ethernet MAC integrated to the 3rd downstream port and two
> downstream PCIe ports.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Drop, file was named entirely different. I see other changes, altough
comparing with b4 is impossible.

Why b4 does not work for this patch?

  b4 diff '20250225-qps615_v4_1-v4-1-e08633a7bdf8@oss.qualcomm.com'
  Checking for older revisions
  Grabbing search results from lore.kernel.org
  Nothing matching that query.

Looks like you use b4 but decide to not use b4 changesets/versions. Why
making it difficult for reviewers and for yourself?


> ---
>  .../devicetree/bindings/pci/toshiba,tc956x.yaml    | 178 +++++++++++++++++++++
>  1 file changed, 178 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml
> new file mode 100644
> index 000000000000..ffed23004f0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml

What is "x" here? Wildcard?

> @@ -0,0 +1,178 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/toshiba,tc956x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba TC956x PCIe switch
> +
> +maintainers:
> +  - Krishna chaitanya chundru <quic_krichai@quicinc.com>
> +
> +description: |
> +  Toshiba TC956x PCIe switch has one upstream and three downstream

TC9560? Which one are you using here?

> +  ports. The 3rd downstream port has integrated endpoint device of
> +  Ethernet MAC. Other two downstream ports are supposed to connect
> +  to external device.
> +
> +  The TC956x PCIe switch can be configured through I2C interface before
> +  PCIe link is established to change FTS, ASPM related entry delays,
> +  tx amplitude etc for better power efficiency and functionality.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - "pci1179,0623"

Why quotes?

> +      - const: pciclass,0604
> +
> +  reg:
> +    maxItems: 1
> +
> +  i2c-parent:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      A phandle to the parent I2C node and the slave address of the device
> +      used to do configure tc956x to change FTS, tx amplitude etc.
> +    items:
> +      - description: Phandle to the I2C controller node
> +      - description: I2C slave address
> +
> +  vdd18-supply: true
> +
> +  vdd09-supply: true
> +
> +  vddc-supply: true
> +
> +  vddio1-supply: true
> +
> +  vddio2-supply: true
> +
> +  vddio18-supply: true
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO controlling the RESX# pin.
> +
> +allOf:
> +  - $ref: "#/$defs/tc956x-node"
> +
> +patternProperties:
> +  "^pcie@[1-3],0$":
> +    description:
> +      child nodes describing the internal downstream ports
> +      the tc956x switch.
> +    type: object
> +    $ref: "#/$defs/tc956x-node"
> +    unevaluatedProperties: false
> +
> +$defs:
> +  tc956x-node:
> +    type: object
> +
> +    properties:
> +      tc956x,tx-amplitude-microvolt:

You already got comments on this.

> +        $ref: /schemas/types.yaml#/definitions/uint32

Never tested.


> +        description:
> +          Change Tx Margin setting for low power consumption.
> +
> +      tc956x,no-dfe-support:

There is no such vendor prefix and you already got exactly the same
comment at v3. How did you resolve that comment?

> +        type: boolean
> +        description:
> +          Disable DFE (Decision Feedback Equalizer), which mitigates
> +          intersymbol interference and some reflections caused by impedance mismatches.
> +
> +    allOf:
> +      - $ref: /schemas/pci/pci-pci-bridge.yaml#
> +
> +unevaluatedProperties: false

Keep order as in example-schema.

Best regards,
Krzysztof


