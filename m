Return-Path: <linux-pci+bounces-12276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430F0960A00
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 14:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F379C28391D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 12:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D430E1B3F01;
	Tue, 27 Aug 2024 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QKqi8h4W"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29821B373D;
	Tue, 27 Aug 2024 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761495; cv=none; b=GvQBHMT0aC1PtkOhJj5XZiWQsJ0H9ggsqaMs5wQ2H5NRxtNtBIDuaKyEVyeBzcNLnikmDk+///wgdbucLR8k4tNG4wQsTlTNVupi7KhEAK982hpUEZHlZFXnDBVXb4nKBhmzRc9abajaSJJNmJ86F7/3FLIBTv33k7dztJKwYfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761495; c=relaxed/simple;
	bh=zJe12w2yljz1E+qbXn4yBMsDN6lp3EUCmGpskNc8Fs8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L97dtbjuv1h4+narUmCURJmQlgjT0vlv4dz4zCyKj+ONfPppPP2f8WkZL47dhZ8cu3cR5KmT32xG/nV1K4oxwk3enmWznRYZvjvTPhLYwwRm5LDqMdvBfNffMSg3NH/7ddDl610/Q0rO3p5LQIIygmW6WbbpWqKwGTqftquikg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QKqi8h4W; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47RCOYgn036679;
	Tue, 27 Aug 2024 07:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724761474;
	bh=sO3DIbNT467egR5G/HnowhddSJHnw0sif6k+DnCg3s8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QKqi8h4W+IFdQfxLJrFhBzHnt6rxz3qT0uyy5vYRvh18Zl4nqh2Lkge8MaVf9Ci9P
	 l5IBFVJBTeqFMri39mGP2BGf996j0TxwvbxHGb/LXRCfRWlChebn+Ao8OKjuw8qb4U
	 f6vKBay8cjpnTuHcYX3ofzJx59CPlbd4lbzhDKXI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47RCOYKB025983
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Aug 2024 07:24:34 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Aug 2024 07:24:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Aug 2024 07:24:34 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47RCONYD011388;
	Tue, 27 Aug 2024 07:24:29 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <vigneshr@ti.com>, <kishon@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <j-keerthy@ti.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <stable@vger.kernel.org>, <u-kumar1@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 1/2] PCI: dra7xx: Fix threaded IRQ request for "dra7xx-pcie-main" IRQ
Date: Tue, 27 Aug 2024 17:54:21 +0530
Message-ID: <20240827122422.985547-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240827122422.985547-1-s-vadapalli@ti.com>
References: <20240827122422.985547-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Commit da87d35a6e51 ("PCI: dra7xx: Use threaded IRQ handler for
"dra7xx-pcie-main" IRQ") switched from devm_request_irq() to
devm_request_threaded_irq() for the "dra7xx-pcie-main" interrupt.
Since the primary handler was set to NULL, the "IRQF_ONESHOT" flag
should have also been set. Fix this.

Fixes: da87d35a6e51 ("PCI: dra7xx: Use threaded IRQ handler for "dra7xx-pcie-main" IRQ")
Cc: <stable@vger.kernel.org>
Reported-by: Udit Kumar <u-kumar1@ti.com>
Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 4fe3b0cb72ec..20fb50741f3d 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -850,7 +850,8 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	dra7xx->mode = mode;
 
 	ret = devm_request_threaded_irq(dev, irq, NULL, dra7xx_pcie_irq_handler,
-			       IRQF_SHARED, "dra7xx-pcie-main", dra7xx);
+					IRQF_SHARED | IRQF_ONESHOT,
+					"dra7xx-pcie-main", dra7xx);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
 		goto err_gpio;
-- 
2.40.1


