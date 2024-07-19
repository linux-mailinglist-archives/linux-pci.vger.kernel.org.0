Return-Path: <linux-pci+bounces-10543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8478A9374A1
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 10:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBED2807BC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 08:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFDB3D0C5;
	Fri, 19 Jul 2024 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="fe5nq4Qm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487D269D31
	for <linux-pci@vger.kernel.org>; Fri, 19 Jul 2024 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376057; cv=none; b=txhs2PcyPexnmFB2kiWGYu62KSCFCHVlObSqPPUlPQKiGHxMPgqonQ+f9+czTqZ6y0HBYeBnEzMIXrIMHPuVmenZH5Qjak1BgJjAk523vWYT/aRZwkE3iT/Md7w4WdS9y/18P5rAPpU20iguXgzi00zmKCcCwJJP97Hc/kzMGC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376057; c=relaxed/simple;
	bh=w1k5K+jcQ9Q/ykVMsX/qJoDslBERO24AtB8r7OJuygc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ym+H/ujxinh0w6NGPWNcW+Ye0xNARQGlknHxQ8HpNOBBpmy0WeSlgfSXf+H1B9PE+HwdGM+Qu6FR51ig8obyQYyyDiwmgyNYQwzwHFmBCQF/830o3RIp2P/Zij2MJfdRStvuHOWqvCol5758FPjyl3k6QRnvAa/jCXHptA2o0ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=fe5nq4Qm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fbc09ef46aso15093225ad.3
        for <linux-pci@vger.kernel.org>; Fri, 19 Jul 2024 01:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1721376055; x=1721980855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLDFsfKJCWA+fTu6bBjMm9nM8Y4NH8EbtQ02Y3aYHlI=;
        b=fe5nq4Qm99qD+jby4LK8KDExHNsBpPpG6SVBr5xt7oYJvN7b2YDnl2iylaV7XaWZQX
         NRMg+3flMjD45Rk7sb63dBFS8i4fTeUAoVyodeqqrPU3LeVIoDgDQsODUAD88bcXVWQd
         M/B4DAV27zrILp8XjwhZ5h/DBPrKsi+j8VSf1VwRE9Wpsv1xDv3CGFDVqJORHtPMPZ0c
         G9GkzP1kuWY2HkWzoBoHN1YuFeQOr0phdIU17U4hHaCkae2RIdhtXOV8+PdesuGs/ymX
         7h4koL6ilMVZ4D+aEUrFjKC770s7+dNuDXSVGqBhgvbCcFsijm4M9HRTX7y/v8R4IPx2
         JTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721376055; x=1721980855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLDFsfKJCWA+fTu6bBjMm9nM8Y4NH8EbtQ02Y3aYHlI=;
        b=Sel/PbhF6dnm+2SVPqpRKfmudkiOPDHvhWqdP6DYszbd+jXn4tJ7kUjp7NMZ+IWMf4
         Hx3Zw2CfQYYI6VArqlpd/xfOhKZsmDwPpoJzLWgXeHla6vK9GihPks3uWFlCFn8Ge+oB
         kmGkJveQ+hWNw4TCDxvQVlO0ALSiBVT79vMRaf/dng/YZYBFY9OirXFDhmr6SGzBaaaW
         /d9G+VT0SxhbkjURpHv/HI856UzCuPoaX/f5/aF8hrq+RzLlkoFDoy28mYZtWuYJp2NM
         R+2eWHkgxH1Ro0ZUbHDPmbriJaxn5agv0GvT5x+gzJ0vnAudv7P7gGiLsDM0zqQktpYG
         pXww==
X-Forwarded-Encrypted: i=1; AJvYcCUcyLK6SFpd7MS4AtyCo/f5SNdh6vUH3/z+Nor7gly7up8SCdOaF2yu8pmRwcgxmsjJWLLvoAtymdNnWVWYlrBBkFbGwrMuotKD
X-Gm-Message-State: AOJu0YxNBUoCDPk7gCs+k0nviR+HgIv/oM3wNQ3sumotgAAVIjM/AImZ
	p+wrNb6grb3FWWe43JdU34fKWuWJa8FPm2yy33nNQYAU4yHH9bXCOJTyTZjZOt8=
X-Google-Smtp-Source: AGHT+IHWV9JAlT/QGF5Yig86nrNCGmsxqCwu1UVWib6rPn8P85SqUNSnDoKPxgrwWBLSh0X3fR1cSg==
X-Received: by 2002:a17:902:c40b:b0:1fb:72b4:8775 with SMTP id d9443c01a7336-1fc4e56b617mr53354115ad.40.1721376055315;
        Fri, 19 Jul 2024 01:00:55 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd64d07ad9sm8178055ad.177.2024.07.19.01.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 01:00:54 -0700 (PDT)
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
Subject: [PATCH v8 3/4] PCI/ASPM: Introduce aspm_get_l1ss_cap()
Date: Fri, 19 Jul 2024 15:59:35 +0800
Message-ID: <20240719075934.10950-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240719075200.10717-2-jhp@endlessos.org>
References: <20240719075200.10717-2-jhp@endlessos.org>
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

v8:
- The same

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


