Return-Path: <linux-pci+bounces-29878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F44ADB63A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 18:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDDC188A75C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97992877E9;
	Mon, 16 Jun 2025 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a3s6TluD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A8F21FF37
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090074; cv=none; b=QKKhVM22UTksw+ooZEcWnyzEUuKlMR9APWF/plA3T48Kv1lNvb4oJaS1iT+p5KbsMQIabUxlDlE3jA4uMMwQRKwd4MR0ej9P2URFZY1CqxbQbgb0/ITCxLHgpF8tTcSxbh153Tx5opYDnazvc1ejPgWLuQFyqC4yGMpGRMo5t9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090074; c=relaxed/simple;
	bh=ZA6S9shc1QEX3PEyqUllB6Vi85lndLEG0kzkNo7/Ypk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIZ2f202gf6lsiy7zi67+fhOg2x7BHYZdegv01v1tx9glE6shVLHGdFGopjKn06l0c3Po++SicNBugab1eIllf2N+P3gYlZ5AaxkJdwKmW3/GJSEouGBgO6xhWC+VpRcq7X/4WM7iF1pTt9yDPt0WBDHgz6mzectv4KgejN0Bp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a3s6TluD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450cfb79177so28890595e9.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 09:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750090071; x=1750694871; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=66enaQYzVszRsP2d3FubStZt1y7rSXnP5cI/cUMaHAc=;
        b=a3s6TluDxHNO9L6Ppp/c5qLuQ4qi+zVkatDACSrjNQzGMPwNIgOmn/VZz8jg1qfjXc
         BXFJ/8N3NKzS9QTT4nmSoT6jHT8VAyO/w0KHLiCMrtl39msoo62nrIVEmchKwR3QEjWZ
         1IuZmKD370XRIdCKBo/ZDWMmy0perrx80w4XGqsxz9zHhe8YHzKUP/7SiX8pvaGaf/FO
         x1n0z6eE1gbJO1eGX7b8hPD0TA5eGqHlIIq678MhQg2B8ooQP4iyRqY/wiBl0ykvTbNl
         R+AMxoNHEjQmhKEUpIRBvx9k6hSvApOkL4mNSwA68tU6g2guvBbQUBHK4zlXYGsLQ3gD
         xJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750090071; x=1750694871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66enaQYzVszRsP2d3FubStZt1y7rSXnP5cI/cUMaHAc=;
        b=I8cHs1AG0cAb/SYzlbPZ6LG75Bx5v36VLYBfW3RQiZ8lJ7V0KZnreW3fIZc242jiIZ
         ntszbs/HQwsVKI0XLR5tQ7NyLP49fUuUWRnHkCThakNpLetsVws2kj55dXi6OLF/yJZX
         n7GpV6q9gfKhxjiAkKC16PxCIlTfLvBzWGV6AJWRmlV8v8zOOOgzwYa2RI568puFOIrH
         /BkAS/JhbSyF8iswmcd4oBC0h4zktt3vAuD6ePX93P5t+5DPfWllOMN9edvXUCI+pxBf
         JDlvH+GEYkCccATQEoMtJm5VjhKTb1kqPPogeJoTLCbnOCiFcnyZP6Cy5SjhXoREcoDu
         9oLw==
X-Forwarded-Encrypted: i=1; AJvYcCVnBPWvkzj+a8B+8HmCBXnoZZ7klYaB9zqg191Ai/htqadznrXytsRt/FWh6R0yOuC2Kolk1vyOmB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAolgqNNBPa2A84wq3ufUV16KQDI29FsQnRRNBmRZUS/D89fkI
	yeN5uvWcRfGuggJSXSTMwk+Ne5R1hlCT8SH73IbWVWO2I/w0BH6j84cLrqMX5+cSZVA=
X-Gm-Gg: ASbGncuk0yU9nbmDddr8hInXW5C97QJFYOmuewQDBBi+6u9wCLyK4EopCZ/47cjRUe7
	2aTYyVXUxR3gtEicbNa3tvtV6sk9n8Mj7Yxhzq8PAEqi4KaTz8SlSV8muUSGPEBtyckjxUQibaq
	pY++svX+Fx4ro+S9/lfdQdhUEdlZ3bppKSVCcfxuSnYG6p4R2Z0WUPOj4Nz3vTwkoCdBcolW+3x
	31f1V7qzMJUd8tLL2yFzoezizUeonbZx6D/H75hfNuoJTKfrbOTv5gw3XTpJNwPoBZkLVKFp2i+
	ebNyZNoSO7/FrAMNgLNrIboVWLIrawLBaG+aj0UzZXqnFTuBYsSRoFRuh528/3csH93dVC0fmN6
	9RzEukBeVnBTzfg==
