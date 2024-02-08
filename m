Return-Path: <linux-pci+bounces-3238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E3B84E4D3
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 17:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56DF51C2198D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 16:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2041B7D416;
	Thu,  8 Feb 2024 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVl7+5ot"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A7B7D410;
	Thu,  8 Feb 2024 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409002; cv=none; b=fBzE2kkaib15dS0VB7ya6I281i0hpaeFuFr86ATvsCjfoziyfKgd9hAfQCnAcX3BDkFbNmb9077fLOzNYeMKhFcT30lAc0y4yKiroVRpfaIzKIvAt8u+YwDiBHdkgHnK1GDwwm5AWJRPh0pRQzPdDLJrOPmtYnXQQJBvNl/q/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409002; c=relaxed/simple;
	bh=vNcKCC/VYDlVMZCuvfjdsv4qWjl8OrFT+5tYxsr8d0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWHGBh7iOxLulokpEvrx60+ZgddYSA7DZU3bGXRhJ1VZpPJGH9wiv81bJR6bqyf0uSj2JzDOh39mODTiHkJdyk7is7DFoowN7AY86t1OpdlSzGp5TZqNm5uc4vgUhS9wE04GkGP4fkjiO/oz1MWpYlU9S4/xD6/r9RSYGplcCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVl7+5ot; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707409000; x=1738945000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vNcKCC/VYDlVMZCuvfjdsv4qWjl8OrFT+5tYxsr8d0s=;
  b=UVl7+5otIv9dKKz90kyxyjlHIOXEub9cTjL3y84IcjLqzbV9la8QIu35
   VrJ13MCZtwwVTVDMMp9TDynRNQ0GxMKhZ3Rq9rBuPyusKTY7Ldp1/VAk8
   6Z+Mv8O0FTkPQ0fWvrRJofRZi21WZVRCoRJF5hxiJ74SJMfpmMGdvpokp
   /U7r/lWuAvgm8BPcKRWVg5cwArboRWAUUvdK1z3MLU3GooK6axlS1eOaO
   oqQFhyi3Ar2HKbeuglYTaBsPk4FPGlm0oGUhVc5j2TsvZoZqMaqukARH+
   v2fAndB+KkkkA/FYXi9QAHs4FYDP8PvyDRBQEibiUcLpyk9sXgt9Ripdd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1115673"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1115673"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:16:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="24927005"
Received: from zhushaoj-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.169.162])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:16:32 -0800
Date: Fri, 9 Feb 2024 00:16:23 +0800
From: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-acpi@vger.kernel.org, chao.p.peng@linux.intel.com, erwin.tsaur@intel.com, 
	feiting.wanyan@intel.com, qingshun.wang@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, 
	Adam Preble <adam.c.preble@intel.com>, Li Yang <leoyang.li@nxp.com>, Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
	Robert Richter <rrichter@amd.com>, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI/AER: Store more information in aer_err_info
Message-ID: <vc67zlmqs46fx2iqjqlpvju5dzpdvqkmydpebecgcaxjivlmu5@ksu4c2g7qqig>
References: <2rfnevhnhylik4r6smr56uunsxweo7s5elo65sjhiztvxnr6bq@5fcyv22zxyyp>
 <20240206172335.GA872811@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206172335.GA872811@bhelgaas>

On Tue, Feb 06, 2024 at 11:23:35AM -0600, Bjorn Helgaas wrote:
> On Wed, Feb 07, 2024 at 12:41:41AM +0800, Wang, Qingshun wrote:
> > On Mon, Feb 05, 2024 at 05:12:31PM -0600, Bjorn Helgaas wrote:
> > > On Thu, Jan 25, 2024 at 02:27:59PM +0800, Wang, Qingshun wrote:
> > > > When Advisory Non-Fatal errors are raised, both correctable and
> > > > uncorrectable error statuses will be set. The current kernel code cannot
> > > > store both statuses at the same time, thus failing to handle ANFE properly.
> > > > In addition, to avoid clearing UEs that are not ANFE by accident, UE
> > > > severity and Device Status also need to be recorded: any fatal UE cannot
> > > > be ANFE, and if Fatal/Non-Fatal Error Detected is set in Device Status, do
> > > > not take any assumption and let UE handler to clear UE status.
> > > > 
> > > > Store status and mask of both correctable and uncorrectable errors in
> > > > aer_err_info. The severity of UEs and the values of the Device Status
> > > > register are also recorded, which will be used to determine UEs that should
> > > > be handled by the ANFE handler. Refactor the rest of the code to use
> > > > cor/uncor_status and cor/uncor_mask fields instead of status and mask
> > > > fields.
> > > 
> > > There's a lot going on in this patch.  Could it possibly be split up a
> > > bit, e.g., first tease apart aer_err_info.status/.mask into
> > > .cor_status/mask and .uncor_status/mask, then add .uncor_severity,
> > > then add the device_status bit separately?  If it could be split up, I
> > > think the ANFE case would be easier to see.
> > 
> > Thanks for the feedback! Will split it up into two pacthes in the next
> > version.
> 
> Or even three:
> 
>   1) tease apart aer_err_info.status/.mask into .cor_status/mask and
>      .uncor_status/mask
> 
>   2) add .uncor_severity
> 
>   3) add device_status
> 
> Looking at this again, I'm a little confused about 2) and 3).  I see
> the new read of PCI_ERR_UNCOR_SEVER into .uncor_severity, but there's
> no actual *use* of it.
> 
> Same for 3), I see the new read of PCI_EXP_DEVSTA, but AFAICS there's
> no use of that value.
> 

Both 2) and 3) are used in PATCH 2 and traced in PATCH 4. I can separate
the logic for reading these values from PATCH 1 and merge it with PATCH
2.

--
Best regards,
Wang, Qingshun

