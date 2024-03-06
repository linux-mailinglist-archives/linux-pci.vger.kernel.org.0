Return-Path: <linux-pci+bounces-4547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99793872F73
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 08:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A9D281FCC
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 07:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5565C5EB;
	Wed,  6 Mar 2024 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5r5V81E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3806F5BAD4;
	Wed,  6 Mar 2024 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709610; cv=none; b=M6bKL1x+hIO0mAD9T6PWsx69ICj2p42s2+F9DHwQ7BsuARI6uKzxhbJmnDjwFIPi6q2E1pvYdSRKs6/ti6V/QnWul5xl75m9YIxSGir/lxq2lOQOJCGlk7xYf5cOyxuSRg0vfKnZhX7APu30djRH6775GT4WEla96C8iRfhE7ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709610; c=relaxed/simple;
	bh=7e0GVHgO/NR/ITDXSFCFIpgdS6eMgQdfekTQKe26Z6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3wUEZTENNBuK5bvcdDIHi/WJvFHtOTBMp9BUAVnvaEtdcT3sypn7g7ENrhHYFFE69E7BwYM0vV8llzSBHL2jlptDzuCci3fhj1dvjU6zBcYw0LAMZ3Rp4O4dL4DtQci45lj4SMwvIjAeFF2PhgZXsSKDQYB4spZA0K6CTTko6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5r5V81E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AC8C43390;
	Wed,  6 Mar 2024 07:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709709609;
	bh=7e0GVHgO/NR/ITDXSFCFIpgdS6eMgQdfekTQKe26Z6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5r5V81EhuBe6LjOo3DLR4LJFl+7dNzzIISuOk/XIYakZFh6e6G5M3ObQxSKKkiw/
	 bgN5f9Hr0Id6WHlCwrOxGH1CUt7N78xGPxA1KNUnnkmt31lDwDVKZPjtx3eitjNSTW
	 ouJm2Og3CB6PSiuQkdcQaFmAbVth8JAFPH5grOXzTLVaM9M2qKBluY8DbkuCXBngYM
	 dTPQkJGPb/lPQ1Ev55bp+vZ1P/3rfRLlU+tj0DPtQzX3+Bsb7ZLVkMYL4bNslfXzS2
	 TCkdKyxtTjHvbkRptE6vkoxnsjH6cc+ZREHX7rZREMzP0/x8MTHiMTXG5lP+QzjUZF
	 kxYDGbw0UgreQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rhlZY-0000000053i-20wI;
	Wed, 06 Mar 2024 08:20:16 +0100
Date: Wed, 6 Mar 2024 08:20:16 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
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
Subject: Re: [PATCH v3 00/10] arm64: dts: qcom: sc8280xp: PCIe fixes and
 GICv3 ITS enable
Message-ID: <ZegZMNWxCnLbHDxP@hovoldconsulting.com>
References: <20240305081105.11912-1-johan+linaro@kernel.org>
 <20240306063302.GA4129@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306063302.GA4129@thinkpad>

On Wed, Mar 06, 2024 at 12:03:02PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 05, 2024 at 09:10:55AM +0100, Johan Hovold wrote:
> > This series addresses a few problems with the sc8280xp PCIe
> > implementation.
> > 
> > The DWC PCIe controller can either use its internal MSI controller or an
> > external one such as the GICv3 ITS. Enabling the latter allows for
> > assigning affinity to individual interrupts, but results in a large
> > amount of Correctable Errors being logged on both the Lenovo ThinkPad
> > X13s and the sc8280xp-crd reference design.
> > 
> > It turns out that these errors are always generated, but for some yet to
> > be determined reason, the AER interrupts are never received when using
> > the internal MSI controller, which makes the link errors harder to
> > notice.

> > Enabling AER error reporting on sc8280xp could similarly also reveal
> > existing problems with the related sa8295p and sa8540p platforms as they
> > share the base dtsi.
> > 
> > After discussing this with Bjorn Andersson at Qualcomm we have decided
> > to go ahead and disable L0s for all controllers on the CRD and the
> > X13s.
 
> Just received confirmation from Qcom that L0s is not supported for any of the
> PCIe instances in sc8280xp (and its derivatives). Please move the property to
> SoC dtsi.

Ok, thanks for confirming. But then the devicetree property is not the
right way to handle this, and we should disable L0s based on the
compatible string instead.

> > As we are now at 6.8-rc7, I've rebased this series on the Qualcomm PCIe
> > binding rework in linux-next so that the whole series can be merged for
> > 6.9 (the 'aspm-no-l0s' support and devicetree fixes are all marked for
> > stable backport anyway).

I'll respin the series. Looks like we've already missed the chance to
enable ITS in 6.9 anyway.

Johan

