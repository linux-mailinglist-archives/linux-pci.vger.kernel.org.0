Return-Path: <linux-pci+bounces-10930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E70B93EF5F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 10:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 903CCB209BC
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 08:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5A8136664;
	Mon, 29 Jul 2024 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxVZWGew"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C24213AD22;
	Mon, 29 Jul 2024 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240293; cv=none; b=ElmffQ6ZNP/YOoozVipVzdhUHIKRDre/CueP3eV3B3Op7FMwCg5jHzrFc/RnlW0xFLWbdx5HAwblkljzqcutFwlWIt5KGRV7dPpSeLvH97NEWUFBC71nS9c+8E56dXR4MN4pGwQtIyAbV4zDKG3fj+Wc05PA69UbW/OvAdky5Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240293; c=relaxed/simple;
	bh=kcplikNPTfJ49hcPkFXkshkzKNenhjH7qdszq0zdwLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnH5+DzoIPVDmCKET7wKgGw+BZo5RRqJ/M4U3BDPGvTf2BFPz2WJLYg89St3tg7XPZgxy54TsrJoS+pw08x5Qh/VP4Yr9E91UfttGZpkxMxXHp3b8UsbJ8/7Qx00x85ibDmsA4KwUpCubishkJB0WuVrqbBcTlMHDNzGMUsWucM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxVZWGew; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722240292; x=1753776292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kcplikNPTfJ49hcPkFXkshkzKNenhjH7qdszq0zdwLw=;
  b=UxVZWGewlwg5jRb4273nmtMej640HC366MRAzilKo8U1f0/QAPT7Audu
   LDtPx2tkkpm64nHHUucoYgqpx0uyZDYmqx1JOAeEP+gdsJU7+QpvdD7iq
   yfIA5wGOJkIS3dwnOBChJBhPlJIhTMlsemE1wsETUrM55tAMtRzUy5e0I
   e8uVO+m7/hVzdqDIfd03ylhKIUj034ksnz1qk7pANZ+JM69XQPmWiI0fb
   0UPgv9hFMvQSk+XwQJvo8Bznzg5c3UaOKXiQ9mwsNN90HW7G2rqYfeu1L
   IeWrU0aF1okMDrSjwyQ4iAlir8UKyGBZTJtzNTuYO3cIr1dAbLa6CohWb
   A==;
X-CSE-ConnectionGUID: zJ5w6hXuQE6icunEl+h43A==
X-CSE-MsgGUID: 3j/xbynCTI2AldUVbFkS6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="19859107"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="19859107"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:04:52 -0700
X-CSE-ConnectionGUID: md5Tyjj9R7GXs2yfcRv6eA==
X-CSE-MsgGUID: 41yRA9BTQn2WB+JnTw5Tew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="58030907"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 29 Jul 2024 01:04:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 88D0F19E; Mon, 29 Jul 2024 11:04:41 +0300 (EEST)
Date: Mon, 29 Jul 2024 11:04:41 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240729080441.GG1532424@black.fi.intel.com>
References: <20240511043832.GD4162345@black.fi.intel.com>
 <20240511054323.GE4162345@black.fi.intel.com>
 <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
 <ZkUcihZR_ZUUEsZp@wunner.de>
 <20240516083017.GA1421138@black.fi.intel.com>
 <20240516100315.GC1421138@black.fi.intel.com>
 <CA+Y6NJH8vEHVtpVd7QB0UHZd=OSgX1F-QAwoHByLDjjJqpj7MA@mail.gmail.com>
 <ZnvWTo1M_z0Am1QC@wunner.de>
 <20240626085945.GA1532424@black.fi.intel.com>
 <ZqZmleIHv1q3WvsO@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqZmleIHv1q3WvsO@wunner.de>

On Sun, Jul 28, 2024 at 05:41:09PM +0200, Lukas Wunner wrote:
> On Wed, Jun 26, 2024 at 11:59:45AM +0300, Mika Westerberg wrote:
> > On Wed, Jun 26, 2024 at 10:50:22AM +0200, Lukas Wunner wrote:
> > > On Mon, Jun 24, 2024 at 11:58:46AM -0400, Esther Shimanovich wrote:
> > > > On Wed, May 15, 2024 at 4:45???PM Lukas Wunner <lukas@wunner.de> wrote:
> > > > > Could you add this to the command line:
> > > > >   thunderbolt.dyndbg ignore_loglevel log_buf_len=10M
> > > > >
> > > > > and this to your kernel config:
> > > > >   CONFIG_DYNAMIC_DEBUG=y
> > > > >
> > > > > You should see "... is associated with ..." messages in dmesg.
> > > > 
> > > > I tried Lukas's patches again, after enabling the Thunderbolt driver
> > > > in the config and also verbose messages, so that I can see
> > > > "thunderbolt:" messages, but it still never reaches the
> > > > tb_pci_notifier_call function. I don't see "associated with" in any of
> > > > the logs. The config on the image I am testing does not have the
> > > > thunderbolt driver enabled by default, so this patch wouldn't help my
> > > > use case even if I did manage to get it to work.
> > > 
> > > Mika, what do you make of this?  Are the ChromeBooks in question
> > > using ICM-based tunneling instead of native tunneling?  I thought
> > > this is all native nowadays and ICM is only used on older (pre-USB4)
> > > products.
> > 
> > I think these are not Chromebooks. They are "regular" PCs with
> > Thunderbolt 3 host controller which is ICM as you suggest.
> > 
> > There is still Maple Ridge and Tiger Lake (non-Chrome) that are ICM
> > (firmware based connection manager) that are USB4 but everything after
> > that is software based connection manager.
> 
> Even with ICM, the DROM of the root switch seems to be retrieved:
> 
>   icm_start()
>     tb_switch_add()
>       tb_drom_read()
> 
> Assuming the DROM contains proper PCIe Upstream and Downstream Adapter
> Entries, all the data needed to at least associate the PCIe Adapters
> on the root switch should be there.  So I'm surprised Esther is not
> seeing *any* messages.
> 
> Do the DROMs on ICM root switches generally lack PCIe Upstream and
> Downstream Adapter Entries?
> What am I missing?

My guess is that they are not populated for ICM host router DROM
entries. These are pretty much Apple stuff and USB4 dropped them
completely in favour of the router operations.

