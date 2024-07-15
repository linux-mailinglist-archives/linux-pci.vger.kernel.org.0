Return-Path: <linux-pci+bounces-10258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0DB9313A9
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 14:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE1A1C225A7
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 12:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694E718C32C;
	Mon, 15 Jul 2024 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SHSH/BLx"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B435C18C187;
	Mon, 15 Jul 2024 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045418; cv=none; b=Q5nS2db7X0GeAUxSUHvgUVsecaR0SgLiHZN2UtPVbZTMCcbr6tluO2vTi7mvrlLN/wM/Pn3l1GGdAm2gaAaDVHoS4quo45VmhA0K7KQjq5c8yHy6QMzNCsmY/0Ub7PIZPj6qhTUEYEflRiG6oLonmAocXjYrYPUr/R7Uwy0SWBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045418; c=relaxed/simple;
	bh=Igv9P5b9xyPs7ch22N3cjMBkjk6low4zX+8qxLLX+b4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e76TN15+iefGjLVFE/MBl75IZCliHujhPluVhrorEmh01eKF6TrrQNttjKmFrk7FH1f/4qfmuC7NgStpgpdHNNiA6f5ibMVVxiNeh8f28RXzQnO6kDuCVyVaBG2khqVxavX0L6BpkdCC4lHGvVDLjoiZjlr6FguEC525589aRdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SHSH/BLx; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46FC9g5e109144;
	Mon, 15 Jul 2024 07:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721045382;
	bh=1cazo7ReNItzF76RUs5P1QS+l8y6IS0p/XVRdyZj368=;
	h=From:To:CC:Subject:Date;
	b=SHSH/BLxBSuqEdfH3DsJalseBTtzzsODlv71vWch1UQgswLoZFOMUpoRkFN2JGfgY
	 000HsQw49SJ5Ej9vwMu/PgEY9XODrz2g7fMVzdsX6dETYd+4VkbnZnUbVTvLHhX1JE
	 UzkMinQ1rhEg/DssLLnf9//ljvGCODMvSeYpZGpY=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46FC9gkB012672
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jul 2024 07:09:42 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Jul 2024 07:09:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Jul 2024 07:09:41 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46FC9anV060344;
	Mon, 15 Jul 2024 07:09:37 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <vigneshr@ti.com>, <kishon@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 0/3] Add support for ACSPCIE refclk output on J784S4-EVM
Date: Mon, 15 Jul 2024 17:39:33 +0530
Message-ID: <20240715120936.1150314-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello,

This series adds support to drive out the reference clock required by
the PCIe Endpoint device using the ACSPCIE buffer.

Series is based on linux-next tagged next-20240715.

Series has been tested with the following device-tree change:
https://gist.github.com/Siddharth-Vadapalli-at-TI/8206ea3a89753c309e4c82d825c75dae
on J784S4-EVM with an NVMe SSD connected to the PCIe connector
corresponding to the PCIe1 instance of PCIe. Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/d825068cfe55bba7a869469c1ef64ddd

Regards,
Siddharth.

Siddharth Vadapalli (3):
  dt-bindings: mfd: syscon: Add ti,j784s4-acspcie-proxy-ctrl compatible
  dt-bindings: PCI: ti,j721e-pci-host: Add ACSPCIE proxy control
    property
  PCI: j721e: Add support for enabling ACSPCIE PAD IO Buffer output

 .../devicetree/bindings/mfd/syscon.yaml       |  1 +
 .../bindings/pci/ti,j721e-pci-host.yaml       | 10 ++++++
 drivers/pci/controller/cadence/pci-j721e.c    | 33 +++++++++++++++++++
 3 files changed, 44 insertions(+)

-- 
2.40.1


