Return-Path: <linux-pci+bounces-3168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B560D84BB2E
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 17:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412DE289C29
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 16:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285E12CA7;
	Tue,  6 Feb 2024 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qmzpn5pk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BCC6FA9;
	Tue,  6 Feb 2024 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237719; cv=none; b=PLUn9qKw7xzewCmJWp9Jl8viebUXZqKo40i+YQocB0i2Whqxl9K2mQlGL1tkLt1YWBtYUgX5I6MGOmZOpaHqAvRmCIX+kxO5Y6lLhAQgg+8ZMhVx12IJn5ZshTnZGHDGtQ18kuW2WawO9aL0lYPL/L6d/S9iE/qh7WI6jSwOAq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237719; c=relaxed/simple;
	bh=rRNlDDubtypf416CZLetd6q9gBTbLbGyegrQgkQerDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqcfC/MibPEAkftQqmPEj2mEcoRbpW1UIse+8OMTOqOMrsDOMTqKl759jcgr3+XrKP1CUi+FR6/difDhhcABWcpe9j8EDc04g9xg7VIJUU598ANeaiZ1VFFbyd+WRP1oTy6SbNcqo65TQ2Bf0DyT10umLDPoIRlcppnPJVPvXWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qmzpn5pk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707237718; x=1738773718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rRNlDDubtypf416CZLetd6q9gBTbLbGyegrQgkQerDE=;
  b=Qmzpn5pkmHrBxj1x8SRX+1gMJwP7cK3Erf6mFFDnKbXIKSjMluSoLojA
   LUejvNaaFirzqB2BHHT8On/4PZLe/EonVCd1gtqm/b/n5iwT0As137igm
   M7V/gaubYEg6AjM4mi+jOHMaWUohFuN1wbZfel+NdXCvw22P5l6q+AGAa
   OKWS0tG80PDE+/RWdOO4/bWAHIFuplNaK/luwLZGYjfwAtLwb+yf5h4UG
   y7Sx2B+QWVc7RbxkeH0TmYeDR8IZ35gOtfaSTsw6vBAtc+N6UT4Mi20HV
   VLG6pH+XkTJfLQcKFf5str5sTTnzeyJdcqsy+JzYPU84SYCiQhWszW9oT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="18304899"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="18304899"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:41:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1357592"
Received: from jingjing-mobl1.ccr.corp.intel.com (HELO localhost) ([10.254.215.110])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:41:49 -0800
Date: Wed, 7 Feb 2024 00:41:41 +0800
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
Message-ID: <2rfnevhnhylik4r6smr56uunsxweo7s5elo65sjhiztvxnr6bq@5fcyv22zxyyp>
References: <20240125062802.50819-2-qingshun.wang@linux.intel.com>
 <20240205231231.GA830643@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205231231.GA830643@bhelgaas>

On Mon, Feb 05, 2024 at 05:12:31PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 25, 2024 at 02:27:59PM +0800, Wang, Qingshun wrote:
> > When Advisory Non-Fatal errors are raised, both correctable and
> > uncorrectable error statuses will be set. The current kernel code cannot
> > store both statuses at the same time, thus failing to handle ANFE properly.
> > In addition, to avoid clearing UEs that are not ANFE by accident, UE
> > severity and Device Status also need to be recorded: any fatal UE cannot
> > be ANFE, and if Fatal/Non-Fatal Error Detected is set in Device Status, do
> > not take any assumption and let UE handler to clear UE status.
> > 
> > Store status and mask of both correctable and uncorrectable errors in
> > aer_err_info. The severity of UEs and the values of the Device Status
> > register are also recorded, which will be used to determine UEs that should
> > be handled by the ANFE handler. Refactor the rest of the code to use
> > cor/uncor_status and cor/uncor_mask fields instead of status and mask
> > fields.
> 
> There's a lot going on in this patch.  Could it possibly be split up a
> bit, e.g., first tease apart aer_err_info.status/.mask into
> .cor_status/mask and .uncor_status/mask, then add .uncor_severity,
> then add the device_status bit separately?  If it could be split up, I
> think the ANFE case would be easier to see.
> 
> Thanks a lot for working on this area!
> 
> Bjorn

Thanks for the feedback! Will split it up into two pacthes in the next
version.

--
Best regards,
Wang, Qingshun

