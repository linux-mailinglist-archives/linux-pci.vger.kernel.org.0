Return-Path: <linux-pci+bounces-27960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2CDABBC5F
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 13:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9924716F0ED
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADA6276047;
	Mon, 19 May 2025 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBa6XIcv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9A1276045;
	Mon, 19 May 2025 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654234; cv=none; b=qzVNZ0QXFNlJRbbArMjDw8OrXs0o2jqP2spWeYklXrcP5oZc8mlfbgPK95xFptI3kIWuL1vicgBEHEC7wpmmPVFr2Ir9Oza47QQmUDDIw5b34W7F4hU4qv1B2QLyI0Iy1BXC0sN+Ctu262N6Dn68hbSVEavCjSUk56Vs16E8qpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654234; c=relaxed/simple;
	bh=0CDEo8glAhVsWbgEFoyQpPYpxMH8Urv8zPMM06VfINM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBQHIfVLMW7kB8PAcLfmMBW5zs15vEZMQKmvoFDQeaVJhrqCDfHN80KgJ90LfI+EPPGyLIM0kSS/w2lh64tyO1y5CxlJhX3bEO2v/QL5BhxiKtJkm7TkIElQ8qCgYszeEiBbiT4l30cI1qJjS3Hi/R2NaPBT+IBwiUKQ4tZl0To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBa6XIcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DE4C4CEE4;
	Mon, 19 May 2025 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747654233;
	bh=0CDEo8glAhVsWbgEFoyQpPYpxMH8Urv8zPMM06VfINM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WBa6XIcvevxCme/UBsPF9VF81/My8CDGLW7crsQYtXiq7FZMil+MdwwjkSJicfS0I
	 Qh7qh+TATbqROvGjSywBgZTVOnb907M9oFApqPTejA9M1nJfWzBNuxdJ6+BmEOLZBM
	 052bIu2u4Je+v4pdfhPkrLmTgFAzXSi0U9NSnHKdQ24dxN8f8BRjHfCmisWw3ByhQ/
	 E6XvoXZtqZH5UEl097a4R69PKXhFWWWlyd5UvL1a3WqsMVYNA+EVmB3UqCTARX4N+F
	 nvk8OuBplgWQcErBWcrSkdR/j5hRaSluHV7kUvW53WcZLT+1rTl12YjaumyvCRaCIl
	 UxWxBqucbXFgA==
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
Subject: [PATCH v3 3/6] PCI: Remove pcim_request_region_exclusive()
Date: Mon, 19 May 2025 13:29:57 +0200
Message-ID: <20250519112959.25487-5-phasta@kernel.org>
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

pcim_request_region_exclusive() was only needed for redirecting the
relatively exotic exclusive request functions in pci.c in case of them
operating in managed mode.

The managed nature has been removed from those functions and no one else
uses pcim_request_region_exclusive().

Remove pcim_request_region_exclusive().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
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


