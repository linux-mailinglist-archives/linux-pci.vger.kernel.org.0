Return-Path: <linux-pci+bounces-27524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA2CAB1D4C
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 21:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D771C409A4
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 19:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A909E21CC60;
	Fri,  9 May 2025 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDFZfLjd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984C625DAFC
	for <linux-pci@vger.kernel.org>; Fri,  9 May 2025 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746819116; cv=none; b=opQ+EUuHgoy5PehSTbeqJdSHK5nopx/ZNnHYnrXt54Ikdusiv5CdZXE1YuiKtPG8fYSxn0uPSqBQkLVZlhQ7SK1ngpWJ/ekt0xgPWndK+YKyzikZ1nz8vi4g3KHfrB38owkM9BqUIkmVeJNJaju1CfTcAmO2HDqg+uHv/k64i5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746819116; c=relaxed/simple;
	bh=JsFo0hFjmR3LuTymmu4wrKJzBSAJO2NiMIdqJde3m2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YH6syDKxl3fh0oArxK5/KFM3bHO6pLdYiQTWvTB8AXiCGxL0rkXPh33gB52v5R0R6ed84BV0TKPykdCOnsgJTIHstlWKSOHa0Ay/SIErY59HJkA+9OFv+dMj+e5YVtawGcf7bmc2RCaaoh5FfeP8VXGdVpw+WMDG86EQjYJbd5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UDFZfLjd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso18138635e9.3
        for <linux-pci@vger.kernel.org>; Fri, 09 May 2025 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746819113; x=1747423913; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nfyjxEHEOEYFl+DBrtval1fCpV6RnB85Mkd6us6425A=;
        b=UDFZfLjdMsr9nQK4FMIgsfT1+vx19ikueV+pvQ2+FsyDQudXz/h1pzYfLSySMQ+9au
         3hE51unsEXrjws+1raYQnEQKIUngB+M8w+sWAOoYgrWLoq5ynd00XCDNh7B+ZNmYz3RS
         uboYp92CHTBjR7DWwG49QveZO8lBNVDh88R7pYc1ImiIl09Q7gLI0y0CxpolAMUCF3BR
         28wveyPWRSwJgipn7POWW9EE6NOsy6wVh1Y8xyWeJ4OzW28dA5CP/xryKnk5S1Txcmu5
         eEs/7iFZxEpxqaZ3OXP4mgSctvxNlZ8RxN3wMzK/pGmy0I0IK6TqIzRFqPsORMOENX4d
         SrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746819113; x=1747423913;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfyjxEHEOEYFl+DBrtval1fCpV6RnB85Mkd6us6425A=;
        b=qrC1AobOUnWTUlgJQCImknRXUKxyUa+T9irwA0Gwkl2J9mBBfYr3mOMf+k2UZ5H+O5
         oFs8cKkyo54xNy+zXSwIJrZH+ZrbLg6bAgtXoXyLjd9PCXhN796xcgy2bZ9/MEBR2Q5i
         oNoIzLItXD9WUclGTI6QXA4HqIOztXlbds2pkPToyjYtk2kWkhwOy7kmhoT2b02WtlMc
         ocnffqOkyYpLHS6LAq/33/iCuakMKb8Sd2AlWDgN9U5E+6NXWbn9TVXAOrj1k3za0WLA
         3bsxTiiKolNItpSP1Sgy1ur2TYik/vQ69zGMjoPRl4uloH38G+XXOCTpSAiGG1vCR1y4
         k64Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOINBhSmYpmrCgYYQpePCvHzGi39lhPf+mwH89PQDDmv/KBWTeiHBu7olMr11T3f+7DIa6iM8CEHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh2l3QOWDg/gVWZL2GwIqm+KR7+0G5pJeOmmnIqDg6AmgoFvvy
	cL2Tf2kJrTwKQR0lAFNGIacihhgQ2aiYW54/4gR2XuWrsud2lckXs5Zm7TbICzDsN7l2ZiFt77Y
	ylA==
X-Gm-Gg: ASbGncsY4kxERSSWHvjH+Zo/zUhtkHkoe+jg7r0uhm+LHsCTdTG2SYAymyFa70J/Kl4
	mMYQUpvmEsCKnoRi0VB5FfkRY9hQi67Sq0nMza+saOoNap8fG6IgqtkKiepQP0jpBz1z01/Swot
	tgvReJbOAPX1LvaJU9Ma5KBzrcJdT57pg1eY/KqXZcmGUy2OxZool4ed7N2vu1Yc7F8dTKJcvcC
	ABIfeDkBMsfSbspGz+VaHWQP0RIdXDNb6KxRN2iAhi18pQrkAYZI1UUKdavgAFwZcyfT0d2o13l
	jkYhusSAbGNDHjCzL6PsvcSPQMtANfX2I8SyTOXAB8YvyMohl3KCUYjOgnsHkarxHqEb9d7nUoM
	jP451FjMRkj0ek4uo7dPm8fUxHHDwK5207g==
X-Google-Smtp-Source: AGHT+IFhOsTuLFYoorhB3flhINBR64mTmsQF6Me/BqyXKoM1cFY2gt5C7uIG1KE8GN4OkDVLMJT2kg==
X-Received: by 2002:a05:600c:528a:b0:43d:abd:ad0e with SMTP id 5b1f17b1804b1-442d6d6b6ecmr40655635e9.18.1746819112785;
        Fri, 09 May 2025 12:31:52 -0700 (PDT)
