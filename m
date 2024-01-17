Return-Path: <linux-pci+bounces-2259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ABD83037B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 11:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73000B246FF
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 10:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717B814A83;
	Wed, 17 Jan 2024 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VnS67NBB"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CEB1429B;
	Wed, 17 Jan 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487156; cv=none; b=CQRf0xLkSK/+XG7zmqCLeKpY9fc4tcQEsXzOmeJu9a+Qrfbx1hLWVP3zuIoJa+/xunl9eelFQ05clywPGBY/97gStgDx8LE0cfZT19Rq4yEJjL2uHoiiZLW560VZ6ls/WF+5AxCgElvIyoPqZOxDFgBGubJTr/yQkZ9hP0rjUtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487156; c=relaxed/simple;
	bh=Nb2CJ0bK1oMUCCsUK9CaW4LZvMtPCDoCVAESMsVYoSU=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EXCLAIMER-MD-CONFIG; b=Z6h5JTKkgsrEDpYsYDUh3AvNQr7XDykASn+czEIAqJa+3oUbQpiMplkr02tCKhfW+kcmd3YZCjd+X2uOMvuQ0Ny/tn7vOyeLDwdR7UtaKcc0aQty0YzmXOTYCO/j8aeLXpEE9c4rnF2fa/KwOVGj3WoYe4IFIApz/pW4nkC0mhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VnS67NBB; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40HAPVKx114398;
	Wed, 17 Jan 2024 04:25:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705487131;
	bh=7LkBVrRURFM2cubK+y34TH+DKZLZzMJlz5v6+GsGZYg=;
	h=From:To:CC:Subject:Date;
	b=VnS67NBBME2H4Ij39GGBn6ZKasFOpPNVCvX1sgGjwam0cxZr30Ye41WvoIMpwo0rY
	 lemuXlqhdq9g7HV8WO9ZGOyn/Vn43QBioZtbH3VsHLkunqQkWdeiIRhJnF2xc1MiEa
	 7mcCmrt/UtHUK2/g1fAK2oYFluVg3wWimgnsi/Hk=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40HAPVd8025690
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 04:25:31 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jan 2024 04:25:31 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jan 2024 04:25:31 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40HAPQIf042834;
	Wed, 17 Jan 2024 04:25:27 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <afd@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 0/3] Fix and update ti,j721e-pci-* bindings
Date: Wed, 17 Jan 2024 15:55:23 +0530
Message-ID: <20240117102526.557006-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
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

This series fixes the bindings for:
Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
by updating the checks added for validating and enforcing the
"num-lanes" property for different compatibles. In the commits
which introduced and extended the checks for the "num-lanes"
property, the property was not truly validated but only described.
Therefore, the bindings are being updated to actually validate
the "num-lanes" property. While at it, checks for "max-link-speed"
are also being introduced. The intent of the aforementioned changes
is to update the bindings for a new SoC namely TI's J722S SoC which
has a similar PCIe controller to TI's AM64 SoC, but differs from it
in terms of its support for Gen3 link speeds. For this reason, a new
compatible is being added instead of reusing the one available for
AM64 SoC.

Series is based on linux-next tagged next-20240117.

Regards,
Siddharth.

Siddharth Vadapalli (3):
  dt-bindings: PCI: ti,j721e-pci-*: Fix check for num-lanes
  dt-bindings: PCI: ti,j721e-pci-*: Add checks for max-link-speed
  dt-bindings: PCI: ti,j721e-pci-host: Add support for J722S

 .../bindings/pci/ti,j721e-pci-ep.yaml         | 34 +++++++++++---
 .../bindings/pci/ti,j721e-pci-host.yaml       | 47 ++++++++++++++++---
 2 files changed, 67 insertions(+), 14 deletions(-)

-- 
2.34.1


