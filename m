Return-Path: <linux-pci+bounces-23891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39673A636B6
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 18:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7846416E43E
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 17:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58FC1ADC8F;
	Sun, 16 Mar 2025 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAptBwQJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507EA1A23B8;
	Sun, 16 Mar 2025 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742145191; cv=none; b=L72wP88vI5UCgl44BeruWEm2GMJGCjCjz1OJoGfkep59+bnS9dQ1HFp1JO31dKjCwNeF6H0LcHnZ7O2TZ1+BEYTw4wY1T1ttsEFIbRanmZSreCI9cppw0FQjhYzwQ/ku7lSoE/jEhxL+HxYgb/Z1euZD76lvpHRNxdm8lgVX+Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742145191; c=relaxed/simple;
	bh=gZfG+mmR5ZOm4scj8+O7ZYzlO/+53iNpUXxBUO2Izm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n586lTlCHOI3WKxn5Mu16NMURHJdmHnCWOmC9AEZgwEhnYwr6xPx/k+xqEytObl9JwVgWWLf62ELIHxwZviidh2ohwpOulgpTA/4/b3bGkVepeoO/1GBTi9j8dWb+EdIquAxPDydumUfcD2JaJc8qIn5PiigEfdc++wVD25utYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAptBwQJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224100e9a5cso68164685ad.2;
        Sun, 16 Mar 2025 10:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742145189; x=1742749989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s6+LYeTuKw2K95gVdGQ9o8M/p/ryIaOOR0ecIS32DgA=;
        b=lAptBwQJCNAg0PWwz8Os2oxyp9ncmIr/Y1jc5uwQWVXClYilnUuzLXxLPR0dzoEWRf
         mF8cxXz7AmgJzlDP82cL+aL6TPhvoVQv2tpXIx3wToHKjs1ZDGAD8nR4iTQ8nE0JBwPH
         /afOGEaxloTYcK3lzCKTqQjCHh0Em1STMzRIH806NW7+dBIeRo4Ot37ZWKoVCOD+kP54
         nPrLia6P1ZwUMipGR4LdVcJ/Ru85ilxefO0yHKY7GCiWA0K2TJl1XX/45WsZGhZWGmh2
         q9PidTq2WE9jvr/Vnvyb8ScQx/CdFfr1UGtrB+Y98ZpLifk+r35h2L+woCBivNeB5F89
         ceYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742145189; x=1742749989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6+LYeTuKw2K95gVdGQ9o8M/p/ryIaOOR0ecIS32DgA=;
        b=QW2KAicvQsowh912oTruiXEZvpyXAk62Up3/Q6jatjAGGiKgO4KooNPa/Rvtvf4h8D
         snvWLduv4OCfO99GtTQNKQnHrFRLoZAh/sRhGyidohaRdfaVvfCCQDn22j8wtxsGf53q
         AkI6/scdIefwzCE9eTymvj7EaC2l/QFHMFWDpvON2NeaSQBoDhPOVs29DnPhkLVzOQA9
         VJExOGrWzRDGnXy8IkdL8eZe31coiiiZjHZRbRGnAuGwmZTr5HCRs7wQvzwC8FW002au
         HAxlCzdu+i7kNHFx03Zhe33RgjVCa54ZHz0bAQYqynkWGhqvGg3A7vnT1uK16vl7q098
         86lA==
X-Forwarded-Encrypted: i=1; AJvYcCUgsA9nvWm+l9XNGzEXN1lnQUzc6KP+x2yvWHIzu2mzriYkG+ySdJc955wVc/5hBVA7kUsKnhsbwkAQ@vger.kernel.org, AJvYcCWOUDJdgAtYElAts5yn58/sSYc8jPR6gwI8wXiU3x3Q+M8gpPqKxn/dg8StuqIDAGw0EXKTqqTD3c3UhgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYMmY89Tb7nP59cBiOI3Y7KVMfqasOoV/gziabIytSHHymHHsi
	0cBcHflZVFDN+JeaZoHM0R2xyFISIQjCXcr17jrw0dyDXP32/HwP
