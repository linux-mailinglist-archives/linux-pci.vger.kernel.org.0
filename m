Return-Path: <linux-pci+bounces-10355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E426893212E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 09:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137EC1C20E60
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 07:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4395025761;
	Tue, 16 Jul 2024 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QypRgdP9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ABC4C7B;
	Tue, 16 Jul 2024 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721114915; cv=none; b=GR1rKnKB5eyrfDKepRe237aZ1EweFq+5PIFdDBVaKCgl+XWgqQ1bNq7Ee3oTHjPmPXSRitR686aDlTy0C0eSs+da0LQFyq1GBiaDg7O7xdJY9WEuaphMYXjSo/3fGFsv+4OR/xwMNSrXZFq3dyd2/jk53zvswaK4a2cWCYLIoBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721114915; c=relaxed/simple;
	bh=c8gKwuCOk0BMePqrAmzJ+naO6NCHrALTjEZjLHRx63w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OhrczpTcLYM7726ts7cQhun6F7S40T8Sp9kzSjdKamMtZhLCECrydwlPdaaqAEPu0clRIAaxxKLKit8wabY7lcYYwdWLKlJATxVw9U3VyFYx554DeGEkms69TaVNLoL5vwLFldR0UWbU05VCgq8cLQvYOiqMaS8p854XCdd5TG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QypRgdP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571F4C116B1;
	Tue, 16 Jul 2024 07:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721114914;
	bh=c8gKwuCOk0BMePqrAmzJ+naO6NCHrALTjEZjLHRx63w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QypRgdP93HikE8gYcxiniC0B9ttTo4MRomj/N2VgOQlPTlw2jUjPvHBzoFkS1eb+W
	 pR2K59Hx7msXMNLofqRuIyShXS4CTs5m/SkvnxlqPzMkXuv5DDy0L9/HBnHEbTtlTp
	 +Fdlr0GKtV4As8fYL3PApOVqC1JrOyPtZ+S0COJDBOq0ZKdQPLiJXubxyTnUWl6XWa
	 H3PSnQZyEnwj4h4o43jKsM4/89gYmO+MAQEVSkiVXWCMARmr1z0SPRG9Z4pVAz1D3z
	 EAupEF/jIG+/WpiV5SwcQ+JNvZn54bBuAqV8Y3+DjiYmR19VuIshaOecI9uNT0OFbP
	 IXb6E0i1hEy1A==
Message-ID: <5f029f16-2030-4e86-929b-0b2832958912@kernel.org>
Date: Tue, 16 Jul 2024 09:28:22 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V226/7] dt-bindings: PCI: host-generic-pci: Add
 snps,dw-pcie-ecam-msi binding
To: Mayank Rana <quic_mrana@quicinc.com>, will@kernel.org,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org, cassel@kernel.org,
 yoshihiro.shimoda.uh@renesas.com, s-vadapalli@ti.com,
 u.kleine-koenig@pengutronix.de, dlemoal@kernel.org, amishin@t-argos.ru,
 thierry.reding@gmail.com, jonathanh@nvidia.com, Frank.Li@nxp.com,
 ilpo.jarvinen@linux.intel.com, vidyas@nvidia.com,
 marek.vasut+renesas@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Cc: quic_ramkri@quicinc.com, quic_nkela@quicinc.com,
 quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com,
 quic_nitegupt@quicinc.com
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
 <1721067215-5832-7-git-send-email-quic_mrana@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <1721067215-5832-7-git-send-email-quic_mrana@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/07/2024 20:13, Mayank Rana wrote:
> To support MSI functionality using Synopsys DesignWare PCIe controller
> based MSI controller with ECAM driver, add "snps,dw-pcie-ecam-msi
> compatible binding which uses provided SPIs to support MSI functionality.

To support MSI, you add MSI support... That's a tautology. Describe
hardware instead.

> 
> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> ---
>  .../devicetree/bindings/pci/host-generic-pci.yaml  | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> index 9c714fa..9e860d5 100644
> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> @@ -81,6 +81,12 @@ properties:
>                - marvell,armada8k-pcie-ecam
>                - socionext,synquacer-pcie-ecam
>            - const: snps,dw-pcie-ecam
> +      - description: |
> +         Firmware is configuring Synopsys DesignWare PCIe controller in RC mode with
> +         ECAM compatible fashion. To use MSI controller of Synopsys DesignWare PCIe
> +         controller for MSI functionality, this compatible is used.
> +        items:
> +          - const: snps,dw-pcie-ecam-msi

MSI is already present in the binding, isn't it? Anyway, aren't you
forgetting specific compatible? Please open your internal (quite
comprehensive) guideline on bindings and DTS.


>        - description:
>            CAM or ECAM compliant PCI host controllers without any quirks
>          enum:
> @@ -116,6 +122,20 @@ properties:
>        A phandle to the node that controls power or/and system resource or interface to firmware
>        to enable ECAM compliant PCIe root complex.
>  
> +  interrupts:
> +    description:
> +      DWC PCIe Root Port/Complex specific MSI interrupt/IRQs.
> +    minItems: 1
> +    maxItems: 8
> +
> +  interrupt-names:
> +    description:
> +      MSI interrupt names
> +    minItems: 1
> +    maxItems: 8
> +    items:
> +        pattern: '^msi[0-9]+$'

Why the same devices have variable numbers?

> +
>  required:
>    - compatible
>    - reg
> @@ -146,11 +166,22 @@ allOf:
>          reg:
>            maxItems: 1


Best regards,
Krzysztof


