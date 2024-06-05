Return-Path: <linux-pci+bounces-8283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 493FA8FC4A1
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 09:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB92C1F21CD9
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 07:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A6C1922F9;
	Wed,  5 Jun 2024 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2AVxhDl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F0C1922D6;
	Wed,  5 Jun 2024 07:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572856; cv=none; b=ZZ3at/h8IWPTjzEUwfT7siT/jbYv8U4Poh1q3/XKqSxkrzt6Nr+R1VZ/giyf/3AGfaSGWSIyNT78IWUhm8yOseN7W1NBRDQAJvl5d6F0NpIUKynYAU5AWs6o1xRzZg4EYQvqe28u+n6Tmsz3A6A0G9iOEc0TRqssOQhXn05MT88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572856; c=relaxed/simple;
	bh=9V9e410qufFFACyQFlVUelV9lIaXlofRulV74vDzxfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCzb01Ac4HyPt34sotg6pazJc42eJqJCRw5OXLMPvmZKoAuCvJpeBfPobfoHL78XSh9PSFJmuvlF41r1ScpHTsXPa01H3ANt7UPEMTLQAZtkxNKLcavWPDT1zU5l+RlXSmBj3yjoDeSs/M2F/J1kx+ZJ4/SUTnx5hudD9a5zaPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2AVxhDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8F0C3277B;
	Wed,  5 Jun 2024 07:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717572856;
	bh=9V9e410qufFFACyQFlVUelV9lIaXlofRulV74vDzxfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2AVxhDlzyIljyZdFm/NlDghoPVhQ7QEPtJEOmDALjn1iGoMguE/9v1bdpN/XIev6
	 OQT+L4yBGb4jLzr8S/lCos541KgvFJ8oFPYsdm08jAh36KIa0JCfFMY+ap2C4EHbT0
	 kqTzoyES3+TpKZy4mMX5yXdnylziQ0q2Obp0PZz5E3gzH6iLJK6i21m6cJVj+l0Q1v
	 VKrWkKj9pcPLFmpvJWt2mLMZnQ/fr9BzqMmy3kNRAbqTUSVSdQfwK4D+cWJRyHiUxP
	 oixu9Zwo5hDrRRrgN4fOH7MS3E5RDuc15IaZF4+y600jx/jTBt2PzdYuJ5wXNYw+QP
	 t0LZwHoacqVeQ==
Date: Wed, 5 Jun 2024 13:04:02 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 03/13] dt-bindings: PCI: snps,dw-pcie-ep: Add
 tx_int{a,b,c,d} legacy irqs
Message-ID: <20240605073402.GE5085@thinkpad>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
 <20240529-rockchip-pcie-ep-v1-v4-3-3dc00fe21a78@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529-rockchip-pcie-ep-v1-v4-3-3dc00fe21a78@kernel.org>

On Wed, May 29, 2024 at 10:28:57AM +0200, Niklas Cassel wrote:
> The DWC core has four interrupt signals: tx_inta, tx_intb, tx_intc, tx_intd
> that are triggered when the PCIe controller (when running in Endpoint mode)
> has sent an Assert_INTA Message to the upstream device.
> 
> Some DWC controllers have these interrupt in a combined interrupt signal.
> 
> Add the description of these interrupts to the device tree binding.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Nit: We recently changed the driver instances of 'LEGACY' to 'INTX'. But the
binding it still using 'legacy'. Considering that the 'legacy' IRQ added to the
RC binding recently (ebce9f6623a7), should we rename it?

This will force the driver to support both 'legacy' and 'intx' for backwards
compatibility.

But irrespective of that,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> index f5f12cbc2cb3..f474b9e3fc7e 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> @@ -151,6 +151,15 @@ properties:
>              Application-specific IRQ raised depending on the vendor-specific
>              events basis.
>            const: app
> +        - description:
> +            Interrupts triggered when the controller itself (in Endpoint mode)
> +            has sent an Assert_INT{A,B,C,D}/Desassert_INT{A,B,C,D} message to
> +            the upstream device.
> +          pattern: "^tx_int(a|b|c|d)$"
> +        - description:
> +            Combined interrupt signal raised when the controller has sent an
> +            Assert_INT{A,B,C,D} message. See "^tx_int(a|b|c|d)$" for details.
> +          const: legacy
>          - description:
>              Vendor-specific IRQ names. Consider using the generic names above
>              for new bindings.
> 
> -- 
> 2.45.1
> 

-- 
மணிவண்ணன் சதாசிவம்

