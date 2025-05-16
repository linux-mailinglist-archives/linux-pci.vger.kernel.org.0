Return-Path: <linux-pci+bounces-27886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21521ABA204
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 19:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC4F47AEF18
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 17:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E1C27780A;
	Fri, 16 May 2025 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNrg7Foa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98CE2777F9;
	Fri, 16 May 2025 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417317; cv=none; b=T7nVzErd+hZ9pqYgRcl50C2zY2RBPWd4u2eDFZz3GKtXOGRx2+6HWIFnK+jIzUDPCYb+KvjFHtEVBLxh9uzjEqD7idcDHk8Qk1wG+KwmmPOE0TL0ao7cGt9BjM4Y2a/cb71qSQKc9WnFEBLrp2ySKdBiVHuQ+QOvxwiYRVsCZas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417317; c=relaxed/simple;
	bh=/SrqagrckwF6dgNkAoSXSSD6RhUeKwgwHwvPTIQ04bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFRauA+JVPPCrr2tmosTS3Er8cbrOdP9PvTLe2/4eVgtZPYVZzhjyYcvbWozE6QhqL/rNllgQXj7u+ykIIHs5exZakvjBOUC8uI84DN/KN6Aewnqz/KyPK5i/tUYHaJzKZdy2VF1e4UcN0Ri0ja1uJU8Vqm9P59UTm0tEG2jIcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNrg7Foa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2928BC4CEE4;
	Fri, 16 May 2025 17:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747417317;
	bh=/SrqagrckwF6dgNkAoSXSSD6RhUeKwgwHwvPTIQ04bY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LNrg7FoauNvW/3I8JfK2FOIE5Gchu1UoNxfRDahLQS49NSyuEzF4OyUBIg6Dgy3Fd
	 RV6xAkCTlqz+Nr+Hlo4toYUM0ogjW43wEkcAWfcVs2xxCA34iAMyYRDHc1207dCkCT
	 R9kQ2EG35KLj3JLb/mHnH07hw8IA7js7xwQs4n9kkXHnCX5nJH4acV4IXbEJO3yr2h
	 xDuBGFa6wqjWkELzE+WDk2RVUeBUP8CNiCuU8fYCDS3lYn/vLFZRpBAIartpuI4GEG
	 cA+dC3+YGWAn6wcrjVkHeWbroxk3hAPhYdcnaWdC6vaOLYl9k7RyuSEGY56AKMXfKk
	 T/SOmyD+7FEOA==
From: Philipp Stanner <phasta@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 2/6] Documentation/driver-api: Update pcim_enable_device()
Date: Fri, 16 May 2025 19:41:37 +0200
Message-ID: <20250516174141.42527-3-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516174141.42527-1-phasta@kernel.org>
References: <20250516174141.42527-1-phasta@kernel.org>
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


