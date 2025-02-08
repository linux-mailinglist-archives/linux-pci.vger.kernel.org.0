Return-Path: <linux-pci+bounces-21020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9EDA2D684
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 15:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9243A814D
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 14:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D0E1AF0BC;
	Sat,  8 Feb 2025 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNFDGzdu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18AB1DDE9;
	Sat,  8 Feb 2025 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739023289; cv=none; b=Bd7+1bQoqfPieE/MBCcUq9jCIt4N3GEsrDDhRv9G8TXKqBjG2+b50jLlgMel/Ket7QCDZ5UrdGM07dmDnOS/F7WnvxdWOtVz7SBEEHlOeFRgOpqyJ5EioVgNf/vBTrdOCylwQbtTBK/eKD1uoqvSk+nTPxN4gR1iMa3hfd9+jeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739023289; c=relaxed/simple;
	bh=dnme0i90eALZ1naFbu3KAXL141QXeax5ndsu+0TgDPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AKAXhHHj+BvqtPh83uh/CUVzLnSVDxnfThCcJSVQ0q/irHQ3slypN1idVs7hSSeaYhshJszvkmxClnm9LvAS8tW0I8IrapvPiQArN5eebneFfwyWtWfaYu2m11tgjjp97tdBlydD++WY3N2xuR4kfUrc32ZzmDtM+KOiXYQaroc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNFDGzdu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f710c17baso5142995ad.1;
        Sat, 08 Feb 2025 06:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739023287; x=1739628087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8vTZdMPLMSqXrnhxcnWbbB76ba6UXQT8qWGFRDWozPI=;
        b=cNFDGzduiAfeeto+6NmViDWE2WGRuAZ8RLy0t4oZUDa7fNWF644zaLmTrJqLlKoAMd
         zr3BN8LFIA2seedklBx0E32e9ECk6qPsvoulP3s9gZC9vLXDXatOE37187RcprJIu93p
         51aEpINQicW+35z1OSuMjiopTaakLoBl6v2LMFhHBnsVNwrivdNh2Tx2rYl2R/4CCDm1
         OvvSf/p3guho+MATfGiKfojYa3n8SV8KFB+DIhhaugb/Yb1thU7AcIf6vhXigb0a5THc
         gMYJ+pCSjVcpRBAaBN+NNYSMD7syCYkgwxJeOH4ZWh+aChi8EZCHI3aCFwWJ5eTDtsXs
         sRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739023287; x=1739628087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vTZdMPLMSqXrnhxcnWbbB76ba6UXQT8qWGFRDWozPI=;
        b=w5gkOI9SP0iJWyxX7dZMCuJm6grzfca2Dh+Iikduldf3dXYYc1Z31wFzEX3zUskK1s
         U3nAXszLylBdOGQqaJ5W12VbhX46EemFqbhV1YN7+CqhNXTHAoi6IQDBA52BTEBTHCJd
         H1vGMnQL3zRrGwqcW5kZ8XNRqo4DhImC42YKubBnHks72617B7BIOOmRE/dp0CaojuAk
         MgWvltPowqMcb2hmrtQROinDgi5wQ9CxAqofZ3fxL4ObcDoNQaU3a0g9lp1g6P4IbJpH
         gmVAnsJ4vJSOGZlVwOt4AN/K0ijgNbGZH5fUZIFDJdqtxlPgOlCWPyRt2jWQsGwK+eDx
         1e7w==
X-Forwarded-Encrypted: i=1; AJvYcCUiWfKCKXUrYVWCzFyq0Lyf/2zlqroYdrwfMoyPeT+NOi7g8o84iQSk0ilMzBp/R8WGOPrU10bYURmH@vger.kernel.org, AJvYcCUqYvZ6b5WM45lXGGVmamYeOtRuzv4paCZyhHTTyb1tM7OEXNDjGe1arIerKjHt330gys362AbkNoDPKlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxauGbq1Q/KVY3RqzrTEtht253dKBBVzeIPT/ABKu/3gZyW7UyE
	RpmalSoaMv4OF3UMt8e3X5zyFWSsDs0ElUWwuS68V+5JjM4qI33kx680vA==
X-Gm-Gg: ASbGncvcvzI5d4Z23phN5y7zH1oPNtIeD/bxMDehgdS1YmXcRRe2RmLvK3jhbYApuFf
	NaQqFprhZ8Xx5E7RjKAOvBHyvDOZw6s2s8FkMTKlAHSZM9ojqr8xXtMEkvGgdPNt1HwDaK9rzP/
	ThKjbSm+uo9cChXG+0ZwlvPPgnlDJOJOWIOSZC65mTa4m/qc/XDIVHVas5fv05AuqKEWG0H5VPi
	8awfoOBVYYk2HCPo9r99L3x7uqFBUeVrT+PO0anabMqi1kJPTt3tttstW+8pZlKHvnZo8Yro1nn
	yfXxxZ25DF1RvPG0ryRzOsrUEQjQlA==
