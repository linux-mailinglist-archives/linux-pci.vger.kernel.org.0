Return-Path: <linux-pci+bounces-2633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B057083F6A4
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 17:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6662E1F243E5
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 16:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82234EB32;
	Sun, 28 Jan 2024 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uj6VoHHy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84A92E3FB;
	Sun, 28 Jan 2024 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458320; cv=none; b=OgFZBQvQcLo+xMzp4Z1osr4vHMokOAxST3AF1oOvo8cjynx7Jmuegb5B8omN9VwR1kmQU61jN56uaxaHAPHi6PMu4lHTRjGKPupvlLNZs13o0LT8TQNfUEwbpxnotv3RloUeI1HwXYfULcII/GZwclIdcEdBiErcHepaCjTQcDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458320; c=relaxed/simple;
	bh=aLHfVWaKvEX0qXeOY8RTqK/CpbpIPh/f3Oro8S0qHGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uvdc2f+GEAzxg9wGuygK/O0Rn+imeqjfd82II400Bxbj+gVPtgT3I9Bvkou2KAafHRTRWec5quxkGYafHUBu/RLVdViPz3UhftLqQplZhL+/KGSj8BoemPLY1Qds335FYtCOjV+tT5IHQ0SX5wCnNI9hgIHu0J5Bw4HBwYHFpDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uj6VoHHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D69C43399;
	Sun, 28 Jan 2024 16:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458320;
	bh=aLHfVWaKvEX0qXeOY8RTqK/CpbpIPh/f3Oro8S0qHGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uj6VoHHyggjJkdjTqji+qAw32BOuBG6nAU1v1LGuQi4GO1YOync6uPja1k2+/KHfv
	 Qy0jQXqLpmTNoatte3l3poGuFq0uxuF3aKCgesXnCkwoevAEbwytW7wrGxTNY9JZIW
	 8emSi/enSI/SSKDjZgVdSh6vzu9J/RSTAP6zS/ZPj71YdVXGshY/PhzwGdB+Ndc7GF
	 Jb/+GeXM0xOFCJ7rYtqUDvD0cWZ6HTEQI6ZjPY/SLNVuWY1pOGkY89hUencmdjtd+b
	 YUcXAEZW0yge8zpiOjXQQG2qZLmnTBIlhub0KSvFID7kIbwFnNaj0RY15C1YaKX4rq
	 z3budv9H2d4tA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 16/39] PCI: Fix 64GT/s effective data rate calculation
Date: Sun, 28 Jan 2024 11:10:36 -0500
Message-ID: <20240128161130.200783-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
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
index f43873049d52..c6283ba78197 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -272,7 +272,7 @@ void pci_bus_put(struct pci_bus *bus);
 
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
-	((speed) == PCIE_SPEED_64_0GT ? 64000*128/130 : \
+	((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
 	 (speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
 	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
 	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
-- 
2.43.0


