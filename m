Return-Path: <linux-pci+bounces-37559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0427BB7A5A
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 19:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4528F19E5C22
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 17:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094F22D8367;
	Fri,  3 Oct 2025 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NjkSElPJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A3F2D7DFC
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511085; cv=none; b=cENkRx9PaepeXOdQbN9vwrUajCcIes9hziaymab/skcBKYWsG7Z9V6msmitT+uXcDNMk7wOzIMrkrpLmx+Fe5xR6/Rq24McUHcjKyp+MHGl3jHqT38CP/pv6LQ6P+njI2d1Tu4NYuNEbR01mja2yIZPnNP6ISOw7ouGuNuZBB3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511085; c=relaxed/simple;
	bh=0P4l5HE9JICpSWU5DgWz3pTjZ6YmStuMYlU7hTnIXF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bTsybNR8qKiQAdF6qz2vjQrOGjm8P4nOtWTJBtJYbwjI4tc+xrjo7ayQbMlZp8t8iUauzwRgzR+mUmlyzfKV47Mg+G4UQEq7fBP4OlRG6j3+If8unxX88dh8rHOxfcn7Ilp9pMlZ1KrxRbIVta978NiFcnIoYvOjWWpCHTZXuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NjkSElPJ; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-42e758963e4so14383595ab.2
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 10:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759511083; x=1760115883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVnrp7WE13kwvvN6B2l11O4oBl8ExmT/hll5Efsm98E=;
        b=FU0cquaR68jurE3iZ6o57UwsGkuUEWyIP7B0j5wFQ3TZbe6XAqWG/ilzBQQQ0SuhvK
         PR8uq3YahLXiBB628NTZGnBF2LolZWcw3r01J8uvh7zZ/jfd6nla7ZcfqROqfJOJl1Tz
         +bvoutt5gpwq1+4Itwm3XaRUJ8vnX8hcFgJo4T58IWDiODSfj1NKh89qe1KDcNSPbYAS
         PlJcNaT2QPxJCZnVX/JgpM8F4XeDYOc78WgqjnNCBQVn6D6HMF5LMD44a5sND+JeSewy
         HRjTNcVtS6lxkNb/zKZFncDKSeoEerlH7WRYHnpYDEINCPQMeDSAGCPdzER+uLVYIoYh
         IuCg==
X-Gm-Message-State: AOJu0Yx1I/mAxPf1pRHBmQGTfK9lv/0G5BYTQaWh83khD5AweL8Y5KbL
	mn57XtbXfe3SVgk2k3OyfktvXaEpVUlMYr46ieb3E6kb+o4Qo5Mlr80gbVl8GVAdPo9geiG1KsU
	BzskZ0BqaQhCvcrp4X0jAwUTbJrkUJ3/LdxRgir4rUhCiHN1ondOVBceHwhKLqz0V5GY4NIOxdd
	0Oe+/4/dQMx0mNfK1lojwbQ2M1NJl7DDyIAcp4/nHqYBnDg6GOjrat0TUw6JzE7TyAcz0y5N9K1
	/fhKgh4EkJSTUR0
X-Gm-Gg: ASbGncsxNGdWD348Z0BVHD4sSd07MR3yWjI/1RmPfikLw6tQKVOhn7N1WL1dNX7vFwB
	Pkrz6aeH63u9xf3EGK5x5xWApM3MwUpf0eraiCjaxwSVGPdpmow2ZH6zfTQ8Ka+wQDOggXxXcH6
	tiy8E+K+PiGkq0zPsy++V1r4Y1yCDfgyPaeK6bLGgE8OjdctnPi+pRpzxGQRFNMCRqZfSTgXNiL
	/hUUC9OWn5/9Xa/DoN4mIDYqlf8CFG1c7giI010yhqUHbrWYjrpLVsZe1cA4x1a3TueCIQ+yst3
	auakaiVc/OBxhiR1yc1RM9d3udCMYgvbptyGBR3nYS536X+1fSdyiwMBo2FRUAP6DJzZPv+vBWs
	XLkZHkFJ6C/qN/by+Ra0q1xaAnHOOBh/RfU9Zp2zp9x1175oX02XKArbS4tAbt2KfwuYp0hX1ze
	hb8ZpU4P0o
