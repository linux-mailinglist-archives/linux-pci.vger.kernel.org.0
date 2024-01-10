Return-Path: <linux-pci+bounces-2008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF4982A09A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 20:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2547A1F220DE
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 19:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50874D590;
	Wed, 10 Jan 2024 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7nruqNC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE0541A86;
	Wed, 10 Jan 2024 19:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D23C433C7;
	Wed, 10 Jan 2024 19:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704913223;
	bh=anQjN0x5VGSmfBB0IWVmK180LXiah3BHUEKoVRwvMfU=;
	h=Date:From:To:Cc:Subject:From;
	b=g7nruqNCyn9ZKeYSfPvatg0/J1OWuB4JotRQaKHaT10ErQ7jrPOI49GWFBGSsbQ64
	 BeS4c3+jbHThShUvF9lgxUHUeALGsva7PreghaB+sm8XNtEooft9RkftmJ87mHQmJU
	 9GSpum7hONtjDF0m76Y7Dq0scplmp2YQfeSeaoUtRwv1P5dR4XW+CsKxngXbkUupQt
	 ek4NsbVmanVKVH0848odvsmlRcNuppnYotEatmdrBHQfev9eDLPWgru3WleTTV/LkZ
	 /SEaL2+Q2AfyJJDioF5DfZoB5Nrm+7HsjyQdoFTQaoQn98u80LYUNWnPuFZM8Rllwo
	 3J3gf5+U77b1Q==
Date: Wed, 10 Jan 2024 13:00:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sanath S <Sanath.S@amd.com>, shyam-sundar.s-k@amd.com,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [bugzilla-daemon@kernel.org: =?utf-8?Q?=5B?=
 =?utf-8?Q?Bug_218360=5D_New=3A_Disk_drive_of_TBT3=2FUSB4_storage_device_c?=
 =?utf-8?Q?an=E2=80=99t_show_up_i?= =?utf-8?Q?f?= connecting behind TBT3 dock
 or some USB4 docks DFP TBT port]
Message-ID: <20240110190021.GA2113949@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

#regzbot introduced: d3fcd7360338 ("PCI: Fix runtime PM race with PME polling")

Sanath, thank you very much for this report and the bisection!

I assume this happens on hot-adds, i.e., you boot the kernel, then
connect a USB4 dock, then connect the TBT3/USB4 storage device to the
dock?

Would you be able to attach the complete dmesgs log from working and
failing kernels?  The ideal would be from d3fcd7360338 ("PCI: Fix
runtime PM race with PME polling"), which fails, and 5cd903bce9dd
("PCI/VPD: Add runtime power management to sysfs interface"), which
presumably works.  But v6.7 and v6.5 is OK too.

Also the output of "sudo lspci -vv", which I assume doesn't depend on
which kernel you're running.

Bjorn

----- Forwarded message from bugzilla-daemon@kernel.org -----

Date: Wed, 10 Jan 2024 10:52:40 +0000
From: bugzilla-daemon@kernel.org
To: bjorn@helgaas.com
Subject: [Bug 218360] New: Disk drive of TBT3/USB4 storage device can’t show up if connecting behind TBT3 dock
	or some USB4 docks DFP TBT port
Message-ID: <bug-218360-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=218360

            Bug ID: 218360
           Summary: Disk drive of TBT3/USB4 storage device can’t show up
                    if connecting behind TBT3 dock or some USB4 docks DFP
                    TBT port
          Reporter: Sanath.S@amd.com

The disk drive of the TBT3/USB4 storage device can’t show up behind TBT3 dock
and some USB4 docks have a DFP TBT port.

TBT3/USB4 storage device can be authorized, the disk drive doesn’t show up.

Issue reproduce sequence: Connect USB4 dock to host → Connect TBT3/USB4 storage
device to dock DFP TBT3 port → TBT3/USB4 storage device disk driver can’t show
up.

The issue was observed in the latest mainline kernel 6.7.


Failing on all the below combination

HP Thunderbolt Dock 120W G2 HSN-IX01    
HP Hook 2.0 USB4/TBT4 Dock (PV Phase)   
CalDigit TS3Plus+ Thunderbolt Station 3 Plus    
Dell Thunderbolt Dock – WD19TB

