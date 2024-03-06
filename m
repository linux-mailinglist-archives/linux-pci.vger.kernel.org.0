Return-Path: <linux-pci+bounces-4553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEF087323B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 10:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA82128A396
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13A85D91A;
	Wed,  6 Mar 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrOgL34i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE30B5D8FA;
	Wed,  6 Mar 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716345; cv=none; b=FS1+wbbFBYL3hzM5AE3SNEd8ALD/OMOssEjMMuYaJfVckQx6tmvwVhY6aU/6TYF4TX6SWEBEQAP85qEo4HCeaXIegmHXoa0quVM70av7SK9YYYiLPG30ImuwiOOflDhCiALU+I1fujIDA2GHp+dCrr0rOw0G/3W4aj+tuClT+kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716345; c=relaxed/simple;
	bh=e/HA3/Wu6r00AM+Hcn0703vmIttHljfM3nHEyflR5DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H49t1wCyDZrwHy8qZjCwN3Ah4eB820KHA2LFC2Q0VQaZlDPMI8qLony6GetoXVQUhs666CtoyW/UHB7atEp4IJvOIuryM96Ek7n97MykEJ3n4x92JF7ol801aPObHhu0itjP/OV1gS3v+OGcmA6jN2AWNTBnEGtfSw2k/+c0HJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrOgL34i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19225C433C7;
	Wed,  6 Mar 2024 09:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709716345;
	bh=e/HA3/Wu6r00AM+Hcn0703vmIttHljfM3nHEyflR5DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CrOgL34i8C9TMoIflZBCmnMRQNCK7UwMEqK8eS7KWQRgfDrlYUZ3ZHnkLyxeLxSZ8
	 hcvhIvdFxhiY+wOjKtO7GkIv/+iF1a/Y68Ek9DIbj2gfpaekgeRFmKg1WsQx4Ro3se
	 Y2Dty1mvJm7+Tc2gk7yTfHJ+4qOUKE8+XoMjN8PYywVkM6wu30RKvKhv4UrXmxJ8WV
	 8oMu52r2nEjjhCb4fcNAzqdDTDkGHJ/0OBFwDfVZNV8IsHD433pGC+XcfOSWH7bAcR
	 oYtbkTVfnlUhMB49f58Cbz1RhvTat7xgm0mdlOThUdlhiR4k7Xy7c7f79+upTdD1EP
	 sz7CG4PEerjmw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rhnKB-000000008RC-0EJv;
	Wed, 06 Mar 2024 10:12:31 +0100
Date: Wed, 6 Mar 2024 10:12:31 +0100
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
Message-ID: <Zegzf_QKbr8yA6Vw@hovoldconsulting.com>
References: <20240305081105.11912-1-johan+linaro@kernel.org>
 <20240306063302.GA4129@thinkpad>
 <ZegZMNWxCnLbHDxP@hovoldconsulting.com>
 <20240306083925.GB4129@thinkpad>
 <CAA8EJppsbX=YXf1Z6Ud+YMnp2XnutN1hcb1T0KdAAWXFREVxXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJppsbX=YXf1Z6Ud+YMnp2XnutN1hcb1T0KdAAWXFREVxXg@mail.gmail.com>

On Wed, Mar 06, 2024 at 10:48:30AM +0200, Dmitry Baryshkov wrote:
> On Wed, 6 Mar 2024 at 10:39, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > On Wed, Mar 06, 2024 at 08:20:16AM +0100, Johan Hovold wrote:
> > > On Wed, Mar 06, 2024 at 12:03:02PM +0530, Manivannan Sadhasivam wrote:

> > > > Just received confirmation from Qcom that L0s is not supported for any of the
> > > > PCIe instances in sc8280xp (and its derivatives). Please move the property to
> > > > SoC dtsi.

> > > Ok, thanks for confirming. But then the devicetree property is not the
> > > right way to handle this, and we should disable L0s based on the
> > > compatible string instead.

> > Hmm. I checked further and got the info that there is no change in the IP, but
> > the PHY sequence is not tuned correctly for L0s (as I suspected earlier). So
> > there will be AERs when L0s is enabled on any controller instance. And there
> > will be no updated PHY sequence in the future also for this chipset.
> 
> Why? If it is a bug in the PHY driver, it should be fixed there
> instead of adding workarounds.

ASPM L0s is currently broken on these platforms and, as far as I
understand, both under Windows and Linux. Since Qualcomm hasn't been
able to come up with the necessary PHY init sequences for these
platforms yet, I doubt they will suddenly appear in the near future.

So we need to disable L0s for now. If an updated PHY init sequence later
appears, we can always enable it again.

> > So yeah, let's disable it in the driver instead.

Johan

