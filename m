Return-Path: <linux-pci+bounces-16280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCC89C0E25
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 19:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC26284A94
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 18:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82A921745B;
	Thu,  7 Nov 2024 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Foegwhou"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59E2170D6;
	Thu,  7 Nov 2024 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731005839; cv=none; b=X862TGTdU26p8W3goNEXc6AFQtf38HQQOtgE27/HZny6qDCMv7WS1d28xUv5a32jA+kF+Iu03NKr0aeFPDyN1DkVOcz22VQNzFoKIL7j6nP36sx+Upnq/DzEjdKX3UaBdMV3zcZ1yRYizdDob1/ZiD3viJhFHciwUgSm26G8Vvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731005839; c=relaxed/simple;
	bh=Jk1glCEODb6LBoL7jnE9DENCd/x3Sr54x9ReG6IrTdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jy4+OGK7zKu0cjRrWDjDSnb2/lLAAiTOBhBM3K2gYKmr84fvmEZ4nLXSUud/iRaiqsF/YcBnz1UOCnWSBaWfRQ8VS2p+kvkwK9DYTKlc9d1FUlR4/dH3ZYO/8/MlEq5vgrp896JcDfO8kzzo7gtpqBT4zdnKQHxA3gbu5FRyvlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Foegwhou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A3DC4CECC;
	Thu,  7 Nov 2024 18:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731005839;
	bh=Jk1glCEODb6LBoL7jnE9DENCd/x3Sr54x9ReG6IrTdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Foegwhoude5WqXWP35jdLgyEeAkFM0PFcfVdf01MOefeo57+VbUDM5iOBoj529Nfe
	 7el/OZoEmt0ke+Avk/ndQI68xoqZ0ZmMHEKupuy0jMHew4QY5ywB32F8fKNv8Drya6
	 Azj1AKVvB3fshMrG2Z23uYowwsYQ+DXGfBWToFnB6Mk5+Zw9OTN8bfrkRNSPjmGr4K
	 as+zqcVz7OQEcINbP59dm8kXT1lAUv9MxzueUvoGr5bB7sxVC+3II1xiXLY6P6eOZ9
	 3OonLQJOD5cMhdXWD08iCIU5S6hgJ0JhuHEoqx7BNpeKMDuHp+ZfH1rNF0dl3YWO1Q
	 coEkh890SYsLA==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org,
	"Ariel Almog" <ariela@nvidia.com>,
	"Aditya Prabhune" <aprabhune@nvidia.com>,
	"Hannes Reinecke" <hare@suse.de>,
	"Heiner Kallweit" <hkallweit1@gmail.com>,
	"Arun Easi" <aeasi@marvell.com>,
	"Jonathan Chocron" <jonnyc@amazon.com>,
	"Bert Kenward" <bkenward@solarflare.com>,
	"Matt Carlson" <mcarlson@broadcom.com>,
	"Kai-Heng Feng" <kai.heng.feng@canonical.com>,
	"Jean Delvare" <jdelvare@suse.de>,
	"Alex Williamson" <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v1 2/2] net/mlx5: Enable unprivileged read of PCI VPD file
Date: Thu,  7 Nov 2024 20:56:57 +0200
Message-ID: <f551f20b0649b4be3f4c9536e756986665366e46.1731005223.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731005223.git.leonro@nvidia.com>
References: <cover.1731005223.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

mlx5 devices are PCIe spec compliant, doesn't expose any sensitive
information Vital Product Data (VPD) section. In addition, these devices
are capable to provide an unprivileged read access file exposed by PCI core.

The parsed VPD section looks like this:
08:00.0 Ethernet controller: Mellanox Technologies MT2910 Family
[ConnectX-7]
...
  Capabilities: [48] Vital Product Data
    Product Name: NVIDIA ConnectX-7 HHHL adapter Card, 200GbE / NDR200 IB, Dual-port QSFP112, PCIe 5.0 x16 with x16 PCIe
extension option, Crypto, Secure Boot Capable
    Read-only fields:
        [PN] Part number: MCX713106AEHEA_QP1
        [EC] Engineering changes: A5
        [V2] Vendor specific: MCX713106AEHEA_QP1
        [SN] Serial number: MT2314XZ0JUZ
        [V3] Vendor specific: 0a5efb8958deed118000946dae7db798
        [VA] Vendor specific: MLX:MN=MLNX:CSKU=V2:UUID=V3:PCI=V0:MODL=CX713106A
        [V0] Vendor specific: PCIeGen5 x16
        [VU] Vendor specific: MT2314XZ0JUZMLNXS0D0F0
        [RV] Reserved: checksum good, 1 byte(s) reserved
    End

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 220a9ac75c8b..7e34badd174b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -2280,6 +2280,7 @@ static struct pci_driver mlx5_core_driver = {
 	.sriov_configure   = mlx5_core_sriov_configure,
 	.sriov_get_vf_total_msix = mlx5_sriov_get_vf_total_msix,
 	.sriov_set_msix_vec_count = mlx5_core_sriov_set_msix_vec_count,
+	.downgrade_vpd_read = true,
 };
 
 /**
-- 
2.47.0


