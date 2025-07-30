Return-Path: <linux-pci+bounces-33153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4048CB1593F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 09:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD6818A3B49
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 07:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3B51F76A5;
	Wed, 30 Jul 2025 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d+FizXXU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24831F1306;
	Wed, 30 Jul 2025 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753859069; cv=none; b=ge7Hy+5VThIl0E/gLVtE66jguUtO/vW1Zs60BVjucpCzRNx+YDXXxWh8YIGbVY1OamMy8tCSQis3KndDKLuQ0fXdCOl/2mVZup392u4p+R806tqHcg+zDKDDQl8HWkqk3n606bOVaB9DwbeGPojzrPlufvd510MWGTAzZjHx2Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753859069; c=relaxed/simple;
	bh=hRRwxJjQE9wJHAhuatc6RMPSyGgs/xP53hoMSHC/2FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npO+xs0uamom6kz8omSeqBaPWlP3RFOn5sCAWZ/ZBjtiPBx2pGC1H63amckPeLldchdI1aeHsSwl9z4+HSvEBB23AbFvQSdFdOpFjWdSyHkJiVNv4uCJO42wS35F455ORNfyw1pBffg6t9ojlKRYwGtT1p90jiPGWhvlhXUW8NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d+FizXXU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753859068; x=1785395068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hRRwxJjQE9wJHAhuatc6RMPSyGgs/xP53hoMSHC/2FU=;
  b=d+FizXXUMwXt4JoZecJEYSTDfklMiN8MMtEkszEOlhIY5i7SHotKc2Wj
   PpzTIR8FpbS96JQ7MOolvunHpUNeCs89NPFFYUO8cuc/SDGWqF5IOlNBr
   3Yhg0XWQQx9xHSxXHACrEMsCJUr8nD1/WirBbvLF8DTLl6ATZVvugCwlZ
   tjVWGS000pC7RBgINpKnTquuFYjMIy/uLZfjTiuTuDdbmUmILMP2rm6Ux
   Eozdxz9hjSghUjyi6iHtIGZZwGapPhe7xpWslmbfhUURtsVwgTaGzMiCB
   40/J3qgoU4exxAFdp+nNSgYrwT/P0Ids5ciaY65Gp63zKWOETqb7PkIBa
   g==;
X-CSE-ConnectionGUID: W/vh5BJvS+m/1mPTgz1kUw==
X-CSE-MsgGUID: Lumic/dFTwiPB+kPEUA2Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="56229392"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56229392"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 00:04:24 -0700
X-CSE-ConnectionGUID: gxhRvuheTAG+uvZ6+T69iw==
X-CSE-MsgGUID: kU6LqtksTKK5o0weRmGeTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="167122521"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 30 Jul 2025 00:04:21 -0700
Date: Wed, 30 Jul 2025 14:55:02 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 06/38] iommufd: Add and option to request for bar
 mapping with IORESOURCE_EXCLUSIVE
Message-ID: <aInBxnVIu+lnkzlV@yilunxu-OptiPlex-7050>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-7-aneesh.kumar@kernel.org>
 <20250728140841.GA26511@ziepe.ca>
 <yq5a34afbdtl.fsf@kernel.org>
 <20250729142917.GF26511@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250729142917.GF26511@ziepe.ca>

On Tue, Jul 29, 2025 at 11:29:17AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 29, 2025 at 01:58:54PM +0530, Aneesh Kumar K.V wrote:
> > Jason Gunthorpe <jgg@ziepe.ca> writes:
> > 
> > > On Mon, Jul 28, 2025 at 07:21:43PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > >> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > >
> > > Why would we need this?
> > >
> > > I can sort of understand why Intel would need it due to their issues
> > > with MCE, but ARM shouldn't care either way, should it?
> > >
> > > But also why is it an iommufd option? That doesn't seem right..
> > >
> > > Jason
> > 
> > This is based on our previous discussion https://lore.kernel.org/all/20250606120919.GH19710@nvidia.com
> 
> I suggested a global option, this is a per-device option, and that
> especially seems wrong for iommufd. If it is per-device that is vfio,

I think this should be per-device. The original purpose of this
pci_region_request_*() is to prevent further mmap/read/write against
a vfio_cdev FD which would be used for private assignment. You shouldn't
prevent all other devices from working with userspace APPs (e.g. DPDK)
if there is one private assignment in system.

> if it is global then vfio can pick it up during the early phases of
> opening the device.
> 
> > IIUC, we intend to request the resource in exclusive mode for secure
> > guests—regardless of whether the platform is Intel or ARM. Could you
> > help clarify the MCE issue observed on Intel platforms in this context?
> 
> As I understand it Intel MCEs if the non-secure side ever reads from
> secure'd address space. So there is alot of emphasis there to ensure

Yeah, Intel TDX doesn't have a lower access control table for CC. So if
host reads, the TLP sends and MCE happens.

Thanks,
Yilun

> there are no CPU mappings.
> 
> Jason

