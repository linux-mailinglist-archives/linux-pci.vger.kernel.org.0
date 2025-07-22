Return-Path: <linux-pci+bounces-32754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A6FB0E3C9
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 20:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBAB1C83236
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 18:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBC828312E;
	Tue, 22 Jul 2025 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+/RGqdJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009DE21516E;
	Tue, 22 Jul 2025 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210692; cv=none; b=ZyytAq0R4v9jtSSbDRWTx2q5TU3v2Ga3FdpAQVxQBxp6MmDL2QuVBiQV7nnulQyBdf27zCn0Sj3dQwAeqNzdNMUAXk1dOfXjjW+CyuAhSBWwABbAQGLa/HWv0K/hDBKFe3ugmSA6oladKwidbwPe0XsPpT4lDEOKqquMX/T2IRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210692; c=relaxed/simple;
	bh=mYy8+bAcduzUOQqy0NojcmuWHY58NTGQZ5+Yl6TNfMw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QPPKmXit+Yv76zxrwhMniR6o1ptErAUWLXtthegtzwYhqZ7EpPuSJIIVncqCEFClwIeSK3bpyUPpFVejGObnYyQApJayJgQfdbdu7L9feIXy9WRajyC9ZleJBwbdG8cdMv6Ximwn7w9Zf/UVhDp60soMKA5HJMzqOh/BSn0ltMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+/RGqdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B79C4CEEB;
	Tue, 22 Jul 2025 18:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753210691;
	bh=mYy8+bAcduzUOQqy0NojcmuWHY58NTGQZ5+Yl6TNfMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=O+/RGqdJ1B1miWRHGPVPSE5EjaYyWNXEO9+7LNgOplnpCSFY58eEgpvfHD9yTEaiP
	 AwU32Odilzp3F3l0Qyh9LPb1bRLmvExcknnONcMlz6F0S955kbuyVCchbuTiFG6lXY
	 0o1Eri7x5UDHJIV/pkGyKFxS7uoKDdpBv9MqpXSCDSxmr0sacMHW8y4OokSrLtJlZL
	 CHus3GRgndFYvmoKNE0OKu5POt5sce1QHGXBfg046FXeByok3vEkPt82WT80pV9Trs
	 iT7dsi9xQVTU0wFyENZ8S6dQT5LKG+GuzPCpfT0gPV8r8nJ4Ag7nte6JzOofEmdY7o
	 vKyaFmtuLHh8w==
Date: Tue, 22 Jul 2025 13:58:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH v2] PCI/pwrctrl: Skip creating pwrctrl device unless
 CONFIG_PCI_PWRCTRL is enabled
Message-ID: <20250722185810.GA2809731@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701064731.52901-1-manivannan.sadhasivam@linaro.org>

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
> 
> Cc: stable@vger.kernel.org # 6.15
> Fixes: 957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
> Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
> Closes: https://lore.kernel.org/r/CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I (finally) applied this to for-linus for v6.16 with the following
commit log:

    PCI/pwrctrl: Create pwrctrl devices only when CONFIG_PCI_PWRCTRL is enabled
    
    If devicetree describes power supplies related to a PCI device, we
    unnecessarily created a pwrctrl device even if CONFIG_PCI_PWRCTL was not
    enabled.
    
    We only need pci_pwrctrl_create_device() when CONFIG_PCI_PWRCTRL is
    enabled.  Compile it out when CONFIG_PCI_PWRCTRL is not enabled.
    
    When pci_pwrctrl_create_device() creates and returns a pwrctrl device,
    pci_scan_device() doesn't enumerate the PCI device. It assumes the pwrctrl
    core will rescan the bus after turning on the power. However, if
    CONFIG_PCI_PWRCTRL is not enabled, the rescan never happens, which breaks
    PCI enumeration on any system that describes power supplies in devicetree
    but does not use pwrctrl.
    
    Jim reported that some brcmstb platforms break this way.  The brcmstb
    driver is still broken if CONFIG_PCI_PWRCTRL is enabled, but this commit at
    least allows brcmstb to work when it's NOT enabled.
    
    Fixes: 957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
    Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
    Link: https://lore.kernel.org/r/CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com
    Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
    [bhelgaas: commit log]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Lukas Wunner <lukas@wunner.de>
    Cc: stable@vger.kernel.org  # v6.15
    Link: https://patch.msgid.link/20250701064731.52901-1-manivannan.sadhasivam@linaro.org

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
> 