X-Google-Smtp-Source: AGHT+IFm2XOGvEu+c2Vt4oKDTOhDYuX0Zc67/qbAzwRfpRIo4JlzBUdpBKcXvIOmlDkGO4s2VlIKAQ==
X-Received: by 2002:a05:600c:3ba2:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-4533ca79d19mr100567515e9.3.1750090071100;
        Mon, 16 Jun 2025 09:07:51 -0700 (PDT)
Received: from myrica (92.40.185.180.threembb.co.uk. [92.40.185.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b19b32sm11602270f8f.67.2025.06.16.09.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:07:50 -0700 (PDT)
Date: Mon, 16 Jun 2025 17:07:52 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Alyssa Ross <hi@alyssa.is>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, virtualization@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devel@spectrum-os.org, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	eric.auger@redhat.com
Subject: Re: Virtio interrupt remapping
Message-ID: <20250616160735.GA5171@myrica>
References: <c40da5dc-44c0-454e-8b1d-d3f42c299592@gmail.com>
 <20250613181345.GA1350149@myrica>
 <6b661c62-c322-4f2b-8e4a-da1d5c5e48a1@gmail.com>
 <877c1ed9o7.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877c1ed9o7.fsf@alyssa.is>

[+Eric]

On Sat, Jun 14, 2025 at 10:11:52AM +0200, Alyssa Ross wrote:
> Demi Marie Obenour <demiobenour@gmail.com> writes:
> 
> > On 6/13/25 14:13, Jean-Philippe Brucker wrote:
> >> Hi,
> >> 
> >> On Fri, Jun 13, 2025 at 01:08:07PM -0400, Demi Marie Obenour wrote:
> >>> I’m working on virtio-IOMMU interrupt remapping for Spectrum OS [1],
> >>> and am running into a problem.  All of the current interrupt remapping
> >>> drivers use __init code during initialization, and I’m not sure how to
> >>> plumb the struct virtio_device * into the IOMMU initialization code.
> >>>
> >>> What is the proper way to do this, where “proper” means that it doesn’t
> >>> do something disgusting like “stuff the virtio device in a global
> >>> variable”?
> >> 
> >> I'm not familiar at all with interrupt remapping, but I suspect a major
> >> hurdle will be device probing order: the PCI subsystem probes the
> >> virtio-pci transport device relatively late during boot, and the virtio
> >> driver probes the virtio-iommu device afterwards, at which point we can
> >> call viommu_probe() and inspect the device features and config.  This can
> >> be quite late in userspace if virtio and virtio-iommu get loaded as
> >> modules (which distros tend to do).> 
> >> The way we know to hold off initializing dependent devices before the
> >> IOMMU is ready is by reading the firmware tables. In devicetree the
> >> "msi-parent" and "msi-map" properties point to the interrupt remapping
> >> device, so by reading those Linux knows to wait for the probe of the
> >> remapping device before setting up those endpoints. The ACPI VIOT
> >> describes this topology as well, although at the moment it does not have
> >> separate graphs for MMU and interrupts, like devicetree does (could
> >> probably be added to the spec if needed, but I'm guessing the topologies
> >> may be the same for a VM).  If the interrupt infrastructure supports
> >> probe deferral, then that's probably the way to go.
> >
> > I don't see any examples of probe deferral in the codebase.

I think the flow with VIOT is roughly:

 // Scan an endpoint
 pci_bus_add_device()
  device_attach()
   driver_probe_device()
    really_probe()
     dev->bus->dma_configure()
      pci_dma_configure()
       acpi_dma_configure()
        acpi_iommu_configure_id()
         viot_iommu_configure()
	  viot_dev_iommu_init()
	   acpi_iommu_fwspec_init()
	    iommu_fwspec_init()
	     driver_deferred_probe_check_state()
	     iommu ready ? 0 : -EPROBE_DEFER

So if the IOMMU isn't available at this point, base/dd.c adds the device
to the deferred probe list, to be retried later. Later:

 // Scan the IOMMU
 ...
  virtio_dev_probe()
   viommu_probe()
    iommu_device_register()
     add to iommu_device_list
     iommu->ready = true

I believe after this probe completes, base/dd.c checks if dependent
devices can now be probed:

 driver_bound()
  driver_deferred_probe_trigger()

That should all be working and you don't need to add anything. The
question is whether the interrupt core supports starting the setup of
interrupt remapping in viommu_probe(), or if it needs to know of the
IOMMU's config and features earlier during boot. Even if the viommu driver
is builtin, those info may not be available early enough since they
require PCI and virtio probe.

> > Would it instead be possible to require virtio-iommu (and thus virtio)
> > to be built-in rather than modules?
> 
> It's certainly possible to have an optional feature in the kernel that
> depends on a module being built in where it otherwise wouldn't have to be.

Agree, no problem requiring this as a first step, but the IOMMU probe
might still not be early enough. 

Thanks,
Jean

