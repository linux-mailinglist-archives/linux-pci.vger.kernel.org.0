Return-Path: <linux-pci+bounces-37841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A309BCF508
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 14:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 609D434BEEF
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 12:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF052773F4;
	Sat, 11 Oct 2025 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I7rB2hXL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209F266560
	for <linux-pci@vger.kernel.org>; Sat, 11 Oct 2025 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760184970; cv=none; b=mTVJmC2S9yx4usvjZJr/fa6y7yHkRKSwsPvSxHnXljbQgcrq+bYuVx59XWd7LrQUxgnKAv9N5F7ZetLjgJKvBYSX8LTpugpKkjpUMFAbcNReGCzC6PGvigt/3T0Po1N0pWgkj4xyAlR0GnDAu8c9cbuB6R8NelqsGl/6bYF7pfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760184970; c=relaxed/simple;
	bh=K9ZlGYLFyygWWlQdxL4k3DB105kYgCqHlL4sa73rs4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N80ga1DEx1ZdzX1OHmGhPoScFHPiuRbjHNgAOHObhF5wwaj0dRuWCc6gMPgN7BwqMeLkPilyWtzJHOIIfOeruX3D1PCNYOkvY29TEQTieEKdOyy4ETIM3ftqvVnA+lyHhqx1/zQpArkC9q5KJ8vNh/0dQFF7i0hYF+amoLXs7ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I7rB2hXL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e430494ccso16470065e9.1
        for <linux-pci@vger.kernel.org>; Sat, 11 Oct 2025 05:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760184962; x=1760789762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESeZUlMWivezlE3DeTyuSwyLVdykZbSbBsQ6LPdbgI0=;
        b=I7rB2hXLuU7CFe5+R8xQOXQpkumabMvRefO44qtV6FQsT+CmXsB4eLOyk6byWrIgAf
         bTYVAcNGD+XOxMM21qOx636SJbXhOslgtnULK68DD0S5yzBuMEQJPnPCwPOAvuonPQxs
         c0wMi+8z/vEld8iqDblKV/6c0S03YIS0YTJTNsq2V0H4MZwagRoMI3deYeaDhrp1cllO
         Twbg5NTyQpVx13D19ZzgfeWd4Z4pDHkRlAKlL28/LH7xse/JPnyQ46z1ZC9AptBGJCxZ
         QHx/i+4wSTeHDE8tU86hen6x3tmzm3vYa58jl4/NXg9YXDoDDIgY4d5nZTuR8ao5Wvi5
         7oQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760184962; x=1760789762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESeZUlMWivezlE3DeTyuSwyLVdykZbSbBsQ6LPdbgI0=;
        b=Uyk1mXJgIcrzHEys7X696wHlxF02nA4WVM/3LuRJVXAN0JWZ/ILVfJ8BqcEBlbm/H6
         2K0Lsn4ZaAsjhJoUBDbag0NizEuioJhC5Ju3OgT6dyfEiID2O1EA55LkO6S3DuLIb/h3
         X/Yp7LHzZCzx605yfJBIHvb2ANdp0ys8LtBGcY/mLwPc/yfdyYXAZxi4e+C9UzO6uA8Z
         k1OJbaRmlJ2Ac/Zf+25EZIiS0iFvUXTu6cF9FGJAy/1HT43+tusXLpbcykGDruk83uAM
         vQAPbaZzovmBpmdk4jnbxpsDAHeFXggDq9KUoaWogopyTAfQIhceTqs0wlx6YFUssEKX
         E4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWefMD3nJMkPxgnfYAu7Mg0V23c1AsfiajcRXTHUmfV690L5XKHq7P0eDU+HDLf5mggm4TB/R5lOmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1vDB1Ocwha6nL5SnAlpiOOgJdqZX+dGAml2SVAnO8/Mbh0hZw
	avmZSJ6QlYhbeJKUkxPkFWP6Slam8B9SDMD2ylL/HP1OLFANa9DIESOkPbIVw8mDqdk=
X-Gm-Gg: ASbGncuOMoMqi8aBYrmectGIBFnGYqOZD2+J/4TwRqVibaw/bogm/J3FrIhnR106F/d
	QkvaxmxBTrmhr6sloZ5Scr+bFAG8O+YKQtm75tcEp64EN2Rah06l6UJsLW1POn1lftv5981yBOD
	H1iAevzsDjPx5wtcK7A0QzFrahQl1ZfLnG6XgcN0H6+2CqrOWqD9Ov7CzoniZh84nv/rC+Mjm2Z
	eqhfOlP4jP8DMKLIQoImCKyhCZczOJInEpH8ZoyUCtfn4T3eJ4Wu51+xtW/8C5to/fDmxVY9Avm
	P7ua8xck/FXY+QFW5HJnVM4akk04508qZNLl2tYAjlnk4sRjqjWuB9pbNF9BpFobovhDQGKfAQ6
	qLCMtnheNgjXurZeIEdPH67lKgAN0wtJwXsASmxNIpyiwnJ1LaTEc
X-Google-Smtp-Source: AGHT+IF0eKdBuninlOSWd/RRES96gVi6uKKSkT94wSVAQclPilU8XlMKpntgxCzH3mwQj1GRHiXV8Q==
X-Received: by 2002:a05:600c:4ec8:b0:46d:27b7:e7e5 with SMTP id 5b1f17b1804b1-46fa9b08d79mr103124925e9.32.1760184962016;
        Sat, 11 Oct 2025 05:16:02 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482b99fsm93739915e9.3.2025.10.11.05.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 05:15:58 -0700 (PDT)
Date: Sat, 11 Oct 2025 15:15:56 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com, 
	Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: PCI: qcom: Document the Glymur PCIe
 Controller
Message-ID: <w2r4yh2mgdjytteawyyh6h3kyxy36bnbfbfw4wir7jju7grldx@rypy6qjjy3a3>
References: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
 <20250903-glymur_pcie5-v4-2-c187c2d9d3bd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-glymur_pcie5-v4-2-c187c2d9d3bd@oss.qualcomm.com>

On 25-09-03 23:22:03, Wenbin Yao wrote:
> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> On the Qualcomm Glymur platform the PCIe host is compatible with the DWC
> controller present on the X1E80100 platform. So document the PCIe
> controllers found on Glymur and use the X1E80100 compatible string as a
> fallback in the schema.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> index 257068a1826492a7071600d03ca0c99babb75bd9..8600f2c74cb81bcb924fa2035d992c3bd147db31 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> @@ -16,7 +16,12 @@ description:
>  
>  properties:
>    compatible:
> -    const: qcom,pcie-x1e80100
> +    oneOf:
> +      - const: qcom,pcie-x1e80100
> +      - items:
> +          - enum:
> +              - qcom,glymur-pcie
> +          - const: qcom,pcie-x1e80100
>  

The cnoc_sf_axi clock is not found on Glymur, at least according to this:

https://lore.kernel.org/all/20250925-v3_glymur_introduction-v1-19-24b601bbecc0@oss.qualcomm.com/

And dtbs_check reports the following:

arch/arm64/boot/dts/qcom/glymur-crd.dtb: pci@1b40000 (qcom,glymur-pcie): clock-names: ['aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'noc_aggr'] is too short
        from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#

One more thing:

arch/arm64/boot/dts/qcom/glymur-crd.dtb: pci@1b40000 (qcom,glymur-pcie): max-link-speed: 5 is not one of [1, 2, 3, 4]
        from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#

max-link-speed = <5> isn't yet supported and of_pci_get_max_link_speed returns -EINVAL and sets pci->max_link_speed to that
without checking the error.

So I guess fun stuff is happening based on that later on ...

