Return-Path: <linux-pci+bounces-3593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B579E857C46
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 13:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71EEA2845DA
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 12:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62CD78672;
	Fri, 16 Feb 2024 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENf1xW2O"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25EE2CCB4;
	Fri, 16 Feb 2024 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708085041; cv=none; b=gjbLX4VnieR6SoCMYCLkxLnd/56eB9Dutc3lsXE6yl5VlrtafCRAhV9bspOyonFrR+NySuV5aHQqEt2t9Expr6/6Gcx6LQYARHVLwSY1AesxiMNNq6GGtJZbQF4d107pJ+dr0075QQaE+Q/TFqLNF/aupVmxvLoFeR5CqFqNyQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708085041; c=relaxed/simple;
	bh=PTQ7drOCFYR2XmjE20PfxIFEdOUFSjak+DYt3wb3o9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4+Ihq5bS9Gm8U5fD/F5HRAn+7ibUzpT3uH+44J58FlbPdPfNstP8WchQ2OY5BzO/LJ5fi91Ib/N7RxF4yUNQwV01l4Z5dbLGVQwgOU5aPDuskhXfk1sD2EThHMlggLJ8z2lbKcTZ08hzFZcp8C1baJQAC6R2fSspvXww8CsSJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENf1xW2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330F1C433F1;
	Fri, 16 Feb 2024 12:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708085041;
	bh=PTQ7drOCFYR2XmjE20PfxIFEdOUFSjak+DYt3wb3o9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ENf1xW2OgcNbljzsuHsPEhYwTKzsVzgBg4eRNA3QwsyDwto/DoeOhthzC5hFd3YcY
	 bSDRt/wq2OUVgMwczv9bee0uGYiSKvimudWKE1/FbjNMSaAP2z/tZ/Iu2dxA19+0Kq
	 peHCuMpufuc9pKv//UsD70WTtzO4rty9jb31/QINryu4P6UJCZp+YjITx3aProa3GH
	 sXn/uadLXP3c1o3klh9kZovcG5324aDuvmT84F6M4BHxU8wnTt4RAJmIACH9dJHm7I
	 S7L7tSQ/WyWM8Sa0QE7wMbG2aPItW1h+en9oiRVrLzRG2PXjBtAQsH1e+ui/LI4Xci
	 JBMybJlrD+nPg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rawx7-000000007JX-2OIU;
	Fri, 16 Feb 2024 13:04:25 +0100
Date: Fri, 16 Feb 2024 13:04:25 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] arm64: dts: qcom: sc8280xp-crd: limit pcie4 link
 speed
Message-ID: <Zc9PSfah4ACuMYVm@hovoldconsulting.com>
References: <20240212165043.26961-1-johan+linaro@kernel.org>
 <20240212165043.26961-5-johan+linaro@kernel.org>
 <a2323580-6515-4380-a7d8-fd25818e9092@linaro.org>
 <Zc8K7iiK4YbnadtQ@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc8K7iiK4YbnadtQ@hovoldconsulting.com>

On Fri, Feb 16, 2024 at 08:12:46AM +0100, Johan Hovold wrote:
> On Thu, Feb 15, 2024 at 09:47:01PM +0100, Konrad Dybcio wrote:
> > On 12.02.2024 17:50, Johan Hovold wrote:
> > > Limit the WiFi PCIe link speed to Gen2 speed (500 GB/s), which is the
> > 
> > MB/s
> 
> Indeed, thanks for spotting that.
> 
> > > speed that Windows uses.

> > Hm.. I'dve assumed it ships with a WLAN card that supports moving
> > more bandwidth.. Is it always at gen2?

> But yes, it seems we may be limiting the theoretical maximum data rate
> for the wifi this way.

It looks like the peak wifi speed for these chips is 3.6 Gbps, and it
may be lower for the X13s (and in practice). So 500 MB/s should be more
than enough.

	https://www.qualcomm.com/products/technology/wi-fi/fastconnect/fastconnect-6900

Johan

