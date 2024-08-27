Return-Path: <linux-pci+bounces-12241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C20960138
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 07:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AD61C21DAE
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 05:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D7613D638;
	Tue, 27 Aug 2024 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DfJMPO+z"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A365713D291;
	Tue, 27 Aug 2024 05:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724738174; cv=none; b=TChGRPkt7uuClA36fZhB53WrIDfxry0i9RiLLl3HJd8XyTpmSNlTjABI0NIApgSIs/U6nl9XqT7WeyRnCm+PBAQaR7y9XmJsLgZtbo+/hp87G+FtAzzfWkQf9GZ6TyLv//DN7FdLGDRY45bWpw4tKqIODf3DuJxsFyz+4ubGZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724738174; c=relaxed/simple;
	bh=U8ZS7CXXIedpOLl4eMBwRLNL4yRq3LRsXiG0OpMo0+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dsxJx6hhY18R95/znMnuhrfm+Lejq7osXPz25zqe84yjyNxeGhVeFQmweb6nOriUCb8brl/F/CnjwCqgvrrLT0geEyKxnWyqhDS0ZxvEI8Wbq20LLP/C5Fh2P+iQ1hznNTrDwJfj4H/KmSuJj4Vfv8pgfLRIro/kvsmXX1khIJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DfJMPO+z; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47R5tsK3028308;
	Tue, 27 Aug 2024 00:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724738154;
	bh=W4UXa3+//kfQvKp14cob8zdKi31YXWRjJXzd5u4IIVc=;
	h=From:To:CC:Subject:Date;
	b=DfJMPO+zdJoWRMaK7MJ8dEiS9Z9qxJneMTZT2qssl3vEfsVn7JI1MjHbOlfd8iBby
	 7hb1gyxr2E0Cq17kG0jduVhUEL1PmmnkAjNKJMQjL/0c1UtvEdVsUEVcREitfU41Rm
	 Oket5whB07wJIDFl2wSmunPoXZexzM31g9YvypSc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47R5tsZH094692
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Aug 2024 00:55:54 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Aug 2024 00:55:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Aug 2024 00:55:54 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47R5tn7d103422;
	Tue, 27 Aug 2024 00:55:50 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vigneshr@ti.com>,
        <kishon@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 0/2] Add ACSPCIE refclk support on J784S4-EVM
Date: Tue, 27 Aug 2024 11:25:46 +0530
Message-ID: <20240827055548.901285-1-s-vadapalli@ti.com>
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

Series is based on linux-next tagged next-20240826.

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
 drivers/pci/controller/cadence/pci-j721e.c    | 38 +++++++++++++++++++
 2 files changed, 48 insertions(+)

-- 
2.40.1


