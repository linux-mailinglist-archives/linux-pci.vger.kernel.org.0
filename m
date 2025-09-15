Return-Path: <linux-pci+bounces-36158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BBBB57E3F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 16:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876FB1700A2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89BD2BDC09;
	Mon, 15 Sep 2025 13:58:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058E4288C27;
	Mon, 15 Sep 2025 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944703; cv=none; b=nU9WWd5FJiWXI1ng/V4MUOwYcMaBYdcv+Q/cJMTLD1KPCnbDGeT9eP//n/xuyLng0+WpoLGatKiLq9yOuPWSPBgFy067r9iZY3vf/cG3SjLTlqG6fVsD7GYXc5mDe3q0QPfQe5q6+Tdl3f633lMYe2agCSUTq3ar4XC08QPvyR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944703; c=relaxed/simple;
	bh=x/aEPn629sGbWXEZVt6Qurw2viseDOvEAhqqv1jBxHM=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=F6R8t2/XQoxKCaG6QW4ntfKxTaI60vE0ARZDkc4JE1iq5VInoQ2abgR5Jdq8OeLVb/N8xbyQq9kEXwq0YFr1iU5nYuK+3YNUoN7pwfP80v2I2foFsaXE5T0MQbeYNUhMVWNO20cm6dHk1myoNMAaFlTl7xm8NFimKpPjJtcXLLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with UTF8SMTPS id EBA2C2C1E640;
	Mon, 15 Sep 2025 15:51:02 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id CB93461248BC;
	Mon, 15 Sep 2025 15:51:02 +0200 (CEST)
X-Mailbox-Line: From db56b7ef12043f709a04ce67c1d1e102ab5f4e19 Mon Sep 17 00:00:00 2001
Message-ID: <cover.1757942121.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 15 Sep 2025 15:50:00 +0200
Subject: [PATCH v2 0/4] Documentation: PCI: Update error recovery docs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Bjorn Helgaas <helgaas@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Terry Bowman <terry.bowman@amd.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Linas Vepstas <linasvepstas@gmail.com>, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, "Oliver OHalloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, Brian Norris <briannorris@chromium.org>

Fix deviations between the code and the documentation on
PCIe Advanced Error Reporting.  Add minor clarifications
and make a few small cleanups.

Changes v1 -> v2:
* In all patches, change subject prefix to "Documentation: PCI: ".
* In patch [3/4], mention s390 alongside powerpc (Niklas).

Link to v1:
https://lore.kernel.org/all/cover.1756451884.git.lukas@wunner.de/

Lukas Wunner (4):
  Documentation: PCI: Sync AER doc with code
  Documentation: PCI: Sync error recovery doc with code
  Documentation: PCI: Amend error recovery doc with DPC/AER specifics
  Documentation: PCI: Tidy error recovery doc's PCIe nomenclature

 Documentation/PCI/pci-error-recovery.rst | 43 ++++++++++---
 Documentation/PCI/pcieaer-howto.rst      | 81 +++++++++++-------------
 2 files changed, 72 insertions(+), 52 deletions(-)

-- 
2.51.0


