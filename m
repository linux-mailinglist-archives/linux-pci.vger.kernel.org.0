Return-Path: <linux-pci+bounces-1761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3124826325
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 07:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDBF282A02
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 06:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC956125B4;
	Sun,  7 Jan 2024 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oWeytvhM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD6E12B74
	for <linux-pci@vger.kernel.org>; Sun,  7 Jan 2024 06:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d4a980fdedso7498315ad.1
        for <linux-pci@vger.kernel.org>; Sat, 06 Jan 2024 22:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704608960; x=1705213760; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lPpQxTiPTYYgOm5HJxIxnoeCqrbLfJBRiV9MT7gfhgk=;
        b=oWeytvhMEpQxH6K1ooiMxUY7MZRiwuFHpwU7r/Cj5G1VsXM0LXXBaqbcJotc8IYx3A
         iKk4lpI3noptRvLbE6jfd0r3DnTE+wIYF06eY5ElkQv940g2g4YElrk57bV7C9Wyx7df
         Av5BSF0SJRxca6IQaCtuELk8dhVUXc4swyMEhxnA/CJogrT7FvRK1Dtb+Fda9uSrFgW2
         YuqgYhtPZdduAkoSPurUMBvRrXDt93plHFtuTSgIIHhRGQmxXTgzR6xO0r14mibB8foZ
         2XxaqG/k+hgIhp7DkJ2VnM8x5df/RKNScQJgv6Lv7q22TFdf2tHmwTmngR4muhFlbqAR
         O9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704608960; x=1705213760;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPpQxTiPTYYgOm5HJxIxnoeCqrbLfJBRiV9MT7gfhgk=;
        b=djvIlJGY+kK24vg2ycLLSevDJxMoUW0uSfbfkSR8UEQT3Vyxbc8zdQrBAbbnzogJVa
         9vNHIAO/Os6qid/8TNm3Z6o2y56p3uYzd7vocrSHY+QoHUT93efhKms1EbmmoKLZZwdf
         WlKagykfr0np7MwWjwFQ2HXWZ0T9cIjF/rj+IFEh4j+y2znq/pUMkooFywLewYYwJ7ka
         ZAtF70tcIz25nIcmjsVmt4Ajkpy2/TOM2FV1Sx/5P3etPRFLrX/UB6oVKOWoeXGSkzhd
         iJMOATlCBALPdsnYUV2W3DCWmkwU92b9NqTKjrGgD2UhadVvfKIKXM68/UecWhB1djod
         44tw==
X-Gm-Message-State: AOJu0Yx50E6ur5K/m1WgROyO61fC1qzNTVacLXbsPpT8SeahCVRY4hxo
	NTfDrPvlEsx9f0kXPsio/25PjSWlb/tw
X-Google-Smtp-Source: AGHT+IFuS+VgFu313P3GUR02Wdk9n+LlHtCgaDIS/dYJjNp5pcntGXq3NJAq0sIqbyTPAg+2UKkK9A==
X-Received: by 2002:a17:902:a60b:b0:1d4:be6f:5eab with SMTP id u11-20020a170902a60b00b001d4be6f5eabmr2083177plq.6.1704608959752;
        Sat, 06 Jan 2024 22:29:19 -0800 (PST)
Received: from thinkpad ([103.197.115.97])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902dacf00b001d337b8c0b2sm3938445plx.7.2024.01.06.22.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 22:29:19 -0800 (PST)
Date: Sun, 7 Jan 2024 11:59:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: krzysztof.kozlowski@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v7 04/16] dt-bindings: imx6q-pcie: Add linux,pci-domain
 as required for iMX8MQ
Message-ID: <20240107062911.GP3416@thinkpad>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-5-Frank.Li@nxp.com>
 <20240107031506.GC3416@thinkpad>
 <ZZos6LDk4NTfQHyU@lizhi-Precision-Tower-5810>
 <20240107051917.GG3416@thinkpad>
 <ZZo4wkHf4RE2O9UN@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZo4wkHf4RE2O9UN@lizhi-Precision-Tower-5810>

