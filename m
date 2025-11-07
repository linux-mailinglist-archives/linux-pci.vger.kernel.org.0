Return-Path: <linux-pci+bounces-40589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BDEC40DD2
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 17:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACE8A4F6150
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 16:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E558272805;
	Fri,  7 Nov 2025 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNYWvEGB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E69262FC7
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532546; cv=none; b=XluBdMxoss+8qqF+GGi9dlR1GSIDhdXR+EjP6P7ZLad9Qy//kfeGfOs80awz8HXv26Wetl/Sm6lVyRVbu8Wy+pj9q7a9XUugm1of76cVJ2YC3pxOtbmslgcTP6jxMXG6+e+pRjgr53QuoUb49hMFovpgdTS/SU5N6+AzLbImkkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532546; c=relaxed/simple;
	bh=/uuBJvBfa8Ndn+0lFjyrN8xoJzUWciCEN2Zw2GSaeHE=;
	h=Message-ID:Date:From:To:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/FBpxZ/5ZeDlUR5sjgPzvZz/ZTyFaJAjXrn1WjycDguA9+qb7B4HIY1DA4uDjxAW9FG/iA+eNg2xS17cJT9qFc9mgi2Yytl/R3PgFouvMoISGeqpUf01nvoBKbXCNWhgtI9Pn29iPAKoy6D0dlCsBzG7Jtw7S0rkLc0ew2oSh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNYWvEGB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429bcddad32so678540f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 07 Nov 2025 08:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762532542; x=1763137342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eXVAQ6YCxaql2PnrFc8uwn29EJDszDo6Iic48te9xOI=;
        b=hNYWvEGBW3TtYnRTtEl+d7RNbddPGhPtf+L1OuraZ65v0VHz2TMpWMt3Mhp7bRh5OR
         ScgpvIDT+iyeDI7vU+fBqrenmWvVhfpFUfGyM+7GWiCcZMnYuXTjqohPYYYSg12oUY63
         M2+YGO0NGhqkdE8SjyrpHwCuGQ4oNK8hP48ExI6EpH8d2+m9AxJvYZwWYnNsV4biEheS
         kJJ5kXfILMzwvwOgVsAV7UrTRYHVqDcxscBvxk7Uft0xF80dEEQwftK+0EwOs3FYPmDk
         3dpb17b1J4hH019enMnzVmJoCd5qfX6SdcpY9NJAxgsvrKrJDgdvViBX5urcd+/du7SO
         rauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762532542; x=1763137342;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eXVAQ6YCxaql2PnrFc8uwn29EJDszDo6Iic48te9xOI=;
        b=oEDpHhKnXCPlBZHCqExf4VACYPnT+Oaa8VjBdWOPcZH6paxyvLmKWC8+pRASV8VA7L
         AxAzo0tdll1UJhglWzBV15x6atwgLyA7NYZNWhil/uaryA2aF5ukSt8ZoXBxnnxQwVF8
         CdOTHNNbVXq7gnzXnraT8VHQWwIiq+gphWQR0b75HJRj5OZwAfBIs2/+RNKCJbgDGLlk
         L0uO+HQyA+18hnmnC8eiK72v0DLRluRMYKvH1iGeEAJrPsmy5tqcwsvmx7J43PUUA34A
         eLkcHP0FZKbMSeMji6+vAE6Ux2P57LC+EwypDxpe7qZx1k0lGGiJUoPYkAYs3irN9mIh
         R3xg==
X-Forwarded-Encrypted: i=1; AJvYcCXf3RqTJ4v29zqgYchn1PXL52EpiUMvFvWl8wmKy1JFDZSmgY9HBcMaZFrG3LXYmmK4qzs8zzrYvlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCvF0QRPFCg2KS6V79vYXqne5eY0FtCw9k73QkQSgVcKzm9R5B
	f3QMADB7pQtMDuncNpAsiCgW1fCyCFVYG07L7sZcXakKy5OvPYAzJwu5
