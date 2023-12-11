Return-Path: <linux-pci+bounces-777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7DC80DF44
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 00:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76AA22818FA
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 23:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1CB56465;
	Mon, 11 Dec 2023 23:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2ICzxgQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00747C3
	for <linux-pci@vger.kernel.org>; Mon, 11 Dec 2023 15:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702336377; x=1733872377;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mY50QY54rnTtvAqWDWF4bpvtvzU/wxKfZnZT9DSIe0Q=;
  b=d2ICzxgQtcVYlcU9H4YGzsbHo5glu7JI3kgOgFPuJFNPLtgTV0HZmniI
   cE1JCXKREQtlswKsjIOt1bMicjVs7zk9pVIvlYiFMyZcpBlaI3QNhy/eZ
   yePbDIk9BvEEYN2xK3tGj9n+JjuPj4AmZJMXe1bTYzNi5WrvQEU8Qs+l0
   qdC9Hsh7vjs4Xd7FTX4LsiGLmNw0SeO8skzHxb0kC97h9IwGqFHthdpg1
   ayQsdnlZY6P9Fp/NNamM3TAxpfzCad8mem1LNlXyNkeBmroG/Y3X3FTl0
   tiBXrmaIAqLE+qBi8qGzcb1LrLMAWVppk8W42XMzAErcCMQEO3Rz3SdzQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="394478109"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="394478109"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 15:12:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1104663536"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1104663536"
Received: from patelni-ubuntu-dev.ch.intel.com ([10.2.132.59])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 15:12:57 -0800
Message-ID: <afacb1fc1ac204a786260f64de83e220d453b410.camel@linux.intel.com>
Subject: Re: [PATCH] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Kai-Heng Feng
	 <kai.heng.feng@canonical.com>
Cc: linux-pci@vger.kernel.org, orden.e.smith@intel.com, 
 samruddh.dhope@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Grant
 Grundler <grundler@chromium.org>, Rajat Khandelwal
 <rajat.khandelwal@linux.intel.com>, Rajat Jain <rajatja@chromium.org>
Date: Mon, 11 Dec 2023 16:19:32 -0700
In-Reply-To: <20231206163026.GA716688@bhelgaas>
References: <20231206163026.GA716688@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2023-12-06 at 10:30 -0600, Bjorn Helgaas wrote:
> [+cc Grant, Rajat, Rajat]
> 
> On Wed, Dec 06, 2023 at 10:18:56AM +0800, Kai-Heng Feng wrote:
> > On Wed, Nov 15, 2023 at 5:00 AM Nirmal Patel <
> > nirmal.patel@linux.intel.com> wrote:
> > > On Wed, 2023-11-08 at 16:49 +0200, Kai-Heng Feng wrote:
> > > > On Wed, Nov 8, 2023 at 12:30 AM Bjorn Helgaas <
> > > > helgaas@kernel.org> wrote:
> > ...
> > > > > I assume you mean to revert 04b12ef163d1 ("PCI: vmd: Honor
> > > > > ACPI _OSC on PCIe features").  That appeared in v5.17, and it
> > > > > fixed (or at least prevented) an AER message flood.  We can't
> > > > > simply revert 04b12ef163d1 unless we first prevent that AER
> > > > > message flood in another way.
> > > > 
> > > > The error is "correctable".  Does masking all correctable AER
> > > > error by default make any sense? And add a sysfs knob to make
> > > > it
> > > > optional.
> > > 
> > > I assume sysfs knob requires driver reload. right? Can you send a
> > > patch?
> > 
> > What I mean is to mask Correctable Errors by default on *all*
> > rootports, and create a new sysfs knob to let user decide if
> > Correctable Errors should be unmasked.
> 
> I don't think we should mask Correctable Errors by default.  Even
> though they've been corrected by hardware and no software action is
> required, I think these errors are valuable signals about Link
> integrity.
> 
> I think rate-limiting and/or reporting on the *frequency* of
> Correctable Errors would make a lot of sense.  We had some work
> toward
> this recently, but it hasn't quite gotten finished yet.
> 
> The most recent work I'm aware of is this:
> https://lore.kernel.org/r/20230606035442.2886343-1-grundler@chromium.org

Hi Kai-Heng, Bjorn,

I believe the rate limit will not alone fix the issue rather will act
as a work around. Without 04b12ef163d1, the VMD driver is not aware of
OS native AER support setting, then we will see AER flooding issue
which is a bug in VMD driver since it will always enable the AER.

There is a setting in BIOS that allows us to enable OS native AER
support on the platform. This setting is located in EDK Menu ->
Platform configuration -> system event log -> IIO error enabling -> OS
native AER support. I have verified that the above BIOS setting alters
the native AER flag of _OSC. We can also verify it on Kai-Heng's
system.

I believe instead of going in the direction of rate limit, vmd driver
should honor OS native AER support setting.

Do you have any suggestion on this?

nirmal
> 
> Bjorn


