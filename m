Return-Path: <linux-pci+bounces-11370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BDD94958C
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 18:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B981C20A5F
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 16:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1713C374C4;
	Tue,  6 Aug 2024 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVYCm/LT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E72CCB4;
	Tue,  6 Aug 2024 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722961706; cv=none; b=nqnvFxfG2+BhNe46uDjRaTSzbXp8X+Hx7NlxavegAKz7Mraizmm2HfL9bMV4yksF7+hE9DEwg6zJ6ieFexbTokzeWSyqH5RiVjinvijrDWmyN2yftFM77RRHbdZ2TL6ODVABndIT1J9tqIj2X0T7GN7tcWVv06SCaZ2OlpPBtx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722961706; c=relaxed/simple;
	bh=lNwXFzw6rXHjh59F/clEqJiNam3fyU0stzGKBxt4tIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FMoVITypFvWPyoJrWxUwW3alYREacbkFyNQL95ozrcp7hG/iPiJXF1kkY560xapQMEwp/rSZnjGdCSBbwtSdqwVlJuWySeOk5cZOoNDiS98MrP9+CyMxBkrZglgfLb3VdjPii9cr991BBvnGQsKnlVdWJoLmDTdoyDHVHrink/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVYCm/LT; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bb8e62575eso459875a12.3;
        Tue, 06 Aug 2024 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722961703; x=1723566503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g/6yrgEwn32jXWvBVoyYSEtZBWivUFa8PwNf1HDHQmU=;
        b=XVYCm/LTdLzzwkTv3x/YZRFESZlLp5Y402Pz/nH9DUlSGQFd5UdRgHWoMafLAKplWk
         j8jxyjp/MZo5rXpsAUG/RPBk6rEDd/05fzyTXmDNlfNFL4p9/LzzqMGMW8cvOkqKJ6ce
         ukFbN8zRLrci2SpB8kSBedqkNhDLHhYMmHO/McZV/MrfblYIMZXUxskJu/qbDuKOnY3Z
         DBv2fuBo0rOYfkEh9CGzTTQ+Br6TYDvrDdW2h/xR3bEGRsEqqWIIiM5RZZkGs/Oq8GbN
         P4MBNVIo8wTmxS3F98pYjPx6Z47hRnrMt1Ypjw9zYuHl4IOZ+vSVDqnWEZODLkXBcRH8
         ZA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722961703; x=1723566503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/6yrgEwn32jXWvBVoyYSEtZBWivUFa8PwNf1HDHQmU=;
        b=eERVUld5xW7ry0cfpOZ/Lc2gpyjIBqK5essD2R/M33Hsp5md1e6atx+j9liQ7JWLf5
         t5xCEuEV8rdTNp5UoY7MliT+ub6TIyC2xWJrvGqJA54h9SbWOPV1+ZevuzJE7TrE/Sp4
         kjahDXtKhVkqZBu4BR77XkMZTBvDzh338NCWqND0X04jFbl65ZOGJNc9ZsO/HXb/y2/o
         vX0aCJtJplig/ukOZp+Fgnts0nnNez+8exr+VWviXMwAxUANBE4jj0UgAQQhQ/tD40ff
         hn27+jcPes3vhvjgO+p2DAZ3WONbIDhUNR49eU15lV9zUbbTexK8c2THbYeeogWnHK/2
         UawQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6r59EcpL1LXtBW62QvDiWyj6JeRTBNQUoA9MA/vpvf6jSgK+OEBwpN01bBqSsZ37MNbTn5injy1+qi4VNg8MxnQwKlF7mcFdavmgXNwubyJy1xfHib4NrppjDG0beIcb0cLCBaQM9
X-Gm-Message-State: AOJu0Yy/M9wr3WdgxohT9/o7x0YaMiDfE4qx9jzvmFRgu1/QL5fe6t0+
	B1vHoQ2eAt+o1eCy3xd2WF5QKGr9K+BRi8xc6dt0WAFv56kEZpin
X-Google-Smtp-Source: AGHT+IF8ZqLyZQuNbSf9g3L4mn6QEJNHmDrcPalxM7jTc6RG4XgFIlFyQQgHJDPMeYr2dQirRsdlOQ==
X-Received: by 2002:a05:6402:1244:b0:5a4:5df5:12ed with SMTP id 4fb4d7f45d1cf-5b7f5129455mr14266577a12.29.1722961702182;
        Tue, 06 Aug 2024 09:28:22 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839c2d2e2sm6047792a12.40.2024.08.06.09.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 09:28:21 -0700 (PDT)
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
Subject: [PATCH] PCI: endpoint: pci-epf-test: Move DMA check into read/write/copy functions
Date: Tue,  6 Aug 2024 18:27:54 +0200
Message-Id: <20240806162756.607002-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test for a DMA transfer was done in pci_epf_test_cmd_handler, which
if not supported would lead to the endpoint function just printing an
error message and waiting for further commands. This would leave the
host side PCI driver waiting for an interrupt because the call to
pci_epf_test_raise_irq is skipped. The host side driver
drivers/misc/pci_endpoint_test.c would hang indefinitely when sending
a transfer request with DMA if the endpoint does not support it.
This is because wait_for_completion() is used in the host side driver.

Move the DMA check into the read/write/copy functions so that they
report a transfer (IO) error so that pci_epf_test_raise_irq() is
called when a transfer with DMA is requested, even if unsupported.

The host side driver will still report an error on transfer thanks
to the checksum, because no data was moved, but will not hang anymore
waiting for an interrupt that will never arrive.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 29 +++++++++++++++----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7c2ed6eae53a..bd4b37f46f41 100644
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
+		dev_err(&epf_test->epf->dev, "Cannot transfer data using DMA\n");
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


