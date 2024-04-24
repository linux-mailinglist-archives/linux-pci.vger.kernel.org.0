Return-Path: <linux-pci+bounces-6620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B78D8B07F2
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 13:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CB4283650
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 11:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6035915990D;
	Wed, 24 Apr 2024 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="Qjry9X9S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18A41598FF
	for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956528; cv=none; b=YOnnMgeeQCWIE4Wenc3ciaXH5ouwZphhMGyTKbcZ1Z62HgCYowIrBFXap59R3EEZxVZH9DCuuaYwb4hTdE9j7fNKxuQd0SbGXKPyaTqE2ovIw6pHBLUk0CuPz2xibDo6pqYSUBPXZxknbA1PCJubaE6/e2Ggr34c6/LJPLcwz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956528; c=relaxed/simple;
	bh=2jKIjdLV7lftx+xiDBEvy7i/MFRg4Wb2datzsreIZFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZiPgctZjmMJxY/3DUGc0/CBSWLcGwSpdP74JNW669ZeKjk14PVeV/3zxXCekAXkBO3aFWLEzqnOK1/EtUUHzyGA5tfwid2MeM8FBtW3WvCW49XeZrC/jbhZSYUoN9qfotjZW+Gv6qbgu8ujB+bEQclSomXgxM2WhCp5KDFlao2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=Qjry9X9S; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5c66b093b86so623176a12.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 04:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1713956526; x=1714561326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UVuD14qd2v2GJpWMUKxJKGrbwwgi+TYXxSr/usBLCtM=;
        b=Qjry9X9S+WvNwQfxxgJ5jAjOYuWuZCXuTBgz8HFxuZzfFyOfoOB8QKY9AruVXXCIbc
         gdPonmkV7sO9AvDKKqza/JapMF6nrPnq2sf4y5zM4A9UDdHQXdpd9Jbl9tcE6wnhxV2Y
         lWWQfaNjZYdh3YNQqTpL2p2xW3oNVgN7QfBiz5NZFOONqTS3wYD4KSqob3ZhyFg7XdtG
         zBxtNbekjskRwFXRhPz0Rmh7/gwbPVJpnJNk1lrTnvIIg7gAucDeQUEbETViEi9EYnfK
         +vGB3coC4QqfY5uvUtWImGQgo+3Km/aGFmWL6/wNAo73CmQvBvfmVTpYDKaWsID2jeVq
         jVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713956526; x=1714561326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVuD14qd2v2GJpWMUKxJKGrbwwgi+TYXxSr/usBLCtM=;
        b=LMUX0ZFhqGy/AdG/UeVxKCMqwzvIy7rG79lRh3QXb5Fm14D0qYQm8pAHBsGzcvN0IR
         0nEM/eafDiOSmn+r0C5Rl5FEyWDwfFrm9O5h3mXxjQ1Rq5hATy+FrkAebBkef2NcrdIU
         AGWxV3GoawFyXjV75HvZGbaiv+GsaDnyhYsJ1vXwnh1rSa5d9TWqGL+kn/h1ydT/3KEm
         4pCnrTwlchrrq4f//+VmSMSRg1irFF2p5xEO/UynTq2WeZGhymbvGT5d1mSnTjRV+R7i
         yNn9PYg3xLKWUyns7364M5HAr11Ue9s9rdiL3nDg7QzCdx1RwoIO4EAgaPzEjRHju1AA
         vsyg==
X-Forwarded-Encrypted: i=1; AJvYcCWXQS21eM7G1QNlWwGsDYL9GBzi9KF/Qov3ac6RhCSs6eijL897HrCMOt2tOD+m6q8xnQZL6CAQmcAUtBC0MAKK6f0paO/O1jKV
X-Gm-Message-State: AOJu0YwBlSC4pg9gKYpd7qCu64RIfzDDfxmLYhFTPeCZ+4VXd/Mux5A1
	C73TdB4hu0BNzrZGnNpYSda0krwmmkwCRFci+OFlSbCaYt0NP3nQeaJaNkGWk0I=
X-Google-Smtp-Source: AGHT+IHGwVsOxC3KDLv+3r/1YnzNplxHumhenciI16CLN8PKLRoRBfKLbi53rsWsJbT33eWrnNUl+Q==
X-Received: by 2002:a17:90a:5513:b0:2a5:be1a:6831 with SMTP id b19-20020a17090a551300b002a5be1a6831mr7456226pji.19.1713956526095;
        Wed, 24 Apr 2024 04:02:06 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id x5-20020a17090a388500b002a53b33afa3sm13990338pjb.8.2024.04.24.04.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:02:05 -0700 (PDT)
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
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v5 3/4] PCI/ASPM: Introduce aspm_get_l1ss_cap()
Date: Wed, 24 Apr 2024 19:00:48 +0800
Message-ID: <20240424110047.21766-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.44.0
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
---
 drivers/pci/pcie/aspm.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 91a8b35b1ae2..c55ac11faa73 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -612,6 +612,18 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
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
@@ -722,15 +734,8 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
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
2.44.0


