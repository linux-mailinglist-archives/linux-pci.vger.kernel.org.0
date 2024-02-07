Return-Path: <linux-pci+bounces-3198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA2984C992
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 12:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D32286D5A
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 11:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDEA17BB5;
	Wed,  7 Feb 2024 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="eLNvsA3A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D361AACC
	for <linux-pci@vger.kernel.org>; Wed,  7 Feb 2024 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707305146; cv=none; b=eGMyxZCBcxKxfVzw9p7kMJLNZWpmkdWC3UZh3Isfh+bJE2Fc2yjrVONS0JAuVGNG/e+GAi8Heg9CaYD54xzgI0AJ8CQIAYcaFVnXHrdi5Dw2unJA1f12X+eOt21MAr8gtplAVKUJ8CC2Y9qL2pRS1v4SfmV27w8rlxbXD9T9CGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707305146; c=relaxed/simple;
	bh=//WupjhxZ/daA1c3+E7b3f7GJj8YlnHRfnguy6tToSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KwlaTj09tUt7buGa1rRNunhYWA+jTbxZNBBbOIWbLx93WGKDxYrh+XatxIA+Fkuc7AwtEmlNQjDBf1HXUDGU3FP1K4acOHYe9pYyMO1Lbnv8xH4pzLzHomL+kbXcl+eU9qvxi432uj3EikjNzo5SzI2g48e7TPUVNkYlLQV/F08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=eLNvsA3A; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29026523507so378759a91.0
        for <linux-pci@vger.kernel.org>; Wed, 07 Feb 2024 03:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707305142; x=1707909942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eW2spjim+pJByd3Mxg/0ijFrCYtfv6oEIqERAXXxYdQ=;
        b=eLNvsA3Avb+46PvHWLNMLCkNShKwWj6n4PuYqqN0uiNDupKx/m3Fp2SfKpaTE7uvdq
         tUpx0gvPyDIUzvDD7Z054+UX//5tldp+XhnX75CZi+hQQFgNPpblbqN4+0BhCicFQYSq
         S1xFcQ30PLysq4L3gymxAObEsNbx9YEezYt+i7iG83ezCYRmykI6wJPQLDla2akLKY5w
         jzTsnNS8+J13m4aOqkVbM/OykzIi5GGBQJkJ1EuOz3qrcSH9ydFXCMN4RNwnxazdhT9L
         t9OjXsw5wIqB4lQiL+6YuK/SfK6HP9odCrztcyYj6gnKND8kvjAZJby2LtscHBiAvEdh
         y93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707305142; x=1707909942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eW2spjim+pJByd3Mxg/0ijFrCYtfv6oEIqERAXXxYdQ=;
        b=HMJknNCy/sc7U6yVxi9R6axaiy+jhxti8vQAIg0lj3XnMVFWQj02DRY8IVdXSlPKNs
         b5/5Su3Qn76NQiiXmZNAmOY+66lAjUL3J7zlBt7QREUA2RysxEor+aHCSDlJDlUVSo7b
         hUfUgybvyKByOrg7LImvEj/uhd0gaZAId8H8EbqtdEWCkCaFI/zkO3At/eOELyC0PeTn
         18XVAciAQB6wzWQaScKiUH2V4kJujMkHV46IjgOntwsY4ktERH758/LBzACBlYU2QAF4
         /mAOwSoBvM066BobfqW00QC7iQcJ6l9CoWVNxEPgYkPf2eJqueOP8M2M54xzuJfeEGTw
         nKjw==
X-Forwarded-Encrypted: i=1; AJvYcCUHFlRzHNHVaWl1OoeJq5wsgwXBpwrqw3cwRnonzz/b0G3javj3xnAUr9BXABTsmhjtJywBwBLhKPzW+fKcS0qmDSr8vDVMXdh9
X-Gm-Message-State: AOJu0YzyGo5M+8TqC0YH3P/AV0ERFDRENlaguVfT/lKHDTBXPp48TCyF
	w6+vdbHUF0ArzBYM61j/sy6LHYOHHoqAEPiDNAvrDTMxmqf9R6kz554AoXhCzR0=
