Return-Path: <linux-pci+bounces-16320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 769219C1AD0
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 11:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D4A281D13
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 10:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F13E1E2837;
	Fri,  8 Nov 2024 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SDTATJH1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36DF1E25F3
	for <linux-pci@vger.kernel.org>; Fri,  8 Nov 2024 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062342; cv=none; b=ByW5bbAXhG+ANkXPPb3NMXBet9EqvSUM1m8aINJ9NQKh8kYCJlKHHlfXYHZjqBSHsnU1HMtq8LjGkK4d9PkcmntoureBbYrZfDvMrlXlwctfaboJ5WD3B1x57mtXQsilFOwWliWtiEP6l1h7NRcpK/cHo7yBvY/SROOmiPdTfkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062342; c=relaxed/simple;
	bh=L2vOQpxf+jsewIrh71TowDocaxbrQWe/NVorAuStYX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aujKThOnIihkc4q6urfuYJ6qyl0hZmtUVNBD4dQUuIR0tr9oC8eaix/fOIr/FfsaA+ildvoNX+iyy4ZDvaC8QRATpfy5/cHKKoJsoSJA+Yb5QBZluwo6FTI/38q8onFpcPflNHlPyDe6WgmnpUewRQU9k9ZYSdqML5AUTHYBi/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SDTATJH1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9ec86a67feso331033566b.1
        for <linux-pci@vger.kernel.org>; Fri, 08 Nov 2024 02:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731062337; x=1731667137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/azjLItm0kRcZGnRsfAiDqYz09Bjkw+3gf50DzO5cz0=;
        b=SDTATJH1lVZWVvcinEnvrAZ/cjnt7bTMs31H88GAdvRkHqNt5Yt23x7+IkkJp9q4NS
         aIAHeTcUlMO/LcOXMmpIxVrlMcshunqgMHtLUrAmzuwhVZYW2jk5Bu/t4zytZTa3bvLp
         S2MK1jq/LNFfTwkOodOrdpg4DC3JosLa85OsQ8OLACBWu49Y/lwM4uq9SMqQ6QS0yDL7
         jNe4wXwX2qPRXhobgceR36y1f0boEaQJBsf9S8kQPs5klhwAcqaOhM23qurYruRXdStL
         mJUfirpalZctTFrwIwS+TQi2+xbWcdn/oasScF/nggWTlYf0AruQE6wxkMUabcl/oX53
         fQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731062337; x=1731667137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/azjLItm0kRcZGnRsfAiDqYz09Bjkw+3gf50DzO5cz0=;
        b=PIaSVTPt/ZK1AZ2U9uCMPYbdf7l/CNeVmAWeFwE5EiQoLqOC2aYzTLVlAUeaR+14rz
         oQtc4jIlLfZgI2+No7We9i28lG4h8ttbPYJlRQwiLp3WkqcKUgZV84wfhweioM/FdZJ5
         LN94kRPluY0HkiUKMtpGYD3wdDjPRtbbqGXztAkj9wQLwWGbeQhp6j8c1/vw9nfSMEy9
         o+B/j9+E+QauQWSWCg3LsMAQ3qeEH+lrqMPLhACPOWwcOeZM4DfcSVASCymfhphuH6To
         wCLvksft5vnOEIjK1PVgVEaK3WlB870zbIN8jrJmAoKM/gE9Cc2VMchB+bwfMOqZMcFT
         NVkA==
X-Forwarded-Encrypted: i=1; AJvYcCUacFqRwQcE5kLjZx43xifbtChZRAu7MGXYEJA70Gr9d+bPMZ+x9sEez7kUCl8vPwf9cX3VL+9VsJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Gr5ft6jO6H3YzqY6VvrEFz9pjcisK/VpaETm/xYcpIGzJ/4M
	QXSqO37MM+2TpoxQwYvdsmuPnkcyWfaHCF9oPOfkh2UjGbi2CMsqeXat672blks=
X-Google-Smtp-Source: AGHT+IHc0Nm4EeujQTsSiAthZ5sn/djXgAGGTqX7CDsdQwDobH57OcRUGR+bcR0+ZbLG2wRvWj+K1A==
X-Received: by 2002:a17:907:6d28:b0:a9a:2afc:e4cc with SMTP id a640c23a62f3a-a9ef0050e63mr178709966b.58.1731062337230;
        Fri, 08 Nov 2024 02:38:57 -0800 (PST)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0def8ecsm213746366b.152.2024.11.08.02.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:38:56 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Michael Turquette <mturquette@baylibre.com>,
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
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH 1/2] of/unittest: Add empty dma-ranges address translation tests
Date: Fri,  8 Nov 2024 11:39:20 +0100
Message-ID: <bb889701c1aae2a88157c9a75be2b83c4b51329f.1731060031.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1731060031.git.andrea.porta@suse.com>
References: <cover.1731060031.git.andrea.porta@suse.com>
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


