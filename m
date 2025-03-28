Return-Path: <linux-pci+bounces-24949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BC0A74CEB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 15:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B23D7A42F9
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 14:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9871B4259;
	Fri, 28 Mar 2025 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpimyxMM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DE116BE3A;
	Fri, 28 Mar 2025 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172878; cv=none; b=CJ4XytngIYrJD2LnyaD3rV0Dfr93qQxSSvB3YKEnz9Y1c8VNdd7Tpg54nrRtE3P/E0V8PJYW1A7pRs8neJEkGJ5kEica12HVxRXBwHNLfpZfwrLFxj1NFmySAGN2xqXqZkO5N5XY/aNluBHVb/iCAC2p0NfC4wosvdP0e1Gt3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172878; c=relaxed/simple;
	bh=8PuT1jV9b0Y7GZnMGFM7vZCfZDWEJjSwlXvGrPuWeAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLLVzGrm+h8oaXuW8fWNFe2li+6qF2EGxyy5HZ/cF+e/Z0KjodjQtD8eTutwGG5xSjpuG0rkZx36rqz8M2jhx7RxI3XqxLBvuLf3ZW93pp4MnGfeHptXFdyOAuEebOAWWqPxKWMtzEZ+l5RZWh4Xr1+UdkIAiHxtOTbj0aBb2nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpimyxMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8747FC4CEF3;
	Fri, 28 Mar 2025 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743172877;
	bh=8PuT1jV9b0Y7GZnMGFM7vZCfZDWEJjSwlXvGrPuWeAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tpimyxMMCICZIjv7JGOqZl85llXmWPMxffKm9ij8USgb/H1h5x3gO7Mdn7wtNcUNE
	 RjScx0Ech9GanW7ELk5oHeAmk9utDRfEA7Ov+PmUUNtPrwDWAnbwPw4TuSqVFOs0y+
	 GXk4OuhwULDchJL7nr+pY6VJ/gTmIVtLOB42cU9O6DoagdALsKZHHpnFR4iPao4kU0
	 fGZsksUwnEk6ewj2k9UMBuHE9YHjT1qCX8g/5eSjpKMc/fcnV6PR6Zs4RGYBLVf4iL
	 8S6NnNjv4zqFdmuQCGPfulrIf818n8PkrXLvaLnuJgo9TDIvh3yamCrpVma5ftPp3w
	 60cycul5X4e0A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tyAtf-000000007JN-0bcM;
	Fri, 28 Mar 2025 15:41:23 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 4/4] wifi: ath12k: switch to PCI_PWRCTRL_PWRSEQ
Date: Fri, 28 Mar 2025 15:36:46 +0100
Message-ID: <20250328143646.27678-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250328143646.27678-1-johan+linaro@kernel.org>
References: <20250328143646.27678-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI_PWRCTRL_PWRSEQ and HAVE_PWRCTRL symbols have been renamed to
reflect the pwrctrl framework name. Switch to the non-deprecated
symbols.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath12k/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
index 52a1bb19e3da..2d1eb22deda7 100644
--- a/drivers/net/wireless/ath/ath12k/Kconfig
+++ b/drivers/net/wireless/ath/ath12k/Kconfig
@@ -7,7 +7,7 @@ config ATH12K
 	select MHI_BUS
 	select QRTR
 	select QRTR_MHI
-	select PCI_PWRCTL_PWRSEQ if HAVE_PWRCTL
+	select PCI_PWRCTRL_PWRSEQ if HAVE_PWRCTRL
 	help
 	  Enable support for Qualcomm Technologies Wi-Fi 7 (IEEE
 	  802.11be) family of chipsets, for example WCN7850 and
-- 
2.48.1


