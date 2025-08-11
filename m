Return-Path: <linux-pci+bounces-33687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD84B1FE66
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 06:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF4B174A96
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 04:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA63A26ACC;
	Mon, 11 Aug 2025 04:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/CGLgBu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D0D2E3718;
	Mon, 11 Aug 2025 04:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754887993; cv=none; b=ta8Sl6qSg5JMD0UAbCXNA3rTTYoj+yGoSgoraO1fe+u4/n+aHT0IIjoJyvnVcNR11+dVjbU+8rA+gKX2PD9G7nS/G/2Ef5U4PWSYeA+DIhinhzJnFvKZ3lj9J46Q9OlhgJGq2gpGHodPkw5VNt+rSa1A7cjCo9pT7kkXYO2SKYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754887993; c=relaxed/simple;
	bh=HO0oNAMkfEi2kNTMoc0ydmEDe5SVeowcPK8qazv9hM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4Qpd9XsO950eMZGa1syA3q0wMUubO1zy2uYYe/XDvtzbK3bgnPTPFo9V8FfSnLMwsO2umBsgl5IVPivHshbNqpzwrPI1Y3lgwGBGNgp0wgT4rRVxjkp4JAith/Luwoj2oyEsg6f3+oGKtkXwMCfCmadY4ptOHG6PSFXc2mj0Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/CGLgBu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754887992; x=1786423992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HO0oNAMkfEi2kNTMoc0ydmEDe5SVeowcPK8qazv9hM8=;
  b=f/CGLgBupHMyO6JRYtqrVnfctN5vY0J9OqPQnYIZL3d9epCJoHXzMF6n
   ZRn3okWJ5abEq/d1+r47mnkMoa/LVoHNnevBYl4AZWu21InQ3hgiKFIkd
   c9v+3wmiMFqCOWOS3k9tKIVFGJTppi+I6qesQelGD8En1F5f8OVHY4Kpq
   0aRng/QC6cBwZu8m4RatfwND9s2LPY92AlDfQ8S3mfs3lDh+wa2PeUk7/
   5HIrdomQGebv5wCZqDhxUaXUplR0c8sgmDDaDqUzfFhlERucUOiVjgoJy
   RaZfMXFkaHAeHYd4QXPS3vFsqmhOftBux/zGGnHmMQc8GSUXeGAbT9QKk
   A==;
X-CSE-ConnectionGUID: nkGbI+P9Te2B2Bu/FgYhPA==
X-CSE-MsgGUID: 6nGj2TVDT/mvvPISQ5ctug==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68586914"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68586914"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 21:53:12 -0700
X-CSE-ConnectionGUID: ltxTGHxpT+SFoXS5VwXS1Q==
X-CSE-MsgGUID: Zv8SNUE4QySqgnhz+/RAMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165810117"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 10 Aug 2025 21:53:09 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id B6F0493; Mon, 11 Aug 2025 06:53:07 +0200 (CEST)
Date: Mon, 11 Aug 2025 06:53:07 +0200
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
Message-ID: <20250811045307.GP476609@black.igk.intel.com>
References: <9a757d21-a6e0-4022-b844-57c91323af5e@kernel.org>
 <20250806150024.GF476609@black.igk.intel.com>
 <2025080628-viral-untruth-4811@gregkh>
 <20250807051533.GG476609@black.igk.intel.com>
 <2025080758-supervise-craftily-9b7f@gregkh>
 <17ed42fe-9d8d-46da-8434-f508ec5932fa@kernel.org>
 <20250808044538.GK476609@black.igk.intel.com>
 <2025080822-cardboard-aloha-3c5d@gregkh>
 <20250808091313.GN476609@black.igk.intel.com>
 <2025080832-poker-rectal-0895@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025080832-poker-rectal-0895@gregkh>

On Fri, Aug 08, 2025 at 04:13:28PM +0100, Greg KH wrote:
> > 0004 USB4
> > 
> > sounds good to me. In USB4 there is no "root hub". It's called host router
> > (but we do have device routers that are called USB4 hubs for added
> > confusion ;-).
> > 
> > But I'm fine with other numbers too, does not matter if you want to save it
> > for some future USB variant.
> 
> Ok, use 0004 for this.  But what should I use for the text string here
> in the usb.ids file?

Thanks! I'll cook up a patch changing these.

I don't think it should be in usb.ids because it is not visible anywhere
except over USB4 link (between hosts). You don't see this through USB 2.x
or 3.x.

