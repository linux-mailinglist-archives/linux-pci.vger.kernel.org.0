Return-Path: <linux-pci+bounces-13347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D9D97E577
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 06:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0A91F21561
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 04:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BCD2F23;
	Mon, 23 Sep 2024 04:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9AcQLGI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A9A23D7
	for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2024 04:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727066490; cv=none; b=ChHwIiVIxNRp2To3he4RFNK1zIaKqUhUYJoEvEeOvzeptDjUtT+4hxOJiQ7jKONAShRjKxvrFxFgyluTug4CmNT/tFyMTWQ0r0+/JzWCVfc/Z1LY857OtNTLrNo+r2ko1Ov0qHhVWZ8TeLdAWWGb1YKczXYW4wP8wUqgx5fGUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727066490; c=relaxed/simple;
	bh=/cxByO9v2ZsiBpCDu9SB8c7VSfPWFxzF9Wx1ZgVdwuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYC7f7vUKa7rRNmtT8mSoeoch5ciq36QdW5DbegLFziFxQeyFnt/xuMTHend28EUlZ+SqL76CmfOZ5TlN+CRnd54xsU6RMYaGCAA/lV8Ssz2xH3lbz6k4bQCVrwJivzRHQPdULImSA1WhOwkVsBAUkvlm447wvNsxdOgHT5z1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9AcQLGI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727066490; x=1758602490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/cxByO9v2ZsiBpCDu9SB8c7VSfPWFxzF9Wx1ZgVdwuE=;
  b=V9AcQLGIuFaf7Fll4EcasZcJttdqByaVd2dM0RpQOZ3slVhw0yDS9s8Z
   sV7fDEfQT91UHKx/XlS7pZEHtQNwzRWERbtzWeRR8NK/tTHg/VwWQJ8MW
   EX63FZhc4s5ESQsQnYUtyBDMABSGqMSm/kyeagv0IfCmxqxnPSE9r5lMo
   +gGjCMl09LjutHFwqGJlb1Yy5I6vBdMkgPFvAAa8/l4KfP3B+6DxGga0U
   fELLoGVU2wU+HFydUMLwhRRAXkbuIrB8lsgJuAREITch0DtCm+L8p8DVB
   OjxOd2Pj01USYEHUlJ6VX3Lj+ghTFzIMtaBZ8ORa/hrkPjyPwuAiv65PA
   g==;
X-CSE-ConnectionGUID: ipt6FwDBSoG92I4/bd0cng==
X-CSE-MsgGUID: iLIeKGAiScuuMrAUXOgJRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="25874964"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="25874964"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 21:41:29 -0700
X-CSE-ConnectionGUID: XxKukB+iQfqzdBv6Zcr7PQ==
X-CSE-MsgGUID: c+Z8LFX0S+e/oN1dGKjU7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="70939233"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 22 Sep 2024 21:41:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 98BEF1BE; Mon, 23 Sep 2024 07:41:23 +0300 (EEST)
Date: Mon, 23 Sep 2024 07:41:23 +0300
From: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To: "Wassenberg, Dennis" <Dennis.Wassenberg@secunet.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"mpearson-lenovo@squebb.ca" <mpearson-lenovo@squebb.ca>
Subject: Re: UAF during boot on MTL based devices with attached dock
Message-ID: <20240923044123.GT275077@black.fi.intel.com>
References: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>

Hi,

On Thu, Sep 19, 2024 at 08:06:03AM +0000, Wassenberg, Dennis wrote:
> Hi together,
> 
> we are facing into issues which seems to be PCI related and asking for your estimations.
> 
> Background:
> We want to boot up an Intel MeteorLake based system (e.g. Lenovo ThinkPad X13 Gen5) with the Lenovo Thunderbolt 4
> universal dock attached during boot. On some devices it is nearly 100% reproducible that the boot will fail. Other
> systems will never show this issue (e.g. older devices based on RaptorLake or AlderLake platform).
> 
> We did some debugging on this and came to the conclusion that there is a use-after-free in pci_slot_release.
> The Thunderbolt 4 Dock will expose a PCI hierarchy at first and shortly after that, due to the device is inaccessible,
> it will release the additional buses/ports. This seems to end up in a race where pci_slot_release accesses &slot->bus
> which as already freed:
> 
> 0000:00 [root bus]
>       -> 0000:00:07.0 [bridge to 20-49]
>                      -> 0000:20:00.0 [bridge to 21-49]
>                                     -> 0000:21:00.0 [bridge to 22]
>                                        0000:21:01.0 [bridge to 23-2e]
>                                        0000:21:02.0 [bridge to 2f-3a]
>                                        0000:21:03.0 [bridge to 3b-48]
>                                        0000:21:04.0 [bridge to 49]
>          0000:00:07.2 [bridge to 50-79]
> 
> 
> We are currently running on kernel 6.8.12. Because this kernel is out of support I tried it on 6.11. This kernel shows
> exactly the same issue. I attached two log files:
> dmesg-ramoops-0: Based on kernel 6.11 with added kernel command line option "slab_debug" in order to force a kernel Oops
> while accessing freed memory.
> dmesg-ramoops-0-pci_dbg: This it like dmesg-ramoops-0 with additional kernel command line option '"dyndbg=file
> drivers/pci/* +p" ignore_loglevel' in order to give you more insight whats happening on the pci bus.

Can you run the same with the v6.11 but add also "thunderbolt.dyndbg=+p"
in the kernel command line and provide me that log?