X-Google-Smtp-Source: AGHT+IGfhBWi96Xsjmb84UU38Fpf2+ni1FJ2iaJ3cnv/Yalixy3TYd0oC6MObc6Eo/qdms50zPpG0Q==
X-Received: by 2002:a17:90a:bc81:b0:296:2f9b:8c2f with SMTP id x1-20020a17090abc8100b002962f9b8c2fmr2189952pjr.40.1707305142616;
        Wed, 07 Feb 2024 03:25:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVIisq+tGMyhVpZ9LDjBzRIZZcB5Q9SCQYewSSZMV2gFGKenIM3PXJNuD9TbM6qt8JIu0BzkyrMAbXxtG9VprJB7PrQWlfWSFyz69e7STaloVeJtsqc0z9I3XCzSPAU0lrye50BLmTpbrLyCun6MI8Y3giaL3P8zy9SXVT2/RUSyS7f6acELfmwf21i+MrVarMRIZg29iQv9f6YULANXvE1P5v4QWWEnmsyVrVdLGrTQzc1FkUvTmwTSf2t6Vy2Fqk5NM5ZyAaQU1pT+KEgBfj2EMoxFL8xE7oGMlbg0Z6ajFEP+G4krgTjglyuYMFN1DqTZNwKFFN418hK2MmlYP1ROGhAmb0uPu1f+X5+tX8X36klLgrVeWc=
Received: from starnight.endlessm-sf.com ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id st7-20020a17090b1fc700b00296c018f070sm1348428pjb.52.2024.02.07.03.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:25:42 -0800 (PST)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v3 3/3] PCI/ASPM: Fix L1SS parameters & only enable supported features when enable link state
Date: Wed,  7 Feb 2024 19:18:55 +0800
Message-ID: <20240207111854.576402-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original __pci_enable_link_state() configs the links directly without:
* Check the L1 substates features which are supported, or not
* Calculate & program related parameters for L1.2, such as T_POWER_ON,
  Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD

This leads some supported L1 PM substates of the link between VMD remapped
PCIe Root Port and NVMe get wrong configs when a caller tries to enabled
them.

Here is a failed example on ASUS B1400CEAE with enabled VMD:

Capabilities: [900 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
                  PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=0us LTR1.2_Threshold=0ns
        L1SubCtl2: T_PwrOn=10us

This patch initializes the link's L1 PM substates to get the supported
features and programs relating paramters, if some of them are going to be
enabled in __pci_enable_link_state(). Then, enables the L1 PM substates if
the caller intends to enable them and they are supported.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
v2:
- Prepare the PCIe LTR parameters before enable L1 Substates

v3:
- Only enable supported features for the L1 Substates part

 drivers/pci/pcie/aspm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a39d2ee744cb..c866971cae70 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1389,14 +1389,16 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 		link->aspm_default |= ASPM_STATE_L0S;
 	if (state & PCIE_LINK_STATE_L1)
 		link->aspm_default |= ASPM_STATE_L1;
-	/* L1 PM substates require L1 */
-	if (state & PCIE_LINK_STATE_L1_1)
+	if (state & ASPM_STATE_L1_2_MASK)
+		aspm_l1ss_init(link);
+	/* L1 PM substates require L1 and should be in supported list */
+	if (state & link->aspm_support & PCIE_LINK_STATE_L1_1)
 		link->aspm_default |= ASPM_STATE_L1_1 | ASPM_STATE_L1;
-	if (state & PCIE_LINK_STATE_L1_2)
+	if (state & link->aspm_support & PCIE_LINK_STATE_L1_2)
 		link->aspm_default |= ASPM_STATE_L1_2 | ASPM_STATE_L1;
-	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
+	if (state & link->aspm_support & PCIE_LINK_STATE_L1_1_PCIPM)
 		link->aspm_default |= ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1;
-	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
+	if (state & link->aspm_support & PCIE_LINK_STATE_L1_2_PCIPM)
 		link->aspm_default |= ASPM_STATE_L1_2_PCIPM | ASPM_STATE_L1;
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
-- 
2.43.0