X-Gm-Gg: ASbGnctT+47pCl4x/xVcTGh925n5URziW7zf5UNOwxwYRH58XgwlO5KjFf3vlY+TqMq
	9K8CgWzZgJD19wB1j9hUXPIp7DoAcD3Vjm/6FBuar1AOjcAbIQr5LnWcEl6X3ZaxYXtgp5zMXKM
	l3w6Z2QOSS67KeIo2lVL47oyFyw6DBYtyp0VcW+SnFdB6WHo2KDqYHPH9/5yzoxCbHLwB4zzPTJ
	nRFw/FrctREhkDZ1+5GuNlsHb11WfMdsdQcw8RBq3v5nU/4qOSlnH+p8Zs6bVsjXW39w9IF3i1q
	EG0kOIGadJRfdzLpT9iqBOCypczr+1nmG7xWqgZaT6ZvMS1ghXghzbMLS+cEP+FLW2ftQd15Dpr
	MT72plMSTDZx3keVst9MLaysbkA/KhAyMnRV3j6qc/zU3ih/JeaDlq6Ujv95AftutkvQ4bZiDmU
	45j+RvE9s9pBvxNHWhMgHvoyKKZr5zXX5TuxCF6c8=
X-Google-Smtp-Source: AGHT+IGFfr9CT1eblajtZCP2XVFU0Vr5uVwdsTRLDJcCXPnjm3McVM0mCmW9P9Gky5idSjyeK+nn1A==
X-Received: by 2002:a05:6000:2905:b0:425:7e45:a4df with SMTP id ffacd0b85a97d-42adc6896abmr3482205f8f.11.1762532542447;
        Fri, 07 Nov 2025 08:22:22 -0800 (PST)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b29e4b9bdsm1826631f8f.32.2025.11.07.08.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:22:21 -0800 (PST)
Message-ID: <690e1cbd.df0a0220.25b002.6c64@mx.google.com>
X-Google-Original-Message-ID: <aQ4cugRUZrJVqR3c@Ansuel-XPS.>
Date: Fri, 7 Nov 2025 17:22:18 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: Add support for
 Airoha AN7583
References: <20250925155330.6779-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925155330.6779-1-ansuelsmth@gmail.com>

On Thu, Sep 25, 2025 at 05:53:08PM +0200, Christian Marangi wrote:
> Introduce Airoha AN7583 SoC compatible in mediatek-gen3 PCIe controller
> binding.
> 
> This differ from the Airoha EN7581 SoC by the fact that only one Gen3
> PCIe controller is present on the SoC.
> 
> The compatible have -gen3 tag as the Airoha AN7583 SoC have both GEN2
> and GEN3 PCIe controller and it's required to differentiate them as
> different schema are required for the 2 PCIe Controller variant.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Any chance this can be picked? All the 2 patch got review tag.

> ---
> Changes v3:
> - Add review tag
> - Add comments for compatible inconsistency
> Changes v2:
> - Fix alphabetical order
> 
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 0278845701ce..1ca9594a9739 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -58,6 +58,7 @@ properties:
>            - const: mediatek,mt8196-pcie
>        - const: mediatek,mt8192-pcie
>        - const: mediatek,mt8196-pcie
> +      - const: airoha,an7583-pcie-gen3
>        - const: airoha,en7581-pcie
>  
>    reg:
> @@ -276,6 +277,26 @@ allOf:
>  
>          mediatek,pbus-csr: false
>  
> +  - if:
> +      properties:
> +        compatible:
> +          const: airoha,an7583-pcie-gen3
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +
> +        clock-names:
> +          items:
> +            - const: sys-ck
> +
> +        resets:
> +          minItems: 1
> +
> +        reset-names:
> +          items:
> +            - const: phy-lane0
> +
>    - if:
>        properties:
>          compatible:
> -- 
> 2.51.0
> 

-- 
	Ansuel

