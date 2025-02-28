Return-Path: <linux-pci+bounces-22624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F58A4951F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 10:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A80165BF3
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 09:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702E9255E23;
	Fri, 28 Feb 2025 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jGBRfURx"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9EB25335E;
	Fri, 28 Feb 2025 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735237; cv=none; b=bitj+21IBK/H65yRrYoairHE2t8nnY8fY5gjWtqLtO93zkvyebm/3AlEFXun2kNo6uSxMM1khT79Y9cRuqhYHYzF4QsK3il1aLT92Ig0JxOSYGKC6RWGI4WS4YHbBAz6wXoDBA4Fl6xsMcR3aeAElojv4HcecBOvjZYcijyNpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735237; c=relaxed/simple;
	bh=hoojCCSHc/q+dNOoqDAtBTI6MuTE62h/+6RDn5nG4U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELsp5sZK3SP9ew0RAhEzEUuGH9QOIVAhYccRJ0utOMNeiPdF01SVlYlG1FoYAItsvWAxrSCDbAzLS6SUtN7Hn0JRx+Mqi+cCnFlSE/AxPrRSwn2ijtRtiV/LJPaZRXE7AyYcyBL4nE9sYJABK0CoJxvx365NUJw33gZtNtLEsoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jGBRfURx; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740735225; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=dp/DcSJ/kAXW2YxVXdVPgsXdGG4LCzYOVrcvn8ANSZE=;
	b=jGBRfURx+7cr9trgiufqj5CanN8sEJWpoQrMTyZHHIy0BSJqfhDITpVuDTwAPdUtfePb7nYLCLK3sksz6PSs4e2zOJNGeDL0saraKz6DX2LVW6wil2GSKgrfwPdzSUi+LPvuPvgK68ezu8wkpeU8cVCcoSzb2mg00xWJS6KyGJo=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WQPKkmW_1740735223 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 17:33:44 +0800
Date: Fri, 28 Feb 2025 17:33:43 +0800
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
Message-ID: <Z8GC9xiGAtUnWj-I@U-2FWC9VHC-2323.local>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
 <20250224034500.23024-3-feng.tang@linux.alibaba.com>
 <Z7y2e-EJLijQsp8D@wunner.de>
 <Z70zyhZe6OrxNNT3@U-2FWC9VHC-2323.local>
 <Z71Ap7kpV4rfhFDU@wunner.de>
 <Z71KHDbgrPFaoPO7@U-2FWC9VHC-2323.local>
 <Z8FXyVyMyAe4_bI3@U-2FWC9VHC-2323.local>
 <Z8FiPOgKFTt8T0ym@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8FiPOgKFTt8T0ym@wunner.de>

Hi Lukas,

On Fri, Feb 28, 2025 at 08:14:04AM +0100, Lukas Wunner wrote:
> On Fri, Feb 28, 2025 at 02:29:29PM +0800, Feng Tang wrote:
> > On Tue, Feb 25, 2025 at 12:42:04PM +0800, Feng Tang wrote:
> > > > > There might be some misunderstaning here :), I responded in
> > > > > https://lore.kernel.org/lkml/Z6LRAozZm1UfgjqT@U-2FWC9VHC-2323.local/
> > > > > that your suggestion could solve our issue.
> > > > 
> > > > Well, could you test it please?
> > > 
> > We just tried the patch on the hardware and initial 5.10 kernel, and
> > the problem cannot be reproduced, as the first PCIe hotplug command
> > of disabling CCIE and HPIE was not issued.
> 
> Good!
> 
> > Should I post a new version patch with your suggestion?
> 
> Yes, please.

Will do, thanks

> 
> > Also I would like to separate this patch from the patch dealing the
> > nomsi irq storm issue. How do you think?
> 
> Makes sense to me.
> 
> The problem with the nomsi irq storm is really that if the platform
> (i.e. BIOS) doesn't grant OSPM control of hotplug, OSPM (i.e. the kernel)
> cannot modify hotplug registers because the assumption is that the
> platform controls them. 

Yes, very reasonable. I also talked with some firmware engineer, who
shared there is working sample that on some old x86 platform, the
firmware itself is really capable of handling the hotplug stuff when
MSI is disabled.

> If the platform doesn't actually handle
> hotplug, but keeps the interrupts enabled, that's basically a bug
> of the specific platform.

That's what happened in our case :)

> I think the kernel community's stance in such situations is that the
> BIOS vendor should provide an update with a fix.  In some cases
> that's not posible because the product is no longer supported,
> or the vendor doesn't care about Linux issues because it only
> supports Windows or macOS.  In those cases, we deal with these
> problems with a quirk.  E.g. on x86 we often use a DMI quirk to
> recognize affected hardware and the quirk would then disable the
> hotplug interrupts.

I see.

As you dug out the history in https://lore.kernel.org/lkml/Z6RU-681eXl7hcp6@wunner.de/

Our previous debug could go through the OSC check in nomsi case,
only after below patch:

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 84030804a763..e7d9328cba45 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -38,8 +38,7 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
 
 #define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
 				| OSC_PCI_ASPM_SUPPORT \
-				| OSC_PCI_CLOCK_PM_SUPPORT \
-				| OSC_PCI_MSI_SUPPORT)
+				| OSC_PCI_CLOCK_PM_SUPPORT)

Otherwise, the OSC function won't be executed, but kernel will simply
disable PCIe hotplug, which breaks the working sample I mentioned above.
We'd better also include take this change?

Thanks,
Feng

> 
> Thanks,
> 
> Lukas

