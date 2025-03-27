Return-Path: <linux-pci+bounces-24826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B6DA72CB0
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 10:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F60D1891EBF
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 09:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0B013AA31;
	Thu, 27 Mar 2025 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ShKgLqAI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A713145B3F
	for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068831; cv=none; b=NALwA3c8t3oBhZ/qAhDmInA0YpXUfklVgnkpfRQJVqK/iJx7aVok2j6/vkWLQI8f7c34hINLpE/8sH/nDmvk81xOo/5hPsT2IGhLtd/AysbmNYZGwaSchIVluSfGUe64epM76LUe1k/nXSMsbqm0//mggb+KHVXyBrpgDaHwv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068831; c=relaxed/simple;
	bh=pT9PkSrT7mqR+WQ6DEQw+ntfETqkmHkkVbQrJp/Yxyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjIGzTtQE2TsM9XjzqnQat/bSUU/vgRj+KsL6R0vmlv5iFq1LI8+WId1U47nOyaGfbpH4c3vQRpZMMXQTnJDitKK9TQvqDHMyjv3otA5qZ0PcLGZTY7leZE/bHtSE3H/yO084Tj5ynpFGuHi5Qc1YezMFX95sw/UgQweIsSBP3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ShKgLqAI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30185d00446so1081031a91.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 02:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1743068828; x=1743673628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SW9HCzyLQIZzY69YplM0Pf2SuZh3YD6bPueDr3mT+uc=;
        b=ShKgLqAIBVI6t6MoN6R7UM0qFNopGJWRD8L/eFlvlA5xTes03oCWNuwAXETlZsWK6m
         nwGOQBTVY6fuuD1U0+VIU/hltO4JB6CafXFWrPtgB2uv/6i9Y0nhsSBcL2t1eC8r5/mL
         MqnfpvhJ6uaIH10W2tfX9XrLk08OX/Rc0Jcqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743068828; x=1743673628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SW9HCzyLQIZzY69YplM0Pf2SuZh3YD6bPueDr3mT+uc=;
        b=orwJhEpmfuJLkRvFNHVNWGI3DKlVTnLEEIr0tfiuAijYA711bYXhw3+dmwXXkAx1tr
         P/FJunh45SrOfkr7p5Bdcq0Apd98iUz2ZdJ5Q/QQIMn7YzG6ru39b5yhF0bFejQ5GsfM
         K2I44GLtmeDozIaJIOZhDF7rqhYrlsjwuiujGP3EvT6f+Solz/6POANHgCE/bd2zgtsM
         qx8nYF4Mo0fP0a235N8PXKM9bWnAwADCWdkhwsiaura/vz5zTulkbXbxlVnFlouErJrp
         Zagh4eAmiCAvU0BcnWIpEFhrgGVYP4l59pqYy9CFOtpltGfHNBFP+fVOGZmqJtL3J4l1
         Au9g==
X-Forwarded-Encrypted: i=1; AJvYcCVi5g6O9jeUKTAtIdg910KyC41njkUfO2ZYJWnXsnVxebnD0DMlhg0zUpAnpOUs0mHyvUI0iANwqYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTf14ACrX6mAsyJII7VUMtoL0QcziFIgPRlJmdhtb6pR0C673d
	n3gA3OSET/38yKoSohGg2P2hQj/+67JxXBXbVtMl714ed2W4E5PzWlHOG5n5fg==
X-Gm-Gg: ASbGnctFYKnWTXDOBQpjWo/1FNEd60qUEyiL8PK5vAnaOi+Idcajcj8sUV9fY7Oz8uN
	g8yOmJmAzagdwbzhGYjrnoDgUSOoBFPP6mm7P3rQCJ6gORTGtC9Ozi1mnfj/9xjs0egnhTxu1Xq
	xi7K4kSsxwPeeSzqUg141bbcDoOF6CgdmgQkrTHr9ktcVWuSmUynHHl82HSwKDqGdNDPGa2lQez
	UxpHSXNEHmkEjZxGmilzGu+9vhPv/ubsN0Pz2KuPzCZ06Yn8bOQ3H7MM17WbDD9EiiywHa2stzm
	FP9rQshg4ZnfWVjVF5PdWb1IlVIO9MMNq6Bs3Q==
