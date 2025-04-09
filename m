Return-Path: <linux-pci+bounces-25536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E47C3A81DE3
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 09:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63CE57AA7F7
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 07:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6799322A80D;
	Wed,  9 Apr 2025 07:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PrD1SWNd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE70022B597
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 07:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182381; cv=none; b=JnrLoMpKGfBPQqQw3dsIj5pTPbK+He698KKTgChVNRdjNkhVuBJjC+iPwWSyxRXQu0LtfS7ccMKvANTx7f4HBIG2lbjHDyBja5LTo5A+uUP3KK4FODqrg26TpTyaGX/E+tpDHUF4vgrI2vy9nqBy8zmlj6zile0y9DkgxEF/M0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182381; c=relaxed/simple;
	bh=yS+f3fqEzIoMXoYigNyYL1iRCbrDvUkMQNrAccauF30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK7wqyRldNbdB+G7/4qnFV9E0q5bIMDNd8BI0UzcZ/iAUJpCcTqJ5hSTGDPaN4hwLYxIwRDFCQ7iqcyYw7+Ef9jyhWGqKKV/WNNqzq84m0iUHyFvBfdy6f9ecnporrnK85r8XKCbu2mXoQw0yaeaB8lz1mPQYNZnpoJiVIdgacI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PrD1SWNd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22a976f3131so37513795ad.3
        for <linux-pci@vger.kernel.org>; Wed, 09 Apr 2025 00:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744182379; x=1744787179; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nm7nG2cOghl5We3pl16VQKS1/9Lv238uk1E4idOp5vQ=;
        b=PrD1SWNdTtPZUgQjRNif2ls9MubJr9v7WpJMbQBGMplnDg/ESsiWZdjv3qFwkjXX84
         lONLGQro2/xnruJpKObbR0aS2CwXuG+xYN7mEDe6swzRcwdKYHIsV0Tdsf7qulqmhtGs
         Cc8rW41SvaR0djm60tukZRnm7/UJwVxZfwxkgxrg3Tr655x/wfxsO4clFVrmI7HuSYf/
         de5vws9DkS4T4CONHe/9F/zIFWKLZezzppEir0ux2e3BT9qXb+QxEmfcGt7X0//8ObMG
         o9xHdnnb1H9q0Krb0GTqrwVDZp/zBjXN+7WsSUD+qKjqcbBhQI5bcyCIkorcYa4Wfe0y
         Ch+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744182379; x=1744787179;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nm7nG2cOghl5We3pl16VQKS1/9Lv238uk1E4idOp5vQ=;
        b=SpkjiFCAd9X7emMypec3r0AvTKKF6EMWJ8Pr+VXqlSc41wLxg9Mf7gUNIIxEaX7G8p
         VOde3UFM7zAWwrW6dpo6udhabqjIOcNB1nTte6sNcjVwgvfXpTEfFCADZBr8n1GJn1cj
         +4RudYtho5Rs97gqhhl8TMOxjyqgNBWVHXQc1vr+UvGxpT7whWVXhP6WoxfufZJWiYdz
         +kYHuxIMRlps29YvLf60RbN9X5tQqEtoo6jal7j9oju/CmCELpYnvwPgcq5r/MpkQsQP
         8CtGsDLsdyjGF5XV17S6e1Ya2kzG/cEG9/fmDOLd6hvOevb5l7b4+ZySWffY7CQiT/z1
         4WSA==
X-Forwarded-Encrypted: i=1; AJvYcCXesPcX5+zUl/C9OGiIOiMGLP5sEwGkRatNEnygGNsvqrABgp3A7x+oXW6uKZSsLvVoz1qLOcKPxJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykEzr6QgV70vGsfgUudcZ5kaFPN8rZe4sLs/0ee0PIWemHAVCf
	U/EBizAi1CAZzOgYtrHWHDkjQoU3VA8cjDfxPR7XgJrxIVUTc/ID4klF5Q/DEQ==
X-Gm-Gg: ASbGncsKQcFBQeMiHubG43QxqaAhS0/WCOXHSM+sXVdpGrBlqtFAHCGb22yUO4It62F
	lq3uxw6KdL3hmensiDCAIvnjFKdryDdrl/bfXvOstH6SDvkg377qewvcefZtRYIup4dDIPURJ/a
	ueT0MYvARdSJHUqKmtFj1TEg+XzYZm9Z9SWuLWPd98PSo/H/eGoFiAJdOU5yFcm6u3SLQRMkfK4
	IwOgPdlmK5N5I7bZotzeqB5M2ZU/y1kjaoWZiD85x9x9N8mVXz5yxNBnk64AAG+sx/RhOnkMcgl
	NIh+CEYDS5RX2ctnYk9NxQ6RHWWDqs72QrJeLNfsVUYc+Cg4NJg=
X-Google-Smtp-Source: AGHT+IG2IBbUsP4jpyoBsAQl7I0S2iGdcUbnYfvvANGYcDIZAtyYHJ27CyPFx40ttshkAUckDfLO7g==
X-Received: by 2002:a17:903:3bc6:b0:224:10a2:cad9 with SMTP id d9443c01a7336-22ac2a2991bmr35596635ad.41.1744182379003;
        Wed, 09 Apr 2025 00:06:19 -0700 (PDT)
Received: from thinkpad ([120.56.198.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb5047sm4544815ad.170.2025.04.09.00.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 00:06:18 -0700 (PDT)
Date: Wed, 9 Apr 2025 12:36:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Srikanth Thokala <srikanth.thokala@intel.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Greentime Hu <greentime.hu@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Tom Joseph <tjoseph@cadence.com>, Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: PCI: sifive,fu740-pcie: Fix include
 placement in DTS example
Message-ID: <3cfkeludmigojzadrgyxyidiydb3mx6yqjcvmgpbhdk75cflog@66i4zpvjcwzv>
References: <20250324125202.81986-1-krzysztof.kozlowski@linaro.org>
 <20250324125202.81986-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324125202.81986-2-krzysztof.kozlowski@linaro.org>

On Mon, Mar 24, 2025 at 01:52:02PM +0100, Krzysztof Kozlowski wrote:
> Coding style and common logic dictates that headers should not be
> included in device nodes.  No functional impact.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> index 844fc7142302..d35ff807936b 100644
> --- a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> @@ -81,10 +81,10 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/clock/sifive-fu740-prci.h>
>      bus {
>          #address-cells = <2>;
>          #size-cells = <2>;
> -        #include <dt-bindings/clock/sifive-fu740-prci.h>
>  
>          pcie@e00000000 {
>              compatible = "sifive,fu740-pcie";
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

