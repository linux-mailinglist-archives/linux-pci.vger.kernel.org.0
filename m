Return-Path: <linux-pci+bounces-3318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B378501CF
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 02:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D054F1C21F80
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 01:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B633FFE;
	Sat, 10 Feb 2024 01:43:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9835D2114;
	Sat, 10 Feb 2024 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707529437; cv=none; b=T9B8P9YYa/H9VIj4idIHfpPiqveXkoHrkgJxi8ZUIZz6nK1jnVaeXCRWnLgc654lazzoYGDSG4E7uQ5EGu2yEhEQHveMKfD7azoV8r2TNQjv3QFeGuMwp3xS1rn3kn+4S24SGurOdNC15Qd9v2+Fn2rPes63CacD9ugDnZH8f5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707529437; c=relaxed/simple;
	bh=tbDTXG6zZ39Ikpk1c1jF/1KG49K8ShwLfURCjWgI4DM=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=iJc3a1HRfBdlN3LF2w2YI7gDVyqc3lSvAwBhzjPZUMg20ik3CEpgExDuZ15PzFrX/97j+hWIP3kk+MEaXg41l915H4l1gkqTI4CoS3T8vbgJXDdwwHRgFxHyHtM7mJpwzF6JyKqI7fhdMB2e9JmeEHQuVbal2oTyJpJ9RluCt8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9F8BF92009C; Sat, 10 Feb 2024 02:43:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 9239892009B;
	Sat, 10 Feb 2024 01:43:45 +0000 (GMT)
Date: Sat, 10 Feb 2024 01:43:45 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>
cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PCI: Rework error reporting with PCIe failed link
 retraining
Message-ID: <alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

 This patch series addresses issues observed by Ilpo as reported here: 
<https://lore.kernel.org/r/aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com/>, 
one with excessive delays happening when `pcie_failed_link_retrain' is 
called, but link retraining has not been actually attempted, and another 
one with an API misuse caused by a merge mistake.

 See individual change description for further details; 1/2 supersedes: 
<https://patchwork.kernel.org/project/linux-pci/patch/20240202134108.4096-1-ilpo.jarvinen@linux.intel.com/>, 
and 2/2 supersedes: 
<https://patchwork.kernel.org/project/linux-pci/patch/20240208132205.4550-1-ilpo.jarvinen@linux.intel.com/>.

 Unfortunately I cannot verify the changes anymore beyond just checking 
that the system `pcie_failed_link_retrain' was intended for still boots, 
because something happened that makes the problematic link not to work at 
all.

 The system was up for 88 days and the link continued working as I was 
logged in over a serial line wired through a PCIe serial option card 
further downstream and I communicated over the line just fine to log out 
in preparation for a reboot.  After reboot the link did not respond and 
after several further attempts, including reboots and power cycles, the 
link still does not respond, LBMS is never set and I couldn't ever observe 
LT being set either.  This affects U-Boot too, as previously it reported:

PCIE-0: Link up (Gen1-x8, Bus0)
PCI Autoconfig: 02.03.00: Downstream link non-functional
PCI Autoconfig: 02.03.00: Retrying with speed restricted to 2.5GT/s...
PCI Autoconfig: 02.03.00: Succeeded!

and now it only reports:

PCIE-0: Link up (Gen1-x8, Bus0)

 Interestingly enough the system had its mainboard replaced those 3 months 
ago to deal with an unrelated problem, and with the new mainboard in place 
I already had issues with the option cards downstream from the PCIe switch 
immediately wired to 02.03.0.  I had to rewire and reseat the adapter and 
cards several times before it started working reliably.  Maybe something 
has happened to the adapter board with the PCIe switch that caused it to 
stop working, hopefully permanently.  Perhaps it has something to do with 
the power supply connection, which is via an FDC/Berg connector, not my 
favourite one.

 I have four such adapter boards total, so I can try and see if I am able 
to revive the original one or use a replacement one, but it won't happen 
right away, as I have the system installed in a remote lab ~1000mi/1600km 
away from me.  I'll try to bring the system back to fully working order at 
the next opportunity, but it is inconvenient to me to travel there right 
now just to address this problem, so it'll be a couple of weeks and likely 
more before I am able to say something.  I hope it's not the new mainboard 
(PCIe devices in the other slots work just fine).

 Hopefully I'll be able fix it one way or another and will be able to 
report on LBMS behaviour too, that is whether it retriggers with every 
link training iteration or not.

 Meanwhile the patches are hopefully obvious enough to apply.

  Maciej

