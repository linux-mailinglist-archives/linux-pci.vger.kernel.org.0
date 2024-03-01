Return-Path: <linux-pci+bounces-4323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D10E86E140
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 13:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B021F223A4
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71753FB88;
	Fri,  1 Mar 2024 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RR5miFg1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CEC7E1;
	Fri,  1 Mar 2024 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709297164; cv=none; b=O2gzd9A697cKZIwtcSM1rzOqUlCHw2gFqlGGSlw03sqcJze7a2O8sVqxUwNjQn4NaCDIVrcBQb3FhJBvBiwzkxE//Ofqx/mkM0agEzt7Cm9vGwBbPwxdUY9zNDoNKdXOyFu7uhOHW4NpSWdz71GkJ5s0XFjBWrhCK8JC+nDTpzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709297164; c=relaxed/simple;
	bh=Zz0zVoGja3cXhFHWcB5UiPfkBIp0SM7xu2HWnAZ05Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4KjexykC5RSs+7GPKgZSWefLgR2nfsalC5WUKaNW4nOMzmP02INlIDF4gH/VtE9xxjcDlN++VApEloS//cYshMnFDPYZya5Y7aEq5pNqWcgg0SFY6xc6fFvmziMq5HkpeNdajcddbp/KTx7IPu599v14xqIb/VNyXWnF9RfPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RR5miFg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169B9C433C7;
	Fri,  1 Mar 2024 12:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709297164;
	bh=Zz0zVoGja3cXhFHWcB5UiPfkBIp0SM7xu2HWnAZ05Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RR5miFg1MbKC8vvcwq6NzLC782LATfreZUIRbVKNW2lo+QvieyB2UVH6UD3RlJagO
	 Wcj3ZTvr4/RVH7eHon1cljpL6j1N0qVpaODmJ4q8bgpwKjm7Oza0ws+RqjQnuL0Fks
	 tSBW3Ii6eBrjxVqg5jh4KKsk6tjttvTIYvIovTLTeIe9Vhwsg6zvFGVYvicxMCkSil
	 NDKNA6pWwI8NnUZhIcDcEGM/yz5RUdrHSWqgciGLZgm8cIvryUxkKvf9iMsq81YoHc
	 nMZxaVmQ74iMSji0quwRNAlhO6CARUduWu4+Lnf2Z45lpGJ+fFT0suABp3KH9qXrpL
	 nuQaLLZDKBgiQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rg2HH-0000000016H-1tzj;
	Fri, 01 Mar 2024 13:46:15 +0100
Date: Fri, 1 Mar 2024 13:46:15 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] arm64: dts: qcom: sc8280xp: PCIe fixes and
 GICv3 ITS enable
Message-ID: <ZeHOF4p1LlNDiLcy@hovoldconsulting.com>
References: <20240223152124.20042-1-johan+linaro@kernel.org>
 <20240228220843.GA309344@bhelgaas>
 <20240229100853.GA2999@thinkpad>
 <ZeBbrJhks46XByMD@hovoldconsulting.com>
 <20240229122416.GD2999@thinkpad>
 <ZeCCPRVvYCNfMYnd@hovoldconsulting.com>
 <20240229135407.GE2999@thinkpad>
 <ZeCktwcEFAfCEVkV@hovoldconsulting.com>
 <20240301122406.GA2401@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301122406.GA2401@thinkpad>

On Fri, Mar 01, 2024 at 05:54:06PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Feb 29, 2024 at 04:37:27PM +0100, Johan Hovold wrote:

> > I'm all for digging further into this issue with the help of Qualcomm,
> > but I don't think that should block this series as that would leave the
> > link errors that we hit since 6.7 in place and effectively prevent us
> > from enabling the ITS in 6.9.
> 
> Sounds fair. I will report back, perhaps with a fix based on what I get to know.

Sounds good, thanks.

> But I think it is better to disable L0s in the SoC dtsi itself. That's not only
> because there are patches to essentially disable L0s in 2 of the available
> platforms making use of this Soc, but also you are enabling GIC ITS in the SoC
> dtsi and that may affect sa8540p which is making use of this dtsi.

I did not do so on purpose as I'm only disabling L0s on machines where
I've confirmed the issue. And the assumption for now is that this is a
machine-level issue.

> The users of that SoC may have not noticed the errors as you did before, but
> enabling GIC ITS will certainly make the issue visible to them (more likely).

Sure and that would be good to know as that would give us another data
point which may help determine where the problem lies. Enabling the ITS
will (hopefully) be done in 6.9 so we'll have a whole cycle to disable
L0s where needed. I don't think this should be done before then.

Johan

