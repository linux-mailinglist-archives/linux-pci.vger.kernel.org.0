Return-Path: <linux-pci+bounces-17693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1276A9E437F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 19:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D77CB2837F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 17:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1DE237EC7;
	Wed,  4 Dec 2024 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkgG07JT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816C2237EC4;
	Wed,  4 Dec 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332433; cv=none; b=j37W7sw4FWH/8R1wlLX7FThX20GZubfA1miNhEfzQ9vLF8qHEF+4gZSy9/tm2zhAnEj8dhy8ZUWmOkZgxj2RWZ6+WfirZGrsOTksz6FSD/pd8hOiDgth9KIuDxVuToAg/RcsYW6jNBBlxUry9fyLp53BXJPRbKarX9zY0xRAPiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332433; c=relaxed/simple;
	bh=C+g6V3G6N0wSuZKsL3GtAbz0xw+hls9DGzXMrgjgSGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rF+kQZsUmeuJLOzs8vyV7C73RGf6XJKYPRjpMggZ6cCd9PLm+UixshdTrC7VL/8dG2k/pjCSQPr2Z9kwWj/bRsP2s/vrjaTEcoVlPf/40gtnpSjSNBvmMq14Rf6qBzIhFOhE3mNG8efJRUw0gfbrhjnY6D4ObQhFjeNuCla6fiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkgG07JT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B768C4CED6;
	Wed,  4 Dec 2024 17:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332432;
	bh=C+g6V3G6N0wSuZKsL3GtAbz0xw+hls9DGzXMrgjgSGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qkgG07JTb3wons4wfUL4+7EAyNJOA3OKFIaBpgq9NPPG+Mm0FESMwS2fPfzgZH45i
	 LDKcDsnGg+pMla1NismC8Gq9N1F073nY1pysWzH0vdh0UiVCZuz8aEDA/4wRe6wH0e
	 WUwhhQp6eP3NxVSuHcq+93ITcnPHj1n103eDI+3piW2vfYJN3QoMatk3vCsyRs4jS8
	 02WsJQH7G3v1wDjnx/Sv7fovZRy2bMg8I1vZc2xFa60+JmrKqtKP8nvad24w1YoLK7
	 1zFF94fVEduRHN02Biy11O9M5M1UnEGltNNNd2vzaUdS5H5Gfp5PsXxauz4o0k2YZL
	 Rm4SGDueeJ4yA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/4] PCI: Add ACS quirk for Wangxun FF5xxx NICs
Date: Wed,  4 Dec 2024 11:02:24 -0500
Message-ID: <20241204160227.2217428-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160227.2217428-1-sashal@kernel.org>
References: <20241204160227.2217428-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
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
index b60954b04a077..6a2d64d050c04 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4870,18 +4870,21 @@ static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
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


