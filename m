Return-Path: <linux-pci+bounces-25173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9E8A78FB4
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 15:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37C73B29D8
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 13:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2647C23A9BF;
	Wed,  2 Apr 2025 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ug3yjsSZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431C2397B4;
	Wed,  2 Apr 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743600421; cv=none; b=l4o8gy//QuNejRZBzXQ/BDsVMdbVfufDLcHs1gg/wI0nLWDXc0nBuVFNj4Ll7+mjck+UkXtu5bs9zH5QpgGmDJ+Q03cxslb8qPcws6hTosSeVNZt6qoPCpwBVpXqh7MfgQeOyORv+hUqDPbK4IIb6KC0HJ7ateBhr/sPwnptuss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743600421; c=relaxed/simple;
	bh=FrauQgZHIO5vM3GOiecxA1ME+VfylZ7v49JpojhIrho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oY6PtfShFbglz6psCMHbQcWZ8epoNtPtdSnbKZKPFsF8+SqXtyllim973KSC6S7Vlx/DUMSz5H0Vex1AYb8P1HVWy2lwaB11UyAFYN2SHpnhQFCEaGL8qjStnmlFH+GbMy3utIMcUFBtcOZvWRcO39zPSA3Dlc5vOSZ70aBALSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ug3yjsSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B91BC4CEEE;
	Wed,  2 Apr 2025 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743600421;
	bh=FrauQgZHIO5vM3GOiecxA1ME+VfylZ7v49JpojhIrho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ug3yjsSZFPHXUda32gb9aSn7a/EU+7LKWQBn/qkFX3G3DIfPdjrmeNuTPA+IcGuEH
	 6jYjyCfZYXlKwhKQ4xAgX6ZWsOsyWcq8JJ+v8kSDA/E+Li95cqzUb/B3VhgFl0+uls
	 BpXvrChUbKVceLzr3WYoPK5BO3/tuDKjDAdlj+vxdtCmrD1UxE0NSfgkLUJL5eQHMO
	 W1vbBiW5QcC8sVAYTX65I0qtAXPPpPp+2bveYvLzW6oRIvk6v54I1UgNGHe/Gm01BV
	 AnBFHotfiGdM/ePo+Y5JdpnFZS7JyCugJTpZbBdkQ+tQW2wKhHE4MYquFEScY6JZa3
	 QV0z93mboCQ8w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tzy7W-000000004iM-2NZV;
	Wed, 02 Apr 2025 15:27:06 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 3/4] wifi: ath12k: switch to PCI_PWRCTRL_PWRSEQ
Date: Wed,  2 Apr 2025 15:26:33 +0200
Message-ID: <20250402132634.18065-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402132634.18065-1-johan+linaro@kernel.org>
References: <20250402132634.18065-1-johan+linaro@kernel.org>
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

Acked-by: Jeff Johnson <jjohnson@kernel.org> # drivers/net/wireless/ath/...
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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
2.49.0


