Return-Path: <linux-pci+bounces-43106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FDECC1DBF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 10:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E822330133EF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 09:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317A22288D5;
	Tue, 16 Dec 2025 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A22E1/6Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2AE255E26
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765878593; cv=none; b=eYrU49iinYc8CQLJZIgwRJJ/0h+FmebK3TD22IRBtNFzSx9ABv54xejnK/samN824NPCCC5yGQBMwg9ZtdRWlK8AEKGy6E8Uy4ThsdV+PybYrmbbVTGqxsHCPWLWQvo/d/RncX0gwhIbTFJeURazONqQb2W0cosGjesR4Uh2Lg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765878593; c=relaxed/simple;
	bh=Qn0TS7R1CXs2Q4hRefc+hzdf0cMQdRNRE0vGYszb8zo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DJA1s/YS14CewsmJRttOtv5ZKKTDszLI0OoI29pHzjrMgWL6w1O0ay1o2EQRw1RmMEzRPLxqyvirqPrMwD3oie2KkHIajGn+ulHwAkBS8i44l71ukys4IIyjdOj6W25FGPyr8A2hLfxrguorHb4GmzCGfZXrKm48Nrbu3ey0CX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A22E1/6Z; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765878591; x=1797414591;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Qn0TS7R1CXs2Q4hRefc+hzdf0cMQdRNRE0vGYszb8zo=;
  b=A22E1/6Zw+4egsx2LP0NCtZW9JVvIjV9Brg2zjJ0ZITu1eslQxj2KhK+
   z20OOEd4Q34MKpvG13LKx1Du9ntDCR73ITdO1Ma9vyCD1xX/a2+4OFRWm
   qwYFXjPTUPOPBI0zVfiUNIDDN1pdJFOy4iukxC3phHQruh0M3lIQgLN+n
   krPqFlzbHiZdKHHKemDp6/oXvdGI36V+F2OH2dAk0gdNeLopdjzWD1N/5
   O8xMhA5qTninEJ3isVogmOHhfVaqLura0Lb9Vq2Mpb2mEtV0me+9T2hqF
   xRx0Kpsdc0aksfVgX9Hha1QMOuEzZXdkZDQVGmjczY+xgz31MV5sxuGrv
   g==;
X-CSE-ConnectionGUID: gT/9o5IaSAu3LftPTiR4kg==
X-CSE-MsgGUID: tKG6sAwBTIOvRMzwu0hPCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="78097968"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="78097968"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 01:49:51 -0800
X-CSE-ConnectionGUID: 3Xe6VcYiQnuIfaGoDHa1FQ==
X-CSE-MsgGUID: A2BzGpIfRsuqK7wGOygyDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="235386961"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.4])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 01:49:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 16 Dec 2025 11:49:45 +0200 (EET)
To: Adam Stylinski <kungfujesus06@gmail.com>
cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: Kernel regression in 6.13
In-Reply-To: <aUCt1tHhm_-XIVvi@eggsbenedict>
Message-ID: <09dc94cd-6247-231a-7bcc-27aaeb3b5176@linux.intel.com>
References: <aUCt1tHhm_-XIVvi@eggsbenedict>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 15 Dec 2025, Adam Stylinski wrote:

> Hello,
> 
> I seem to be encountering a regression that prevents my system from 
> booting.  The regression occurred between 6.12 and 6.13.  I've bisected 
> it to this commit:
> 665745f274870c921020f610e2c99a3b1613519b
> 
> Some info about this system: it's ancient. It's a Q9650 that I used as a 
> mythbackend/frontend for over a decade. This booting failure on newer 
> kernels finally forced my hand to buy new a "new" PCI Express based 
> tuner and upgrade the system into the modern age. It boots via MBR on a 
> P45 based chipset (A P5Q Plus board, to be precise).  Given the age, I 
> chalked the issue up to possibly some failing hardware or memory 
> corruption that happened at compile time. I recently pulled the system 
> back out again to do some performance testing in zlib-ng only to find 
> out it hangs on the latest Ubuntu server ISO. I figured at this point it 
> wasn't something specific to my kernel config / compilation and it's 
> likely a regression. It's also old enough that I may be in the position 
> of the only one having this problem, so I took it upon myself to bisect 
> what was going on. Let me know if there's anything you'd like me to test 
> or try.

Hi,

Thanks for the report.

In pcie_bwnotif_enable() there's pcie_capability_set_word() that enables
bandwidth notifications:

	        pcie_capability_set_word(port, PCI_EXP_LNKCTL,
                                 PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);

So as the first step change those PCI_EXP_LNKCTL_LBMIE | 
PCI_EXP_LNKCTL_LABIE into 0 to see if not enabling the bandwitdh 
notification allows the system to come up.

I suggest not trying this directly at the top of 665745f27487 
("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller") 
but on a kernel that is expected to have fixes since 665745f27487 
including those made to the other PCIe service drivers that share 
interrupt handler with bwctrl (so basically some stable version).

If that works try to enable those bits one at a time.

Please also send lspci -vvv.

-- 
 i.


