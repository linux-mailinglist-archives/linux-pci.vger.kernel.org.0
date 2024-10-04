Return-Path: <linux-pci+bounces-13832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2FF99093F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 18:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3CD9B23AD9
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 16:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9826513CF86;
	Fri,  4 Oct 2024 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="N5MAvhXP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF211C8782
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059315; cv=none; b=KAtpH70+Sx9CmYNjIhvzw0kT9RtuM+HQYizNJseZrmPkcNrQRTjFm97MJ0s8yvk4OEejm4reyaoDob9bEf6CL3k31xFkp+sFEyRg0Svwd0EkrsHMw+eKm3v4Vn0f6EPI+LJy7ulRrAbXXABOI0p6zKXnBtZl1Wga4s7gS1Ezh/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059315; c=relaxed/simple;
	bh=l7+/OOnbPo59NRdHU4hf39heIHqnVwgUybEyl/BT7zY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nkp5PTSNe1XwPtb9lPyhgrBmtIphMWRqUEYpzoaTHgY7zLvgFD0Y1DbmEraVd+coA8R/F+w5pzKEyKssCGLkPpdfI1qt8H43d86bO82/gNYzRD1Y4nsmw5uPt/yFLmp+WmD2h2QyA2rg2ANYBFWuRRi/U28LviR0+Tae3Zj4ZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=N5MAvhXP; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cb97afcec9so11479996d6.2
        for <linux-pci@vger.kernel.org>; Fri, 04 Oct 2024 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728059312; x=1728664112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g9cpx8Hyi6dy6qO2dUhiRIRpdrteVAK0AMuAZrMnAe0=;
        b=N5MAvhXPocpXL+3MRnLl6U8seb48TXhzIBXVAGF6Z5WylKzfg0PGkMinuwXG8cdnS/
         raQH7qudNAX3v1B/9Qy3c5Hzk1i75y3HHgpVLDnNWTzg9pKA9hI91i9zbS8fkvBRzbhL
         yDmknpHxL8IoHp+fne7pCvc5KTG7wzoc234m6tS2ePyNmurrsfezA97BnnePodjMbDWY
         FXAPzWSJx+qYyc2kLa/btg7cqB4xWXJuLy6/a2AXezMquOZah862dfX8qAHQ8YRHztEU
         MHoIpaiotQi/NjTH3AnQxWKN+5riQplWeni+ontCtxV05YncNV4ObPO8IopM6J3olyTJ
         I2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728059312; x=1728664112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9cpx8Hyi6dy6qO2dUhiRIRpdrteVAK0AMuAZrMnAe0=;
        b=sxxXwGOyYYk1YMEFbGcp0P4Kq+oWuWRM+LrFlfo4xid3IQSfhnzBxpxXGnxQXV7qOO
         C0y6L8d5IlK3jVRHeU8L9hDmCRiz08CGt+hImX9Kf0DvyahktXrSBZRdIV73eGY0Odb4
         /6HVdO6AfeIezoBCxbS+FFuCwGoIbLLt1njn2xyjed3OfmYrTOPGzZT7MsfHZyLnybgz
         RgBOCqPweROlhFnPqfksE0UBVfd6IaU4dGMb9ueUpbwgPNmFD4gmWYzX465Vqsj6oRha
         xTCc9MMxqsMvgF+216DTWdtkQsqIB8libB5gIr0PwX0kLq1xQooY8B11dYy0/Ifdjwuh
         UDoQ==
X-Gm-Message-State: AOJu0Yxv5wGMOpR6M8Wrco+/n6CSG1iu1s1y51x3NpQnhtfUREtJelBF
	vQU0+BJ8tziAQV8pug9XSMyUFdTX2pocXZqSlCLmD/Aj2Ubn7Pd3/TsFDxUnLt/z3hrON2vVC8A
	P
X-Google-Smtp-Source: AGHT+IHCGTgu+cqiGiiZGFp3IkE06rob+xgV+iZNNZ8TyR776du/mFsmvAe7H6wEvrhSrVYdAin9FQ==
X-Received: by 2002:a05:6214:5504:b0:6cb:4a84:e02a with SMTP id 6a1803df08f44-6cb9a32d338mr50523826d6.16.1728059312390;
        Fri, 04 Oct 2024 09:28:32 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba4751920sm573476d6.98.2024.10.04.09.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 09:28:31 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-pci@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	dan.j.williams@intel.com,
	bhelgaas@google.com,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	vishal.l.verma@intel.com,
	Jonathan.Cameron@Huawei.com
Subject: [PATCH] PCI/DOE: Poll DOE Busy bit for up to 1 second in pci_doe_send_req
Date: Fri,  4 Oct 2024 12:28:28 -0400
Message-ID: <20241004162828.314-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During initial device probe, the PCI DOE busy bit for some CXL
devices may be left set for a longer period than expected by the
current driver logic. Despite local comments stating DOE Busy is
unlikely to be detected, it appears commonly specifically during
boot when CXL devices are being probed.

This was observed on a single socket AMD platform with 2 CXL memory
expanders attached to the single socket. It was not the case that
concurrent accesses were being made, as validated by monitoring
mailbox commands on the device side.

This behavior has been observed with multiple CXL memory expanders
from different vendors - so it appears unrelated to the model.

In all observed tests, only a small period of the retry window is
actually used - typically only a handful of loop iterations.

Polling on the PCI DOE Busy Bit for (at max) one PCI DOE timeout
interval (1 second), resolves this issues cleanly.

Per PCIe r6.2 sec 6.30.3, the DOE Busy Bit being cleared does not
raise an interrupt, so polling is the best option in this scenario.

Subsqeuent code in doe_statemachine_work and abort paths also wait
for up to 1 PCI DOE timeout interval, so this order of (potential)
additional delay is presumed acceptable.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/pci/doe.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 652d63df9d22..27ba5d281384 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -149,14 +149,26 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
 	size_t length, remainder;
 	u32 val;
 	int i;
+	unsigned long timeout_jiffies;
 
 	/*
 	 * Check the DOE busy bit is not set. If it is set, this could indicate
 	 * someone other than Linux (e.g. firmware) is using the mailbox. Note
 	 * it is expected that firmware and OS will negotiate access rights via
 	 * an, as yet to be defined, method.
+	 *
+	 * Wait up to one PCI_DOE_TIMEOUT period to allow the prior command to
+	 * finish. Otherwise, simply error out as unable to field the request.
+	 *
+	 * PCIe r6.2 sec 6.30.3 states no interrupt is raised when the DOE Busy
+	 * bit is cleared, so polling here is our best option for the moment.
 	 */
-	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
+	timeout_jiffies = jiffies + PCI_DOE_TIMEOUT;
+	do {
+		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
+	} while (FIELD_GET(PCI_DOE_STATUS_BUSY, val) &&
+		 !time_after(jiffies, timeout_jiffies));
+
 	if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
 		return -EBUSY;
 
-- 
2.43.0


