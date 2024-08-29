Return-Path: <linux-pci+bounces-12423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54D1964252
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 12:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEAC1F25F93
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 10:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E157618FC65;
	Thu, 29 Aug 2024 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EXN2TC9a"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E5915C14D;
	Thu, 29 Aug 2024 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928822; cv=none; b=qHPGEh+L1h1LQiCm7j8WLAAzLDLQKbQhOT2ZftZSG6q8pmrIkDIuLAutb0VTDREoKdANIytEMueBizx+D1UpLd3ZCpeJHAv2cY9z1dPgyJUmIhWkrJCw7qZOVC18kyfHie5DJtChyHl+TIx9ElFtF9enaUw7+6QMicCzSQf9/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928822; c=relaxed/simple;
	bh=E7gq/QmJsj+D89bOqk//b2dR8cVweEQPEUtJg4eDE8E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y/9nonm25N+bHx47NeUfGnHwuIOhdaXOpynNSJtV9npRIfJr79klEXGGDVGRHYi2KTvyWxYnR0FiZzK7BNg44C4hzIzyUbkacAqHXaBL3TU63zqQVBdVQ/Wpib/e2xbdTg+JCzbUjtnzozZHGkPFLelge9dQRvRPsXU/kQpvn9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EXN2TC9a; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47TArMPF032241;
	Thu, 29 Aug 2024 05:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724928802;
	bh=epzqzdstf08Pv0QIoDHbhYfXJluab1eVI95BSkCmztU=;
	h=From:To:CC:Subject:Date;
	b=EXN2TC9as0Y3TYhI6xQH3pS32XJWmft/LaP/NDYk4GKNgplfcj001HhS/v/kXPmxA
	 A4ipT2aMZ0OLZNIYl5OYS5PAImThRxI3TDiJvQoElVCA3vAwJgXT7FpwnwkXVqwr0f
	 B0hnSFPgrGGu8SeNfxrid9VYrX3GUYv5HYmuE5IU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47TArMbM081088
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Aug 2024 05:53:22 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 05:53:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 05:53:21 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47TArHpR070385;
	Thu, 29 Aug 2024 05:53:17 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vigneshr@ti.com>,
        <kishon@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 0/2] Add ACSPCIE refclk support on J784S4-EVM
Date: Thu, 29 Aug 2024 16:23:14 +0530
Message-ID: <20240829105316.1483684-1-s-vadapalli@ti.com>
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
the PCIe Endpoint device using the ACSPCIE buffer. Series __doesn't__
have any dependencies as the dependent patch:
https://lore.kernel.org/r/20240729064012.1915674-1-s-vadapalli@ti.com/
which was mentioned in the v2 series has been merged.

Series is based on linux-next tagged next-20240829.

v3:
https://lore.kernel.org/r/20240827055548.901285-1-s-vadapalli@ti.com/
Changes since v3:
- Rebased series on next-20240829.
- Addressed Bjorn's feedback on the v3 patch 2/2 at:
  https://lore.kernel.org/r/20240828211906.GA38267@bhelgaas/

v2:
https://lore.kernel.org/r/20240729092855.1945700-1-s-vadapalli@ti.com/
Changes since v2:
- Rebased series on next-20240826.

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

Regards,
Siddharth.

Siddharth Vadapalli (2):
  dt-bindings: PCI: ti,j721e-pci-host: Add ACSPCIE proxy control
    property
  PCI: j721e: Enable ACSPCIE Refclk if "ti,syscon-acspcie-proxy-ctrl"
    exists

 .../bindings/pci/ti,j721e-pci-host.yaml       | 10 +++++
 drivers/pci/controller/cadence/pci-j721e.c    | 39 ++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

-- 
2.40.1


