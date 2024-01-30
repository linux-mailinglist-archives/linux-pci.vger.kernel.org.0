Return-Path: <linux-pci+bounces-2789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7AF842015
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 10:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9AC1C25B26
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 09:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A7960BBA;
	Tue, 30 Jan 2024 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWRJN3g7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0027760BB0;
	Tue, 30 Jan 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608098; cv=none; b=HwHEIbDLyJGuSyktoMr9shSrBzct9TrEZxyG0zddm2nClPQkWT1Qbb3WotDryAFZDZoLueO6shtF8Hhks79vgbrFmHBM/yxpWSgOvi/u9NHcyAz3cB72i73YLoLMJkriMnqgMHVJhEy8D1unmcXQujiCWm98cfoxT02aO5ithZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608098; c=relaxed/simple;
	bh=Gk3O7xNePa/BvuxS5xywJTjNNf9oVpimuDpdQFWGd1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLlJni5g72V0G1bnzsp+RySUis5zxt200PqDM2yphMZZY9D6K18/OS5YH1g2S2tLVo3x4yHCZ8MDMUvVbpuljSHsZwL4uzp/cUHQ6+wkAz45PPUFtcpvgOBQeXAhPbuW7DFCwlEyTeJia05J0gLYPp4XQhrto467UEI+56+mE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWRJN3g7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF425C433C7;
	Tue, 30 Jan 2024 09:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706608097;
	bh=Gk3O7xNePa/BvuxS5xywJTjNNf9oVpimuDpdQFWGd1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWRJN3g74c8qWlkPuvdsDXpXvLioaCVVHeKuGXhAtgZt9AMr90V3E9wLUr6HousSw
	 3C1Ozlm2Kl3tfeoYhGJQHl5yd70OMZwuK4lyxiGzHtgaN+ekJFiBOnoZ5+4WBdIgSr
	 FgPwEct+6ETAUhysZpBgap7FmFGXKJvwSwufQy/fRlUV3KCUzIBe4iF4Lw1DFfgcgP
	 cTHYMLC4gy8vIYM48hQ+3W9yWa/LJG/rq5sKVzyzeX5bhvR9gpJSnKMhRS13tQzPx6
	 2OYE77wcbBQOkPMldsT/yL4tCON7CI8xnyBUiNdeqr0PYa7xomxjgJM832/BpJo6yJ
	 pQg9obmk3+rIA==
Date: Tue, 30 Jan 2024 15:18:04 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/6] arm64: dts: qcom: sm8450: Add opp table support
 to PCIe
Message-ID: <20240130094804.GD83288@thinkpad>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-5-77bbf7d0cc37@quicinc.com>
 <20240129160420.GA27739@thinkpad>
 <20240130061111.eeo2fzaltpbh35sj@vireshk-i7>
 <20240130071449.GG32821@thinkpad>
 <20240130083619.lqbj47fl7aa5j3k5@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130083619.lqbj47fl7aa5j3k5@vireshk-i7>

On Tue, Jan 30, 2024 at 02:06:19PM +0530, Viresh Kumar wrote:
> On 30-01-24, 12:44, Manivannan Sadhasivam wrote:
> > On Tue, Jan 30, 2024 at 11:41:11AM +0530, Viresh Kumar wrote:
> > > I don't have any issues with a new callback for bw. But, AFAIU, the DT
> > > is required to represent the hardware irrespective of what any OS
> > > would do with it. So DT should ideally have these values here, right ?
> > > 
> > 
> > Not necessarily. Because, right now the bandwidth values of the all peripherals
> > are encoded within the drivers. Only OPP has the requirement to define the
> > values in DT.
> 
> I have a bit different argument here. I am saying that it doesn't
> matter if we have OPP framework or something else using these values.
> The hardware must be represented properly by the DT, so Linux or any
> other firmware/OS can program the device. So DT should have bandwidth
> values anyway. And that's the way we have designed things in Linux
> now.
> 

So you are saying that the ICC core itself should get the bw values from DT
instead of hardcoding in the driver? If so, I'd like to get the opinion from
Georgi/Bjorn.

> > > Also, the driver has already moved away from using those macros now
> > > and depend on the OPP core to do the right thing. It only uses the
> > > macro for the cases where the DT OPP table isn't available. And as
> > > said by few others as well already, the driver really should try to
> > > add OPPs dynamically in that case to avoid multiple code paths and
> > > stick to a single OPP based solution.
> > > 
> > 
> > Still I prefer to use OPP for bandwidth control because both the voltage and
> > bandwidth values need to be updated at the same time. My only point here is, if
> > OPP exposes a callback for bw, then we can keep the DT behavior consistent.
> 
> Feels like we are going a bit backward on this. The current view, as
> per me, is that driver shouldn't need to micromanage all these
> configurations and the OPP core should be able to handle them. That's
> why we want to handle all configurations from there.
> 
> This also means that the DT needs to contain all this information and
> drivers shouldn't use special math functions to calculate these
> values. Drivers need to move away from them, instead of getting more
> of those.
> 
> I don't see how a callback would be helpful here, if the driver relies
> on DT values only. Or am I confusing things here ??
> 

No, there is no confusion here, but a difference in perspective. Let's get the
thoughts of Georgi/Bjorn on this. I just want to avoid the confusion in DT since
some peripherals with OPP support will have bw defined in DT, while rest of the
peripherals will have them in drivers.

- Mani

> -- 
> viresh

-- 
மணிவண்ணன் சதாசிவம்

