Return-Path: <linux-pci+bounces-20774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C701A299DA
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 20:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949C91884A84
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 19:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B1520C032;
	Wed,  5 Feb 2025 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A9GElEUe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6DC205AB8
	for <linux-pci@vger.kernel.org>; Wed,  5 Feb 2025 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782756; cv=none; b=N/oXsk1qclFW5xi6IGSxpzPP6yph0Nh6nn4nL0aeJKEeSPRESJbL4UBPOjRvsmTxycAf2O3POmAUORITqwSTL0jYscDPUtC6LjNPWxWUJTAN1ndhZ8ecv/cfCqES9XF38vtrE0BoOFW70tpMk+PKjhp8pHgJQHb4NoOnen07ArM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782756; c=relaxed/simple;
	bh=UOaTvQH694j5NPXqH8YX0yM0fuej0rpwLUTQghdWl0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zcpb4XuJljs1cHcq0SSn86r/vlD1xQCiLQi6rrRQcerF/zZu62GbUrmoWJHyPjOny72i9bpxIFBWyd/lVlKOzLMHgKVBPyIVuUXAxmCgSzS2S1eACD/LNvUcq8Ioxu6OS17/2aCWOArECUj+iteM4GyJFjiL9YO2xv6s+Y/ccLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A9GElEUe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-219f8263ae0so3891745ad.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Feb 2025 11:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738782753; x=1739387553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl5E0UVjy+KHHY0GruFIRH1nxCM5/nCEesXNNBsIatY=;
        b=A9GElEUeIbvmJcxzBukyz1jbrl+RbOeLkyl5HcUG284mWMyWpX9mAI4Wh/a2U+PG5e
         yglnbrryzc/8NupWix+bgE8V1wGSU4eVXw/w3wOi2qx027CpYrUBagMGDz8VX6Q3Y1Y0
         kLdS/1tpe86tnsuaAWOdcsuD1yIVrAvGHTxSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738782753; x=1739387553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rl5E0UVjy+KHHY0GruFIRH1nxCM5/nCEesXNNBsIatY=;
        b=J4whRpal37Zzmr36tfSqGEl7Y06206BrkumHQ65QxViK3vKKWeBuAA2mr8U/VV2OnX
         lLkyCP1fvQCrm25g08WsK9rR9WNLOj08N9QfR6Pvn46TOlAGPBcG/MV1UP3So9GykAwx
         j2fe3iFozCL9jR6RH7JftCHfkkPHKXdoL9+Pqb7ZBVDcEIS9MkyM/HXvQp8DmShBXT0c
         Dqb8V85swB5aPAguPcN8U5lEzlcNh67jRV0wfQl58GNuC7oJ5xj4lEJQyF0AHBf4azWb
         QIJbo196l+ff+S53QMOmT21figk9uQDA73bzkYZcH3rADKpT9c403G9WZCNAACVWhFvy
         aQzA==
X-Gm-Message-State: AOJu0Yy6dT+6ruy9Y8Docv0+E4ppgfMlBGoTkGCOa5TEM6eX3TpAvpe3
	SPeGWcpeR9ydTzYycGIzuw6nMlHVQBRPJdKWbRaegElihs5kRDpVEMeIpYrYSx204RnP0Tw2xOn
	LJtlSxcwUz8CtRKkqYUo1UeemKJDTYM0aVyYQPTTg/AfSUjXFPdADGh7CKnj9YFiX+AFy4dKTBm
	2J9XdR7JM9b7y/UVF2dFwvrIi3dlM2NvFxiwDKES1Des5/eZca
X-Gm-Gg: ASbGncufaH27vHNdcmeYE5go7Ct/iUh9gDBdYkwrc7oUXezhkJNL2jgw9CgQhLG9Tax
	3O6c4m0Fse7BuQHTyDdyLFmDvX4GzNzsFIH/kQAzwuNR9Pw/Lb3kkwRzBBzKnO4md6iTyRWBAa+
	ycubhI/CRgg38hO1kbwOw8AdaWT9adQkQhLMzDI8evcypKl0JFg+FinW24aRwWgSaRARXuc8oL5
	vY4FHjHcgYREl4aWrN0C2/vJLfdoDctDf3Kg3RLgPYaExg9uuh3iqyx86Awd1nbGun9DmJKCEVn
	uLKpTM86ZwQpPaJqNMyKP9F532MZ5S9TdejlOZw9r17qnuaoiRLDDJYXZZTenaKLxXcZz5g=
X-Google-Smtp-Source: AGHT+IGHNDQdUmc+0d+Oa25tolqBbEh64Eprx1WXUEnsJUtgXypSDf+wemV6e9iAiBws6tIO7Kj01Q==
X-Received: by 2002:a05:6a00:3cc3:b0:72d:3c4d:c1ea with SMTP id d2e1a72fcca58-730351017f7mr5551115b3a.7.1738782753270;
        Wed, 05 Feb 2025 11:12:33 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ceb1csm12670842b3a.151.2025.02.05.11.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:12:32 -0800 (PST)
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
Subject: [PATCH v1 3/6] PCI: brcmstb: Fix potential premature regluator disabling
Date: Wed,  5 Feb 2025 14:12:03 -0500
Message-ID: <20250205191213.29202-4-james.quinlan@broadcom.com>
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

Our system for enabling and disabling regulators is designed to work
only on the port driver below the root complex.  The conditions to
discriminate for this case should be the same when we are adding or
removing the bus.  Without this change the regulators may be disabled
prematurely when a bus further down the tree is removed.

Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators from DT")
Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index bf919467cbcd..4f5d751cbdd7 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1441,7 +1441,7 @@ static void brcm_pcie_remove_bus(struct pci_bus *bus)
 	struct subdev_regulators *sr = pcie->sr;
 	struct device *dev = &bus->dev;
 
-	if (!sr)
+	if (!sr || !bus->parent || !pci_is_root_bus(bus->parent))
 		return;
 
 	if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
-- 
2.43.0


