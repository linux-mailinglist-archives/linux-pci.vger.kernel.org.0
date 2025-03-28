Return-Path: <linux-pci+bounces-24947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A13A74D04
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 15:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1565E1671D7
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E27D1A8F93;
	Fri, 28 Mar 2025 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVN+T77o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43201487F6;
	Fri, 28 Mar 2025 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172877; cv=none; b=aXQQddI8DrL9RkITKwzadFfSG1V/+brSHHYCw1TxFIkgB1S8HNEIHlhpeJMNxWUY5OECieKuxoz/Iku/r4dWHn/R7BEL/1JnJxsvcAo1o6daR6IxUTeeJN30Rcjb8RGmwKp5AXAmb81ZTkLRRZO1KddTwF8xjjBWUY68jeEbriQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172877; c=relaxed/simple;
	bh=ukkF1hCEQm7wbvZ+4W4weswXt03pl708DLbZGCEkZ5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLCR5qt4N1u+diwBPdBqN1teu+QdxJiW53uerg+K4Yx+fmC+HJ+U550s4ZL3/ZmDCdFF693bz/epoOf0a/PC94N1KMxgVdi3zliBoV+pg5AhJ8jUrGzqH2u2O1xXvNFzJh2V/6ovCNEenlRBMqaeLlDH4NaBrJ9sM/1n6msMK/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVN+T77o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61342C4CEEB;
	Fri, 28 Mar 2025 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743172877;
	bh=ukkF1hCEQm7wbvZ+4W4weswXt03pl708DLbZGCEkZ5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVN+T77o0MVlYYptvSQ19rgbdLkuIJf6geemDlEupAakuG8ZVSFTTH2iqfM9mID7F
	 rRusyJ0kBF4Gp5vxfHx/B+MnrKhymbBlMxe9cl9gl8o2LY+TgHZgpKNG12P59iOQvv
	 KqjAE5hOiy5zsCoQY3IMmobvq0yO3WPUnETWfrvL+wL7EKpUG33aWbN0hxiM7SmQW2
	 GZ2EB6DLom0XC+lG8WyEV3Ndk7jbHZOFq2/XUUDGazUm5SH2IlPnG80VGfhKJDnr8+
	 U0AhO31B7LBIKnszEaKnfJ+DuRHYvNKUfXNcYFu/MBuUZYi1Xlwa+TlaEUoPiniQT5
	 t/s2T6nYzONbg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tyAtf-000000007JK-0GTP;
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
Subject: [PATCH 3/4] wifi: ath11k: switch to PCI_PWRCTRL_PWRSEQ
Date: Fri, 28 Mar 2025 15:36:45 +0100
Message-ID: <20250328143646.27678-4-johan+linaro@kernel.org>
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
 drivers/net/wireless/ath/ath11k/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index 2e935d381b6b..659ef134ef16 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -24,7 +24,7 @@ config ATH11K_PCI
 	select MHI_BUS
 	select QRTR
 	select QRTR_MHI
-	select PCI_PWRCTL_PWRSEQ if HAVE_PWRCTL
+	select PCI_PWRCTRL_PWRSEQ if HAVE_PWRCTRL
 	help
 	  This module adds support for PCIE bus
 
-- 
2.48.1


