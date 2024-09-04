Return-Path: <linux-pci+bounces-12726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AAF96B65D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 11:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732E828924A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 09:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7ED197A7B;
	Wed,  4 Sep 2024 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZvMmWZT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3257A155C96;
	Wed,  4 Sep 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441662; cv=none; b=Di+PeZV9geO+TQM0qIrNvZ+1JTk6tYIdseIOD3+T1E04FaX1j7n/8qKSl0LNwrym1i16JtxzoAQVNjlsINOPPNG1+WXUU11p8ArtHke0q0ycsJWwh4Z/Q1nNCDj4Vgr79+DLyOdf+Q+w+QFFt6zjI+VA8nHZQo7Ow5dcqt3Y1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441662; c=relaxed/simple;
	bh=D9nne4Oe1Iwf2TF66qCK6hwEQPc1r+DNeysXLALsbcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmggatvsqAWKVcJYZR1BMIl9oECscmlx7Mavlmjmu8VxoQqG4dpagKR5bzkJDK/99PM9WbfpN9XIXxph5UrJZtGaUQG7yVpVBhlVdFZRUlpXLkICSOPTd8tqWp+JvGygNikPj4ltWgRz+/tjYLTeoXkeeYNN6MXEtxic6FGKCgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZvMmWZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9509EC4CEC2;
	Wed,  4 Sep 2024 09:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725441661;
	bh=D9nne4Oe1Iwf2TF66qCK6hwEQPc1r+DNeysXLALsbcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZvMmWZTb7fUvgrSCtMiRHkDCm05V6XbyXPz4au0uc+/IITApcUwEj8QjKz+RcccP
	 vpnux0SLunyt7ESN53X3X6q6XUCbZufrsjT2cKnYAGjgkEeaGf+SdK4C0OLKNW9hUs
	 xdBYsL3RDAW8M0cjzOvf8UAqT5njNwZRxYJYJIiH/FHtyzQHJKC5MwIqrx3VCDBpvM
	 2IRT8VaT8DQCfJblqzdsF8PBv43BaUFrPzs9ADAdxZ7IKb8mcLmu5zcyof5OS5r8b9
	 40WX1evHBgMssqUnM3Rd62YWyJsYfwXCqaTXS81bonKSIsx9pg6NGK7VgVj/AB4JQg
	 q5577JcpIQD6g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1slmCU-000000000wl-0bOz;
	Wed, 04 Sep 2024 11:21:18 +0200
Date: Wed, 4 Sep 2024 11:21:18 +0200
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
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	abel.vesa@linaro.org, johan+linaro@kernel.org,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Subject: Re: [PATCH v6 1/4] PCI: dwc: Rename 'dw_pcie::link_gen' to
 'dw_pcie::max_link_speed'
Message-ID: <ZtgmjnNkcAkE_Y15@hovoldconsulting.com>
References: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
 <20240904-pci-qcom-gen4-stability-v6-1-ec39f7ae3f62@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-pci-qcom-gen4-stability-v6-1-ec39f7ae3f62@linaro.org>

On Wed, Sep 04, 2024 at 12:41:57PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> 'link_gen' field is now holding the maximum supported link speed set either
> by the controller driver or by DT through 'max-link-speed' property.
> 
> But the name 'link_gen' sounds like the negotiated link speed of the PCIe
> link. So let's rename it to 'max_link_speed' to make it clear that it holds
> the maximum supported link speed of the controller.
> 
> NOTE: For the sake of clarity, I've used 'max_link_speed' instead of
> 'max_link_gen'. Also the link speed and link generation values map 1:1.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