On Sun, Jan 07, 2024 at 12:38:10AM -0500, Frank Li wrote:
> On Sun, Jan 07, 2024 at 10:49:17AM +0530, Manivannan Sadhasivam wrote:
> > On Sat, Jan 06, 2024 at 11:47:36PM -0500, Frank Li wrote:
> > > On Sun, Jan 07, 2024 at 08:45:06AM +0530, Manivannan Sadhasivam wrote:
> > > > On Wed, Dec 27, 2023 at 01:27:15PM -0500, Frank Li wrote:
> > > > > iMX8MQ have two pci controllers. Adds "linux,pci-domain" as required
> > > > > proptery for iMX8MQ to indicate pci controller index.
> > > > > 
> > > > 
> > > > property
> > > > 
> > > > > This adjustment paves the way for eliminating the hardcoded check on the
> > > > > base register for acquiring the controller_id.
> > > > > 
> > > > > 	...
> > > > > 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > > > > 		imx6_pcie->controller_id = 1;
> > > > > 	...
> > > > > 
> > > > > The controller_id is crucial and utilized for certain register bit
> > > > > positions. It must align precisely with the controller index in the SoC.
> > > > > An auto-incremented ID don't fit this case. The DTS or fuse configurations
> > > > > may deactivate specific PCI controllers.
> > > > > 
> > > > 
> > > > You cannot change the binding for the sake of driver. But you can make this
> > > > change in other way. See below...
> > > > 
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > > 
> > > > > Notes:
> > > > >     Change from v5 to v6
> > > > >     - rework commit message to explain why need required and why auto increase
> > > > >     id not work
> > > > >     
> > > > >     Change from v4 to v5
> > > > >     - new patch at v5
> > > > > 
> > > > >  .../bindings/pci/fsl,imx6q-pcie-common.yaml           | 11 +++++++++++
> > > > >  1 file changed, 11 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> > > > > index d91b639ae7ae7..8f39b4e6e8491 100644
> > > > > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> > > > > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> > > > > @@ -265,6 +265,17 @@ allOf:
> > > > >              - const: apps
> > > > >              - const: turnoff
> > > > >  
> > > > > +  - if:
> > > > > +      properties:
> > > > > +        compatible:
> > > > > +          contains:
> > > > > +            enum:
> > > > > +              - fsl,imx8mq-pcie
> > > > > +              - fsl,imx8mq-pcie-ep
> > > > 
> > > > "linux,pci-domain" is a generic property. So you cannot make it required only
> > > > for certain SoCs. 
> > > 
> > > Sorry, why not? there are many generic property.
> > > 
> > 
> > It doesn't make sense to make it required only for specific SoCs since it is not
> > specific to any SoC. You can make it required for all.
> 
> More than 2 controller need require "linux,pci-domain".
>

But this property is applicable to single controller also.
 
> > 
> > > > But you can make it so for all SoCs. This way, the drivers
> > > > can also rely on it.
> > > > 
> > > > Now, you should get rid of the commit message about driver internals:
> > > 
> > > Not all dts already added "linux,pci-domain" yet. If required for all SOCs,
> > > it will cause dtb check warnings.
> > > 
> > 
> > You can safely add this property to all DTS. Nothing will break.
> 
> Yes, but it will be off topic of this patch serial.
> 
> I can submit new patches for this later. After all dts changed, then I
> remove this conditional check.
> 
> This patch serial is already quite big, (17 patches).
> 
> And I don't want to involve new DTB check warning.
> 

Okay. But please follow up on this once this series gets merged.

- Mani

> Frank
> 
> > 
> > - Mani
> > 
> > > Frank
> > > > 
> > > > > This adjustment paves the way for eliminating the hardcoded check on the
> > > > > base register for acquiring the controller_id.
> > > > > 
> > > > >       ...
> > > > >       if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > > > >               imx6_pcie->controller_id = 1;
> > > > >       ...
> > > > > 
> > > > > The controller_id is crucial and utilized for certain register bit
> > > > > positions. It must align precisely with the controller index in the SoC.
> > > > > An auto-incremented ID don't fit this case. The DTS or fuse configurations
> > > > > may deactivate specific PCI controllers.
> > > > > 
> > > > 
> > > > - Mani
> > > > 
> > > > > +    then:
> > > > > +      required:
> > > > > +        - linux,pci-domain
> > > > > +
> > > > >  additionalProperties: true
> > > > >  
> > > > >  ...
> > > > > -- 
> > > > > 2.34.1
> > > > > 
> > > > 
> > > > -- 
> > > > மணிவண்ணன் சதாசிவம்
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

