Return-Path: <linux-pci+bounces-10898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D85293E7FF
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77AFB2342F
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9834375808;
	Sun, 28 Jul 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0pF2z1z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEB073466;
	Sun, 28 Jul 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182896; cv=none; b=g0Iv0ZSBkCZ2AIM2npi0jju7KCQ8l8Gex61lkfLYHPCP9nxlhdhBCk66OmHbO4kNj1n2ckHOLU+DgU+7pu8Od3xUl8PoivVYbFaK4RWa76w3w/st43f/nLOiFtnTfW+NBnVMic0HiRWrWbmK69PvMju7jNcs/AhVuMgleWjMPZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182896; c=relaxed/simple;
	bh=WW2dZdXyLFVysjeQ7eCox9Ns9GnBTUGXYgI0PLvjs1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TbyLKahjdeAE7HHLbBqBoL3Zmym5P6dlucad2HaltMk4NCF2+tUAgeORMls5j7QINkBPLYT9OPOZ2HS1JiAgOu52mrDAtrj2jq1PaERbeoRvqjRBTQ9D1cIiB9kzLxwhWNsywCHMu/pvsT5NxjHaqbH2elme+5SrtAF7FCCU/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0pF2z1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52CFC116B1;
	Sun, 28 Jul 2024 16:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182896;
	bh=WW2dZdXyLFVysjeQ7eCox9Ns9GnBTUGXYgI0PLvjs1g=;
	h=From:To:Cc:Subject:Date:From;
	b=X0pF2z1zFdPok+M1V4BlZrRJUhrenVtnaECgEbGda/7ZzX0umxkSPrtAG+sU1GXPa
	 8+r7rEt/hfE2r900gZamJD31KQC6IS/ssZ+j+H3UwuZ3j15jXdQDRMPfv9/iD4xx0P
	 ohBFXIeEESQtqekFT8eaPSWRlFeBjC3G90J7zi9iJug5TUbCteUR79Q9lpKgTQllI1
	 Zj48CiufY67jKI411KbQVu4do3takXgA2Ye2ewpAm4c7LqeTMXdvCnaqs1nGQ9hiHn
	 oOBAdxp5nIPMYx08YdjCpLlXab/Sj7V4S4WFusWqR6T+gVuWzkHzoKHDwcj95PQ7cu
	 G4diw1p15calA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Gospodarek <gospo@broadcom.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 01/15] PCI: Add ACS quirk for Broadcom BCM5760X NIC
Date: Sun, 28 Jul 2024 12:07:45 -0400
Message-ID: <20240728160813.2053107-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Ajit Khaparde <ajit.khaparde@broadcom.com>

[ Upstream commit 524e057b2d66b61f9b63b6db30467ab7b0bb4796 ]

The Broadcom BCM5760X NIC may be a multi-function device.

While it does not advertise an ACS capability, peer-to-peer transactions
are not possible between the individual functions. So it is ok to treat
them as fully isolated.

Add an ACS quirk for this device so the functions can be in independent
IOMMU groups and attached individually to userspace applications using
VFIO.

[kwilczynski: commit log]
Link: https://lore.kernel.org/linux-pci/20240510204228.73435-1-ajit.khaparde@broadcom.com
Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 56dce858a6934..e02a1e513f989 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4997,6 +4997,10 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_BROADCOM, 0x1750, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x1751, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x1752, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0x1760, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0x1761, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0x1762, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0x1763, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0xD714, pci_quirk_brcm_acs },
 	/* Amazon Annapurna Labs */
 	{ PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031, pci_quirk_al_acs },
-- 
2.43.0


