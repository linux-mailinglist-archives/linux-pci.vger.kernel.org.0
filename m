Return-Path: <linux-pci+bounces-14418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E3999C212
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 09:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37911C23C04
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 07:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BA21547E4;
	Mon, 14 Oct 2024 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXEWkiQg"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224A415278E
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892423; cv=none; b=JlvIHg5LSKPRIzUt2TIfZhtZbSqzt1NvGXu5QPnDvchnDHYitlOQ617Yzjwz/sXxmXH5CfyEfgjyOBV6cOR1ofYsrjjkM/xOjLKc8UDVXgDFaTIcCHfE6+6sdaRYcA1TY2MsINZywZqJ2sOZhQ2WCK2mJkiImK8eraCvqDLYLTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892423; c=relaxed/simple;
	bh=20dHbTNM+hZemZeemkf/zrLwaqYqHauu10+I7bKd7Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pD2C+ldPltW8w+a+f6Njm27M2sYyKKfoiYFRetwXTBhZPYV/00eRB8er/eVMCnJIE8rZtE3J/G4IhKhg2sCSh2ZPoGnTPai5Ujh0w5KTUxesmUfqGKP/WOGPtWAkbth0V2CHWBKJBPohysTMdDGqTTqJ4hkYLWyOXMncVoxJJ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fXEWkiQg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728892421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTleeIx32xfGthGbrYB2jpEkGH+phvUDXuHiflf4emI=;
	b=fXEWkiQgPaPdPi+qMZ9ZxpvDubS9wJYtzWggRPVejc7vNAoiZzX1do7vpmpWy8R0KHPyno
	mHK3760A1he/uaCCe5Yg2Cg0S8BcyKH4JGEC6Atbagr2DPT8llG1wvwLLrwYqL1+fuNQhD
	PzfTRnLh5JYY0HZ+oS6vmxD7SRKOLzg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-qOMCfweXOEKcnh7IGtCMHg-1; Mon, 14 Oct 2024 03:53:39 -0400
X-MC-Unique: qOMCfweXOEKcnh7IGtCMHg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8711c48990so340060066b.2
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 00:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892418; x=1729497218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTleeIx32xfGthGbrYB2jpEkGH+phvUDXuHiflf4emI=;
        b=IWN4vx2vm/QGhoCD8t0x/GeXgA+TtDC/q9NfGhV21j8ePkScBuRtrzUL1GWRxuoxbU
         upEaT0IaK7/kzFADZo8R39cgHCcKQjKi71L4LDDLwIguvyHZ8FdTbR8vHvSRBNobvUoD
         sXMg9UAZLpZGUlm8FaF4IkfO2+FqzkmwnDvPZkXr0mjCLBVHlmQiTnt7+ySSu3pB4UPP
         SPpRUGIhJJ40FqyyC3gu4FsZJ1Zzdq05PoTFYStuHJpD6gKpC+e5+Tsi84LX9l6xV6gz
         vJt6qv9LBdurO7k3dnkZed3PFdNOAoFa/g7+2xXIgcxeNIx9eC25U8EzRn90kPuzC3Xk
         Y7jA==
X-Forwarded-Encrypted: i=1; AJvYcCWpxmWTEHjpY7QfC5/7WmcYBd4MOWqddMl1jFYPblLCaGJRPvuKBX3oFSNTbjWiP+M9wMjpaQjeAlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgEMNLU2KbpxcPX2fxyox2Z0nsqcT3Lh5QDGozkt56gYFRAdSC
	o6nJbxGLjVpBcVnHkKaxDJp8Mh6IHiu8uv1Kd5B7wFN89GXhasPDlfXx/GbitzO2toRfsbK5Chw
	e6GdIfYidEu/Oo9ISV5Fycw3OQC9vQ4ac7YFHH0RvAfpOTKAWSxfjxOVsiw==
X-Received: by 2002:a17:906:478b:b0:a99:fc9a:5363 with SMTP id a640c23a62f3a-a99fc9a60a2mr368732966b.9.1728892418066;
        Mon, 14 Oct 2024 00:53:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUnosY+kibFUuBIFRq/gqj6RpYmUBSd6Q1TUjFGYFrABqsddiCupMgUWAcTJEMJoMK0CGTFw==
X-Received: by 2002:a17:906:478b:b0:a99:fc9a:5363 with SMTP id a640c23a62f3a-a99fc9a60a2mr368729166b.9.1728892417590;
        Mon, 14 Oct 2024 00:53:37 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d3798001d5778cfc1aeb0b3.dip.versatel-1u1.de. [2001:16b8:2d37:9800:1d57:78cf:c1ae:b0b3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f86fa986sm243291666b.92.2024.10.14.00.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:53:37 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Keith Busch <kbusch@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Li Zetao <lizetao1@huawei.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v7 2/5] fpga/dfl-pci.c: Replace deprecated PCI functions
Date: Mon, 14 Oct 2024 09:53:23 +0200
Message-ID: <20241014075329.10400-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014075329.10400-1-pstanner@redhat.com>
References: <20241014075329.10400-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Port dfl-pci.c to the successor, pcim_iomap_region().

Consistently, replace pcim_iounmap_regions() with pcim_iounmap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/dfl-pci.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 80cac3a5f976..602807d6afcc 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -39,14 +39,6 @@ struct cci_drvdata {
 	struct dfl_fpga_cdev *cdev;	/* container device */
 };
 
-static void __iomem *cci_pci_ioremap_bar0(struct pci_dev *pcidev)
-{
-	if (pcim_iomap_regions(pcidev, BIT(0), DRV_NAME))
-		return NULL;
-
-	return pcim_iomap_table(pcidev)[0];
-}
-
 static int cci_pci_alloc_irq(struct pci_dev *pcidev)
 {
 	int ret, nvec = pci_msix_vec_count(pcidev);
@@ -235,9 +227,9 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 	u64 v;
 
 	/* start to find Device Feature List from Bar 0 */
-	base = cci_pci_ioremap_bar0(pcidev);
-	if (!base)
-		return -ENOMEM;
+	base = pcim_iomap_region(pcidev, 0, DRV_NAME);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	/*
 	 * PF device has FME and Ports/AFUs, and VF device only has one
@@ -296,7 +288,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 	}
 
 	/* release I/O mappings for next step enumeration */
-	pcim_iounmap_regions(pcidev, BIT(0));
+	pcim_iounmap_region(pcidev, 0);
 
 	return ret;
 }
-- 
2.46.2


