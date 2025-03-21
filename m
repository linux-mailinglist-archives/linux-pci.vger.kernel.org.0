Return-Path: <linux-pci+bounces-24292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63A5A6B2C7
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 02:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B1017B1B0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 01:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8791E1A31;
	Fri, 21 Mar 2025 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AmExqWzF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF99461
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 01:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742522309; cv=none; b=ZYZtP7psXJHo2C+De0KAfK87h8ltaBhixt8/x5t8fibAf80qGe8oGXpQLhtc82sniCAUJA9TMCJq6En4dd17mz2JZRCqiD0EmnBWBfeuN1d+U6HsKkPlnUMszrJcE+ShT7rhPnYDeOPAc52TMHUQxVvdaZ539tDZd7+cNNwhkUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742522309; c=relaxed/simple;
	bh=n4iud0iTs3ti+9DTUS/fzRYy+lrK7xEU8OitWgZBH/M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L+wg1YDtW6n5C8Fe1Q1j6QmBE7yVSdrqbMVizaCrCUE8xJUbE/v743mcwd+BPuMwibXRJAeRkvNi+CeGAoc3EJIfOL+5TSMeoQKsG8J9HvFKCqwiE1FksvPLQS5iTTELHC/UgEnT/fyd76DWw92P+TqVCpRxXv2hKHMc/QtcXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AmExqWzF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so2246945a91.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 18:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742522306; x=1743127106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R8hwWNQ07sLMLFvkrCgP33Nv+kRi/W1sjysWfPlbkf0=;
        b=AmExqWzF4fGHJoMml0r66BDD0f6+zGdVhbf2FB1y5QgUtv/KpjEx/Ddf505Vrw1lZ2
         RV+RstdLPYFb+LXYBcY5SS+raaz2+ixhhpOP71QI7ab+QGfRGYgkjlTyICfRBUjh4dV0
         dm6gd6xP30yMNozI2SbPBcLR4k/A6Mhs/5ljVBPY70QlQN94CG+IFqlL8cXEN3UnwEgT
         /2OAKyeFWA9Ph71EzahjP7C7jm66HNNRNPFRp9CD/ad2HsTJyhEGnKWu5mxwWXe3Liry
         3DzNCWv3a4bOMrYWGhkj3lFXJwCP7Ki4fzoGzBRSnf2zBOlTKkPOBnfjBcpvrCuvQyfL
         uXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742522306; x=1743127106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8hwWNQ07sLMLFvkrCgP33Nv+kRi/W1sjysWfPlbkf0=;
        b=SiaJsvVSwCbEsskNeO4LjwT6M5FGbYInNYHySBPn3+n7oJLbAkpFgbTjjLolVMhyhw
         UHl3fDX3y6iI2AyW0BQCK3W9XKNM+5BsLB8BTVY/rW35bYiekScBRj06YKQgW2xNWRMk
         0rs7BnJIxSsapx6EZW68H66r7sDQGhZAUw1x91hJD2irULbUQZ0YXp1y1J8O3tYBF/G/
         NsD+ihPaadJi80cfnr6Gf3HD6iPTCFCyAHLI/hF0XMJmsZ4FmBVCvGj+I1mHuxJjD2Q0
         9asurxtEBR66CGWRXmTRT8ncneXwH3wAinIDYDXGkLd86XZovii8eG0OSwxWFgbZm9hj
         Ldcw==
X-Gm-Message-State: AOJu0YzjqYJ+8qpQUsnfoRi9+DwtgIredQCmtHiVjmMSj8xoTE5HbFgN
	ZXLM8VGznQLKcbmGCV3UkzFTkLePxUL4ApcKRFUzgIs7nxwPSZWDujYoeHyr/QVfH0oNDPaMI3u
	0dw==
X-Google-Smtp-Source: AGHT+IFV4Qnu7njkqEmJkPc551/MF4B61d9nnZf8CNgqRm3ak75Uqd98BpHSuS21FUWXsEk4xWjupK8Y3EU=
X-Received: from pjl4.prod.google.com ([2002:a17:90b:2f84:b0:2fc:2f33:e07d])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2641:b0:2ff:7331:18bc
 with SMTP id 98e67ed59e1d1-3030ff10899mr2036372a91.26.1742522305896; Thu, 20
 Mar 2025 18:58:25 -0700 (PDT)
Date: Thu, 20 Mar 2025 18:58:02 -0700
In-Reply-To: <20250321015806.954866-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321015806.954866-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321015806.954866-5-pandoh@google.com>
Subject: [PATCH v5 4/8] PCI/AER: Rename aer_print_port_info() to aer_printrp_info()
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

Update function/param names to be more descriptive. This is a
preparatory patch for when source devices are iterated through
to institue rate limits.

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Reported-by: Sargun Dhillon <sargun@meta.com>
---
 drivers/pci/pcie/aer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e5db1fdd8421..3c63a6963608 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -727,15 +727,15 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
-static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
+static void aer_print_rp_info(struct pci_dev *rp, struct aer_err_info *info)
 {
 	u8 bus = info->id >> 8;
 	u8 devfn = info->id & 0xff;
 
-	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
+	pci_info(rp, "%s%s error message received from %04x:%02x:%02x.%d\n",
 		 info->multi_error_valid ? "Multiple " : "",
 		 aer_error_severity_string[info->severity],
-		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
+		 pci_domain_nr(rp->bus), bus, PCI_SLOT(devfn),
 		 PCI_FUNC(devfn));
 }
 
@@ -1299,7 +1299,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 			e_info.multi_error_valid = 1;
 		else
 			e_info.multi_error_valid = 0;
-		aer_print_port_info(pdev, &e_info);
+		aer_print_rp_info(pdev, &e_info);
 
 		if (find_source_device(pdev, &e_info))
 			aer_process_err_devices(&e_info, KERN_WARNING);
@@ -1318,7 +1318,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 		else
 			e_info.multi_error_valid = 0;
 
-		aer_print_port_info(pdev, &e_info);
+		aer_print_rp_info(pdev, &e_info);
 
 		if (find_source_device(pdev, &e_info))
 			aer_process_err_devices(&e_info, KERN_ERR);
-- 
2.49.0.395.g12beb8f557-goog


