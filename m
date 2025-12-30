Return-Path: <linux-pci+bounces-43838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8363CE97AF
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 11:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22CC53029D10
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 10:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADDE2D7DF5;
	Tue, 30 Dec 2025 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaIKTdmW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73C28466C;
	Tue, 30 Dec 2025 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767091968; cv=none; b=bBBiFZ+2n1N1hsTml2R3RvM1zGu7b5GlxqADlfYlpzez/vZdcBCNFB1bMvxzhHUdwFUt7H4BWPdCRTt8Ii6oMM3NrTqJREeQMIAIMg+Jsv3n5m+PyhAvwIIvK38tKzcxcTwdkM+lyz8uGguEozhCXEcDVEQAFMBwSI7b4/WabAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767091968; c=relaxed/simple;
	bh=eDtEoC77c2rp+hClH2NgHufaS4PxIYjOQpTMAZ/ULOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EV+k24AQXoNJteIpor9z3EsfBQT0z6wJhBoPA3b6PRWPHiVTgGaJhpr3LZJ+m37wEG+sasLtmLiDDCyWBLCEgiqyEzG7aeeTtTwNm54OKtjGxeUv81AkGN4Ix5eYyW+bhdAKzkbdQWx2coSxf4x51Y1Mgs83/VhEKFfTGUy/Ts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaIKTdmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201A4C4CEFB;
	Tue, 30 Dec 2025 10:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767091967;
	bh=eDtEoC77c2rp+hClH2NgHufaS4PxIYjOQpTMAZ/ULOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qaIKTdmWzGryt4/jp0RnRyo8aS8Mf7v41bzi6Qi+GUJ5miJcloxMRGRiub1ZlkAGB
	 t05I4iauBeZXOhF5xWf1iY/91dz49p43ZvJ2e7A5pZDt/tM4WYXF4hoyWNqwDPac/Z
	 YcApx0qnrAcZgjgahxvMlon2755X5XgKoIQmFHDdJuD9NxisMic1NuIbd6CHjrptuh
	 vG3D7jDH11UalF4ZLhBI0wbwSxXu7ctfjkDbhilcddojXURy1xIUgVuRWMfolLQcvb
	 Gj9bP3HDBj2VynXouOCukPcdU2gP3CixjAdHGoqBlfdJWuK45Ur7MR2hz5qLT7I+rC
	 pc3ypYZXBL+MQ==
Date: Tue, 30 Dec 2025 16:22:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Alex Elder <elder@riscstar.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v3 0/7] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
Message-ID: <5jsdwblb4h2jw2t2jzcivpszkuxwxiph4x3devu6mqlzrzmzyw@fsm4scedwk56>
References: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com>
 <aVOrC85Y6mCYU8xL@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVOrC85Y6mCYU8xL@ryzen>

On Tue, Dec 30, 2025 at 11:35:55AM +0100, Niklas Cassel wrote:
> On Mon, Dec 29, 2025 at 10:56:51PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > Hi,
> > 
> > This series provides a major rework for the PCI power control (pwrctrl)
> > framework to enable the pwrctrl devices to be controlled by the PCI controller
> > drivers.
> > 
> > Problem Statement
> > =================
> > 
> > Currently, the pwrctrl framework faces two major issues:
> > 
> > 1. Missing PERST# integration
> 
> AFAICT, and from reading your reply here:
> 
> https://lore.kernel.org/linux-pci/ibvk4it7th4bi6djoxshjqjh7zusbulzpndac5jtqkqovvgcei@5sycben7pqkk/
> 
>   I suppose maybe you plan to enhance pwrctrl so it can assert/deassert
>   individual PERST# in the hierarchy?
> 
> "No, that plan has been dropped for good. For now, PERST# will be handled
> entirely by the controller drivers. Sharing the PERST# handling with pwrctrl
> proved to be a pain and it looks more clean (after the API introduction) to
> handle PERST# in controller drivers."
> 
> Thus, it seems that even after this series, pwrctrl will be missing PERST#
> integration. Perhaps the cover letter could be rephrased to more clearly
> highlight this.
> 
> Because it seems a bit weird that the first point of the problem statement
> (missing PERST# integration) will still be the case after this series.
> 

Maybe the wording has confused you. I intend to say that the previous
implementation doesn't integrate PERST# properly because controller drivers
deasserted PERST# even before the pwrctrl driver has turned on the power and
both of them worked asynchronously. But with this series they become synchronous
as the controller drivers have the control over the pwrctrl and PERST# and they
can assert/deassert PERST# following the spec timing requirements.

So even though PERST# is not part of the pwrctrl, the integration is now in
place. But I agree that the wording could be improved. I will rephrase it if I
happen to send next version.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

