Return-Path: <linux-pci+bounces-5478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE2D893A85
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 13:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C601C20E6B
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 11:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBD0200D9;
	Mon,  1 Apr 2024 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lpLFpz1f"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2478A171C1;
	Mon,  1 Apr 2024 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711969826; cv=none; b=PcFuPFuQtHJXUM72i7LoFdkFjG3pmuG0y7karglw+Q3OqQrRYuoZwAI7G2+qivMhMfiReC1AKSgsts8dcuqALPp+UEwEoKivrZOaX1pSJnpacbBqs84e5nqwntvvt943vy2b1JSlIoduK9XMIWREDzZbxeo3KS0VtfYEVKdAM/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711969826; c=relaxed/simple;
	bh=jXPaO+i+Lw710s/JiXZf6r82g0i1A7AaxWvqDCwkkOQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EPRnB+66NY5hBBoyZJSSfDuWC+Bx+6fsJ5MY/YGeOoMLExuMpVHIpR2SzXqjrmSjGSBdtMElqZs0F4ObCPgf3YGEGphMGKX7zJTHephlPD9ph0otPY5WKI59rbjh+2QmHZOC4dOoQHZfkxOtMQnQf8xroj0MkV6dGvJFqbj6Duo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lpLFpz1f; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 431B9utw045139;
	Mon, 1 Apr 2024 06:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711969796;
	bh=OHVLNNuVDONKMS47YizWE9mpzvg3Fyk8qUd4xbzSgbQ=;
	h=From:To:CC:Subject:Date;
	b=lpLFpz1fFO/ugHdyXI6gx0Tm/5t1bI8LC56m3Nt8j7a0ZEikz4KNAAnjrUk4FBzg3
	 wyYoeSxNZGnCqNahmWTNx4uyIqp8m4knDrwzKvPjeuIbvG7VPaXFmzP16yo1ib6jV3
	 tk8f3WXxGTR9wNQOYip8DlthZ02eGqXRTMZVMo5s=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 431B9utS099052
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Apr 2024 06:09:56 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Apr 2024 06:09:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Apr 2024 06:09:56 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 431B9p8x034988;
	Mon, 1 Apr 2024 06:09:52 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <kishon@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3] dt-bindings: PCI: ti,j721e-pci-host: Add device-id for TI's J784S4 SoC
Date: Mon, 1 Apr 2024 16:39:51 +0530
Message-ID: <20240401110951.3816291-1-s-vadapalli@ti.com>
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

Add the device-id of 0xb012 for the PCIe controller on the J784S4 SoC as
described in the CTRL_MMR_PCI_DEVICE_ID register's PCI_DEVICE_ID_DEVICE_ID
field. The Register descriptions and the Technical Reference Manual for
J784S4 SoC can be found at: https://www.ti.com/lit/zip/spruj52

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---

This patch is based on linux-next tagged next-20240328.
v2:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240115055236.1840255-1-s-vadapalli@ti.com/
Changes since v2:
- Rebased on next-20240328.

Regards,
Siddharth.

 Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index b7a534cef24d..0b1f21570ed0 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -68,6 +68,7 @@ properties:
       - 0xb00d
       - 0xb00f
       - 0xb010
+      - 0xb012
       - 0xb013
 
   msi-map: true
-- 
2.40.1


