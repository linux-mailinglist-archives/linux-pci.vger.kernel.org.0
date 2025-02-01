Return-Path: <linux-pci+bounces-20616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF010A2486C
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 12:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E013166177
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D83137719;
	Sat,  1 Feb 2025 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jObRT3yy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378D617BD6
	for <linux-pci@vger.kernel.org>; Sat,  1 Feb 2025 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738407644; cv=none; b=n7GuHTxfAaj3iyZxso/UOoDUTGoXkhqjCBrlliw7BRaTRxJQRhO95MN/fROqbIrXyMP8a7Z/JUz4ubXuCzWwDtpN3y1KZcnz2Bbf1x6LvowPPw8V6AbBnCj8VnB/H2vzjPTsjMWQCNReOZb5QB2+pQdMsJfu7/m1Y6F5XfxV03E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738407644; c=relaxed/simple;
	bh=JmWAHXdOaXV/M3CCGGuc0twYRRreA4gPfNaDgyIKvt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ea8nYO3P2E41tvOlPE7eivDNkv55zIRprZ2LGFK3gAkaeD1HjrWOMEK0CccddABjS2YLJrxQtzddOLkzzF1yN+eh6GNRZIa1XUVaFGDKsiz4ciWeQ1wgh05dllcZvla/4nQzcqxs5nXmuXGjAvZs0dkPiNjrVPu4QJ++b+EWcXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jObRT3yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3286C4CED3;
	Sat,  1 Feb 2025 11:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738407643;
	bh=JmWAHXdOaXV/M3CCGGuc0twYRRreA4gPfNaDgyIKvt4=;
	h=From:Date:Subject:To:Cc:From;
	b=jObRT3yyoJqHYF5aDMmUTZBS1b4olMA/WGDtswtX1sg1FnX4jM9X0sbWfPaUoPx+J
	 DaW8nU+IKhT+oi13JNz9UOHqQ5Lsk3CLqbwsBheuTzz7O7fLn5BMSUeC7JT6wNcNi+
	 N/IlrlurmoPB/iynqZgAKAdICNNl/zrUx0LUe9xvWBU3voty2uosTzCNcg0e/JHgTn
	 PtbBJoQoVzE+ZfafA7EprUrsl7flCxV1HVdOkmL0r1KFPWJPsYkBiyxG03oVVtFoAp
	 g3AKzNL+/TfIWABKHtTMHSfAFLMbZkQi8QS+MSGmjZKk03poAAh+p24Nd4JQTU5mpY
	 K9IMjjjlGgvdA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 01 Feb 2025 12:00:18 +0100
Subject: [PATCH v2] PCI: mediatek-gen3: Remove leftover mac_reset assert
 for Airoha EN7581 SoC.
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250201-pcie-en7581-remove-mac_reset-v2-1-a06786cdc683@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMH+nWcC/x3MQQqEMAwF0KtI1gbailXmKoOIU7+ahVVSEUG8u
 2WWb/NuSlBBok9xk+KUJFvMcGVBYRniDJYxm5xxtXHG8h4EjNjUrWXFup3gdQi9IuFg69H8PCp
 MxlMudsUk17//ds/zAifk0mNuAAAA
X-Change-ID: 20250201-pcie-en7581-remove-mac_reset-16e7b6e3ef06
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Remove a leftover assert for mac_reset line in mtk_pcie_en7581_power_up().
This is not harmful since EN7581 does not requires mac_reset and
mac_reset is not defined in EN7581 device tree.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- fix typo in commit log
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index aa24ac9aaecc749b53cfc4faf6399913d20cdbf2..0f64e76e2111468e6a453889ead7fbc75804faf7 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -940,7 +940,6 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	 */
 	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
 				  pcie->phy_resets);
-	reset_control_assert(pcie->mac_reset);
 
 	/* Wait for the time needed to complete the reset lines assert. */
 	msleep(PCIE_EN7581_RESET_TIME_MS);

---
base-commit: 647d69605c70368d54fc012fce8a43e8e5955b04
change-id: 20250201-pcie-en7581-remove-mac_reset-16e7b6e3ef06

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


