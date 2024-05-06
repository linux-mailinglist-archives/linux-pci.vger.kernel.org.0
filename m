Return-Path: <linux-pci+bounces-7135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7E78BD639
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 22:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07D51C20D70
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 20:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B9A15AD95;
	Mon,  6 May 2024 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aNQ1VEJM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A2F156C6E;
	Mon,  6 May 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027305; cv=none; b=qaUWk1+KPcg8pH4I9pKnwyNje55OCw4iOBuOrdfyVKTg95RvKZInY+2jIp0F41C8frXINDMcG1BZ5lXBF2E6NEzBOgwEvCDa/PngbHSVE/oy3OGX1Rc/NzCkJWkGs/4L/UZqHK71iwa3JB3mU5OP8DooS7x910qYRV2B9G+Advw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027305; c=relaxed/simple;
	bh=D0OobsD6K8gAqBNQ7TX2RYZyzVxpLG88EsKBKz07ibw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eem4jFlrEy9l44Q03+sro9AWdDNrw+i5CldlZaCXBzsMiMDI2Gp0NX4XaCdOhR2b/yYh9oGt8/MDKKWLbH2mrlyvBFg5xCst2YIzmzCWluAD2duNl9ZyHzdI42WGV6QLmkknne3ax+8+m2gK2FHLcdW8sryJkCGcmKP+tX16l7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aNQ1VEJM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715027304; x=1746563304;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D0OobsD6K8gAqBNQ7TX2RYZyzVxpLG88EsKBKz07ibw=;
  b=aNQ1VEJMIjiy6rv/9kzh9o5JM6mTejv3v6dCM6I3QE4DM4E3M88puBti
   MzcvSmjz5ayspX/y/fJZAG/8W6iYpi8MSP9Iep71Ad1DOY7ANmskYG8bH
   +anc8md0yXNT5dLUSdT5m4I94onqcJoGWFWkvOFnODnK9MkaHBcNSbjWD
   w4sa7aUwDFl//0+pLUMCutz4yvBTsGDrEzwgHyVZxEbU8ypuCgTKw19AR
   92/N7+tDqdReLtbv5iFVW/zs8d/w7A288c367pS/lMfRSm02YampYz7NE
   UfjlRtIb/K8s+sFxQkU4cez54gYPWAYtSXAPffkiVPspj5uZvRjlZ+lHz
   Q==;
X-CSE-ConnectionGUID: 2ykffqLLQGm1XIld6+/WAQ==
X-CSE-MsgGUID: B91AZvLiRj289dvS+41r8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="33297033"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="33297033"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 13:28:24 -0700
X-CSE-ConnectionGUID: DjyiNd3sSXCtcE/QcWH6wQ==
X-CSE-MsgGUID: qLl6V1eMSCOnYYGhS3ERIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="28242490"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.124.222.135]) ([10.124.222.135])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 13:28:22 -0700
Message-ID: <3d18ae36-4dea-496a-a8fc-253b21135838@intel.com>
Date: Mon, 6 May 2024 13:28:21 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] CXL Development Discussions
To: Adam Manzanares <a.manzanares@samsung.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "gourry.memverge@gmail.com" <gourry.memverge@gmail.com>,
 "wj28.lee@gmail.com" <wj28.lee@gmail.com>,
 "rientjes@google.com" <rientjes@google.com>,
 "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
 "shradha.t@samsung.com" <shradha.t@samsung.com>,
 "mcgrof@kernel.org" <mcgrof@kernel.org>, Jim Harris
 <jim.harris@samsung.com>, "mhocko@suse.com" <mhocko@suse.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <CGME20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f@uscas1p2.samsung.com>
 <9bf86b97-319f-4f58-b658-1fe3ed0b1993@nmtadam.samsung>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <9bf86b97-319f-4f58-b658-1fe3ed0b1993@nmtadam.samsung>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/6/24 12:27 PM, Adam Manzanares wrote:
> Hello all,
> 
> I would like to have a discussion with the CXL development community about
> current outstanding issues and also invite developers interested in RAS and
> memory tiering to participate.
> 
> The first topic I believe we should discuss is how we can ensure as a group
> that we are prioritizing upstream work. On a recent upstream CXL development
> discussion call there was a call to review more work. I apologize for not
> grabbing the link, but I believe Dave Jiang is leveraging patchwork and this
> link should be shared with others so we can help get more reviews where needed.

Bundle for the potential fixes
https://patchwork.kernel.org/bundle/cxllinux/cxl-fixes/

Bundle for the next merge window
https://patchwork.kernel.org/bundle/cxllinux/cxl-next/

Just be aware patchwork only takes patches, so the bundle are registered with the first patch of a series. The listing does display the origin series.

DJ

> 
> The second topic I would like to discuss is how we integrate RAS features that
> have similar equivalents in the kernel. A CXL device can provide info about 
> memory media errors in a similar fashion to memory controllers that have EDAC
> support. Discussions have been put on the list and I would like to hear thoughts
> from the community about where this should go [1]. On the same topic CXL has 
> port level RAS features and the PCIe DW series touched on this issue  [2]
> 
> The third topic I would like to discuss is how we can get a set of common
> benchmarks for memory tiering evaluations. Our team has done some initial
> work in this space, but we want to hear more from end users about their 
> workloads of concern. There was a proposal related to this topic, but from what 
> I understand no meeting has been held [3]. 
> 
> The last topic that I believe is worth discussion is how do we come up with
> a baseline for testing. I am aware of 3 efforts that could be used cxl_test, 
> qemu, and uunit testing framework [4].
> 
> Apologies for getting this out late, and please include anyone that may be
> interested in joining a discussion.
> 
> [1] https://lore.kernel.org/linux-cxl/20240417075053.3273543-1-ruansy.fnst@fujitsu.com/
> [2] https://lore.kernel.org/lkml/20231130115044.53512-1-shradha.t@samsung.com/
> [3] https://lore.kernel.org/all/2b29dd3d-bb2c-6a8c-94d2-d5c2e035516a@google.com
> [4] https://lore.kernel.org/linux-cxl/170795677066.3697776.12587812713093908173.stgit@ubuntu/

