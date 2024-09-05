Return-Path: <linux-pci+bounces-12803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3897096CE8F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 07:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5AAFB24A3A
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 05:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68DB188A32;
	Thu,  5 Sep 2024 05:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao2AbB64"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F968188A1F;
	Thu,  5 Sep 2024 05:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725515048; cv=none; b=mI3bc/wnMJGAa2QhiwboojKbagRHHDmeMLFnrg8k2QxIK3C3iCBb7olq1FMW9YXgzBuWDxd7n+s66Jf0ymHE0EFAFzLGMEnWUkLTXO2e26XrwQfc8+lpccTrIzZXfHFTIWgpx/3+REjoa3r9m1qLlBTwCTEHl4lR0sy6vMMgrGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725515048; c=relaxed/simple;
	bh=CdJAp/tUMWFGhcz1c0UPGBcC4IuszSHGI5lDno6dzRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNDmhX+WjQUM3j7JW16v83cBmIebRo/c15S5XGBc5Wl0e8IQC+V5qD7VB5cO0Bl2mySC3d5YTRKA49fixHHGyplOH7Ku9zKm+U1JayQL1HoFsdpkOpaiy5vGg10+nZ2TFw/+Mnne4NBI8wbnGgQ6VFMX90Wklk5wrNsuf8AhGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ao2AbB64; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d8881850d9so284733a91.3;
        Wed, 04 Sep 2024 22:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725515047; x=1726119847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbsO7GDIIJTt0xgKGCjBgrCED+h3LnKu0qaWwuQvabM=;
        b=ao2AbB64Gov841SsaJPPJZxU4GTYdEJZg+q/ZNvsJaMUo4vJnL+6VyhV39fqGdDQFe
         9NG00wPBAaYUWzcE2MIahe2E3RsTe/yPHcaH+P6Ys3llo5f2+V79eYMJ1e+UNvxCnRrH
         TDn+4W+KYF6el5bju85nHAYUbvm9/wA1HvTzqTgAUDVJ6Ac6LmLylD1QZzzaphCXESmo
         5AXAprGQxEDCtf+OEqmFyX97j5lh1tMUSZqVJmCaBNezuCGNB7sSfIKd6nZA6PqwH8y8
         4l7TBhcv9yHiqXEykGXORWuL4PMpSfxbYN8T0NKRL90piJT+Arxs88bewriMvlar+1EG
         gYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725515047; x=1726119847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbsO7GDIIJTt0xgKGCjBgrCED+h3LnKu0qaWwuQvabM=;
        b=q40+U6uISZpN1vnHyxPnbW/ybLvYdRvf5M99A72l3vKZgbOfsmPKgh7bMm3iBsbB1f
         Furnz0/eWJk2wfD7dTmJslO4Gy3UBj5uSrHZBBgiOc64XiWZJQ47R8Tep8q4bawPclob
         /XkXlHaxYIqZpqhNIQByb5D9SifwIXGM9psEEHw2+Ql9GGJwupSbzvMMkmWxXKtLWV6O
         zL4TkgCGcJe/CJeieXs44bJfLYr76vowSihI2/Hlr0o85fxaPOP3oPAuClSDCTpN2rgA
         cBMKR6Blhk9qSarOdPMniXhpuNV4Fi31BIgxLhGK/u4seG5q4itgXNxNjddxHtLvgT1y
         9gSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNrNs8fY9sElSiZV1v7VHCFRBkBWPMTeIjACW1HlSYDTMqd+TopPIvnm4aWNxXtzCq7XUJ/JsVn4zf2sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKb5Zkco3AmuwrlllxiFkZ7UkK7qkqtslOoDEqdpsqhwgz7DIm
	A1h1mBbHP63nfo6AF/n8RNq/2vxmmRgf0HuLfm7+O0r2LGOrR9gB
X-Google-Smtp-Source: AGHT+IFREtDh3v/rJbVgKE66ieWm7HhiQ791rRKVF2ym8Umg9iu1Hx/8lKh3w16vChXjPVOd1srCbg==
X-Received: by 2002:a17:90b:3e84:b0:2da:5156:1241 with SMTP id 98e67ed59e1d1-2da62fddceamr8295212a91.16.1725515046445;
        Wed, 04 Sep 2024 22:44:06 -0700 (PDT)
Received: from fedora.. ([106.219.166.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da63ac4ea8sm4930614a91.21.2024.09.04.22.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 22:44:06 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH next] PCI: imx6: Add error handling in imx_pcie_cpu_addr_fixup()
Date: Thu,  5 Sep 2024 11:12:55 +0530
Message-ID: <20240905054255.126676-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added error handling to the imx_pcie_cpu_addr_fixup function for cases
where the memory window retrieval fails. The initial implementation did
not have error handling, and the function simply returned cpu_addr without
checking for failure conditions.

I have added -0ULL as a error return code but what should be the ideal return
code for error handling in this function, given the u64 return type? Common
approaches include returning ~0ULL or another invalid address value, but
clarification on best practices would be appreciated.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
Compile tested only. I am new to the PCI subsystem and not sure how to test these 
modules. Do I need dedicated hardware, or is there another way to test these changes?

 drivers/pci/controller/dwc/pci-imx6.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 0dbc333adcff..6af39852d2c2 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1023,6 +1023,10 @@ static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
 		return cpu_addr;
 
 	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
+	if(!entry) {
+		dev_err(pcie->dev, "Unable to get memory window.");
+		return -0ULL;
+	}
 	offset = entry->offset;
 
 	return (cpu_addr - offset);
-- 
2.46.0


