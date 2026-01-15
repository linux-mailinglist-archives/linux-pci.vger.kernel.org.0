Return-Path: <linux-pci+bounces-44933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C18D23FEA
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 11:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E798302168C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 10:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1767336C0CE;
	Thu, 15 Jan 2026 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ov88QUlV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CB52236E0;
	Thu, 15 Jan 2026 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473852; cv=none; b=IxkxmouB15U6EGq/yMCPtWZ0pgKbUE7E+Uhl2z12BH70dwZqsO0UiQGT0LnL8givH+kZ4/4onZ9Khvom/JpWwlOyhKNuRXZ7+F6Nn8LIUoETmKPbmDe0ByH9JSngrZ3tSiIGFe0Agpy9xFm1gV/pW0W0gY+AwG/OJa87pqIGR7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473852; c=relaxed/simple;
	bh=Br66xhJUW6Skly14rBwfApxEJ7tEni4TvDeAZjMZJtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzS01Dzt+w/mwIsjosRcxpZMYhmu9Nnv9122NHEflTumlJ/94AEnQavEBp+gpCqA5NuwEOtX7Z6BFWbBoNJlCaRzd1PFZL9REDbSHRZtZG+1TyJkuvFYofKJIT1EPpNcmytsW77UM8sf2SZwLsuPDdAxJPlqfImz0Nn+wDe2/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ov88QUlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A908C116D0;
	Thu, 15 Jan 2026 10:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768473851;
	bh=Br66xhJUW6Skly14rBwfApxEJ7tEni4TvDeAZjMZJtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ov88QUlVwP5VS7KgIHYLlLvIrQDLR3mhM8zQZl6GbJhlysJf3FteSBdkA2m9jeqh/
	 H2AD5M9LyhI1hYSC18Ot7nf9DydQNjXb2umVxQNypcp9I4juEvwJKEcHQ3TenBXJwb
	 0DkDKG/KuFd31ETxC1feT8R2l7QZFSWTaAKudtj+TAHHAhHeCknpw5BaZPWv4Laup/
	 Cw7KiBG11AGFVmOr8zv04i/Q44IMIkcte5kE4nmx2P7oFkuFbflIB106hEwHbHoOGx
	 p7C0PKpNRlHYQCgDi73ezlfW0tIfoQjQ6sqB4Bgsg2AmkedV06SVCR+wRjC8GEcQcK
	 5CXPG12V1QK7w==
Date: Thu, 15 Jan 2026 16:13:53 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 6/9] dt-bindings: connector: m2: Add M.2 1620 LGA
 soldered down connector
Message-ID: <7fkc5c65jxxwemd4ons44fkzhg6ppzbam24uvfahmu4d7bmr2o@4ipkh7qqcovi>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-6-eff84d2c6d26@oss.qualcomm.com>
 <20260113172536.GA3975461-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113172536.GA3975461-robh@kernel.org>

On Tue, Jan 13, 2026 at 11:25:36AM -0600, Rob Herring wrote:
> On Mon, Jan 12, 2026 at 09:56:05PM +0530, Manivannan Sadhasivam wrote:
> > Lenovo Thinkpad T14s is found to have a soldered down version of M.2 1620
> > LGA connector. Though, there is no 1620 LGA form factor defined in the M.2
> > spec, it looks very similar to the M.2 Key M connector. So add the
> > "pcie-m2-1620-lga-connector" compatible with "pcie-m2-e-connector" fallback
> > to reuse the Key M binding.
> 
> Key M or Key E? I'm confused.
> 

Sorry, typo due to respinning both series at a time. Key E only.

- Mani

> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/connector/pcie-m2-e-connector.yaml       | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> > index b65b39ddfd19..9757fe92907b 100644
> > --- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> > @@ -17,7 +17,14 @@ description:
> >  
> >  properties:
> >    compatible:
> > -    const: pcie-m2-e-connector
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - pcie-m2-1620-lga-connector
> > +          - const: pcie-m2-e-connector
> > +      - items:
> > +          - enum:
> > +              - pcie-m2-e-connector
> >  
> >    vpcie3v3-supply:
> >      description: A phandle to the regulator for 3.3v supply.
> > 
> > -- 
> > 2.48.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

