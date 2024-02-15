Return-Path: <linux-pci+bounces-3473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AE6855B71
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 08:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4571F21419
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 07:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B6FD272;
	Thu, 15 Feb 2024 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwFhE6aE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6D8CA4E;
	Thu, 15 Feb 2024 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707981209; cv=none; b=IjUQHoMFnEPaAzFf1IPLkPGORMSVU847twrWQdfi1rP57F5jAo9nsAPEPZbkX9Q4SfvCgdLEehR50j0DygCDyEWZAfDS0aswWquB78fdev888FsbvJzzv0kyra9WZ1gsCon6vOvcB1A2BVcLfxLt4FJ1w4koZE6Q/uPwhuUeb4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707981209; c=relaxed/simple;
	bh=YpnpnFaZh0LSwzis6eqahkcKumfgJU1f3vmHIa6cjMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1B2+UMAl3IWOUVUWSXTfzat25NeOiCYpDihsb4c/5kzVXG5vpGisNZ3kMOcRK3A5l0FSbQsqzK6siVoeMlpLr88oE/YZu7bZgyQzKgNR3WNW8lk0LGzcAd3EHogshka7NnWNEKdGzjpEwE0coJcaUvvtSowB8D8toIW2i3KwJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwFhE6aE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EA9C433F1;
	Thu, 15 Feb 2024 07:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707981208;
	bh=YpnpnFaZh0LSwzis6eqahkcKumfgJU1f3vmHIa6cjMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NwFhE6aE7PhTnpwNFcmUamw7gUPcRHAuwxC46DdUoc2P/1ZE5Q/hxLsRuHZTQfiH6
	 HDCjlj2bURFFfudvWwGJYrAVjsVu5+kKzUvErtMMHrjFkDZhKA/uiaiSEi1W7HXU55
	 JJRGaLtvYZb029eKQE2qdpHHv/4EXQ0rUYCXlsM2ZfW0jJMgFbhy4kwS9H48AKx0rC
	 kqD5HrQGJOCnkwH5w65HBVF9zTvJAKcDfWq2qOSYj/lPfr0t4cquXSg+9xWL3uk4Wk
	 ISJWKA3R++MICmze2hIlxdG29NZ16GBBC/8orXx/Rd5t9BK/9CzIrcSqabPr0IP3Iv
	 b0geU9h/VHQzA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1raVwK-0000000026e-3Oir;
	Thu, 15 Feb 2024 08:13:49 +0100
Date: Thu, 15 Feb 2024 08:13:48 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v2 3/3] PCI: qcom: properly implement RC shutdown/power up
Message-ID: <Zc25rIZbzWyw7hzq@hovoldconsulting.com>
References: <20240212213216.GA1145794@bhelgaas>
 <27560098-ced3-4672-bc60-6c1b7c0dc807@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27560098-ced3-4672-bc60-6c1b7c0dc807@linaro.org>

On Wed, Feb 14, 2024 at 10:33:19PM +0100, Konrad Dybcio wrote:
> On 12.02.2024 22:32, Bjorn Helgaas wrote:
> > "Properly" is a noise word that suggests "we're doing it right this
> > time" but doesn't hint at what actually makes this better.
> > 
> > On Sat, Feb 10, 2024 at 06:10:07PM +0100, Konrad Dybcio wrote:
> >> Currently, we've only been minimizing the power draw while keeping the
> >> RC up at all times. This is suboptimal, as it draws a whole lot of power
> >> and prevents the SoC from power collapsing.
> > 
> > Is "power collapse" a technical term specific to this device, or is
> > there some more common term that could be used?  I assume the fact
> > that the RC remains powered precludes some lower power state of the
> > entire SoC?
> 
> That's spot on, "power collapse" commonly refers to shutting down as many
> parts of the SoC as possible, in order to achieve miliwatt-order power draw.

I'm pretty sure "power collapse" is a Qualcomm:ism so better to use
common terminology as Bjorn suggested, and maybe put the Qualcomm
wording in parenthesis or similar.

Johan

