Return-Path: <linux-pci+bounces-29316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87EDAD3510
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 13:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6DC3A9C35
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2741F28003E;
	Tue, 10 Jun 2025 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPttBMOQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6757C2253F8;
	Tue, 10 Jun 2025 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749555365; cv=none; b=ARr4uKsVkMLQLtVMMrYGeXb6IAcuHAchE+MLMAb8SnW092QX4w6fDItyVkNWzNzFqvXrjSCdVUQqolrMK4Ci5CBNYn65V7BEZw3KicLCk+Cade/vyuiPc/NUwJOcf1QzcY7YAO4F/Om3qWSymXjPZeXmHNBnDA1NA9cDjTxtQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749555365; c=relaxed/simple;
	bh=wSo4fbCYtc2b8U3BtZtgyroxgV8tXbcvtEFPrGZnt/0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D/XQk4YGj1utJ5ykWSXomWw7S3BOxwoT34aBoi6zxVqp9m5CN5p4fGOcyqmjDQDNLieaU8bjboeUQbNMVdctds15k+MiXp6Bwcn9VqLn5xhGQcHW+0ulJ3JdLH14EfpzXYjQo+lOi3mGkFbSYm+7XRtSxgDnPPSioad9AOoRqq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPttBMOQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749555364; x=1781091364;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wSo4fbCYtc2b8U3BtZtgyroxgV8tXbcvtEFPrGZnt/0=;
  b=lPttBMOQVObk8AwnidwGxrEnGhh7pNas1mX30+E1xfDu620ehrfxFuiQ
   /qoRmO7mvyl8ZiW4Tvu4Edsfvkv3AAuYvO6plLJAULIimMKZvskuwDizc
   cmOaHMOBE/OJ/WjP+eqY/2alV3dJ3IlahFtBoErAokowW8n2qywdk38Z+
   eWOxY/k+8upF0uzdpphH+tcx79cResrsfOpLkImQdoAHU9o+hQ1ObZjDv
   kJmfceVxS0al6I9E+ZAz6At2abWpkU6QCpZmfwmMocKVzZQjj3i67qq7k
   GVUOeJi4B7ZxRS290qE2gYd8kDdWbRd+sBRS3HuWqSRWifywlRC1Fxk9M
   g==;
X-CSE-ConnectionGUID: WN1rZlmUTh638B6SBgh4ww==
X-CSE-MsgGUID: 2l+A0M++Qe28NWLYvaZN3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51801180"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51801180"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 04:36:03 -0700
X-CSE-ConnectionGUID: 7Km5ImlnTRuktlHDJ/cZOw==
X-CSE-MsgGUID: zxfwpSx6SPSuTj/nMq6ZQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="177730322"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 04:36:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 10 Jun 2025 14:35:56 +0300 (EEST)
To: Rio Liu <rio@r26.me>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Tudor Ambarus <tudor.ambarus@linaro.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Relaxed tail alignment should never increase
 min_align
In-Reply-To: <7bbcee36-4891-4b8e-8485-54f960f73580@r26.me>
Message-ID: <4a30d092-9ab6-3d61-8f3d-fab2965111e0@linux.intel.com>
References: <20250610102101.6496-1-ilpo.jarvinen@linux.intel.com> <20250610102101.6496-2-ilpo.jarvinen@linux.intel.com> <7bbcee36-4891-4b8e-8485-54f960f73580@r26.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 10 Jun 2025, Rio Liu wrote:

> Thanks for fixing the problem so quick!
>
> > Reported-by: Rio <rio@r26.me>
> > Tested-by: Rio <rio@r26.me>
> 
> 
> My full name is Rio Liu if you want to include it, sorry for not 
> mentioning it earlier. 

Ah, sorry. I missed it was fully shown by the later emails on the From 
line.

-- 
 i.


