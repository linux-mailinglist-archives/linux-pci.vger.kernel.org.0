Return-Path: <linux-pci+bounces-16830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDDA9CD9E0
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 08:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC5B1F21699
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 07:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0464618734F;
	Fri, 15 Nov 2024 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NeneI/Xq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0A7523A
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655573; cv=none; b=RrkpR85zSPCnv/4jMFiopu5DCAR0YPol4a/pUL6jMC6FHBN8zZGBAHZeQM0l3NHIHPPg8RaYvM5v6f743j/TzBf3K87ZpkfV6U6I6W/o8/9zGcIHn/93wI7PTSyQbKOuW66u9AE3z4zvpK4IjbFf1Kjqo8bAjBg/MeXJGNTcUUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655573; c=relaxed/simple;
	bh=kmy/XrVB2997ryrPkfAqlPTqEpXt76Ofqetkymj+YpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cX5vMIIvXB7g+nIOm38Xd1eqq/KW4AHev7I5jnz/IaqjlHrxtwWWF8/oQOZlZrXnyhW2OnT0OTkhmEzFaUwQmG4GOmjMTn8i1Do8xLfL9zqRPFSKTBFga3vjPDrG5HfzGC/o0xDf/J+TTKraPA8YmjFTcGKWHOj7i8ntgThCII8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NeneI/Xq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cdb889222so3808235ad.3
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 23:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731655572; x=1732260372; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/td2OHK6Uv6OlvtXPu6vE7g7uy24DWzvPVKBds7d3U=;
        b=NeneI/Xq/z60FaJAiQ/u+pGPCFSLlGQY8wTLLxH5XrZAhGdnzyl6gduEnaPtPrpLkY
         LdLcTj1EhHDYez440sF7qn3VC9gVU5n0KnSSxHnDBfleq0IPpjveHcvXCjUIYDYfQwEs
         wvz8CIxDeHNBv53+VYEYCQERAOuEhsVRnuF4AZFj4oRvTnVHecowAgNILBL4kizu7mWv
         5mzc/cgqx09cCOhQsjnW+cFid8PxSf5Zuqsl3ES56+D7pgBG8Ji/NXDCZrgpm7oKc5za
         d4yV3E/Xr5U0LMJ5sVjh3JfaYpqTCueNETuWJkLY8C2Ya/KT9LZ1+6R2kXfEib0+/Vjh
         T52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731655572; x=1732260372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/td2OHK6Uv6OlvtXPu6vE7g7uy24DWzvPVKBds7d3U=;
        b=v4ulDrSFa191Pml1fWtw1TvSRK9SXlT+A2g2JdJcfCs78eRkaJqkpcAbDKq5MKWag0
         K4pd45UmActClaMv9nffM+OUI3zZJ6I4Zq06ZB2PDoAEDKUF5gUTdcGYx0EMa1Ik+aE1
         qS6rbrus/lduuzVgs3GbneKiqhlJSSvsRmS4c14WmtL+abOCma25TR68f5zTJMqPBG/z
         XBeh8MrmXcTBUmi9O+wwh1yw3wmjx67YhP25tLa9MIU2tHKUXsI1mO9vld4cc4n9860G
         2asi2JFZmMb9f10S9iVUBGOYEsjf7x2vJlUyNEFmC2TRzoxeHBnsRK4pp9xkdlUbkt+x
         KJ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKL73fGI2roJqZK1yYAeJ/6gvmaJ48FyK3Hf2zSRGZY/WhUvd61vGDmr1TuCq85I5lYJaN0uSgte0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwljS7c5cMdDsSnNIxVSXk/gq6LTsV+hRip44my5pppdk0CUZ0w
	GvboKXyKnixzzWMgw6rPInAyFLK8PF5qsmafZzGp7NBijYuDuTaMB2jkMWUcRw==
X-Google-Smtp-Source: AGHT+IHF/h7Xa2A+zRkLdeKjCwTQRdlDQlAAp44kZhFqgVsoIp+fBjbt5btngDZE1kkJjv4kY/f0xQ==
X-Received: by 2002:a17:903:2450:b0:211:ebd:e35f with SMTP id d9443c01a7336-211d0ecb12fmr20281755ad.39.1731655571824;
        Thu, 14 Nov 2024 23:26:11 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ecaad0sm6850975ad.100.2024.11.14.23.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 23:26:11 -0800 (PST)
Date: Fri, 15 Nov 2024 12:56:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: snps,dw-pcie: Drop "#interrupt-cells"
 from example
Message-ID: <20241115072604.yre2d7yiclt5d3w5@thinkpad>
References: <20241105213217.442809-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105213217.442809-1-robh@kernel.org>

On Tue, Nov 05, 2024 at 03:32:16PM -0600, Rob Herring (Arm) wrote:
> "#interrupt-cells" is not valid without a corresponding "interrupt-map"
> or "interrupt-controller" property. As the example has neither, drop
> "#interrupt-cells". This fixes a dtc interrupt_provider warning.
> 

But the DWC controllers have an in-built MSI controller. Shouldn't we add
'interrrupt-controller' property then?

- Mani

> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> index 548f59d76ef2..205326fb2d75 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> @@ -230,7 +230,6 @@ examples:
>  
>        interrupts = <25>, <24>;
>        interrupt-names = "msi", "hp";
> -      #interrupt-cells = <1>;
>  
>        reset-gpios = <&port0 0 1>;
>  
> -- 
> 2.45.2
> 

-- 
மணிவண்ணன் சதாசிவம்

