Return-Path: <linux-pci+bounces-19959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E612A13B2A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 14:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4841659A7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 13:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5E322A7F8;
	Thu, 16 Jan 2025 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tHgIXJ+R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657F122ACD2
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035485; cv=none; b=f2gG46MmOBXxIGmz4yDNasoti1H1nZ2Usu93qllJbpIDQWQvtbJh7n1vY1XPJfutclV7mUG29QqDquTlFs+NuhQrxWTgylDJxE3RNLCat7r3IIDu6ByFnOE5iatX9QdoB2vfwf4nbI8swfIYi/2PdoIW/IMl+zzbxDOxEPsaPBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035485; c=relaxed/simple;
	bh=4uuXXMls8114LWh45Vhuuj5GpluyhflqvtpAwRLCiZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bgi93NoieCedOz01TImoYEErFvCUg9+IzgbU5BDb2aDtJTIEZboPeSVYi5Ax0otACqhh612njouqjYAXdAaAtchHEqlDbm1vN4to8Fy7wBQUC7XkCFU1p+k0NmZkrvCouY11o//HuhZa5gpG3Xntz7u6/6pzexFSFDlBibWPKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tHgIXJ+R; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso1335861a91.0
        for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 05:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737035483; x=1737640283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuraTNV/U058me9OXCx94wz8W+2D2JAwEjqocWrvvU4=;
        b=tHgIXJ+RhgWyKWeULH9vC47wnwv+66RYejsTNU2TQYn6YulkcMg4FRaHz1ALBidFz6
         8AVSJBLHxe5oamim63jjGTHcfHcVCKyTSpwzjPJkKpDOEMnsHQ2Kle1Xy5Zqush55fjH
         j6mkm2vvGlOfJGT72ur9oVm4iyNNfd2SgFhoLBHQ63c5tGtI90Iptv4jgeHCMlPtIRqB
         qu98fKnvu5W3uZhRVUeS/Gyt/o7zIF15cbC0YvTGyC/gfMlLum/6bzMO0BtaeLCKkaoJ
         EIbBTolFLLba30SenWzfHYQ4DIWv1HCDeQ+WjjGUytO8sRHLw/c1EA8u/X0C9iWXn4cQ
         /X5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737035483; x=1737640283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuraTNV/U058me9OXCx94wz8W+2D2JAwEjqocWrvvU4=;
        b=u6HvJv7ybt1QhaJ1sTyEqWGRpmDaeK1Cfa6zGzCVOmqEsl76syhvdoSMk+FlQMXq0R
         ZifSmqa/T79BUN56dVgxw9DGnMxaIMmV8Z2OYosUaa82X7ewvTtTOGNvpy+1LH2zWZon
         aEJma9umQp8fBi3/0KGmHjUzKKaU4sGzXLSJClBRjymrRAwwvNliFtgmrVyAHZHKxImn
         ykAcRFNW0NfhArxirqOH4grlkJG2d3IAXp/XVD1GiKMrp3U5n0G1bbLSTA54ptKzGU/B
         irZZjy29nlAoFPqIvEe+MVJRI/zPQGrwuQbkK26rB64yn/1Cxeahr/06ynRzHGZ0OVq2
         kK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+2aDPyjSpp7daiS5+7MTiRj+LBiEFIH9XF/X3gwtoutsDlUWszrhxHQXi2aEk44GQZFuZh2bgo6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQxpUT/OMngUZN+gaNg97lwwOck74LepMMILETlyfaRdh2deg
	pcZA/zcF4efa34Q72o21J2Td/qKDlMLBTbvmJOjWA3my8K3GlvSZYl5xyC801Q==
X-Gm-Gg: ASbGnctnuBLhT1meafK6ZVaadAvtrDQAHtypQgI6jPu6NgvnkM8xjCJzJSFHJh865tG
	jKHEaL8rweyqZ6PM7/vvkcdYxdNNe70rHhVoh2TsCt5sDTIT8QMZ6MR2KzlUZqQVy9A/DYkrbVk
	3gfNS7A98vXEMZwV9NR5jMRsLTwHbjZ2iYjv+Bh83yYIR7jTjyYx1pKnrtHp/xlK5cuxMYOwulO
	2zQrQlFYcws8KoXdHh/wNhTPE922KKtVKzd+rKfi5n3xLP3hZ5w+rJa0XIUekO2GzvVY1MJY0ft
	2iR6lXx/
X-Google-Smtp-Source: AGHT+IHmaGQZNbO8JtgXuwbUObwC7YFWTkj6AMiRO/klNtQ/UWZdvAYSXN4Noy4pr3wn0/p+IsYVIQ==
X-Received: by 2002:a17:90b:520e:b0:2ef:67c2:4030 with SMTP id 98e67ed59e1d1-2f548f4ea90mr45589561a91.27.1737035482828;
        Thu, 16 Jan 2025 05:51:22 -0800 (PST)
Received: from localhost.localdomain ([120.60.79.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c1cba9csm3341229a91.24.2025.01.16.05.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 05:51:22 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kw@linux.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	lpieralisi@kernel.org,
	shuah@kernel.org
Cc: kishon@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org,
	robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	cassel@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 1/4] PCI: endpoint: pci-epf-test: Fix the check for DMA MEMCPY test
Date: Thu, 16 Jan 2025 19:21:03 +0530
Message-Id: <20250116135106.19143-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116135106.19143-1-manivannan.sadhasivam@linaro.org>
References: <20250116135106.19143-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if DMA MEMCPY test is requested by the host, and if the endpoint
DMA controller supports DMA_PRIVATE, the test will fail. This is not
correct since there is no check for DMA_MEMCPY capability and the DMA
controller can support both DMA_PRIVATE and DMA_MEMCPY.

So fix the check and also reword the error message.

Reported-by: Niklas Cassel <cassel@kernel.org>
Closes: https://lore.kernel.org/linux-pci/Z3QtEihbiKIGogWA@ryzen
Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ffb534a8e50a..b94e205ae10b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -331,8 +331,8 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
 	void *copy_buf = NULL, *buf;
 
 	if (reg->flags & FLAG_USE_DMA) {
-		if (epf_test->dma_private) {
-			dev_err(dev, "Cannot transfer data using DMA\n");
+		if (!dma_has_cap(DMA_MEMCPY, epf_test->dma_chan_tx->device->cap_mask)) {
+			dev_err(dev, "DMA controller doesn't support MEMCPY\n");
 			ret = -EINVAL;
 			goto set_status;
 		}
-- 
2.25.1


