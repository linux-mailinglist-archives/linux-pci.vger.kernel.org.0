Return-Path: <linux-pci+bounces-31204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B356AF0563
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 23:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0273F16DE32
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 21:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D18826B766;
	Tue,  1 Jul 2025 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soks8+eG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08033D69;
	Tue,  1 Jul 2025 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751403700; cv=none; b=ds9CnF4EjBG2QJ6yRUbcT3OLlrlqqQmEayKkutcY8fckF7XnSmRM8OFM23ITPO9Et5MIq6WCu4W8wsZNQd7aiI1Hw+r+cpSBsRYenRAwi851/XrMuIVMTyXk/PizJ8Cb4LvS4XDdjHtlvPKIlWHRL+ocnPGNaacGLbH5owwVC/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751403700; c=relaxed/simple;
	bh=ZyYV5UNurBoHaNIOOOU+hpKbNEI30wMtrtMFSsxPC/c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oU6PbfLiKEnT6NFLWz2gYcLa5g6JoiSoG4pkSR3DkfJ1Ov1ZJd4qxucC/WXtJBrF4t0KFiszn+5avDP4tESAkWLduM1FRHtjLPhZ5XRaZ7GNNdbkgah75EY1ek8ivTCsmVp9QBVaj1RlWZGvu0rSPo3wj6oxVDPy0hG7QeLdQ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soks8+eG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7096C4CEEB;
	Tue,  1 Jul 2025 21:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751403699;
	bh=ZyYV5UNurBoHaNIOOOU+hpKbNEI30wMtrtMFSsxPC/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=soks8+eG7hN/v41F5Cs5ldAvm0LQ9FeWh8g7BszMN/HamSmKNYIk2fRjQQn2AjMgI
	 MaDUOg0aQK+f3jW8eii1ciVaTCYMf/QpcwSfx+BkhfX1DT9N15A8wPjosLVZtWshLt
	 yMdfTAuuWZsRD9gXbFS/z9HuiKEeT0IMsj2E8Nq/Xx8F1VGNQZunG6t7iuaEjW7mxN
	 uVAhSngiKCuysSbFzITc55/XAXUPnlcOzSeRtrNxQLvZbBk8BFS0JQG1ZOf517JNaj
	 DYY0B1nhXjTH/Mxt9t6R6vzDmrxdtyioJ7sy+pNURzuftOI+e4W2Udn8+4AwDG3Kzu
	 yuNsFz/ANuadw==
Date: Tue, 1 Jul 2025 16:01:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2] PCI/pwrctrl: Skip creating pwrctrl device unless
 CONFIG_PCI_PWRCTRL is enabled
Message-ID: <20250701210138.GA1849044@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701064731.52901-1-manivannan.sadhasivam@linaro.org>

[+cc Bart, Krzysztof, update Mani's addr to kernel.org]

On Tue, Jul 01, 2025 at 12:17:31PM +0530, Manivannan Sadhasivam wrote:
> If devicetree describes power supplies related to a PCI device, we
> previously created a pwrctrl device even if CONFIG_PCI_PWRCTL was
> not enabled.
> 
> When pci_pwrctrl_create_device() creates and returns a pwrctrl device,
> pci_scan_device() doesn't enumerate the PCI device. It assumes the pwrctrl
> core will rescan the bus after turning on the power. However, if
> CONFIG_PCI_PWRCTL is not enabled, the rescan never happens.
> 
> This may break PCI enumeration on any system that describes power supplies
> in devicetree but does not use pwrctrl. Jim reported that some brcmstb
> platforms break this way.
> 
> While the actual fix would be to convert all the platforms to use pwrctrl
> framework, we also need to skip creating the pwrctrl device if
> CONFIG_PCI_PWRCTL is not enabled and let the PCI core scan the device
> normally (assuming it is already powered on or by the controller driver).

I'm fine with this change, but I think the commit log leaves the wrong
impression.  If CONFIG_PCI_PWRCTRL is not enabled, we shouldn't do
anything related to it, independent of what other platforms or drivers
do.

So I wouldn't describe this as "the actual fix is converting all
platforms to use pwrctrl."  Even if all platforms use pwrctrl, we
*still* shouldn't run pci_pwrctrl_create_device() unless
CONFIG_PCI_PWRCTRL is enabled.

I think all we need to say is something like this:

  We only need pci_pwrctrl_create_device() when CONFIG_PCI_PWRCTRL is
  enabled.  Compile it out when CONFIG_PCI_PWRCTRL is not enabled.

> Cc: stable@vger.kernel.org # 6.15
> Fixes: 957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")

Not sure about this.  If the problem we're solving is "we run pwrctrl
code when CONFIG_PCI_PWRCTRL is not enabled," 957f40d039a9 is not the
commit that added that behavior.

Maybe 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF
nodes of the port node") would be more appropriate?

> Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
> Closes: https://lore.kernel.org/r/CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com

I'm also not sure this really merits a "Closes:" tag.  All this does
is enable a workaround (disable CONFIG_PCI_PWRCTRL when brcmstb is
enabled).  That's not a fix because we *should* be able to enable both
pwrctrl and brcmstb at the same time.

If 2489eeb777af ("PCI/pwrctrl: Skip scanning for the device further if
pwrctrl device is created") was purely an optimization (see
https://lore.kernel.org/r/20250701203526.GA1849466@bhelgaas), I think
I would:

  - Revert 2489eeb777af with a stable tag for v6.15, and

  - Apply this patch with a Fixes: 8fb18619d910 ("PCI/pwrctl: Create
    platform devices for child OF nodes of the port node") but no
    stable tag.  8fb18619d910 appeared in v6.11 and the "don't enable
    CONFIG_PCI_PWRCTRL" workaround was enough for brcmstb until
    2489eeb777af, so if we revert 2489eeb777af, we wouldn't need to
    backport *this* patch.

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Changes in v2:
> 
> * Used the stub instead of returning NULL inside the function
> 
>  drivers/pci/probe.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4b8693ec9e4c..e6a34db77826 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2508,6 +2508,7 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  }
>  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
>  
> +#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
>  static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
>  {
>  	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> @@ -2537,6 +2538,12 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
>  
>  	return pdev;
>  }
> +#else
> +static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
> +{
> +	return NULL;
> +}
> +#endif
>  
>  /*
>   * Read the config data for a PCI device, sanity-check it,
> -- 
> 2.43.0
> {

