Return-Path: <linux-pci+bounces-21411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54387A354C4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 03:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1083AD589
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 02:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68A47E0E8;
	Fri, 14 Feb 2025 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z1nFhGrw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159B136326
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 02:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739500552; cv=none; b=XP36k9YjAclMeqzCzB8gv98h/IrLMeOQKKz8IjIIq0ijKXNhLF+63AltSuvupWe4Bsb1ne10tkwUf6a6wxnPE4yDJweIYUqKrlNVl5Zk1tEuw2CspI6tKsMV1mc17r5l2tktlqSNLfjR1XkZPylvvGFNyF2O6jxp+6ciJTJP1h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739500552; c=relaxed/simple;
	bh=MxrsUIMwpSF3a45K0ErscHgs+LNbTlmNP28Z4qAvIJM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PRX9xyBkpOWeaT/FliqJwqso0sh/s8Hic7jQgPggVOXJtJ8/seitO+U88ugJ+rXmErpyI9D4cXylGKexA6vYqeOc9wk5D9t4zXWyzj8GcSCoGSQHS6s1AmQO2Re7p0Hm4YnKD6x5iRGa80hJWnvCgACYc6VoUg/9gx0XZDfFgB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z1nFhGrw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220e04e67e2so40048725ad.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 18:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739500550; x=1740105350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VtI+Vb8g7MbKlHF8GNGco7nXiQ3egRGy3mLNKXIfjFI=;
        b=z1nFhGrwD/cTr9YV3DEKzz9HwOHOvXxZiy9+nipSB3FbG5xmVtBCCzj6mFT63gtn3d
         ycvPGEcPMlZoanJnqiiFI0xSVP0R2ymdkQZRi7SYIH3MXwTAxubq2b3oW4ussDpxF2ta
         P5TeLH/BB2jvTCflysHK6Q8wtNBRGBPScybiFEKeKDP9Ov1ITpEMA0HLr0lm6siI/4GE
         wcQvHk3HTvYEDqrjBSLDZ7a2z1n6Zv1dlxOBXeWpvDvXkK9dWzFkgGf7uENA8xEO7dpp
         D9OFXdDI1IxY9xpP49vGRoe9efKlHLgo0MFXLJArKFEOJiEr67SH/emdIVA4Y1B3EYyG
         TyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739500550; x=1740105350;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VtI+Vb8g7MbKlHF8GNGco7nXiQ3egRGy3mLNKXIfjFI=;
        b=T89N/M5lHQegwgat/3Srb5dwfwu83qQK0YNXla9F2tq82j722WEZdY7Nyss/TyM1qF
         LJHDlZI2i8NbavL9ZdkU0+OdGFLWRv84xMqRfQBrr2WBSB5YYyKvQoQneaJyieC0eKe+
         gA/4v1tRAsYLFc1WMVq6Rm61pm3NXYF4vN/zvWqmn2KKxTOR+/c3eI5UbZQt3JnHE8cO
         mrEVUnT/xFz+eXZTUc9Nmae5I/9UgWUkIfjRw48rp8NbZee1omWBZe6CtM9dGpVf/cnV
         yLJuK+r6gJLkbSAAW1fAAK5KwT/nr2ZbOlYpaKOUC854sBC+T4I85r/C0opcfs+MYS1h
         nNUQ==
X-Gm-Message-State: AOJu0Ywg9fzSoGMK4RBTTRtv4gwZJxtglB4P63uGqdZZekQBD/hMCBIS
	FhGWuxh5WSsub0BALR2jKBq8j9CUZIOnwesJPqSytV2sgVJPJX7XJ200q2WUshFMYjR/w3SUk4/
	C6g==
X-Google-Smtp-Source: AGHT+IEZkABvOwmS6IjrFeu3QfP9CHXLyOdMiHH8akLSOTV9UOUWzmKIqcQGcE5KRMmess+aKOE/s1kUAS4=
X-Received: from pfbih2.prod.google.com ([2002:a05:6a00:8c02:b0:730:8f44:a42b])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6493:b0:1ee:67ec:2279
 with SMTP id adf61e73a8af0-1ee67ec2304mr11194420637.26.1739500550581; Thu, 13
 Feb 2025 18:35:50 -0800 (PST)
Date: Thu, 13 Feb 2025 18:35:36 -0800
In-Reply-To: <20250214023543.992372-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250214023543.992372-1-pandoh@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214023543.992372-2-pandoh@google.com>
Subject: [PATCH v2 1/8] PCI/AER: Remove aer_print_port_info
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Info logged is duplicated when the source device is processed. In both
cases, BDF and error severity are derived from aer_error_info. If
no source device is found, then an error is logged with the BDF from
aer_error_info.

Code flow:
aer_isr_one_error()
-> aer_print_port_info()
-> find_source_device()
   -> return/pci_info() if no device found else continue
-> aer_process_err_devices()
   -> aer_print_error()

aer_print_port_info():
pcieport 0000:00:04.0: Correctable error message received
from 0000:01:00.0

aer_print_error():
e1000e 0000:01:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
e1000e 0000:01:00.0:   device [8086:10d3] error status/mask=00000040/0000e000
e1000e 0000:01:00.0:    [ 6] BadTLP

Tested using aer-inject[1]. No more root port log on dmesg.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Reviewed-by: Karolina Stolarek <karolina.stolarek@oracle.com>
---
 drivers/pci/pcie/aer.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ad4206125b86..9a8cc81d01e4 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -733,18 +733,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
-static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
-{
-	u8 bus = info->id >> 8;
-	u8 devfn = info->id & 0xff;
-
-	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
-		 info->multi_error_valid ? "Multiple " : "",
-		 aer_error_severity_string[info->severity],
-		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
-		 PCI_FUNC(devfn));
-}
-
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 int cper_severity_to_aer(int cper_severity)
 {
@@ -1296,7 +1284,6 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 			e_info.multi_error_valid = 1;
 		else
 			e_info.multi_error_valid = 0;
-		aer_print_port_info(pdev, &e_info);
 
 		if (find_source_device(pdev, &e_info))
 			aer_process_err_devices(&e_info);
@@ -1315,8 +1302,6 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 		else
 			e_info.multi_error_valid = 0;
 
-		aer_print_port_info(pdev, &e_info);
-
 		if (find_source_device(pdev, &e_info))
 			aer_process_err_devices(&e_info);
 	}
-- 
2.48.1.601.g30ceb7b040-goog


