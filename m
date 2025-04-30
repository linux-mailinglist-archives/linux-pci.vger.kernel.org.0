Return-Path: <linux-pci+bounces-27030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8A7AA4477
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 09:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2191D9C36F8
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 07:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC7E20FAB9;
	Wed, 30 Apr 2025 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1CfhUpa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51D620E03F
	for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745999591; cv=none; b=jZ0dPkRvYiAAmsNql9baaI5LOZhPtChztQhRgXEqq24ynaU3uRrKlrWfC2hffY8M+dbaGNPjGotGfWkBCDE+moX6djswgey7cDnjTurh08GANLh1PANaQlqzeDAvyx2u1vpdSnNWO4bjoZJL5BJKs3uz2qvwuUzYj57cdueJwJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745999591; c=relaxed/simple;
	bh=dfeiFNyIRnHm/2Kov6JSS45aI2yIJSqRZZS/TSMbT3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agNUTU5MB0jTi3H3RsXx8uQCloca4G2WL+mc7ZWJkW/vPDmoPccXMB5jVkcrklxcgD/ZoB2tQcmRFPqoanTyYZScy8ctVYIbzOjsmtD9yjFZ40HHebAbcrALmRsjRJjxpiiCJjnyPZuiB6q4vvfHth68FfnKqA6beDuheMufOIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H1CfhUpa; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736bfa487c3so5735937b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 00:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745999589; x=1746604389; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i+MTVq2cBl2VSKlfLrQRi33s6xMW5rWCQfy1PuSzKJk=;
        b=H1CfhUpaqHCBReObIuqGBgg+Po+jdevCSJ/5pAi2DzlK98eKoXm6ZgmW8Go//TJgdN
         g0Jg8cYYi5JqyAwpkQyi9wllYwwysVCIys8h6QULuveXZCyF3x77Gt5pYj8R5fHo13Rf
         rdf9G9Do+FJCd6hbWz4bUtapTARFS955yO41etszva86/LqALfu0FyYOqn87d1G0+LnO
         42JV52wUE45kqD5jixX1sAdT0uKFVCGsBpgqxu9CEu9J559KIxM4yjV/2FeYcGQGRhlX
         7rAPjBxQupUadwBuESe+HKm6rZ+xeiDPFodglo8jnlVgNW2j+eKJr8BBz3iG1uVfsdoe
         aVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745999589; x=1746604389;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+MTVq2cBl2VSKlfLrQRi33s6xMW5rWCQfy1PuSzKJk=;
        b=tM2VxhUbC7B62Ye7zYAkin5ukEfSQdVugqSt9KDaa8UayV73+uUv8f+t61KZkt6wzt
         QN3+eheQtbYL4braXQkXtPI3c4Kne/ee76wjR2Bvyqg5oIxZ4aXvPsRv09s+c8V3Sd7b
         5e2xXVji5/OoYiwFkWlzZcIVKJ0rpCslYXVrpUsWV0a1OYt3OaZJ4jYhiYs0xU87lp07
         pAjbb/PHjYAJYSTXrTMMuFOn3tbzTjvEf4tlojnacDAxRr3wdUMVoxIuNKVNvc7r7oek
         jne4ukrkg85KRXs/u+D8b4BPZ2qg+6hji/f5YCE0CPVgq3OgNXK1kbjd3I2DlF5HfTkh
         Leaw==
X-Forwarded-Encrypted: i=1; AJvYcCWA5wckCU1NMPvjNcDxhY6Ywg5YABgMHn86/WMz8YVFoSxTiQ2eYXwBgMIqbLmk/ZdmuCW94E3IsDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylby2izLVMwx2xFoCP1zNP1r5WUm4JuL6pvQ4B16Hz6BFIBeQ4
	DvT/PHBcZ6i4WIBi+SK4LDmWvHSIdvwRf1x8yInmOCmBrWJop5KDGUEFaSU7Cw==
X-Gm-Gg: ASbGncuI9Md4FOz80b83rxkeuJTidOSLGRibMgvQFY6KW1EYv6C+aOAMgYcMD3NYiiw
	+XDscoMmivOrG3wSIRzfCWERPAlXCXamothpY6qVHAdiDEGv5+Bloi131M9nNi9e1JRrrESCD3m
	6xxgd4tgSKK74nWWfE4hiDHkxEHD27ffQDsXBU4Px8oXit2ysRJIZceYfKq4WldnRf3OkHRXeNy
	6JkEDa8KXUaEGTeR8Mtilka4ezaQReJwQWBs+Wmy/mhxvrFSKpSb9KWm6u831swmrhyefeXgof9
	JqLgVJz2Od8XVDRJlyQD10Tno8Y326P1uwPrpZKXWTobxw0fjCVX
