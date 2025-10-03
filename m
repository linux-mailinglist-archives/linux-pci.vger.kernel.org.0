Return-Path: <linux-pci+bounces-37544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7671EBB72E7
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 16:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C9319E7F61
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 14:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D80238C23;
	Fri,  3 Oct 2025 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pHIfItoT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B780823504B
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759501715; cv=none; b=aIcjg0R4utX0j3JvylpVGZaY+aUCKXNBkb7frhBT1aL0dzYkCJ2F9hREN/tBinQxU3VwJtf/MR4PjkHy5bUaIA/FZCiNfkKSBxqbvrb2CSmwZU7ElQXIgoEc856Kw9T78adG532GJkPidPQIvhvKPGi8Qa+ZlMi0ybaETpmlZho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759501715; c=relaxed/simple;
	bh=ezPNEZ/IJFqSQ+puYoLRYru6SDkIr4R+J3IIgGJZEDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evPCBzNJmrYyjG8YGgw4ACYV/pQaLzdrkgrFMZlmoq89G7EktBFFosz1H4jBUdeOQSG1Wvml4POy7+sVkrIC9vIu1hwsgMuh3vTdk0Z93FajuSukaB9Kt+x7pZE3ieGFwAC9sRslvczxzadd3JvsQTVUl+Tyg98YjxoVyEzHwQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pHIfItoT; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4df60ea79d1so27562191cf.2
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 07:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759501712; x=1760106512; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jSkC//pyzN8DkO27vm1eJ5t7cdX6GtvZ0FN76acbnVs=;
        b=pHIfItoTrinMsVqESM6JspIwtJsiY16ZVAqygfSB4MHuP7s29dKKDd5NDQo75zfi0m
         cXClk018vqZeeO2QANylhVksI6CPwzqFOXfbsMB0YP7J8pLTDUjWoE4c7jsPNng2y/8A
         Kr+sYYraKRdeP5c3ZaFb+vMGLuEktws44aKGIl2ShuN1Sq+Qu6RbZS3W2OGYefGFdLc0
         54ZJ5kJEQbQK5lXcF6xJ1EWb3sCK9bspiefzTQJtGebY7ehYm0Upgs22go4+N+YjsD/S
         +wWFS1eqXgogQxeimFRDB4JXH0VktA+6cogmAyn0VOfNZgiTakVJ8vxFEnlCAwei60Lh
         vn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759501712; x=1760106512;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSkC//pyzN8DkO27vm1eJ5t7cdX6GtvZ0FN76acbnVs=;
        b=d1MUGldHOAGqyUIg/5TAHWbLtjAq8q4HOyXUUKOJDYO+HsW467VBMyog2q5b8nm0u7
         fkfnUzy8ij7hiES/NWJj+YCuwv28KAs76AlzPCZVT80Xp8B5dzVurJh7Q6ez5UW3rNAc
         P2tnRHQpQQc0xD6YKUxb2VoDO2n4ENv6T6oAGtUOP5iANbaEwcu8OPl8ymdlI9nYk5wI
         MGQBuMK/YX39ld165nJpSn0BvFsB15UDVANbMUsZd3/lzA0zMJnCPkF32CaPhm275Gdd
         kTQ/tBSK55NfVfNNKydUmoXRz5xY5FDXnVK0y7ow4pS4nVBNLFsQf8QPpI1OvA1yiYL8
         cyJA==
X-Forwarded-Encrypted: i=1; AJvYcCUIAKS18fhLFdl4a7Z3kqfYCXg0LluM1INuL7MOuRxI65uPtOUso3DZqfdK99kQuXo5Ir04FM3+g5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmYJRyM8wtMaSrkRmShz8qaEgI714znujYVbXIpebOhZ4Rtfb3
	1bfCVyi+1H25bO9trD/DjP/c6c1fMqju4nvJCGA7nB/MEAToIg/AYOej1/qTW+0iu/A=
