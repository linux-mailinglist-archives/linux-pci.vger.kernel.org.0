Return-Path: <linux-pci+bounces-11807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711D7956A38
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 14:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7DB6B2388B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 12:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13C4165F17;
	Mon, 19 Aug 2024 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQTgy4zO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6EE13DBA0;
	Mon, 19 Aug 2024 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068896; cv=none; b=qyvQ+nQwZ81489UlrdVg+jY4uXCLRO63gaf+7rkFs03zuW2PCgTgJJerKW79/fwm97uL+ChUOrCGjXlDXOmtDFOgqgDXftD1cV7Iqw6I+ji6+CCFQjzYRF246lqYVe9DgeyulNBIxObMr2lg0K3F1Q9u8Ba7LTdYCLI1t93MR2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068896; c=relaxed/simple;
	bh=9FMe2E36njetavmaIaeBUbP3/ypPX2kaswZqmd1RdWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FRjXAnaJ+PeYMp0DxjOUHLwWlsIJbFP+w14wVLtEb+Ttao6OMuiq7WWcFiGHBGa0rubNegByIWovuirMMcCjITVBXteh71A0tDHSyg6PLpWKKH2lokncSY/YzlcEc0k7qf4ZFi2kfPvzkUeEDDC45aNKtdxiP7c8oKD3YgCw8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQTgy4zO; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso6425621a12.1;
        Mon, 19 Aug 2024 05:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724068893; x=1724673693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zqIJnZhOkzwlhHlFmquqUgF5P4b6JO1W6PZDA+8kgtI=;
        b=HQTgy4zOeyhr/6u+dQTvrFp61x4bKZRi1KUsJoJYav3xTWf41Ce3ZaddwtcxYijl5W
         zywmIymlOutxLcWk9mYVc9/afntpHBnNHL4H0O81H1uPJCekrlVhRJM+lCUO7GK/lfzo
         KYuh4VtmUTd56DQMsxSyVcsXs77yr2fGd0GFWCm8aagdSi2gRLCoWKRd8StNlnUAYV0G
         Nt6H1HxW537eLFPSrCk8UwWdZu+j4ck954m8m1xbLeHqYLaZ30YK56epbwfM2pag07T6
         I6THhQxbldY9K7UFQQaCtAYuP0xuEGwQekR0Y713X5EdnlTd4TPCd0smKLvqyniR5KRt
         62/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724068893; x=1724673693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zqIJnZhOkzwlhHlFmquqUgF5P4b6JO1W6PZDA+8kgtI=;
        b=UKoqzEJCNVBFyY25TF+XR+ydzwNS8PDUFVe1PAT5nOUp2vc9XGGgRTm9iGANvpDmtC
         dEzp6QcgQJyk54lIJ5T6WpAJx+tHTip0u9hX4deBPFm/PVbsMwqc+twckEfDJCqVpVOC
         K7RDarmAmK/29zxD7jPVjF9s/K0dxs1nr9YY0Ye+5wt6IePWr8/dVL8JYLv2baLYf0eJ
         jNcre4FZP5HEoprvT1bz8Xz5wtfyzfs9djp7K5aaDzNN8P/wGmEs/c9MyVpd4620ze3D
         vsiW89+PdCnWM2kWRrKUlJYAlF3Ep4bsSA9rLe8VINXj+Jpm0gUoUqlg6G5d32HnPo+m
         mSvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhBLaUdnpKADl8Liu6v/2ec2gccWsmGuOi+v2uXN2NGbbs4RL9YdUFLwJ+TK31jJMGNdH/U5Ct+rb5QGMIXr2fY/qo5gewX0GDCUwO7aYQOOFMu+ddp3NZ8Ne1xFPHz9PL3VkVONyk
X-Gm-Message-State: AOJu0Yyt6kqHBki8+IFajMPrn4fA7hH06pLu6wXpPUa8X8n0NcEvANI9
	cAaYVDZ0oQesJ7QYL/irK8OGccdYnr4JZnQHBlV0nYsDZZHh2DP8
