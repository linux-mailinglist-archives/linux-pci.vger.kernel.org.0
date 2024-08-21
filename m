Return-Path: <linux-pci+bounces-11941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 466E49599E6
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 13:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798DD1C22214
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 11:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2566D1CFEAD;
	Wed, 21 Aug 2024 10:32:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA28205A79;
	Wed, 21 Aug 2024 10:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724236362; cv=none; b=WMzXA83HpIgpK3DT5mzm47Ro5VDkR7Ebl+ILAT/jIrB4OI1UaDzxl3/pGe2pulvhqC3LxgQkoXfALkPL6mwMYFbaS2XTo05PJvSLL+IaTqHV4qmqaWcr83r6tHZCS8HFtUYPpt4PPNXP9XVzasy2E1VnjXRZb0iRB1p5+k02GRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724236362; c=relaxed/simple;
	bh=9gVgLrSXnQUFcicxu3DQ133yEjMN6nNKhgaaZWULtpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ghQmeHxXxmlP872Y3vRrsJtRn8kcjV3Ygqmb0uM8p+VUYtA6ttVYX/m+ojeeVsyB1rw74uQdPAvJFlWVAsE1vvIQDo5ulscspxJNlNIhFrMWkHgc8Z5ITsM2ORImBuss5HloSyJuz13wRLHZGjgzMD8qnKiErHZaSSMosF4MfKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 21 Aug 2024 19:31:32 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 4CCAD200848A;
	Wed, 21 Aug 2024 19:31:32 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Wed, 21 Aug 2024 19:31:32 +0900
Received: from [10.212.247.18] (unknown [10.212.247.18])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 3A447AB187;
	Wed, 21 Aug 2024 19:31:31 +0900 (JST)
Message-ID: <e7bd8500-5001-4ba7-b050-f90b27a79e28@socionext.com>
Date: Wed, 21 Aug 2024 19:31:30 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: PCI: socionext,uniphier-pcie-ep: add
 top-level constraints
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240818172843.121787-1-krzysztof.kozlowski@linaro.org>
 <20240818172843.121787-3-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Cc: Xiaowei Song <songxiaowei@hisilicon.com>,
 Binghui Wang <wangbinghui@hisilicon.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20240818172843.121787-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 2024/08/19 2:28, Krzysztof Kozlowski wrote:
> Properties with variable number of items per each device are expected to
> have widest constraints in top-level "properties:" block and further
> customized (narrowed) in "if:then:".  Add missing top-level constraints
> for clock-names and reset-names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/pci/socionext,uniphier-pcie-ep.yaml          | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
> b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
> index f0d8e486a07d..93f3d0f4bb94 100644
> ---
> a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
> +++
> b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
> @@ -38,13 +38,17 @@ properties:
>       minItems: 1
>       maxItems: 2
>   
> -  clock-names: true
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
>   
>     resets:
>       minItems: 1
>       maxItems: 2
>   
> -  reset-names: true
> +  reset-names:
> +    minItems: 1
> +    maxItems: 2
>   
>     num-ib-windows:
>       const: 16

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

I'd appreciate if it could be applied in devicetree or pci.

Thank you,

---
Best Regards
Kunihiko Hayashi

