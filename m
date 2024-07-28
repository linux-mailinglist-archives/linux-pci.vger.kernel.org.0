Return-Path: <linux-pci+bounces-10910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324D593E854
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A101C213EA
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1874F606;
	Sun, 28 Jul 2024 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kij7pyed"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3399417756;
	Sun, 28 Jul 2024 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182997; cv=none; b=Tqd0E7oAw/3ibnvVES58gJTTMl5Jske28TcgzsAzQqaWEIQEG5G1J4TMXFMw3mAWh/Tg5So8fmVU1IshVbbu9DIl5PShfugjKWSIrYVIHRXSnArmDHrT1723aKVOv+pGC4mQnASEJ3xbDI0nVQ9nn7rl1aj5F5fA8yo+oCLQ0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182997; c=relaxed/simple;
	bh=HMeSELUynsvJYfgBIX/+wU3WRg7Ji9njsKv3FGSyVTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U7aXpLLtei2TJ4CQPETk3nP92XEwTF1JAcZfoI+VnGCNffzy/Jc6Yy3Cogk5CiIo0Xgz1RYN8BcHLFiswgrLEOp2SAxxmxQJts1iZhSuO+Eox8HSZbBA7ZmGuzp9qIvuIpsZRxUrIgzrtzGJ76S85ZXGuUstKKLij6WUNyr3C5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kij7pyed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08541C32782;
	Sun, 28 Jul 2024 16:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182997;
	bh=HMeSELUynsvJYfgBIX/+wU3WRg7Ji9njsKv3FGSyVTs=;
	h=From:To:Cc:Subject:Date:From;
	b=Kij7pyedyvAjSCTXmbAMrE4zAcA2iavekMkTw3dcrD2PTzlQwDhoG7VPtloqZX3h4
	 /6Xv0+Qj1Aoo7zpMYw7zZFBiiz2yIR5+jMkwP1C877xUZEuTcCy6TwaFSVzUpfv2PH
	 SVzycjGmIQmXaTeK8nhKDQQKVgxxAseshEy77hJWSD5Re3gw2HrJuAiutNNUoS0eLh
	 k1DtVF/lAmak3FXKlLmurDqntMj5zotCPlxjCY4zNrvBwHagfRx2pENsAan2+yK6xD
	 lyEfBHWxbn/i+VtBsytrTGT2pqr//DBHSIHs3VU7sP7GDfFyNePPSVNfJ1PMmulbci
	 hx66uU6fhpq6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Gospodarek <gospo@broadcom.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 01/11] PCI: Add ACS quirk for Broadcom BCM5760X NIC
Date: Sun, 28 Jul 2024 12:09:34 -0400
Message-ID: <20240728160954.2054068-1-sashal@kernel.org>
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
X-stable-base: Linux 5.10.223
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
index 60a469bdc7e3e..39c42a1e8d9a3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4945,6 +4945,10 @@ static const struct pci_dev_acs_enabled {
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


