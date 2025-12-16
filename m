Return-Path: <linux-pci+bounces-43079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 369B8CC06FC
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 02:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D9023014D93
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 01:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C0723C516;
	Tue, 16 Dec 2025 01:21:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9715F21D3C0;
	Tue, 16 Dec 2025 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765848068; cv=none; b=P54DBFRfc7p0zAPl2ijojuvTUZBYuhheod7Wsru0WFWp89Dk1KbsT4g0TCUV6KZZFtGKnQPHP8Mu7N5c1udvyfOoQrxZmQdRu9ClkArfOOdK0loVpGWOZzyM6SBm1qcBjemzveGrei1D11RWr78X5Mg02XYr9pt9Hrj96TeVkJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765848068; c=relaxed/simple;
	bh=kGpfbrbMVheGJSnH0LAKgtj8UxEkHf/npB2J4NcjsFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/J/GJHzPor7NEH1mxiLe9khR4viwD4q8Ry4AMlq2BW0W1E02jC2CAOfdnIHdha0lBoFJ7cXzgUB+4dPsCdgiP4OdsxFEELiLHlMy/cf3KfVxF0n2s4VUiFrz/X6lixOlU6mKT/8Y1c0kBiXf3OiHQnpznsRIUR8StaBl7SjZM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 16 Dec 2025 10:21:04 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id 1C6372069FC4;
	Tue, 16 Dec 2025 10:21:04 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Tue, 16 Dec 2025 10:21:04 +0900
Received: from [10.212.247.110] (unknown [10.212.247.110])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id 56FA910A00E;
	Tue, 16 Dec 2025 10:21:03 +0900 (JST)
Message-ID: <3f1b7852-1494-4a73-8783-b578f9ad5d40@socionext.com>
Date: Tue, 16 Dec 2025 10:21:06 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: PCI: socionext,uniphier-pcie: Fix interrupt
 controller node name
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251215212456.3317558-1-robh@kernel.org>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20251215212456.3317558-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rob,

Thank you for pointing out.

On 2025/12/16 6:24, Rob Herring (Arm) wrote:
> The child node name in use by .dts files and the driver is
> "legacy-interrupt-controller", not "interrupt-controller".
After your change commit bcd7ec2cd720 were merged, it was a long time
before I realized I needed to fix it.

"interrupt-controller" is included in the list of Generic Names
Recommendation. Would it be better to apply (i.e. restore) this,
or fix the PCI driver and .dts?

> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   .../devicetree/bindings/pci/socionext,uniphier-pcie.yaml      | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
> b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
> index c07b0ed51613..8a2f1eef51bd 100644
> --- a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
> @@ -51,7 +51,7 @@ properties:
>     phy-names:
>       const: pcie-phy
>   
> -  interrupt-controller:
> +  legacy-interrupt-controller:
>       type: object
>       additionalProperties: false
>   
> @@ -111,7 +111,7 @@ examples:
>                           <0 0 0  3  &pcie_intc 2>,
>                           <0 0 0  4  &pcie_intc 3>;
>   
> -        pcie_intc: interrupt-controller {
> +        pcie_intc: legacy-interrupt-controller {
>               #address-cells = <0>;
>               interrupt-controller;
>               #interrupt-cells = <1>;

Thank you,

---
Best Regards
Kunihiko Hayashi

