Return-Path: <linux-pci+bounces-19627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEEBA092CF
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 15:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E5EC7A3C22
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 14:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2130D210190;
	Fri, 10 Jan 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="S+hzhv5r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400EE20FAAF
	for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2025 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517723; cv=none; b=uNo+rM0IJPN8l9tzyNoDRzPv0cJES+KPHGBTRr4kZUkjSMfJd8Dd/1TUu2D+iqRSYlgCRu1Otwpz+6cPmzFB0qnWDLYpk2DXZIc5Um3+kBlSHt7qG065aSrhNvxV7jMMu//mCFlffwIWMN71NPb6HAKfYK/OZitGDPAGfR1pr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517723; c=relaxed/simple;
	bh=jkblsDlsUSxYsT+VxyH05FNCYvRrKBfkKwtrrzDlM7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1p4Xl9UG77bNZ9qEVhLxW8LkcMb3kUPVK224yzS1WRsvvyoTPIjU6UCXJ7nyjIGHCZN92moZh39O4xazC9niOAB7QwMDzCiD1VT/Ou2T+gV8uqszXW+CBYO4plfBDx1YJlpjCmJbIZwFmMBd2E7QYFrT6ctMW9kiJmMRv8yNVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=S+hzhv5r; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaeec07b705so338208066b.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2025 06:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1736517719; x=1737122519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/I7HoDRHZV0XTx2nTCcpli5SpYI0/lHKSshoL/AVNY=;
        b=S+hzhv5rircbWM0IFWempym1Mth+Urk9ahOV/UUkFYoik9QDdmdU2Zme+JVf//ftNP
         OYX+gwnPKh/2K/YUry34z7gkV+/mtrAsjPXUybeMCGXWvdUkdaJmgOarQgnycHMTpPRz
         zBkFHEFhkvWMSdj6rwrnsm5yLi04+UObVaVx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736517719; x=1737122519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/I7HoDRHZV0XTx2nTCcpli5SpYI0/lHKSshoL/AVNY=;
        b=QRSramFGFkG5cvxEyV7V201ku6PdGoYWK0ZikEoTvJRdjTxjMSBXRQVUJM57ETmZk0
         1jhSC8RuyDOkHpXLfP1BqUS7Yhtr1IgalJF/QI2AIIqmUZqPTg+G87xRh9vOoglyCk9W
         mC4TadkYhrpJgU5O2HshADx7KLfq7AYp1aIxOpAeRPSfUYld29Q+2YyhsfvFCSGQPaN4
         7LvJrqDxpLPRzDz4cl6jPN523i6nA3O1qx6XulyZvUNQEY8BwDL8IL/56K31b2f/s3Ae
         0HRsP7smV+Aw51nIWcxo/YX6WHsDK98/o6IJfxIlZqvZCGoaol8kzGvi0gB1QltirKeU
         J5kA==
X-Forwarded-Encrypted: i=1; AJvYcCWRP8u6A2drZkJxxvZS7GtG45gWHn2oQ5C5qkS4V+syUvaCa0AssILIYSwMUxRqsSGqb830k2GN3pw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6dWSQLOHi0qkjvKcFDFgmaFXeVAcyPG87XnnW5cAuGhKaIEq7
	+kgoL9vAm5GojM5xzkzXouRZirw/ISFsafjfF0Xeoa8kklX0hAarWqkp5Zt8aXw=
X-Gm-Gg: ASbGncv0OHhMwITgPg40u2O5hBSnO7ht6JwSrQVlTBvJmcSd+Mbi3csoKSbqo40L3A/
	l4R3ntsOkokW8dnePdAAuGhzCNLjRE+i6esbBURRROEsjsV2WMbGQQZgh7wzcusj/60U2NcvpTi
	o2rWRlXq/e6bP10Q9y5ZcuAxEcaOtjQ3na9X1NXVBzdMAGb92dphUN4gpD4EVAf+vsI97Zom9H1
	7+3Rc1bzctwv3kJoWwCtwy/hjvIe0lX8vcTYFHRDW0Byuz6FNZKx7+TlqP4vaYfjIU=
X-Google-Smtp-Source: AGHT+IHQABlx0ljsChy/AaNgLOa5tG+fbxwnozWPPmywCwKrdUKAOZN8SDFE4NcVHC8wzrW5y/A8Dw==
X-Received: by 2002:a17:907:c588:b0:ab2:c208:732d with SMTP id a640c23a62f3a-ab2c2087cbbmr743393166b.40.1736517719125;
        Fri, 10 Jan 2025 06:01:59 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95af680sm172606166b.141.2025.01.10.06.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 06:01:58 -0800 (PST)
From: Roger Pau Monne <roger.pau@citrix.com>
To: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/3] vmd: disable MSI remapping bypass under Xen
Date: Fri, 10 Jan 2025 15:01:49 +0100
Message-ID: <20250110140152.27624-3-roger.pau@citrix.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250110140152.27624-1-roger.pau@citrix.com>
References: <20250110140152.27624-1-roger.pau@citrix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

MSI remapping bypass (directly configuring MSI entries for devices on the VMD
bus) won't work under Xen, as Xen is not aware of devices in such bus, and
hence cannot configure the entries using the pIRQ interface in the PV case, and
in the PVH case traps won't be setup for MSI entries for such devices.

Until Xen is aware of devices in the VMD bus prevent the
VMD_FEAT_CAN_BYPASS_MSI_REMAP capability from being used when running as any
kind of Xen guest.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
 drivers/pci/controller/vmd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 264a180403a0..d9b7510ace29 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -965,6 +965,15 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	struct vmd_dev *vmd;
 	int err;
 
+	if (xen_domain())
+		/*
+		 * Xen doesn't have knowledge about devices in the VMD bus.
+		 * Bypass of MSI remapping won't work in that case as direct
+		 * write to the MSI entries won't result in functional
+		 * interrupts.
+		 */
+		features &= ~VMD_FEAT_CAN_BYPASS_MSI_REMAP;
+
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
 		return -ENOMEM;
 
-- 
2.46.0


