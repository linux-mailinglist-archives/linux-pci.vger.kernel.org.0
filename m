Return-Path: <linux-pci+bounces-17689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07879E4258
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 18:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7DD286F43
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 17:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD1423616F;
	Wed,  4 Dec 2024 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUEgX56n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548C723616B;
	Wed,  4 Dec 2024 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332410; cv=none; b=c3etfkMA+Wah1VV5cifvctj+j3Y2lPSIIau0ZvsGEt1JU6LlARLNVGWyXFfukI4q/RAkr5yGdRxUlknMaERbxN0+2qy+NXcGoXZ0dM2m4/PDxPPOUsrn/CaeOWDheTsTFrLI/tkxhlIDX5Uyc9xwhfppD5I0lL5sNM8VpSzI2ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332410; c=relaxed/simple;
	bh=gwj10IZEnbGdabcW/HcHYtZXeY0iTbo00wWMMX3xrHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YP5bXhtjmwXr/jJriUr1eOlOIS8CHk4Bfajbn9qjfLh1S0FleP0kHfCIKulKdHWJ3tuxpjhmqWjgo5ds1kvgLADfc4fpziRP0dqMFeO+CUsSyOxW/ZgxvM4vE7pOWqeXeii/xt+75ZqWrTFe4L2K6V5CY75IhGECzFGJ0URy3RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUEgX56n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DA9C4CECD;
	Wed,  4 Dec 2024 17:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332409;
	bh=gwj10IZEnbGdabcW/HcHYtZXeY0iTbo00wWMMX3xrHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IUEgX56n3pzaCB1ftGM5sJcPnvP9B3sXP1ApgXZC3kBQslV+UPd2fV1yfTKl6HpCG
	 +BKlhoEqowZAtW9NEmx04+r0iYhPKme+wDeco1SVtu3uDugAv1buWLasEB2SSmNvNl
	 QGChtr5cSf2m/kaiKuiD56v0Onb1RZikxrJp8thdB+Rp+bn8r1tdioaWGtMeZZ8cDu
	 b7ZSkjStKjfuJe/ehWOt+91Atw1xazl0SCy0155niE+dxyNnrK72pfP5qClW0CMJPu
	 2eP4SxrjyoY7z76YD+VPeAHruGEAyAxr7Jby5+DzBkkJcmZgnCq3/IULiTKKsN4Tco
	 rDctPkZ55GOIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 5/6] PCI: Add ACS quirk for Wangxun FF5xxx NICs
Date: Wed,  4 Dec 2024 11:01:55 -0500
Message-ID: <20241204160200.2217169-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160200.2217169-1-sashal@kernel.org>
References: <20241204160200.2217169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
Content-Transfer-Encoding: 8bit

From: Mengyuan Lou <mengyuanlou@net-swift.com>

[ Upstream commit aa46a3736afcb7b0793766d22479b8b99fc1b322 ]

Wangxun FF5xxx NICs are similar to SFxxx, RP1000 and RP2000 NICs.  They may
be multi-function devices, but they do not advertise an ACS capability.

But the hardware does isolate FF5xxx functions as though it had an ACS
capability and PCI_ACS_RR and PCI_ACS_CR were set in the ACS Control
register, i.e., all peer-to-peer traffic is directed upstream instead of
being routed internally.

Add ACS quirk for FF5xxx NICs in pci_quirk_wangxun_nic_acs() so the
functions can be in independent IOMMU groups.

Link: https://lore.kernel.org/r/E16053DB2B80E9A5+20241115024604.30493-1-mengyuanlou@net-swift.com
Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4ce4ca3df7432..6b76154626e25 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4855,18 +4855,21 @@ static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
 }
 
 /*
- * Wangxun 10G/1G NICs have no ACS capability, and on multi-function
- * devices, peer-to-peer transactions are not be used between the functions.
- * So add an ACS quirk for below devices to isolate functions.
+ * Wangxun 40G/25G/10G/1G NICs have no ACS capability, but on
+ * multi-function devices, the hardware isolates the functions by
+ * directing all peer-to-peer traffic upstream as though PCI_ACS_RR and
+ * PCI_ACS_CR were set.
  * SFxxx 1G NICs(em).
  * RP1000/RP2000 10G NICs(sp).
+ * FF5xxx 40G/25G/10G NICs(aml).
  */
 static int  pci_quirk_wangxun_nic_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	switch (dev->device) {
-	case 0x0100 ... 0x010F:
-	case 0x1001:
-	case 0x2001:
+	case 0x0100 ... 0x010F: /* EM */
+	case 0x1001: case 0x2001: /* SP */
+	case 0x5010: case 0x5025: case 0x5040: /* AML */
+	case 0x5110: case 0x5125: case 0x5140: /* AML */
 		return pci_acs_ctrl_enabled(acs_flags,
 			PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 	}
-- 
2.43.0


