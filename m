Return-Path: <linux-pci+bounces-5168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D604788BFDB
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 11:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DFF1F6199B
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 10:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B1B3A8F0;
	Tue, 26 Mar 2024 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKI9rqcO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92EA171AD
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450143; cv=none; b=AX299gCdEN2xeC42TPpoZEC6Gg3kNO7IoZ6dR1DoIv+ckM/p5LjY+nsyUBqUM+oTyIjJhiPSElA5oXG6gBfnFUbhTXvo3zgoNYMY9JsTXf231Ic0ephC5+nMI9Lnv56Q6Malz1EJwEK4TvxqpC+FcnigqMQRD12jeXNFXLFq+YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450143; c=relaxed/simple;
	bh=a9jhEQgepLFu1V/9oFFkAbVrqrZxzbztMATHDJFc3OU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WhA1Cu62BIvGIxjWXf7So9JYquXxvXuYyrSP0K9BsyGiMfz2DuoVM3h2k3g52eQZoWlYuFbzgTh8PJg+wr64M+RXFUS0m9i1ZusOf2Fg6vs5v5uSjZcsXoUnrqNIieHrVeWy/uREnkjlhqB4MKitVPAlJlzpHBrG5l9p8myVtJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DKI9rqcO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6b22af648so4173602b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711450141; x=1712054941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3SaotDWl/4tLhYj27mIQOcHctxJufPLQpgAq2r/Phs=;
        b=DKI9rqcOywAd/xF3C0HFG0zlBOPpf6/tdssQ9ECGiIrOYlM0+27o5d8M53lawXcz5L
         wEQQR80kSaPJX9H9NoAI/cyw0nnVkF1lJedokvO7BKIP0eASiioZv4zv8TpG6PL6A7tw
         oIyzCv32Yr/nqRn4VRUUBNrfQT6NRqDLWEN7SwKf0zwB00TP3RB49GlIBrYNn9G/0/jf
         PUS4IZ4ypkc/mHRJh+i9AOCvGzYpnnrqkhHgpmaR6d3Jok8tZISq4kdwhbPRzkPCYNcm
         ZqGT0VbrkB+yw6q1Ry2+DGb1SSf8JlIIzlhyDxvjH3OXH2vGWjWAx3NPsoZoU3ArFEiA
         b1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711450141; x=1712054941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3SaotDWl/4tLhYj27mIQOcHctxJufPLQpgAq2r/Phs=;
        b=f6oT/g9XnAO8as/X2GQOIifl2Vtrdd7AoA5FbPSFmx76N7E3zEVVUV3yOMd9xpfkhk
         dq/bmGb4vm7+zH5bgQZsz9PzajDpKtLqGK/Vl6Ktc3Tl/odHqsbWeNKGgvOdprEr0pea
         rMTpkWht8W481nHV5ibyB7YGuHrDLsd36xyGU/8gd+c0MTq1No/09dCgXfe0RyOKs/Sh
         yOUX2jEmNQW6HKedFbHMhTRv9iBJoJLQpgbXxGbokl95LqRJf7Z5TgoMtCtJ7GbOczEZ
         PYHInPbD7PczJdLt6yC6MSMDWLOcmcGlV3lClWIfIot6xgA2vcOeNhfZtOZEKmTGzRrK
         43HA==
X-Gm-Message-State: AOJu0Yyj6zDt1o0eGKpoGY/bqadnhguylvJqeDXmaaPz+1WHl6pSS0vb
	JEX/mi2faxn9PcaJMy65xqVdUIlB2GjkRCGd2HsJOu0CfvV7c5yHKoWi26Vzgw==
X-Google-Smtp-Source: AGHT+IHlO3+pLdIHsXr+Zqk4ZTZm+g6rYTdPkIaErY2qnQHcr3IGV3c/Zdyg8NfbLAv1QA3Qf4eobw==
X-Received: by 2002:a17:90a:c788:b0:2a0:8eee:5603 with SMTP id gn8-20020a17090ac78800b002a08eee5603mr706623pjb.6.1711450140840;
        Tue, 26 Mar 2024 03:49:00 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090a059600b0029fc196159bsm8777218pji.30.2024.03.26.03.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:49:00 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Tue, 26 Mar 2024 16:18:17 +0530
Subject: [PATCH v4 1/4] PCI/portdrv: Make use of pci_dev::bridge_d3 for
 checking the D3 possibility
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-pci-bridge-d3-v4-1-f1dce1d1f648@linaro.org>
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
In-Reply-To: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, lukas@wunner.de, 
 mika.westerberg@linux.intel.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=a9jhEQgepLFu1V/9oFFkAbVrqrZxzbztMATHDJFc3OU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmAqgUbSOKJVFNG5vo+m1rTB5ZtU8V4c/GTGvtz
 SRWC0jHPCGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZgKoFAAKCRBVnxHm/pHO
 9X8aB/4mHeDmAABHwdZVT2KCy3Oi2k8U3Euk7a/eKi2F/KDGkvTB2juxg6mHFSYM6GAAuFUEMqv
 H1bqB0ctCMAnm5M9Ic8ML+rjdYiCCs9iX4FoXtSkqIyMg/Ggvcugfyq0z7cSSmSSVchACmFV1zN
 CxqohHwRG9XlbS9KWYTXkDRs77JklCpTdk4Yb4wTD8sxVCevT9xo0dNymysXSEwDVr8c7oNTTX3
 EVeeOnwqSgTgtNxsxVLVRlme4T+xTuZVYT9IXPrPtq0KWXk29YZZ3RvD8R96F3tVWLjByX3oFh9
 fmHw26ZXd7Fl0Ca0GWeUwfyszN1gouLii9fer4v1Hb2tPDra
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

PCI core is already caching the value of pci_bridge_d3_possible() in
pci_dev::bridge_d3 during pci_pm_init(). Since the value is not going to
change, let's make use of the cached value.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/pcie/portdrv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 14a4b89a3b83..1f02e5d7b2e9 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -702,7 +702,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
 					   DPM_FLAG_SMART_SUSPEND);
 
-	if (pci_bridge_d3_possible(dev)) {
+	if (dev->bridge_d3) {
 		/*
 		 * Keep the port resumed 100ms to make sure things like
 		 * config space accesses from userspace (lspci) will not
@@ -720,7 +720,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 
 static void pcie_portdrv_remove(struct pci_dev *dev)
 {
-	if (pci_bridge_d3_possible(dev)) {
+	if (dev->bridge_d3) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_dont_use_autosuspend(&dev->dev);
@@ -733,7 +733,7 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 
 static void pcie_portdrv_shutdown(struct pci_dev *dev)
 {
-	if (pci_bridge_d3_possible(dev)) {
+	if (dev->bridge_d3) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_dont_use_autosuspend(&dev->dev);

-- 
2.25.1