X-Gm-Gg: ASbGncsZ5Atw+E91nd3GnSKZejEwsG2by2ppcqkD2rFEY9ncXUnDBWDxyYiK8SiLpEi
	hqM17thM1wxq5pZmGL63IjY3qZyDEtj+AtEpCAoyNfWZc0c9uMhq+ZSFp+ElwuYtfJoxjastLXb
	FO08+RSCTCfi8M1Y+aqaS5KKywGdqSWwQj8BNxLxXs1W/Gl+slH6I48YCTL4+U0OORt5wx1fyQ0
	+R1Q9WNGdOBQHlFIO5EWb+hGnC6G8qN3ZruWcqbZgyrO3VVkZvi9dAFoWH0SvCVtRp/MVIZTAv5
	T9eGsLWHJcjObdxt2/fa6HFt+aQZgSfUeVo0UsX6wuNaQwlDI6c0yjicHn4=
X-Google-Smtp-Source: AGHT+IHN6IHHl4o2biDKthB8P90GW61u0ceqgL1egI/yJY3yeQWb57WuUSMeoFVKeGhHjZkeO30EJA==
X-Received: by 2002:a17:902:c949:b0:224:3c9:19ae with SMTP id d9443c01a7336-225e0af554dmr135710595ad.34.1742145189418;
        Sun, 16 Mar 2025 10:13:09 -0700 (PDT)
Received: from localhost.localdomain ([103.221.69.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4063sm60189635ad.65.2025.03.16.10.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 10:13:08 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Mason Huo <mason.huo@starfivetech.com>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR PLDA PCIE IP),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 1/2] PCI: plda: Remove unused IRQ handler and simplify IRQ request logic
Date: Sun, 16 Mar 2025 22:42:45 +0530
Message-ID: <20250316171250.5901-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The plda_event_handler() function has been removed since it only returned
IRQ_HANDLED without performing any processing. Additionally, the IRQ
request logic in plda_init_interrupts() has been streamlined by removing
the redundant devm_request_irq() call when the request_event_irq()
callback is not defined.

Change ensures that interrupts are requested exclusively through the
request_event_irq() callback when available, enhancing code clarity
and maintainability.

Changes help fix kmemleak reported following debug log.

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

Fixes: 4602c370bdf6 ("PCI: microchip: Move IRQ functions to pcie-plda-host.c")
Cc: Minda Chen <minda.chen@starfivetech.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v1: drop the dummy IRQ handler used in previous version
   [0] https://lore.kernel.org/linux-pci/20250224144155.omzrmls7hpjqw6yl@thinkpad/T/
---
 drivers/pci/controller/plda/pcie-plda-host.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index 4153214ca4103..f7edfa97723f8 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -280,11 +280,6 @@ static u32 plda_get_events(struct plda_pcie_rp *port)
 	return events;
 }
 
-static irqreturn_t plda_event_handler(int irq, void *dev_id)
-{
-	return IRQ_HANDLED;
-}
-
 static void plda_handle_event(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
@@ -452,16 +447,13 @@ int plda_init_interrupts(struct platform_device *pdev,
 			return -ENXIO;
 		}
 
-		if (event->request_event_irq)
+		if (event->request_event_irq) {
 			ret = event->request_event_irq(port, event_irq, i);
-		else
-			ret = devm_request_irq(dev, event_irq,
-					       plda_event_handler,
-					       0, NULL, port);
-
-		if (ret) {
-			dev_err(dev, "failed to request IRQ %d\n", event_irq);
-			return ret;
+			if (ret) {
+				dev_err(dev, "failed to request IRQ %d\n",
+					event_irq);
+				return ret;
+			}
 		}
 	}
 

base-commit: cb82ca153949c6204af793de24b18a04236e79fd
-- 
2.48.1


