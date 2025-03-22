Return-Path: <linux-pci+bounces-24441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 600A2A6CB66
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 17:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F273B1896C8E
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 16:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5C022F392;
	Sat, 22 Mar 2025 16:11:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35BD54654;
	Sat, 22 Mar 2025 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742659890; cv=none; b=hP6nG8kmHv5CeXdRUeiBWUJB24CAbpEVNb4wGcKwUAc6sH0PJcEoA3Ftp0T6+PJ8ekKVXfaXc/Uaug+BCMaC/3E46WT+lVYHMaTNEQeIPuZSQRGc6Za4W8EuPJmejJKOF7Hk2eoqFiydto8l94IYm19RYjJPMhVvE+ogkidu3bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742659890; c=relaxed/simple;
	bh=27ESzGNGjnjy6IvMQoS+CTT81Jg09ji4mykE9+eGzz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mog5hEggIQNOD0QA4vgxHMuq1GbJYBt96eNbFNMOWs2Ls2IYia1T6vefxF/eS46wmFS8ECLcPUgcsoogdCzL8y4xI8OhnhXdJ4hgULzf478bQHHodjbPyV00+ek6gDlA7G27AdarDE9ZFrSWgSJgWF79wuYfDJKQocA3JCcCpkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 532A1280348F6;
	Sat, 22 Mar 2025 17:11:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3587C1C676C; Sat, 22 Mar 2025 17:11:24 +0100 (CET)
Date: Sat, 22 Mar 2025 17:11:24 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v5 1/4] PCI: Introduce generic capability search functions
Message-ID: <Z97hLJM4z8R39ZBk@wunner.de>
References: <20250321163803.391056-1-18255117159@163.com>
 <20250321163803.391056-2-18255117159@163.com>
 <Z92cgXEGwgYD2gau@wunner.de>
 <e6e808b6-302b-4f3e-ad2d-5f9c4dce7394@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6e808b6-302b-4f3e-ad2d-5f9c4dce7394@163.com>

On Sat, Mar 22, 2025 at 11:47:18PM +0800, Hans Zhang wrote:
> On 2025/3/22 01:06, Lukas Wunner wrote:
> > On Sat, Mar 22, 2025 at 12:38:00AM +0800, Hans Zhang wrote:
> > > Add pci_host_bridge_find_*capability() in drivers/pci/pci.c, accepting
> > > controller-specific read functions and device data as parameters.
> > 
> > Please put this in a .c file which is only compiled and linked if
> > one of the controller drivers using those new helpers is enabled
> > in .config.
> > 
> > If you put the helpers in drivers/pci/pci.c, they unnecessarily
> > enlarge the kernel's .text section even if it's known already
> > at compile time that they're never going to be used (e.g. on x86).
> > 
> > You could put them in drivers/pci/controller/pci-host-common.c
> > and then select PCI_HOST_COMMON for each driver using them.
> > Or put them in a separate completely new file.
> 
> I add a drivers/pci/controller/pci-host-helpers.c file, how do you like it?
> Below, I have rearranged the patch, please kindly review it, thank you very
> much.

Looks fine to me, but I'm not one of the maintainers for the controller
drivers, they may have a different opinion.  I'd recommending submitting
this and see if any of them doesn't like it.

Just one nit that caught my eye:

> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -132,6 +132,22 @@ config PCI_HOST_GENERIC
>  	  Say Y here if you want to support a simple generic PCI host
>  	  controller, such as the one emulated by kvmtool.
> 
> +config PCI_HOST_HELPERS
> + 	bool "PCI Host Controller Helper Functions"
> + 	help
> +	  This provides common infrastructure for PCI host controller drivers to
> +	  handle PCI capability scanning and other shared operations. The helper
> +	  functions eliminate code duplication across controller drivers.
> +
> +	  These functions are used by PCI controller drivers that need to scan
> +	  PCI capabilities using controller-specific access methods (e.g. when
> +	  the controller is behind a non-standard configuration space).
> +
> +	  If you are using any PCI host controller drivers that require these
> +	  helpers (such as DesignWare, Cadence, etc), this will be
> +	  automatically selected. Say N unless you are developing a custom PCI
> +	  host controller driver.

I like the comprehensive help text, but I'd recommend removing the
input prompt "PCI Host Controller Helper Functions" after the "bool".

I think generally only menu entries should be displayed that are relevant
for end users.  The prompt is only needed for developers and they can
easily modify Kconfig to select the item when they add their driver.

If you absolutely positively want to have a prompt, I'd recommend
hiding the menu entry unless CONFIG_EXPERT is also enabled, i.e.:

	bool
	prompt "PCI Host Controller Helper Functions" if EXPERT

Or maybe there's something better than CONFIG_EXPERT for cases like this,
dunno.

Thanks,

Lukas

