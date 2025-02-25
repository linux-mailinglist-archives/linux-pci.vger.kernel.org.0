Return-Path: <linux-pci+bounces-22389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015DAA44F3C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 22:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA9717AA5C8
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 21:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE1A21148B;
	Tue, 25 Feb 2025 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="UPaipt5F"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4180320FA9E;
	Tue, 25 Feb 2025 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520331; cv=pass; b=Sd1QoxeEfUOaBUNR8qr4IC8fTwgmyA/jctOiBszrZU5etc7jJKA0OLk3j69LvzlOemQXc91VAXEk9ydbfVFfVspBu9rsLIoKSIEtSvLk7eAZymn0TVHnOFJ7/HZE1Ccks+2Lk8mrys4hU2xYLgB5dCzL0Dxe7AAr0nM6yHYo0eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520331; c=relaxed/simple;
	bh=+ELnTD2jQXo2BD566+x6iNht2yvO8kyKXVBT0Jw+ND8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3L56J6+Gii6iJa3tw5f93gZHglXnpCXdDNhbrklDdnfCGF2R8nauLpfdMV/JqHPGIdEGjYzymOCAAC8mfV95iZ3rxKPE/isluD8T/TlEr82RxrdOK9ZWRu2WLE9MLx3qZtzcYd0IYjBtt6yLVqQR0CZ7zH0wMlfO73v5gHsx/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=UPaipt5F; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740520299; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kKpnwqL23qM255LDU7Kavm53nW5Sfsv/fiQCAMwjmhozGaXDh7gBbsN9XV69BvD6VHGdGdEkZkeyFYWoLaP4atl3j/FIjpWs0d+lVnOCAwEc97uub9MJN/I09m+xxNzZTY0OmJl9BPrCczZa0ZXqPP0PcgCitsOKJgySg89juXg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740520299; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gRvAwLbNIssG674AaLjZhtPbGgHizEjSnBjeusKXP4A=; 
	b=fs+RxRi3Dx1sHjH3ffMThzrKwCOhtPiwvTQivQx2+Z529hEKvHYDy1jDf8rhm+BcGKExafSCqrYxWUro1u56H5MN6hR8SSq1ODuVrMyiULEfAuS4tJ3HQubuICV12icDr8GlxDsAqkjm2e66Q59TtH3YEDH6hgds9JIAR/cIBhc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740520299;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=gRvAwLbNIssG674AaLjZhtPbGgHizEjSnBjeusKXP4A=;
	b=UPaipt5FnYaXKMPGeTGt2rQC6zrZWqvGss4ZULEqjqnAGwnkZnI2V6v1+As+pYHY
	bIzMtKbGkmY9HBgFN8HH10TVpf2bd8I28HVXoAOVgEQsJfe+arrBfO/8ThHTptes9KD
	aufIe8euQL5DeFgPEduRo4PN+0vzMvozv1VVFIdk=
Received: by mx.zohomail.com with SMTPS id 1740520296039872.1712499063477;
	Tue, 25 Feb 2025 13:51:36 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 040DF18040A; Tue, 25 Feb 2025 22:51:31 +0100 (CET)
Date: Tue, 25 Feb 2025 22:51:30 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	Simon Xue <xxm@rock-chips.com>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 1/2] dt-bindings: PCI: dw: rockchip: Add rk3576 support
Message-ID: <jzxf7a7xm4xm5yjgim2sqmxuvmtjrqupps3mnwvhbzimsu6zdk@75fyzct43n3e>
References: <20250225102611.2096462-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225102611.2096462-1-kever.yang@rock-chips.com>
X-ZohoMailClient: External

Hello Kever,

On Tue, Feb 25, 2025 at 06:26:10PM +0800, Kever Yang wrote:
> rk3576 is using DWC PCIe controller, with msi interrupt directly to GIC
> instead of using GIC ITS, so
> - no ITS support is required and the 'msi-map' is not required,
> - a new 'msi' interrupt is needed.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

You should either drop my Signed-off-by or add

Co-developed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Both options are fine with me, but the current one does not make
much sense :)

Greetings,

-- Sebastian

> 
> Changes in v7:
> - Move the rk3576 device specific schema out of common.yaml
> 
> Changes in v6:
> - Fix make dt_binding_check and make CHECK_DTBS=y
> 
> Changes in v5:
> - Add constraints per device for interrupt-names due to the interrupt is
> different from rk3588.
> 
> Changes in v4:
> - Fix wrong indentation in dt_binding_check report by Rob
> 
> Changes in v3:
> - Fix dtb check broken on rk3588
> - Update commit message
> 
> Changes in v2:
> - remove required 'msi-map'
> - add interrupt name 'msi'
> 
>  .../bindings/pci/rockchip-dw-pcie-common.yaml | 10 +++-
>  .../bindings/pci/rockchip-dw-pcie.yaml        | 55 +++++++++++++++++--
>  2 files changed, 57 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> index cc9adfc7611c..2150bd8b5fc2 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> @@ -65,7 +65,11 @@ properties:
>            tx_cpl_timeout, cor_err_sent, nf_err_sent, f_err_sent, cor_err_rx,
>            nf_err_rx, f_err_rx, radm_qoverflow
>        - description:
> -          eDMA write channel 0 interrupt
> +          If the matching interrupt name is "msi", then this is the combinded
> +          MSI line interrupt, which is to support MSI interrupts output to GIC
> +          controller via GIC SPI interrupt instead of GIC its interrupt.
> +          If the matching interrupt name is "dma0", then this is the eDMA write
> +          channel 0 interrupt.
>        - description:
>            eDMA write channel 1 interrupt
>        - description:
> @@ -81,7 +85,9 @@ properties:
>        - const: msg
>        - const: legacy
>        - const: err
> -      - const: dma0
> +      - enum:
> +          - msi
> +          - dma0
>        - const: dma1
>        - const: dma2
>        - const: dma3
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> index 550d8a684af3..4764a0173ae4 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -16,16 +16,13 @@ description: |+
>    PCIe IP and thus inherits all the common properties defined in
>    snps,dw-pcie.yaml.
>  
> -allOf:
> -  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> -  - $ref: /schemas/pci/rockchip-dw-pcie-common.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
>        - const: rockchip,rk3568-pcie
>        - items:
>            - enum:
> +              - rockchip,rk3576-pcie
>                - rockchip,rk3588-pcie
>            - const: rockchip,rk3568-pcie
>  
> @@ -71,8 +68,54 @@ properties:
>  
>    vpcie3v3-supply: true
>  
> -required:
> -  - msi-map
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +  - $ref: /schemas/pci/rockchip-dw-pcie-common.yaml#
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: rockchip,rk3576-pcie
> +    then:
> +      required:
> +        - msi-map
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3576-pcie
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 6
> +          maxItems: 6
> +        interrupt-names:
> +          items:
> +            - const: sys
> +            - const: pmc
> +            - const: msg
> +            - const: legacy
> +            - const: err
> +            - const: msi
> +    else:
> +      properties:
> +        interrupts:
> +          minItems: 5
> +        interrupt-names:
> +          minItems: 5
> +          items:
> +            - const: sys
> +            - const: pmc
> +            - const: msg
> +            - const: legacy
> +            - const: err
> +            - const: dma0
> +            - const: dma1
> +            - const: dma2
> +            - const: dma3
> +
>  
>  unevaluatedProperties: false
>  
> -- 
> 2.25.1
> 
> 

