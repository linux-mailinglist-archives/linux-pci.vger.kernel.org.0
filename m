Return-Path: <linux-pci+bounces-22631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5803BA49674
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 11:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15D03B2B10
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A706F269AFF;
	Fri, 28 Feb 2025 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XhiNexaA"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F627269AF2;
	Fri, 28 Feb 2025 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736913; cv=none; b=jWw6ufKXBEVi7HmqVh74iExbji0w0B1dYPDtguIdW241jXhcwe+goy23avbaL/mFaihr8DCpSbL7vU+z3ExeHLeSMlPhvHNM/Cx5/5QKLDiW3RM01aYCi61YOaXdi3lnNdaZVPLtmKHH2TG6RTYjI0IAJcKtI+NtHfugIf2OiEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736913; c=relaxed/simple;
	bh=BxWvwWJXkiVke6UswN453oEGpo4pRgTvp8ThHzvIFik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eb+DYZDcmmi7XghffdbB5xj3Hw5tq/90XGiGOT/EGN40Sa2S9W5zALxy+7h40u7XOXOVPX7duGxHZpD8hpZhp4EhSxAIu9EVXV3+0iC+JuFzwc7yfInCVoEwAWRXzaIT+cxhNbp3IRes55w+dTV059H7z837cbwnjYaLTMTeCH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XhiNexaA; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740736901; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=qqdjs9uYKWL6AnUSV2VSVPfmJAZIYK7C9baXgx0fnAg=;
	b=XhiNexaAW6wJBbmjvO+IZMHoSVHSGZbRX45Xds+g6Di+opGkSd+agHH0sGs42cuSYzdIuyvVsWMmChaSSF1KRxhPIcDHjPRQ22AmM3gop19VDM6POd23g2DMHK7z/j9UIIZhGM2sacHc06zGP+vQcc9QeTiGZbYEjov+v0QLIiw=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WQPM.Ry_1740736899 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 18:01:40 +0800
Date: Fri, 28 Feb 2025 18:01:39 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: rafael@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Markus Elfring <Markus.Elfring@web.de>, lkp@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] PCI/portdrv: Add necessary wait for disabling
 hotplug events
Message-ID: <Z8GJg30JYWHeMFHK@U-2FWC9VHC-2323.local>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
 <20250224034500.23024-3-feng.tang@linux.alibaba.com>
 <Z7y2e-EJLijQsp8D@wunner.de>
 <Z70zyhZe6OrxNNT3@U-2FWC9VHC-2323.local>
 <Z71Ap7kpV4rfhFDU@wunner.de>
 <Z71KHDbgrPFaoPO7@U-2FWC9VHC-2323.local>
 <Z8FXyVyMyAe4_bI3@U-2FWC9VHC-2323.local>
 <Z8FiPOgKFTt8T0ym@wunner.de>
 <Z8GC9xiGAtUnWj-I@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8GC9xiGAtUnWj-I@U-2FWC9VHC-2323.local>

On Fri, Feb 28, 2025 at 05:33:43PM +0800, Feng Tang wrote:
> > The problem with the nomsi irq storm is really that if the platform
> > (i.e. BIOS) doesn't grant OSPM control of hotplug, OSPM (i.e. the kernel)
> > cannot modify hotplug registers because the assumption is that the
> > platform controls them. 
> 
> Yes, very reasonable. I also talked with some firmware engineer, who
> shared there is working sample that on some old x86 platform, the
> firmware itself is really capable of handling the hotplug stuff when
> MSI is disabled.
> 
> > If the platform doesn't actually handle
> > hotplug, but keeps the interrupts enabled, that's basically a bug
> > of the specific platform.
> 
> That's what happened in our case :)
> 
> > I think the kernel community's stance in such situations is that the
> > BIOS vendor should provide an update with a fix.  In some cases
> > that's not posible because the product is no longer supported,
> > or the vendor doesn't care about Linux issues because it only
> > supports Windows or macOS.  In those cases, we deal with these
> > problems with a quirk.  E.g. on x86 we often use a DMI quirk to
> > recognize affected hardware and the quirk would then disable the
> > hotplug interrupts.
> 
> I see.
> 
> As you dug out the history in https://lore.kernel.org/lkml/Z6RU-681eXl7hcp6@wunner.de/
> 
> Our previous debug could go through the OSC check in nomsi case,
> only after below patch:
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 84030804a763..e7d9328cba45 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -38,8 +38,7 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
>  
>  #define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
>  				| OSC_PCI_ASPM_SUPPORT \
> -				| OSC_PCI_CLOCK_PM_SUPPORT \
> -				| OSC_PCI_MSI_SUPPORT)
> +				| OSC_PCI_CLOCK_PM_SUPPORT)
> 
> Otherwise, the OSC function won't be executed, but kernel will simply
> disable PCIe hotplug,

> which breaks the working sample I mentioned above.
Sorry, this saying is wrong, the patch doesn't change anything for cases
that firwmare would handle the PCIe hotplug.

But still, it is reasonable to let firmware decide if it would grant
the control to OSPM.

Thanks,
Feng

> We'd better also include take this change?
> 
> Thanks,
> Feng
> 
> > 
> > Thanks,
> > 
> > Lukas

