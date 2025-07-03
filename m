Return-Path: <linux-pci+bounces-31339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16633AF6D59
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0CA1C80281
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 08:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B3E28D8E8;
	Thu,  3 Jul 2025 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NG5UNXMh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7CB2AD25;
	Thu,  3 Jul 2025 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532378; cv=none; b=W2KdGPbhDXUluTIHFteB0+4vVDQ/pnZSPgI0Hc5NdcTnApuqfyemToq39yWlFIS09VZOPoqml7GLU4ZJinOk3sblFT67WVKiGJlT/ZhLRi3Yp3ACMXP6m7lKGSqqF87kBJrhHl35MbtDfGfnv8QCTu3I+XSo63TUA5vPx2oeUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532378; c=relaxed/simple;
	bh=O9usTxhDHfLcTpuq8xPp2WlePI7M1F+dg5efcZC39oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9ZHloIdbnIOvCzJ3X8GacFopRjghwljbk/jqXdvvvpbPL0e3lHC1b/c+8Ek5cf36Ql2tDQgZMn++Drjc3VhE2rsDeKKLWPzKn9j9YPaA1azDW0gP/cUUN/5ut5/s9AABZ537IfRIJV12evk5MmaCiZP8A51hjJdcK8OZxzOEAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NG5UNXMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83553C4CEE3;
	Thu,  3 Jul 2025 08:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751532377;
	bh=O9usTxhDHfLcTpuq8xPp2WlePI7M1F+dg5efcZC39oY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NG5UNXMhWC6eZ5jBGL0/+BOWH6EGU5YtD0bIhJRutPXvUnrBUObK+G3X0+1q3+Nm4
	 scgX62QHjUzqME6mZjzb4U4WH1wNbIIao5a5tSRr/rvRqDpwOoG3/M1gCQfGgZgKg7
	 B1UDHrAxTeqmmXGccDLQL0PVcVSXLFpsnHFfuy+RCDnmQhA4wYQawO+kSDGzwAgAxH
	 lEd+qxQdUaU+GnKIFecjxr2HXDXApiSUFqqIos19/zBR2iCqoU35YDwDw+7e5mrMq3
	 C4OQtZpGHoONucvQqs0xzX1AewQUjjDm9UxjXv8/ykUsuCOCO9OHFO6tyth9oQL7ML
	 PcTigfGkrWFzg==
Message-ID: <81db2fce-34db-46e7-8c68-bc4cb1a03d25@kernel.org>
Date: Thu, 3 Jul 2025 10:46:12 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] agp/amd64: Check AGP Capability before binding to
 unsupported devices
To: Lukas Wunner <lukas@wunner.de>, David Airlie <airlied@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Andi Kleen <ak@linux.intel.com>, Ahmed Salem <x0rw3ll@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org
References: <b29e7fbfc6d146f947603d0ebaef44cbd2f0d754.1751468802.git.lukas@wunner.de>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <b29e7fbfc6d146f947603d0ebaef44cbd2f0d754.1751468802.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lukas,

