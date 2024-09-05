Return-Path: <linux-pci+bounces-12804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E0B96CF09
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 08:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F984B2552A
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 06:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211D3185941;
	Thu,  5 Sep 2024 06:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGG0cWBI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CD9126C1C;
	Thu,  5 Sep 2024 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725517175; cv=none; b=ZXhHaLqbk0ma+fTfGz1JW1YTW5mwO9IJ32pkkTsFICbeqX7Gf0yGQX6/FMaYjMnvUWmuXjnx5hc+VxiEsaefeCRv5dhPwXKTdKSbB6lJqueH8tdLHi/CUvTrDxDwDDjC6njg0GzuwZ/4rVzE09WazI1OWC6ZEB92yr7ZKqaSDCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725517175; c=relaxed/simple;
	bh=PUamt9EBsZmj1IRHlPey5ETLPvCHcB/WBQxHhNysqSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jz1RsG3ORVeC+4DL/xqW7ohHzpF78YS4jsCNkD0b1a+AOt1cF1TsmD3sQpMisYiw7zCSUDN6HWLbLoOiPjHuoqiUOg85oyytN3EN4EHsqBXWHEdrKRY3Mj0Oj4iaqlEPv3bi/JR3cbyfnbpZgPaTWuzvKROQwmajeq5LTV8lrcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGG0cWBI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725517173; x=1757053173;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PUamt9EBsZmj1IRHlPey5ETLPvCHcB/WBQxHhNysqSY=;
  b=LGG0cWBIu8d64yk9XLdIbSz3kw2qmUumaYinD7yARmPIXk0zWRmJ2vfx
   b/SjHuU0hGhJFc01G7GWO2be23AuPUVUyjWgu1liU0kyTSkSVKu9yPDcS
   g8C43kBWBjIYF3IJ0612drnhfHhln2q73ugAGC/lYRiDND5kRqJUYtumo
   xmkh2YIRvfiXz/hrcyoEJFYLYm49xG/0Xujimlc7ak8ihkcOGwxn8meEK
   PnGOSXMm2cDmsNS47gw/PhAab7J3QEbnF6pIxxZYmi2J16tkVEWiWxK47
   Tl/GaWasMGwgkQwjdZ8YtYkptIMHXUIsLcvC38Af8Pnw53SOag7HP6Bom
   g==;
X-CSE-ConnectionGUID: q9P66J2JS7KDFoNkPDyTuw==
X-CSE-MsgGUID: gz9TPIxBSsK9981TpJ6Vhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34783091"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="34783091"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 23:19:33 -0700
X-CSE-ConnectionGUID: GHdnaViQS0+VSO49hxuNQA==
X-CSE-MsgGUID: ldMyRC/sQei5mGB1L5Ayrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="65352799"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.246.29.120])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 23:19:30 -0700
Date: Thu, 5 Sep 2024 08:19:25 +0200
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Tony Hutter <hutter2@llnl.gov>, bhelgaas@google.com, minyard@acm.org,
 linux-pci@vger.kernel.org, openipmi-developer@lists.sourceforge.net, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Introduce Cray ClusterStor E1000 NVMe slot LED
 driver
Message-ID: <20240905081925.00001d14@linux.intel.com>
In-Reply-To: <20240903221820.GA26364@bhelgaas>
References: <40c7776f-b168-4cbe-a352-122e56fe7b31@llnl.gov>
	<20240903221820.GA26364@bhelgaas>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Sep 2024 17:18:20 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Aug 27, 2024 at 02:03:48PM -0700, Tony Hutter wrote:
> > Add driver to control the NVMe slot LEDs on the Cray ClusterStor E1000.
> > The driver provides hotplug attention status callbacks for the 24 NVMe
> > slots on the E1000.  This allows users to access the E1000's locate and
> > fault LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs
> > entries.  This driver uses IPMI to communicate with the E1000 controlle=
r to
> > toggle the LEDs. =20
>=20
> I hope/assume the interface is the same as one of the others, i.e.,
> the existing one added for NVMe behind VMD by
> https://git.kernel.org/linus/576243b3f9ea ("PCI: pciehp: Allow
> exclusive userspace control of indicators") or the new one for NPEM
> and the _DSM at
> https://lore.kernel.org/linux-pci/20240814122900.13525-3-mariusz.tkaczyk@=
linux.intel.com/
>=20
> I suppose we intend that the ledmon utility will be able to drive
> these LEDs?  Whatever the user, we should try to minimize the number
> of different interfaces for this functionality.

Ledmon won't support it, at least not in current form. Ledmon support for p=
ciehp
attention is limited to VMD, i.e. first we must find VMD driver then we are
looking for slot/attention.
I'm not familiar with any attempt to add support for this in ledmon.

=46rom the end user perspective, I don't like pciehp/attention because we are
refereeing to pciehp driver not pcieport and to determine proper slot we
need to do additional matching by slot/address. I would be simpler.
https://github.com/intel/ledmon/blob/main/src/lib/vmdssd.c#L100

Thanks,
Mariusz

