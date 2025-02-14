Return-Path: <linux-pci+bounces-21410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66691A354C3
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 03:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01463AD4B7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 02:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0FBC2EF;
	Fri, 14 Feb 2025 02:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XA/Aexq+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DFA2AE97
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 02:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739500549; cv=none; b=SahD2thKmG6mm2r3VR6ZB1F+7SyYANUtjcnGFT3nHDT5oZTYG8WtKbHJaAwESyCCPHWQNL3OdaRyw9FsHB1QtpGDbmoNVPjqtHhWhS6DtiQl0bT0y7TCwWT+YbhJZc/shaMEIMK/ZdTlNV/COTLBGO+cZcR3HM6yk8fJGpc1YZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739500549; c=relaxed/simple;
	bh=w6rhhY0LBdAbZngShiG9PEv3OXkaShk/ko+UULE8gxA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q0oKU6vYEASe8q9uZNd55T2cz5oMwuLZgC00Qn9ZPMYcitI5xC6nnMtIqjdxmk1OONnn/80CBh0Vy3thKMFOeE3TjbClISN9kBvuE73kBdAtpNdtmi/JvSPMpjnYaSYSwB+PnL8WVlM9rIyC6Ys6KNYfIseNn7v/Y7ySL1jlwqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XA/Aexq+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f6890d42dso51427105ad.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 18:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739500547; x=1740105347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+zDOWV0S1hZy5Y+eZiQjxwgjJSy/QDfNy15NSVlYViU=;
        b=XA/Aexq+nGg6a26dsBZKbSBL5ofVDhYO6KhvqnAHpBY9i6kntiHzZ3U5hQ16/+cDPo
         xdFU3ELGzHxdnKxTMf3GlyBbGxZ2acJnD1yIitIrdzvqHP7VaE7JgbvT0ihQvR2+tooo
         rVoKMifDdcr9SHgpb0td+IuihRWVp/bASH4OzHkhVHoZglMGpmLS7wTSo2gbbyGy4p2u
         9LGI+Wr477R3HqEhZSSeLf5wKTDQUpBWI1C5hpZkVOL1F2a4bo6SdumNF64hyzZRO8S9
         3iU7+eH0tvY39dRqKRI9kUizdY4tUc7gMK5B0mCJ25Q3mG+0NKPJKDeYXrula6SeW1Nf
         zR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739500547; x=1740105347;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+zDOWV0S1hZy5Y+eZiQjxwgjJSy/QDfNy15NSVlYViU=;
        b=joXFhDOj637P7Jy33439UIq6VzT/9d4m3/uW/nRYI/WlgIppqqdiGWTONW92Thbhnj
         YAt4rANssI/CQ/Cy7hswUh4Ua3UEJG8uasm9F3p9OJUSDcYSnEq3Cwg+UJ3r7r/nhZqW
         O17uYvDaaBuvb2kzcn26XkLJHbDyE6+DPFCvVQJbeHBhzsvrPVyTDoWJoLx4fvB5zwO4
         6QbvZuZ/W8JjjI7vdUy156D/eNvnj94sTlNeMEjfbUcdy8tv7+vY/tsWVgStM7DV3cTf
         4hfdURkipXdK4jS/XsTfSKk1OR9N7VmusKLXpahgq6e/X/E+JOvtk7ylOWelTxzXfHMU
         3F2w==
X-Gm-Message-State: AOJu0YwPq7lPwUq3ifhLVnSW7kHQP6M+IoXgD90UwiJdxCl6etrT0tb+
	5pNufVfV50tYMfrkK2QXWiPL9b1tPpc1vVggWDVjc7HaVX9AtEiSMM2+fnQw0HPbHc8LeIHuSzO
	+Zw==
X-Google-Smtp-Source: AGHT+IH69Hjo0QyOUOe6MefqyzXUDvLftQyBacAiv7Tqut+hJrKi5ngrL/8VZrqUyLRwio8mw8p5Ft0vdvg=
X-Received: from plzt5.prod.google.com ([2002:a17:902:bc45:b0:220:ce35:8d3b])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8c6:b0:21f:617a:f1b2
 with SMTP id d9443c01a7336-220d21616famr98825905ad.46.1739500546729; Thu, 13
 Feb 2025 18:35:46 -0800 (PST)
Date: Thu, 13 Feb 2025 18:35:35 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214023543.992372-1-pandoh@google.com>
Subject: [PATCH v2 0/8] Rate limit AER logs
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jon Pan-Doh <pandoh@google.com>
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

Jon Pan-Doh (7):
  PCI/AER: Remove aer_print_port_info
  PCI/AER: Move AER stat collection out of __aer_print_error
  PCI/AER: Rename struct aer_stats to aer_report
  PCI/AER: Introduce ratelimit for error logs
  PCI/AER: Add ratelimits to PCI AER Documentation
  PCI/AER: Add AER sysfs attributes for log ratelimits
  PCI/AER: Update AER sysfs ABI filename

Karolina Stolarek (1):
  PCI/AER: Use the same log level for all messages

 ...es-aer_stats => sysfs-bus-pci-devices-aer} |  20 ++
 Documentation/PCI/pcieaer-howto.rst           |  13 +-
 drivers/pci/pci-sysfs.c                       |   1 +
 drivers/pci/pci.h                             |   4 +-
 drivers/pci/pcie/aer.c                        | 194 ++++++++++++------
 drivers/pci/pcie/dpc.c                        |   3 +-
 include/linux/pci.h                           |   2 +-
 7 files changed, 169 insertions(+), 68 deletions(-)
 rename Documentation/ABI/testing/{sysfs-bus-pci-devices-aer_stats => sysfs-bus-pci-devices-aer} (85%)

-- 
2.48.1.601.g30ceb7b040-goog


