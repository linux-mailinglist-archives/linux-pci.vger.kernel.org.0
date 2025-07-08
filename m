Return-Path: <linux-pci+bounces-31731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BFAAFDB95
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 01:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26E71C26FCF
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 23:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805FF22C35D;
	Tue,  8 Jul 2025 23:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3TtU7Wk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA3A33993
	for <linux-pci@vger.kernel.org>; Tue,  8 Jul 2025 23:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016285; cv=none; b=Ly6sUZxysc1pFhk4qXA0V5qHKseCXHSncqBPLlldLjLX/PqFhU3ErayN9km8SIuya+t58H2AqTHisIzTcp+HzEAm7vM8VkcVcVPVNQ9e5UwmfN89jEHwyMpjz4Xlp5AU6Awmq1Ou9IQmioIjsPRp/Z2/988cUzIQbXmPKoeeN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016285; c=relaxed/simple;
	bh=t244hZBGOCmukFAtqkOz3yRi9QKL2o27KYwvOYiYMbs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IC/s4Lpwf+2Rx3MEfDv0iTCAe2ASkLVK+2amxEUPapjVWbLuj/imr/fnoNWaskZWyyG13O+c0fqphI3B5KNP+E4Vjv8bG3t5Y2GN3xtCKSjiNGW80kov5zu0eKvIB0U4R0JsfRP4j9EYeVBTcVsYWLMU5wtO5qcssZonb7LdOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3TtU7Wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6FCC4CEED;
	Tue,  8 Jul 2025 23:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752016284;
	bh=t244hZBGOCmukFAtqkOz3yRi9QKL2o27KYwvOYiYMbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=P3TtU7Wkp3Qj3oBE1eiS31+hBYttueD1Mq7h1sf9mJRb7d1BdfdZVCLV0LJW5pIxd
	 YEwBkPAqjAg1tGOL4boJs3c2m63OXx2BX0CzqwJxDMGpuba1kTodzT57LVSZVZPmnx
	 w9dieGr1ImEis+OYHBn8JniJkoSP1ph91lr+dRkLMCLct1eXxcac9L9+/n7UWJ5nu9
	 bW7ikwX4y3go0kCLfteJwyj0zOZ31ExRvwQy/18/qQsEwqRS3OpERtgWoUVwl8LPFI
	 IL04KAq5XnqK5y4SgMsJGR7q72m40WccU9BSRb8Ipv4B+PmOufeEuJD3gBb2kWn9K6
	 K2h9q2VA5/jaw==
Date: Tue, 8 Jul 2025 18:11:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-pci@vger.kernel.org,
	Yaron Avizrat <yaron.avizrat@intel.com>,
	Koby Elbaz <koby.elbaz@intel.com>,
	Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alan Stern <stern@rowland.harvard.edu>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>
Subject: Re: [PATCH] PCI: Allow drivers to opt in to async probing
Message-ID: <20250708231123.GA2169642@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53abe6f5ac7c631f95f5d061aa748b192eda0379.1751614426.git.lukas@wunner.de>

On Fri, Jul 04, 2025 at 09:38:33AM +0200, Lukas Wunner wrote:
> The PCI core has historically not allowed drivers to opt in to async
> probing:  Even though drivers may set "PROBE_PREFER_ASYNCHRONOUS", initial
> probing always happens synchronously.  That's because the PCI core uses
> device_attach() instead of device_initial_probe().
> 
> Should a driver return -EPROBE_DEFER on initial probe, reprobing later on
> does honor the PROBE_PREFER_ASYNCHRONOUS setting, which is inconsistent.
> 
> The choice of device_attach() is likely not deliberate:  It was introduced
> in 2013 with commit 58d9a38f6fac ("PCI: Skip attaching driver in
> device_add()"), but asynchronous probing was added two years later with
> commit 765230b5f084 ("driver-core: add asynchronous probing support for
> drivers").
> 
> According to the kernel-doc of "enum probe_type", "the end goal is to
> switch the kernel to use asynchronous probing by default".  To this end,
> use device_initial_probe() to allow asynchronous probing.  The function
> returns void, making the return value check unnecessary.
> 
> Initial PCI probing often takes on the order of seconds even on laptops,
> so this may speed up booting significantly.
> 
> Curiously, a small number of PCI drivers already opt in to asynchronous
> probing.  Their maintainters (who are all cc'ed) should watch out for
> issues, now that asynchronous probing is not just allowed for deferred
> probing, but also initial probing:
> 
> hl_pci_driver        drivers/accel/habanalabs/common/habanalabs_drv.c
> cxl_pci_driver       drivers/cxl/pci.c
> quicki2c_driver      drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> quickspi_driver      drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> i801_driver          drivers/i2c/busses/i2c-i801.c
> mei_me_driver        drivers/misc/mei/pci-me.c
> mei_vsc_drv          drivers/misc/mei/platform-vsc.c
> sdhci_driver         drivers/mmc/host/sdhci-pci-core.c
> nvme_driver          drivers/nvme/host/pci.c
> ehci_pci_driver      drivers/usb/host/ehci-pci.c
> hvfb_pci_stub_driver drivers/video/fbdev/hyperv_fb.c
> 
> All other driver maintainers may test asynchronous probing by specifying
> the command line parameter "driver_async_probe=drv_name1,drv_name2,...",
> and on success setting "probe_type = PROBE_PREFER_ASYNCHRONOUS" in the
> pci_driver struct.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to pci/enumeration for v6.17, thanks!

> ---
>  drivers/pci/bus.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 69048869ef1c..b77fd30bbfd9 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -341,7 +341,6 @@ void pci_bus_add_device(struct pci_dev *dev)
>  {
>  	struct device_node *dn = dev->dev.of_node;
>  	struct platform_device *pdev;
> -	int retval;
>  
>  	/*
>  	 * Can not put in pci_device_add yet because resources
> @@ -372,9 +371,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>  	if (!dn || of_device_is_available(dn))
>  		pci_dev_allow_binding(dev);
>  
> -	retval = device_attach(&dev->dev);
> -	if (retval < 0 && retval != -EPROBE_DEFER)
> -		pci_warn(dev, "device attach failed (%d)\n", retval);
> +	device_initial_probe(&dev->dev);
>  
>  	pci_dev_assign_added(dev);
>  }
> -- 
> 2.47.2
> 

