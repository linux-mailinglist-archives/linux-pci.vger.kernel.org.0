Return-Path: <linux-pci+bounces-42653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D1DCA51D4
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 20:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95A54300B306
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 19:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35FC21CA03;
	Thu,  4 Dec 2025 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIq+Qxzr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE0DDDAB
	for <linux-pci@vger.kernel.org>; Thu,  4 Dec 2025 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764876275; cv=none; b=rU707m0YlB2IFvxpgRwtHT6dKsmQDO8uDYK7gw7EFCJfrI1o2o6mDeYZFm6dhrX8tMMj9xg3p7UN5T/tZgO4THAGBNxOur015E9K61waeYI63+dOCxfxoaRLCpGS+xDhTa0y7iZFfGaZkuHMtl4K2Tp+4F1lS1KvYFb7vAhChyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764876275; c=relaxed/simple;
	bh=tJMgXJV68ALNhmWSxtStFXgTvJoZgcTTAFRTpvUH7Iw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A07zzU7k9+4cA4EjrJ//QBSzrmCT4mmybR7JF5AvCnrZYU64hDrpPSpjME3MAfU3oauPLvZfjZhaKFlFhZcr2zKrZfM5gtoXwY4ZwmqJi2eIC9fwP96y93uGat3BF8qdQM4pU7QFj/ZlFE/Wk+tp+EV9YmjbgZmr0hPKeuwTWfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIq+Qxzr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764876274; x=1796412274;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tJMgXJV68ALNhmWSxtStFXgTvJoZgcTTAFRTpvUH7Iw=;
  b=kIq+QxzrvU+4jyhNmgbV/YsuNSrhHPXCuLCUORBmtwtGt2+YoaxN5lfN
   3NDwsT+/Uvbv1WP+Elevm+vmuSumfdAVEALpH0awPsz7iLYdb7HcCCvWj
   Vu8K10PK9qQPy/35PJnAQxJYDFoHHoQPepQTZRNEif2Ep+hhglI5/alf8
   maZGPeK4HHeTd419kdCK6IMYb+A1WYQ44NNU8kMHYgP9HKmyizhrH0cfK
   UCrxvB/tQ3SzS213AoMZ+e0M2LYCi4kQYx8Osnop+nGIqjiH7WSpC0Mq4
   kCexr8z38Rz6LUAZs3YhtwV4iBT2UP55bT2BN6kAsV7F7+n7GROUxs2fk
   Q==;
X-CSE-ConnectionGUID: bSnwCz58Qtu1zvJiUbLs1w==
X-CSE-MsgGUID: jaEs9Pn+RkOKxMPQYfkAzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="77591693"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="77591693"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 11:24:33 -0800
X-CSE-ConnectionGUID: Cy9bm9gURduPyiPKt5iogg==
X-CSE-MsgGUID: nhjwzbrpQZyMQ0B7LhACig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="226038617"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 11:24:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 4 Dec 2025 21:24:27 +0200 (EET)
To: Teika Kazura <teika@gmx.com>, helgaas@kernel.org
cc: linux-pci@vger.kernel.org, aros@gmx.com, superm1@kernel.org
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 220729] dmesg flooded with
 "PME: Spurious native interrupt". AMD, related to audio.]
In-Reply-To: <20251204.162726.629872510136678985.teika@gmx.com>
Message-ID: <52ef10ee-f276-3927-2d0d-6a361ee34376@linux.intel.com>
References: <20251104200516.GA1866276@bhelgaas> <20251204.162726.629872510136678985.teika@gmx.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 4 Dec 2025, Teika Kazura wrote:

> From: Bjorn Helgaas <helgaas@kernel.org>
> Subject: [bugzilla-daemon@kernel.org: [Bug 220729] dmesg flooded with "PME: Spurious native interrupt". AMD, related to audio.]
> Date: Tue, 4 Nov 2025 14:05:16 -0600
> 
> > It looks like PME and bwctrl share the interrupt; Teika, if it's easy
> > for you, you might see if this is reproducible without bwctrl.
> > There's no direct config option for it, but I think you could remove
> > bwctrl.o from drivers/pci/pcie/Makefile.
> 
> Unfortunately, compilation fails, like this:
> ------------------------------------------------------------------------
> ld: vmlinux.o: in function `pcie_retrain_link':
> /usr/src/linux-6.17.9-gentoo/drivers/pci/pci.c:4746:(.text+0x9fdfb1): undefined reference to `pcie_reset_lbms'
> ld: vmlinux.o: in function `pcie_failed_link_retrain':
> /usr/src/linux-6.17.9-gentoo/drivers/pci/quirks.c:135:(.text+0xa27105): undefined reference to `pcie_set_target_speed'
> ...
> -------------------------------------------------------------------------
> Ok, let us give up this route. This bug is not fatal. Thanks a lot for your reply.

You could instead change the flags in pcie_bwnotif_enable().
If you replace this:

        pcie_capability_set_word(port, PCI_EXP_LNKCTL,
                                 PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);

With this:

	pcie_capability_set_word(port, PCI_EXP_LNKCTL, 0);

The bandwidth notifications should no longer cause any interrupts. If that 
works, you can try with one flag at a time to see if it breaks because of 
PCI_EXP_LNKCTL_LBMIE or PCI_EXP_LNKCTL_LABIE.

There's also a series adding tracing to bwctrl events that might be able 
to provide clues if there are some odd bw notifications coming in (it's 
not readily available in your kernel though):

https://lore.kernel.org/linux-pci/20251025114158.71714-1-xueshuai@linux.alibaba.com/


BTW Bjorn, that series is still sitting unapplied I think.


-- 
 i.


