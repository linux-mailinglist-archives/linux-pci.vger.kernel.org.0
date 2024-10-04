Return-Path: <linux-pci+bounces-13857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E53F990E82
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 21:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A64F1B2A33C
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 19:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10371DE8A8;
	Fri,  4 Oct 2024 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nws6Kjuf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B897F1DE8A4;
	Fri,  4 Oct 2024 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066566; cv=none; b=e8I6J74bnmgmthCK6R3PczyiP0fhPUEIsqzevA/TKNIrA7JRa3BQjYuXgt8apGnwPIXrpeMj5dyrIMzXS9Pg0OYGVEFZQeA6Js23f4rcrCrwIbuTuN9eXH6e2xSo2i2FLErrR5OIa1K33Gj/24jxFzAw11p9/3pUwRGDm6Zmihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066566; c=relaxed/simple;
	bh=SX/GBVNN+MOa0kaEeRC5B2kAwXngpalqGNk5JbhH4Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNkjV1+nweTbQ9oE+ztXq4diT4LswvndYkQRRuZWceOk3rk2oK4urzIc8IlE/ndbbvuQOI48r47UjR0zu3O8s5yX6JMaahXKEy8WIpc0qd3ADnhUJRxnZlki7v1R5faBbf2O+VxNT4zXRuzqR3y8nyPJ+0N4FjiSikckKJV6Y7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nws6Kjuf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7627C4CECC;
	Fri,  4 Oct 2024 18:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066566;
	bh=SX/GBVNN+MOa0kaEeRC5B2kAwXngpalqGNk5JbhH4Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nws6Kjuf/0wNjbWBoAS/mkf1HlR9e6RKFOqCY7aEaSxBJMaW9WP5kv75daNF9HjG+
	 HnxvcVvHccHT/w9A3kZ6dVrtpJqVtZ0e31nSyA+OynZipOdvcssk/B2Bx1+Q/Zq4tT
	 BOUCs1Il1V4JGiobhcP6Gakta5qn+iX/vtrK/0B+gDG4rB997J589Omdw08lHyGzyk
	 PZ4Sccuen3TSePLuQFvD7g5EjbFjB1ePAS4yccdFISzw6ej84QFNM1uPJM3K9m0Ser
	 vga1ilf7Qr1LiQjG53TG0xh7hwQuDAlmAte8xSE35K20gTcEQa5zw2vZvnkY0CU4Eu
	 6GV7qaFmoUVMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subramanian Ananthanarayanan <quic_skananth@quicinc.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 17/31] PCI: Add ACS quirk for Qualcomm SA8775P
Date: Fri,  4 Oct 2024 14:28:25 -0400
Message-ID: <20241004182854.3674661-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182854.3674661-1-sashal@kernel.org>
References: <20241004182854.3674661-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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
index 2d648967aa85f..965e2c9406dbd 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4946,6 +4946,8 @@ static const struct pci_dev_acs_enabled {
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


