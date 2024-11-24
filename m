Return-Path: <linux-pci+bounces-17247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E84F9D6D79
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 11:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECFB281366
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 10:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A591891A8;
	Sun, 24 Nov 2024 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="auraZ1VE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D25218455B
	for <linux-pci@vger.kernel.org>; Sun, 24 Nov 2024 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732442714; cv=none; b=WnMlnikufV4F40gbU9y5VFmx7Fa3najqh55N+XFPvYOBut6v1qMQv07X2hxyB3jZLOQZrcFR5O34//mBI9pGj9iUNfxU4iaNcz5szPV08AdTAsT3LDC2J3sqfoeUUAaGXx4uGcAxLhkXmIuVsbbNkuQHNl9nfNSk0S+OajVGWZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732442714; c=relaxed/simple;
	bh=L2vOQpxf+jsewIrh71TowDocaxbrQWe/NVorAuStYX8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hjnfep0Peffl67uullk3dgwQQEB/tKxWajZEMbbnpeu+66uDVzIn7nMhiVZl9Cv58mpiBdkaWwkXlwEZ+5/9TAV+XQ6rTDlSbaI+F3lmsOVcMMG3oZ9H6JdBPlsa+kpeBNIG+ZuatyJgWB8z50SLHV/w9HSJQ2NKn4g0th/64q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=auraZ1VE; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9e44654ae3so481179566b.1
        for <linux-pci@vger.kernel.org>; Sun, 24 Nov 2024 02:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732442710; x=1733047510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/azjLItm0kRcZGnRsfAiDqYz09Bjkw+3gf50DzO5cz0=;
        b=auraZ1VE35Pq1CgskQJl3IF1qsb2sP3XX2A8zuMz4TocbydcYT7CpYAY5OOQE5zc4c
         mwlTQV6++o8ds9nM1r3d/cTuz1gOijnR9nyMuFiLDAmVmC6ZteIUDBsqOAOIao3ObsTb
         7xFJx5v5tjjpaF7uC2TkLUeP9UjP5ek/2/lTea6LCoGSHIpyMBuqPnSD+0BnBJxHasfJ
         1oOGTF5Z3DuWdwYmNLMaUz0PIHYn196dUz8zU4ZnR44sexKOZL5ZeLmE70pLs0NyTQkD
         PUYDw+nJ1aJS2ut8jsi20HoH0vM9QhA40D8ls4TyvhuVwhfYVmkg2pxe7ZlPZaDclUgG
         mzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732442710; x=1733047510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/azjLItm0kRcZGnRsfAiDqYz09Bjkw+3gf50DzO5cz0=;
        b=QIDZ9Z3taVIMunnu4wF7Pt7iMmUsHZTHzyjQIDPK7ZOUSe7wvDEtuKH1pFopxUiqwl
         JEEmLizGPbilMukDnf+LEiqH1gQa9rWRrvqm35pa6MzMgDTvy8FB7QMwJCTbMk1oMNiz
         B1ls4z2+SVDKkvnjEc98r8fVA1BBUhtgMUuiQWcJ0LUZBKDssS6aLRG2UUh95Cdz6rP9
         lyXMEq+0w4mwbT4AH1b/tmywiEPABjkPfeXIRdRi2YuxvjBoaCeBH3aScqcs7+i7QRYf
         jMs63ipYySJBNV+Rj9yVi1pJ8rd3IXPA+ufiVH26jZ8Lh0kZsUFDACFMSQ/cDxlqYIZF
         S4iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFQcmhMgdaBrav+gTw+S27QckwM5FkW7qyG/EhYi3feh38VXr4+Gqu/mxylOm+sZiWxEXkb0kWVsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8V/6uDN9r0qjVkDNfDZNQtQFXkM/1VbvxOvjOoLKzQeIm8XR4
	2VAHpUIc0L1dFO8yddnypbpYDR7F0o8ssujQXx3wqoAZL+QiuXRa2dW8NlxdZ7A=
X-Gm-Gg: ASbGnctADEIbMJEfd7FYJGPHQw3OpVttxOVECnjHF3SCY74+2qxoOQCseJxpVbd0nle
	+aWeWeWBsT2O0FeMxrGvWmBKwEr+6hb5uTqq+25UqconLWghHDwHqvBLUPxTDmrvoasoLIpt92D
	W24Cy0PBFDiRD5V9BxKZzr33cm1uMlY/YINRWMrL9rsfy4czMH3mwofeSgmKZWDxmFM6extnucA
	jyEQjPanpc7+amIBkWLs3HmvFYK8U6DbNcbFrmEpUbg89UEDS9WZ2njrJM6+vReMh0XxaGAZNN7
	7Xl3t6D67hKNSw/eXj3b
