Return-Path: <linux-pci+bounces-32756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C12B0E3F8
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 21:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A85B5483B7
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 19:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906AD285040;
	Tue, 22 Jul 2025 19:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5y6dRVb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676A3284B3B;
	Tue, 22 Jul 2025 19:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211708; cv=none; b=QWRssQm6ghbNmlwNZqKnzDonh9GWHmvTBWNmRZnb5bWNd4X1OlPVZeXu1e0UThQmAoNztsU62WOgpAqY5h4lbJvgXu5tyctvUCoflnX9g/qFCkf9cLiN2snckDrHymb03nSEFx8Xnpx6GSnZzYCo4xiz1ZsTN2H0rymXd6OO88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211708; c=relaxed/simple;
	bh=hYl7SIkdl/URxlHfT+Z6G/6IY/jmbMbxnem0O0iNRPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fW66MT6qgrRmc0t/wUMW8Ko5WlxcSdEwWfGIla6D+/F0l5pp6xrOUdLxba5E2J7G7b/XWW2kyInVMFGIwIY6nmEsj3cKJwSiuDeT7tPdwH5tKV7GcTfnkXGsNsXNDM7zN8vjm2ZO22rbfpQnZ3vX3lIA6N96jaqKNPrhjAoSou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5y6dRVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC582C4CEEB;
	Tue, 22 Jul 2025 19:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753211707;
	bh=hYl7SIkdl/URxlHfT+Z6G/6IY/jmbMbxnem0O0iNRPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=b5y6dRVb8lebfblIJneCLKujCxqzhhtuQCuQtP7wJmCI2x3Cdj2zOaBiewzL25kHs
	 0sR3tWHh0iH2zMIW5NUYXD4bc+GIIlICDGxcGfuOPW8MOQH76m9s6YCpOVJ/xqU3yz
	 60CR72x8VBQTn0LBizpRHM9QiqDIAsRTIED2P3b/aDduVHqIv5d6YHdAXRTAvyvRrB
	 52Px7l0ut0ssZOfn9fHpP/lKyikAn54DEPDiklv7B75FasHLz/oiDhEA982n+Gw7AJ
	 2+85ee0d6YMNKuHShBQJqp958gTHE1uczZGn0usPnmv0K2a7QMFnBg8gQqnXwCSuH8
	 OII9E8yaOKD6w==
Date: Tue, 22 Jul 2025 14:15:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH v2] PCI/pwrctrl: Skip creating pwrctrl device unless
 CONFIG_PCI_PWRCTRL is enabled
Message-ID: <20250722191506.GA2810550@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722185810.GA2809731@bhelgaas>

[use Mani's new email addr]

On Tue, Jul 22, 2025 at 01:58:11PM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 01, 2025 at 12:17:31PM +0530, Manivannan Sadhasivam wrote:
> > If devicetree describes power supplies related to a PCI device, we
> > previously created a pwrctrl device even if CONFIG_PCI_PWRCTL was
> > not enabled.
> > 
> > When pci_pwrctrl_create_device() creates and returns a pwrctrl device,
> > pci_scan_device() doesn't enumerate the PCI device. It assumes the pwrctrl
> > core will rescan the bus after turning on the power. However, if
> > CONFIG_PCI_PWRCTL is not enabled, the rescan never happens.
> > 
> > This may break PCI enumeration on any system that describes power supplies
> > in devicetree but does not use pwrctrl. Jim reported that some brcmstb
> > platforms break this way.
> > 
> > While the actual fix would be to convert all the platforms to use pwrctrl
> > framework, we also need to skip creating the pwrctrl device if
> > CONFIG_PCI_PWRCTL is not enabled and let the PCI core scan the device
> > normally (assuming it is already powered on or by the controller driver).
> > 
> > Cc: stable@vger.kernel.org # 6.15
> > Fixes: 957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
> > Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
> > Closes: https://lore.kernel.org/r/CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> I (finally) applied this to for-linus for v6.16 with the following
> commit log:
> 
>     PCI/pwrctrl: Create pwrctrl devices only when CONFIG_PCI_PWRCTRL is enabled
>     
>     If devicetree describes power supplies related to a PCI device, we
>     unnecessarily created a pwrctrl device even if CONFIG_PCI_PWRCTL was not
>     enabled.
>     
>     We only need pci_pwrctrl_create_device() when CONFIG_PCI_PWRCTRL is
>     enabled.  Compile it out when CONFIG_PCI_PWRCTRL is not enabled.
>     
>     When pci_pwrctrl_create_device() creates and returns a pwrctrl device,
>     pci_scan_device() doesn't enumerate the PCI device. It assumes the pwrctrl
>     core will rescan the bus after turning on the power. However, if
>     CONFIG_PCI_PWRCTRL is not enabled, the rescan never happens, which breaks
>     PCI enumeration on any system that describes power supplies in devicetree
>     but does not use pwrctrl.
>     
>     Jim reported that some brcmstb platforms break this way.  The brcmstb
>     driver is still broken if CONFIG_PCI_PWRCTRL is enabled, but this commit at
>     least allows brcmstb to work when it's NOT enabled.
>     
>     Fixes: 957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
>     Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
>     Link: https://lore.kernel.org/r/CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com
>     Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>     [bhelgaas: commit log]
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Lukas Wunner <lukas@wunner.de>
>     Cc: stable@vger.kernel.org  # v6.15
>     Link: https://patch.msgid.link/20250701064731.52901-1-manivannan.sadhasivam@linaro.org
> 
> > ---
> > 
> > Changes in v2:
> > 
> > * Used the stub instead of returning NULL inside the function
> > 
> >  drivers/pci/probe.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 4b8693ec9e4c..e6a34db77826 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2508,6 +2508,7 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> >  }
> >  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
> >  
> > +#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
> >  static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
> >  {
> >  	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> > @@ -2537,6 +2538,12 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
> >  
> >  	return pdev;
> >  }
> > +#else
> > +static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
> > +{
> > +	return NULL;
> > +}
> > +#endif
> >  
> >  /*
> >   * Read the config data for a PCI device, sanity-check it,
> > -- 
> > 2.43.0
> > 

