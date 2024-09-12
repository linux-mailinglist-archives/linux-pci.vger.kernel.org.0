Return-Path: <linux-pci+bounces-13067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B91897610B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 08:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD23B22242
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 06:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711D2188CA7;
	Thu, 12 Sep 2024 06:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX7FFODG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C75028C;
	Thu, 12 Sep 2024 06:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726121398; cv=none; b=gTLp7WVFkGz4QcVM91xBdyKdTtK63JUAgeIJDJwQz0NNVn0F4jXk4ZHwZMHRJKHLWvQZ0mpMSmkrESd3o3VNRjbx/B/TtupXjT9o5HM4XeTrG+xo44Ajwisnw4hKFBmv5x0fjaww6gei2XXqcBD4vJGLeiP7arE+KxGKgC35Ay4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726121398; c=relaxed/simple;
	bh=KUoUy9GLonbn9CIbH0VYwTW45LtmjuX2qj1A8pKAocE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIxH3nUNjgAG4NfEv93tSnHUKJlQeU7ga7HnkLRdnH33yUAGkLEkEflEZEQX/wPGFSS+xSFGJdmNA2e+cDcJCcBpVoqvTH2YJkAbQuqXcA//K2fpD5oxmi76gK6LNScrXXqmU4Egyaqldkf5N7F5jB9NdEPcw8D9QlZkmjGJ2kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX7FFODG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC27C4CEC3;
	Thu, 12 Sep 2024 06:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726121397;
	bh=KUoUy9GLonbn9CIbH0VYwTW45LtmjuX2qj1A8pKAocE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iX7FFODGSJQjBhMM/jVXyg0aep2aCLBGSsZjz5T7IRoLAlv2w6Z+JTWztoh0b1ahl
	 TvLl0siXHB5NtdrF4nz6WWkC/YIUvcG8mBEZOpYWNz/iPGKLH1WeCANkefM9wfbDU+
	 7vwF5lJkNC4fOt21wnjWnuiyRDq5DOmOsFoZAeZr9F1SAkx9gIMjJhVKlvernYr+Vb
	 L+e33w3SWxVu6V8cz1FKFhJ7c3e0oa841aAcPyH9NLcSWTz6p7rULAClkIo03Vtpl0
	 HUvZq1l1psznqgMKGG9hM22aQTB8SROW31Twt2bw68j/MxFCgytjRav70iPrVPCOde
	 sSirpCbApLdXQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sod20-000000004iC-1UBO;
	Thu, 12 Sep 2024 08:10:16 +0200
Date: Thu, 12 Sep 2024 08:10:16 +0200
From: Johan Hovold <johan@kernel.org>
To: manivannan.sadhasivam@linaro.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, abel.vesa@linaro.org,
	johan+linaro@kernel.org,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 4/4] PCI: qcom: Add RX lane margining settings for
 16.0 GT/s
Message-ID: <ZuKFyPBDZtocpkRr@hovoldconsulting.com>
References: <20240911-pci-qcom-gen4-stability-v7-0-743f5c1fd027@linaro.org>
 <20240911-pci-qcom-gen4-stability-v7-4-743f5c1fd027@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-pci-qcom-gen4-stability-v7-4-743f5c1fd027@linaro.org>

On Wed, Sep 11, 2024 at 08:56:29PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> 
> Add RX lane margining settings for 16.0 GT/s (GEN 4) data rate. These
> settings improve link stability while operating at high date rates and
> helps to improve signal quality.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> [mani: dropped the code refactoring and minor changes]
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

