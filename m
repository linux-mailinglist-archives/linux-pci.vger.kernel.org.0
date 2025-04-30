Return-Path: <linux-pci+bounces-27025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32792AA43B0
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 09:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DA81C00C9D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 07:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBDA1E1A16;
	Wed, 30 Apr 2025 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mdelu/gF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FDE1DB92A;
	Wed, 30 Apr 2025 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745997421; cv=none; b=rBgHPLTqTW+gRzi1ZK5IkZfRqvPMmBLJ3hm2nPthoySBjSLHqTPYKfzYDNHki0q3p81hDVdPboEMvYCmlFP/QRjKXTTsi8kO70OP/hjUskuWnx8CGEWYCEpFATr0wdTfalBHzAkF2fgjt94CVpzxMlQM/9TMUypfbH1Rp4UikKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745997421; c=relaxed/simple;
	bh=7APuLcwtJfYEKekA+/wgGV9NPKWHxVPgebd65tjT+FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRSdzhyuvuZ6A0CGQiCL/I2WfNlm4ov6Yv/l+GBJD3yz1DITKheruIaD7iRQXP0pOcr3c88Yw4s0TkVCQpRBIVJY4JQa/reI80/QzehWkzJ8CvfCJLwTFEJ2KWPTVJg2MVawze8ppr0qDf4jw/swVAeUuMm6Yk03839KMj0UNYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mdelu/gF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE193C4CEE9;
	Wed, 30 Apr 2025 07:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745997421;
	bh=7APuLcwtJfYEKekA+/wgGV9NPKWHxVPgebd65tjT+FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mdelu/gFgRdZWf9/TJRbdkRSmIq4eCh4iIe0quy0t0lyMhk8VMMjVng03r2RT1g/G
	 J+pqfyY5aI11z0wAs9rhE633GDVH1KYzV3kdA71pxLRHEtNVsf3ceZ0mRilhTwi5yw
	 1dzCSPDyWkoO/ksxzhz7oP7BAhwxF7AgvHekZKFPrLdQHzK2cGzC9DrTqVZ9Ls0+R0
	 7oyswC/3gr/71j8sB5bafD3y86JGxMx6dl24BUa/BRIRIi6+8yKHuWmb2V87D2eWeF
	 K6POhUtKzeFIVHCr/6LeWs54CrPe2YOuEtvVg7RMDsper+vfJxtYE+Zd46kWpVNXOP
	 uHZTLmbsv6laA==
Date: Wed, 30 Apr 2025 09:16:56 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	dlemoal@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: pci-ep: Add ref-clk-mode
Message-ID: <aBHOaJFgZiOfTrrT@ryzen>
References: <20250425092012.95418-2-cassel@kernel.org>
 <7xtp5i3jhntfev35uotcunur3qvcgq4vmcnkjde5eivajdbiqt@n2wsivrsr2dk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7xtp5i3jhntfev35uotcunur3qvcgq4vmcnkjde5eivajdbiqt@n2wsivrsr2dk>

Hello Mani,

On Wed, Apr 30, 2025 at 12:35:18PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Apr 25, 2025 at 11:20:12AM +0200, Niklas Cassel wrote:
> > While some boards designs support multiple reference clocking schemes
> > (e.g. Common Clock and SRNS), and can choose the clocking scheme using
> > e.g. a DIP switch, most boards designs only support a single clocking
> > scheme (even if the SoC might support multiple clocking schemes).
> > 
> > This property is needed such that the PCI controller driver, in endpoint
> > mode, can set the proper bits, e.g. the Common Clock Configuration bit and
> > the SRIS Clocking bit, in the PCIe Link Control Register (Offset 10h).
> > (Sometimes, there are also specific bits that needs to be set in the PHY.)
> > 
> 
> Thanks for adding the property. I did plan to submit something similar to allow
> Qcom PCIe EP controllers to run in SRIS mode.
> 
> > Some device tree bindings have already implemented vendor specific
> > properties to handle this, e.g. "nvidia,enable-ext-refclk" (Common Clock)
> > and "nvidia,enable-srns" (SRNS). However, since this property is common
> > for all PCI controllers running in endpoint mode, this really ought to be
> > a property in the common pcie-ep.yaml device tree binding.
> > 
> 
> We should also mark the nvidia specific properties deprecated and use this one.
> But that's for another follow up series.
> 
> > Add a new ref-clk-mode property that describes the reference clocking
> > scheme used by the endpoint. (We do not add a common-clk-ssc option, since
> > we cannot know/control if the common clock provided by the host uses SSC.)
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/pci/pci-ep.yaml | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> > index f75000e3093d..206c1dc2ab82 100644
> > --- a/Documentation/devicetree/bindings/pci/pci-ep.yaml
> > +++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> > @@ -42,6 +42,15 @@ properties:
> >      default: 1
> >      maximum: 16
> >  
> > +  ref-clk-mode:
> 
> How about 'refclk-mode' instead of 'ref-clk-mode'? 'refclk' is the most widely
> used terminology in the bindings.

I does seem that way.
Will use your suggestion in V2.


> 
> > +    description: Reference clocking architechture
> > +    enum:
> > +      - common-clk        # Common Reference Clock (provided by RC side)
> 
> Can we use 'common-clk-host' so that it is explicit that the clock is coming
> from the host side?

Sure.

I take it that you prefer 'common-clk-host' over 'common-clk-rc' ?


Kind regards,
Niklas