X-Gm-Gg: ASbGncsYOHYGOQKm31c+llASknW7HGRM/x49QuqrEoQsk0vO0S8H+uhLfMz/ixYOkWl
	i8wS4vxvXQvohynZ7QhnnqV/hNxQwGpTcDEjfgZB0EGmIpQiCIYH4al8sRupNrA/5sH5gK0vXbn
	yYl/bEqiMmYPNzfmXiOfKmwYUHRQIEn94PRAUyIa0fpzpgJk4Ync/0Y7uLN7j9eedTfU9rPvhmp
	Dd77l4oJmouKNjcSxChd7U27+sEZG7L4HP0Le38mY+vX50d/tFi0L4PplrcaIcLVzLPSvBwMK5r
	kmQPQr9+iGqEOkaEvskGmh+hWbRT1Er42484cXjmtY2k8iZ2f3VXaHXIwW8RIfeKnTT6uGKhQRb
	4uG/MLQnzSBowaAmcxP68es/bBqp2Dfqefeyn8yMowx+es/54PbQm8WvKkoGHHiddyY5ucnEIe9
	HVSlYsEaZ301YdTtZs/iVd4M2qY4U=
X-Google-Smtp-Source: AGHT+IFmZUi0hUXGPsDtYIINOMocKKfxwRPSDcyJQoNDReTGD2RJGHxokJ1tsn6R+c3XW95hY9Axtw==
X-Received: by 2002:a05:620a:4489:b0:815:dab2:1ea8 with SMTP id af79cd13be357-87a38f08966mr387406685a.79.1759501712450;
        Fri, 03 Oct 2025 07:28:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55d0c8a57sm40352021cf.37.2025.10.03.07.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 07:28:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4glo-0000000E68Z-3t8X;
	Fri, 03 Oct 2025 11:28:28 -0300
Date: Fri, 3 Oct 2025 11:28:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chris Li <chrisl@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
Message-ID: <20251003142828.GP3195829@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org>
 <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>
 <20250930163732.GP2695987@ziepe.ca>
 <CACePvbVXZ-rPmBi30eAO-2oF5K5hzQqQPo17M6hV7Pn4Dxrg9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbVXZ-rPmBi30eAO-2oF5K5hzQqQPo17M6hV7Pn4Dxrg9g@mail.gmail.com>

On Thu, Oct 02, 2025 at 02:39:26PM -0700, Chris Li wrote:
> On Tue, Sep 30, 2025 at 9:37 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > As I said, I would punt all of this to the initrd and let the initrd
> > explicitly bind drivers.
> 
> You still need a mechanism to prevent after the PCI bridge scan,
> create the pci_devices, not auto probe the drivers. If it is not
> driver_override, it will be some new PCI API and liveupdate is the
> first user of it.

Yes, we need userspace to control the timing of driver binding for
Confidential Compute too, so I would prefer to see a generic proposal
that can solve both.

If this is to be a luo thing then preserving disabling driver auto
bind for specific devices could be reasonable.

> There are two slightly different things here:
> 1) modprobe the driver. That is typically control by udev.
> 2) auto probing the drive after the driver has been loaded or PCI
> device scanned.
 
> In your envisioning, the initrd autobind controls both of the above
> two spec of things, right?

Today the initrd runs udev which does the module loading and then
the kernel does driver auto binding.

You'd want to move driver binding to userspace so that userspace can
select which is the right driver for luo and for CC we want to delay
binding the drivers until after userspace has measured and verified
the device.

The idea is that userpsace, through the modules.alias file, would run
the same driver selection algorithm and signal the kernel to load the
driver.

Also, for VFIO we have addressed Greg's remarks about driver name ABI
by adding VFIO specific module.alias entries:

alias vfio_pci:v*d*sv*sd*bc*sc*i* vfio_pci
alias vfio_pci:v000015B3d0000101Esv*sd*bc*sc*i* mlx5_vfio_pci

Modern userspace is already supposed to be entering VFIO mode by using
this file and avoiding making driver name an ABI.

Jason

