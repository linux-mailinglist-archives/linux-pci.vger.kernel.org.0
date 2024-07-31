Return-Path: <linux-pci+bounces-11080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B619438F0
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 00:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C15C1B23CF5
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 22:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A0D16EB71;
	Wed, 31 Jul 2024 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gekSnrla"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6055216E89E
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464924; cv=none; b=MWPnfUO1slC9iy6ndoEenD7GMXSPcbwTPqNcxPP4hk9WwPL8UkrIrtLFLEnV/V7d8dXjz1ciIKfud85hb1AQswZBYd/RLiMxkrcVrjR2TbUo2pJ/ZPuqaASny30dH02c5xZwJ2mKQ3Pu/ysVjGC35xNLRkgEdsUxyztWyx9f6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464924; c=relaxed/simple;
	bh=ohxTxIMDhY1ATcgdpM1JyttNCDtL0q2lDi0qmnU6oPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RFYcwRPSKcMES6BTqotocAgtW1gJxFIRxNiAEf8/Kxc8y21kkDhwH28/GpJP/IOi1rYjedq/tXM7UT4Gvhzibc5FhEdmHfCy+ARo6eYhA0TFJc5GWJ0y50hkva7iFcbB+0HOuC75xbKKwpowJl6dR2ASTZ9IGhAjPYzcrdQJJ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gekSnrla; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44fdcd7a622so31050101cf.0
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 15:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722464922; x=1723069722; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BvkPsLOG5fUE2ytDC/96EogS/1H6a6HtgvVDjzytUG8=;
        b=gekSnrlaIcBasVelXAtPu0R+aEG5i5alx1+igVCPdMmZxNeQr95zRQy8HeESR51x+C
         4oRS8Lnh1Jf5aiK5+a8HZuc1kK/+0Tom0vyCTrwg64zF+xO5COMFIEltT5WJi6qsJOV7
         QQjT36VRLsRepI7Y7bz2SykaE2q//W+4lqPew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464922; x=1723069722;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BvkPsLOG5fUE2ytDC/96EogS/1H6a6HtgvVDjzytUG8=;
        b=kV0VwcZZXNVM29s9uU0cnskf2SgohTJgdzBWDhbN3eSgyOBd7AGnkVLhG3l2yUq264
         B2svhYlWmaqAZp8ub+OWOnv6EoumBQ66XFac0iXGv0vqBgGb/dsa8Dk2oHK5GgOjIBPc
         zcRDBfxQjPkjwxSvxizL1xVB5TkmUBkOLHHI/gPxZywZg0YPVaIl6qslDs0asISigui9
         hkerv6ix+Ctr+FNStlKsVzpmjAZryhxgG2TSr0P2ABimqPWmp18nMO/FmFlt+5k6127A
         o4CvGFD5aQzbIxV1xztBPD1wwl8N7hToxzg2ERV7qOctZJPdZjGQv3z2R2OpbNufQVUj
         EmYw==
X-Gm-Message-State: AOJu0YxJyXZ0zXqCdU7fW6X2MSEv6ctlD6AdJ418wneGrKCHsno+R4vk
	63eU9Z269cfAuJX5sOBmUgXV+JZaVErfhVY7qfT67jjyel73jBsEWCQQmDxTLaDXNT7rq26nWRW
	/W/9/narQuDnEAwZnXK2O+kWvQtzf/EcI2DLgZ3BSR+yGuh+c0pnEA+cCuY4PoREMnKBUvNAcYm
	6QOU3I3s2XtdyBaIZ1X/4ggYRVbO5iNNRfMatTsy2jHe3JQg==
X-Google-Smtp-Source: AGHT+IFBtq3zfvlVDpCsnHiydXJF3wP25FYPP/JkCKWE8phEA2Y4P9A5CFNfuo6bGZRLAirUY+0/bA==
X-Received: by 2002:ac8:7f87:0:b0:447:e542:ab00 with SMTP id d75a77b69052e-451567a84b4mr8510471cf.50.1722464921783;
        Wed, 31 Jul 2024 15:28:41 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8416c80sm62359181cf.96.2024.07.31.15.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:28:41 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 05/12] PCI: brcmstb: Use swinit reset if available
Date: Wed, 31 Jul 2024 18:28:19 -0400
Message-Id: <20240731222831.14895-6-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240731222831.14895-1-james.quinlan@broadcom.com>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The 7712 SOC adds a software init reset device for the PCIe HW.
If found in the DT node, use it.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 4d68fe318178..948fd4d176bc 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -266,6 +266,7 @@ struct brcm_pcie {
 	struct reset_control	*rescal;
 	struct reset_control	*perst_reset;
 	struct reset_control	*bridge_reset;
+	struct reset_control	*swinit_reset;
 	int			num_memc;
 	u64			memc_size[PCIE_BRCM_MAX_MEMC];
 	u32			hw_rev;
@@ -1633,12 +1634,30 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pcie->bridge_reset))
 		return PTR_ERR(pcie->bridge_reset);
 
+	pcie->swinit_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "swinit");
+	if (IS_ERR(pcie->swinit_reset))
+		return PTR_ERR(pcie->swinit_reset);
+
 	ret = clk_prepare_enable(pcie->clk);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
 
 	pcie->bridge_sw_init_set(pcie, 0);
 
+	if (pcie->swinit_reset) {
+		ret = reset_control_assert(pcie->swinit_reset);
+		if (dev_err_probe(&pdev->dev, ret, "could not assert reset 'swinit'\n"))
+			goto clk_disable_unprepare;
+
+		/* HW team recommends 1us for proper sync and propagation of reset */
+		udelay(1);
+
+		ret = reset_control_deassert(pcie->swinit_reset);
+		if (dev_err_probe(&pdev->dev, ret,
+				  "could not de-assert reset 'swinit' after asserting\n"))
+			goto clk_disable_unprepare;
+	}
+
 	ret = reset_control_reset(pcie->rescal);
 	if (dev_err_probe(&pdev->dev, ret, "failed to deassert 'rescal'\n"))
 		goto clk_disable_unprepare;
-- 
2.17.1


