Return-Path: <linux-pci+bounces-35331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9BAB408B7
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 17:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645B23AA29A
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D94427EC80;
	Tue,  2 Sep 2025 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IspQlBFM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C591B21BF;
	Tue,  2 Sep 2025 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826229; cv=none; b=q7ACvsSE0FhJXS38xFhwqgw33aMOxi6+nm5yQKRGVnRt0agvqvj36QEEo4kfe0n9rmri8Y7AT1xUc0366dOrGW/p5hRD4UHy2HXJWwdP2eZjLiHMOcex9ICL8gsyEGFIKDsr4VWShfMlDHOpMB7GaSb4cUSTYwRRwzesDJBFkbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826229; c=relaxed/simple;
	bh=qzmEDuKWEk0/8pYzYSJdXE71mPG9XjgsjccYBz9NBo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FkvisQR8nwq6i0Cm3gsr9KBQ4ReJRgyaBGHbPO7MUdaavHDvcU/UIIWStxfpl+KrBAFi339PfOZ7I8ZYhG1Yr21rddZu2Q/uMtIyowyw772HJDlPfWU95yK70/1GNKo0CFwC0ALTBDf2AdgXOye8qeYyCHeTYxrnyNJdbEKDiCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IspQlBFM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b8b02dd14so15317965e9.1;
        Tue, 02 Sep 2025 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756826226; x=1757431026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z/+y/tdM/NG8BWfS1y/m+V54Xiln8R8eIncX37hI0yA=;
        b=IspQlBFMHReltC4OLIRytRbqALLfI/aGtCIlPDij6AELTcBtSq6SCQ7JXDpLr+mY4H
         OQoNnO7Lw25YxQ9ZrIpI7p9hVg8i1vmzB9b0DdzQhjusV5x43YNJ7yU9RW7vh1cEDNQk
         TpQrOAHm4RvsUG7nkl6YSN0oXSX9XMH+oDaxotEJGq7PXWHoKKYdb28ImPsbnK2IKgNw
         kT4OwlpBG7Og4sla+BwD1A7kRtKOv89HmgaEs2o+cs84ywfFjtL0wpMESG6Rpw1I4WhK
         zmiJjqw0UuK7bHO8sreKafy19eugfeB/DI6wO/dnZKcIkwp7VoybwbxoVhL6ENNqCNEo
         77QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756826226; x=1757431026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/+y/tdM/NG8BWfS1y/m+V54Xiln8R8eIncX37hI0yA=;
        b=pLDEQhWgZCbMLpAFwUCucUj163OmEkaCsRpxoZZjZEya8iZ0qDewfZp5R6ZJWyA0nm
         uoTjQA2JocDpODnqyupPNDP0Uew2A0VbTxtvNTWzECgFOQBaTHTP938wY9jq1xQUS3J4
         VU4JjNYt2Kmv3U3zITqDsiJRHcsf400dFXhxK8h79LPQu3yJ5TqE0ypR73GYWDkocf+l
         ldCSA1iFDI+oiehKb+4BI13D+Jzvi2x+5xd+UOaLrgfLMVen/8+geoCIOLl3+/RxoSan
         WGhvdaHS6/+XBsNs7l25vYh7YPYgk9kooqRBjKiD1VsDgZivw5d1yNBmzPzhq6YxwY3G
         ubZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4Koy1Bnkknt5zQPryMIqgpEGj+i2jbLcf4wY4cQUMQNH+YEF+/Ur/0jXD4muC2/GpE81ybZH/rmOn@vger.kernel.org, AJvYcCXuXFg9iQ0wytMQIflLUVHnGWk3deWxDLsDXc63HR6Ah2A4bRhnWA8GJdEn3ZyaKGw6GnKaRTbz2hPtmcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw560b/M/SDeygF/VMqwtOT7+iFIUWley8I0zJTsbhP8scHL0CC
	bkmTvChulgz4Z6i3IuaxtdM4SUaUC1598Xa4cuTKl4iwCTTRVuKQQFjl
X-Gm-Gg: ASbGncuyDvWJpcrgrDRD1Xy7HUMmCT72lDwASYjkF+dymPgqGBgSMYmOc7rMd4WkFIi
	NKgoxbRAl+AFL6qL5VohlKY2j8gzMxLOjjG6iubHT3rFbaCxdbbaczoFxW1oiBDWPVb4lA40+6P
	SQRK7Z/ZFY6caBmnQI+VQ95VMfApAkW1GTRxWPJQYkrVQfBiWGB0ZLR+r/R/nk0eXhjmNXiTjzI
	s14bukzI0db8O89AMWE2lNzOy3PQfStckdJIlOOoHAikHm0UA0Y4CRjJIRlipgVE0AAuRxny+Nq
	+x8xoax27gOK5P4DNmQI13lQjWd82TVmuQHnfKzS1n3ogX51qWNvwgIT+kCJd3Jp6MIZQIxJCvu
	Eo96I96Iqr0X5YF4MOC5RGRazryg9eQ==
X-Google-Smtp-Source: AGHT+IHPrxWG9n0jv/V9dHimweE6JV57TFo0vu1l+QiPK2mACEOvsa8ilVRABmpFuv6uFYWMmNxRuw==
X-Received: by 2002:a05:600c:3ba9:b0:456:1a41:f932 with SMTP id 5b1f17b1804b1-45c6fa9a71amr2875755e9.22.1756826225515;
        Tue, 02 Sep 2025 08:17:05 -0700 (PDT)
Received: from mars ([2a02:168:6806:0:3f02:d36b:e22e:74c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0d32a2sm308037565e9.9.2025.09.02.08.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:17:04 -0700 (PDT)
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
Subject: [PATCH] PCI: mvebu: Fix the use of the for_each_of_range() iterator
Date: Tue,  2 Sep 2025 17:13:42 +0200
Message-ID: <20250902151543.147439-1-klaus.kudielka@gmail.com>
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

Analysis:

To determine range.flags, of_pci_range_parser_one() uses bus->get_flags(),
which resolves to of_bus_pci_get_flags(). That function already returns an
IORESOURCE bit field, and NOT the original flags from the "ranges"
resource.

Then mvebu_get_tgt_attr() attempts the very same conversion again.
But this is a misinterpretation of range.flags.

Remove the misinterpretation of range.flags in mvebu_get_tgt_addr(),
to restore the intended behavior.

Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
Fixes: 5da3d94a23c6 ("PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"")
Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Closes: https://lore.kernel.org/r/20250820184603.GA633069@bhelgaas/
Reported-by: Jan Palus <jpalus@fastmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220479
---
 drivers/pci/controller/pci-mvebu.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 755651f338..4e2e1fa197 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1168,9 +1168,6 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
 	return devm_ioremap_resource(&pdev->dev, &port->regs);
 }
 
-#define DT_FLAGS_TO_TYPE(flags)       (((flags) >> 24) & 0x03)
-#define    DT_TYPE_IO                 0x1
-#define    DT_TYPE_MEM32              0x2
 #define DT_CPUADDR_TO_TARGET(cpuaddr) (((cpuaddr) >> 56) & 0xFF)
 #define DT_CPUADDR_TO_ATTR(cpuaddr)   (((cpuaddr) >> 48) & 0xFF)
 
@@ -1189,17 +1186,10 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
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
+		if (slot == PCI_SLOT(devfn) &&
+		    type == (range.flags & IORESOURCE_TYPE_BITS)) {
 			*tgt = DT_CPUADDR_TO_TARGET(range.cpu_addr);
 			*attr = DT_CPUADDR_TO_ATTR(range.cpu_addr);
 			return 0;
-- 
2.50.1


