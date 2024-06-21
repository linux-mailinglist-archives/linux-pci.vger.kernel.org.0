Return-Path: <linux-pci+bounces-9071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1AC9123AF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 13:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6E328B457
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 11:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75FE176AA5;
	Fri, 21 Jun 2024 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BdZhAPw3"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C40174EC2;
	Fri, 21 Jun 2024 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969405; cv=none; b=MEOg7QZjsYLnv2hfy9dJ5shMTnDtBqLY6cprl1gk+xiSLgFzdRA5WEBAPRe6/CyanJqVCOGPuZBsPB6CXO6EdJOecNvj05y/GS5NDJnghaAEhH8Hk6uMiH0Ick6IFjqrXlz6oGTMoLuf+W7LmNB7Y8Etc9KaNkXtqRg3jUPotu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969405; c=relaxed/simple;
	bh=eOM+rlNe4Ccmiqqj78VRC7CbyAJhediEgq9+gqUJt5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDiRTkI40vB4Swy4WZcma/JTsC/kQf17Kqu5KJJ532D5mvqiRn8U8HQojyZ8OPgU8bTwDIV3e/7kdHFqQ+1oN4+CuzEcaXTMhHnh37JW8x6pgTl0LNP0Gow83FhbfL/EcNrmq84Qab0rwvlqh/H+zTE9o0uJmrXbn1ffGE/PmpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BdZhAPw3; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718969404; x=1750505404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eOM+rlNe4Ccmiqqj78VRC7CbyAJhediEgq9+gqUJt5c=;
  b=BdZhAPw3wQu9V3Zy94zBjcAjDhLAJUdD9eKdTFjG8zHfdFAa/KJ1EmMl
   q0ThJ9lM9U6mGcCioVpqZXtv/M+RNA2biDy6X543Z9PkiVUd1sgidphB9
   /JCilIkhSlgTmEzvz+o3oHveCJkhCYhzA9pOqLSG3v3ns6nwJ3Z2I0ujt
   JN0mGoRnDrmBo85AzGLhXvdYvRUeNYn3+d33yZhUUGNlX4YeqKa1ee1TL
   JCnYso7e7WqDo14c6YxUVMpi0QscwXz3LU3qFmafVBn0SPh2iuiZ46QYN
   DTT0tNzrK2lPUnIxIXmNO8VCLxP5CqlD+GX/kzVUGKKJXBlLd2wFBHC7W
   g==;
X-CSE-ConnectionGUID: MLVdO+kgSZidOgeJsnHSMg==
X-CSE-MsgGUID: dO+OJ/qNSuS3vu3+Mtuk5A==
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="259209056"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2024 04:30:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 21 Jun 2024 04:29:36 -0700
Received: from daire-X570.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 21 Jun 2024 04:29:33 -0700
From: <daire.mcnamara@microchip.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <conor.dooley@microchip.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <daire.mcnamara@microchip.com>,
	<ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 3/3] dt-bindings: PCI: microchip,pcie-host: allow dma-noncoherent
Date: Fri, 21 Jun 2024 12:29:15 +0100
Message-ID: <20240621112915.3434402-4-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621112915.3434402-1-daire.mcnamara@microchip.com>
References: <20240621112915.3434402-1-daire.mcnamara@microchip.com>
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
---
 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index f7a3c2636355..c84e1ae20532 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -52,6 +52,8 @@ properties:
     items:
       pattern: '^fic[0-3]$'
 
+  dma-noncoherent: true
+
   interrupts:
     minItems: 1
     items:
-- 
2.34.1


