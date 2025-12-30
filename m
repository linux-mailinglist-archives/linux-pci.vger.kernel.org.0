Return-Path: <linux-pci+bounces-43833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 808F9CE9478
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 10:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C2F03012BF5
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 09:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905E62FD7BC;
	Tue, 30 Dec 2025 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqwrhjIp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8A12FD1B5;
	Tue, 30 Dec 2025 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767088781; cv=none; b=Sp2Y9k3LDPl+4ylzo/aMnyP/rCgx3EjjdKj+7sbWHNAFmt2EOaT4ZemfRwHn8cQXYa7yyatWtvt7eL968WiWOM6m49JZqvonc3vpyW7C3poacVmWhsCSuNOT2BMCN7hYCnLEWKL4BZi4chPOh3lJu84+sHdq6rquHupOaYiIDH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767088781; c=relaxed/simple;
	bh=WQMM7B12M9tIAmaZVZs3gPdILEXJR91D0xsOKWnW8Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOBIoTI4VU4yi8Xbd1nVlYnaY7y/LFOo6yh0y2lWP3DqeHLKYbPYfJGDQAIThxjz81WR1jSJ9MeMQKPO1xo8B18PNnIayxn/HEJHwhYJln9B/QsLP7T5heGnkQ3gtEBIupSJfPEDBC9C8fcWdi3dt/1HlblTkCATAvP1W1LLJTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqwrhjIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805D4C4CEFB;
	Tue, 30 Dec 2025 09:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767088780;
	bh=WQMM7B12M9tIAmaZVZs3gPdILEXJR91D0xsOKWnW8Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqwrhjIpRrmUHbOHO5zyLEza02aPUJI3mccQhmKPtxIZJ9a/63KUmdx1YAbxcCL7u
	 KTnKKlvrtH6j5FiVziTV3W29DE5n+FhJXL9b08FKGcm2M2LaBVIE1sp1k543D6KE09
	 m3ys6JQk//QzYdKUsn2kDO9mgP2ubbHdsrROvC8IHIik/q0SRFbCwm3aNm1PHCrMqV
	 b++Jl1KwixUXFPjevpwrPqzaAO5G+fMBMQNemV31K9hVERlEbGKfrF6rIT+bSDxns3
	 qaPreNpkBNr+8agQGhRF8nS4SZWwIfG0sqJRaYlrNUyo5td/4cVhzzYGfPOL7HbLHC
	 g+0h79GzwpqoA==
Date: Tue, 30 Dec 2025 15:29:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Damien Le Moal <dlemoal@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org, linux-ide@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 0/5] PCI: Add initial support for handling PCIe M.2
 connectors in devicetree
Message-ID: <jhykqitumvq6jr63euamjdli4zntxbxasepx3g5nn4m45fu4ou@m2v44lk7lbby>
References: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com>
 <aVOcgDeOejO9m1zE@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVOcgDeOejO9m1zE@ryzen>

On Tue, Dec 30, 2025 at 10:33:52AM +0100, Niklas Cassel wrote:
> Hello Mani,
> 
> On Sun, Dec 28, 2025 at 10:31:00PM +0530, Manivannan Sadhasivam wrote:
> > The Mechanical Key M connector is used to connect SSDs to the host machine over
> > PCIe/SATA interfaces. Due to the hardware constraints, this series only adds
> > support for driving the PCIe interface of the connector in the kernel.
> 
> Since this series does not add any support for SATA, do we really want to
> modify the SATA device tree binding?
> 
> I know that device tree describes the hardware, but if there is no software
> that makes use of this, the SATA DT binding change feels a bit unnecessary.
> 
> Do we perhaps want to defer modifying the SATA DT binding change until the
> corresponding change in software is added?
> 

I'll defer the question to Rob since he was the one who asked for the SATA
binding change:

https://lore.kernel.org/all/20251208191110.GA2473021-robh@kernel.org

- Mani

-- 
மணிவண்ணன் சதாசிவம்

