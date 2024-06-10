Return-Path: <linux-pci+bounces-8527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4C6901E65
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 11:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF6F1C21037
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 09:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D064770FA;
	Mon, 10 Jun 2024 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DxD5TyLn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28157440B
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718012028; cv=none; b=Mc8CcyKH2LF8RL0OtvvG3wzv5tUS9576gRQePNvl7PftkKOqLQyLRs98JH97TlmJ8IFMMIIdgHxcTOELI6ts4pyOJUf+nZ71lRIJrbJ8p8LfgY5n0Mdhi90m/wZ88Lok7cZAtx2/7yrnZU7w5nR8lnWEkYORJYuasQwA6Z+/O5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718012028; c=relaxed/simple;
	bh=tLOcVSiD6Eqw6Yy+f53eqMdy4+lsxuB3aeWvrhbUWPM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sjVrSKS0YlSPMAzPAL2YGrgk1auSaTp26v1xH4mvIbG/EN0Bo+EiinFw1RyRdVxs0s8Ih7P15qvycXisiVKrX0+vhn0imveJR/tx804fNpyRJciaobmub9TIbVzSiJP/u/ir+ZlWm6hVGn0sDEgJiYW/aKvuTX5FroYuV/ZPc1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DxD5TyLn; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5295eb47b48so4857121e87.1
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 02:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718012023; x=1718616823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pzVEamgsK8pIhsebOuX84FJsT0b+I1ivveKg0N5OLWc=;
        b=DxD5TyLnUt2vJ5eV6h8gmlNIM5sfKsNMxoZxcrFkXMM+IfaORIQCFuAgNCq9/XIsIX
         /lUn2W+QfQddSG7CeKqJiKdp0uKZm7Hs/Ym7AyuKC6glA4riQ86KUA3AKP35NGCrRWW9
         y+Oi1CbUGU+J/iHI7iVQ3PnwvRRjFVbKPWaER32KwxfApqigTaFEOIXWim1/URWk/SJR
         thiE6UObycwYrvGtt5gYlOUgVDlnP89S7+88D81FJ1Q/ty+dpfXui8OPK1IkBJpJwMn/
         8hb6ap0Nq8wFKgEGZwC3BZbwPKvinfDSyCpWFw0e6Qj9+xWJk5DnAA1tc9FnzhCsyGL6
         3yLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718012023; x=1718616823;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzVEamgsK8pIhsebOuX84FJsT0b+I1ivveKg0N5OLWc=;
        b=AdleGni08o4v8Snl5ROB/gf+ttVohSx4aTm33oc+/nSsR8t2UUnhWQOudr6WTNbfA3
         Lsccl5ACvm7fRRPpvl+Nvu9LnZrdn8wCu9q3Prvo2leA/UCt4QRys68BamEBNN2kHUMT
         NRFSypThEiHtlcCcO07gjkbgbkQ90L3504DTBL8Ai9ZVRSfjiiljEGESSkVt2nQgc9Yh
         AkgDpS4mLkZxyUmXOAERE3hTkTLXaWWxcSyifmGLNy8PJqNX7io/8BxnKKpofabofDiV
         rWj6dKb5pp5xjQx6oZdUlAVcaZykI+9f2T5uov1Ayk2tZwyh2L1TE+hnO4JJ4BOIT70Z
         lSNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD0EeLgb8knPtZswI3+IKC8jST64z0qYBqJtuKUOu+lVXMDCKNHEWcYiBOKLUR/VYX9OD15HRRZOsyvtnv7Zh5Ty06DGI4Ek1O
X-Gm-Message-State: AOJu0YzAH57xh/Cl1Msf5foxBE1GdZbvk4EmmsnZZYXaLIf+7aCWgQxu
	8ArNwC74ft9o0kkhc0e/xyp4GOZcurHSdb7Cz5KSBDmfQjfenx8dn+nG0RXnAE0=
X-Google-Smtp-Source: AGHT+IEjZLgV6Wy1oAxIIdW1ddfOocWe7sK0ReqlNbZA+bPWxFoLzpJukeMXV37eZ5OiEJagfcMF0A==
X-Received: by 2002:a05:6512:61b:b0:52c:7fc3:601 with SMTP id 2adb3069b0e04-52c7fc306f4mr2851793e87.61.1718012023012;
        Mon, 10 Jun 2024 02:33:43 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0d512556sm7087985f8f.29.2024.06.10.02.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:33:42 -0700 (PDT)
Date: Mon, 10 Jun 2024 12:33:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] PCI: endpoint: Clean up error handling in vpci_scan_bus()
Message-ID: <68e0f6a4-fd57-45d0-945b-0876f2c8cb86@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eacdf8e-bb07-4e01-8726-c53a9a508945@moroto.mountain>
X-Mailer: git-send-email haha only kidding

Smatch complains about inconsistent NULL checking in vpci_scan_bus():

    drivers/pci/endpoint/functions/pci-epf-vntb.c:1024 vpci_scan_bus()
    error: we previously assumed 'vpci_bus' could be null (see line 1021)

Instead of printing an error message and then crashing we should return
an error code and clean up.  Also the NULL check is reversed so it
prints an error for success instead of failure.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 8e779eecd62d..7f05a44e9a9f 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1018,8 +1018,10 @@ static int vpci_scan_bus(void *sysdata)
 	struct epf_ntb *ndev = sysdata;
 
 	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
-	if (vpci_bus)
-		pr_err("create pci bus\n");
+	if (!vpci_bus) {
+		pr_err("create pci bus failed\n");
+		return -EINVAL;
+	}
 
 	pci_bus_add_devices(vpci_bus);
 
@@ -1338,10 +1340,14 @@ static int epf_ntb_bind(struct pci_epf *epf)
 		goto err_bar_alloc;
 	}
 
-	vpci_scan_bus(ntb);
+	ret = vpci_scan_bus(ntb);
+	if (ret)
+		goto err_unregister;
 
 	return 0;
 
+err_unregister:
+	pci_unregister_driver(&vntb_pci_driver);
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
 
-- 
2.43.0


