Return-Path: <linux-pci+bounces-2645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE0683F7BC
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 17:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2E01C20E0B
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 16:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113E912DD85;
	Sun, 28 Jan 2024 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcTfUczS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FF12CDBF;
	Sun, 28 Jan 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458539; cv=none; b=rDaqrTXSFgUATr5v95PnlqgxoFROEol+306CSsDdK6+RGT1QZRGXNQgB6xuPpBxQqitU1HROeuoyzQ6YG5CQ9yg/6h8gY1GaM3HisA1LXVGak6AAdXbI5/bmWemQgFxIkX7rkDarrEpZTHHOuLv+kx8u1trxNov9P9U+xd9M0Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458539; c=relaxed/simple;
	bh=Xl7920HQkZ7swwIi9lvrg+gUWUgjO2e+J2L2je5hU5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uw7AFKZrSIJUomR/tiKIrfVtzwcuq81m4uzP1/WinjlUPmSKkj0YOXpNA7nbJiEz2mvu8GNNDTfaplsafPUubGMeNjLWzgsanMCqn3+YkxTLNwQq9mjZYopnVHYiAHya1A4iSjNz7Vxza2h/M0r/QRJODbq4v3p2vuYt0h5B8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcTfUczS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF3AC433F1;
	Sun, 28 Jan 2024 16:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458539;
	bh=Xl7920HQkZ7swwIi9lvrg+gUWUgjO2e+J2L2je5hU5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rcTfUczSJgks6ar+0kDCH6mENgkHEp4i+hSi3ntv8M+Sqtr2v1e42Vdsg5O4eM51j
	 YiH1uqz6Bh4Zk7+zNerA0LMqpFteAyKbjasLW0ZPDLL4MMMaBk8lH1ag7Mn9zmhNKm
	 Gg61TQMyJfEt6BaA1G/Wzir+y/43jQ0kvwZOjuYQ/FDyH8qjDLIffW6jOsDFWAN7Tl
	 dERQ/rA61qKzSShltJTtWcw5rU0Ynq0HWVaw2UdW5U3ZK1zJdqV3zlOZNmZNm9gPF0
	 GxjLdVOb/Xi3hRd3HdnYyYez/MYzn914/Sf9dVhgMYosS/a/3Ns2mFnU3d4DqUibT/
	 CPEj3GMQosSJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 09/19] PCI: Fix 64GT/s effective data rate calculation
Date: Sun, 28 Jan 2024 11:15:06 -0500
Message-ID: <20240128161524.204182-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161524.204182-1-sashal@kernel.org>
References: <20240128161524.204182-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit ac4f1897fa5433a1b07a625503a91b6aa9d7e643 ]

Unlike the lower rates, the PCIe 64GT/s Data Rate uses 1b/1b encoding, not
128b/130b (PCIe r6.1 sec 1.2, Table 1-1).  Correct the PCIE_SPEED2MBS_ENC()
calculation to reflect that.

Link: https://lore.kernel.org/r/20240102172701.65501-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 72280e9b23b2..2b5337980da7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -312,7 +312,7 @@ void pci_bus_put(struct pci_bus *bus);
 
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
-	((speed) == PCIE_SPEED_64_0GT ? 64000*128/130 : \
+	((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
 	 (speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
 	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
 	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
-- 
2.43.0


