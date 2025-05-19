Return-Path: <linux-pci+bounces-28015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6996ABCA1A
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBDE3B1D35
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 21:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122512206BB;
	Mon, 19 May 2025 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD/alx/9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F62206B7;
	Mon, 19 May 2025 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690611; cv=none; b=F0xQ/wbRT/gQ5O+RGlifciBqylVXUQEcFT/dObcPIqTHJlvr0Qch8px8UdXGlrGMWsuTVaN+FwK3XCisp7AVhyFssrYgDCHJ/5nXkj3ZCrQzJwvzvNhTE8tqrO7PuSzyhNLog+iQAqiNF9iMdwm5+KlcvUKBU/hV+qwurBWw7gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690611; c=relaxed/simple;
	bh=lBvl18LaQT+t/CXp3Ntta7x6/KSCyUwxhyyopGai6uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xm3UVLrpURyZFveuaP2R+hermxjizEl5kILzLQGMPgnaTgAay0B+VP3d3gYQtaBX9NZNkzms0FdPq8EVTaMrYnWnt1gVeBJMnvUX0I+XaHzKW/ykChmj3aJIfhbecOfK4dEtwDGVklrYaZx6k0aMNpUFIQhw0qa7YBCeazU4ihU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dD/alx/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17725C4CEE9;
	Mon, 19 May 2025 21:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690610;
	bh=lBvl18LaQT+t/CXp3Ntta7x6/KSCyUwxhyyopGai6uQ=;
	h=From:To:Cc:Subject:Date:From;
	b=dD/alx/9EyoI+LMRQbvbxI4Sy1XdxACArzosYw1zQvMczIvgYvmog5PH2i0Jcczh0
	 UoRzP7Q+sEAMiG5VPG6IrFd1ver77ke/Rae2FQrAH2VtYZlrn2LL4phpvOCbquhNvD
	 VcTDYu+JHgKjOrjHY3Bc4goGN3Na6xqarBfneBwMsOcnLHFQNraqmIDeJ6DF1HAObQ
	 BWYEhOyr7TeUwPRdm8JVEaO4vskMbW20ivYTqNFeGbjlN3X+a9TUuVFvYdkAgrhoQ3
	 SopSTEV0eIL8CrzU3vqFCtpZVoUhkz7TN2eyGGfUKJzTzUeC8bxE+CvCzYCv2G1ymD
	 jzqSkM/vVWRtw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v6 00/16] Rate limit AER logs
Date: Mon, 19 May 2025 16:35:42 -0500
Message-ID: <20250519213603.1257897-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

This work is mostly due to Jon Pan-Doh and Karolina Stolarek.  I rebased
this to v6.15-rc1, factored out some of the trace and statistics updates,
and added some minor cleanups.

Proposal
========

When using native AER, spammy devices can flood kernel logs with AER errors
and slow/stall execution. Add per-device per-error-severity ratelimits for
more robust error logging. Allow userspace to configure ratelimits via
sysfs knobs.

Motivation
==========

Inconsistent PCIe error handling, exacerbated at datacenter scale (myriad
of devices), affects repairabilitiy flows for fleet operators.

Exposing PCIe errors/debug info in-band for a userspace daemon (e.g.
rasdaemon) to collect/pass on to repairability services will allow for more
predictable repair flows and decrease machine downtime.

Background
==========

AER error spam has been observed many times, both publicly (e.g. [1], [2],
[3]) and privately. While it usually occurs with correctable errors, it can
happen with uncorrectable errors (e.g. during new HW bringup).

There have been previous attempts to add ratelimits to AER logs ([4], [5]).
The most recent attempt[5] has many similarities with the proposed
approach.


