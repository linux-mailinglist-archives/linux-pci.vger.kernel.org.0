Return-Path: <linux-pci+bounces-21942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5DEA3E93E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 01:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED5D421F6A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 00:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7541288CC;
	Fri, 21 Feb 2025 00:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGLmW5i9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5148317BD3
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 00:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740098521; cv=none; b=rD9IjrecU7zGUm3d/JH+AS74Tc/d+fQlzg5yheEker+AYzfr4JJ8g3CrIVMfN+AVvMPHErdDGS0C6LxhNIC9oasyb/b2KL3dO+91WKRA2VhhfuK8W2uH7TxwCxVDaoDW2vTFm9J5SGoBx+yh6LDd+rf3q4Ep+ER9usmVvV371Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740098521; c=relaxed/simple;
	bh=ETp8jkID19Q6clNd9atoSB8ooztT2iJp2Tlq3F9YBFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TU8WXC1v3BX0fgC3ouJZALvqMloS6LzYTv+w5LppYhJPUsB2i/m6mQk7w6xewgAv79UO0afahK9mciRpK69QUIHY1mjajXShbm5UgKxZlNW/cHG2Kfb7/lVpEryMcDAwZw0f8XeDkuvZCSnlRfEEYgv13Tq3eyKeUwB4ObjhREg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TGLmW5i9; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30761be8fa8so15992041fa.2
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 16:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740098516; x=1740703316; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/pKysWYhWubY7fPYY3ZkE7Dmtc31H4VKjfkNJgksHZ8=;
        b=TGLmW5i9icSDBDUYCrackD4ihVxJDjJ0+igF1oeSBr0EZTZTUtgkxkAs8jU4lJOm0o
         Pc5hu67NlZsA4JQ05emfI3kLqoNhGCBKriXDi/DOc9ZGUbNa4QOyIvlYzUu6JQs49dGC
         NdulSh7XLVcGhXfY64Ky2ck641U0gHfgo9UEKC6Ajv95T2wuNftoO1ct4yIwP7Qhtw0M
         pAh11MNnS1nvXtBs2kkaUNS0M21fsGKyRfsX16ORLGdQkv1P0ytRxPXhkK+pHRbmghYX
         EOg5nFhDZebsqr+mE0yiJd93SivKN7BIor1TqYamWq0DuNchUxgGHV9h38XfIzbyP3Pw
         U4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740098516; x=1740703316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pKysWYhWubY7fPYY3ZkE7Dmtc31H4VKjfkNJgksHZ8=;
        b=wEt5hix02o8+ZFpttFQ41Kf8bAjg9xnFx1xPgLVs+oF03lUxXA3dkWK8hPK0QRQgkC
         Ak5h/Aj8r2hvH40efug/JdZxvaJpE2hMI7moYAt52hdVg3Fcw7BLBCeBTnblrhhMd8Xu
         r68eUtFGpxaJS3VZuoyc+m09hh2mIvVGRHCRgxsHaVrFHE0+iw0COFeWPwXRBYUkR2Fi
         iGfTMa/PgO3sLRFNAF7x7CMeRA+dsZJg1vB/lzRnXpid/GY9eTH5vsjPFEHoNmYXqkao
         vA0s/WFeWEmhLb+4K/CHQgVnUV8rsJFwaWwNlvmAREJPW7m+2sG3p/9Bcf2+jrvt8Rr4
         KZHg==
X-Forwarded-Encrypted: i=1; AJvYcCU2caTcmm3Q5OjzROi6L4aAuu+CC2ymenjRiT6Q4RbIQtSLtkgJ8Wr2TynTGheR9HNS+iDuYkCiINg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLIkQh6VV8PX4qpGv4BxDNVJgng3SQbug6vqgL14wQwdZaYCkt
	wNerr7evssSmceOBpp6pERfOmES2gZrbQNPKKa+oZ5HhQgUbPplywy2fPAwXHt0=
