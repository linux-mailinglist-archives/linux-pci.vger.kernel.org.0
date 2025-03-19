Return-Path: <linux-pci+bounces-24072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4415AA68715
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 09:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92515188D2AB
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 08:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C272615A85A;
	Wed, 19 Mar 2025 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xyoLY7UA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2939C24EF7D
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373660; cv=none; b=sORU8/KZ5JDHhE80/DcQ5fEG8pXCz10Z4KDF1WuanmBNxpt2TYJJVq9BL3oHBKiwah4gBftfR/apKGVt04dsevKdcAAZjGK7mwUFN71H4yFPQQBzgWOmIORTVlm9P/Q8Co0+oUlBR6+VTs60BNQ5bnAWE3QG9rBpNHh/FxTQvmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373660; c=relaxed/simple;
	bh=d/7dSLOwVK4SQyZGJ5xU/bEX1mTCtqM4vFgK5IH0rcM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WAQ2fFfpFBjG6WqkMCum1CwGe4vIagBZAjsRuL453MxaKRyNXelLlS8CFaG8Me87zF4+xnHVP4Bq+NbIqQmhrjHTgXjta9oqPMOEHFdh9GZ1DXjN0p94DsVLB4AVncVGuHdvhEQhosSXJ1qCE/sPy9i/s5FE2mJTyiDXw0kRSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xyoLY7UA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff8a2c7912so1035297a91.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 01:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742373658; x=1742978458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8DGNoL7CybCSP0f8gUzMjvsRtsxkjGkSgopo0IaV0Fk=;
        b=xyoLY7UAmBg8amyPX5n/aX6RkQ895i4RMVasturCGSAJKtj/8hciuk6Pwyed4ChpBz
         cAtibQUw1nkRSpCpEorMWffu+RmR+E063fwPdER1AUFlYI66c8mmm+NMHVMsuPxFieM6
         Y5L7qT12zpuJA5npiuCvLXwrQ4I2aY8/cUCxvtLBBLlnywYuPyDT/Dys8WeYjDgCi+xS
         1gtj4WK4nj67xYhUoTtlJXQSRnIMp41gWIk4lhmRdqsAmVKsL1RHOWNXMJvjkekPFS6/
         yrbdH4ju5+3U2QA5DzkLdRAPlCCPyLpjMrIpP48MRpBwwY+sXOtcTjVh8UAprSyZDB54
         YgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742373658; x=1742978458;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8DGNoL7CybCSP0f8gUzMjvsRtsxkjGkSgopo0IaV0Fk=;
        b=nzBW/+S+rTF8ZtvEffnMLko9KzlYdTWETPsDQCx4zru01VJeIA2DJB5mOC3rlAoOVf
         zTEvToMRhrZSXYyI7vrmFUFAy8Rk20Li+VxjNvtjnw+AQndV8zJq/pFXXxUO7iZ98LRM
         OmGHf8Wj8a3hNeTwDC0Hf9kVID+5Q5k363dUqMx70eE1G4+oqQfcvO5GeJeczbYiarIQ
         AD+JAiEljzyo9UPvV/g1ClBZ0inStmkz6sE259LtKQ3b7yXZx25ZVaPkADzGk7iUrE4W
         XkRAEo6cdqdtu4F9wABesJIObloNtdyBCVkkB5hepDPtn4Dy4O951jgg6+UM44qXhyKz
         T/Kw==
X-Gm-Message-State: AOJu0YzNazzl3FgxflLkf817UVRHzu6KTRf2nmXX5oZFdQ05OghGMP4L
	57pSOMWx6v0QXMxsDY9P7tA+GqJQfBv+AMw+/8xmqNIrBNbTXcz/5JjfwU5zD7yFlRESJgw2xcc
	22g==
X-Google-Smtp-Source: AGHT+IG2yH3QksnWU3hbt+aXBwYL7aPCgOL8Q0Dm6VNKvk3n4iLL9J7xBKqAEE+Eid13vS/di3kzJPx0c+k=
X-Received: from pjbee11.prod.google.com ([2002:a17:90a:fc4b:b0:2ea:46ed:5d3b])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:180c:b0:2fb:fe21:4841
 with SMTP id 98e67ed59e1d1-301a5b16c1bmr8401032a91.8.1742373658389; Wed, 19
 Mar 2025 01:40:58 -0700 (PDT)
Date: Wed, 19 Mar 2025 01:40:41 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319084050.366718-1-pandoh@google.com>
Subject: [PATCH v3 0/8] Rate limit AER logs
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
5-8 Ratelimits and sysfs knobs

Outstanding work
================
Cleanup:
- Consolidate aer_print_error() and pci_print_error() path

Roadmap:
- IRQ ratelimiting

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

Jon Pan-Doh (6):
  PCI/AER: Move AER stat collection out of __aer_print_error()
  PCI/AER: Rename struct aer_stats to aer_report
  PCI/AER: Introduce ratelimit for error logs
  PCI/AER: Add ratelimits to PCI AER Documentation
  PCI/AER: Add sysfs attributes for log ratelimits
  PCI/AER: Update AER sysfs ABI filename

Karolina Stolarek (2):
  PCI/AER: Check log level once and propagate down
  PCI/AER: Make all pci_print_aer() log levels depend on error type

 ...es-aer_stats => sysfs-bus-pci-devices-aer} |  34 +++
 Documentation/PCI/pcieaer-howto.rst           |  16 +-
 drivers/pci/pci-sysfs.c                       |   1 +
 drivers/pci/pci.h                             |   4 +-
 drivers/pci/pcie/aer.c                        | 276 +++++++++++++-----
 drivers/pci/pcie/dpc.c                        |   3 +-
 include/linux/pci.h                           |   2 +-
 7 files changed, 266 insertions(+), 70 deletions(-)
 rename Documentation/ABI/testing/{sysfs-bus-pci-devices-aer_stats => sysfs-bus-pci-devices-aer} (77%)

-- 
2.49.0.rc1.451.g8f38331e32-goog


