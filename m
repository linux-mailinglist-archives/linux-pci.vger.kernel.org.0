Return-Path: <linux-pci+bounces-35083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AD1B3B465
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 09:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341AA685CD9
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 07:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807C326B76C;
	Fri, 29 Aug 2025 07:34:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303901BC5C;
	Fri, 29 Aug 2025 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756452863; cv=none; b=kfII5mAPVosCnDltD2sxsdImo9YN7UJt3myKcq4pZDHLPsAbDc8bphFzNfjCGPT/y9DvsVln7KqVB/6kKnFJxsE/JUtcm8icudKF+K4BF0XIpx18p0Fskpu1/HmkhzJJtvVt2na7Ira/YJKEkSDtButd4LPe67XbDxZV7Y0LR6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756452863; c=relaxed/simple;
	bh=nvTYPITPQx27Il3XgzdIdHVin35HyeQBeVK3b0nt+gs=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=BgeQYY1Qj7XCvCwFKTLx4hmYCiV8TSRMopp3PVqE6vBjppraCp6FUEB+r7s8lu43S6x3zgSv9wiC91mCl9dXBQjsHulnRk2cZ1sMIbR9DWX2OWX7+KYlVh/pIdloUlW8iZiCKliETEZO+kjeiePBbTHYZ38vPFSDFKTwfK+inoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with UTF8SMTPS id 0731018C47;
	Fri, 29 Aug 2025 09:25:04 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id D091A600AD9B;
	Fri, 29 Aug 2025 09:25:03 +0200 (CEST)
X-Mailbox-Line: From 3d6f5aa8634bd4d13f28b7ec6b1b8d8d474e3c69 Mon Sep 17 00:00:00 2001
Message-ID: <cover.1756451884.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 29 Aug 2025 09:25:00 +0200
Subject: [PATCH 0/4] PCI: Update error recovery documentation
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

The documentation on PCIe Advanced Error Reporting hasn't kept up with
code changes over the years.  This series seeks to remedy as many issues
as I could find.

Previous commits touching the documentation either prefixed the subject
with "Documentation: PCI:" or (when combined with code changes) "PCI/AER:"
or "PCI/ERR:".  I chose the latter for brevity and to avoid mentioning
"documentation" or "PCI" twice in the subject.  If anyone objects or
finds other mistakes in these patches, please let me know.  Thanks!

Lukas Wunner (4):
  PCI/AER: Sync documentation with code
  PCI/ERR: Sync documentation with code
  PCI/ERR: Amend documentation with DPC and AER specifics
  PCI/ERR: Tidy documentation's PCIe nomenclature

 Documentation/PCI/pci-error-recovery.rst | 42 +++++++++---
 Documentation/PCI/pcieaer-howto.rst      | 81 +++++++++++-------------
 2 files changed, 71 insertions(+), 52 deletions(-)

-- 
2.47.2


