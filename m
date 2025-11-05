Return-Path: <linux-pci+bounces-40380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 991F7C37695
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 20:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 490DB4E10B9
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 19:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7AB272E42;
	Wed,  5 Nov 2025 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VA0aPRXP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A3299AB5
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369418; cv=none; b=gjxmCcznKHKl2DjnQRxvSV0Fejy8JomPODPzJMxh1hyBzw+szY9nyi1C0BGytuz9g25u7EVRH4NCa8DRdco3ZRfF+kCtfbeVr+/lJnkPmw3R+sckSAunBMDX+PD8VHSIFbAgqZZIKjauGnEPjpl0cjnUC877qothPv9ABwAJ8a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369418; c=relaxed/simple;
	bh=PZ6fOoCOFzuuftIdxLfo9ZcdanHH16wdQ4uKtiHl2CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyApwMSqCcanQqLKXUM6XjWTShqpXsD71cqlGc8lEhfR3HG+gtgz+gaIN28bmKVQ0GRAEVV8WDf3o7AVXwKKkw2/FVoBlJYxyKYk0k70z+PZ89ZVQ09Yf555dculSvYg20LBFy/Kj5K2MxnC4d6PPKFtj9NNAwPSiAFmfCZRrFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VA0aPRXP; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-88f2b29b651so17600985a.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 11:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762369415; x=1762974215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pkL4FKIhP6Ehebj2t+yWaZ1SkFSBXZJ6OHio2cMXcNM=;
        b=VA0aPRXP3DrdGlRq1n8tiTXTu7vcPVWJQYQC272tesb6SdIYqWrVyQZS77r/EX/DXm
         hsn8HIJOYYeiXEJ1Ah1WcPzD1ArgF3EKbTloX4dGTM0rfY61dwL/1pYd38jBI4I/JY3l
         tAvu1XMu8cNW77qqzYHGOa/n/CrYDru1g7bA6+OecEE8QIeB7grGt6SKOC3kvEHlgpot
         nRRK6H31ufX/W3TH5Fg+95zpI3gkfjDxM5jYoJ4vQzWLLa0BtBG7Ww2hxxwMBRGAJRJh
         tYz4q3IyabA1/s1UdM37uNsmm0tRlfX1ULsZ4qovaXexFSPkRQcrxdPCQDLpMxj8q3im
         /WSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369415; x=1762974215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkL4FKIhP6Ehebj2t+yWaZ1SkFSBXZJ6OHio2cMXcNM=;
        b=WM0wWswBntubncHx+MhmqgDmNcPT6vw3vRpYrjiEZ3GVQNCAd6MceXyaR8dIOKlNer
         06nQ4ngANN1GRbZZ48GZIGm2IEjfLxT9FTiZ3NjxqD44Pepom5R+JaW1adhC8rSbJSFv
         ToOdeIy81W1a04vF7he8HccQk5REn79rNd9eASF3VJ5wscW0hxD7u27ThVh87zkxM9Gi
         693B8KE/zKdqlkMjUNvAujTXzOu6JGgNQvPg3N2hNU5dgdgo55hWCRx6PjybPDe0Sg4i
         eu3NBmY6VsZYbdqZ7xKxXXsGuk+T75wpICVR/vhVoqFjtZCzdpH8cx+gTkF13MTJ61cy
         TLJg==
X-Forwarded-Encrypted: i=1; AJvYcCW5rhvQQhCjMXeXbG5z7h3vc/uhYuFAZTRUARTa+49Osodi/80nZ/YoYB9sH8bdkp3r8KAoM5LOXvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNgFNcSfSYJSer1MAQlKb0opAf23H8kI4eN69sk6qs3DxwFBTc
	RVh40ZeMvXVlhDuqFXa7Dsm1Ki36SOBT0XZ+F0kNszLPQISIa+wb6BmP0tRyhdZ8muw=
