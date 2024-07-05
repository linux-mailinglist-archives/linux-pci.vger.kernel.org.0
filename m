Return-Path: <linux-pci+bounces-9841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902D192897E
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 15:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DB61C23C42
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 13:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74D614AD2B;
	Fri,  5 Jul 2024 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAN/Bkvy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B17214BF8B
	for <linux-pci@vger.kernel.org>; Fri,  5 Jul 2024 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720185787; cv=none; b=EwkcHTzJP0JoOkBk5zq0Cxu6H2/JA8uBvHbPYcnJqjWeg1sSFiOrbLrgO2zSLNn5anfMOobWcHeJ0fYBtsYjo86CofvYqdHsLyljQc45/rMcD0fFOi/0i15g8BOKjQj6HycM2vYucaw70B2lWHXhdyNAMSbcDGoV4D9funLiKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720185787; c=relaxed/simple;
	bh=tnN+QDEh6roISw8nBXOAHDmIvCOkxg9vyshUATisLwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQ+TvHW0l+tgUoGZFDUJ70QO+TLlnx6WxqaGOoPzh2sI1dwBqaDrzdptZzEmaTNuXcnVTynOXSM2YZxvAhfUBYROKqclsOfbgvYvSgPWCPmuczLDsd/rHbsuEVH4UJVvkhrgxW7XBH+NPQvWhhhBE4MqlHo0S0qboEx/84GWtss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAN/Bkvy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720185786; x=1751721786;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tnN+QDEh6roISw8nBXOAHDmIvCOkxg9vyshUATisLwI=;
  b=VAN/Bkvy9O0HnWnVlrpoxCDk2b5GSdPwAvI7Ze/4uVa6lrjwC/zZSulD
   9j+rUYQOoOMBNPSmDSMUoS+rbXWj7bGGhvbuDNrInRJzargwZxlZOyoFQ
   7nbNFCkZHVGB/BI3wAk6Xo15o9sYuzjgY3c3JuDHLT54ainm6YKfuuT2p
   Mu9Z7ClwlyVuWVp1yhS5kPm1I1g1mXJ8AvKC3BAPIbrFOuM/nHB8eqDXd
   cnppCRl//8ktuMWhqgpRMgLPbd6Ivya4bWrEYU/kSru8dHl7mTdfkPlDO
   1YSuPUQujYcJLE8Vj71tr+37rLtINMm9EI75NlaPQnCIt50iDC5hRZgWe
   w==;
X-CSE-ConnectionGUID: Pnx/Vb2tTMybeegGLqdJ2Q==
X-CSE-MsgGUID: 5IhFJ4QkRSe8FdqNX6+CqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17198976"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="17198976"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 06:23:05 -0700
X-CSE-ConnectionGUID: WRITEH6iRkKxzhakBZ9Dpg==
X-CSE-MsgGUID: 0l57Za4NSqG7RooLxDqSXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="51476926"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.245.98.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 06:23:02 -0700
Date: Fri, 5 Jul 2024 15:22:57 +0200
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas
 <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Ilpo Jarvinen
 <ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Keith
 Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>, Pavel Machek
 <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Stuart Hayes
 <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v3 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <20240705152257.0000527c@linux.intel.com>
In-Reply-To: <Zofu_b-vnBDkWsnJ@infradead.org>
References: <20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com>
	<20240705125436.26057-3-mariusz.tkaczyk@linux.intel.com>
	<Zofu_b-vnBDkWsnJ@infradead.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jul 2024 06:02:53 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> If you just did a:
> 
> 	if (npem_has_dsm(dev))
> 		return;
> 
> we'd save a level of identation for the !dsm case an make the
> code a bit easier to read.  Also I think "OS" above should be "The OS".

Thanks for review!

I did it way because in next patch I'm adding DSM. With that I have less changes
in second patch.

Mariusz