X-Google-Smtp-Source: AGHT+IHctpArOY8ZZmCUzbJXS5jZn+B9sz/9xRjEY8w0f1US2wIXF4pzMZ9gF8s2dGf/17SJpsbTKg==
X-Received: by 2002:a17:907:96a4:b0:a83:7ecb:1d1f with SMTP id a640c23a62f3a-a8392a03bc1mr738483066b.46.1724068892325;
        Mon, 19 Aug 2024 05:01:32 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6777sm634559366b.10.2024.08.19.05.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:01:31 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: rick.wertenbroek@heig-vd.ch
Cc: dlemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: endpoint: pci-epf-test: Move DMA check into read/write/copy functions
Date: Mon, 19 Aug 2024 14:01:10 +0200
Message-Id: <20240819120112.23563-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pci-epf-test PCI endpoint function /drivers/pci/endpoint/function/pci-epf_test.c
is meant to be used in a PCI endpoint device inside a host computer with
the host side driver: /drivers/misc/pci_endpoint_test.c.

The host side driver can request read/write/copy transactions from the
endpoint function and expects an IRQ from the endpoint function once
the read/write/copy transaction is finished. These can be issued with or
without DMA enabled. If the host side driver requests a read/write/copy
transaction with DMA enabled and the endpoint function does not support
DMA, the endpoint would only print an error message and wait for further
commands without sending an IRQ because pci_epf_test_raise_irq() is
skipped in pci_epf_test_cmd_handler(). This results in the host side
driver hanging indefinitely waiting for the IRQ.

Move the DMA check into the pci_epf_test_read()/write()/copy() functions
so that they report a transfer (IO) error and that pci_epf_test_raise_irq()
is called when a transfer with DMA is requested, even if unsupported.

The host side driver will no longer hang but report an error on transfer
(printing "NOT OKAY") thanks to the checksum because no data was moved.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 29 +++++++++++++++----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7c2ed6eae53a..ec0f79383521 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -314,6 +314,17 @@ static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
 		 (u64)ts.tv_sec, (u32)ts.tv_nsec, rate);
 }
 
+static int pci_epf_test_check_dma(struct pci_epf_test *epf_test,
+				   struct pci_epf_test_reg *reg)
+{
+	if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
+	    !epf_test->dma_supported) {
+		dev_err(&epf_test->epf->dev, "DMA transfer not supported\n");
+		return -EIO;
+	}
+	return 0;
+}
+
 static void pci_epf_test_copy(struct pci_epf_test *epf_test,
 			      struct pci_epf_test_reg *reg)
 {
@@ -327,6 +338,10 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
 
+	ret = pci_epf_test_check_dma(epf_test, reg);
+	if (ret)
+		goto err;
+
 	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
 	if (!src_addr) {
 		dev_err(dev, "Failed to allocate source address\n");
@@ -423,6 +438,10 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
 	struct pci_epc *epc = epf->epc;
 	struct device *dma_dev = epf->epc->dev.parent;
 
+	ret = pci_epf_test_check_dma(epf_test, reg);
+	if (ret)
+		goto err;
+
 	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
 	if (!src_addr) {
 		dev_err(dev, "Failed to allocate address\n");
@@ -507,6 +526,10 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
 	struct pci_epc *epc = epf->epc;
 	struct device *dma_dev = epf->epc->dev.parent;
 
+	ret = pci_epf_test_check_dma(epf_test, reg);
+	if (ret)
+		goto err;
+
 	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
 	if (!dst_addr) {
 		dev_err(dev, "Failed to allocate address\n");
@@ -647,12 +670,6 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 	WRITE_ONCE(reg->command, 0);
 	WRITE_ONCE(reg->status, 0);
 
-	if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
-	    !epf_test->dma_supported) {
-		dev_err(dev, "Cannot transfer data using DMA\n");
-		goto reset_handler;
-	}
-
 	if (reg->irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Failed to detect IRQ type\n");
 		goto reset_handler;
-- 
2.25.1