X-Google-Smtp-Source: AGHT+IFJkmLWd/lonFB+EtD7O5kAypEs9+uoWSd7MhEjp5k731wZKwYQHKuuFIZHJ3I3Aw60m3IKpg==
X-Received: by 2002:a17:90b:5703:b0:2fa:603e:905c with SMTP id 98e67ed59e1d1-303788c1d9amr11144403a91.2.1743068827905;
        Thu, 27 Mar 2025 02:47:07 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:2c04:d30e:5507:f399])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039dfd499csm1946525a91.10.2025.03.27.02.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 02:47:07 -0700 (PDT)
Date: Thu, 27 Mar 2025 17:47:01 +0800
From: Chen-Yu Tsai <wenst@chromium.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
Message-ID: <20250327094701.GA791706@google.com>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>

Hi,

On Fri, Feb 28, 2025 at 03:46:33PM +0000, Robin Murphy wrote:
> In hindsight, there were some crucial subtleties overlooked when moving
> {of,acpi}_dma_configure() to driver probe time to allow waiting for
> IOMMU drivers with -EPROBE_DEFER, and these have become an
> ever-increasing source of problems. The IOMMU API has some fundamental
> assumptions that iommu_probe_device() is called for every device added
> to the system, in the order in which they are added. Calling it in a
> random order or not at all dependent on driver binding leads to
> malformed groups, a potential lack of isolation for devices with no
> driver, and all manner of unexpected concurrency and race conditions.
> We've attempted to mitigate the latter with point-fix bodges like
> iommu_probe_device_lock, but it's a losing battle and the time has come
> to bite the bullet and address the true source of the problem instead.
> 
> The crux of the matter is that the firmware parsing actually serves two
> distinct purposes; one is identifying the IOMMU instance associated with
> a device so we can check its availability, the second is actually
> telling that instance about the relevant firmware-provided data for the
> device. However the latter also depends on the former, and at the time
> there was no good place to defer and retry that separately from the
> availability check we also wanted for client driver probe.
> 
> Nowadays, though, we have a proper notion of multiple IOMMU instances in
> the core API itself, and each one gets a chance to probe its own devices
> upon registration, so we can finally make that work as intended for
> DT/IORT/VIOT platforms too. All we need is for iommu_probe_device() to
> be able to run the iommu_fwspec machinery currently buried deep in the
> wrong end of {of,acpi}_dma_configure(). Luckily it turns out to be
> surprisingly straightforward to bootstrap this transformation by pretty
> much just calling the same path twice. At client driver probe time,
> dev->driver is obviously set; conversely at device_add(), or a
> subsequent bus_iommu_probe(), any device waiting for an IOMMU really
> should *not* have a driver already, so we can use that as a condition to
> disambiguate the two cases, and avoid recursing back into the IOMMU core
> at the wrong times.
> 
> Obviously this isn't the nicest thing, but for now it gives us a
> functional baseline to then unpick the layers in between without many
> more awkward cross-subsystem patches. There are some minor side-effects
> like dma_range_map potentially being created earlier, and some debug
> prints being repeated, but these aren't significantly detrimental. Let's
> make things work first, then deal with making them nice.
> 
> With the basic flow finally in the right order again, the next step is
> probably turning the bus->dma_configure paths inside-out, since all we
> really need from bus code is its notion of which device and input ID(s)
> to parse the common firmware properties with...
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci-driver.c
> Acked-by: Rob Herring (Arm) <robh@kernel.org> # of/device.c
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

This change causes the MediaTek IOMMU driver to panic on probe,
resulting in multiple MediaTek platforms not being able to boot.
This was observed on Linus's tree at commit 1a9239bb4253
("Merge tag 'net-next-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next")
which just received the IOMMU updates a couple merge commits
prior.

