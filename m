Return-Path: <linux-pci+bounces-27791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9F1AB86C1
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 14:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6B8A00837
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 12:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAD729B20D;
	Thu, 15 May 2025 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0MiLkKr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3262929B209;
	Thu, 15 May 2025 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313184; cv=none; b=XdyFXpSRZumyhri+D7tEAIn5s5NqUQ6Yzid94evVQb9RgsJSY4mNpUfeAcpZWyTgYjbxqTBT89T5AsZUh5Wo0MNrm4Z2rt1boi3/6ASZAX4xxRriJOVVnGLal/L+JV38lk/IiIuAIM3/EdIgVIF48T2lc1tvW0OSfm63L+G4E84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313184; c=relaxed/simple;
	bh=/SrqagrckwF6dgNkAoSXSSD6RhUeKwgwHwvPTIQ04bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SF0qcLCxtwcaRtOVsclbnr1oClex5nthT6YdzLVjZDAlv8+BsjmZ3MdHHbLPFNS65eegpfy439u8rmGMUMXtvIEwlgWmYvBRx40J6tRW65BOGdOdCTRDstlZoS7VOTXg+gduc0OxRei60ceOpaC5KoP8HYC04UzAiC25oldqojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0MiLkKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BD7C4CEF1;
	Thu, 15 May 2025 12:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313183;
	bh=/SrqagrckwF6dgNkAoSXSSD6RhUeKwgwHwvPTIQ04bY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D0MiLkKrQ0MoMun9OU8NJfFYgPyEd4w8monEHSuh9udnUPXC8txU0pcKl6twIcTs4
	 r0CoBn+RslTYElcxHXBK/VgXmces5xzGVTePXZLXHBrF+9y99nW/q/O6OfRMZ6DqsW
	 hoTtv1j8dXR1YN9EdmVNH8/V6tFnHL1W1I5fwk64dixlaSN+7LkqgmcE3U7M8thyfZ
	 g7UaU9ebXFMxNRrNG4CvLQErFY8eLsJEv04CwLk59E23N7NYl883AkJgEFssyVD82d
	 Yc4kFoimE5zQzliqu80chJ+yVM5AC/UARcZfxibwVws/hgPuCcnZfQTEQ9vg81FO0n
	 EIALOShswR1YQ==
From: Philipp Stanner <phasta@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/7] Docu: PCI: Update pcim_enable_device()
Date: Thu, 15 May 2025 14:46:00 +0200
Message-ID: <20250515124604.184313-4-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515124604.184313-2-phasta@kernel.org>
References: <20250515124604.184313-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_enable_device() is not related anymore to switching the mode of
operation of any functions. It merely sets up a devres callback for
automatically disabling the PCI device on driver detach.

Adjust the function's documentation.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 Documentation/driver-api/driver-model/devres.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index d75728eb05f8..9443911c4742 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -391,7 +391,7 @@ PCI
   devm_pci_remap_cfgspace()	: ioremap PCI configuration space
   devm_pci_remap_cfg_resource()	: ioremap PCI configuration space resource
 
-  pcim_enable_device()		: after success, some PCI ops become managed
+  pcim_enable_device()		: after success, PCI dev gets deactivated automatically
   pcim_iomap()			: do iomap() on a single BAR
   pcim_iomap_regions()		: do request_region() and iomap() on multiple BARs
   pcim_iomap_table()		: array of mapped addresses indexed by BAR
-- 
2.49.0


