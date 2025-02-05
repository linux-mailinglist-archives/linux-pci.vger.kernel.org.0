Return-Path: <linux-pci+bounces-20773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69924A299D8
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 20:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF497A3AB6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 19:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEB020011A;
	Wed,  5 Feb 2025 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G34l7Riw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7642B1FFC46
	for <linux-pci@vger.kernel.org>; Wed,  5 Feb 2025 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782752; cv=none; b=lU7GiZ46QHFuEjl+FcuCAdg9MyogZUv/CvAIB3gtdTk67B/ZlV5H3EFv8wDN22t1yv+PaUVdL0qLr5YGlT7g/Vu1xl5c/wZb0gDke6unQzs/PQoXaMR7atlIFELpOdKsUpNwgryUvMuqbz1c/AL9FqRfAwmDwd5dSkZq4DQ5N9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782752; c=relaxed/simple;
	bh=pnzOH1e2axdVqJngQp6tdqFmDskboQFLalroUwFTUdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bx1OkPJ6ra6kK+oXIGFdH5VIz5oR06XX4CxPJgD1FPTZyF18gs/JdNoWjsLsz+8x9uOTL/xXoYqnOlCv/F3WBEXOC73EAgOQp/MaFXPe0EENaPxEsjDkVHXOW+SHXTNaeQI6H4KZJBcH2BnvSBW1cDa1dPgR9oe1tqw4uNFhA2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G34l7Riw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216728b1836so3469675ad.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Feb 2025 11:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738782750; x=1739387550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rshGoTVKNv7yJ8UG0ncdA2L3Ez+eMRudoZQa+hQwzgo=;
        b=G34l7Riw5CEHbbRxZts1CYc48HpXGjRfgWl5FQoMWp8Oo28jSTwQRwdu3DvfK5RjfP
         yX58EoHrk8Ndjp+fezovoQh9xvZDb2lqna+hPkT9ECX8e2NDwNXRN0pxx0PFLrkwJ/km
         Mqq2WEcfwyhhkuuNOMUS769/Nj8gI2tCmzI/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738782750; x=1739387550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rshGoTVKNv7yJ8UG0ncdA2L3Ez+eMRudoZQa+hQwzgo=;
        b=kIZUzSjevn650LcnXlZcv6DyMJZQ1yYHqHkSS5pOYXBLgVMtq3KLvBieyFq3VPBf93
         9N2Vy3YWuRTtnF7NPuFTHj6uWZn3UrJX/bhYvX/+L6deDUrxiulXxP1XfhY/V6Cn7QJL
         j0tJfoQigHyQvOwCpXSbCkndzX0mlCXWYalbdi5+WMm5OwLAn62pNMF59QgLG8hyRBRs
         kcbk4pXVnnC0KurYX+QhROJ45skSnQL/gPsJ2HCpWiplS2mWwzlrGFJKm9rQWVOxmikM
         5kVsf1gQ7iwgod7PwMhhxPpylNwwxMC78o642o5LryIivtG9wbLBLIHl8mwDTHAXZrPt
         tmnQ==
X-Gm-Message-State: AOJu0Yz0B9Oivl8UvawZppYs4JVuZ0UOCuZi2TGpAWvSFBR34P29PhWf
	RNzfCrVXmqaQEczapjT3N2WGVRsV2gOflTmjnmYFZ0ouREXrikBBH/iSRbYlOjnp/lFDTs+iuMG
	PgNoH/DLU4/5f8rEqGAwMMFFUSAT94Keg8H3M5umPxD+XywvOxwvcBr441NmFatZ4nWR0u9mbVz
	pbH9cXYVmc7ss7lB5pk0LRfqnRvQxzinVRWflQBT1rTDPs2NfK
X-Gm-Gg: ASbGncuqFexCwXWRiidU/KenVY0wT0b24d1ywaNHpBL82JadrIR2CyFNIN2WlWEoqOf
	Vts2GjpzNQEQiwwWBKwy30joFM7r48ZEZGQE5WWHzWZbT448n7YByQz+zp5dKCJzV9IWTgMaJ2i
	1h19fd67LzP12IdAWu5sgey/7ED8/4+3qz9nyKAtHM0jq82TYQ1xNoyiKrruQCW8rjWvKYdI/l3
	eJGwvc4DfExAeCQJWNJyV7QjTS6TSSwt+b/cRa2XfFTxFMzdDD3vtj/kDY7SZ3YLuja9DMMeEFd
	7SDao5wTtl1cqN3a2FvbBTcOCkqi0UUA1AGyoe6g0ZNpXdtxxjEsI+yg9csInZMTitrzmF0=
X-Google-Smtp-Source: AGHT+IEvH1UsOv2Pdep53yziZn/D7SThmLNGW4jFaeetD7lQZsfU1M4mdvMGq8u34jzx7Ya85/+NnQ==
X-Received: by 2002:a05:6a20:2d0b:b0:1ea:ddd1:2fa7 with SMTP id adf61e73a8af0-1ede88b9994mr7396175637.28.1738782750080;
        Wed, 05 Feb 2025 11:12:30 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ceb1csm12670842b3a.151.2025.02.05.11.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:12:29 -0800 (PST)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 2/6] PCI: brcmstb: Fix error path upon call of regulator_bulk_get()
Date: Wed,  5 Feb 2025 14:12:02 -0500
Message-ID: <20250205191213.29202-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205191213.29202-1-james.quinlan@broadcom.com>
References: <20250205191213.29202-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If regulator_bulk_get() returns an error, no regulators are
created and we need to set their number to zero.  If we do
not do this and the PCIe link-up fails, regulator_bulk_free()
will be invoked and effect a panic.

Also print out the error value, as we cannot return an error
upwards as Linux will WARN on an error from add_bus().

Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators from DT")
Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index f8fc3d620ee2..bf919467cbcd 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1417,7 +1417,8 @@ static int brcm_pcie_add_bus(struct pci_bus *bus)
 
 		ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
 		if (ret) {
-			dev_info(dev, "No regulators for downstream device\n");
+			dev_info(dev, "Did not get regulators; err=%d\n", ret);
+			sr->num_supplies = 0;
 			goto no_regulators;
 		}
 
-- 
2.43.0


