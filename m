Return-Path: <linux-pci+bounces-4889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D832387F850
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 08:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926CB282ACD
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 07:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C095751C42;
	Tue, 19 Mar 2024 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIO8unB1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552553818;
	Tue, 19 Mar 2024 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833133; cv=none; b=h0jSNRV86uSCyCYoCZt084uuTqBtzQDSElh8IEBL+xSy24iTWcvDYxsu2oHdsfId06FCjtXxuYfcvTNLXWbyyj09ZTYVzQbFbxSzWoafWZJlQL+JFoUqlK2cHqGiNzpqacgbKFHDne9oACaQV/4tUmhHtJ24HR+ml0RJp3oOUlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833133; c=relaxed/simple;
	bh=5rG0sUDoiZrvoz6iRtGyeAQK9MoHwCjGsgwcUU3ymyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbXqUrHMsUNVqcl7DOHGBBWhLAk48D5hDf51SveZUf3DGgA54+GXCBHbW5tYHBeT+pI8fokULzcyFzQfyum5QYZd6k2shsg3He1kP68DgoYc7r8KoNscVuYQ4MKS/6YzcOdjcJNFhOl6CtXnxNrdUIWNYqN07WifevJkB615D3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIO8unB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014F6C433F1;
	Tue, 19 Mar 2024 07:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710833133;
	bh=5rG0sUDoiZrvoz6iRtGyeAQK9MoHwCjGsgwcUU3ymyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kIO8unB1oXF7hmV2W9nys/h02n3+MsCWFwPGT9EDjUfzK8WQnVw0gZBh5ofXTl4Do
	 mNOPe24YWgZsSj7cozvCpNH5EG4JU2msOPEYFUkFAfzV+0hSnfeqxCRm+4+IYXbCjg
	 DHnad96vPblkBHASix6x14yArkYJmlVOmSzd4ZFQBZmp23kHLlsa0yMsa107tgSGAw
	 KqtkoX6UfbhKXkYk15zaB9zI3Cladrbw5D4Y68aPVLK0iuXnUfMeXtCL4adFwjp9u9
	 kz3nLR1ymajfF2JeXD7lbjV7ZFvRBu67HtGVAg0DdN/8OQRyr6qUNrNnLr0ezb+8uk
	 KVSNq1SRqlrcw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rmTqs-0000000040Q-2ZCK;
	Tue, 19 Mar 2024 08:25:38 +0100
Date: Tue, 19 Mar 2024 08:25:38 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/5] arm64: dts: qcom: sc8280xp: PCIe fixes
 and GICv3 ITS enable
Message-ID: <Zfk98hYPn7kiFGkt@hovoldconsulting.com>
References: <20240306095651.4551-1-johan+linaro@kernel.org>
 <171081652637.198276.6219023769904423414.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171081652637.198276.6219023769904423414.b4-ty@kernel.org>

On Mon, Mar 18, 2024 at 09:48:30PM -0500, Bjorn Andersson wrote:
> 
> On Wed, 06 Mar 2024 10:56:46 +0100, Johan Hovold wrote:
> > This series addresses a few problems with the sc8280xp PCIe
> > implementation.
> > 
> > The DWC PCIe controller can either use its internal MSI controller or an
> > external one such as the GICv3 ITS. Enabling the latter allows for
> > assigning affinity to individual interrupts, but results in a large
> > amount of Correctable Errors being logged on both the Lenovo ThinkPad
> > X13s and the sc8280xp-crd reference design.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [4/5] arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
>       commit: 2b621971554a94094cf489314dc1c2b65401965c

I noticed that you applied both of these for 6.10, but this one is a fix
that should go into 6.9.

> [5/5] arm64: dts: qcom: sc8280xp: enable GICv3 ITS for PCIe
>       commit: 81051f14a66c3913f1d219bd97e47002f1dc91de

Johan

