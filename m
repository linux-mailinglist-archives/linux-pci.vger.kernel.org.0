Return-Path: <linux-pci+bounces-2637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D847D83F71E
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 17:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC3A1F2A799
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 16:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC9160DEF;
	Sun, 28 Jan 2024 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1GD1WhQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A5160DE2;
	Sun, 28 Jan 2024 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458418; cv=none; b=BUX0dxBxVOtGLTjatpjZZMm+KaewI2553qe6oQRImHrsRhCUhe4a1SuCFbg9sQTgvnH6TZ2uhVfAEeDqIvY9+JqPzv2Jere5uBikTEsQ+gGS+49b/1VT8JBlQqQ0ZLe3uomorh7bbT/z2MOAx7jvDFCCDZlhrM18ExyxgPraUvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458418; c=relaxed/simple;
	bh=bAcWqAhQUqIXHIRsmqUiFdqDByAUih+G9oofDlAEWLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BoW7OH/pkhw21acK0Q8BJbgy12Jr2zWza7upbd7jWNJt/D9KRfXbq8M37IKXAw/bCcCHG1tIf9q28pjp2FkOxwRmJK6LGhfPTtNNPq6DwDIVWNH6oJ+qJkGCd6FtI24xXYVrjbFpDiqtt25G0heJU43+HoQpBEQTZPdV7nRtGrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1GD1WhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A15C433A6;
	Sun, 28 Jan 2024 16:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458417;
	bh=bAcWqAhQUqIXHIRsmqUiFdqDByAUih+G9oofDlAEWLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1GD1WhQFjGPKnWesPYcx9s/POQEHNOleV3yEj6LKdWX1ksJUV4MIx8iwxTRpicAA
	 T0NaEOEua8xGvVv/iUKAV3qSYogD6JoQ13YFGhctl7EIemH6LdztPH1F08mjhP91ts
	 WrmDznKIa1yMHz6RA1GPQa0DcdXp3LlXOU4ZWctrT5qQp4yAgs8VT0CRmd9+P0Pig2
	 tbSQaE6MXysq6L6lUv5wOHRXdDyLtfACzWDn7fOadJ7P6uwAli1yM6VlNSoDHO0fyO
	 O8veMvKi9QhZ1LHcy+ESW3zI72mVo3MEGMjV/bzuIPotJfzkrsiO8e+DXYRsoLV+TL
	 4tEW1oO5jWNIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 13/31] PCI: Fix 64GT/s effective data rate calculation
Date: Sun, 28 Jan 2024 11:12:43 -0500
Message-ID: <20240128161315.201999-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161315.201999-1-sashal@kernel.org>
References: <20240128161315.201999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
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
index 5484048f457d..99abc4cec0df 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -269,7 +269,7 @@ void pci_bus_put(struct pci_bus *bus);
 
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
-	((speed) == PCIE_SPEED_64_0GT ? 64000*128/130 : \
+	((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
 	 (speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
 	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
 	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
-- 
2.43.0


