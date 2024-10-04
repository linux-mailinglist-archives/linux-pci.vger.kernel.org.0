Return-Path: <linux-pci+bounces-13853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6D6990DB7
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 21:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F3A1F21A49
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 19:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79704211880;
	Fri,  4 Oct 2024 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkXWPtx3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1A21D8A1A;
	Fri,  4 Oct 2024 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066472; cv=none; b=ess09CuzP/OyRqTBITkfKsJfIwItPbWnbFy7pqoTBzBSKXPZ6hqXjV0q7mKYHj5J+WehpYay2qKXR9UimBkCxNES8SlVcx4lobcvjmA6H7f3m2/z0+mbAjjyDGkeM+8+JJmkkIavCzB7Sj5zNSrTgHFvAtyUrxcznMKhWowAcqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066472; c=relaxed/simple;
	bh=f4vQGxdiJ2b7QPQg78n8WmDb/VeocSReR2PSAfRaUGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3fF52zAbvc93EXD8FqgjlAVpFMjktpL47rpRVAeK/ZwiPRNrGlOC+qykFntC/3GS2600xSEgHaZ3y121yBtUebAhGhlFHG7NkaPS98WEVainjMEDEPskCqq8QVlxnLDE/xwNSL3VuuG7K7wkfcFJoFKuDp48x4wa71+MFHIdao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkXWPtx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A6BC4CECE;
	Fri,  4 Oct 2024 18:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066472;
	bh=f4vQGxdiJ2b7QPQg78n8WmDb/VeocSReR2PSAfRaUGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CkXWPtx3cBphG3a91COldLqvMpsRoHLsu7Fd1GvGqqnVIUY4JlZfTwtVMQLRQlYmp
	 w6kgtyQRwZvO8QNCHb/cO9aFH1yracni2gnE2ymo+3HQpF9W/KkTl7ih8eNXEJ+jUM
	 fUNHRjHP42OAesy2+MkzIhxb6p0cCvCuFnL4PC49Ki3bU7UP3Pn1KGY9zJG7/e6iHA
	 EseYvkMXuhd2jXsz7ACawmXrVWUgYBt3IpNQEen2GAwYdOgYbdyKrBK6Ed+NQI1+mm
	 rigSVIcnbM/oiZR7helz74P5m3Z5GB10U6Ep9jrXEHDI8k9B4cTpAP1RdQOHlYLusX
	 j8xJLcgvjbYzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subramanian Ananthanarayanan <quic_skananth@quicinc.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 18/42] PCI: Add ACS quirk for Qualcomm SA8775P
Date: Fri,  4 Oct 2024 14:26:29 -0400
Message-ID: <20241004182718.3673735-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Subramanian Ananthanarayanan <quic_skananth@quicinc.com>

[ Upstream commit 026f84d3fa62d215b11cbeb5a5d97df941e93b5c ]

The Qualcomm SA8775P root ports don't advertise an ACS capability, but they
do provide ACS-like features to disable peer transactions and validate bus
numbers in requests.

Thus, add an ACS quirk for the SA8775P.

Link: https://lore.kernel.org/linux-pci/20240906052228.1829485-1-quic_skananth@quicinc.com
Signed-off-by: Subramanian Ananthanarayanan <quic_skananth@quicinc.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7ebce76778f71..131c75769b993 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4972,6 +4972,8 @@ static const struct pci_dev_acs_enabled {
 	/* QCOM QDF2xxx root ports */
 	{ PCI_VENDOR_ID_QCOM, 0x0400, pci_quirk_qcom_rp_acs },
 	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
+	/* QCOM SA8775P root port */
+	{ PCI_VENDOR_ID_QCOM, 0x0115, pci_quirk_qcom_rp_acs },
 	/* HXT SD4800 root ports. The ACS design is same as QCOM QDF2xxx */
 	{ PCI_VENDOR_ID_HXT, 0x0401, pci_quirk_qcom_rp_acs },
 	/* Intel PCH root ports */
-- 
2.43.0


