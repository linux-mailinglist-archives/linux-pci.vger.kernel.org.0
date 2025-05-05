Return-Path: <linux-pci+bounces-27221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 658FBAAAE6B
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 04:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160221A82D57
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 02:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910C93745A1;
	Mon,  5 May 2025 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9g/t7JB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF5435F7CC;
	Mon,  5 May 2025 22:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485246; cv=none; b=uLH9qetLzLKlVHzMCrW035xTUDT04fXERb20VelrxcLxHIaw1ab+uw2jPsvrAaIJ9EcZ9iueRnVLb7IHt5TicRaHABT+f27VZva8tApeO+afoBdPnKY/SvKJhWg6rgjee9Io98jYGpt753cKWhKbzxdSwc2cZyD/14uJFWe5oXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485246; c=relaxed/simple;
	bh=enAfUT/STELazeBDnsbKZdAHSgGQsc35imKgdRurVlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNreq1CGktQpR4fwCA29vCyZpUIaMZGtOBg88Qpol0r1T9iOA4NrOdpOjeKhzxgo0MWobQUrIUSBB6pmFrwwpAPndbUPIorwPEyN5y0t/Vh+R/qV/Yh/FlcBsUQEZwAVDT5VRNnZ8UOK3RSzSGSS99JL0WRycHuiQ4OKfUL/3Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9g/t7JB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2274CC4CEEF;
	Mon,  5 May 2025 22:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485244;
	bh=enAfUT/STELazeBDnsbKZdAHSgGQsc35imKgdRurVlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K9g/t7JBXv7foVm48xbOE1Jf76s4sjqXZXfWlk0+ZrtMTP1GSgZ7+qn/XpqD1NfZk
	 LJ71MC69jjLGqHqrt7w9D0tjyNFrTGVe+AjPwFXKt7kE+xNIjQY6grFTOfQC8+llxl
	 2xeMqyT42yQ7oHP0hx2WCRM5tqw1jwXv6q4wQBu1RpcR49eA/iBHKJCeG1KbZIFG1i
	 ZkIpRh+U3wSygkIjZsB+c0/1wsEqey8GLvGuECkvOLnw8DV42r3pRMrS8Dt1kC4i5g
	 FUW4dlh9IjKAMZd+dIEawfYySlh/hlcrlvJPwwuePhZ2LvNeNQ2ykn+UM5yiYsZQ7h
	 6t2aNyTyCbkAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stanimir Varbanov <svarbanov@suse.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	"Ivan T . Ivanov" <iivanov@suse.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jim2101024@gmail.com,
	nsaenz@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 232/486] PCI: brcmstb: Expand inbound window size up to 64GB
Date: Mon,  5 May 2025 18:35:08 -0400
Message-Id: <20250505223922.2682012-232-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Stanimir Varbanov <svarbanov@suse.de>

[ Upstream commit 25a98c727015638baffcfa236e3f37b70cedcf87 ]

The BCM2712 memory map can support up to 64GB of system memory, thus
expand the inbound window size in calculation helper function.

The change is safe for the currently supported SoCs that have smaller
inbound window sizes.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Jim Quinlan <james.quinlan@broadcom.com>
Tested-by: Ivan T. Ivanov <iivanov@suse.de>
Link: https://lore.kernel.org/r/20250224083559.47645-7-svarbanov@suse.de
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 792d24cea5747..32ffb0c14c3ca 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -309,8 +309,8 @@ static int brcm_pcie_encode_ibar_size(u64 size)
 	if (log2_in >= 12 && log2_in <= 15)
 		/* Covers 4KB to 32KB (inclusive) */
 		return (log2_in - 12) + 0x1c;
-	else if (log2_in >= 16 && log2_in <= 35)
-		/* Covers 64KB to 32GB, (inclusive) */
+	else if (log2_in >= 16 && log2_in <= 36)
+		/* Covers 64KB to 64GB, (inclusive) */
 		return log2_in - 15;
 	/* Something is awry so disable */
 	return 0;
-- 
2.39.5


