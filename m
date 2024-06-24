Return-Path: <linux-pci+bounces-9174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F12B914495
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 10:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B721F23747
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 08:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC6E4AED4;
	Mon, 24 Jun 2024 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="fxYpPcUZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4745007
	for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2024 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217371; cv=none; b=ml8Tt6SR57uv9hWIdmxQqIq3qm2WTPNwru3cx7rEFc4XTTGoi2SaTZUF7g0Do9QrIVHj+y1oZarIKIRWIyl3ZfUvNuEwwB0QJ3bvyXhz8/K1cvn4klqQqcVWCA+yTkHOXAgoAwV2hcnGymMOFK/zJiIF36Hw8FjTcralNX8p2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217371; c=relaxed/simple;
	bh=l8PxRcYIUV+BwhTr/9tnWDMOzSzkqoN1MtjHSsnguGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtXTTehJq/u21iod7e51T4qj+qvdjVqvBWDy9dTchRteEeqm33IbCi8TgUq2aLa01tJejZVmQIcC3jE1aOsi5on/A6oyBmjvbw5C7Z0QZbXNaY/HYj5ehRWgXXm7oFr63aR+vrLug0/Nxltmlf7zF3O367dycT+4R813FhK1c48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=fxYpPcUZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f64ecb1766so29955455ad.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2024 01:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1719217369; x=1719822169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKqXgp0PeCY7zVPXIYmvQu6WZY+HEs+Sn2Z47Kgx7oM=;
        b=fxYpPcUZsuE9aiH3471SZiJQzzMoSlqLkowXosNEkyMWVlKz/QwPk+rVLeFOaDBOWt
         N4PQkstLuhKl02eVi0yv9ZAkq/dSRCWjcVznar6vEWRu5Qg29be95rINkTgoKhlz7aqw
         Xjp7AmCl41xYlm+SDDqkZzzxJVXbvURJs6mw/YJnjiBcat0Ut8xOyfmTdC70EkchrZG7
         V7eojFfhBN7KsMGLKEmlQUt9dvYfj5QiHHzFvvGfsYQbtPbd/6lVGpyMLBtripypYIf+
         ZJEs0UGYOl/fj+BwPZu3u5Yq1mugqVsgo8R9R2ZZPajgCrfFmjxg9Mxsn74g7BjK7r+l
         r4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719217369; x=1719822169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKqXgp0PeCY7zVPXIYmvQu6WZY+HEs+Sn2Z47Kgx7oM=;
        b=Ac/fD+Z6Czu37PnYLmhy/z1htxG4AWgMpkPqxawC38nxBXS5v6mKiBf/qtqjIDdtCY
         FMa49dVir4VgS1Y7GZ/73wv+ZtyBw19t96i+IEM0v6TnNSAskPeOXzNZS3e/7ip/+LPI
         GbpeaAWb9YTBo+iQvUJ3Pi56b2T5xpsIHUMFZTjvaDHUjxC/ier7jGks5B+0qv51WJmu
         OOWs0jio5de3dziG1Cch1KY4VfnJ9ZzzHLWyhZptnPvjr67iAKjsExCDXz+Ce4FeuS+1
         eeotnqUPnqcFwCEM9cqAcNBdHh7TsIRMml9Ab45Jjoc1QdjJ0VmgxQJi77v4L6cCsKOQ
         y3Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWdjKkTpgBXbW2/S9/00reYch4v1qhwxrqhxJ+xo4Fbv0v5UVkXup3JWkXPwomXl0GR1DKsJCs80pXKY4EjoajKwPpkP33buzYl
X-Gm-Message-State: AOJu0YxmzbknvgE1DXaVNh3rF35mRiI+/krTp/RpAbFkKuU2JRzhiNQC
	UcTbRy2LO3p9BRrsDd+Bqu9CgdCklvNOpN6Gqb/lp8kYFRo3NQ54jAPWXyF77Tyd4gK+XXfWesf
	u
X-Google-Smtp-Source: AGHT+IGkoHJq/Uha60iVDfgi2zLJGjHRCAI0OByy2xj9MuNZhuILpLYTi5YuR8zGMv4NTd34FPkw1Q==
X-Received: by 2002:a17:902:ec91:b0:1f7:1b97:e91f with SMTP id d9443c01a7336-1fa1d5173d9mr51886265ad.26.1719217369112;
        Mon, 24 Jun 2024 01:22:49 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9eb3c8b5dsm57068405ad.181.2024.06.24.01.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:22:48 -0700 (PDT)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
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
Subject: [PATCH v6 3/3] PCI: vmd: Drop resetting PCI bus action after scan mapped PCI child bus
Date: Mon, 24 Jun 2024 16:21:45 +0800
Message-ID: <20240624082144.10265-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624081108.10143-2-jhp@endlessos.org>
References: <20240624081108.10143-2-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on the PCIe
Root Port and the child device, they should be programmed with the same
LTR1.2_Threshold value. However, they have different values on VMD mapped
PCI child bus. For example, Asus B1400CEAE's VMD mapped PCI bridge and NVMe
SSD controller have different LTR1.2_Threshold values:

10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor PCIe Controller (rev 01) (prog-if 00 [Normal decode])
    ...
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
        	  PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
        	   T_CommonMode=45us LTR1.2_Threshold=101376ns
        L1SubCtl2: T_PwrOn=50us

10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express])
    ...
    Capabilities: [900 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
                  PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=0us LTR1.2_Threshold=0ns
        L1SubCtl2: T_PwrOn=10us

After debug in detail, both of the VMD mapped PCI bridge and the NVMe SSD
controller have been configured properly with the same LTR1.2_Threshold
value. But, become misconfigured after reset the VMD mapped PCI bus which
is introduced from commit 0a584655ef89 ("PCI: vmd: Fix secondary bus reset
for Intel bridges") and commit 6aab5622296b ("PCI: vmd: Clean up domain
before enumeration"). So, drop the resetting PCI bus action after scan VMD
mapped PCI child bus.

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
v6:
- Introduced based on the discussion https://lore.kernel.org/linux-pci/CAPpJ_efYWWxGBopbSQHB=Y2+1RrXFR2XWeqEhGTgdiw3XX0Jmw@mail.gmail.com/ 

 drivers/pci/controller/vmd.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 5309afbe31f9..af413cdb4f4e 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -793,7 +793,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
 	struct pci_bus *child;
-	struct pci_dev *dev;
 	int ret;
 
 	/*
@@ -935,25 +934,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	pci_scan_child_bus(vmd->bus);
 	vmd_domain_reset(vmd);
 
-	/* When Intel VMD is enabled, the OS does not discover the Root Ports
-	 * owned by Intel VMD within the MMCFG space. pci_reset_bus() applies
-	 * a reset to the parent of the PCI device supplied as argument. This
-	 * is why we pass a child device, so the reset can be triggered at
-	 * the Intel bridge level and propagated to all the children in the
-	 * hierarchy.
-	 */
-	list_for_each_entry(child, &vmd->bus->children, node) {
-		if (!list_empty(&child->devices)) {
-			dev = list_first_entry(&child->devices,
-					       struct pci_dev, bus_list);
-			ret = pci_reset_bus(dev);
-			if (ret)
-				pci_warn(dev, "can't reset device: %d\n", ret);
-
-			break;
-		}
-	}
-
 	pci_assign_unassigned_bus_resources(vmd->bus);
 
 	pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);
-- 
2.45.2