X-Google-Smtp-Source: AGHT+IF27avX+bMlAPUDjojXnihXV+/+kooigFr7e9ZVvLkYgR4oL+7yerxVqNUweak7WLSGulhdMg==
X-Received: by 2002:a17:906:292a:b0:aa5:2a71:1646 with SMTP id a640c23a62f3a-aa52a711b3emr430419266b.33.1732442710505;
        Sun, 24 Nov 2024 02:05:10 -0800 (PST)
Received: from localhost (host-79-49-220-127.retail.telecomitalia.it. [79.49.220.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fd52sm322314666b.116.2024.11.24.02.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 02:05:09 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 1/2] of/unittest: Add empty dma-ranges address translation tests
Date: Sun, 24 Nov 2024 11:05:36 +0100
Message-ID: <08f8fee4fdc0379240fda2f4a0e6f11ebf9647a8.1732441813.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1732441813.git.andrea.porta@suse.com>
References: <cover.1732441813.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intermediate DT PCI nodes dynamically generated by enabling
CONFIG_PCI_DYNAMIC_OF_NODES have empty dma-ranges property. PCI address
specifiers have 3 cells and when dma-ranges is missing or empty,
of_translate_one() is currently dropping the flag portion of PCI addresses
which are subnodes of the aforementioned ones, failing the translation.
Add new tests covering this case.

With this test, we get 1 new failure which is fixed in subsequent
commit:

FAIL of_unittest_pci_empty_dma_ranges():1245 for_each_of_pci_range wrong CPU addr (ffffffffffffffff) on node /testcase-data/address-tests2/pcie@d1070000/pci@0,0/dev@0,0/local-bus@0

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/of/unittest-data/tests-address.dtsi |  2 ++
 drivers/of/unittest.c                       | 39 +++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/of/unittest-data/tests-address.dtsi b/drivers/of/unittest-data/tests-address.dtsi
index 3344f15c3755..f02a181bb125 100644
--- a/drivers/of/unittest-data/tests-address.dtsi
+++ b/drivers/of/unittest-data/tests-address.dtsi
@@ -114,6 +114,7 @@ pcie@d1070000 {
 				device_type = "pci";
 				ranges = <0x82000000 0 0xe8000000 0 0xe8000000 0 0x7f00000>,
 					 <0x81000000 0 0x00000000 0 0xefff0000 0 0x0010000>;
+				dma-ranges = <0x43000000 0x10 0x00 0x00 0x00 0x00 0x10000000>;
 				reg = <0x00000000 0xd1070000 0x20000>;
 
 				pci@0,0 {
@@ -142,6 +143,7 @@ local-bus@0 {
 							#size-cells = <0x01>;
 							ranges = <0xa0000000 0 0 0 0x2000000>,
 								 <0xb0000000 1 0 0 0x1000000>;
+							dma-ranges = <0xc0000000 0x43000000 0x10 0x00 0x10000000>;
 
 							dev@e0000000 {
 								reg = <0xa0001000 0x1000>,
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index daf9a2dddd7e..80483e38d7b4 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1213,6 +1213,44 @@ static void __init of_unittest_pci_dma_ranges(void)
 	of_node_put(np);
 }
 
+static void __init of_unittest_pci_empty_dma_ranges(void)
+{
+	struct device_node *np;
+	struct of_pci_range range;
+	struct of_pci_range_parser parser;
+
+	if (!IS_ENABLED(CONFIG_PCI))
+		return;
+
+	np = of_find_node_by_path("/testcase-data/address-tests2/pcie@d1070000/pci@0,0/dev@0,0/local-bus@0");
+	if (!np) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	if (of_pci_dma_range_parser_init(&parser, np)) {
+		pr_err("missing dma-ranges property\n");
+		return;
+	}
+
+	/*
+	 * Get the dma-ranges from the device tree
+	 */
+	for_each_of_pci_range(&parser, &range) {
+		unittest(range.size == 0x10000000,
+			 "for_each_of_pci_range wrong size on node %pOF size=%llx\n",
+			 np, range.size);
+		unittest(range.cpu_addr == 0x00000000,
+			 "for_each_of_pci_range wrong CPU addr (%llx) on node %pOF",
+			 range.cpu_addr, np);
+		unittest(range.pci_addr == 0xc0000000,
+			 "for_each_of_pci_range wrong DMA addr (%llx) on node %pOF",
+			 range.pci_addr, np);
+	}
+
+	of_node_put(np);
+}
+
 static void __init of_unittest_bus_ranges(void)
 {
 	struct device_node *np;
@@ -4272,6 +4310,7 @@ static int __init of_unittest(void)
 	of_unittest_dma_get_max_cpu_address();
 	of_unittest_parse_dma_ranges();
 	of_unittest_pci_dma_ranges();
+	of_unittest_pci_empty_dma_ranges();
 	of_unittest_bus_ranges();
 	of_unittest_bus_3cell_ranges();
 	of_unittest_reg();
-- 
2.35.3


