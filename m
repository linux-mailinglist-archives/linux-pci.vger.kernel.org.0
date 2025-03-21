Return-Path: <linux-pci+bounces-24290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DB4A6B2C3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 02:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541471890DDC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 01:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFC01DFD86;
	Fri, 21 Mar 2025 01:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFZeufen"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6AF9461
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 01:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742522303; cv=none; b=TwhsGgGF/fNEGq7DwbKya9HNAebvujyio4KfnJk4Ey/3NiOclpCh33goNwW3hfLg/pWRZta0lG7J5Ccp16BLk9xKk3tdyYvd97LUGs7hLGZ/XAavSTA4l0DcWhjxXsG884yKhhvXrDlkydJQ/Z9p7jxn6PFUfIm2Dj83USl08jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742522303; c=relaxed/simple;
	bh=KZOcOyizsUrn78Tt3nRHBxYUDqgCvXlp2As7lgDjcgQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=InMk3rDTNT88OhpMd3kTakU9plQzC4eVcC9VIANZ4VLxrTkV3WJlUXbdoGwZEEJR78Xhasg2lzg5wo/ituUKg9Mt+wUok+lzbSLiVoT0hXiOdnZCV+068OxrrfLEjIs3VMQ4KR3GruMRELneD5EQ583QOVzDRB/rJ5BArKybt18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFZeufen; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff8a2c7912so2318533a91.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 18:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742522300; x=1743127100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGqOhVbhYbRp09iQ8MkomGhZ6WYASwULI1k3fzWO1To=;
        b=EFZeufenmYGQ4Xh1B6qffl7x/QNj3moWjQ+BdJ+R652mO2aH+gdYMhqfSP5POM52yB
         b384toBNBtiWij6PzfEBXSJX9GCcI6UVu1PjB53zVPEUdbPy2jOK+RedCEel91QLMTE2
         PNWOdeqmz47aBgNEKD9IjbRvDasjxS777q62qDGgkAlScV+NYiHo73wy/z8PXqcD8ZHx
         rGsBMYD3CwR8Ync9AmeTz5X8KwiB/SPMScSQqs/i8DMijdOFnXkHJiYMNPi6hlsOrfUL
         oygsFBjGR0I8ZxCySw0GYy+FnicQenoSWoogAONPR6VGJvg1EbW3kxiZ+S6WfyKuYuzI
         dujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742522300; x=1743127100;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GGqOhVbhYbRp09iQ8MkomGhZ6WYASwULI1k3fzWO1To=;
        b=lzLWxJvyZ5mE4Ui5Bcog1hgEhbcPiaFDHYZQgoyNYmuxFKy+AX2atasttB28/oNJ7j
         eVpO+fdtfiK5+ngi4lz+bkFXI0ND2PDenSJB48Udaz/1HGSGLmO9KEOVR/78phpkHWVF
         LZyt+c2QF7/XewiApke8JCwZcNYB2ljNurJB/HmkSILUmUY0XOpfEtjRmO6BghG28rTo
         XMkeS8oXEJEoQin7iTHWfs9eMqo8kMYHTuzfk0w6RacJFt0t4y5mPSRHcYAkArOiyK06
         X/r3fIPTnCOXhlHcLg2olUHKS9W78VsqsXSTgQA+NCsN/iK+HFm2VB+cBJfDSNUrfyo3
         sgsw==
X-Gm-Message-State: AOJu0YwfuQW4tyodKar4ExMdaAra9eQ2npsJcMYXvbPnDvRbY3Urybi0
	rYUH0P37CDyV1ncAWmPL/ZnQJJmZBngE+CdMGRTSiRTU/1SoDADkEMVn6wT63bEnFkUQaaASN7D
	JaQ==
X-Google-Smtp-Source: AGHT+IEGk4/ag7wItbxC5hY9A3Qv+9sMPGiy2A1c6kctOI6EBzYxep0n89spcU0PrQWe+aGsDAgI97wgwts=
X-Received: from pjur6.prod.google.com ([2002:a17:90a:d406:b0:2ee:4a90:3d06])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38d0:b0:2fa:30e9:2051
 with SMTP id 98e67ed59e1d1-301d42b3a2dmr8394844a91.5.1742522300062; Thu, 20
 Mar 2025 18:58:20 -0700 (PDT)
Date: Thu, 20 Mar 2025 18:58:00 -0700
In-Reply-To: <20250321015806.954866-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321015806.954866-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321015806.954866-3-pandoh@google.com>
Subject: [PATCH v5 2/8] PCI/AER: Make all pci_print_aer() log levels depend on
 error type
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sargun Dhillon <sargun@meta.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Karolina Stolarek <karolina.stolarek@oracle.com>

Some existing logs in pci_print_aer() log with error severity
by default. Convert them to depend on error type (consistent
with rest of AER logging).

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Reported-by: Sargun Dhillon <sargun@meta.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.i=
ntel.com>
---
 drivers/pci/pcie/aer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 45629e1ea058..3116b4678081 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -784,14 +784,14 @@ void pci_print_aer(struct pci_dev *dev, int aer_sever=
ity,
 	info.mask =3D mask;
 	info.first_error =3D PCI_ERR_CAP_FEP(aer->cap_control);
=20
-	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
+	aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, =
mask);
 	__aer_print_error(dev, &info, level);
-	pci_err(dev, "aer_layer=3D%s, aer_agent=3D%s\n",
-		aer_error_layer[layer], aer_agent_string[agent]);
+	aer_printk(level, dev, "aer_layer=3D%s, aer_agent=3D%s\n",
+		   aer_error_layer[layer], aer_agent_string[agent]);
=20
 	if (aer_severity !=3D AER_CORRECTABLE)
-		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
-			aer->uncor_severity);
+		aer_printk(level, dev, "aer_uncor_severity: 0x%08x\n",
+			   aer->uncor_severity);
=20
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
--=20
2.49.0.395.g12beb8f557-goog


