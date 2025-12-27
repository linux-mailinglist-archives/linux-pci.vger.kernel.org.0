Return-Path: <linux-pci+bounces-43755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 020D8CDF451
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 05:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A29933000B6D
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 04:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0BB1E3DE8;
	Sat, 27 Dec 2025 04:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMEMFKjy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F388A45C0B;
	Sat, 27 Dec 2025 04:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766810665; cv=none; b=eBkOTir4bD+Iy5vfaLxjerNQ2PZWUsOvAH1bbU9IvyPNuWO13qRvbrPAWCWTr27/D6mbSUS/pxzs9FDBMyXL+SSvJShlzAQlavaGE2gK576uJpLU5RkdHxOmZkC3dqhMLaI5L1ij3aF9RbzzgOu6uxHAZD+roUELZugpQD7LYvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766810665; c=relaxed/simple;
	bh=vCBpUxe+HteI/vq950VbB2IayktbeNPBlcxl7XWa9mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+BXYUT332CWX+ephz/IT8Oe/pu+OqLY7QLXEczoH7WgIKyWoeoLHLvyHUD6Bjn0QkQQ4fE6aYT/3Qt3lcApnlpDACtLHGlicdMcsKLdV7yHQQnkGS/Zd0dEmPraH6HsPweV4fWH7eGK6TTufH8Q+D3o9y9LKAq9J2HZloqea3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMEMFKjy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8CDC4CEF1;
	Sat, 27 Dec 2025 04:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766810664;
	bh=vCBpUxe+HteI/vq950VbB2IayktbeNPBlcxl7XWa9mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMEMFKjy+jYbu5mqEhanvaVhJSCRM3z2deGV5CeUT2LhKUKS0lA+IR+1JopONVC2m
	 o2DYpITKXRT7+s33h42D5p/IQ/gE29HlLwoc+MfF7R8c10U1O7Qjy2B1OKV6DCZgvu
	 jKraVUNbbGsdbysjwli1ofWfxevSt45nOw+/lyXV9MPoLVKAOFeTCrXXZxPJyaeRWE
	 Lqla8yu4zFLioAeuHsop2arBRkKL7PmtTaK/QjstXzOr/xFcl/jcQvXt/tx3L8WgfF
	 0NaxoIhmokSYiS6DO4mS8nSxx5APJUXob4+7AYFqiuCz+rk46q8YciLomqRXhd+tcf
	 8B/d2c9s0zDdA==
Date: Sat, 27 Dec 2025 10:14:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sean Anderson <sean.anderson@seco.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 5/5] PCI/pwrctrl: Switch to the new pwrctrl APIs
Message-ID: <myrl5u2zhcoofzub6xy7wmw37h66ut4uxeiirvnbvxrikud6r2@zxgzzd454ciq>
References: <tutxwjciedqoje5wxvtin4h637auni5zzpvb7rtfg4uticxoux@yfl6xg7oht7t>
 <20251226230711.GA4146413@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251226230711.GA4146413@bhelgaas>

On Fri, Dec 26, 2025 at 05:07:11PM -0600, Bjorn Helgaas wrote:
> On Tue, Dec 23, 2025 at 07:41:30PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Dec 19, 2025 at 01:35:39PM -0500, Sean Anderson wrote:
> > > On 12/16/25 07:51, Manivannan Sadhasivam wrote:
> > > > Adopt the recently introduced pwrctrl APIs to create, power on, destroy,
> > > > and power off pwrctrl devices. In qcom_pcie_host_init(), call
> > > > pci_pwrctrl_create_devices() to create devices, then
> > > > pci_pwrctrl_power_on_devices() to power them on, both after controller
> > > > resource initialization. Once successful, deassert PERST# for all devices.
> 
> > ...
> > > And now you will continually probe the controller until all of the
> > > drivers are loaded.
> > > 
> > > There is a non-obvious property of the deferred probe infrastructure
> > > which is:
> > > 
> > >         Once a device creates children, it must never fail with
> > >         EPROBE_DEFER.
> > > 
> > > So if you want to have something like this, the pwrctrl devices need to
> > > be created before the controller is probed. Or you can use the current
> > > system where the pwrctrl devices are probed asynchronously.
> > 
> > You are right and it is an oversight from me. If the pwrctrl driver
> > is not found, the pwrctrl devices should not be destroyed in the
> > error path, but the controller driver can still return
> > -EPROBE_DEFER. This will allow the controller driver to get reprobed
> > later and by that time, pwrctrl device creation will be skipped. I
> > believe this satisfies the comment you quoted above.
> > 
> > I found this issue while testing the series with one of our Qcom
> > switches and I fixed it in yet to be submitted v3.
> 
> I guess I should wait for v3 before putting this in linux-next?

Yes, please. I'll send v4 today or tomorrow.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

