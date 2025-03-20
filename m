Return-Path: <linux-pci+bounces-24199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EABA6A11E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF5D7B0B27
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621A92153C5;
	Thu, 20 Mar 2025 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YnUtPhMl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0C20B7F0
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458868; cv=none; b=Fk1TVnLXakFsFUOfMUIe3EJ118McmFjA6EP+Z1LLPe8AXad9/8ZogCoXEAYNVhmGqoFBXpcb26GLOBttAWUvQm+wNzTRz/zHjv1IhoCR2d9VSoQ512warsYTV8/Iql1keJIDHqNzRWh9aszobdENXDIyh6Jc9mbEaz3E6ofDxfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458868; c=relaxed/simple;
	bh=JemRQqQ/t+09egnr2q6Sif3jH42Xnx2oKbxYr4saI5Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SsDcQZXz2WKkKQyfKoH+/1QCt7TC4fBvAqqqWkGVEgd410hHcBgkmqD8L4ScBoY62lq6r6b0tQCQGnScQ6NoWnfkIWhljdtDNe4QioIV1UKehubXms/RPskFMu0VkbMLjWC2cpV+vvZJIqMQlvnWJpzi4j1ss8wSF5ouJHNIQ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YnUtPhMl; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2c2d24b3947so1211363fac.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742458864; x=1743063664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ymnTWwlrA8Y21fufRd7ZhH6/snRfjWep3m0g3sqIRjg=;
        b=YnUtPhMlWT4R4+YucbTKStYmflVmeaLPuDj3d+39gYbMdBuUhrRa6GkRpJj0USkgic
         GeuZHOfwSYNW1VD8M04oCz/1swARfMfGXqaq5YmOLv+vBO9J3xCOsYsYcZXRF7vcNAZU
         MKqnngf2dX45gQI52DKK4miOLhx5jXrtgwqBEfZoNm6bNh1K6mCFGkhkSZqAr3Xfv6zf
         JAnqeziL6OjITRXQPir7XO/WIREWA2vF134qx9wlHjWPESdfBPK5aCJC16C/Zdi3LKq2
         F42GIqm2EVCSpkalYtSQQj76C3tRIfhZTm97L7SEBDu0kPf4J6ral+Cw13PP4zaikZ1B
         pidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458864; x=1743063664;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ymnTWwlrA8Y21fufRd7ZhH6/snRfjWep3m0g3sqIRjg=;
        b=CQRyihQlMUZsoDGle2CB/2cczraaJ9ogIBLwR/SLqLYGwNbhQr6ollGCLSa6zvWEpR
         RvUqJ3UthcbKGyu1W4xJ/3sCyo3UP80VCy/OqEasgFRnRV1PNurpomudAjxsjf3jD1E7
         3FPqdB4SmwD22JMxpKjogYoWpW4Tr2yOSwZLO2KTc/aihF2x8RQ/r2e6wRVTVgJjDqpK
         SIzl51ZzwrTUo6d9V6jsCnVgHav34huZ9iBkfnTYIfgh+fN4wlbh1vKHElVEP8C4QePm
         nRhyPVHfAlQzgWv38tNXBuH34EFd2vjGYq5d/FVWA5t9NqGGXxHRMYAi5JRap6b6hqZB
         QiQg==
X-Gm-Message-State: AOJu0YxA/8xzyX4/A8jQPQpfYyuh+lehhAg6U60J6AohMeiHw4WiuTmt
	totCIHSuoXyaBbyiqjJUUW92iYHrbS+sVWllftgOKxvJ1n1XsDFpOOS1JZkU7MIXr98QJjdWfID
	J+w==
X-Google-Smtp-Source: AGHT+IET/vWE8GhkdC+uJp1id8qG7sDUa8mQ2ileIVE+bujx5DzFyztxhtXWcBCjg9oF9Bd49Nt/7dg3310=
X-Received: from oabsc21.prod.google.com ([2002:a05:6871:2215:b0:2bc:6ba1:58a4])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:e98:b0:2c1:556f:f752
 with SMTP id 586e51a60fabf-2c760682a0amr1329480fac.0.1742458864680; Thu, 20
 Mar 2025 01:21:04 -0700 (PDT)
