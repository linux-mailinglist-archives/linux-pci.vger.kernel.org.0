Return-Path: <linux-pci+bounces-27423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3332AAF459
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 09:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD68D1BA8525
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 07:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D692220686;
	Thu,  8 May 2025 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PqyVD8QR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1214921D3C0
	for <linux-pci@vger.kernel.org>; Thu,  8 May 2025 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746688240; cv=none; b=jTWPvA4lu1QOZkGk8UeA/uVp4DxCJjARY4vefpqUz4TWuK6mQH9ouy0RmhhdxU4toP7mvxK42ZBBiOTLqRhgd4+sQP2z8XuW2nbhA20g6R2yUAAJ31vKxgRCht6pKa7rM6kZauhNC02pmd0s6vh+RGO/V9XRfPBCN4RAP/oK2yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746688240; c=relaxed/simple;
	bh=Aq+BoDTRwjfmiHKRLtODTEbwNFS8yDdFMEIJ4A/Pkz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wim33uNkgxEnXOQmhIN86xLbPhh9QRNnT9h/+G2LQJe5tjJciST+6LwPoKAe/7bk0MZYxRCywvbkJnFYXLzkOmXkvoAqS3bHxTcJKOWuSbPgxdtIDI1Q7MPcm+2HWRUG7k3UUhGU7plFVF2OVTFWUCrESSRI5hVrixspU/darJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PqyVD8QR; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so5734455e9.2
        for <linux-pci@vger.kernel.org>; Thu, 08 May 2025 00:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746688236; x=1747293036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNdUV80pt9dTQBN0xsYhQhCQV2pGwrGMIFKsn4D5UWo=;
        b=PqyVD8QREBiMqctqAfCiJh+9kTLyraCDuRzdJpTikutPhuoITo221B0JbN1KjRTyft
         VMUgg8MsyXFxONe9uQKfx34qpJ+kNAXgupnUE25QhsXZoZQM0PRA2/CuTRhqdgBD6REM
         t32cRbPy3BAHI2fx2p6THm2NM7xx7wmN8vOjua2MpvvnfzbxAGttdlsIgKltIw7XCY9Q
         p/qMWVCYfES+S2IHsSiWt3gSU+PijHviU2dc3oZHgV6GrRZKG/WCuRyU12X9K/wmMKRc
         Ls9wfWITKwX61EZB10khBzcQJ3lU52QO5E9YzkxI4twe+6U3aTOSRGrKHAiLX3e6RKgz
         V+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746688236; x=1747293036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNdUV80pt9dTQBN0xsYhQhCQV2pGwrGMIFKsn4D5UWo=;
        b=gfjL3rKP9nLN/6h9dsF9c4V1t6eB72hk/q7J00ZyfbGG4nLVBdMFkCnvNydVrhiGw8
         ix+5D19tG4ppJPYOCh6WSUX0utO0UMW5j4OYQqw5Jnk653fhz4jawiKWd756Be4iHk5o
         IhArWTWsZK773rvIlVgXPI86qCXOHbndFxjw3WVDaRgygfM2C/4IiJ7pDzPzSXuiYbbC
         BH3/cyUk+dSLs0BZVLhYjecOJTmxl+Nfam1gsFaCkzHlp9PjTJSjiqbT7eaa07cdi1yn
         oSammsvb5QzAZKkhQZmQ1fIVwiYBB0GZTI1IRt+EYTRP7sGyq9k9K5S8xxGm7EBXrZKd
         pfKA==
X-Forwarded-Encrypted: i=1; AJvYcCVnkm91LBBB0RIJPRzsPl7e5J1cOd0owSq40qD5pfih/qVOcJJnqver3+vPfdyDpClkzEb477bG+7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6uWCDISGbdaUcaPV5iQoEPpNubQdP1Q0paS2UFO1K4GQnTMQI
	rsz+ULGT8VLoLEUpMro1424CZpIH7QJmzrdYC/czFFHQFnqRdRARIUMGcTojAQ==
X-Gm-Gg: ASbGncvr+orT9jetjJ5x/rmUNYaxS2EA5KWhEyCJpAvJ3H+nX2bU4k14WFu5S0me6SK
	0t1YrBuSYn27jAzUyCwEpwR5O6jdYP/Hu1JVOA5Y6oSssg2IA9vFd0duDtv+av3+R/Cr7lMPR8Q
	KrP3ouZG3CHYTftsA2YD13ds2f2PQAsAvzi9mmXmHd8y8IAuBezbxMYuLacx/Ukf4oqaieoeNs6
	7CvSFS4GoPnx42hcI1kqn7h7F4YrNP6GdY6kaQiobsJkXnB90OWQyz4EXGWmlQmHquIMAACV7P6
	+ShiGpUPxmRljVw+WBepoZiwYNFm4c+Gfcccifh1qg3wd5YppL5Ozi4XAX4vF8qdAWUK/SG46vH
	EG/ni+YbIlxcm8oYngxuCvaj0/zg=
X-Google-Smtp-Source: AGHT+IGM/ocJYvn2QOjf3fD6bkcOlBGcdKqEyGGwPgr1OkqArjdUzcdfSklA7LLxbWYmBJNriXe76Q==
X-Received: by 2002:a05:600c:37cd:b0:43c:f6b0:e807 with SMTP id 5b1f17b1804b1-442d034bcbamr21959325e9.31.1746688236376;
        Thu, 08 May 2025 00:10:36 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-69-61.cust.wifirst.net. [46.193.69.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b178absm19500236f8f.97.2025.05.08.00.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 00:10:35 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 08 May 2025 12:40:30 +0530
Subject: [PATCH v4 1/5] PCI/ERR: Remove misleading TODO regarding kernel
 panic
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-pcie-reset-slot-v4-1-7050093e2b50@linaro.org>
References: <20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org>
In-Reply-To: <20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>, 
 Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Marc Zyngier <maz@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>
Cc: dingwei@marvell.com, cassel@kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=789;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=Aq+BoDTRwjfmiHKRLtODTEbwNFS8yDdFMEIJ4A/Pkz4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBoHFjp3+Y0C7nYToqJfWiLXSkKAM5YKgVxrQcgv
 dew07ahS2+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaBxY6QAKCRBVnxHm/pHO
 9bheB/9ACtGdPZ3LmfihI48+MK1ALP0+Bx6+UetxxXKaahBYzIQ5gDCkxVfgOgnxWWQewlNuhzp
 LkZw3nCIYvdYAZ7/RT6FkDdBk4lRXh8t4QhrVlil8KmoN8umYdxyDDZutpu8RDRf9b5H84xabGV
 tt9QfWQz9sKtIRWtac2DBCJCM4vwuvtSDxEUlUvJkdec5PwCN8ffMmJBN3NQ+vSvJtmkY8CKX8o
 ZT1VVrEU3tuPcd3IaetbkOs7WBG2+W8B9TJkzU8p+4MnsQUmp41iy5Y6yO6mf3fDQ643DyRvmm+
 9X9+lTcKXgUsmH6hLBn6yhdJdN2ABj8XC+7vLejHvCUqYl4/
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

A PCI device is just another peripheral in a system. So failure to
recover it, must not result in a kernel panic. So remove the TODO which
is quite misleading.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/pcie/err.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31090770fffcc94e15ba6e89f649c6f84bfdf0d5..de6381c690f5c21f00021cdc7bde8d93a5c7db52 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -271,7 +271,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
 
-	/* TODO: Should kernel panic here? */
 	pci_info(bridge, "device recovery failed\n");
 
 	return status;

-- 
2.43.0