v6:
- Rebase to v6.15-rc1
- Initialize struct aer_err_info completely before using it
- Log DPC Error Source ID only when it's valid
- Consolidate AER Error Source ID logging to one place
- Tidy Error Source ID bus/dev/fn decoding using macros
- Rename aer_print_port_info() to aer_print_source()
- Consolidate trace events and statistic updates to one non-ratelimited place
- Save log level in struct aer_err_info instead of passing as parameter
v5: https://lore.kernel.org/r/20250321015806.954866-1-pandoh@google.com
- Handle multi-error AER by evaluating ratelimits once and storing result
- Reword/rename commit messages/functions/variable
v4: https://lore.kernel.org/r/20250320082057.622983-1-pandoh@google.com
- Fix bug where trace not emitted with malformed aer_err_info
- Extend ratelimit to malformed aer_err_info
- Update commit messages with patch motivation
- Squash AER sysfs filename change (Patch 8)
v3: https://lore.kernel.org/r/20250319084050.366718-1-pandoh@google.com
- Ratelimit aer_print_port_info() (drop Patch 1)
- Add ratelimit enable toggle
- Move trace outside of ratelimit
- Split log level (Patch 2) into two
- More descriptive documentation/sysfs naming
v2: https://lore.kernel.org/r/20250214023543.992372-1-pandoh@google.com
- Rebased on top of pci/aer (6.14.rc-1)
- Split series into log and IRQ ratelimits (defer patch 5)
- Dropped patch 8 (Move AER sysfs)
- Added log level cleanup patch[7] from Karolina's series
- Fixed bug where dpc errors didn't increment counters
- "X callbacks suppressed" message on ratelimit release -> immediately
- Separate documentation into own patch
v1: https://lore.kernel.org/r/20250115074301.3514927-1-pandoh@google.com

[1] https://bugzilla.kernel.org/show_bug.cgi?id=215027
[2] https://bugzilla.kernel.org/show_bug.cgi?id=201517
[3] https://bugzilla.kernel.org/show_bug.cgi?id=196183
[4] https://lore.kernel.org/linux-pci/20230606035442.2886343-2-grundler@chromium.org/
[5] https://lore.kernel.org/linux-pci/cover.1736341506.git.karolina.stolarek@oracle.com/
[6]
https://lore.kernel.org/linux-pci/8bcb8c9a7b38ce3bdaca5a64fe76f08b0b337511.1742202797.git.k
arolina.stolarek@oracle.com/
[7]
https://lore.kernel.org/linux-pci/edd77011aafad4c0654358a26b4e538d0c5a321d.1736341506.git.k
arolina.stolarek@oracle.com/


Bjorn Helgaas (9):
  PCI/DPC: Initialize aer_err_info before using it
  PCI/DPC: Log Error Source ID only when valid
  PCI/AER: Consolidate Error Source ID logging in aer_print_port_info()
  PCI/AER: Extract bus/dev/fn in aer_print_port_info() with
    PCI_BUS_NUM(), etc
  PCI/AER: Move aer_print_source() earlier in file
  PCI/AER: Initialize aer_err_info before using it
  PCI/AER: Simplify pci_print_aer()
  PCI/AER: Update statistics early in logging
  PCI/AER: Combine trace_aer_event() with statistics updates

Jon Pan-Doh (4):
  PCI/AER: Rename aer_print_port_info() to aer_print_source()
  PCI/AER: Introduce ratelimit for error logs
  PCI/AER: Add ratelimits to PCI AER Documentation
  PCI/AER: Add sysfs attributes for log ratelimits

Karolina Stolarek (3):
  PCI/AER: Check log level once and remember it
  PCI/AER: Make all pci_print_aer() log levels depend on error type
  PCI/AER: Rename struct aer_stats to aer_report

 ...es-aer_stats => sysfs-bus-pci-devices-aer} |  34 ++
 Documentation/PCI/pcieaer-howto.rst           |  16 +-
 drivers/pci/pci-sysfs.c                       |   1 +
 drivers/pci/pci.h                             |   5 +-
 drivers/pci/pcie/aer.c                        | 346 ++++++++++++------
 drivers/pci/pcie/dpc.c                        |  49 ++-
 include/linux/pci.h                           |   2 +-
 7 files changed, 329 insertions(+), 124 deletions(-)
 rename Documentation/ABI/testing/{sysfs-bus-pci-devices-aer_stats => sysfs-bus-pci-devices-aer} (77%)

-- 
2.43.0


