Return-Path: <linux-pci+bounces-22828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB6DA4D627
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 09:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DE13A6CC0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 08:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B711FAC3E;
	Tue,  4 Mar 2025 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFHQEELn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE891F940A;
	Tue,  4 Mar 2025 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076604; cv=none; b=a7VijCJbsJB7PdUTSzsanbM2SDabquc2p7RFTmeY4Re+fRhCuz7Egr7FNF8rnSDxZAZoAVVmrEugH8xzuRJASftJp934B2AU7PgBEZqnlwxGGnZycB0A0TzcchEMVaotAOy0mpd29hT+momQDoUfsV+Q6UdCerm7rLe15KJya9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076604; c=relaxed/simple;
	bh=RsFHsmgRna6/YR64hWk++Pe5uJYfrdjKW5xLWtUre6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4G2yhDykJ89xAIiIcCfr4CgZ5lkgjTXwVGmkAvrBd2g1UrL9meIX/IJfLDpGLQKHC9sTKxWc/j5+P085B2EpSRNASHqiaYLAaGKt83uc4UyeeboFFjhxy+Oww3XsFry2xFU8bIKqnZtTWG4VIk6FGOvbzD5hp+jx04vCiqKQ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFHQEELn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741076603; x=1772612603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RsFHsmgRna6/YR64hWk++Pe5uJYfrdjKW5xLWtUre6U=;
  b=CFHQEELnKhvakvHYUaBC3nCBVnc9Q9DibTUv/SWLyo+4uFKufOR9X4LM
   AcmPARw2EToG0GU+yXa426iB2rLwNd7GjTmhg8RvNdCSHHigezvFNypp7
   cBELYE5FkhaLLmvbgSAl1dZBaMt7BiQs1RDaWrH8GdvSUF9XlGqyIxR1g
   2ORQ1ERe0UH03vcZeKq++g1ILyZVC/axRJiyA51SVWJe+O5WvrQBi6qiW
   iyNnJmeGJwZuZQ9wkN+z8cN+3QJbwKW5JM8SYg11SGUblaiQdjpdrFXXt
   Zo2dI3Ui7AMaPIocsf3NMtvAYupdZr+CEpwpAHNGeVL9RN1YGO2nvusnY
   Q==;
X-CSE-ConnectionGUID: OcPUaMaLSBe6+Axadk5N2A==
X-CSE-MsgGUID: CJj7la2sTKGQdql0u+t9gQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52964160"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="52964160"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:23:20 -0800
X-CSE-ConnectionGUID: EaDWR0S3SCe0DGJAinWjIA==
X-CSE-MsgGUID: nI1OirT+QFCGP7zJY6no7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="149105150"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 04 Mar 2025 00:23:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 0E93718F; Tue, 04 Mar 2025 10:23:14 +0200 (EET)
Date: Tue, 4 Mar 2025 10:23:14 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Kenneth Crudup <kenny@panix.com>, Bjorn Helgaas <helgaas@kernel.org>,
	ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	Jian-Hong Pan <jhp@endlessos.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikl??vs Ko??es??ikovs <pinkflames.linux@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
Subject: Re: diagnosing resume failures after disconnected USB4 drives (Was:
 Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac))
Message-ID: <20250304082314.GE3713119@black.fi.intel.com>
References: <20250211055722.GW3713119@black.fi.intel.com>
 <83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com>
 <20250213135911.GG3713119@black.fi.intel.com>
 <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>
 <20250214162948.GJ3713119@black.fi.intel.com>
 <661459dd-67d0-4e1c-bb28-9adf1417f660@panix.com>
 <20250226084404.GM3713119@black.fi.intel.com>
 <Z77ak-4YsdAKXbHr@wunner.de>
 <20250226091958.GN3713119@black.fi.intel.com>
 <Z8YKXC1IXYXctQrZ@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8YKXC1IXYXctQrZ@wunner.de>

On Mon, Mar 03, 2025 at 09:00:28PM +0100, Lukas Wunner wrote:
> On Wed, Feb 26, 2025 at 11:19:58AM +0200, Mika Westerberg wrote:
> > On Wed, Feb 26, 2025 at 10:10:43AM +0100, Lukas Wunner wrote:
> > > On Wed, Feb 26, 2025 at 10:44:04AM +0200, Mika Westerberg wrote:
> > > >   [Meteor Lake host] <--> [TB 4 dock] <--> [TB 3 NVMe]
> > > [...]
> > > > I added "no_console_suspend" to the command line and the did sysrq-w to
> > > > get list of blocked tasks. I've attached it just in case it is needed.
> > > 
> > > This looks like the deadlock we've had for years when hot-removing
> > > nested hotplug ports.
> > > 
> > > If you attach only a single device to the host, I guess the issue
> > > does not occur, right?
> > 
> > Yes.
> > 
> > > Previous attempts to fix this:
> > > 
> > > https://lore.kernel.org/all/4c882e25194ba8282b78fe963fec8faae7cf23eb.1529173804.git.lukas@wunner.de/
> > > 
> > > https://lore.kernel.org/all/20240612181625.3604512-1-kbusch@meta.com/
> > 
> > Well, it does not happen if I revert the commit so isn't that a
> > regresssion?
> 
> Does the below fix the issue?

Unfortunately I still see the same hang. I double checked, with revert the
problem goes a way and with this patch I still see it.

Steps:

1. Boot the system, nothing connected.
2. Connect TBT 4 dock to the host.
3. Connect TBT 3 NVMe to the TBT4 doc.
4. Authorize both PCIe tunnels, verify devices are there.
5. Enter s2idle.
6. Unplug the TBT 4 dock from the host.
7. Exit s2idle.

