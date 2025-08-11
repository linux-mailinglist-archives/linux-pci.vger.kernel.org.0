Return-Path: <linux-pci+bounces-33688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6B4B1FE80
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 07:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BC23B0886
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 05:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8AB263C9F;
	Mon, 11 Aug 2025 05:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCCLQX8Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049091C07C4;
	Mon, 11 Aug 2025 05:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754889961; cv=none; b=EDYO3nMp1qyGvDdGCrJR5yQOKWotoRoh6Ouel7hskYEFgVU8Iim/D8q/A5WR0uqcicndnnTWVdGX1L0o+pho0xWqwdoQ5siyBpyCWmcbTTvTDqnJik1Xmv4IRHvDX02Kcb1sAqSLnpQuS6Xwt93/8ru648CIyar/04BmbTaE1Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754889961; c=relaxed/simple;
	bh=gEKVH43a1VlYIav599dvZjUBUDVcCJDUOzKldTsJvM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2/s7Eupr0mWwUfS3rn7i+08aE3N85M2LCO1/C1I2HMvUC7Rlu3OL1B+Lhv419RQoAVKCUwDRU/gCyoVzKw3jCEhlFizBRBN/Apd8eTmwT6ajwYqKxloABWrNqd5LXVwESvwqc6b0VbtDFiPfhvLjBhoKssU7qN0NRvhfORlxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCCLQX8Z; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754889960; x=1786425960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gEKVH43a1VlYIav599dvZjUBUDVcCJDUOzKldTsJvM0=;
  b=MCCLQX8ZIjtMdQ3v5h0P+7dlxaJLQQ6pV81A8H2nXEEpfzAIiFkXAT+P
   MN2bGInwqy9j3YJ3XRTJlgBZ5ARVpwDM+7wSaYE6bg/c1xF1H5gBobkER
   mlXbLeOK8ZL2M5kOqgzjxzU1YXEiSc+/F27HnPaOGreIHMyB8ge5ugs7Q
   vi8g0D9HGDMQCKogp1m1hYMl2PozDWSDMmWHK4PXYtM0sulxztoofZQUw
   v3rwzK2e7xA5TVr5Xn+GdrdsnHVTMQVrXKUMo5Cf+7om1wxjg4AG0lWY6
   D6byZp5GiDnJIuOVliyVOWpPpDAcDZ1KA5fUc2c9HR0Yzu4oHRaLTtkyV
   A==;
X-CSE-ConnectionGUID: jbSnxtoITr+wWSeNSsyhDQ==
X-CSE-MsgGUID: KRRsEgfdR+KgvBFU7js3Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57214978"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57214978"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 22:26:00 -0700
X-CSE-ConnectionGUID: wB7bb9+nTWieHSYhDlS3OQ==
X-CSE-MsgGUID: w99MNDdvRSuqBqcCEzDBZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="196655949"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 10 Aug 2025 22:25:57 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id F14B393; Mon, 11 Aug 2025 07:25:55 +0200 (CEST)
Date: Mon, 11 Aug 2025 07:25:55 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Mario Limonciello <superm1@kernel.org>,
	"Rangoju, Raju" <raju.rangoju@amd.com>, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	andreas.noever@gmail.com, michael.jamet@intel.com,
	westeri@kernel.org, YehezkelShB@gmail.com, bhelgaas@google.com,
	Sanath.S@amd.com
Subject: Re: [PATCH 0/3] thunderbolt: Update XDomain vendor properties
 dynamically
Message-ID: <20250811052555.GQ476609@black.igk.intel.com>
References: <20250806150024.GF476609@black.igk.intel.com>
 <2025080628-viral-untruth-4811@gregkh>
 <20250807051533.GG476609@black.igk.intel.com>
 <2025080758-supervise-craftily-9b7f@gregkh>
 <17ed42fe-9d8d-46da-8434-f508ec5932fa@kernel.org>
 <20250808044538.GK476609@black.igk.intel.com>
 <2025080822-cardboard-aloha-3c5d@gregkh>
 <20250808091313.GN476609@black.igk.intel.com>
 <2025080832-poker-rectal-0895@gregkh>
 <20250811045307.GP476609@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250811045307.GP476609@black.igk.intel.com>

On Mon, Aug 11, 2025 at 06:53:07AM +0200, Mika Westerberg wrote:
> On Fri, Aug 08, 2025 at 04:13:28PM +0100, Greg KH wrote:
> > > 0004 USB4
> > > 
> > > sounds good to me. In USB4 there is no "root hub". It's called host router
> > > (but we do have device routers that are called USB4 hubs for added
> > > confusion ;-).
> > > 
> > > But I'm fine with other numbers too, does not matter if you want to save it
> > > for some future USB variant.
> > 
> > Ok, use 0004 for this.  But what should I use for the text string here
> > in the usb.ids file?
> 
> Thanks! I'll cook up a patch changing these.
> 
> I don't think it should be in usb.ids because it is not visible anywhere
> except over USB4 link (between hosts). You don't see this through USB 2.x
> or 3.x.

Of course for documentation purposes it could be:

    0004 Linux USB4 Connection Manager

