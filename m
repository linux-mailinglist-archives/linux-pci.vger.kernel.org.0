Return-Path: <linux-pci+bounces-19835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 260D9A11B28
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6039D188AC96
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84D322F84F;
	Wed, 15 Jan 2025 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gi1pdFp2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FDD18952C
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736926992; cv=none; b=W/JGf96sb8YPvlkd1/tGfQ9FPUra8m5uH8dOx1M5xIo+P0W9KL9DiPRO39yVGAFY27Le4hEzKHxfwPDx3jyS3RQ/ZNHSWiD5km3+/pQyJLCK26W0kgM5nRsP33iLiz6NygWosrxA8j7Gx17lXi3kM2NJNthv+j1TekN6YPWMnJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736926992; c=relaxed/simple;
	bh=iyGutq3+Ejn4wQyff+71qXKssr987DPAX9EtsU4EjB0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XodlwPdGQo+Ofb3uTRkU4skaHfgpLywCoS1h+kQtwVbt28zEuyOzNQuRTNN/xnRHO2WqqFX6W8UfD0aGeZ6GrRjKU/F/Uh4nYpZenxo+td9TMjg3zR5Lq9OHE4N3dpS+mD++KO5pf1zQBPrUGUe9swrKHAclHBhCy2ZedXgoWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gi1pdFp2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2166855029eso121386965ad.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 23:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736926990; x=1737531790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=imIGIAq8FnnIjNNQzaGAaNZSPz97kz7JBRa/BcjqERs=;
        b=gi1pdFp2wneCuKwtioAOk8Z1TSqwCFSVBWsSo0D0QxSa2tLUH/7vM3meGEeXzcfN1t
         RpBw8/5yxWpAlqJfHdvxQrKtJitNfKYz/SPVhB3c3G80PEgIBQc+16UCHKtyJ4tRaepJ
         d1KYwoQN4MqE3eq4BS0+QJScB9I6lm5p4dBTwcJTWsoxeC8RS/x43kw1MEtwSvOvQDhC
         vrDfwcBZ3kmgyWH9E+4aXRiND+C1j4nMSURje9A4YgduGlLwSaXx47fv8rEyX+txoKIL
         CpsJYLFynxXep0rg4qFoUuCXVGMMCxBNeHuRDpPW5sxit6iheRQTikUGsb3tjzifJ9Gf
         HnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736926990; x=1737531790;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=imIGIAq8FnnIjNNQzaGAaNZSPz97kz7JBRa/BcjqERs=;
        b=Ao6qLNbzudhxXfXKLt3RoODI6M5HHGyZ2AXTFHlt1JljrRe+siymy7ipPsT4Sfllcr
         DFu27gpUpYKlEfw7gNVkF6lBElXSaIGJjI/lshw4jm0kp5DBh1wF/P8KdyhfEEMeeOT1
         lEm46XyMrTgqJq0oUBlHDD5+b5rboys2Fvn7GG6Pu1BOcaGDkEZTDApqLpLNBHw551Tc
         4+xX5LyN/OU42ltN225d6HkZrQx68rOn71icVpfAjLDeW+gyGXzQwo0vpN2OtEsxqn8b
         quKZFHMHZw/08liG7jDdh7nF1y3D+PKW5W/6i2ZweZkGEU1G2jV3paUzfhKnWG4mTCA3
         dbTg==
X-Gm-Message-State: AOJu0YynL/CIjxqN1OtFUrDRbPi9Nrxxvb5rXgJpFjWAx6bZen8Rwxeg
	WtdPy7xD8aNeFr+w6ah1Csdjs93GwrFQkWpBAH7Zv9rUcHq9uOQfoBaLJ7ACrCoSHPqnBxMHqIe
	SBg==
X-Google-Smtp-Source: AGHT+IGxgEgmhSsgz2jtG32D2uiVufp5im7mzT7Ktpcqd1Rrl2a8qKI6e3oCcJ+AQV0Xsk9AJAi5ZUbvu7I=
X-Received: from pgbcq4.prod.google.com ([2002:a05:6a02:4084:b0:7fd:460b:daa3])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c88d:b0:1e1:c07b:b087
 with SMTP id adf61e73a8af0-1e88cf3bd46mr46344138637.0.1736926990383; Tue, 14
 Jan 2025 23:43:10 -0800 (PST)
Date: Tue, 14 Jan 2025 23:42:52 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250115074301.3514927-1-pandoh@google.com>
Subject: [PATCH 0/8] Rate limit AER logs/IRQs
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
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
1-3 AER logging cleanup
4-7 Ratelimits and sysfs knobs
8   Sysfs cleanup (RFC that breaks existing ABI/can be dropped)

Outstanding work
================
Cleanup:
- Consolidate aer_print_error() and pci_print_error() path
- Elevate log level logic out of print functions[6]

[1] https://bugzilla.kernel.org/show_bug.cgi?id=215027
[2] https://bugzilla.kernel.org/show_bug.cgi?id=201517
[3] https://bugzilla.kernel.org/show_bug.cgi?id=196183
[4] https://lore.kernel.org/linux-pci/20230606035442.2886343-2-grundler@chromium.org/
[5] https://lore.kernel.org/linux-pci/cover.1736341506.git.karolina.stolarek@oracle.com/
[6] https://lore.kernel.org/linux-pci/edd77011aafad4c0654358a26b4e538d0c5a321d.1736341506.git.karolina.stolarek@oracle.com/

Jon Pan-Doh (8):
  PCI/AER: Remove aer_print_port_info
  PCI/AER: Move AER stat collection out of __aer_print_error
  PCI/AER: Rename struct aer_stats to aer_info
  PCI/AER: Introduce ratelimit for error logs
  PCI/AER: Introduce ratelimit for AER IRQs
  PCI/AER: Add AER sysfs attributes for ratelimits
  PCI/AER: Update AER sysfs ABI filename
  PCI/AER: Move AER sysfs attributes into separate directory

 ...es-aer_stats => sysfs-bus-pci-devices-aer} |  50 +++-
 Documentation/PCI/pcieaer-howto.rst           |  10 +-
 drivers/pci/pci-sysfs.c                       |   2 +-
 drivers/pci/pci.h                             |   2 +-
 drivers/pci/pcie/aer.c                        | 227 +++++++++++++-----
 include/linux/pci.h                           |   2 +-
 6 files changed, 216 insertions(+), 77 deletions(-)
 rename Documentation/ABI/testing/{sysfs-bus-pci-devices-aer_stats => sysfs-bus-pci-devices-aer} (69%)

-- 
2.48.0.rc2.279.g1de40edade-goog