X-Google-Smtp-Source: AGHT+IEmrbYmM283aDdLTvSPiun1uA3nSLqx3Ls03leTT6bhVAX3cKXT+hRBIQwHXrDVOeyPa+qz3IfuZ5wF
X-Received: by 2002:a05:6e02:3e8b:b0:42d:8afd:4444 with SMTP id e9e14a558f8ab-42e7adaaa0emr46855145ab.26.1759511082847;
        Fri, 03 Oct 2025 10:04:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-57b5eb026easm403433173.19.2025.10.03.10.04.42
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:04:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-871614ad3efso487563685a.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759511081; x=1760115881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pVnrp7WE13kwvvN6B2l11O4oBl8ExmT/hll5Efsm98E=;
        b=NjkSElPJrg6Cery3jkYLti++z60ATRSNwnOaRSblHPoZ4aVXl/gr2yKt5N2HFi3Tjm
         BuuItWeC+KD0Ux7UcRBgKIpnSkLTCTeHsiV1LJM04kLxM2uKHEq4yI34W22N0NTVS6Ib
         8fpqwjqmFGOo9sDIeBE00xVR4CwQfDxcPQWCE=
X-Received: by 2002:a05:620a:414d:b0:84d:26f0:613 with SMTP id af79cd13be357-87a37cb2c5dmr525099985a.33.1759511081397;
        Fri, 03 Oct 2025 10:04:41 -0700 (PDT)
X-Received: by 2002:a05:620a:414d:b0:84d:26f0:613 with SMTP id af79cd13be357-87a37cb2c5dmr525092085a.33.1759511080652;
        Fri, 03 Oct 2025 10:04:40 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55a34b6bfsm46472271cf.7.2025.10.03.10.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 10:04:39 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: brcmstb: Fix use of incorrect constant
Date: Fri,  3 Oct 2025 13:04:36 -0400
Message-Id: <20251003170436.1446030-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The driver was using the PCIE_LINK_STATE_L1 constant as a field mask for
setting the private PCI_EXP_LNKCAP register, but this constant is
Linux-created and has nothing to do with the PCIe spec.  Serendipitously,
the value of this constant was correct for its usage until after 6.1, when
its value changed from BIT(1) to BIT(2);

In addition, the driver was assuming that the HW is ASPM L1 capable when it
should not be telling the HW what it is capable of.

Fixes: caab002d5069 ("PCI: brcmstb: Disable L0s component of ASPM if requested")
Reported-by: Bjorn Helgaas <bhelgaas@google.com>

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9afbd02ded35..7e9b2f6a604a 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -48,7 +48,6 @@
 
 #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
 #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK	0x1f0
-#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
 
 #define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
 #define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK	0xf8
@@ -1075,7 +1074,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	void __iomem *base = pcie->base;
 	struct pci_host_bridge *bridge;
 	struct resource_entry *entry;
-	u32 tmp, burst, aspm_support, num_lanes, num_lanes_cap;
+	u32 tmp, burst, num_lanes, num_lanes_cap;
 	u8 num_out_wins = 0;
 	int num_inbound_wins = 0;
 	int memc, ret;
@@ -1175,12 +1174,9 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 
 
 	/* Don't advertise L0s capability if 'aspm-no-l0s' */
-	aspm_support = PCIE_LINK_STATE_L1;
-	if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
-		aspm_support |= PCIE_LINK_STATE_L0S;
 	tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
-	u32p_replace_bits(&tmp, aspm_support,
-		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
+	if (of_property_read_bool(pcie->np, "aspm-no-l0s"))
+		tmp &= ~PCI_EXP_LNKCAP_ASPM_L0S;
 	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
 	/* 'tmp' still holds the contents of PRIV1_LINK_CAPABILITY */

base-commit: 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4
-- 
2.34.1


