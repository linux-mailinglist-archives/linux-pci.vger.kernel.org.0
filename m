Return-Path: <linux-pci+bounces-35618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9927AB47A76
	for <lists+linux-pci@lfdr.de>; Sun,  7 Sep 2025 12:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437A617239B
	for <lists+linux-pci@lfdr.de>; Sun,  7 Sep 2025 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CA821FF41;
	Sun,  7 Sep 2025 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Stv4cO8f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D263B219A67;
	Sun,  7 Sep 2025 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757240644; cv=none; b=RiS6lWzHOTsqn/8qL312ZUOo7ej5dJ3A627DRm/estJ7UhMeTxwxLz+N+TAAz3KfHwm0VID+80YSRLH0SzZrMSEc+HkcdvZpjH765+TfYw9kJ1/6P7Ew7VhHDuNiCpEfwppozdM3NZFOWlrs6rVya9DyyQts5mRDkhZFSt252iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757240644; c=relaxed/simple;
	bh=R4RtuzqEMcHFFycZq6vE34eomFBBUmArRGdvbys3T10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R9Hu71ivJ1ba94Z0Ajx9pAfQnZvYcHu9/u7zMl2hxqc5hl84/jSJVfKxqivLUcH4h1VAkt2E64ExQs3FTm5lEgnWkZVluC3cAs3uy/7WSo4RShkH/mRC0ML6TWLN37QD1JHNvxPWAZBv25Q9XEzpc/PEvRxI9EB0mREgq7ozOxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Stv4cO8f; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so29528045e9.1;
        Sun, 07 Sep 2025 03:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757240641; x=1757845441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=heEi416LkX8py4ejS5ZQNBKZJw/dtjDhd+4HdFbuaRE=;
        b=Stv4cO8fBJRkhUn8xb2zQYQtt/33C/iTFZKv1W2yAsAwKjVS70AP2cWH8Y7CrdxwsD
         U2+QU/YSMlvlKSsRVUXcOXwysctG+CAIJPzJMrZCsKxHZANgOL+PBbM+43zXAQRsTCOM
         pXix6l17VyM3HoK02kIVL26IABfPRNQ5bDq4ZxTGorEO/vfoPQlip1jlAN4Lmn1AXCxl
         uHrF+oW21mwV8CSaaPbNadtmUYWcuotTQgvmX1Pxea0Hp3rARzq4CvxFcQIt5RNsSLfb
         uksu1O1CzqQyIbcma5cbrJ7tvwoi4i3LHd931y84Zt7PwXV1wj3IgQJzL+XSLM1ALvSr
         iDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757240641; x=1757845441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=heEi416LkX8py4ejS5ZQNBKZJw/dtjDhd+4HdFbuaRE=;
        b=anw0sb5vRpcXZmBh9QGe/cXYj6ZUVB2E5fJjng31sXJxSodtgp3M2kxtHt9BI+lRnV
         EDJQffOW4/fWqkZYc59VTzfTNYjNJkGls4KIMk2ulSUkS1oWUxEUAT8IhjJ2J6AmMjx+
         D3hku2C34F2sB6ZpD3YXh87YNQe0A59kJl76IJTFQnR9EZ2foEhTZGZreG1Ff2B1vSRu
         uwtIi1EGQ9LS9cYWIj2S4hqyez0wE/o0MRj5UkaRqIMyKu8z8i2ll7QRcCG1PsZFeM5I
         yQvC05Mhh1M3grxORKK9s1olzZ3DMRokGc03+9xmSW2baxSeZaHhgjdvBdtiCdOmhsAQ
         Numg==
X-Forwarded-Encrypted: i=1; AJvYcCUjL0S/0Sr7QqQGjzfc+ZrIeMHsdYpz1LfAkFvC7svEaUIcLtT9sIzlIRhCsOGaWddoa4ql+kZx8nOS@vger.kernel.org, AJvYcCVjakEt26z6xShs5ULuetTBCvzGiSyuhyggDXG79gWUVDtGrxvTXA5YP4SHHkQOzCMp+GGJg9U2wXZvzMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0u7VRxUPbPuo+Mrei+5QD2Gn37PD0LVVuZufOQcLI0q/tTtby
	kh37LMbfdUvnTogjkk9sc+QyoATixBsrjzjZV6xmTSfQnQMrnB/Q2jf+
