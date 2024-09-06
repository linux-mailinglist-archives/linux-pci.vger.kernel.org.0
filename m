Return-Path: <linux-pci+bounces-12896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B58096F26F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 13:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E771C23EED
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26E01C9ECA;
	Fri,  6 Sep 2024 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="PJvH4io2"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C50158866;
	Fri,  6 Sep 2024 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621014; cv=pass; b=tqTyAwDqvkFd3RoBH/obQSpYDZZPeDJTSb+jCHsRukuyuQyDSfbHu2RC5oJW+eD+SYhkj/u1iWIu/lGFLVSeB8YJH+kDkAhGJXSn5dam4VIEGsf97rqymzgwf8J+bzv1UACToAj5cqjwZDppBqLCGmvo7LwX1cye+FWAsIWZpPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621014; c=relaxed/simple;
	bh=VeWu0Q7HBCMb8CC0HM9o9z1Td3lQJ40pCAD7M+w3zUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZMjqA9yU+ifARXkyPt2Xozmf2fWnfUtQjnH5fIS6h4lKpfPsQB+QmV2oTXy407vyuio6Rn69RCdjVGeKcYzgn9eR+/shP5Zg9yyZ006aX5k08a/TvVJS878H5URSZQK3XzVIzR/FE4YhWgfQ4hqaHrLbNoIS5WQO4/5hpS/RSls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=PJvH4io2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: usama.anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725620994; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TsnyS4d5F1+fQwXS8QdnsodfUwajKiOUmH45kBOZ43eI+GDxG0gtyv8x5jTvvQ6vfhZlKBSfoauFj+u/yA9xPpW55rj0np7/Ou2MqiwHyD0zoB7alqpXqTMVjIdz+Z50sp7w5p9+GrCKkx3bJ84kUzssQ2GfotkhKfrB6zk9+Pc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725620994; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Hk3dEKo4OtxjsOE2EQD+oEBaenRW6kDIqnQG/8TbeKs=; 
	b=BPOzPrORzaib0/Gqv2WI1xXl8Aq5JaTj+S/7GrtMHUIpV4OsTEv9Y/gUtzl9k3t9drtBXXRrxFQda7JWEDuID/8MfzP/brYQKvzNMFZUIhcyzkcA1jOgLLHvGmj/pz8Q8/Q0Ht0wZRKhodhnS8zAVsQ9gQaaynrVCHbOtjz74g0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725620994;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Hk3dEKo4OtxjsOE2EQD+oEBaenRW6kDIqnQG/8TbeKs=;
	b=PJvH4io2t3cq98Q4qvgm9boWlZaM0js5bjMk1kcgRRES83M3mtCQEe2sAl+ml7mU
	uW4WD0HkEVfHfs6wHUVQXYxBsAu5G66dPR3I1/OKLYsS/edLbWDbB9Sr0oDw3VkjCDb
	PwgISuLROYgNUFDOXpBCFfPy3hSyiOGfl2q5P3to=
Received: by mx.zohomail.com with SMTPS id 172562099299268.57317148356151;
	Fri, 6 Sep 2024 04:09:52 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: brcmstb: Correctly store and use the output value
Date: Fri,  6 Sep 2024 16:09:31 +0500
Message-Id: <20240906110932.299689-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

brcm_pcie_get_inbound_wins() can return negative error. As
num_inbound_wins is unsigned, we'll be unable to recognize the error.
Hence store return value of brcm_pcie_get_inbound_wins() in ret which is
signed and store result back to num_inbound_wins after confirming that
it isn't negative.

Fixes: 46c981fd60de ("PCI: brcmstb: Refactor for chips with many regular inbound windows")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 55311dc47615d..054810d7962d7 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1090,9 +1090,10 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
 
-	num_inbound_wins = brcm_pcie_get_inbound_wins(pcie, inbound_wins);
-	if (num_inbound_wins < 0)
-		return num_inbound_wins;
+	ret = brcm_pcie_get_inbound_wins(pcie, inbound_wins);
+	if (ret < 0)
+		return ret;
+	num_inbound_wins = (u8)ret;
 
 	set_inbound_win_registers(pcie, inbound_wins, num_inbound_wins);
 
-- 
2.39.2


