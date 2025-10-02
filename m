Return-Path: <linux-pci+bounces-37394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE8CBB2B92
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 09:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0DE219C34B9
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 07:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAC118FC80;
	Thu,  2 Oct 2025 07:45:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549602F4A;
	Thu,  2 Oct 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759391129; cv=none; b=Tqmg8c8zFWS/Am6eU4eqAPaABiG7z47gS7z39qPAEex7cxfuOskbwqTU5+7zZ3FkMd1gXkHg0i3rvM5x3AoaJVV9YkO5S3sGjOyHaOXKUFVur3RcAvBPGSm4hnJTlzBbMc655Hh/kMogs5KZKjC6IB+ssWq5kRxfGmG2rycJ+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759391129; c=relaxed/simple;
	bh=kE/24R+PCV/l7eUZIlk5aGEh01L3C+6v7O1EKkb/aCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mpv8LHAkAFEqJe48FpxxFQlpsrbhHhpD/WUWVGFzIKODvabuyDHa193rl5ytXPelgfUWVoacW5OEk4rB+WGSfVWkIl6zECT3sJ2uKEwfwMxprVsxTJ34Xnlr3AVoJpSybKcPxCanUXiebVp+JTA73/GKVpQPs0Wf7Hus5n7WUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 1247A2C06F79;
	Thu,  2 Oct 2025 09:40:12 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A5FC85F8EA1; Thu,  2 Oct 2025 09:40:11 +0200 (CEST)
Date: Thu, 2 Oct 2025 09:40:11 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com,
	shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v12 10/25] CXL/AER: Update PCI class code check to use
 FIELD_GET()
Message-ID: <aN4sWxjrzxeCyGBO@wunner.de>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-11-terry.bowman@amd.com>
 <20251001171216.00005fa0@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001171216.00005fa0@huawei.com>

On Wed, Oct 01, 2025 at 05:12:16PM +0100, Jonathan Cameron wrote:
> On Thu, 25 Sep 2025 17:34:25 -0500 Terry Bowman <terry.bowman@amd.com> wrote:
> The way that class code definitions work in pci_ids.h is somewhat odd
> in my opinion, so I'd like input from Bjorn, Lukas etc on whether a
> generic mask definition is a good idea or more likely to cause problems.
> 
> See for example. 
> #define PCI_BASE_CLASS_STORAGE		0x01
> ...
> 
> #define PCI_CLASS_STORAGE_SATA		0x0106
> #define PCI_CLASS_STORAGE_SATA_AHCI	0x010601
> 
> This variability in what is called CLASS_* leads to fun
> situations like in drivers/ata/ahci.c where we have some
> PCI_CLASS_* shifted and some not...

Macros working with PCI class codes generally accept a "shift" parameter
to know by how many bits the class code needs to be shifted, see e.g.
DECLARE_PCI_FIXUP_CLASS_EARLY() and friends.

A macro which shifts exactly by 8 is hence only of limited use.


> > +++ b/drivers/pci/pcie/aer_cxl_rch.c
> > @@ -17,10 +17,10 @@ static bool is_cxl_mem_dev(struct pci_dev *dev)
> >  		return false;
> >  
> >  	/*
> > -	 * CXL Memory Devices must have the 502h class code set (CXL
> > -	 * 3.0, 8.1.12.1).
> > +	 * CXL Memory Devices must have the 502h class code set
> > +	 * (CXL 3.2, 8.1.12.1).
> >  	 */
> > -	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> > +	if (FIELD_GET(PCI_CLASS_CODE_MASK, dev->class) != PCI_CLASS_MEMORY_CXL)
> >  		return false;

Hm, this doesn't look more readable TBH.

Refactoring changes like this one should be submitted separately from
this patch set.  If any of them are controversial, they delay upstreaming
of the actual change, i.e. the CXL AER plumbing.  They also increase the
size of the patch set, making it more difficult to review.


> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -73,6 +73,8 @@
> >  #define PCI_CLASS_PROG		0x09	/* Reg. Level Programming Interface */
> >  #define PCI_CLASS_DEVICE	0x0a	/* Device class */
> >  
> > +#define PCI_CLASS_CODE_MASK     __GENMASK(23, 8)
> > +
> >  #define PCI_CACHE_LINE_SIZE	0x0c	/* 8 bits */
> >  #define PCI_LATENCY_TIMER	0x0d	/* 8 bits */
> >  #define PCI_HEADER_TYPE		0x0e	/* 8 bits */

Putting this in a uapi header means we'll have to support it
indefinitely.  Usually such macros are added to kernel-internal
headers first and moved to uapi headers if/when the need arises.

Thanks,

Lukas

