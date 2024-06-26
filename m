Return-Path: <linux-pci+bounces-9281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CE2917CAC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 11:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20FA2811BC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 09:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE9B16A92F;
	Wed, 26 Jun 2024 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="N0uEqOZa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190038BEF
	for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394816; cv=none; b=id+cRHMENzxC3zxmK6ZXRbp2vUT8uJNTK1sxORDM0GyLHQYjjGiJNe0k3EZ6dOqhMUAa+35DhtuZathwiAbGou0buCT3R7ue/z0KgWp0ykzd3kxCgePqVkabhD5tG60E9leUeu8essMGffkaKibjSC3l4BAseAIqlNyi8sV7pcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394816; c=relaxed/simple;
	bh=t3x+yPoWJqcunaS/pKWvxbPII/x2hQ1qiSygdYUHM84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyU0cBTd3akyLKJBtthNoY+3SeNU9A6boYfwYkbBsNe0yi8zyCP24oSU8nVZqWdFhZg3DLzaEKx/BGa75SLH3XM9/cUln7mb1zhilNludQngWgGbK9Q1a8wl/NVIJYPq+PJ9NgPyxhf/F1ljQC+Cu2EAgL8Vavf1plnjiATE0do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=N0uEqOZa; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c7dff0f4e4so5129554a91.2
        for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1719394814; x=1719999614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYkL/+OYvrPefgy3yyZJb4UdPCVnAP9ikoloQG2+LAg=;
        b=N0uEqOZaTh/aqHFkpOfdHSZQWREJGX+6QQIzadsbBdSCQvDDRqtnRjp23XHMQk8Nz0
         vIZ3v1L1WC4j7oLxMsVSyOSTqwpAIcqVgbcz+jmJOA3cCcMBadMA4S03Gr2ygGXbE0xR
         U3E3rFigujCbNtXC6/yziIkTR6Q1btkyync3zxI4op/ZtciQGlYXCJzGEPoVhQpyB4uR
         eyrvbJ/DumIgg0qfJxhWUqFMcNzAmidwRLGmRfz1AVJKDwvlLv8Jq3FUuDYTYtk6s3ME
         B2eHBH1QEmhUsMYNKV+MnVGYus3dMF9jgDrd9VA42ngRuxaPfTsv1FgE2QnjZ/Z/j8tb
         GG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719394814; x=1719999614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYkL/+OYvrPefgy3yyZJb4UdPCVnAP9ikoloQG2+LAg=;
        b=lMAqGxjBuazF6zDouhmIPnLjxeDB/mSxq3sz8SjwlPyFiwILLXvLZcXQhc2LxQ8u5/
         NQn+K242OOi+abt8aswGrwi/dhYI7hvgQc18B4Ena58ji6vXPCPIy2TdwR4oNI5woVn/
         6hhjfOCZP3Xtd3W1i2n3xwK8m//L4KYs//SUxSuIQRUPzwDbupMc6fzgZOyuU5kROV93
         PJhEMaGCDMZhg2qqFfNukzvX6KsbWWM5pLDZeeG19Ry+PcUzfYHXACW2YnSe2VQ/mj80
         uQW/MW0VGxPGbamIOrquPQm7sC4eg68QlBwusipKD4poOPGZxOJE7qgCjZA5yZzF8HsQ
         +QhA==
X-Forwarded-Encrypted: i=1; AJvYcCUeKzwmmUk6l/bn26PJmINsr4j49iPNylid9M6UkOxCRCfb0qW7S9Rh+7O8BTfljoGfAGCs9DC7EkuCC+73Ebm9Y9HxJnKUOOKO
X-Gm-Message-State: AOJu0YxE+lXEgzfVubXS15DYhA+7KWf6V66A6Xfx6Jf+5/27g2X0/0NI
	BhXM0yGF0B6GSuxZnr/tIcXLpp4TANq0S8wLN/44OeCLlm6YERkn9JQdeCoeR3YiK9oSwe76ngV
	N
X-Google-Smtp-Source: AGHT+IG3oKwCrQlC6wo/9oxGXcDpBv5N7NMtxjzsIJEcW7oGLQArvKeicnb3ZhGwKn3EmwKnwHhuvQ==
X-Received: by 2002:a17:90b:4c8f:b0:2c8:a8f:c97 with SMTP id 98e67ed59e1d1-2c86146c865mr7628141a91.37.1719394814219;
        Wed, 26 Jun 2024 02:40:14 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c8d806f8f7sm1199096a91.35.2024.06.26.02.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:40:13 -0700 (PDT)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v7 3/4] PCI/ASPM: Introduce aspm_get_l1ss_cap()
Date: Wed, 26 Jun 2024 17:39:12 +0800
Message-ID: <20240626093911.14435-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626092821.14158-2-jhp@endlessos.org>
References: <20240626092821.14158-2-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce aspm_get_l1ss_cap() which is extracted from aspm_l1ss_init() to
get the PCIe's L1SS capability. This does not change any behavior, but
aspm_get_l1ss_cap() can be reused later.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
Reviewed-by: David E. Box <david.e.box@linux.intel.com>
---
v6:
- Skipped

v7:
- Pick back

 drivers/pci/pcie/aspm.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index bd0a8a05647e..5db1044c9895 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -611,6 +611,18 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	}
 }
 
+static u32 aspm_get_l1ss_cap(struct pci_dev *pdev)
+{
+	u32 l1ss_cap;
+
+	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CAP, &l1ss_cap);
+
+	if (!(l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
+		l1ss_cap = 0;
+
+	return l1ss_cap;
+}
+
 /* Calculate L1.2 PM substate timing parameters */
 static void aspm_calc_l12_info(struct pcie_link_state *link,
 				u32 parent_l1ss_cap, u32 child_l1ss_cap)
@@ -721,15 +733,8 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
 		return;
 
 	/* Setup L1 substate */
-	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CAP,
-			      &parent_l1ss_cap);
-	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CAP,
-			      &child_l1ss_cap);
-
-	if (!(parent_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
-		parent_l1ss_cap = 0;
-	if (!(child_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
-		child_l1ss_cap = 0;
+	parent_l1ss_cap = aspm_get_l1ss_cap(parent);
+	child_l1ss_cap = aspm_get_l1ss_cap(child);
 
 	/*
 	 * If we don't have LTR for the entire path from the Root Complex
-- 
2.45.2