X-Gm-Gg: ASbGncut0R/yKWw8ymgB1Ih6BCAN6S+F411LL3onzH1pHNRtB8r4PSOuqPHpRO2R3bB
	MMXpT/Ec4W3q0+jOIBKN2xuln1vuDdhWCBVBU8tKQcumRwEFiSJnMgt+W3SCrYx1AVy2N/6Hyv3
	yfaS/P7E77O6GPsdaakzc7wK1dBzgcBoU0G0oNi+W1jucDFqyTGY/i5yHJMrA39OUqHSrF+IVWn
	P5BG5pSZFlAEmVrIaRXrr+Q8IwTo5ceQpW+/p4TxqcE9ukznU2ua81EZs+hRuRT+1o1ER2+zFZD
	0kreLzHnFBOd0awL/Y3YntLQzkDDOrJpyG+nUNaSxtU8ZB6qnuMkTDo4ilE/5muF3ivXaLEMJDi
	WaulYU3sEaaGv/xAaKMFKGdOzMWyGoItC+wOTGducznYYSdnv/CZr6oRpMY6irF3J2z6hnhu+Gf
	AdnAp4MddUL9Nzzj7hJeNtpogX9dmH4FufWugCIt9RAS5sQgoJEIJKwq9jwhs=
X-Google-Smtp-Source: AGHT+IE5V/WtcWnffysPIf/k2M0HgfBpWIauzXvLJZtWgsovo179L03Km10ymeu7JR1a7HWgRpdnqA==
X-Received: by 2002:a05:620a:2a10:b0:89a:3233:db11 with SMTP id af79cd13be357-8b220afee3cmr496686485a.81.1762369415363;
        Wed, 05 Nov 2025 11:03:35 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235809f79sm20649785a.47.2025.11.05.11.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:03:34 -0800 (PST)
Date: Wed, 5 Nov 2025 14:03:31 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND v13 17/25] cxl: Introduce cxl_pci_drv_bound() to check
 for bound driver
Message-ID: <aQufg2Nfq8YqkwHl@gourry-fedora-PF4VCD3F>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-18-terry.bowman@amd.com>
 <aQuOiK8S31w44pYR@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQuOiK8S31w44pYR@gourry-fedora-PF4VCD3F>

On Wed, Nov 05, 2025 at 12:51:04PM -0500, Gregory Price wrote:
> On Tue, Nov 04, 2025 at 11:02:57AM -0600, Terry Bowman wrote:
> > CXL devices handle protocol errors via driver-specific callbacks rather
> > than the generic pci_driver::err_handlers by default. The callbacks are
> > implemented in the cxl_pci driver and are not part of struct pci_driver, so
> > cxl_core must verify that a device is actually bound to the cxl_pci
> > module's driver before invoking the callbacks (the device could be bound
> > to another driver, e.g. VFIO).
> > 
> > However, cxl_core can not reference symbols in the cxl_pci module because
> > it creates a circular dependency. This prevents cxl_core from checking the
> > EP's bound driver and calling the callbacks.
> > 
> > To fix this, move drivers/cxl/pci.c into drivers/cxl/core/pci_drv.c and
> > build it as part of the cxl_core module. Compile into cxl_core using
> > CXL_PCI and CXL_CORE Kconfig dependencies. This removes the standalone
> > cxl_pci module, consolidates the cxl_pci driver code into cxl_core, and
> > eliminates the circular dependency so cxl_core can safely perform
> > bound-driver checks and invoke the CXL PCI callbacks.
> > 
> > Introduce cxl_pci_drv_bound() to return boolean depending on if the PCI EP
> > parameter is bound to a CXL driver instance. This will be used in future
> > patch when dequeuing work from the kfifo.
> > 
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > 
> > ---
> 
> This commit causes my QEMU basic expander setup and a real device setup
> to fail to probe the cxl_core driver.
> 
> [    2.697094] cxl_core 0000:0d:00.0: BAR 0 [mem 0xfe800000-0xfe80ffff 64bit]: not claimed; can't enable device
> [    2.697098] cxl_core 0000:0d:00.0: probe with driver cxl_core failed with error -22
> 
> Probe order issue when CXL drivers are built-in maybe?
> 

I've narrowed it down to:

Works
-----
CONFIG_CXL_BUS=m
CONFIG_CXL_MEM=m

Fails
-----
CONFIG_CXL_BUS=y
CONFIG_CXL_MEM=y
or BUS ^ MEM

this commit moves pci -> pci_drv.o and moves it ahead of cxl_mem into
cxl_core into core, but note the comment in the Makefile:

# Order is important here for the built-in case:
# - 'core' first for fundamental init
# - 'port' before platform root drivers like 'acpi' so that CXL-root ports
#   are immediately enabled
# - 'mem' and 'pmem' before endpoint drivers so that memdevs are
#   immediately enabled
# - 'pci' last, also mirrors the hardware enumeration hierarchy

~Gregory

