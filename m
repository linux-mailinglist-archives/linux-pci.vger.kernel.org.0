Return-Path: <linux-pci+bounces-10883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB65793E779
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41A7283F57
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52E677F2F;
	Sun, 28 Jul 2024 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GszzGFoG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8722B4F8BB;
	Sun, 28 Jul 2024 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182741; cv=none; b=MS7o9AzSRfm2e16vP50DHVELq3BuHaSOG2qt5H3rC5D9ICrpVMYzZwX2Sz1uOz13HMtPieQR3zAZ+1xVdB/QYo01b4DMESs3Ocr0aGYreee5oDQrnGhe5fSfLLhk1K4GqQZt15gJRYt6yBArNFaOfNkeBnyVsgH5HB9wd8YfitY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182741; c=relaxed/simple;
	bh=sC+ABeFiElt3XPZrsSXKGWNaeItAgfe1CrRJ7+e7gaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p7CAQPP2Nk+zdk8tXfNMAbtrArCDdU1qPA1b81GKvoZR6oSwLuoGXXTjD7ZNy/OI7Eu08EH/vHQH5jyUISREKsE3ic+plSeOJAp0+23fdVUqTRIM7pRRNaSZWw21z3sSI/u4ba1Ei9EIPKWMFgvEmqZ5FSudPWzZJHQbI2xBWI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GszzGFoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC30DC32782;
	Sun, 28 Jul 2024 16:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182741;
	bh=sC+ABeFiElt3XPZrsSXKGWNaeItAgfe1CrRJ7+e7gaQ=;
	h=From:To:Cc:Subject:Date:From;
	b=GszzGFoGzpxevR3nSBESEPZjLKE8uEtcg8Z3AwO4eLuwSwZ5DhazRgjAvcSuIRQKf
	 4ov/Yui0lojoBApWroBMoj454soP5V/sPoMvLqwjcsWxYwe5OcTgaIj8z3vW3rV+R7
	 jBKtGGZPDZrKKCDZp4f2LRiG7gLAul+0Qr8VbudSPv4Qell+QA3bRpQTNDpNBNkBSO
	 HTX5HPIn5s9hen6Ynop20Q4czDAOsYQddimhJPGo+y2+NGaEsvEht281E5Yg813NI3
	 4IruC7kiUN9/nuU/Yldy0lSPuYNoRTpXQPah8Wo5MJrN+UZT7vfta9GEPVayzQFYIR
	 J4GO+ASE8+Bvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Gospodarek <gospo@broadcom.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 01/23] PCI: Add ACS quirk for Broadcom BCM5760X NIC
Date: Sun, 28 Jul 2024 12:04:42 -0400
Message-ID: <20240728160538.2051879-1-sashal@kernel.org>
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
X-stable-base: Linux 6.10.2
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
index 568410e64ce64..a2ce4e08edf5a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5099,6 +5099,10 @@ static const struct pci_dev_acs_enabled {
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


