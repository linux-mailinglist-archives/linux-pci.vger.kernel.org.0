Return-Path: <linux-pci+bounces-38795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7220BF2FCD
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 20:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DE63BDD78
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 18:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEEB2D3732;
	Mon, 20 Oct 2025 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GUAtOGPW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6A13C3CD;
	Mon, 20 Oct 2025 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760985986; cv=none; b=sjLlNLGCK39VqZTxASjdLwMQ0n08NmBFc969D9jRPBtlwEdF0K2CZvv+uZHM61ZDY8+k4HBHJxY8Pc6+LQtwXM8YINB/sm3zWk7cyRPD3uq54ne893D66zcWFWFbeqdL+vabgnBkrNoXiPeVBHEHV6qP5FWONENUmh6FNZ2GJak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760985986; c=relaxed/simple;
	bh=vNPmbqR8QfW6+ZVYfTbhb4OdfBX+SCZXk52NZ5Rt700=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VCrpzUgrNxFSmlGUdgWWL8aCA9GxXhvIt0ck8J1GdolSim3tRm/sd1VaIM4Nul1jkVUTWsEoL9t3c+25wpq0O1koUVtPyZkwayN//qqSDZVJblZMMhQMGhSOZ6xu5S7tSP60DKbzfBB1GYtXPmhpRawPL11XocRWypuuFfwWs/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GUAtOGPW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760985984; x=1792521984;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vNPmbqR8QfW6+ZVYfTbhb4OdfBX+SCZXk52NZ5Rt700=;
  b=GUAtOGPWioS470Vza3GDlk2jRmfvlcXQt3TVHBD8dZ5wVJgaA7lShwbU
   feUCh583I8Ak6IHU0Ntp72HG8vwAMXoqf/sYLfFoDyYeJodgU/5uEE1Fh
   8YqQl9S+pTWQ0o8Xiws1TFr8HUXtzhLURqHIkRsiT4WcVw9HfjybSzK3m
   9uC5vpzAvLFGwFKpSm1cfHmfS+q9plhjTyMFertL6uA47Ss5KyyMmD2sw
   7B2Y3ce721UvYEXUj6Q1zw14t/01T27u7Tau27iCx2YPV7b+m8KamtorC
   hmthm7YSK9dblTpHP7qK0fGURzVY2Zl0IeddEHpuJlnPYtD/NWzSltQUn
   A==;
X-CSE-ConnectionGUID: 5oKk0W3XQ5qDHPVtmfQgfg==
X-CSE-MsgGUID: 3jtPQVG7SMWh0Tq3Ak4nFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62315673"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="62315673"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 11:46:21 -0700
X-CSE-ConnectionGUID: W0IQ73/NROu/CVrixSL3yQ==
X-CSE-MsgGUID: yJqGjlDWT4CQop1SdZTlhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="207077269"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.76])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 11:46:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 20 Oct 2025 21:46:13 +0300 (EEST)
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com, kw@linux.com, 
    LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, 
    lucas.demarchi@intel.com, rafael.j.wysocki@intel.com, 
    Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
In-Reply-To: <702c4ad7-508b-42de-9dc3-40e4a0fe7bd7@gmail.com>
Message-ID: <b3a49920-1cff-4ea2-519a-318030ba8797@linux.intel.com>
References: <20251017185246.GA1040948@bhelgaas> <702c4ad7-508b-42de-9dc3-40e4a0fe7bd7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 18 Oct 2025, Bhanu Seshu Kumar Valluri wrote:

> On 18/10/25 00:22, Bjorn Helgaas wrote:
> > On Fri, Oct 17, 2025 at 11:52:58PM +0530, Bhanu Seshu Kumar Valluri wrote:
> >>
> >> I want to report that this PATCH also break PCI RC port on TI-AM64-EVM.
> >>
> >> I did git bisect and it pointed to the a43ac325c7cb ("PCI: Set up bridge resources earlier")
> >>
> >> Happy to help if any testing or logs are required.
> > 
> > Thanks for the report!  Can you test this patch?
> > 
> >   https://patch.msgid.link/20251014163602.17138-1-ilpo.jarvinen@linux.intel.com
> > 
> > That patch is queued up as
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=469276c06aff
> > and should appear in v6.18-rc2 on Sunday if all goes well.
> > 
> > If that doesn't work, let us know and we'll debug this further.
> 
> I applied above patch on top of commit f406055cb18c ("Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux")
> 
> Did pci rescan and run kselftest (pci_endpoint_test). It is working.
> 
> Thanks for the patch.

Thanks for testing the revert.

> Happy to help if any testing or logs are required.

I'd be interested to understand what goes wrong with the change I was 
trying to make as I want to attempt the same change later, but with all 
known issues solved by supporting changes, obviously :-).

The log snippets you provided are unfortunately too short to contain all 
the necessary information (missing e.g. root bus resources and possibly 
other helpful details).

So if you could provide dmesg and /proc/iomem contents from broken and
working (with the revert) cases to let me easily compare them, that would 
help. Please take the dmesg with dyndbg="file drivers/pci/*.c +p" on 
kernel's cmdline.

No further actions needed beyond that until later if I need to test some 
of those supporting changes before retrying all this in the mainline. It 
may take some time, even more than one kernel cycle as there have been 
quite many regressions.


-- 
 i.


