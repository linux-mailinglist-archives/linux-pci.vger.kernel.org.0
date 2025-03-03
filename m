Return-Path: <linux-pci+bounces-22753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06EBA4BCD1
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 11:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00775189272B
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 10:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39E5A94A;
	Mon,  3 Mar 2025 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSVJThAt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBD3101C8;
	Mon,  3 Mar 2025 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998887; cv=none; b=CR5h6Y/pEaN30UeRqaCZ70/l08U9b/H/BE4aUpyZhSdREmv8t46dGojkbvMM6Lsks3LGFC13uHOh/DO2N47WJal7I3qcPdjGGcXr1k+vqUfTxImpStYF/vHZu/60rMSAYea/YhDiXVyg5wM5pzxFa6J0D8isrIXEfQYcZ+03Rlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998887; c=relaxed/simple;
	bh=X9tzQvVlQ+wbFrpPLuFQHJ7qRfiOJX3C1fJr5HbOYdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCvgpAHjwAgEAOPwm0N7sN2cRMGNI6gRLaBuwbAPBiBxUF3ahzQzNRhcJNJ6OZXyOwzcm/4PVXFrfJdICmeLtWiOv31oPmNZt9F34gcDJJUah0FGRGTqQmbDv4kV8HsLIeAiIAcewZcCXWbZZCn3D+Q1k05fxCRxJS7CL2J/zJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSVJThAt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740998887; x=1772534887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X9tzQvVlQ+wbFrpPLuFQHJ7qRfiOJX3C1fJr5HbOYdI=;
  b=SSVJThAtDh0taqUjyNeQwaV7/tB6dq/ZtZQ0XJb/Q+YjP3MLaiy2DfqM
   rJWPxzDCzFo0ptKPegqaECkNpSKjIpYFWXQvCADl/+yt/qEklUiOdEGhi
   nQp+LRoVclnhzu5xrg0YcpBmbSq5XpoadDtbnkRh44gZDPZLAz1obtbcS
   YzWI4m2gLiNwJkKXyPUppjUA+HwVnWcbHq0V7SwMdPCse4EgXl3i2izhE
   fcDs+YUkaxgs7ApESRj/VmZfYziJDAej8rJiaP7eRAZ4IiEXv6YT50g1R
   wLelfxMUh7qdStlZnvw4ydvJdkp8sjOLRx83OVew7CnvB5JSPYCb0AVgf
   g==;
X-CSE-ConnectionGUID: uZOO8U4FR7iXOT/pCkoYNQ==
X-CSE-MsgGUID: uvsDyYYVRIS7mv4ldyA2oA==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="59280184"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="59280184"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 02:48:06 -0800
X-CSE-ConnectionGUID: KFV6zqDdQnOtKHp8FbUXhA==
X-CSE-MsgGUID: onRsMZUMTKyLS8bi+e41IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123190941"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 03 Mar 2025 02:48:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 0B80F125; Mon, 03 Mar 2025 12:48:00 +0200 (EET)
Date: Mon, 3 Mar 2025 12:48:00 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kenneth Crudup <kenny@panix.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, ilpo.jarvinen@linux.intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jian-Hong Pan <jhp@endlessos.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
Subject: Re: diagnosing resume failures after disconnected USB4 drives (Was:
 Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac))
Message-ID: <20250303104800.GQ3713119@black.fi.intel.com>
References: <20250213135911.GG3713119@black.fi.intel.com>
 <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>
 <20250214162948.GJ3713119@black.fi.intel.com>
 <661459dd-67d0-4e1c-bb28-9adf1417f660@panix.com>
 <20250226084404.GM3713119@black.fi.intel.com>
 <b6eff06e-1a8c-48c3-b536-39b567015d0c@panix.com>
 <5c131927-87c1-4e21-90f8-8e3a34cd6dbf@panix.com>
 <20250228104925.GO3713119@black.fi.intel.com>
 <1f214d95-61c0-4be9-8b19-5aef76631c0e@panix.com>
 <e5badaa8-20e2-4160-be20-75e174d241bc@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e5badaa8-20e2-4160-be20-75e174d241bc@panix.com>

On Sun, Mar 02, 2025 at 08:13:51AM -0800, Kenneth Crudup wrote:
> 
> On 2/28/25 08:04, Kenneth Crudup wrote:
> 
> > Don't worry about the printk()s WRT to the code; a couple of weeks ago
> > I'd seen an NPE on resume in __tb_path_deactivate_hop so threw in a
> > bunch of tb_port_info(port, "%s(): %d\n", __func__, __LINE__); so I
> > could get an idea of where the crash was.
> 
> I've started a separate E-mail about this, but I'd determined those crashes
> were due to d6d458d42e1 ("Handle DisplayPort tunnel activation
> asynchronously").
> 
> Since reverting 9d573d1954 and d6d458d42e1 I've been testing several resume
> scenarios (NVMe connected/disconnected and/or external DP-tunneled monitor
> connected/disconnected and have yet to have a resume or hibernate failure
> over several cycles.
> 
> Now, how do I help you guys go about fixing these commits?

I commented on the other thread. Let's deal with these as two separate
issues and investigate both in isolation.

For others, the second thread is this one:

https://lore.kernel.org/linux-usb/8e175721-806f-45d6-892a-bd3356af80c9@panix.com/

