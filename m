Return-Path: <linux-pci+bounces-13844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFE5990C50
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 20:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F8B281150
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 18:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2941F5BC4;
	Fri,  4 Oct 2024 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXUI8Zq1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940AD1F5BC0;
	Fri,  4 Oct 2024 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066171; cv=none; b=kqxECKwjeGm941lz7JsC8Ozp0TcaNiLdCvW4h8OADVkbkOO36tWrcUw7iHdBPAj6O77nXmwhMbaFhD5ZxvAFtwAoiVj/Rr2fm1rTufZia2ZQ6ren3sa8m0uhdsUh/zfDdUC0M6XlK209hh8e/nQM2ImmDnkrACzplX49Qo5XgLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066171; c=relaxed/simple;
	bh=tqSLOFPfKEnqGdn4qjmQhLMprXa7jx1CfgoRF+aYnQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNdHFi5hPvHjCoCoJMRuwZFYvnV/Hise7I2dHmpDXS+Q9OvHFfYMOMUeLXKDA58mAIFOrPoXPS6qqpbb5rn/OJvu3NjQx4PCmGJOAzcX/guaUfDaLyL9+vNQxUc6h2j5xgUmzb8vKv3EiTkWUZWbRDyi1xClWGfAEXJ57gRg/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXUI8Zq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92895C4CECE;
	Fri,  4 Oct 2024 18:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066171;
	bh=tqSLOFPfKEnqGdn4qjmQhLMprXa7jx1CfgoRF+aYnQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MXUI8Zq1qoDeEwiuIkOpmDPGTuvq/LKlOE5eMyjlQa9UaBNklGF7EPuQ0hF0H+SUU
	 vLjbg6C9gDucIpjp8+wkQ8E9uzVK+qTFBj5MVlHCvBGXvxJQzidys7iI0J5wtTbmRR
	 OyhnyokhT5EEN51fbSGCUbzcR5rkx6vA2nKYRFbZzxOQSMWJpVJptEXRFJFag39lT2
	 Otc1BhDS36LnQlyM4dZ6a+EZhzE8Ua7Kb0VdcrouEAUMbgmHtd2dEN/F/hKB4/JhUn
	 igrgqOulyBGaKInb0HHrlZL69wNs6WQ86/4878Kz2R3eI1g9zTpKcsot2mzreus87w
	 CX6piwJ+86Z+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	zdravko delineshev <delineshev@outlook.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 28/70] PCI: Mark Creative Labs EMU20k2 INTx masking as broken
Date: Fri,  4 Oct 2024 14:20:26 -0400
Message-ID: <20241004182200.3670903-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
Content-Transfer-Encoding: 8bit

From: Alex Williamson <alex.williamson@redhat.com>

[ Upstream commit 2910306655a7072640021563ec9501bfa67f0cb1 ]

Per user reports, the Creative Labs EMU20k2 (Sound Blaster X-Fi
Titanium Series) generates spurious interrupts when used with
vfio-pci unless DisINTx masking support is disabled.

Thus, quirk the device to mark INTx masking as broken.

Closes: https://lore.kernel.org/all/VI1PR10MB8207C507DB5420AB4C7281E0DB9A2@VI1PR10MB8207.EURPRD10.PROD.OUTLOOK.COM
Link: https://lore.kernel.org/linux-pci/20240912215331.839220-1-alex.williamson@redhat.com
Reported-by: zdravko delineshev <delineshev@outlook.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e616add85b134..d2875e04378a4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3608,6 +3608,8 @@ DECLARE_PCI_FIXUP_FINAL(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
 			quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_FINAL(0x1b7c, 0x0004, /* Ceton InfiniTV4 */
 			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CREATIVE, PCI_DEVICE_ID_CREATIVE_20K2,
+			quirk_broken_intx_masking);
 
 /*
  * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
-- 
2.43.0