Date: Thu, 20 Mar 2025 01:20:50 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320082057.622983-1-pandoh@google.com>
Subject: [PATCH v4 0/7] Rate limit AER logs
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <Terry.bowman@amd.com>, 
	Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Proposal
========

When using native AER, spammy devices can flood kernel logs with AER errors
and slow/stall execution. Add per-device per-error-severity ratelimits
for more robust error logging. Allow userspace to configure ratelimits
via sysfs knobs.

Motivation
==========

Several OCP members have issues with inconsistent PCIe error handling,
exacerbated at datacenter scale (myriad of devices).
OCP HW/Fault Management subproject set out to solve this by
standardizing industry:

- PCIe error handling best practices
- Fault Management/RAS (incl. PCIe errors)

Exposing PCIe errors/debug info in-band for a userspace daemon (e.g.
rasdaemon) to collect/pass on to repairability services is part of the
roadmap.

Background
==========

AER error spam has been observed many times, both publicly (e.g. [1], [2],
[3]) and privately. While it usually occurs with correctable errors, it can
happen with uncorrectable errors (e.g. during new HW bringup). 

There have been previous attempts to add ratelimits to AER logs ([4],
[5]). The most recent attempt[5] has many similarities with the proposed
approach.

Patch organization
==================
1-4 AER logging cleanup
5-7 Ratelimits and sysfs knobs

Outstanding work
================
Cleanup:
- Consolidate aer_print_error() and pci_print_error() path

Roadmap:
- IRQ ratelimiting

v4:
- Fix bug where trace not emitted with malformed aer_err_info
- Extend ratelimit to malformed aer_err_info
- Update commit messages with patch motivation
- Squash AER sysfs filename change (Patch 8)
v3:
- Ratelimit aer_print_port_info() (drop Patch 1)
- Add ratelimit enable toggle
- Move trace outside of ratelimit
- Split log level (Patch 2) into two
- More descriptive documentation/sysfs naming
v2:
- Rebased on top of pci/aer (6.14.rc-1)
- Split series into log and IRQ ratelimits (defer patch 5)
- Dropped patch 8 (Move AER sysfs)
- Added log level cleanup patch[6] from Karolina's series
- Fixed bug where dpc errors didn't increment counters
- "X callbacks suppressed" message on ratelimit release -> immediately
- Separate documentation into own patch

[1] https://bugzilla.kernel.org/show_bug.cgi?id=215027
[2] https://bugzilla.kernel.org/show_bug.cgi?id=201517
[3] https://bugzilla.kernel.org/show_bug.cgi?id=196183
[4] https://lore.kernel.org/linux-pci/20230606035442.2886343-2-grundler@chromium.org/
[5] https://lore.kernel.org/linux-pci/cover.1736341506.git.karolina.stolarek@oracle.com/
[6] https://lore.kernel.org/linux-pci/edd77011aafad4c0654358a26b4e538d0c5a321d.1736341506.git.karolina.stolarek@oracle.com/

Jon Pan-Doh (5):
  PCI/AER: Move AER stat collection out of __aer_print_error()
  PCI/AER: Rename struct aer_stats to aer_report
  PCI/AER: Introduce ratelimit for error logs
  PCI/AER: Add ratelimits to PCI AER Documentation
  PCI/AER: Add sysfs attributes for log ratelimits

Karolina Stolarek (2):
  PCI/AER: Check log level once and propagate down
  PCI/AER: Make all pci_print_aer() log levels depend on error type

 ...es-aer_stats => sysfs-bus-pci-devices-aer} |  34 +++
 Documentation/PCI/pcieaer-howto.rst           |  16 +-
 drivers/pci/pci-sysfs.c                       |   1 +
 drivers/pci/pci.h                             |   4 +-
 drivers/pci/pcie/aer.c                        | 271 +++++++++++++-----
 drivers/pci/pcie/dpc.c                        |   3 +-
 include/linux/pci.h                           |   2 +-
 7 files changed, 260 insertions(+), 71 deletions(-)
 rename Documentation/ABI/testing/{sysfs-bus-pci-devices-aer_stats => sysfs-bus-pci-devices-aer} (77%)

-- 
2.49.0.rc1.451.g8f38331e32-goog


