Return-Path: <linux-pci+bounces-12094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB3395CC56
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 14:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712701C21A5A
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC291865FC;
	Fri, 23 Aug 2024 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Rzmgum9L"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534B5185B5A;
	Fri, 23 Aug 2024 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416081; cv=none; b=Ku9ZnNsmdto0kUmd7/UmOkxTDZhIZLkvIP74VCpjk23oH+kR5Bo4t6xcHXPxEiSypID3xjkaR64XGYYh99KHNlnuuFOhk7ZBBNnwKR4GnB8pgMQQsbctYw7+pRn4hk0XCLqPaWK4yhlPhKQCk390u06C5ZeM0wZdZRAAPQuYBQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416081; c=relaxed/simple;
	bh=AAJU18OBl8o8+iDmdG41Ki05MWpShLtTzqE+u3kWNwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffknpFqWBJQ3dJjDyZHkGrmMeb/bSxGYlHp+AtICGM0kG/vwgj4KMO+kGSuzWKsKdnMP0VvS4yRpy2pfuajA+BMaJiioq09mPHa+JG9YNEu7B9NFlQ0HI060Y1il5rALivpwtRvOOZhwebrM1HC5VggoL4weKKfQ5PTTVm1JS08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Rzmgum9L; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724416079; x=1755952079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AAJU18OBl8o8+iDmdG41Ki05MWpShLtTzqE+u3kWNwI=;
  b=Rzmgum9LXWohg4N8TKyAZIciL3v47SybuKAyu6tH6jOJjst5Y1rCMN72
   QQy/G2hqEqtaNUPugkzXOq7b5l+nVLt4e/rauvzLumkXIlO1zYwynC4ny
   mHG2KXRHM6q6ZHTIwaA34mm4EtzA0P19HvD1LtumVG6WgSVT/cWCsnwGJ
   jLEUcBfVIfvGfRCUmQuSbZFEg6LtP+ssVAmL8z4Mzx23m0DDlNQfRT4+O
   YVkHcP6SH9c/UbCNF2CIVsubKJVGxF5E+/TOST2qRkiaKkFkRPaX8HmqE
   zcgzMkyOzKNzRyAkPPAQxO0mYyWh1D0wJ0rEGV63P8i7KrQ4xZfWNoM2x
   w==;
X-CSE-ConnectionGUID: rDZOZxKYRGu2u+L6hg58hQ==
X-CSE-MsgGUID: j2lyweIKQPuiHDwPt1WV/g==
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="198251697"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Aug 2024 05:27:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Aug 2024 05:27:35 -0700
Received: from daire-X570.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Aug 2024 05:27:33 -0700
From: <daire.mcnamara@microchip.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <conor.dooley@microchip.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <daire.mcnamara@microchip.com>,
	<ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v9 3/3] dt-bindings: PCI: microchip,pcie-host: allow dma-noncoherent
Date: Fri, 23 Aug 2024 13:27:17 +0100
Message-ID: <20240823122717.1159133-4-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823122717.1159133-1-daire.mcnamara@microchip.com>
References: <20240823122717.1159133-1-daire.mcnamara@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Conor Dooley <conor.dooley@microchip.com>

PolarFire SoC may be configured in a way that requires non-coherent DMA
handling. On RISC-V, buses are coherent by default & the dma-noncoherent
property is required to denote buses or devices that are non-coherent.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index 612633ba59e2..5f5f2b25d797 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -44,6 +44,8 @@ properties:
     items:
       pattern: '^fic[0-3]$'
 
+  dma-coherent: true
+
   ranges:
     minItems: 1
     maxItems: 3
-- 
2.34.1


