Return-Path: <linux-pci+bounces-25171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4025A78FB1
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 15:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9769316C2D0
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 13:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD0923A990;
	Wed,  2 Apr 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjpE0TCa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C8F23908C;
	Wed,  2 Apr 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743600421; cv=none; b=GH60CPDu6nPwpHktiCVNBQMQJUdO3hUY2QQHhcoRqRDShWUqbjS++iOiZsBEuHqzpCOynAY0atDiU+6cuQc1ppKa022iZLu7mpAreruvQTlKa0cLX1HB+RCOw+teOVR9YXw91jIpRFV9ooZTc2DCuiZDoQFRC1Ox/QhmhWDOM04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743600421; c=relaxed/simple;
	bh=NI+j/rVLL0bJuVQlOJfryLdM5lDGm0bxHI32FuemuZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/gEpfvDoI47Rig7T8A9uuEJv7LLENFVsei4Ay05isiq7U24G5odKSX3mv3eJyuOzRWiTwCrpFtemva6ViRTQpVcZ1GHaswtuOIzc527ojPSC502g+5TS4pb3whgUcwLMfZ6m+LyzRqmc252E7IpktF0CxxXd5YqVig3kZijpcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjpE0TCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34014C4CEEB;
	Wed,  2 Apr 2025 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743600421;
	bh=NI+j/rVLL0bJuVQlOJfryLdM5lDGm0bxHI32FuemuZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GjpE0TCabADCgjtkRfcHKGDvhjLhAqSzmO6QI+9FXgU31c9/yB9kPXbHMtCLJDZ62
	 5vl2iYi4KX8axdVSU8kUCfQgx4GmHsjPg90y7gcj6Fgj1DpdqMSNv36yxKlufwEqsn
	 2k8LNOwmdgfeUew3e5zOKsNfDbWjs5KLEFR0giwkLEoB5NpaXoK+nO3qKu4fTKWXnS
	 PX/gBVooJegjGiBtxYS+roWa75zO5dbwCpwkSIw+B5Pxzpi3ZFRER5JVJdSNBFr+7N
	 lIylAVdxG6eUKz5Ohvpd/GP+cIoIWoH5ThcYL+zDgw1HbDyPxHTD6Jqs3TT/Kcxzre
	 3hmc717ea7Uag==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tzy7W-000000004iK-20RP;
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
Subject: [PATCH v2 2/4] wifi: ath11k: switch to PCI_PWRCTRL_PWRSEQ
Date: Wed,  2 Apr 2025 15:26:32 +0200
Message-ID: <20250402132634.18065-3-johan+linaro@kernel.org>
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
2.49.0