The regression was bisected down to this patch on MT8183 Juniper
Chromebook. The error is a NULL pointer dereference. Here's the
decoded backtrace:

    Unable to handle kernel read from unreadable memory at virtual address 0000000000000000
    Mem abort info:
      ESR = 0x0000000096000005
    usb 1-1.1.2: new high-speed USB device number 6 using xhci-mtk
      EC = 0x25: DABT (current EL), IL = 32 bits
      SET = 0, FnV = 0
      EA = 0, S1PTW = 0
      FSC = 0x05: level 1 translation fault
    Data abort info:
      ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
      CM = 0, WnR = 0, TnD = 0, TagAccess = 0
      GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
    [0000000000000000] user address but active_mm is swapper
    Internal error: Oops: 0000000096000005 [#1]  SMP
    Modules linked in:
    CPU: 4 UID: 0 PID: 68 Comm: kworker/u34:1 Tainted: G    B              6.14.0-05877-g1a9239bb4253 #621 PREEMPT  a6631d3f04612a5c23866dc67cf38316c6b023e0
    Tainted: [B]=BAD_PAGE
    Hardware name: Google juniper sku16 board (DT)
    Workqueue: events_unbound deferred_probe_work_func
    pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    pc : mtk_iommu_device_group (drivers/iommu/mtk_iommu.c:368 drivers/iommu/mtk_iommu.c:940)
    lr : mtk_iommu_device_group (drivers/iommu/mtk_iommu.c:368 drivers/iommu/mtk_iommu.c:940)
    sp : ffffffc0809674a0
    x29: ffffffc0809674a0 x28: ffffff80c1f0f078 x27: ffffff80c1f0f460
    x26: ffffff80c1f0f458 x25: ffffffdb1b738788 x24: ffffffc0809676d0
    x23: ffffff80c8fe4130 x22: ffffffffffffffed x21: 0000000000000000
    x20: ffffff80c1f0f010 x19: ffffff80c8fd7d00 x18: 0000000000000000
    x17: 000000040044ffff x16: 00500072b5593510 x15: 0000000000000000
    x14: ffffff80c09fbb80 x13: ffffffa5bf03f000 x12: ffffffbb6399cdf1
    x11: 1ffffffb6399cdf0 x10: ffffffbb6399cdf0 x9 : dfffffc000000000
    x8 : 000000449c663210 x7 : ffffffdb1cce6f87 x6 : 0000000000000001
    x5 : ffffffdb1cce6f80 x4 : ffffffbb6399cdf1 x3 : 0000000000000000
    x2 : 0000000000000020 x1 : ffffff80c22ed940 x0 : 0000000000000001
    Call trace:
    mtk_iommu_device_group (drivers/iommu/mtk_iommu.c:368 drivers/iommu/mtk_iommu.c:940) (P)
    __iommu_probe_device (drivers/iommu/iommu.c:461 drivers/iommu/iommu.c:563)
    probe_iommu_group (drivers/iommu/iommu.c:1722)
    bus_for_each_dev (drivers/base/bus.c:370)
    iommu_device_register (drivers/iommu/iommu.c:1875 drivers/iommu/iommu.c:276)
    mtk_iommu_probe (drivers/iommu/mtk_iommu.c:1380)
    platform_probe (drivers/base/platform.c:1404)
    really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658)
    __driver_probe_device (drivers/base/dd.c:800)
    driver_probe_device (drivers/base/dd.c:830)
    __device_attach_driver (drivers/base/dd.c:959)
    bus_for_each_drv (drivers/base/bus.c:462)
    __device_attach (drivers/base/dd.c:1032)
    device_initial_probe (drivers/base/dd.c:1080)
    bus_probe_device (drivers/base/bus.c:537)
    deferred_probe_work_func (drivers/base/dd.c:124)
    process_one_work (./arch/arm64/include/asm/jump_label.h:36 ./include/trace/events/workqueue.h:110 kernel/workqueue.c:3243)
    worker_thread (kernel/workqueue.c:3313 (discriminator 2) kernel/workqueue.c:3400 (discriminator 2))
    kthread (kernel/kthread.c:464)
    ret_from_fork (arch/arm64/kernel/entry.S:863)
    Code: 92800256 f940d2b5 aa1503e0 97e8dbd7 (f94002b5)
    All code
    ========
       0:	92800256 	mov	x22, #0xffffffffffffffed    	// #-19
       4:	f940d2b5 	ldr	x21, [x21, #416]
       8:	aa1503e0 	mov	x0, x21
       c:	97e8dbd7 	bl	0xffffffffffa36f68
      10:*	f94002b5 	ldr	x21, [x21]		<-- trapping instruction

    Code starting with the faulting instruction
    ===========================================
       0:	f94002b5 	ldr	x21, [x21]
    ---[ end trace 0000000000000000 ]---


ChenYu

> ---
> 
> v2:
>  - Comment bus driver changes for clarity
>  - Use dev->iommu as the now-robust replay condition
>  - Drop the device_iommu_mapped() checks in the firmware paths as they
>    weren't doing much - we can't replace probe_device_lock just yet...
>  
>  drivers/acpi/arm64/dma.c        |  5 +++++
>  drivers/acpi/scan.c             |  7 -------
>  drivers/amba/bus.c              |  3 ++-
>  drivers/base/platform.c         |  3 ++-
>  drivers/bus/fsl-mc/fsl-mc-bus.c |  3 ++-
>  drivers/cdx/cdx.c               |  3 ++-
>  drivers/iommu/iommu.c           | 24 +++++++++++++++++++++---
>  drivers/iommu/of_iommu.c        |  7 ++++++-
>  drivers/of/device.c             |  7 ++++++-
>  drivers/pci/pci-driver.c        |  3 ++-
>  10 files changed, 48 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
> index 52b2abf88689..f30f138352b7 100644
> --- a/drivers/acpi/arm64/dma.c
> +++ b/drivers/acpi/arm64/dma.c
> @@ -26,6 +26,11 @@ void acpi_arch_dma_setup(struct device *dev)
>  	else
>  		end = (1ULL << 32) - 1;
>  
> +	if (dev->dma_range_map) {
> +		dev_dbg(dev, "dma_range_map already set\n");
> +		return;
> +	}
> +
>  	ret = acpi_dma_get_range(dev, &map);
>  	if (!ret && map) {
>  		end = dma_range_map_max(map);
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 9f4efa8f75a6..fb1fe9f3b1a3 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1632,13 +1632,6 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>  		err = viot_iommu_configure(dev);
>  	mutex_unlock(&iommu_probe_device_lock);
>  
> -	/*
> -	 * If we have reason to believe the IOMMU driver missed the initial
> -	 * iommu_probe_device() call for dev, replay it to get things in order.
> -	 */
> -	if (!err && dev->bus)
> -		err = iommu_probe_device(dev);
> -
>  	return err;
>  }
>  
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 8ef259b4d037..71482d639a6d 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -364,7 +364,8 @@ static int amba_dma_configure(struct device *dev)
>  		ret = acpi_dma_configure(dev, attr);
>  	}
>  
> -	if (!ret && !drv->driver_managed_dma) {
> +	/* @drv may not be valid when we're called from the IOMMU layer */
> +	if (!ret && dev->driver && !drv->driver_managed_dma) {
>  		ret = iommu_device_use_default_domain(dev);
>  		if (ret)
>  			arch_teardown_dma_ops(dev);
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 6f2a33722c52..1813cfd0c4bd 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1451,7 +1451,8 @@ static int platform_dma_configure(struct device *dev)
>  		attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
>  		ret = acpi_dma_configure(dev, attr);
>  	}
> -	if (ret || drv->driver_managed_dma)
> +	/* @drv may not be valid when we're called from the IOMMU layer */
> +	if (ret || !dev->driver || drv->driver_managed_dma)
>  		return ret;
>  
>  	ret = iommu_device_use_default_domain(dev);
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index d1f3d327ddd1..a8be8cf246fb 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -153,7 +153,8 @@ static int fsl_mc_dma_configure(struct device *dev)
>  	else
>  		ret = acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
>  
> -	if (!ret && !mc_drv->driver_managed_dma) {
> +	/* @mc_drv may not be valid when we're called from the IOMMU layer */
> +	if (!ret && dev->driver && !mc_drv->driver_managed_dma) {
>  		ret = iommu_device_use_default_domain(dev);
>  		if (ret)
>  			arch_teardown_dma_ops(dev);
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index c573ed2ee71a..780fb0c4adba 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -360,7 +360,8 @@ static int cdx_dma_configure(struct device *dev)
>  		return ret;
>  	}
>  
> -	if (!ret && !cdx_drv->driver_managed_dma) {
> +	/* @cdx_drv may not be valid when we're called from the IOMMU layer */
> +	if (!ret && dev->driver && !cdx_drv->driver_managed_dma) {
>  		ret = iommu_device_use_default_domain(dev);
>  		if (ret)
>  			arch_teardown_dma_ops(dev);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index a3b45b84f42b..1cec7074367a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -414,9 +414,21 @@ static int iommu_init_device(struct device *dev)
>  	if (!dev_iommu_get(dev))
>  		return -ENOMEM;
>  	/*
> -	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
> -	 * instances with non-NULL fwnodes, and client devices should have been
> -	 * identified with a fwspec by this point. Otherwise, we can currently
> +	 * For FDT-based systems and ACPI IORT/VIOT, the common firmware parsing
> +	 * is buried in the bus dma_configure path. Properly unpicking that is
> +	 * still a big job, so for now just invoke the whole thing. The device
> +	 * already having a driver bound means dma_configure has already run and
> +	 * either found no IOMMU to wait for, or we're in its replay call right
> +	 * now, so either way there's no point calling it again.
> +	 */
> +	if (!dev->driver && dev->bus->dma_configure) {
> +		mutex_unlock(&iommu_probe_device_lock);
> +		dev->bus->dma_configure(dev);
> +		mutex_lock(&iommu_probe_device_lock);
> +	}
> +	/*
> +	 * At this point, relevant devices either now have a fwspec which will
> +	 * match ops registered with a non-NULL fwnode, or we can reasonably
>  	 * assume that only one of Intel, AMD, s390, PAMU or legacy SMMUv2 can
>  	 * be present, and that any of their registered instances has suitable
>  	 * ops for probing, and thus cheekily co-opt the same mechanism.
> @@ -426,6 +438,12 @@ static int iommu_init_device(struct device *dev)
>  		ret = -ENODEV;
>  		goto err_free;
>  	}
> +	/*
> +	 * And if we do now see any replay calls, they would indicate someone
> +	 * misusing the dma_configure path outside bus code.
> +	 */
> +	if (dev->driver)
> +		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");
>  
>  	if (!try_module_get(ops->owner)) {
>  		ret = -EINVAL;
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index e10a68b5ffde..6b989a62def2 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -155,7 +155,12 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>  		dev_iommu_free(dev);
>  	mutex_unlock(&iommu_probe_device_lock);
>  
> -	if (!err && dev->bus)
> +	/*
> +	 * If we're not on the iommu_probe_device() path (as indicated by the
> +	 * initial dev->iommu) then try to simulate it. This should no longer
> +	 * happen unless of_dma_configure() is being misused outside bus code.
> +	 */
> +	if (!err && dev->bus && !dev_iommu_present)
>  		err = iommu_probe_device(dev);
>  
>  	if (err && err != -EPROBE_DEFER)
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index edf3be197265..5053e5d532cc 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -99,6 +99,11 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>  	bool coherent, set_map = false;
>  	int ret;
>  
> +	if (dev->dma_range_map) {
> +		dev_dbg(dev, "dma_range_map already set\n");
> +		goto skip_map;
> +	}
> +
>  	if (np == dev->of_node)
>  		bus_np = __of_get_dma_parent(np);
>  	else
> @@ -119,7 +124,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>  		end = dma_range_map_max(map);
>  		set_map = true;
>  	}
> -
> +skip_map:
>  	/*
>  	 * If @dev is expected to be DMA-capable then the bus code that created
>  	 * it should have initialised its dma_mask pointer by this point. For
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f57ea36d125d..4468b7327cab 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1653,7 +1653,8 @@ static int pci_dma_configure(struct device *dev)
>  
>  	pci_put_host_bridge_device(bridge);
>  
> -	if (!ret && !driver->driver_managed_dma) {
> +	/* @driver may not be valid when we're called from the IOMMU layer */
> +	if (!ret && dev->driver && !driver->driver_managed_dma) {
>  		ret = iommu_device_use_default_domain(dev);
>  		if (ret)
>  			arch_teardown_dma_ops(dev);
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

