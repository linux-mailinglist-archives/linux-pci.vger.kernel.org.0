Return-Path: <linux-pci+bounces-26728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF030A9C359
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 11:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC111653BA
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 09:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC93236426;
	Fri, 25 Apr 2025 09:25:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3246D2356CD
	for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745573133; cv=none; b=XHt4SDtL20FCWQQn73/AJu6J/RqrK3K9Og4l61cipH4Yc8/x6nF9gAhT3UEne13u9llEnt2PVlc67cuXXRivGOH9TgG78B+x3LQ7Q/nGfEkzzRW+55/MTPEktZbX6wIfRxnj5ucSXxXBzjrewduCb7Yj8/B24yjDHQuKrt5pK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745573133; c=relaxed/simple;
	bh=cDc9UhmmFN+11WuHEXxb1Wwaeiuj09fWDbTMRwVZMEU=;
	h=Message-Id:From:Date:Subject:To:Cc; b=flgkjkVYBku5ZOAhb5AYFjDZuFi3fK+2F18xfxrwwLZzbLEPbVXnQXqpWflNvSSo46q2qaOhc9JdadKEgELfXTlP2D7TbBe68GdENdG5HYT4HtO577ciCmu4fqfXXp5v8p2xeRoo8OVwNJCdVBOhM9KQjAaAa/TXGOQzuYnL+Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 974AD2C4C3F1;
	Fri, 25 Apr 2025 11:24:55 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 31C6018E80; Fri, 25 Apr 2025 11:25:22 +0200 (CEST)
Message-Id: <cover.1745572340.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 25 Apr 2025 11:24:20 +0200
Subject: [PATCH 0/2] PCI: Clean up match_driver flag usage
To: Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev, Borislav Petkov <bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

A small puzzle piece to improve maintainability of the PCI core:

The match_driver flag in struct pci_dev is used to postpone driver
binding until all PCI devices have been enumerated.

The AMD IOMMU driver fiddles with the flag to work around breakage
introduced 10 years ago.  The breaking change has since been reverted,
so accessing the flag appears to be superfluous and is hereby dropped
(patch [1/2]).  The patch needs an ack from AMD IOMMU maintainers.

This clears the way for moving the flag to struct pci_dev's priv_flags
and thus prevent any further abuse outside the PCI core (patch [2/2]).

There are already two patches queued up in this cycle which amend
priv_flags with new definitions for bits 4, 5 and 6 (on the pci/hotplug
and pci/bwctrl topic branches), hence the bit number used here is 7.

Lukas Wunner (2):
  Revert "iommu/amd: Prevent binding other PCI drivers to IOMMU PCI
    devices"
  PCI: Limit visibility of match_driver flag to PCI core

 drivers/iommu/amd/init.c |  3 ---
 drivers/pci/bus.c        |  4 +++-
 drivers/pci/pci-driver.c |  2 +-
 drivers/pci/pci.h        | 11 +++++++++++
 drivers/pci/probe.c      |  1 -
 include/linux/pci.h      |  2 --
 6 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.47.2