X-Google-Smtp-Source: AGHT+IHOV0YjO8FrqIWkreeg9lltDRiF9MtKGpnQ6FydqiN+TMar2coLflk6oXPZZEYEe2H2CfYMxA==
X-Received: by 2002:a05:6a20:c896:b0:1ed:e7cc:ee7e with SMTP id adf61e73a8af0-1ee03b10078mr13675773637.32.1739023287016;
        Sat, 08 Feb 2025 06:01:27 -0800 (PST)
Received: from localhost.localdomain ([110.44.101.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730796ba9absm932063b3a.87.2025.02.08.06.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 06:01:26 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	linux-pci@vger.kernel.org (open list:PCIE DRIVER FOR STARFIVE JH71x0),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1] PCI: starfive: Fix kmemleak in StarFive PCIe driver's IRQ handling
Date: Sat,  8 Feb 2025 19:31:08 +0530
Message-ID: <20250208140110.2389-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kmemleak reported following debug log

$ sudo cat /sys/kernel/debug/kmemleak
unreferenced object 0xffffffd6c47c2600 (size 128):
  comm "kworker/u16:2", pid 38, jiffies 4294942263
  hex dump (first 32 bytes):
    cc 7c 5a 8d ff ff ff ff 40 b0 47 c8 d6 ff ff ff  .|Z.....@.G.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 4f07ff07):
    __create_object+0x2a/0xfc
    kmemleak_alloc+0x38/0x98
    __kmalloc_cache_noprof+0x296/0x444
    request_threaded_irq+0x168/0x284
    devm_request_threaded_irq+0xa8/0x13c
    plda_init_interrupts+0x46e/0x858
    plda_pcie_host_init+0x356/0x468
    starfive_pcie_probe+0x2f6/0x398
    platform_probe+0x106/0x150
    really_probe+0x30e/0x746
    __driver_probe_device+0x11c/0x2c2
    driver_probe_device+0x5e/0x316
    __device_attach_driver+0x296/0x3a4
    bus_for_each_drv+0x1d0/0x260
    __device_attach+0x1fa/0x2d6
    device_initial_probe+0x14/0x28
unreferenced object 0xffffffd6c47c2900 (size 128):
  comm "kworker/u16:2", pid 38, jiffies 4294942281

This patch addresses a kmemleak reported during StarFive PCIe driver
initialization. The leak was observed with kmemleak reporting
unreferenced objects related to IRQ handling. The backtrace pointed
to the `request_threaded_irq` and related functions within the
`plda_init_interrupts` path, indicating that some allocated memory
related to IRQs was not being properly freed.

The issue was that while the driver requested IRQs, it wasn't
correctly handling the lifecycle of the associated resources.
This patch introduces an event IRQ handler and the necessary
infrastructure to manage these IRQs, preventing the memory leak.

Fixes: 647690479660 ("PCI: microchip: Add request_event_irq() callback function")
Cc: Minda Chen <minda.chen@starfivetech.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/plda/pcie-starfive.c | 39 +++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index e73c1b7bc8ef..a57177a8be8a 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -381,7 +381,46 @@ static const struct plda_pcie_host_ops sf_host_ops = {
 	.host_deinit = starfive_pcie_host_deinit,
 };
 
+/* IRQ handler for PCIe events */
+static irqreturn_t starfive_event_handler(int irq, void *dev_id)
+{
+	struct plda_pcie_rp *port = dev_id;
+	struct irq_data *data;
+
+	/* Retrieve IRQ data */
+	data = irq_domain_get_irq_data(port->event_domain, irq);
+
+	if (data) {
+		dev_err_ratelimited(port->dev, "Event IRQ %ld triggered\n",
+				    data->hwirq);
+	} else {
+		dev_err_ratelimited(port->dev, "Invalid event IRQ %d\n", irq);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/* Request an IRQ for a specific event */
+static int starfive_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
+				      int event)
+{
+	int ret;
+
+	/* Request the IRQ and associate it with the handler */
+	ret = devm_request_irq(plda->dev, event_irq, starfive_event_handler,
+			       IRQF_SHARED, "starfivepcie", plda);
+
+	if (ret) {
+		dev_err(plda->dev, "Failed to request IRQ %d: %d\n", event_irq,
+			ret);
+		return ret;
+	}
+
+	return ret;
+}
+
 static const struct plda_event stf_pcie_event = {
+	.request_event_irq = starfive_request_event_irq,
 	.intx_event = EVENT_PM_MSI_INT_INTX,
 	.msi_event  = EVENT_PM_MSI_INT_MSI
 };

base-commit: bb066fe812d6fb3a9d01c073d9f1e2fd5a63403b
-- 
2.48.1


