Return-Path: <linux-pci+bounces-27792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33630AB86C0
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 14:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1364E4FDA
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 12:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBCF29B22B;
	Thu, 15 May 2025 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWIFx1dO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9069829A9F5;
	Thu, 15 May 2025 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313187; cv=none; b=V7+AGVyDzUCNjA6bE9fObb8tSBitGo7ezXs3BaCMgnMK6n0Iy8vvvnRD72qYX6IKqqRTRqND1vlzgMUe+hm9Sjbb/3XFSusNGE8oCk/AJ2aMwGRvZXDj+xVbynpbGGYmuJud2OFiZzuZHlK3dU+wSB5ah1irnV7SnB0FyzPm6KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313187; c=relaxed/simple;
	bh=anJhc65G7bGsG8RZ5DM3uxXKassmvqJOGcJ5+fNqfr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2CRMAmdlmaz4HDKLX4lnv59bO3tbEYABV13KDoVURmYucdGr879Qm+J2oKSN0GCP/gRtHogp0usRt/yJWvBxickk0pmUk49B34tnTmD7lkQOjENPl9MIDv6y2t20aGD4FkmTaF81ahij0/AjcDh5OZMZxwCI0gsjg0Ix1Rv424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWIFx1dO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25895C4CEE7;
	Thu, 15 May 2025 12:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313187;
	bh=anJhc65G7bGsG8RZ5DM3uxXKassmvqJOGcJ5+fNqfr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oWIFx1dOLtGGOIdemKnG8RCiH6wALzTPSUfdksV9HMAlmfew2pfNn255FykCJkYYg
	 K6Mtl/anRp6eI/8h9IlqoYehebJGMF6PjL0MHQmadRyq8mkeiG/e2SwRGlcbLpEViC
	 rd5CeeVKMgyDAtjQac+SUZUb4WrHtyEqrMufWNgjsfYc/GQQcKwasedBj1yPC9DnzJ
	 K8K0hJX94XOpZDn5PxvoIZWcaFqOpoKjC60mhnH5nAyqrInbqA5wzoBoEElmoTVkw9
	 Elgt6zdwGGPbdBi1PUPP+3keEDrnfZShvq33GL49LqFL9mzW8uehavU6ghm/uiAsrl
	 WDw4PZaJsbVEQ==
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
Subject: [PATCH 3/7] PCI: Remove pcim_request_region_exclusive()
Date: Thu, 15 May 2025 14:46:01 +0200
Message-ID: <20250515124604.184313-5-phasta@kernel.org>
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

pcim_request_region_exclusive() was only needed for redirecting the
relatively exotic exclusive request functions in pci.c in case of them
operating in managed mode.

The managed nature has been removed from those functions and no one else
uses pcim_request_region_exclusive().

Remove pcim_request_region_exclusive().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
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


