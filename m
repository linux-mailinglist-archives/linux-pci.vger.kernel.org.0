Return-Path: <linux-pci+bounces-44277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40250D028E5
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 13:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EC94308277D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 12:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412844AACE8;
	Thu,  8 Jan 2026 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="auB9IHJS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6F494A02;
	Thu,  8 Jan 2026 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872231; cv=none; b=Dit93rHEdvrFW33yf5g0Mv49ri8m0rqdvG01U3hbALmfXrESRL46EPqD8mXWOx1jtBCJDEh8kZlArIYBPsSmKS96K+mUSNGxjTzNhEutdyY2ZCaUXPNeHB/Yp/LB4y8ldaj3lS5NVC2bxjUVHWSqmkKj+KUzQR8KkefJ9eEmi+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872231; c=relaxed/simple;
	bh=jzdYEgrzzEHAbsKGK1TfXPqFuiXDJDpoPhLR/Fd2ZG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qh+ECUj+zhELPUQooaVvxMPA2YTW+OtZMZB68ajqBDufHHXded8T9NWHz70DeYMjt8gybEa+gBk+NTvD6II6/sxe23BwDikLeA5u80fnE0w3qq7lWWvgwplL+VFkDqveXUId7212EMt6eXMkt7feCBCsPK3UOqum9kD0W+pAr04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=auB9IHJS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767872228; x=1799408228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jzdYEgrzzEHAbsKGK1TfXPqFuiXDJDpoPhLR/Fd2ZG4=;
  b=auB9IHJSHXNnfJy5qTrU8d7GOIP9/kYoYqFw9s0CZNPQGOuULIdlcBPj
   idcHuxqZKN7tz+O3qLrosa+VsSEYau631F4Zll7ADt9+Sc7JqdIYr7NuQ
   REIJCHMIg8mysTVEO6lWJ55DwX0s8m46Jxnmt7bP1AudCvIkhoF7j/WEm
   f+viUkm+7cSNOum9dwNzPsn5D5LUlK7gxiuJdDOu2hJV28NwrTE+p7ECR
   9+cUG3fhXCJy7gj+E0c6BfTvDV0xj79NG6Fb05Q75T8NZFXLR44sICPLG
   QzYWSg2rUaRko8Lua2iF3AVAny44+Gm1x22+gnTHVnW+Bllc20w+BD4iV
   Q==;
X-CSE-ConnectionGUID: 6Dk6GncNT1CubNipDn7BIQ==
X-CSE-MsgGUID: Z6Nyuv/1Qwej/BZ9u0Hg3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="79547977"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="79547977"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 03:37:06 -0800
X-CSE-ConnectionGUID: S2N2NM28S9ikmBT4twszjA==
X-CSE-MsgGUID: 1TBz1duORRyaggZDd90VpA==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 08 Jan 2026 03:37:02 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 6C40898; Thu, 08 Jan 2026 12:37:01 +0100 (CET)
Date: Thu, 8 Jan 2026 12:37:01 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: YehezkelShB@gmail.com, andreas.noever@gmail.com, bhelgaas@google.com,
	bp@alien8.de, dave.hansen@linux.intel.com,
	feng.tang@linux.alibaba.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de, mahesh@linux.ibm.com, mingo@redhat.com,
	oohall@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	tglx@linutronix.de, westeri@kernel.org, x86@kernel.org
Subject: Re: [PATCH v4] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Message-ID: <20260108113701.GR2275908@black.igk.intel.com>
References: <20260108095303.GQ2275908@black.igk.intel.com>
 <20260108103358.3412-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108103358.3412-1-atharvatiwarilinuxdev@gmail.com>

On Thu, Jan 08, 2026 at 10:33:58AM +0000, Atharva Tiwari wrote:
> I am using a SD-card reader in the thunderbolt port (usb-c)

Okay, so regular USB 3.x device not a USB4/TB.

> Unfoutunatly my linux install got bricked because of macOS update,
> so i cant provide dmesg, but i have lspci saved on macOS:

I saw that in the bugzilla too but it is missing the capabilities (that's
why I asked 'sudo lspci -vv' output so it also dumps the capabilities and
hopefully sheds some light why the AER message flood happens).