X-Gm-Gg: ASbGncsw7al5lMKj5LIt26+mN+ZYyVtYOxvTExwdK0YW+YSOTTMiiLYtYhaWRUV9gMW
	cBsK+nev2WsSjixGz4nDDFrMbkpJNS404NSozZ/IvtSs+n7nRWDB7ah/hM7T4MkKA+kEQCTfZND
	v6zqtW/XyOhA3pv0SwGkj9k/BXt+Z7EqhQfNr0s0CC4eP/sMSv7diW6Obc0ygSQx6qzjgXiWGKl
	tnLXub7Y7w2jcMlWWDh0pS5R5HUGMJQ5D4GwFqXicFoGN1q+hL7CTquSWJiAT/k5V9TTMu4Ro2p
	Z+8J24F9j/KeoJQGshqpFTO+uwRY69hXenddujWerOD9WWUfOpnw1GRX7wfZXDFgsajJwN4/pyx
	RVFmIP9zv23dGGdqFFbAMe4yilyoNTAP+4R/mOQ==
X-Google-Smtp-Source: AGHT+IGAQugrVy2ibYrudSntWDB/4r6Xm95+Vcag6ocvEAnmm7jKzg6q+K6hmYLhYl6fHTFJ/LNoPw==
X-Received: by 2002:a05:6000:4027:b0:3e7:42e5:63dd with SMTP id ffacd0b85a97d-3e742e56a53mr1926383f8f.56.1757240640977;
        Sun, 07 Sep 2025 03:24:00 -0700 (PDT)
Received: from mars ([2a02:168:6806:0:267e:37:6a88:3fc5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9dbfsm37655439f8f.43.2025.09.07.03.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 03:24:00 -0700 (PDT)
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jan Palus <jpalus@fastmail.com>
Subject: [PATCH v2] PCI: mvebu: Fix use of for_each_of_range() iterator
Date: Sun,  7 Sep 2025 12:21:46 +0200
Message-ID: <20250907102303.29735-1-klaus.kudielka@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blamed commit simplifies code, by using the for_each_of_range()
iterator. But it results in no pci devices being detected anymore on
Turris Omnia (and probably other mvebu targets).

Issue #1:

To determine range.flags, of_pci_range_parser_one() uses bus->get_flags(),
which resolves to of_bus_pci_get_flags(). That function already returns an
IORESOURCE bit field, and NOT the original flags from the "ranges"
resource.

Then mvebu_get_tgt_attr() attempts the very same conversion again.
But this is a misinterpretation of range.flags.

Remove the misinterpretation of range.flags in mvebu_get_tgt_attr(),
to restore the intended behavior.

Issue #2:

The driver needs target and attributes, which are encoded in the raw
address values of the "/soc/pcie/ranges" resource. According to
of_pci_range_parser_one(), the raw values are stored in range.bus_addr
and range.parent_bus_addr, respectively. range.cpu_addr is a translated
version of range.parent_bus_addr, and not relevant here.

Use the correct range structure member, to extract target and attributes.
This restores the intended behavior.

Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
Fixes: 5da3d94a23c6 ("PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"")
Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Closes: https://lore.kernel.org/r/20250820184603.GA633069@bhelgaas/
Reported-by: Jan Palus <jpalus@fastmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220479
---
v2: Fix issue #2, as well.

 drivers/pci/controller/pci-mvebu.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 755651f338..a72aa57591 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1168,12 +1168,6 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
 	return devm_ioremap_resource(&pdev->dev, &port->regs);
 }
 
-#define DT_FLAGS_TO_TYPE(flags)       (((flags) >> 24) & 0x03)
-#define    DT_TYPE_IO                 0x1
-#define    DT_TYPE_MEM32              0x2
-#define DT_CPUADDR_TO_TARGET(cpuaddr) (((cpuaddr) >> 56) & 0xFF)
-#define DT_CPUADDR_TO_ATTR(cpuaddr)   (((cpuaddr) >> 48) & 0xFF)
-
 static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
 			      unsigned long type,
 			      unsigned int *tgt,
@@ -1189,19 +1183,12 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
 		return -EINVAL;
 
 	for_each_of_range(&parser, &range) {
-		unsigned long rtype;
 		u32 slot = upper_32_bits(range.bus_addr);
 
-		if (DT_FLAGS_TO_TYPE(range.flags) == DT_TYPE_IO)
-			rtype = IORESOURCE_IO;
-		else if (DT_FLAGS_TO_TYPE(range.flags) == DT_TYPE_MEM32)
-			rtype = IORESOURCE_MEM;
-		else
-			continue;
-
-		if (slot == PCI_SLOT(devfn) && type == rtype) {
-			*tgt = DT_CPUADDR_TO_TARGET(range.cpu_addr);
-			*attr = DT_CPUADDR_TO_ATTR(range.cpu_addr);
+		if (slot == PCI_SLOT(devfn) &&
+		    type == (range.flags & IORESOURCE_TYPE_BITS)) {
+			*tgt = (range.parent_bus_addr >> 56) & 0xFF;
+			*attr = (range.parent_bus_addr >> 48) & 0xFF;
 			return 0;
 		}
 	}
-- 
2.50.1