X-Google-Smtp-Source: AGHT+IE+F2JRpn2ZM2o9jL/72thVrixPZ14egfscs7wCjp/nG5sCmrUA/FtL4Jd33FyKJWKHKnmfiQ==
X-Received: by 2002:a05:6a21:8cc6:b0:1f5:591b:4f7a with SMTP id adf61e73a8af0-20aa457e4a4mr2377739637.38.1745999589047;
        Wed, 30 Apr 2025 00:53:09 -0700 (PDT)
Received: from thinkpad ([120.56.197.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62dcasm1023535b3a.138.2025.04.30.00.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 00:53:08 -0700 (PDT)
Date: Wed, 30 Apr 2025 13:23:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, dlemoal@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: pci-ep: Add ref-clk-mode
Message-ID: <dxgs3wuekwjh6f22ftkmi7dcw7xpw3fa7lm74fwm5thvol42z3@wuovkynp3jey>
References: <20250425092012.95418-2-cassel@kernel.org>
 <7xtp5i3jhntfev35uotcunur3qvcgq4vmcnkjde5eivajdbiqt@n2wsivrsr2dk>
 <aBHOaJFgZiOfTrrT@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBHOaJFgZiOfTrrT@ryzen>

On Wed, Apr 30, 2025 at 09:16:56AM +0200, Niklas Cassel wrote:
> Hello Mani,
> 
> On Wed, Apr 30, 2025 at 12:35:18PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Apr 25, 2025 at 11:20:12AM +0200, Niklas Cassel wrote:
> > > While some boards designs support multiple reference clocking schemes
> > > (e.g. Common Clock and SRNS), and can choose the clocking scheme using
> > > e.g. a DIP switch, most boards designs only support a single clocking
> > > scheme (even if the SoC might support multiple clocking schemes).
> > > 
> > > This property is needed such that the PCI controller driver, in endpoint
> > > mode, can set the proper bits, e.g. the Common Clock Configuration bit and
> > > the SRIS Clocking bit, in the PCIe Link Control Register (Offset 10h).
> > > (Sometimes, there are also specific bits that needs to be set in the PHY.)
> > > 
> > 
> > Thanks for adding the property. I did plan to submit something similar to allow
> > Qcom PCIe EP controllers to run in SRIS mode.
> > 
> > > Some device tree bindings have already implemented vendor specific
> > > properties to handle this, e.g. "nvidia,enable-ext-refclk" (Common Clock)
> > > and "nvidia,enable-srns" (SRNS). However, since this property is common
> > > for all PCI controllers running in endpoint mode, this really ought to be
> > > a property in the common pcie-ep.yaml device tree binding.
> > > 
> > 
> > We should also mark the nvidia specific properties deprecated and use this one.
> > But that's for another follow up series.
> > 
> > > Add a new ref-clk-mode property that describes the reference clocking
> > > scheme used by the endpoint. (We do not add a common-clk-ssc option, since
> > > we cannot know/control if the common clock provided by the host uses SSC.)
> > > 
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/pci/pci-ep.yaml | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> > > index f75000e3093d..206c1dc2ab82 100644
> > > --- a/Documentation/devicetree/bindings/pci/pci-ep.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> > > @@ -42,6 +42,15 @@ properties:
> > >      default: 1
> > >      maximum: 16
> > >  
> > > +  ref-clk-mode:
> > 
> > How about 'refclk-mode' instead of 'ref-clk-mode'? 'refclk' is the most widely
> > used terminology in the bindings.
> 
> I does seem that way.
> Will use your suggestion in V2.
> 
> 
> > 
> > > +    description: Reference clocking architechture
> > > +    enum:
> > > +      - common-clk        # Common Reference Clock (provided by RC side)
> > 
> > Can we use 'common-clk-host' so that it is explicit that the clock is coming
> > from the host side?
> 
> Sure.
> 
> I take it that you prefer 'common-clk-host' over 'common-clk-rc' ?
> 

That's what I intended previously, but thinking more, I feel that we should
stick to '-rc'i, as that's what the PCIe spec uses.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

