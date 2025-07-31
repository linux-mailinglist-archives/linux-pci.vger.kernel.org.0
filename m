Return-Path: <linux-pci+bounces-33226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE32BB16F16
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 12:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C7016BD3E
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 10:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD74E2236FF;
	Thu, 31 Jul 2025 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuu/UYLE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DF32A8C1;
	Thu, 31 Jul 2025 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753956060; cv=none; b=ifEc3IPpoHPxQSjN9UWmn4HVVGFJllbYsfH6602lXfde9J3mD0wICcfqsHv2aInUUWfXBjoOxR2BVLSn5dv75wpA4KveZJ5gL4rt+vtANl6UOybjFr6vgf1fzbu0VCP4gTsou/oy/DKExpzLPbr6XgNJn7wLyZf70m73oZ78dvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753956060; c=relaxed/simple;
	bh=D/Pse1aDeleA703VwEsVnxO77p0exXY+NO8OrcIK420=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TgFnQ0qnQsUIQIqXM4ORwqO2c51zSM/rL7u/XSsxftkywrq3fFCu3YsSm8S7DpcgbEbsWgxw7GvizRNH01BCwb3IsiUpbVdssOoDpcexp6zsJEHZdNXoznkxKMPEPpQbQNyDqujFVFHcPdKw9SNhsfOq5Scvh4yO0y/kOjYnT0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuu/UYLE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-455b00283a5so1364065e9.0;
        Thu, 31 Jul 2025 03:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753956057; x=1754560857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mW1dNUXjXlTN+wuB0WXe+6YyB6aJsubXCg360VY1fvU=;
        b=kuu/UYLE41zw2nIy6KDobNHLbhC16/grwr75n1AetloyS3aFL6z/3CTn7sRrHfV+74
         SPFP9AOw5qKeU5oA5eGMrUeaywAIK+pXPx2MtslMNgQ4CV2VlhnU6MoDzmvMQdix4RAG
         OaauVmHqlXxJBPeOMXmnGit5u+KiqtqNCjGcOoXCdBGZisD74/5Wytm7t7+H9EgZoPMs
         o1Gg1/e4MySgm6OIA03dPc0i8DEBrz0gqa2oHDCF9CSi+VP9H62I4BYAcb45smqaGLAr
         4suFL6t61binL+nAelCY0D17e9Y8kpjweFrQo3IgFW4ZucvXDhYJKgmuujNwNTrVtn2F
         LcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753956057; x=1754560857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mW1dNUXjXlTN+wuB0WXe+6YyB6aJsubXCg360VY1fvU=;
        b=iRtmzt5yU6qsLP8I9vcCSIK8NF5i5da9atGEt2dzKj+2W10ImTXcSsaRPSrJsaovok
         mmz4Pe1MAu1yD5GmIamoUZyq+V2nGjfN0ZfioJLFUet8q8kskbA03N5QDtwVrmwv2T8k
         PneFR2nP8U/mLauxx4qGIAzPGCdwJQu9o7LYqJHj7vbXYJW7oKlM+oNrKt4Av6p9kgqU
         7oU8Am98KrsBl7imN6w5u9kNjSjso85WiXLl6CeI25i7LrSxCxnYxz0Tg25enat79JKH
         e6FOVLFyhtVDJ+L1M+Rh+4uaBfKg7/Yea//vKzzQKqcaCyq2Ruigh+KsYagruRKlFu+V
         z0VA==
X-Forwarded-Encrypted: i=1; AJvYcCUU4n48MOlurUP9l1663XaD5mBNMyoq6AhwL3+yFfhnrV0O86pI4qNuIkwFYfGMWaE6WnxPCxZqgFKo@vger.kernel.org, AJvYcCUof6NsrvQ94saLF2BXdLVN47yQyNROiVMwrfeXMHhVtxRn7KKysg7erzME14iCT/lk6s9dIdsuglpMpMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMdXOHghK2gyNK/tGlYDmdJefNKYgL+YcvmlwttSt1I61u1cZJ
	zaeP8kxURcKaJ7FRm7uNwiouKfQVp1/P9GqsHTc/je+uhxmjbMlfav4Y
X-Gm-Gg: ASbGncuj1Y8KqrmiA8DDYimCGz0aeJ+k1gU7Ta/v2zGTRVBsZEBK7NkzVBl4Ec/wpvN
	CU6uVCssK71EpP0cs9RyspfQdkPSlcribl6ZerO8DDdcLhCSXMEWFvRmspGV4596Wm3oJP82Kot
	FkmxEsdv3lJF+JipXcly3i/VcK+Sdf31y4fDHCu97+cvHt4uEXUCPmqkPTth7BNZsGOXyBRXeli
	ZVGcV6U1chGPz1gZVBjXvcRa4O9VO7oCvsGkJBTzIx6Bv80DVvZs5wWjwBv1cQszC7H8RA/fLJa
	kDNQ6Mfs8BtlSG+vsZboIgjc7c0FAe2AmlQwg7p+U1gxZOnKgOApmKYPAnLZ7Pt8PkgPCa8QlgY
	L060NtO4Ibx1CVwsebNIiG00FOa51GtM=
X-Google-Smtp-Source: AGHT+IGQ6Kbneqb9SOPvp5dN+lqGJxIqcX3WzO2XlOiE5Tmg6TBNCMzJE6qi21TOp0dkhT/vQt2CmQ==
X-Received: by 2002:a05:600c:810a:b0:456:1d4e:c14f with SMTP id 5b1f17b1804b1-45892bd0a3cmr53266785e9.28.1753956057113;
        Thu, 31 Jul 2025 03:00:57 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4589ee57922sm20566725e9.22.2025.07.31.03.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:00:52 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] PCI: ibmphp: Remove space before newline
Date: Thu, 31 Jul 2025 11:00:17 +0100
Message-ID: <20250731100017.2165781-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is an extraneous space before a newline in a handful of
debug_polling and err messages. Remove the spaces.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/pci/hotplug/ibmphp_hpc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/ibmphp_hpc.c b/drivers/pci/hotplug/ibmphp_hpc.c
index a5720d12e573..2324167656a6 100644
--- a/drivers/pci/hotplug/ibmphp_hpc.c
+++ b/drivers/pci/hotplug/ibmphp_hpc.c
@@ -124,7 +124,7 @@ static u8 i2c_ctrl_read(struct controller *ctlr_ptr, void __iomem *WPGBbar, u8 i
 	unsigned long ultemp;
 	unsigned long data;	// actual data HILO format
 
-	debug_polling("%s - Entry WPGBbar[%p] index[%x] \n", __func__, WPGBbar, index);
+	debug_polling("%s - Entry WPGBbar[%p] index[%x]\n", __func__, WPGBbar, index);
 
 	//--------------------------------------------------------------------
 	// READ - step 1
@@ -147,7 +147,7 @@ static u8 i2c_ctrl_read(struct controller *ctlr_ptr, void __iomem *WPGBbar, u8 i
 		ultemp = ultemp << 8;
 		data |= ultemp;
 	} else {
-		err("this controller type is not supported \n");
+		err("this controller type is not supported\n");
 		return HPC_ERROR;
 	}
 
@@ -258,7 +258,7 @@ static u8 i2c_ctrl_write(struct controller *ctlr_ptr, void __iomem *WPGBbar, u8
 		ultemp = ultemp << 8;
 		data |= ultemp;
 	} else {
-		err("this controller type is not supported \n");
+		err("this controller type is not supported\n");
 		return HPC_ERROR;
 	}
 
-- 
2.50.0


