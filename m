Return-Path: <linux-pci+bounces-21501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 839A3A364CB
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A45170D46
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDFD268C7E;
	Fri, 14 Feb 2025 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AU8jaPw/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BE2268C6A
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554798; cv=none; b=SRMqJZftoWEMgxKev4v5d6llxp3IFlDK1kovP9YeCOBDfHPHfwgJyqUJfiP4/NYos3p6JW8tpRTvFWNXjPMaW7BYxYUD6jpfO89/rrrDY2wtkclWR/lsQMB4qJI+ecB/rkQ41daNp1im+Lhvf3EfCdmwdsFCNINwcOAXqEebg5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554798; c=relaxed/simple;
	bh=wWDSiynleuPZE3S/Pww46mj6AfFqdSQeGB8YL6rAx6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAyd4Us4Sb6ypDMmh3k4GEobSqc673++C7Mu/8IRK2Md2mBERWi+4fTIU/33bzbcg5EJNpEFQzs9X2sHE0xtyEAhotDVsovz6XFnOqWPRwXKqS7nqAcK4OjugbDq9e4mW+SdM86TMk5baxZcsyMQ6sNeZGKABUGuf1UvoRFxGEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AU8jaPw/; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5fa28eaa52cso1469440eaf.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739554795; x=1740159595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5WBjTrVITVgZYhJvGdqnlQGu4S0yfOA3QhZ3ApzwhQ=;
        b=AU8jaPw/4w+cfO+cCUdXeJEYR22BVnJrhQKfQHd+XhCNgfjJaAVs6p/j6uSHtm+VLy
         HvHefs3GA1hhAn9Bcz9SQ5zDWW0ojzXZp1qS+rzzYlcUlM3GhgvLPAk93Jvxty5UaIVF
         drPjZqtcXROzByUz/bSLYnMGqc0IYJ1kBOzuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554795; x=1740159595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5WBjTrVITVgZYhJvGdqnlQGu4S0yfOA3QhZ3ApzwhQ=;
        b=tQnnT0R9WRcCq+T/7OO66d58oywheUfbow3SJU/hsbwsFgh2jtvHxYiAOnPWn3FBYu
         gOSP+coe+oEXZj+ewK2IJS4NYlUTbBAJHDcpUUXezbNkCGiqmt9LIeZssQ8QZcf4UnN3
         R1xy1XtIjG+DGG2ApWGXxYo6FVnKF3NzBmGTcj2w/wQ+7GMb4q2eEKaRRgkYF5bvrzqR
         lwX38yFKLzf+m3q99+PfMN1Yu1HUVR8e/d/rNzbcAiZgAuaMUwcYBxynmTDbtE5P4a4/
         ncQ566+dyzu7Eusnu2oaVJUh2zQ/l25k1x9Fp/mGG/xxykeAH2QljNJCNBYlGKEZuXIs
         6VOg==
X-Gm-Message-State: AOJu0YyBUUWjppvLdRMa7SsME9DV/rKSu96Qsu6eLfp+OH8L+edShaUz
	ijlOT7YA3BQsNCoMsyOZyIKSE57Zid2eYNqhz4eSFnAoPmpEtc/BUDfUbssKs3a7rRE/MIFp0YR
	QwfnO4MkIGByseR0kzGOYnXo/uiZu+7gkAMlKRh1EqVOMtIBVe2nM7S7fn0+GCOwKE6wKWuL9ds
	L2BuSFWX2Kmj2MCSMUz+pkr67WH05O17aO95CMduFv4p5ITWTy
X-Gm-Gg: ASbGncujL04E0RfkoVBLTsawnKs2ruElUyNB+xrKtBRloHDbU3pvJ2FKepF2TnPGRg/
	grZONeKsAse9p7zu+4+aQxUG7f8ZOID5EXQd1zuuD2R2n2hc6RPYWHLr/lHghxJKUwlUDgxL7P2
	HZQRakc4I8wsZMPXj+2+STYHq/at0ybY8kaVD++xPn8Jow+EN0AAwnJxFeCD6F7GiI3++vZ0pvw
	kDB7LzL+rOEDek7goS9kVVLOQXU7TplyTUfZEI0r7kpl+dOqNutwbJ4h80dsFPVHAFNBSWAEHJ6
	rUb1euaCnf1Wrbn8I9O5zrwLDbFJ81KVJRQ2/fKK73Wf/nbY4Lwqv0aRVoBLGHQEzhc2Xdw=
X-Google-Smtp-Source: AGHT+IHHLIOPe+42yxDSEg6UPq/HyJpzpOJx8RHpCQuMziDQFg6kMun+TwGePYtgASMBwGxG/t8jXA==
X-Received: by 2002:a05:6820:160a:b0:5fc:c1c5:873a with SMTP id 006d021491bc7-5fcc54fd122mr31501eaf.0.1739554795496;
        Fri, 14 Feb 2025 09:39:55 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcb17a4ca4sm1284073eaf.30.2025.02.14.09.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:39:54 -0800 (PST)
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
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Jeremy Linton <jeremy.linton@arm.com>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/8] PCI: brcmstb: Set gen limitation before link, not after
Date: Fri, 14 Feb 2025 12:39:29 -0500
Message-ID: <20250214173944.47506-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214173944.47506-1-james.quinlan@broadcom.com>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the user elects to limit the PCIe generation via the appropriate DT
property, apply the settings before the PCIe link-up, not after.

Fixes: c0452137034bda8f686dd9a2e167949bfffd6776 ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 546056f7f0d3..64a7511e66a8 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1324,6 +1324,10 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	bool ssc_good = false;
 	int ret, i;
 
+	/* Limit the generation if specified */
+	if (pcie->gen)
+		brcm_pcie_set_gen(pcie, pcie->gen);
+
 	/* Unassert the fundamental reset */
 	ret = pcie->cfg->perst_set(pcie, 0);
 	if (ret)
@@ -1350,9 +1354,6 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 
 	brcm_config_clkreq(pcie);
 
-	if (pcie->gen)
-		brcm_pcie_set_gen(pcie, pcie->gen);
-
 	if (pcie->ssc) {
 		ret = brcm_pcie_set_ssc(pcie);
 		if (ret == 0)
-- 
2.43.0


