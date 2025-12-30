Return-Path: <linux-pci+bounces-43846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD92DCE9AA0
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 13:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC1AB302C4EE
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 12:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E74A2DC34B;
	Tue, 30 Dec 2025 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="co+yQlrY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB472D8379;
	Tue, 30 Dec 2025 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767098010; cv=none; b=snRhnV8J2nFmnCm5cPMgk8kDTbK5kL+95fX7bWJALwiwWi/lbmxZNuQVp+L+CM7rHS24BHsaIUJzZtAsOvl0Ul9lM7vLdLq9N5xvFQROJl6Cyt+jTS9EkUXuPmXE1LkHGRYzFAi//JeWxO3rSOuLRKWPMqoaEN8e2hdPaJCd21g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767098010; c=relaxed/simple;
	bh=sqV+4rjDf3gN1ReQZXnG664i3qo43+zgGpc9NOCJKTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqWG0H7mQLVTjBRI28FwZMNbSbTCHItb7gJqJI2Ta4YY6f9h45UhnBmvL/6Vc5YQ8LhUjIh+7me9gfsN5e/zo9AxdbuY93ILSOwgGEHJF3wFBKGwjF1CnRca6ncJ//8+IPf3NMztB9++M3rDxSayq4AQbH1xS6NiYak1R0leXS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=co+yQlrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4E4C113D0;
	Tue, 30 Dec 2025 12:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767098009;
	bh=sqV+4rjDf3gN1ReQZXnG664i3qo43+zgGpc9NOCJKTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=co+yQlrYMUa1YdQhnacrxY9IVGVdk8wnjepUguqb5oTmnii+liUPp2KfDSrsqi70c
	 10BMjRRMU25iTkGZ1zPHo79jZ1IoJ+PtZHDYBt1eJwG2AU9g7eHLjNp+5mlMwyO6cb
	 V6QuUJDdvOkiNclXMpGPy8ET4E1f3WdnO7zw+Pib4jzhEwkUPDMqn+fzRP6CC8XI3n
	 BdcsBihVNqSD4bCNCn4ofAYXIs5zEcaQZOi/gFWA9trDiQpfRLziX9wV1rNUSqTe16
	 Qco+Von97vFkJCjPCXOq16RVPK0oYUaYlEERAUEneE4D6WVvHk+WVvWSYrcRrBkFsK
	 zqNCIazKZU48w==
Date: Tue, 30 Dec 2025 18:03:21 +0530
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
Message-ID: <hgowokljpte5upekanfovxzfgrciviuoyhbnye6eeo7ifpywyr@krbusbak4wkf>
References: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com>
 <aVO3_32KT6HfOUAZ@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVO3_32KT6HfOUAZ@ryzen>

On Tue, Dec 30, 2025 at 12:31:11PM +0100, Niklas Cassel wrote:
> Hello Mani,
> 
> On Mon, Dec 29, 2025 at 10:56:51PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > **NOTE**: With this series, the controller driver may undergo multiple probe
> > deferral if the pwrctrl driver was not available during the controller driver
> > probe. This is pretty much required to avoid the resource allocation issue. I
> > plan to replace probe deferral with blocking wait in the coming days.
> 
> It sounds like you want to base that upcoming series on top of this series.
> 
> Considering that we are only at -rc3, would it perhaps be a good idea to
> wait for you to implement the blocking wait, so that it can be part of
> this series, to avoid the additional code churn?
> 

Blocking wait feture is not strictly required for this functionality. It is
something I wanted to implement to avoid multiple probe deferrals, but blocking
wait will also achieve the same by just waiting for all pwrctrl drivers to be
probed instead of returning -EPROBE_DEFER.

But I haven't figured out yet on how to do it though. That's why I sent this
series to allow it to be put into -next and have some test coverage.

If I happen to send the blocking wait patches this cycle itself (should be
atmost 2 patches), those patches could be squashed with this series itself. So
I don't see it as a big churn.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

