Return-Path: <linux-pci+bounces-35167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6AAB3C793
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 05:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9EFCA05B7F
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 03:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650E72737FB;
	Sat, 30 Aug 2025 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvEbtI1y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FDA6F06B;
	Sat, 30 Aug 2025 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756524121; cv=none; b=QZLArUEivmJTxhAdE0JB3J2Kv1IZ6tG6d6PuXQ4h7FVGf9550Zyl9DU0T/rNJN7+E4kh6ok1PX/Jd+Fc15W8AV4PXx4LL6KWxk9Cc3dX2gFQAAszV1ZP4hM44jU3onPCkFkYpRaYQiKyQrtrFSNsVswgHHTGQ2KDLZJDIsCC7uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756524121; c=relaxed/simple;
	bh=uJCWLg8Xr/0C+/8ZRu6677VYEHkkf5iwokGEhBnGEiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smHQng6mmcFfIxZ5qaUfM6+vco3yO9Yv0co0VOs58tz1kmgHusV7cQ9nGHswQQmoAu7lmqQO21nPuMEto0H/P786fc2xM8Lx49EDtqQ3PKQ7asFmKLgCCIUfMRMuFUrAqgecrz6larrheLaDi7IjoegP1DkRmnY4Oarnwno7ljY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvEbtI1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA81C4CEF0;
	Sat, 30 Aug 2025 03:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756524120;
	bh=uJCWLg8Xr/0C+/8ZRu6677VYEHkkf5iwokGEhBnGEiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvEbtI1ytCwUwam3rCM76cmTxjzFL004GOrQNw0nOxG3e7xUMl0Y2Xb3LISngBCrs
	 quhz/Siq8fyNOa/n5vOlMC3BsLo51jbgRMXLqI0YqhKBgre2UOyFzcPdhbS/qcovLu
	 ULPkFdUuWHYFvAJIaN6F9kSnNRSlb/E5rTnwOFLO6av/oInj11Jdu3KrdRK8pUeE+S
	 nYN2IvDhE6/pkaf4KBQWwLTMkFerx+2QWl9GeGBy5ltBDg0k+zps5rAIy01sNB+eSM
	 QuL2KyC9IMQc5gj/0iUdovvDdJ6or4DypUQ9GwZvEkJg7FLl4I+CtMDzx5A7Q6lQF9
	 hD8I6wodAF2yg==
Date: Sat, 30 Aug 2025 08:51:51 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: 'Krzysztof Kozlowski' <krzk@kernel.org>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	jingoohan1@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com, 
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com, 
	jh80.chung@samsung.com, pankaj.dubey@samsung.com
Subject: Re: [PATCH v3 07/12] dt-bindings: PCI: Add support for Tesla FSD SoC
Message-ID: <3eykohfvqgkbvwirzx63bx65d5uv774gib65bcyjlpphrssfjp@74bqakxvnkmh>
References: <20250811154638.95732-1-shradha.t@samsung.com>
 <CGME20250811154725epcas5p428fa3370a32bc2b664a4fd8260078097@epcas5p4.samsung.com>
 <20250811154638.95732-8-shradha.t@samsung.com>
 <9e065582-9349-4f39-88b5-048d333ab8d7@kernel.org>
 <000901dc101c$917bf160$b473d420$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000901dc101c$917bf160$b473d420$@samsung.com>

On Mon, Aug 18, 2025 at 02:16:16PM GMT, Shradha Todi wrote:
> > > +
> > > +  phys:
> > > +    maxItems: 1
> > > +
> > > +  samsung,syscon-pcie:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +    description: phandle for system control registers, used to
> > > +                 control signals at system level
> > 
> > What is "system level"? and what are these "signals" being controlled?
> > 
> 
> I will add a more detailed description for why the syscon is being used
> 
> > 
> > > +title: Tesla FSD SoC series PCIe Host Controller
> > > +
> > > +maintainers:
> > > +  - Shradha Todi <shradha.t@samsung.com>
> > > +
> > > +description:
> > > +  Tesla FSD SoCs PCIe host controller inherits all the common
> > > +  properties defined in samsung,exynos-pcie.yaml
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pci/samsung,exynos-pcie.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: tesla,fsd-pcie
> > > +
> > > +  clocks:
> > > +    maxItems: 4
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: aux
> > > +      - const: dbi
> > > +      - const: mstr
> > > +      - const: slv
> > > +
> > > +  num-lanes:
> > > +    maximum: 4
> > > +
> > > +  samsung,syscon-pcie:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +    description: phandle for system control registers, used to
> > > +                 control signals at system level
> > > +
> > > +required:
> > > +  - samsung,syscon-pcie
> > 
> > clocks are required, compatible as well.
> > 
> 
> Since this was inheriting the common exynos yaml file and that had these properties
> under required, I did not mention again. Will take care in next version.
> 

dma-coherent needs to be a required property as well since this binding is
supporting only one controller, that seem to have cache coherent DMA.

> > Missing supplies, both as properties and required. PCI devices do not
> > work without power.
> > 
> 
> According to the HW design of FSD SoC, the control to manage PCIe power is given to
> a separate CPU where custom firmware runs. Therefore, the Linux side does not control
> the PCIe power supplies directly and are hence not included in the device tree.

What do you mean by 'PCIe power'? Supply to the PCIe controller/bus or the
devices connected to the bus?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