On 2-Jul-25 5:15 PM, Lukas Wunner wrote:
> Since commit 172efbb40333 ("AGP: Try unsupported AGP chipsets on x86-64
> by default"), the AGP driver for AMD Opteron/Athlon64 CPUs has attempted
> to bind to any PCI device possessing an AGP Capability.
> 
> Commit 6fd024893911 ("amd64-agp: Probe unknown AGP devices the right
> way") subsequently reworked the driver to perform a bind attempt to
> any PCI device (regardless of AGP Capability) and reject a device in
> the driver's ->probe() hook if it lacks the AGP Capability.
> 
> On modern CPUs exposing an AMD IOMMU, this subtle change results in an
> annoying message with KERN_CRIT severity:
> 
>   pci 0000:00:00.2: Resources present before probing
> 
> The message is emitted by the driver core prior to invoking a driver's
> ->probe() hook.  The check for an AGP Capability in the ->probe() hook
> happens too late to prevent the message.
> 
> The message has appeared only recently with commit 3be5fa236649 (Revert
> "iommu/amd: Prevent binding other PCI drivers to IOMMU PCI devices").
> Prior to the commit, no driver could bind to AMD IOMMUs.
> 
> The reason for the message is that an MSI is requested early on for the
> AMD IOMMU, which results in a call from msi_sysfs_create_group() to
> devm_device_add_group().  A devres resource is thus attached to the
> driver-less AMD IOMMU, which is normally not allowed, but presumably
> cannot be avoided because requesting the MSI from a regular PCI driver
> might be too late.
> 
> Avoid the message by once again checking for an AGP Capability *before*
> binding to an unsupported device.  Achieve that by way of the PCI core's
> dynid functionality.
> 
> pci_add_dynid() can fail only with -ENOMEM (on allocation failure) or
> -EINVAL (on bus_to_subsys() failure).  It doesn't seem worth the extra
> code to propagate those error codes out of the for_each_pci_dev() loop,
> so simply error out with -ENODEV if there was no successful bind attempt.
> In the -ENOMEM case, a splat is emitted anyway, and the -EINVAL case can
> never happen because it requires failure of bus_register(&pci_bus_type),
> in which case there's no driver probing of PCI devices.
> 
> Hans has voiced a preference to no longer probe unsupported devices by
> default (i.e. set agp_try_unsupported = 0).  In fact, the help text for
> CONFIG_AGP_AMD64 pretends this to be the default.  Alternatively, he
> proposes probing only devices with PCI_CLASS_BRIDGE_HOST.  However these
> approaches risk regressing users who depend on the existing behavior.
> 
> Fixes: 3be5fa236649 (Revert "iommu/amd: Prevent binding other PCI drivers to IOMMU PCI devices")
> Reported-by: Fedor Pchelkin <pchelkin@ispras.ru>
> Closes: https://lore.kernel.org/r/wpoivftgshz5b5aovxbkxl6ivvquinukqfvb5z6yi4mv7d25ew@edtzr2p74ckg/
> Reported-by: Hans de Goede <hansg@kernel.org>
> Closes: https://lore.kernel.org/r/20250625112411.4123-1-hansg@kernel.org/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> Changes v1 -> v2:
>  * Use pci_add_dynid() to bind only to devices with AGP Capability
>    (based on a suggestion from Ben).
>  * Rephrase commit message to hopefully explain the history more accurately.
>    Explain why resources are attached to the driver-less AMD IOMMU
>    (requested by Ben).
>  * Acknowledge Hans as reporter.

Thank you for the new version.

I can confirm that this fixes the issue for me and the code also looks
good to me:

Tested-by: Hans de Goede <hansg@kernel.org>
Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans




>  drivers/char/agp/amd64-agp.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
> index bf490967241a..2505df1f4e69 100644
> --- a/drivers/char/agp/amd64-agp.c
> +++ b/drivers/char/agp/amd64-agp.c
> @@ -720,11 +720,6 @@ static const struct pci_device_id agp_amd64_pci_table[] = {
>  
>  MODULE_DEVICE_TABLE(pci, agp_amd64_pci_table);
>  
> -static const struct pci_device_id agp_amd64_pci_promisc_table[] = {
> -	{ PCI_DEVICE_CLASS(0, 0) },
> -	{ }
> -};
> -
>  static DEFINE_SIMPLE_DEV_PM_OPS(agp_amd64_pm_ops, NULL, agp_amd64_resume);
>  
>  static struct pci_driver agp_amd64_pci_driver = {
> @@ -739,6 +734,7 @@ static struct pci_driver agp_amd64_pci_driver = {
>  /* Not static due to IOMMU code calling it early. */
>  int __init agp_amd64_init(void)
>  {
> +	struct pci_dev *pdev = NULL;
>  	int err = 0;
>  
>  	if (agp_off)
> @@ -767,9 +763,13 @@ int __init agp_amd64_init(void)
>  		}
>  
>  		/* Look for any AGP bridge */
> -		agp_amd64_pci_driver.id_table = agp_amd64_pci_promisc_table;
> -		err = driver_attach(&agp_amd64_pci_driver.driver);
> -		if (err == 0 && agp_bridges_found == 0) {
> +		for_each_pci_dev(pdev)
> +			if (pci_find_capability(pdev, PCI_CAP_ID_AGP))
> +				pci_add_dynid(&agp_amd64_pci_driver,
> +					      pdev->vendor, pdev->device,
> +					      pdev->subsystem_vendor,
> +					      pdev->subsystem_device, 0, 0, 0);
> +		if (agp_bridges_found == 0) {
>  			pci_unregister_driver(&agp_amd64_pci_driver);
>  			err = -ENODEV;
>  		}


