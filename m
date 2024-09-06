Return-Path: <linux-pci+bounces-12881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3DF96EAF1
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 08:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB9E28580A
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 06:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92A58175F;
	Fri,  6 Sep 2024 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOIczusQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8346F3EA71;
	Fri,  6 Sep 2024 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605325; cv=none; b=syZh5iWg916vIkdKs9NGX6Sg/m3nuIlPTU+rVE5DC5cqh5Khb3TfXUVBQehGIn/fgkfuP7Af/N60sHoRlOAgpA7G6iPPKlczVbNX7yTtBYdx74vsAWM5ixvBXvEUoOsjLyFwRzOFwdkWHWnhg1xrdOrfIwL+uB4nrEGGmMvXjGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605325; c=relaxed/simple;
	bh=nGb8XxbR7FTLc/dIcFXasGyv/0FcYxflx3mwiODWW0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWVy31iUps0rLH4PDLLYpNKtm7jpP6D0XZ/iFTG67s9ZW9a0wGLRHPkcivrSeVXtpOMLv/nbhrQWIDp7r4AeePuIoPZ9DsY4kgN2gcj4jAcbJfUF6DjehKevjysOF47xmIbJ1C/ztg88Bmqm7PbAq631UZ7xbc4anSoAHgOuKj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOIczusQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D76C4CEC4;
	Fri,  6 Sep 2024 06:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725605325;
	bh=nGb8XxbR7FTLc/dIcFXasGyv/0FcYxflx3mwiODWW0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOIczusQjztFmfGBOGL8PH/zIGGSMEuyk0eGnLJwDxbhKs3NtjKDUtyi7s9Dbw+GI
	 Mb5BTIF50Nu8L7y6Lfzsd1RoqTP5zG5jS6J1I3Q/zyXZ3SrIIOsFt+HbBhvYFyARVB
	 u518shT9HZk1jzZq0270PBjkrb2jnN/rikfE3sQEyf2l0girKC1NnyZN47AZauzdzG
	 IRo2YzVITl1tCYYwMnOYPnepCcBo3sia1aVd6u4vwF24Ipcnus5ZR69FL6zBOSUDjg
	 G0Pcv2+6Swf32EIlEldguVu3F5gtO2VrPfrs/rRZRn4giUfIA2IyY4Yc+p+4VB0gQk
	 vHpQC9Tysfhow==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1smSmF-000000004Ee-3z23;
	Fri, 06 Sep 2024 08:49:04 +0200
Date: Fri, 6 Sep 2024 08:49:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Subject: Re: [PATCH v6 3/4] PCI: qcom: Add equalization settings for 16.0 GT/s
Message-ID: <Ztql31KXrBQ1I5JV@hovoldconsulting.com>
References: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
 <20240904-pci-qcom-gen4-stability-v6-3-ec39f7ae3f62@linaro.org>
 <ZtgqvXGgp2sWNg5O@hovoldconsulting.com>
 <20240905152742.4llkcjvvu3klmo6j@thinkpad>
 <Ztnb-GauC_8D8N-i@hovoldconsulting.com>
 <20240905173437.hm3hegv5zolaj7gj@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905173437.hm3hegv5zolaj7gj@thinkpad>

On Thu, Sep 05, 2024 at 11:04:37PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Sep 05, 2024 at 06:27:36PM +0200, Johan Hovold wrote:
> > On Thu, Sep 05, 2024 at 08:57:42PM +0530, Manivannan Sadhasivam wrote:
 
> > > Perhaps we can just get rid of the Kconfig entry and build it by default for
> > > both RC and EP drivers? I don't see a value in building it as a separate module.
> > > And we may also move more common code in the future.
> > 
> > It is already built by default for both drivers. I'm not sure what
> > you're suggesting here.
> 
> Right now it is selected by both drivers using a Kconfig symbol. But I'm
> thinking of building it by default as below:
> 
> -obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
> -obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
> +obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o pcie-qcom-common.o
> +obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o pcie-qcom-common.o
> 
> A separate Kconfig symbol is not really needed here as this file contains common
> code required by both the drivers.

But the separate Kconfig symbol will only be enabled via either PCI
driver's option (e.g. can't be enabled on its own).

I'm also not sure if the above works if you build one driver as a module
and the other into the kernel (yes, I still intend to resubmit my patch
for making the rc driver modular).

Johan

