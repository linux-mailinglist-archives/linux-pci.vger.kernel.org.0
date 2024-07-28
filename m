Return-Path: <linux-pci+bounces-10904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6015A93E82A
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B699282304
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0D3768FD;
	Sun, 28 Jul 2024 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEMFc76F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF958ABC;
	Sun, 28 Jul 2024 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182950; cv=none; b=KhqlG7xcaA2RW7B9qr+QZC9hZLUCIpr2IdMU272uw7mRXvi5JA9eP/ylIr1Y9yiGQRJXVJqZ0PB9BJ7epSIpj2wz0i81Ssc7intMAbs/BQ55DEwjH+mlBclq6yppxHsFlsP4Ju4dRf2UItawjdLl1PyTRpm64VGoDKLSLachqV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182950; c=relaxed/simple;
	bh=QQPZNOuLd0TSpWAZqx1Dns0T9wfC3OCSI7K99mEBZtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qxAzvesx3Dgtz20L4iVat3N4IxdrHQSAwrqe5ImmGm/ylmr03NtrPxpGp2AwT/L2qI7Ve6l9soP/Oc8+XcGGmYlFyD40EktiIfuNpfRWDBdyHiugXIo8RGKGeHqY/GPgU18uSe6V5QgTKmWf+pTOb4nFhMavpicbTjYEIoeFDrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEMFc76F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54042C116B1;
	Sun, 28 Jul 2024 16:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182950;
	bh=QQPZNOuLd0TSpWAZqx1Dns0T9wfC3OCSI7K99mEBZtI=;
	h=From:To:Cc:Subject:Date:From;
	b=fEMFc76FAo0/r0iywd0dmk59rXtl2+eE4QuuLjZWyIjnKR5DBXsZAbsWG4GxD1Kb/
	 IJLyYw18ZYsnaYds+mn64NLSbI3V1qQWR4IePPHeJbMALwGNeWa1P058KT5by85/+N
	 kwxfZ0FtkDeFakio4xhTUyacNNH505qVjL+NOZz7Ai8AfFsBbpCMaR9cDzXyqS/0jc
	 o0yjsrmtrex+eoAIIKehQW2KmckQ7WjW9/7vCc1hxB2MtdiJude0EvnxIHhfoWP64m
	 a8OmfH3GLqi8GIXV08SItuVNUVetteL0CkFLbnsFTGjL43EDR/kLADgTEleL+g7BWp
	 gPprbp8K8cwyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Gospodarek <gospo@broadcom.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 01/13] PCI: Add ACS quirk for Broadcom BCM5760X NIC
Date: Sun, 28 Jul 2024 12:08:43 -0400
Message-ID: <20240728160907.2053634-1-sashal@kernel.org>
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
X-stable-base: Linux 5.15.164
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
index 4d4267105cd2b..842e8fecf0a9a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4971,6 +4971,10 @@ static const struct pci_dev_acs_enabled {
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


