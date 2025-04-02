Return-Path: <linux-pci+bounces-25174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63423A78FB6
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 15:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD33B3B2A3C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 13:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2887223AE7D;
	Wed,  2 Apr 2025 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sF44gpQ6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C438023A562;
	Wed,  2 Apr 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743600421; cv=none; b=F09UAKxoX/ci74Km1gbXDKlnmommCfUxxt42Vj0IxucI9aw2rtCOyJVKwNYF0FCWR3/owmpwk1v3uMRcnifedEVeaKp2x39xv9zNGbzEJAkC+CCUCOh2jILkgf902LAv80xNt3v/z8cbPlRQi5jKSvL0DE3k3e0iV1BwTlGguwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743600421; c=relaxed/simple;
	bh=sUaCyaEjEYggSl/kXXjuZDqRS5xLlh4DDfCG6MRWm7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5FoNjIkjR0y8sEBey7y8uqqwPK0MyHczD8qRsnvp2bsGAuvld4FMM8DhZ7CrHL0j6DlE6hjyCnpHRDPFKrGiIsRGDqnt5tQ2IHh25wbQRAkAQJcSCw40iQzVCpAbuOd19F2Qr0WZ1LTfUWGdCURq/cJLmBeDdjeSbh4rCRiPoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sF44gpQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E079C4AF0C;
	Wed,  2 Apr 2025 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743600421;
	bh=sUaCyaEjEYggSl/kXXjuZDqRS5xLlh4DDfCG6MRWm7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sF44gpQ6clwCB0In8M9mY9sxmtUTTn0Zy5FU4gp1j0GBdgoEMftZyiKh7w89RMX+M
	 bQvehtlm2oDyuOL6JBa+qhXydZ6To4pJm+Q9L5aO+Ggg/RqjT9+ult2mk3VAvUL4Z5
	 wa6KlBzDeTPjYUgcTE0BUaL7Y4vKGYJtnedEveVpjaztX0w8NWT3+oT7Z+Gff2hSWF
	 0Tvt8EO1lrltt8CbJ+dGpyat4IT3NMBE3HSARnrHxy5kD+nU5T5IQBvhA99/Pz1fqr
	 JcyMinTPw5VBEmp7faUlIWVVMM+QEGAONLPvfydAptPtSzpFPjm4oDYcWW5g2qBX4f
	 eGldFLZpC3tAg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tzy7W-000000004iO-2htb;
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
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 4/4] arm64: Kconfig: switch to HAVE_PWRCTRL
Date: Wed,  2 Apr 2025 15:26:34 +0200
Message-ID: <20250402132634.18065-5-johan+linaro@kernel.org>
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

The HAVE_PWRCTRL symbol has been renamed to reflect the pwrctrl
framework name. Switch to the non-deprecated symbol.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/Kconfig.platforms | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 02f9248f7c84..cc94845e9bbf 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -269,7 +269,7 @@ config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
 	select PINCTRL
-	select HAVE_PWRCTL if PCI
+	select HAVE_PWRCTRL if PCI
 	help
 	  This enables support for the ARMv8 based Qualcomm chipsets.
 
-- 
2.49.0


