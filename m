Return-Path: <linux-pci+bounces-38384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FF0BE4E99
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 19:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368F61A62ECB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00DC3346AA;
	Thu, 16 Oct 2025 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BaHEvFRn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965E3346B7
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636763; cv=none; b=fbMYjFsy0D7e/OolCKKIXzNc4xeCGLCIopxlBkhdNum4pDlslaOx8iCy9yIo4urzil6XSPlW8VjgcgSR1dCRR3A7t+XL644wAagMcGyWyOIdv8mB33XcjvJCnTyusU0HuZWK/BKPG+nRwjQrv8E/0ittfs3kOdtEG105qxm12wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636763; c=relaxed/simple;
	bh=nN0jfqUgFwh0E12jjH+hjzZ78vXZRT3xrRDVlgThzEM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uy4IwFisM0yyZLQDtFEYAYc0lh9d5Im0O4kJVQxlS4K1iGzZZnyl9iKmyXkHWBX747e7sOStGUy7qvqL6aCKokaKMC2vIJTUsFfPcqSJhCDkef9DL3lFm7HmjT+HsaBeV/pLF49LvhA/ETGh9Fk6576Ph/OCsM38aKLbf7aYwSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BaHEvFRn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760636762; x=1792172762;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nN0jfqUgFwh0E12jjH+hjzZ78vXZRT3xrRDVlgThzEM=;
  b=BaHEvFRnLlI7iY0TTMnzHjpGDjTcrY9CKj61AXhIkj3mcnvQjdRqkoL4
   dNCaoRGyjdYF2oMY2w12WMdm9V6NhzHZK96vG9cqmAvLIWLNmtAYZwT/4
   yIBLAKCk1LJ+bmN8RfK0FNrmn4GXTDW0gMeFM/ELU1NJ4kM+Owj6mt1xc
   cZn6wgUTRiZmZpZ/uU5I+UrjXg7B9BUpXbddbtDeoAz/56S+fLB7k83Tb
   48yk/Da4O8DjfLGc6sBNcWHhEPZ821iOROPQr8ZHv1DdL+T9f/WX+UwfL
   hXnOCFtWE/NSpDScqad72WbKkEyz0oSh2M+lm3OT7dnsnMezhADIkJJi/
   w==;
X-CSE-ConnectionGUID: iYRcyrqLRzSpQOf1JhSCtQ==
X-CSE-MsgGUID: ThiHu+tOQGGH5Ss0P0LztA==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="66705831"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="66705831"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 10:46:01 -0700
X-CSE-ConnectionGUID: UFZI73kESQK3bOQDhnXE9A==
X-CSE-MsgGUID: b9vlIJ58Qee3ybn8VnmVUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="186536035"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.242])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 10:46:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 16 Oct 2025 20:45:55 +0300 (EEST)
To: Mario Limonciello <superm1@kernel.org>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    kernel test robot <lkp@intel.com>
Subject: Re: [pci:for-linus] BUILD REGRESSION
 f0bfeb2c51e44bee7876f2a0eda3518bd2c30a01
In-Reply-To: <bdee889f-b154-4532-ba8d-ae5910ce1613@kernel.org>
Message-ID: <e31f6ac5-ebb6-9989-60ac-014054f1fd73@linux.intel.com>
References: <20251016162854.GA988737@bhelgaas> <bdee889f-b154-4532-ba8d-ae5910ce1613@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 16 Oct 2025, Mario Limonciello wrote:

> On 10/16/25 11:28 AM, Bjorn Helgaas wrote:
> > On Thu, Oct 16, 2025 at 11:18:38AM -0500, Mario Limonciello wrote:
> > > On 10/16/25 11:15 AM, Bjorn Helgaas wrote:
> > > > On Thu, Oct 16, 2025 at 07:26:50AM +0800, kernel test robot wrote:
> > > > > tree/branch:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
> > > > > branch HEAD: f0bfeb2c51e44bee7876f2a0eda3518bd2c30a01  PCI/VGA: Select
> > > > > SCREEN_INFO on X86
> > > > 
> > > > Just making sure you've seen this, Mario.
> > > 
> > > I didn't see this, thanks for including me.
> > > 
> > > > I *think* f0bfeb2c51e4 is
> > > > the most recent version, and it was on pci/for-linus, so I'll drop it
> > > > for now.
> > > 
> > > Are you sure the failure is caused by "PCI/VGA: Select SCREEN_INFO on
> > > X86"?
> > 
> > I'm not sure.  I looked briefly for a more detailed report but didn't
> > find it.  Maybe didn't look hard enough.  This email seems like a
> > summary that could possibly have included a link to details.
> 
> I looked at https://lore.kernel.org/oe-kbuild-all/ and don't see one there
> either.
> 
> I think you should keep the patch in.  As it pertains to arch specific stuff
> it behaves identically to pre-337bf13aa9dda.
> 
> If I'm wrong and there is actually still a problem we'll get more build robot
> reports as they come.
> 
> > 
> > > I wouldn't expect the below error to be:
> > > 
> > > > 
> > > > > Error/Warning ids grouped by kconfigs:
> > > > > 
> > > > > recent_errors
> > > > > `-- mips-allyesconfig
> > > > >       |--
> > > > > (.head.text):relocation-truncated-to-fit:R_MIPS_26-against-kernel_entry
> > > > >       `--
> > > > > (.ref.text):relocation-truncated-to-fit:R_MIPS_26-against-start_secondary

Looks unrelated to me. These "summary" reports from lkp often contain 
unrelated errors, I think there's even mention about it somewhere in 
the report text (probably before the part which was quoted to the list).

-- 
 i.


