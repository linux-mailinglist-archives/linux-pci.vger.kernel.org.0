Return-Path: <linux-pci+bounces-4557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F191D873323
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 10:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A752A1F25875
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 09:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0F55F49C;
	Wed,  6 Mar 2024 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHFtTZwV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214195DF37;
	Wed,  6 Mar 2024 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718853; cv=none; b=FOlcBX8gzQClFc+KT1TAF0tTDyWVKl7x4SQH3IdCtEQaTjELe9eIvA9KeyTWNcNlt5YiQffUYNE1gF6Ua5CvIBXqmFm5tTpY+odlsjOCfzMjY3I5LCyx5cN+Lrx0zMOkXGCRMmZPkISsEByjIdX05iTDmGQphRwbDtgzxY7U9ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718853; c=relaxed/simple;
	bh=4mj6rQLHXzZGluvEPep1VdO/+AkWaC1Woi35qDutu0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbwIrjia4OUy8ec3b1bEHNucGKn7NsKsJElAIP1KTmpW3mlzaFkGKUmxuOEIdQN4jEJ/BHCuiU2N07/noFvXpyzlRXNCYHmWi+xONdKtQVsmsenGl21FU8dt/aOQGXQrVfi/neLy8ETjT19sIpp/fE4ByPz9sVFrjoaNDhf3HTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHFtTZwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3296C433F1;
	Wed,  6 Mar 2024 09:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709718852;
	bh=4mj6rQLHXzZGluvEPep1VdO/+AkWaC1Woi35qDutu0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VHFtTZwVg80vMOmKCaUuT3qvJDKET0IKlm88QT3fHZA8mJmFrwdJemjslDVDFfMwB
	 ET9qBiPvpib09VwaRB0meoYfbP98+avGtsIl2h4i946N1O4P1Fb3kJDD+aSNZYVaKW
	 IaqfNzyOty0h9gFpcwNHCytIuv4XezVy8yusf7FZSnUwdQVjuetaezqrkWYwPhLpzK
	 pMRxOewS0zY4RYsjfRUBNCHE7o9zxgYR0vQzt0dnk8Hd6gvGaEA1pUbNRQMpjAWFp5
	 ipAB94xMcoVJ7G073SdepaKnRwsYXs8mvxJHHwF9PUGRUUUAznoozCKFlobfvAYf4m
	 aUHrexfUUXFwQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rhnyd-0000000019w-1qzg;
	Wed, 06 Mar 2024 10:54:20 +0100
Date: Wed, 6 Mar 2024 10:54:19 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
Subject: Re: [PATCH v3 00/10] arm64: dts: qcom: sc8280xp: PCIe fixes and
 GICv3 ITS enable
Message-ID: <Zeg9S4Jtxg5D2cBu@hovoldconsulting.com>
References: <20240305081105.11912-1-johan+linaro@kernel.org>
 <20240306063302.GA4129@thinkpad>
 <ZegZMNWxCnLbHDxP@hovoldconsulting.com>
 <20240306083925.GB4129@thinkpad>
 <CAA8EJppsbX=YXf1Z6Ud+YMnp2XnutN1hcb1T0KdAAWXFREVxXg@mail.gmail.com>
 <Zegzf_QKbr8yA6Vw@hovoldconsulting.com>
 <20240306093857.GC4129@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306093857.GC4129@thinkpad>

On Wed, Mar 06, 2024 at 03:08:57PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 06, 2024 at 10:12:31AM +0100, Johan Hovold wrote:
> > On Wed, Mar 06, 2024 at 10:48:30AM +0200, Dmitry Baryshkov wrote:
> > > On Wed, 6 Mar 2024 at 10:39, Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > On Wed, Mar 06, 2024 at 08:20:16AM +0100, Johan Hovold wrote:

> > > > > Ok, thanks for confirming. But then the devicetree property is not the
> > > > > right way to handle this, and we should disable L0s based on the
> > > > > compatible string instead.
> > 
> > > > Hmm. I checked further and got the info that there is no change in the IP, but
> > > > the PHY sequence is not tuned correctly for L0s (as I suspected earlier). So
> > > > there will be AERs when L0s is enabled on any controller instance. And there
> > > > will be no updated PHY sequence in the future also for this chipset.
> > > 
> > > Why? If it is a bug in the PHY driver, it should be fixed there
> > > instead of adding workarounds.
> > 
> > ASPM L0s is currently broken on these platforms and, as far as I
> > understand, both under Windows and Linux. Since Qualcomm hasn't been
> > able to come up with the necessary PHY init sequences for these
> > platforms yet, I doubt they will suddenly appear in the near future.
> > 
> > So we need to disable L0s for now. If an updated PHY init sequence later
> > appears, we can always enable it again.
> 
> It could be the same case for all 'non-mobile' chipsets (automotive, compute,
> modem). So instead of using the compatible, please add a flag and set that for
> all non-mobile SoCs. Like the ones starting with SAxxx, SCxxx, SDxxx.

I've already updated the series and was just about to post it. Disabling
for further platforms would also require matching on the compatible
string and we can easily do that in a follow-up patch once we have some
confirmation that it is needed.

Johan

