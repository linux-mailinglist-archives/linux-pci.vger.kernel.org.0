Return-Path: <linux-pci+bounces-27887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9ADABA213
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 19:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C719E192C
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 17:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DB327874E;
	Fri, 16 May 2025 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPE0J8mp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CA52741CD;
	Fri, 16 May 2025 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417321; cv=none; b=B1i0dfRlRceLF8FkJAsLjxHdCFURrVsqTGa4KO+CiHNdLz8FcnGcgDxK5fSUq9lrMxOrDcGnwRT6MhaOaYy/dgpt7aqvngwvv5MoLKLVo1peoqaqE9d3Izw6HvXtTljxTSrPEdKfq04BavAsOcstfeFlj4H0jJwBD3AFDBsQ+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417321; c=relaxed/simple;
	bh=c1ROWu0lfGtKMMpettEtZCS5NGvMgU/+Xjau9CxLvpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVSXYcJpx0Am06d3EXfEUxHm9sCPxnIqDfL3dPFC8Qd6eaob4hXi/bi8mLG6kzpsI0Vdh1NynV4dQbpwF9PudpdSTmhfBPU1Mvh7yTsN4wsZLd/VT95fRv88ls4LMTKuYqdxR+MnZP+K/tpIbGL3hTw7BSBzRwKub+HsdGdrWuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPE0J8mp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77EDC4CEF0;
	Fri, 16 May 2025 17:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747417320;
	bh=c1ROWu0lfGtKMMpettEtZCS5NGvMgU/+Xjau9CxLvpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPE0J8mp3Y48oscDtYpaoS1rkv6XQhRHnDNBBUooWcUegMvh3q7rHlAGEqI9EW1BX
	 SWcgEJT05vxPpj35mZRT09ykUMkBGVWl0zvEWbl78/OJF42RS6USz6SZwXLZJge19n
	 hRtSJmwmIFAjVFlkgPD4N7jSl+UmxNqXa/DGa3pGi7/ZnzeU/ehTK16oHj4KmgzMeu
	 d9mlCUhEA7xyp1xBZiExXlsH58CpChK4sDdbxAjJo1syxU7A8LMUKJ0YDl+5qZ+Xs1
	 HBIwrRh1HxJk3/4e2Hqaz51hH47HjWJSIZOwK2ora2gfO587MKgSGwNI0KgaD6EtHK
	 t9cCk3Avz2iWQ==
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
Subject: [PATCH v2 3/6] PCI: Remove pcim_request_region_exclusive()
Date: Fri, 16 May 2025 19:41:38 +0200
Message-ID: <20250516174141.42527-4-phasta@kernel.org>
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

pcim_request_region_exclusive() was only needed for redirecting the
relatively exotic exclusive request functions in pci.c in case of them
operating in managed mode.

The managed nature has been removed from those functions and no one else
uses pcim_request_region_exclusive().

Remove pcim_request_region_exclusive().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/devres.c | 18 ------------------
 drivers/pci/pci.h    |  2 --
 2 files changed, 20 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 5480d537f400..769b92f4f66a 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -852,24 +852,6 @@ int pcim_request_region(struct pci_dev *pdev, int bar, const char *name)
 }
 EXPORT_SYMBOL(pcim_request_region);
 
-/**
- * pcim_request_region_exclusive - Request a PCI BAR exclusively
- * @pdev: PCI device to request region for
- * @bar: Index of BAR to request
- * @name: Name of the driver requesting the resource
- *
- * Returns: 0 on success, a negative error code on failure.
- *
- * Request region specified by @bar exclusively.
- *
- * The region will automatically be released on driver detach. If desired,
- * release manually only with pcim_release_region().
- */
-int pcim_request_region_exclusive(struct pci_dev *pdev, int bar, const char *name)
-{
-	return _pcim_request_region(pdev, bar, name, IORESOURCE_EXCLUSIVE);
-}
-
 /**
  * pcim_release_region - Release a PCI BAR
  * @pdev: PCI device to operate on
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 8c3e5fb2443a..cfc9e71a4d84 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1060,8 +1060,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 #endif
 
 int pcim_intx(struct pci_dev *dev, int enable);
-int pcim_request_region_exclusive(struct pci_dev *pdev, int bar,
-				  const char *name);
 
 /*
  * Config Address for PCI Configuration Mechanism #1
-- 
2.49.0