X-Gm-Gg: ASbGncuVME/2MYNBY9SXpxBcdnvIaqR2qVakdqL/q5BIec6byFHoMMjEmCUEjDCV8AC
	HXc6ifdrNS8M+qITw2N2B9GxyK/riAWAhPRlatirOtnk3w46WWts3iYvnhxXzNNvSpN1h5Sk724
	h3Y+Ki/fzHsGM7qD1XBDnxvNOotHIazvk9urq8nGrtX/8qOAPgUmkCaU9cbtXGuLWVNV3zpWXRW
	jBokd1GkNyLfwvU8Ft7hKlErcarmAdVgUzf9LQoIJfSukWnSXtrBSVBCsvH33Fj+U+UFoV/eqXQ
	wQQRxBbmGRLNFaK7AStu17ru9fNEyAOALfVI8pfBJH0E6ot0pxxuqLyAwKrcxR2wy+EKYmI=
X-Google-Smtp-Source: AGHT+IE6YC3qJWgj+pA7QsnD+7VLqLnqN2QSjIeiyvjgAXpfDQedbS+a7gzdDe5aFOVCj1yTz7b6Nw==
X-Received: by 2002:a05:6512:3054:b0:545:2fa9:8cf5 with SMTP id 2adb3069b0e04-54838f79d55mr366460e87.49.1740098516390;
        Thu, 20 Feb 2025 16:41:56 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54530530d93sm1920688e87.199.2025.02.20.16.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 16:41:55 -0800 (PST)
Date: Fri, 21 Feb 2025 02:41:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Mrinmay Sarkar <quic_msarkar@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: PCI: qcom-ep: describe optional IOMMU
Message-ID: <plurppltr3ttmmptnrounyjw3l7justgsl3dlpjqtkzsvkctsc@3cz52qtnyd3q>
References: <20250217-sar2130p-pci-v1-0-94b20ec70a14@linaro.org>
 <20250217-sar2130p-pci-v1-1-94b20ec70a14@linaro.org>
 <20250220071943.edn6q65ijmeldnag@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250220071943.edn6q65ijmeldnag@thinkpad>

On Thu, Feb 20, 2025 at 12:49:43PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Feb 17, 2025 at 08:56:13PM +0200, Dmitry Baryshkov wrote:
> > Platforms which use eDMA for PCIe EP transfers (like SA8775P) also use
> > IOMMU in order to setup transfer windows.
> 
> eDMA has nothing to do with IOMMU. In fact, it is not clear on what IOMMU does
> on the endpoint side since we do not assign SID based on the RID from RC.

Well... If my memory serves me right, I had to enable IOMMU after
switching from iATU to eDMA. But I might be mistaken here. I will update
this commit message not to mention eDMA.

> 
> But the binding should describe it anyway since IOMMU does sit between DDR and
> PCIe IP.
> 
> - Mani
> 
> > Fix the schema in order to
> > allow specifying the IOMMU.
> > 
> > Fixes: 9d3d5e75f31c ("dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > index 1226ee5d08d1ae909b07b0d78014618c4c74e9a8..800accdf5947e7178ad80f0759cf53111be1a814 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > @@ -75,6 +75,9 @@ properties:
> >        - const: doorbell
> >        - const: dma
> >  
> > +  iommus:
> > +    maxItems: 1
> > +
> >    reset-gpios:
> >      description: GPIO used as PERST# input signal
> >      maxItems: 1
> > @@ -233,6 +236,20 @@ allOf:
> >            minItems: 3
> >            maxItems: 3
> >  
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: qcom,sdx55-pcie-ep
> > +    then:
> > +      properties:
> > +        iommus:
> > +          false
> > +
> > +    else:
> > +      required:
> > +        - iommus
> > +
> >  unevaluatedProperties: false
> >  
> >  examples:
> > 
> > -- 
> > 2.39.5
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
With best wishes
Dmitry

