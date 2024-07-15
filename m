Return-Path: <linux-pci+bounces-10257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7129313A3
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 14:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8734D2822B1
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 12:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC9918A94D;
	Mon, 15 Jul 2024 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PrYpgJyq"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890F918A944;
	Mon, 15 Jul 2024 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045415; cv=none; b=SkqXxzZudJEVJs3TPWJz4qAbP6TuU7SszRZz6GyapkodhdD0wgsjqtbXGAcHqxJVwRD1vgGJnqHE18yj0FAPvCrsnZNzHTUemHcBOq1AUXwaVkHrA4oQ32usxZnNixQecW9PqkzNNGbuNfvw3QC1EQ11/KHPW3dClEXSEoB80W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045415; c=relaxed/simple;
	bh=Ffsd04pWiaoT9ORxIGqRa1ioi+6zLm29fu6Ecnk7ffg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDeXaR7txgjs4bFcEQt4xm3bUc8Cnv4zHonjA3Cpt7QOCQOqQaFcIcNrBtyrjwfJIo7vjIrbgbtHMAoMXzImjUa6cggHT/ltrXp2flI1DtDpkhB9CHdFcpWXtOgRYxlDyRnySAkJN711EY4ltVuElU0D0bu4KCcqVCMCV5UnH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PrYpgJyq; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46FC9kNI024076;
	Mon, 15 Jul 2024 07:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721045386;
	bh=e1bMDhcKO64D9bQTeeRYaeGcwchVy5zOu1+7tRpUtuE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PrYpgJyq2ieq8yOjOB/ywnyG6tuQ3c+m4JK6dBA/9dZqUKwC+QLtL/CK3FauipboO
	 9eKrPTf0B5O7Jh3Q9qsYu441wH6KmaUA2nd8h6QmhetjdT/Se6TnDbbOExB8cr8yY8
	 M/yJAZhTURwRC8MemoVz23mHo1x4XAEhSjQkEfDw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46FC9ku9101155
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jul 2024 07:09:46 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Jul 2024 07:09:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Jul 2024 07:09:46 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46FC9anW060344;
	Mon, 15 Jul 2024 07:09:42 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <vigneshr@ti.com>, <kishon@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 1/3] dt-bindings: mfd: syscon: Add ti,j784s4-acspcie-proxy-ctrl compatible
Date: Mon, 15 Jul 2024 17:39:34 +0530
Message-ID: <20240715120936.1150314-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240715120936.1150314-1-s-vadapalli@ti.com>
References: <20240715120936.1150314-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The ACSPCIE_PROXY_CTRL registers within the CTRL_MMR space of TI's J784S4
SoC are used to drive the reference clock to the PCIe Endpoint device via
the PAD IO Buffers. Add the compatible for allowing the PCIe driver to
obtain the regmap for the ACSPCIE_CTRL register within the System
Controller device-tree node in order to enable the PAD IO Buffers.

The Technical Reference Manual for J784S4 SoC with details of the
ASCPCIE_CTRL registers is available at:
https://www.ti.com/lit/zip/spruj52

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 9dc594ea3654..13cbc6fe996e 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -113,6 +113,7 @@ select:
           - ti,am625-dss-oldi-io-ctrl
           - ti,am62p-cpsw-mac-efuse
           - ti,am654-dss-oldi-io-ctrl
+          - ti,j784s4-acspcie-proxy-ctrl
           - ti,j784s4-pcie-ctrl
           - ti,keystone-pllctrl
   required:
-- 
2.40.1


