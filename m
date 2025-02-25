Return-Path: <linux-pci+bounces-22360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9B1A447C4
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D837416A61D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E28220C470;
	Tue, 25 Feb 2025 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3mbytdo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD2F199EB0
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503574; cv=none; b=qFUnhJ8fcYl46vBzzvafpgwKGXdfViJ1wzk0pM4VSieSRK8m0f0o2S9P1AEYKa5Y5LoZIKwR+QZR+nZY4Ql/8thYD06zXQDPDOaK5FrXd24NCseB1nQk7/eIr2AvQgPQ+tTTsfLi0iPsQ5u2lUSaxg3n6sK+/5yDIJEloFZqZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503574; c=relaxed/simple;
	bh=FnUacC9VqqRTi29gXJo7HKIQwygyqPBosmqqmN5z+pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UjNJlC/lzHk31TFD/jy3Z0wLQBcv23Ka1cthq0FexUWG/HGuwwud0Iqn8Npbt8p1t7N7Eubkj3OS7Vgs47DN4eosqnYjHlcTKxlFE4FOhc8qIFqFIKMSl+S4EWKssZBFEq4vSA5VCcMZIOnIeBufhI40pEhDYFdokrbSP3oQUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g3mbytdo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-221050f3f00so134444785ad.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 09:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740503572; x=1741108372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5lxY7B542/PLdEoJyDDrjtx4yD4vXFk48rEXnqEjwQ=;
        b=g3mbytdoVZEX7ZA7zKRirvzIYoazIPF7Ip+vVmtGRxCRnTiPnJKPfKMnV4qaQUJQPV
         igsbUbOq1xu7s4+tHbCV/rH+hc4M8oDeofNvzJEEeAJcHJwclG6kCXG9vNnK3sHU4hpu
         lXCktHOOimAkRtZOR6OlZgxu1Oh30uf2s1R+Z61XcMDy1Y18VN0bTjeZbceiuwpPcHJ6
         v6jniiZ8HjYT+6/dIMcfK/bmYEwzjajxtvyTA2jCmfXJKcTCv3v9YCrWhaGwK5WvDIFr
         8n1q1IngxQ7Q01OKGnpp6B5UNe0M9/rXLQ6NZKBA/idXKYgJwlQFXSmysAnjWx4C7FCN
         8t/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503572; x=1741108372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5lxY7B542/PLdEoJyDDrjtx4yD4vXFk48rEXnqEjwQ=;
        b=T2TiCXuf3iLt6VEbohEKxfA47nfEBFYSZRO+7kUH/n/l5hgKGxXLgKVLj6T61DLsA/
         YNsKkHH/NgQiDo9KT6QYBRZRbeaBLh35r3ikau2+SWuKuaJj5+ssYQ8z26HakoC73CW/
         rGIc1JeaS2gnAi+wkvgb7xT2Bm8l36nSUYGQsUYKqbN4Vo4O5PfngvhrXSE/aJvh4NPB
         BW27gO41yuVkLsgyQXbGUTlt9UCLG4AR8xrzxMhhhDRtrP86Obh1P+KDRUMcwevyteDj
         4DjiLWSv3uituduX/EzgzvY0C6BJ5TVFusIpc4HBtzv2eISqLb53yuk78XSHT9RdCD/O
         s9Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWuC7DaKfCND+3ukiLwRDGgSX8s/kuS51OUkTfrKKTt/YyErMcs0Jef//d2WBVThGcOktN1v8Zyea8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRIEecRPYikWihmtQNULBRKQCrpvjkG3yNpY1DnhxUrHJPZijw
	h1mRiDfYbplVD8maXRfszlG3jH2FGbP5Nza/VqXBBkMakozC5wWTNRe14zy4EA==
X-Gm-Gg: ASbGncvaU3JzDBEbFZaJJVvRn8VdCF/BiQnv3x9RfBJItMYr/ti/iBqtrf62vqLBuvl
	208FJ8KSOKhQik52rRyMka05lqknXzNbxt04wVAwov2u7QpvdO78bH27rZED1IW+HfKtcklZOX2
	iPMb1mtAiGYCO59kjP8mD3+BSS5GfTrQAMYTJCaYyaWaRzq1JBLFK30MsJyI8iEh3va0r6iWJOZ
	P1L0PHFxNz+BeawNxer0EC6uCv8L4sDPg28gLf0ADevjGUaJL1CJQGhSxJThF0ulY20Mxg1ND4c
	Sq+IJJd6LNCpfj0NbQaQSJEd+N4lSTi3FzjASeF/ITwGFgt1gDvTjA==
X-Google-Smtp-Source: AGHT+IFw71b3OYVPNe+t05CidalajI1SiIlNZ2RN6zsNLW4GExT54+gYQjXEbzLSFC9QbDLlJoqFIQ==
X-Received: by 2002:a17:903:2344:b0:215:b75f:a18d with SMTP id d9443c01a7336-22307b4554dmr67545865ad.11.1740503572170;
        Tue, 25 Feb 2025 09:12:52 -0800 (PST)
Received: from localhost.localdomain ([120.60.68.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a095f40sm16844925ad.144.2025.02.25.09.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:12:51 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kw@linux.com
Cc: robh@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shradha.t@samsung.com,
	cassel@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] PCI: dwc-debugfs: Perform deinit only when the debugfs is initialized
Date: Tue, 25 Feb 2025 22:42:38 +0530
Message-Id: <20250225171239.19574-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225171239.19574-1-manivannan.sadhasivam@linaro.org>
References: <20250225171239.19574-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some endpoint controller drivers like pcie-qcom-ep, pcie-tegra194 call
dw_pcie_ep_cleanup() to cleanup the resources at the start of the PERST#
deassert (due to refclk dependency). By that time, debugfs won't be
registered, leading to NULL pointer dereference:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Call trace:
dwc_pcie_debugfs_deinit+0x18/0x38 (P)
dw_pcie_ep_cleanup+0x2c/0x50
qcom_pcie_ep_perst_irq_thread+0x278/0x5e8

So perform deinit only when the debugfs is initialized.

Fixes: 24c117c60658 ("PCI: dwc: Add debugfs based Silicon Debug support for DWC")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index dca1e9999113..9ff4d45e80f1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -535,6 +535,9 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
 
 void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
 {
+	if (!pci->debugfs)
+		return;
+
 	dwc_pcie_rasdes_debugfs_deinit(pci);
 	debugfs_remove_recursive(pci->debugfs->debug_dir);
 }
-- 
2.25.1


