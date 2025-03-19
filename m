Return-Path: <linux-pci+bounces-24074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA644A68717
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 09:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7F642030B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 08:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0331A2512ED;
	Wed, 19 Mar 2025 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGY+gECu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8552B211484
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373670; cv=none; b=Nj/rIRPX4oax7FhXSZ4s6w8rojE6xuNJcaXHFexJQD0WmgUVNGVO48oGnPpea2wmleeHPA4mOX43yv32vVioysdEK6kQTO733tLX6IPY2lyT8arTw9FuHqHY6DTM74AXRKPXgiONhBvyP7cp0j+CovgjGVNhBlTDz+VkFvqR5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373670; c=relaxed/simple;
	bh=MwEATReO8imz4GoKPAFiBiNDctI15TMlRL06/TVa40M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mAxMXgih5iJEyNWW6PdG92lH2XVE3GMci5r0G/XbLy+JJyj4u771bIPm3ZClh1hsj53+aRrb8Q/dUpnLpuwyBuJVeILwkop4NjyZA6wiBfcTCSGY677YCCRb6QJM0etRGSFegxl9z674sNPwkL1BbYe7svAOBkhfsPsjoNU7emQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGY+gECu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22412127fd7so84335755ad.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 01:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742373669; x=1742978469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H9AxGwy1IhUwP8hXGISKWkuM3ZklYPzsVZdfo4nULSY=;
        b=wGY+gECuEcidQ900nArEMb97ZsajuvkjI3wPKEZowgS4B5gTzGiiY5M4/qr3Nej1Qt
         RYFG+G0b/PqZFvpRddspBwbYJ70ojyCbQDG80qRNoPqtA9Xsy+2884RihW24MXTt4eXp
         fksKjc0YrhAOPclK2AQDLqj+8TVvfCXbRlwdUhNGLvW5z5TODRrLL9XGzx/DTzZG1X4p
         FmGvqFSoWnApnBUxMM0hATWZOau9bXda/3sbYOj7GczHpHYkLCtz1NEHCd32frYxGj1O
         uauX76HmEHD5F1g5VGY4O9CMKWkRkwEMmrD8jK0Q/wieXJ2e/+Cf0XQJlFzNZMXG47RI
         /FTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742373669; x=1742978469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9AxGwy1IhUwP8hXGISKWkuM3ZklYPzsVZdfo4nULSY=;
        b=lCBuDUkWKsllso85LaRYLCuHu6DHzl041Mxab+JhlsEbV0FtM32OWZqdkYjBKxFQ3j
         YMGAOpSmaWRJFYL6lNFwdkUPSrOfu9oEcumORlD2swNCGOZelhm1QpDCChjfJKFaMQEs
         rgfZe7AgESt30034idd5jdRqKmNSXubMw7J2ASn6aQbQrTAl1G+WHNhgyLWT0PsrBspM
         ITFenu6hc2P1n+hxr/r6RqxWvD5k70E6+JUCEkwzQHJ4msgMDDqoAzIW/lD6oZvs/71+
         z7oPOo8YCdMTWV/hq7AEbJifp8sk6z0fVRbnYB7X6bC67en+C1JLQ7TKfm0cei5YjMti
         f9/g==
X-Gm-Message-State: AOJu0YzjWClDMUalT9aoQ97XMRGJvswezOBk73dh0drkSxp01FvUd0wh
	2aEgfatdVYsl0iWXUZL40mrV3CATIGIlgdv1E26I6GtExGyJh156wYfmsKC9Ie8WNGiqFnPJc56
	zNA==
X-Google-Smtp-Source: AGHT+IFCu6a9ZK9xBCnJ2jlKnyBDnng8eNVjKexlSoToTJPVsU3/B6u6SEIjmcgQgHRFOR7D3TRTP/HVh0U=
X-Received: from pjk8.prod.google.com ([2002:a17:90b:5588:b0:2fc:ccfe:368])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f68e:b0:224:2a6d:55ae
 with SMTP id d9443c01a7336-22649a6a8f8mr32820175ad.48.1742373668797; Wed, 19
 Mar 2025 01:41:08 -0700 (PDT)
Date: Wed, 19 Mar 2025 01:40:43 -0700
In-Reply-To: <20250319084050.366718-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319084050.366718-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319084050.366718-3-pandoh@google.com>
Subject: [PATCH v3 2/8] PCI/AER: Make all pci_print_aer() log levels depend on
 error type
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <Terry.bowman@amd.com>, 
	Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Karolina Stolarek <karolina.stolarek@oracle.com>

Some existing logs in pci_print_aer() log with error severity
by default. Convert them to depend on error type (consistent
with rest of AER logging).

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 drivers/pci/pcie/aer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index cc9c80cd88f3..7eeaad917134 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -784,14 +784,14 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	info.mask = mask;
 	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
 
-	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
+	aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	__aer_print_error(dev, &info, level);
-	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
-		aer_error_layer[layer], aer_agent_string[agent]);
+	aer_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
+		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	if (aer_severity != AER_CORRECTABLE)
-		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
-			aer->uncor_severity);
+		aer_printk(level, dev, "aer_uncor_severity: 0x%08x\n",
+			   aer->uncor_severity);
 
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
-- 
2.49.0.rc1.451.g8f38331e32-goog


