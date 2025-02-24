Return-Path: <linux-pci+bounces-22143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126DDA414DF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 06:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED34C16C165
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 05:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB831AC44D;
	Mon, 24 Feb 2025 05:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zoazNnS/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AEF3C14
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 05:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740375841; cv=none; b=nEMIqFogKJOX99AgJFWMhuTrPGJKPZ5fv/4E8HEA2xRUIKumIAtClrMgTV0EGUJHUWBP+o/5a5abC8FdyM2KLhKeJZl969NvExCStDpbnYvg2JJ1A4xmZpF2c6f8sfmhbCNVQP5ZADMjt0aL3z1UbvDNmHhFxEhRqN3ppHCK+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740375841; c=relaxed/simple;
	bh=6vqGCANtAX9VcV8YYZOtNyZdC+xLqgpXJgWUdVceStY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TN7DfDvIPZ4TH6ch22CSw1u9ZGyMqP2avlF1Krluwq9H7Q9r6aPoC5UPBEUA37zNJG4XzdKXz7znvPD3WgRwFvZBaO7Sd6JHqRQAdk5ks/jEjGEYZicLL7bqXy9TtmHocklw8FXA54QRC3PjUd4ZZ9JFSqnYQRFl4ywEKtHLxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zoazNnS/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2211acda7f6so85655195ad.3
        for <linux-pci@vger.kernel.org>; Sun, 23 Feb 2025 21:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740375839; x=1740980639; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sqF2oB0fOJ00qITszHytsg//Jw5NU1rfZI3/hzZUwto=;
        b=zoazNnS/ok47uWqp1bla1Ly1yhl8niybC+b/UI4pIwQZKGt6DnfetF6K6uJ+I2CSGD
         i/5VdVz0vCn3ARLZLoKMpuy7l+bBPU6NG/fpfgrqxL/VNL9rY32WlCcQdWUKabeKm64L
         Jdk4rnqIeNZsHTalgYMoOIkcFKWCjT6x2GpwHcDmkc5aj67mfUW0SfEydgOykGkxus3y
         rMsASVBHtLkLOffiQqgl3KD9OrBBfX1VjE0kByjMAghOvo/aZ5Vn+LyIEFzJEjuqJQva
         N70nge2xuxpsTOeHCBkUVNX7DY1T96LDPs1Vm8w4TGVelrf3pYOh/JDasqAqXUnViWTL
         wZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740375839; x=1740980639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sqF2oB0fOJ00qITszHytsg//Jw5NU1rfZI3/hzZUwto=;
        b=P2NX2qdRm4LY33HJBiEeh79Sa4ILxtmcToYPHq+oWJDFa5YN5OTt6t10gWE9HbUhC6
         vLGscpf0IsmdNPi3opy5d/KuKVvaRFfyFSzNyAfgc5ICEsTfmjS8Uwfve2/STcOrlJdy
         l6ZvHIz4FfgKY7MCNHYQLeAzCKlE77uEGPeFGvJ6S/hC4tmq3GhXTGn70SGGNq0ApK9/
         8O1X5buFuESgp0bHTjqRQ7ytkj5OZpoMcoW67/ZBOcvmk9ZvgsOuhNKdmjvyj7oWigom
         SVBMZcUXaE/BxtSeyJtMSsd0YzP/q+yzI9ncVUYxmUykYPQzt9HzuNxatpzlPvyTWOMr
         7Uow==
X-Forwarded-Encrypted: i=1; AJvYcCX1Ow0Ll/vb1/CVtZq0vT6krrbUKQ2OdrtlR61mAqCqZyD1RFSnFLjphIbcNUMrogh+a0OULitUJ9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz96iPmlj/6SHOaUubQeZ7LcX12aZtjaq4ums2ViA67JiRf3Fxs
	/s1Yv0yrL1qtybInNIhuoOMOT0pgxmBvUmTC/PU7CNndAUlIs/UJGyU3npeCcmRVlpAGsf8riVQ
	=
X-Gm-Gg: ASbGnctcF5hiDxa0uPHA8qmvcsjxjFEud0HmUVlil4oTdeyp2YEQ94LyeGwVLh16gqd
	R6MWGsZ1CNtPDZnFLz+0GqyNm5OcimRGPiXJPrjsLfrPz3VM9zY1SaU2VEDHHvG8C0/ZQMmcZUT
	yyglxxFbBKe22Kxn2DhL6OhDh+kwpvfvSrG3P+6Wquj0rG8XdctZibmghddw2Z5O6Z2cj7I7r5z
	CqT/IXVgAAKfGDRgMt7qwRLAdj2iehuQX+FAG85gO3A7+8tMcu8FRWUn4w55tGUYRtUPQrN8qji
	tAU0iyP3u44AM1yebuFvtpV7c5SOlMEErqqZ
X-Google-Smtp-Source: AGHT+IEiXXDmNWiIoyS4g/sMa+CHtSKXB9iHnryoV5l5+xYp1a39XIVItxTv64eAI9cSRTAKN1SUlg==
X-Received: by 2002:a05:6a20:6a0b:b0:1e1:ad39:cc5c with SMTP id adf61e73a8af0-1eef3c7718dmr22630530637.14.1740375839448;
        Sun, 23 Feb 2025 21:43:59 -0800 (PST)
Received: from thinkpad ([36.255.17.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adf35fb47c4sm11085874a12.31.2025.02.23.21.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 21:43:58 -0800 (PST)
Date: Mon, 24 Feb 2025 11:13:53 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: Add
 mediatek,pbus-csr phandle array property
Message-ID: <20250224054353.c24rcplzsvskzceq@thinkpad>
References: <20250222-en7581-pcie-pbus-csr-v3-0-e0cca1f4d394@kernel.org>
 <20250222-en7581-pcie-pbus-csr-v3-1-e0cca1f4d394@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250222-en7581-pcie-pbus-csr-v3-1-e0cca1f4d394@kernel.org>

On Sat, Feb 22, 2025 at 11:43:44AM +0100, Lorenzo Bianconi wrote:
> Introduce the mediatek,pbus-csr property for the pbus-csr syscon node
> available on EN7581 SoC. The airoha pbus-csr block provides a configuration
> interface for the PBUS controller used to detect if a given address is
> accessible on PCIe controller.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../devicetree/bindings/pci/mediatek-pcie-gen3.yaml     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index f05aab2b1addcac91d4685d7d94f421814822b92..162406e0691a81044406aa8f9e60605d0d917811 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -109,6 +109,17 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  mediatek,pbus-csr:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to pbus-csr syscon
> +          - description: offset of pbus-csr base address register
> +          - description: offset of pbus-csr base address mask register
> +    description:
> +      Phandle with two arguments to the syscon node used to detect if
> +      a given address is accessible on PCIe controller.
> +
>    '#interrupt-cells':
>      const: 1
>  
> @@ -168,6 +179,8 @@ allOf:
>            minItems: 1
>            maxItems: 2
>  
> +        mediatek,pbus-csr: false
> +
>    - if:
>        properties:
>          compatible:
> @@ -197,6 +210,8 @@ allOf:
>            minItems: 1
>            maxItems: 2
>  
> +        mediatek,pbus-csr: false
> +
>    - if:
>        properties:
>          compatible:
> @@ -224,6 +239,8 @@ allOf:
>            minItems: 1
>            maxItems: 2
>  
> +        mediatek,pbus-csr: false
> +
>    - if:
>        properties:
>          compatible:
> 
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

