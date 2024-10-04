Return-Path: <linux-pci+bounces-13849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBE7990D22
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 21:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE4D1F2149D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 19:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EFF204F81;
	Fri,  4 Oct 2024 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJK9xKj4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCA3204F7F;
	Fri,  4 Oct 2024 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066347; cv=none; b=AN27+BYr0lyhtA5T7SJUoXeNJMbYZkSPL0JG5UcloRSt0fVJy3uHpawZLF+uRdV1nFdKVUSbbbkM6Sk8PoUeEhl1xIB98a4woZ8FJbnrkPqPzaI22/oMZryWzs4IfKu8DaYP+LeFYZamto1hqmlvQCeKfxOnrgAqNV90a9cMqTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066347; c=relaxed/simple;
	bh=ne5KnQQ+r/SnAU48EHUjI5LbEmo1/sRY2ibkTUT+nnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWvT54t75K/+DIls6ckAcuCB7tyv4YlO1B93Dn15PvQbA/nE5mkQ7xRND9ogyi1rvqfdybFGUA7CuWbf/Wg1i0gZB5qodc3DUfxXTNR/HgSIZgndesyPJeynX9ow0VMcep7vp4twPgkTeZD4qukm8yjgdRByn7Y9hVwPVMnrs8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJK9xKj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D712C4CECD;
	Fri,  4 Oct 2024 18:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066347;
	bh=ne5KnQQ+r/SnAU48EHUjI5LbEmo1/sRY2ibkTUT+nnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KJK9xKj4y78WZIJaibbi4nT5fD6M3sUDzRBZMRj2EIkySmLqNeKco0Yk3g0s20C/P
	 hTVmADvNP0CZMURNj5Y1diWCRb2u9o448WseIvHaWFu9PiaMi6xPZpMr2X/FMm0c2Y
	 be46HAbgXiuYpuvJW2GsE7ew6D2Hc0TXhYxDwTU9S7lOezLOA4sykq9jp6Bfp9x+61
	 SnkMwlTmw4BNyRx0bVbSZUmBPL013N8txvr1bMVpWSTYdDFEWYNyeog9jnaEGtJC5X
	 0inGB+waTjUwapGhGsORbrc5jYMTCfmAKR2rBBnsIXuXCZd0fG4wzN3I6u8gD9iRCR
	 fjtOt54+s1Z/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subramanian Ananthanarayanan <quic_skananth@quicinc.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 24/58] PCI: Add ACS quirk for Qualcomm SA8775P
Date: Fri,  4 Oct 2024 14:23:57 -0400
Message-ID: <20241004182503.3672477-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index 5af53d9cc8b38..b70126953fc42 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5067,6 +5067,8 @@ static const struct pci_dev_acs_enabled {
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


