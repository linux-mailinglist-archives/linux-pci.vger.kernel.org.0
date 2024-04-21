Return-Path: <linux-pci+bounces-6500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E748AC0D6
	for <lists+linux-pci@lfdr.de>; Sun, 21 Apr 2024 21:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435C51F213C4
	for <lists+linux-pci@lfdr.de>; Sun, 21 Apr 2024 19:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9043F9D9;
	Sun, 21 Apr 2024 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pA5ujGR6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4C3EA73;
	Sun, 21 Apr 2024 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713726568; cv=none; b=FYqQwsGw2gz6ualTPP/2oxm9JZy3XWJH9J6XmVTkW3Ho5r38aIGGADw11juh10qLJPO7FnIuzdA/QD/5iGRzz1qtgFkIt8hvKphfyad4HXBbWCjqUFY0OhkpZQGKx8nP1i5RqvW01gpOPIo+rhaN6Ri/FHxKKf24dyXUtLP8yhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713726568; c=relaxed/simple;
	bh=Cg1eXO0eZNRYPj2a7qijOthKjtEPw18jmjNdvJvLi/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VhA/5mSOm8JXlLw1sBnp6rtQuvTwOAa+Qc3dTv84NfDvD/fZOtMpx/Ca1mY7KPKCP3UndpuxnUbM55I1IzXXuoGmF0/G7iPL9IQplPdGE5TRvFt+HRgevRE1ZIImE31+lqqOnZefgv62JnXjkdXRZZ0l9syB/tVGrZjqK6+5bcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pA5ujGR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10610C113CE;
	Sun, 21 Apr 2024 19:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713726567;
	bh=Cg1eXO0eZNRYPj2a7qijOthKjtEPw18jmjNdvJvLi/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pA5ujGR6O+RicashdOKTnXSJ6tMhHjCXt/2zQb8itsO7yEOogMV/1iF9dGN1YLc1D
	 EiBkI9Eak40xo6wntraDzxAkSYiczGW5Vs36B9zyptvmdXzMPg2bqzuFtLq3bMQd/v
	 GVhdhuc/WcG6q7JJ/9DQrtGcaHxPviHGE0QdDUH4r5jd+RjBS87pfpagNBzOihFqt2
	 qV3T9uCOZLURZI/pBgcRnfiKxOh089ZAJ20XwMqR0mSds0Da4fCJMNUpnM/26K8rQU
	 tZz2V5H5QORxJxfc+awPheGq9ISTd+2rUiNEkojfhbcqp8ZCy0+/JiGxrZ12+vZFE1
	 11q//awSIjvaw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Vidya Sagar <sagar.tv@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v7-incomplete 0/3] PCI: Add support for preserving boot configuration
Date: Sun, 21 Apr 2024 14:09:11 -0500
Message-Id: <20240421190914.374399-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418174043.3750240-1-vidyas@nvidia.com>
References: <20240418174043.3750240-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

This is Vidya's work; I started splitting it into separate patches.

This is based on v6
(https://lore.kernel.org/r/20240418174043.3750240-1-vidyas@nvidia.com) but
is missing a few pieces, so it's not complete yet.  I just wanted to show
the idea of what I had in mind.

The missing pieces are:

  - Set PCI_REASSIGN_ALL_BUS if !PCI_PROBE_ONLY

  - Use bridge->preserve_config instead of PCI_PROBE_ONLY

  - Change to use pci_assign_unassigned_root_bus_resources() instead of 
    pci_bus_size_bridge() and pci_bus_assign_resources()

Bjorn Helgaas (3):
  PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to
    pci_register_host_bridge()
  PCI: of: Add of_pci_preserve_config() for per-host bridge support
  PCI: Unify ACPI and DT 'preserve config' support

 drivers/acpi/pci_root.c | 12 ---------
 drivers/pci/of.c        | 60 ++++++++++++++++++++++++++++++++---------
 drivers/pci/pci-acpi.c  | 22 +++++++++++++++
 drivers/pci/pci.h       | 12 +++++++++
 drivers/pci/probe.c     | 14 ++++++++++
 5 files changed, 95 insertions(+), 25 deletions(-)

-- 
2.34.1


