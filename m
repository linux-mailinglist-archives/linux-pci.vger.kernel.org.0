Return-Path: <linux-pci+bounces-27959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4443ABBC5C
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 13:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9A31697C8
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9699C275842;
	Mon, 19 May 2025 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfaWN0F7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B42D27511C;
	Mon, 19 May 2025 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654230; cv=none; b=syxeSUrGpTvnzzvneVl65CC+pmqGQ/QMn81vj4McZl3QQHF0SWAFbQ5mjjqPG65REqCwBwPkQJVzQygvZ16WFwLZGbilKuYxrs73Xy6XGa3isnPvevJ1gNfpjjvIrmnuIb56BHlHu3lceBAU7xLBoA1Yi81Bqbqcd5/bLC1Of6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654230; c=relaxed/simple;
	bh=EOTXJySNIRQ1hPgH/GQOn7ZCvUlevAKYgutrhZhqAOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyhMonhNjP3AIkZuGHEdnzOgsvOJXBqzIxwAn3O7agWJc9PkOGAbh80UtdZNeCmba/Bw4gUTa/NjTPbbsvinA/AsPB8ZlAyGSridWX3hrfZ8X0WlyR+uNG3U6q4aifdzuYr7n0U7wBcsvIHcjco13A8U9BXexFlTkAlY3GKHhD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfaWN0F7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A977C4CEE4;
	Mon, 19 May 2025 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747654230;
	bh=EOTXJySNIRQ1hPgH/GQOn7ZCvUlevAKYgutrhZhqAOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JfaWN0F7MFws4criB+GKIi0vHpk8WokfNZGVC4bFtizg+x7Lqt0s/fB+ToeFVy4lk
	 NLtyLNGSa13CvIeRsNE+0Ive7uM0uTdit1pPiIne0yIwN1XYdCQTn2CFsg9jqjn5To
	 8zggGRXh+UglM9cIcyjwlNtaY49CNP8lTZb5mCMmaUwr8+/RnlzAJo5ZUPNVTN3G8J
	 KZRcs8ENrbcL03ilXOPN5v614XGeOxPKbhRC1xiNQTSLj54/mUEpdG286NujzxaZ1o
	 YPZRG+/pQm9fNKHsRRZpesiDdCeMe/i+w2q4BkI+gdKrnR6MNc8U6BQHzQ1PV9hTCw
	 UzJ6ZOl7Xusjg==
From: Philipp Stanner <phasta@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 2/6] Documentation/driver-api: Update pcim_enable_device()
Date: Mon, 19 May 2025 13:29:56 +0200
Message-ID: <20250519112959.25487-4-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519112959.25487-2-phasta@kernel.org>
References: <20250519112959.25487-2-phasta@kernel.org>
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
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
Sorry, I didn't find a way to do a line-break with which `make htmldocs`
doesn't complain.
---
 Documentation/driver-api/driver-model/devres.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index d75728eb05f8..9b52a3e4b931 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -391,7 +391,7 @@ PCI
   devm_pci_remap_cfgspace()	: ioremap PCI configuration space
   devm_pci_remap_cfg_resource()	: ioremap PCI configuration space resource
 
-  pcim_enable_device()		: after success, some PCI ops become managed
+  pcim_enable_device()		: after success, the PCI device gets disabled automatically on driver detach
   pcim_iomap()			: do iomap() on a single BAR
   pcim_iomap_regions()		: do request_region() and iomap() on multiple BARs
   pcim_iomap_table()		: array of mapped addresses indexed by BAR
-- 
2.49.0


