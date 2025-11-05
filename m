Return-Path: <linux-pci+bounces-40339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73983C351B7
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 11:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307D43B10EE
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 10:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DB42FE56B;
	Wed,  5 Nov 2025 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FW5Q11Sr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C671EA7FF
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338784; cv=none; b=oAwljlziu6moXgD/WamB/upmBBQRehRVzGKbq7+xiFEeR4rTtuNDE1pPu29fyei4IqCe5IDx9fq0jV8qi1GIdp61wck5K2ID3c4URgsLQsiZcjD3Ejn4UAUSOCwg6lVpCdGejGVWoGsz1ER3eKNQRknFFeELVI6fw7CUopbDp3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338784; c=relaxed/simple;
	bh=+EtThdPOzwQUh3qUX+JgJuFEHzFIktQ75GUsI6ddgiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZyQwUh96b+Ke5m955WFEHR37wyRcyjKpHXOjerKwCqavMpbzP59VXlaNDvw6CrWLYGqR8lYgQDL4K/h9JN32B1v0bhEGED9occdT3Zu2AA0rpdRBleRqaD9vv4Gsm3SsIZ1k9vOK5vRgBac7VHbXlYBRQ8zvkl6FYHgAH7yZdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FW5Q11Sr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762338783; x=1793874783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+EtThdPOzwQUh3qUX+JgJuFEHzFIktQ75GUsI6ddgiQ=;
  b=FW5Q11SrOzJoGW2zbDYOlzGit/zpywu3vhWo+z8NEjyfdrX9Cbm4aGpw
   CVGiW+Wunj/BN5K35/9XVIgrrV3/MhyReKjHFdLZnq3/uLGKnAo5hpWNu
   S+MOquD62QxDAdaRhT3/9xfokRs1pyp7dH0AWMzHqhChpjwH9tC5RMmSG
   VPrBVXOkYLcT6PV91QGeGxcZGNevITl1cFBXWUf80nrkddtuktmrwPUo4
   j5m/79C1b0T2jIHbHdIxLfrce1TOLk2sXdcE53UT4NdZUZUyxZ8h9bSQw
   4BmeIozVeZYQ9E+0uHQOqLbzx8ObSESqdKbm/kGlL3gXCBzheLtThfOee
   g==;
X-CSE-ConnectionGUID: o/MK+kjiReaqdgqAKeAt6w==
X-CSE-MsgGUID: pW/i38+WQsapUXMHBK8H0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64144996"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="64144996"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 02:33:02 -0800
X-CSE-ConnectionGUID: PrL81p3+S5aEyswk++wB/w==
X-CSE-MsgGUID: B1sNgTpjSd+tgyiDiaxIqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="224666100"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2025 02:33:01 -0800
Date: Wed, 5 Nov 2025 18:18:52 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, xin@zytor.com, chao.gao@intel.com,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [RFC PATCH 11/27] acpi: Add KEYP Key Configuration Unit parsing
Message-ID: <aQskjKRlE4dj39un@yilunxu-OptiPlex-7050>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
 <20250919142237.418648-12-dan.j.williams@intel.com>
 <20251030110251.00002b03@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030110251.00002b03@huawei.com>

On Thu, Oct 30, 2025 at 11:02:51AM +0000, Jonathan Cameron wrote:
> On Fri, 19 Sep 2025 07:22:20 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > From: Dave Jiang <dave.jiang@intel.com>
> > 
> > Parse the KEYP Key Configuration Units (KCU), to decide the max IDE
> > streams supported for each host bridge.
> > 
> > The KEYP table points to a number of KCU structures that each associates
> > with a list of root ports (RP) via segment, bus, and devfn. Sanity check
> > the KEYP table, ensure all RPs listed for each KCU are included in one
> > host bridge. Then extact the max IDE streams supported to
> > pci_host_bridge via pci_ide_init_nr_streams().
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > [djbw: todo: find a better place for this than common host-bridge init]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Generally all this ACPI code looks fine (up to the TODOs Dan has called out)
> One trivial thing below
> 
> > diff --git a/drivers/acpi/x86/keyp.c b/drivers/acpi/x86/keyp.c
> > new file mode 100644
> > index 000000000000..99680f1edff7
> > --- /dev/null
> > +++ b/drivers/acpi/x86/keyp.c
> 
> > +static bool keyp_info_match(struct acpi_keyp_rp_info *rp,
> > +			    struct keyp_hb_info *hb)
> > +{
> > +	if (rp->segment != hb->segment)
> > +		return false;
> > +
> > +	if (rp->bus >= hb->bus_start && rp->bus <= hb->bus_end)
> > +		return true;
> If you are going to not use the simple pattern for matching that
> would have this inverted so we only match if we pass all checks
> might as well do
> 	return rp->bus >= hb->bus_start && rp->bus <= hb->bus_end;

OK, let's use the pattern for all:

	return rp->segment == hb->segment && rp->bus >= hb->bus_start &&
	       rp->bus <= hb->bus_end;

> 
> 
> > +
> > +	return false;
> > +}