Received: from thinkpad (cust-east-par-46-193-69-61.cust.wifirst.net. [46.193.69.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3b7d2bsm81937825e9.36.2025.05.09.12.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 12:31:52 -0700 (PDT)
Date: Sat, 10 May 2025 01:01:51 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, dlemoal@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: pci-ep: Add ref-clk-mode
Message-ID: <a7rfa6rlygbe7u3nbxrdc3doln7rk37ataxjrutb2lunctbpuo@72jnf6odl5xp>
References: <20250425092012.95418-2-cassel@kernel.org>
 <7xtp5i3jhntfev35uotcunur3qvcgq4vmcnkjde5eivajdbiqt@n2wsivrsr2dk>
 <aBHOaJFgZiOfTrrT@ryzen>
 <dxgs3wuekwjh6f22ftkmi7dcw7xpw3fa7lm74fwm5thvol42z3@wuovkynp3jey>
 <20250509181827.GA3879057-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250509181827.GA3879057-robh@kernel.org>

On Fri, May 09, 2025 at 01:18:27PM -0500, Rob Herring wrote:
> On Wed, Apr 30, 2025 at 01:23:03PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Apr 30, 2025 at 09:16:56AM +0200, Niklas Cassel wrote:
> > > Hello Mani,
> > > 
> > > On Wed, Apr 30, 2025 at 12:35:18PM +0530, Manivannan Sadhasivam wrote:
> > > > On Fri, Apr 25, 2025 at 11:20:12AM +0200, Niklas Cassel wrote:
> > > > > While some boards designs support multiple reference clocking schemes
> > > > > (e.g. Common Clock and SRNS), and can choose the clocking scheme using
> > > > > e.g. a DIP switch, most boards designs only support a single clocking
> > > > > scheme (even if the SoC might support multiple clocking schemes).
> > > > > 
> > > > > This property is needed such that the PCI controller driver, in endpoint
> > > > > mode, can set the proper bits, e.g. the Common Clock Configuration bit and
> > > > > the SRIS Clocking bit, in the PCIe Link Control Register (Offset 10h).
> > > > > (Sometimes, there are also specific bits that needs to be set in the PHY.)
> > > > > 
> > > > 
> > > > Thanks for adding the property. I did plan to submit something similar to allow
> > > > Qcom PCIe EP controllers to run in SRIS mode.
> > > > 
> > > > > Some device tree bindings have already implemented vendor specific
> > > > > properties to handle this, e.g. "nvidia,enable-ext-refclk" (Common Clock)
> > > > > and "nvidia,enable-srns" (SRNS). However, since this property is common
> > > > > for all PCI controllers running in endpoint mode, this really ought to be
> > > > > a property in the common pcie-ep.yaml device tree binding.
> > > > > 
> > > > 
> > > > We should also mark the nvidia specific properties deprecated and use this one.
> > > > But that's for another follow up series.
> > > > 
> > > > > Add a new ref-clk-mode property that describes the reference clocking
> > > > > scheme used by the endpoint. (We do not add a common-clk-ssc option, since
> > > > > we cannot know/control if the common clock provided by the host uses SSC.)
> > > > > 
> > > > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/pci/pci-ep.yaml | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> > > > > index f75000e3093d..206c1dc2ab82 100644
> > > > > --- a/Documentation/devicetree/bindings/pci/pci-ep.yaml
> > > > > +++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> > > > > @@ -42,6 +42,15 @@ properties:
> > > > >      default: 1
> > > > >      maximum: 16
> > > > >  
> > > > > +  ref-clk-mode:
> > > > 
> > > > How about 'refclk-mode' instead of 'ref-clk-mode'? 'refclk' is the most widely
> > > > used terminology in the bindings.
> > > 
> > > I does seem that way.
> > > Will use your suggestion in V2.
> > > 
> > > 
> > > > 
> > > > > +    description: Reference clocking architechture
> > > > > +    enum:
> > > > > +      - common-clk        # Common Reference Clock (provided by RC side)
> > > > 
> > > > Can we use 'common-clk-host' so that it is explicit that the clock is coming
> > > > from the host side?
> > > 
> > > Sure.
> > > 
> > > I take it that you prefer 'common-clk-host' over 'common-clk-rc' ?
> > > 
> > 
> > That's what I intended previously, but thinking more, I feel that we should
> > stick to '-rc'i, as that's what the PCIe spec uses.
> 
> Couldn't this apply to any link, not just a RC? Is there PCIe 
> terminology for upstream and downstream ends of a link?
> 

Usually, the refclk comes from the host machine to the endpoint, but doesn't
necessarily from the root complex. Since the refclk source could very well be
from the motherboard or the host system PCB, controlled by the host software.

> The 'common-clk' part seems redundant to me with '-rc' or whatever we 
> end up with added.
> 

No. It could be the other way around. We can drop the '-rc' suffix if it seem
redundant. Maybe that is a valid argument also since root complex doesn't
necessarily provide refclk and the common refclk usually comes from the host.

> Finally, this[1] seems related. Figure out a common solution.
> 

Thanks for pointing it out. I think the patch also refers to the 'refclk' though
there was never a mention of 'reference clock'. I will respond there.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

