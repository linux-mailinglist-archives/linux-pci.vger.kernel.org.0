Return-Path: <linux-pci+bounces-17691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063069E4264
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 18:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CAF168EC5
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 17:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DAC2111D9;
	Wed,  4 Dec 2024 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGHxWNf+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693D02111D6;
	Wed,  4 Dec 2024 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332421; cv=none; b=udfOU6hWkHZsP9rBIqVYwYm5EUGaSQmiQltpe96mHHcNqAD6cJcC0Ok//l1pc7loOyKX/GObtMHqwNHU3dI2Rt9dnaY6H0H8b95qgfaFo0/oU3AsC+l2MInJcVfaOt7BavPkg90PIseLHPQtYjvj4l6sxVpqk4MNEwOrQQVXJ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332421; c=relaxed/simple;
	bh=NLeJhhJ0d7Vb4wrWpECxG0/9i2FFOMfbuBSC4/uFRSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFHO7XZe2X4TTv7NFujds85aK3XxGDDsVVjG3QMo2NIcpfpzF//QwRfFzT6yJZ26Yr4lRV+ZlyvozjIKRHGRPOYReJ9G82hZp/YrlG0hd8kesVE33AyIRFgTtwFM9zLx+xEz/Xf6qJKZBMkcZ03aCBBJvi5319elCr4vx3q27yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGHxWNf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EC0C4CED1;
	Wed,  4 Dec 2024 17:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332421;
	bh=NLeJhhJ0d7Vb4wrWpECxG0/9i2FFOMfbuBSC4/uFRSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BGHxWNf+vJD00Cecy3C+AqO3DWeZGR6eskTR1NXXIKFHTsW+ZXJzpX3IILmUr+1sV
	 BWbSI518w3xqK0MO93vR1T91361o0imKhLYZFvQQdzzgZEr+JFwOHZtW2za+H2B/4+
	 OGeTalXLTX7ZaZsiVx6YKQL/9mMgBwy35KziTtSxr7b2JwFn1iUVwpixJXoPvCqjgf
	 QM9GFnPFqsiwzqp4Q6YboMkVlET8Xo4RPJvnUIhlFa594OIDYbjdloaB03MwJ5aIHu
	 kLBOPX3rY/JL0ixvBJhHFaRRv3ys1kqN/ZaVWgK2vEIA4ZqMPYFYijbw3mh1iMTYsZ
	 nUgcb7WtL9y1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/4] PCI: Add ACS quirk for Wangxun FF5xxx NICs
Date: Wed,  4 Dec 2024 11:02:13 -0500
Message-ID: <20241204160216.2217323-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160216.2217323-1-sashal@kernel.org>
References: <20241204160216.2217323-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index 86b91f8da1caa..37cc08d706367 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4829,18 +4829,21 @@ static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
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


