Return-Path: <linux-pci+bounces-10932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD3C93F11C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 11:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95F31B21F1A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E868A140E30;
	Mon, 29 Jul 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yneWTDxe"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA1140395;
	Mon, 29 Jul 2024 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245355; cv=none; b=V6FKtJkpiX//5+7QXjkb4FW2AJXrPEITqL9tqZOc0aIIV7A15r6j1HhduVyiadrrNOjG0UrtVv+q3muX5KrFfmYnM4xzeIvcU+aPqcLw49rLstTXWwNmbbbLGkFmurzCZdpLxkvKG7nenIOcqSzUvaSIZDsMU2uLPVVgQbOIQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245355; c=relaxed/simple;
	bh=KPD6Nqo4WtXdWCQ9rIJoXTKcOslTYNZhKeQoyx6xU5g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C4l05uoevQ1wpXK2q06gYpinnue7UZrYYTWjn3VKEf/k2M2ojmNWi/bpwQrOnnA308Z2H2E8ivA0YA0CfG72/CzC92tYh3lbKOBBSS0DszpV16g5TMUcSUQIHdTsPt8ulQYhIDh6PYo+S8J2sD43BK8jibsNbb5csdbYCSLSlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yneWTDxe; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46T9T1pR025659;
	Mon, 29 Jul 2024 04:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722245341;
	bh=P/I6r3mH3PG538T0NKFeG4eXz7IvtF1fCAZrKGlcUfs=;
	h=From:To:CC:Subject:Date;
	b=yneWTDxe/SMvsH5YbZt3YK4OEoctQO40U1/B+CeuaR1xIOvrFAVD+kLEQS/YeYRZw
	 VKzRXbgpu3PsAO8mAWOv65hG5O02p7SyyprUCOGykl/SL12gnAWJEpNCvaGp8IH7xJ
	 0F3yXh4habvgsO57Zv8cRi1cqMmPP72yTbRLwH2U=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46T9T1kn071204
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 04:29:01 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 04:29:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 04:29:01 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46T9Stc5087068;
	Mon, 29 Jul 2024 04:28:56 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <vigneshr@ti.com>, <kishon@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 0/2] Add ACSPCIE refclk support on J784S4-EVM
Date: Mon, 29 Jul 2024 14:58:53 +0530
Message-ID: <20240729092855.1945700-1-s-vadapalli@ti.com>
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

This series adds support to driver out the reference clock required by
the PCIe Endpoint device using the ACSPCIE buffer.

Series is based on linux-next tagged next-20240729.

NOTE: For functionality, this series depends on:
https://lore.kernel.org/r/20240729064012.1915674-1-s-vadapalli@ti.com/

v1:
https://lore.kernel.org/r/20240715120936.1150314-1-s-vadapalli@ti.com/
Changes since v1:
- Patch 1/3 of the v1 series has been posted separately at:
  https://lore.kernel.org/r/20240729064012.1915674-1-s-vadapalli@ti.com/
- Collected Acked-by tag from:
  Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  for Patch 2/3 of the v1 series which is patch 1/2 of this series:
  https://lore.kernel.org/r/1caa0c9a-1de7-41db-be2b-557b49f4a248@kernel.org/
- Addressed Bjorn's feedback on Patch 3/3 of v1 series at:
  https://lore.kernel.org/r/20240725211841.GA859405@bhelgaas/
  which is patch 2/2 of this series.

This series has been tested on J784S4-EVM with the following
dependencies applied:
1. https://lore.kernel.org/r/20240729064012.1915674-1-s-vadapalli@ti.com/
2. https://lore.kernel.org/r/20240715123301.1184833-1-s-vadapalli@ti.com/
Test Logs with an NVMe SSD connected to the PCIe connector on J784S4-EVM
corresponding to the PCIe1 instance of PCIe:
https://gist.github.com/Siddharth-Vadapalli-at-TI/e54e9126c2fa36c71c40ce7aade57857

Regards,
Siddharth.

Siddharth Vadapalli (2):
  dt-bindings: PCI: ti,j721e-pci-host: Add ACSPCIE proxy control
    property
  PCI: j721e: Enable ACSPCIE Refclk if "ti,syscon-acspcie-proxy-ctrl"
    exists

 .../bindings/pci/ti,j721e-pci-host.yaml       | 10 +++++
 drivers/pci/controller/cadence/pci-j721e.c    | 38 +++++++++++++++++++
 2 files changed, 48 insertions(+)

-- 
2.40.1


