Return-Path: <linux-pci+bounces-24288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 234BCA6B2C2
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 02:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A917A47CD
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 01:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0256C1E0DE3;
	Fri, 21 Mar 2025 01:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/pArheC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594A79461
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 01:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742522298; cv=none; b=DM93IH5dz9hHjBKNiMmOWoxkMP5KgBzCZD8iAucwwe4SVi76uXBqBGt5CwOCd2tivTIf+u+RTahm1YSQIyoFC06rXQSf6qV3eq/wc67skqt8rEu1wXC/rC9vQKBp5O9Fpb2ANQKscjaaypf8yyJFjgeDBVpRPbXcyEYZGX1LBxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742522298; c=relaxed/simple;
	bh=Ki8IqZy+loLjz5AEk1IkSp66lYLVmixHo1+BQe9suwM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=s/lh0381L/fjFIdkmEORekRUONXJPZ3hGF7UkBmDdiy6/RGiWPyC/b+TovtFHFpJEXrL3of4ibzMr+iCKPjXZW0LA+bX4CmUKyqmDHaVq0AO9+ApBbLrk/0DrNRLVOKnUgI+awYfDrxCUk6bF7Tqmb6Hb72LiCjYTrdTovPgGgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p/pArheC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-225429696a9so33251025ad.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 18:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742522294; x=1743127094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aHDqAOnLAs+o63QDke7lbKGOz4H5yc6KL5dGLO74KbM=;
        b=p/pArheCaCrTBue0ug1LwJZ6DaULxyMuEJmxoxApo8uxvKmqhwB1gZMYgfuCmRyo4x
         CX1Irk+r8x3Gtve5J2MDo9sZgJK0GPOSFzejsggKcKL9Bzus1lMS8wIMPLWRsnoklVSj
         SNECUoIjiLlwYFiC5np8oaRKI0hBiarK6/KAZco54gKWYKOitcsEret117f5zuQmYSEM
         UypDePVcTMDhJqa0HdJ118gpisenVrlf77ao9GxbClimDHw+WLoAuETjqPaTMNtcfP+I
         kY9u3mWo3kNED7+hj21Z9xHxQ7Skpeu6XJQGXFQYoIP1rBlVdZgGpT4q/2EXkNRARAsB
         rWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742522294; x=1743127094;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHDqAOnLAs+o63QDke7lbKGOz4H5yc6KL5dGLO74KbM=;
        b=wYR8jZPyT7KxOvn1gBbEsSsKhSswXhxk53GMH6+ZfjLDS5N82Q0SUgUg48HVUoxbjw
         bL6CaD3J2wv0HA+vlu1tNxrPl1xUdirj7D95rKRRVT4akL8iQWGpud5wgMMC3z4O9aqC
         Z6ffurZ2WQ7Wc+JupLJ1xgekdazlwH3ZzJO2F9iCwhp3uzJZhY2k7ROllktiiq3VmBei
         hxrG6bCpwW+PheXlcD9aIwKGdXqdW/IVADn7Uh3givjItja19ABbD6u068d6C0zN9Bvg
         AxDtcHrDR60YRF6Z8v224zMdyGJgIDm/sKmR8PagmwwUS60B29/+F/Q0AkriDx3s32ZP
         KARw==
X-Gm-Message-State: AOJu0YzzOO5MiFuEXJwsFhPIDuOTcvsSBrV2WPvfNGtuBz4ROK09lpMj
	gRWzcjXmZin5nukWvjMc0NiXbkKsZ3meuYMv+RoFUgBDJlP4D6FvJmBa4CamU3MaCzAFPM10PJR
	zig==
X-Google-Smtp-Source: AGHT+IHlybheH/LOazOeZt9XFMj+sZYrX9sxGES3nRs3LPdHnYF8Egsf31SxmIqbM9dW/Xw/IdHatMbyhH4=
X-Received: from pfbln22.prod.google.com ([2002:a05:6a00:3cd6:b0:737:79:e096])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1954:b0:736:546c:eb69
 with SMTP id d2e1a72fcca58-73905966986mr2143248b3a.9.1742522294535; Thu, 20
 Mar 2025 18:58:14 -0700 (PDT)
Date: Thu, 20 Mar 2025 18:57:58 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321015806.954866-1-pandoh@google.com>
Subject: [PATCH v5 0/8] Rate limit AER logs
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sargun Dhillon <sargun@meta.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Proposal
========

When using native AER, spammy devices can flood kernel logs with AER errors
and slow/stall execution. Add per-device per-error-severity ratelimits
for more robust error logging. Allow userspace to configure ratelimits
via sysfs knobs.

Motivation
==========

Inconsistent PCIe error handling, exacerbated at datacenter scale (myriad
of devices), affects repairabilitiy flows for fleet operators.

Exposing PCIe errors/debug info in-band for a userspace daemon (e.g.
rasdaemon) to collect/pass on to repairability services will allow for
more predictable repair flows and decrease machine downtime.

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
1-5 AER logging cleanup
6-8 Ratelimits and sysfs knobs

Outstanding work
================
Cleanup:
- Consolidate aer_print_error() and pci_print_error() path[6]

Roadmap:
- IRQ ratelimiting

v5:
- Handle multi-error AER by evaluating ratelimits once and storing result
- Reword/rename commit messages/functions/variable
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
- Added log level cleanup patch[7] from Karolina's series
- Fixed bug where dpc errors didn't increment counters
- "X callbacks suppressed" message on ratelimit release -> immediately
- Separate documentation into own patch

[1] https://bugzilla.kernel.org/show_bug.cgi?id=215027
[2] https://bugzilla.kernel.org/show_bug.cgi?id=201517
[3] https://bugzilla.kernel.org/show_bug.cgi?id=196183
[4] https://lore.kernel.org/linux-pci/20230606035442.2886343-2-grundler@chromium.org/
[5] https://lore.kernel.org/linux-pci/cover.1736341506.git.karolina.stolarek@oracle.com/
[6] https://lore.kernel.org/linux-pci/8bcb8c9a7b38ce3bdaca5a64fe76f08b0b337511.1742202797.git.karolina.stolarek@oracle.com/
[7] https://lore.kernel.org/linux-pci/edd77011aafad4c0654358a26b4e538d0c5a321d.1736341506.git.karolina.stolarek@oracle.com/

Jon Pan-Doh (6):
  PCI/AER: Move AER stat collection out of __aer_print_error()
  PCI/AER: Rename aer_print_port_info() to aer_printrp_info()
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
 drivers/pci/pci.h                             |   6 +-
 drivers/pci/pcie/aer.c                        | 282 +++++++++++++-----
 drivers/pci/pcie/dpc.c                        |   3 +-
 include/linux/pci.h                           |   2 +-
 7 files changed, 270 insertions(+), 74 deletions(-)
 rename Documentation/ABI/testing/{sysfs-bus-pci-devices-aer_stats => sysfs-bus-pci-devices-aer} (77%)

-- 
2.49.0.395.g12beb8f557-goog


