Return-Path: <linux-pci+bounces-17052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060B99D18EA
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 20:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B777282AF6
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 19:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD511E4928;
	Mon, 18 Nov 2024 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJqbrK9f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881C1E5718
	for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731958234; cv=none; b=I2zlUKyuv+l7/gGlpprvPPqL/xpvizlcMkETUDyqzlV41fZ7iex8oaGesVi6fqmzv2e+uYvSPy3yh2j//VQIZpLRT4WsOfvmBYL80gKa9QBi07n+kiqhF4SGXGJW0BnD7dT8HDhAtzWIUeSS6NeeuFei5eNrzxTLehIWB9A2OKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731958234; c=relaxed/simple;
	bh=TXHvwthUxyKkucy030t7OQ/t8utulAiGHXcKf+Rfzo0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Hc+ihhIMty/Aa70cCFBNsKKiI85UAFFGD9QkP5/zhXGpS85eZbk5M5UJhIqmi0PRUKXCSl7+2+Y+xkWfXlRSWeBLo+87k7ngI5k0kmDalTtHv+WMOrh6p0mUrgttuHqIjUfqsP6NXoW8ofrXTN2hel6OjrTn20iH0qlERsphF1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dJqbrK9f; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ee76304cb4so4095117b3.1
        for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2024 11:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731958232; x=1732563032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3CLLTznJHtiA3Z7FprTvybK93w9NP6cqpZVxzAkyep8=;
        b=dJqbrK9f/U8dtM2jSVw5t12edEhISxMfGATl/mNlKKL54GKNjjh3eD+VzWh1jEoNM4
         +K/NiQSvt0p+Fn2lMlB71jRJdZn3mb4fcShPJfvoWkIg66aWjUgrE7mXPiS1HWokjiPe
         YDYLqJ5TTkNl0+2v92LzgEDkT63BJxywsm1ilsxtBe/GwHHjW2kQ+/PgkiJj4RpkqAYx
         HaoR/WOWwVxw11cXCN1GATFN4GhI5i33teeyARiAUQPSrJaJKZhK+ogf70O4FC8zgB5P
         ShI7TvHMLFCf/mYx6OhazNLZ7N1addOxK1XIpZn4NNLtGNFhGEKa10w/+KYDAN50qNx8
         6dwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731958232; x=1732563032;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CLLTznJHtiA3Z7FprTvybK93w9NP6cqpZVxzAkyep8=;
        b=iAKi6+Xp9sC0fHnQR97fMAI1rB/WTVd6tpfORZLwaTA3M3tQwmPA060yKTkB7zrVpm
         462s8v9Wv//qLwH21mRZeLpLQ10QLaW2ej5osWOVJi132rd8lppCyOu+CJRQZ71CUza8
         Urw/oqm3Y1uv078JRBJIY0WXGfiRgQ1R/j2zqfA8/3h50QNEYU7Uwl7ImnoYumCrpMOt
         Ag++4S7w6C2IOp+FxrOqOEDjXHpKe50w4R+dFYMEbxRQnxQ6y1/36HuQn9SVOf8IO2aS
         8QnHmf15GwFE5Zs34/N3fNiW2/ocoywWbBzwvQJxhT9QOF1Yt8m7dD/aVDrsPkxWefuR
         ycCA==
X-Forwarded-Encrypted: i=1; AJvYcCVhBnTK4wv/C2GR1fly2qVcPBP1E6abyY/V+wYtE3kuAQl/6YP1HjRgs4xcHrDYgkYGzpphCNRxL2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YziNmw8pZtpgB9yXTyF2uMARkbchVApBf7tS8mg9rOzuabD9Bs6
	ihpOPmP9OZQ+7TqXrPT8NzlOSBM/RnLfYVlkhvCZSHi/xgJrvcHAT0c4BMD5a2JaKSNv48TEBjd
	3+5phdA==
X-Google-Smtp-Source: AGHT+IGI12rDi2j2Em3Uzj0nPxjRZJXlGUUwEV7OobEm70WjZPuHminqW6f0I+E4Dxk+zPq/CiUJPuqKcuZI
X-Received: from jperaza.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:f86])
 (user=jperaza job=sendgmr) by 2002:a05:690c:8b14:b0:6e2:12e5:356f with SMTP
 id 00721157ae682-6ee55c5a91bmr477037b3.3.1731958232230; Mon, 18 Nov 2024
 11:30:32 -0800 (PST)
Date: Mon, 18 Nov 2024 19:30:22 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241118193024.2695876-1-jperaza@google.com>
Subject: [v8 PATCH 0/2] PCI/ACPI: Support Microsoft's "DmaProperty"
From: Joshua Peraza <jperaza@google.com>
To: gregkh@linuxfoundation.org
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, dtor@google.com, 
	dwmw2@infradead.org, helgaas@kernel.org, iommu@lists.linux-foundation.org, 
	jean-philippe@linaro.org, joro@8bytes.org, jperaza@google.com, 
	jsbarnes@google.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	mika.westerberg@linux.intel.com, oohall@gmail.com, pavel@denx.de, 
	rafael.j.wysocki@intel.com, rafael@kernel.org, rajatja@google.com, 
	rajatxjain@gmail.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

This patchset rebases two previously posted patches supporting
recognition of Microsoft's DmaProperty.

v8: Joshua renames untrusted_dma to requires_dma_protection and updates
some comments, reducing use of the word "trust" to refer to PCI devices
and matching the word choice in Microsoft's documentation.

v7: Rajat updates a comment with Robin's suggestion. Joshua re-sends and
Greg requests clarity and documentation on why untrusted_dma is the
right name.

v6: Rajat renames pci_dev_has_dma_property and links to Microsoft's
documentation in the commit message. Robin suggests clarifying a
comment.

v5: Rajat changes the name to untrusted_dma. Bjorn suggesting changing
another function's name pci_acpi_check_for_dma_protection to
pci_dev_has_dma_property and seeks clarified documentation.

v4: Rajat changes the name to poses_dma_risk. Christoph suggests this
name doesn't capture the intent as well as untrusted_dma and Rafael
agrees.

v1,v2,v3: Greg suggests that (un)trusted is the wrong word for referring
to PCI devices, recommending a name something like "platform wants to
protect dma access for this device."


Rajat Jain (2):
  PCI/ACPI: Support Microsoft's "DmaProperty"
  PCI: Rename pci_dev->untrusted to pci_dev->requires_dma_protection

 drivers/acpi/property.c     |  3 +++
 drivers/iommu/amd/iommu.c   |  3 +--
 drivers/iommu/dma-iommu.c   | 16 ++++++++--------
 drivers/iommu/intel/iommu.c | 10 +++++-----
 drivers/iommu/iommu.c       |  5 ++---
 drivers/pci/ats.c           |  2 +-
 drivers/pci/pci-acpi.c      | 22 ++++++++++++++++++++++
 drivers/pci/pci.c           |  2 +-
 drivers/pci/probe.c         |  8 ++++----
 drivers/pci/quirks.c        |  4 ++--
 include/linux/pci.h         |  7 ++++---
 11 files changed, 53 insertions(+), 29 deletions(-)


base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
-- 
2.47.0.338.g60cca15819-goog


