Return-Path: <linux-pci+bounces-11950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1A0959CB8
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 15:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358221F217A2
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 13:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA33199FB8;
	Wed, 21 Aug 2024 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="J7wL/N1H"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DBB199942;
	Wed, 21 Aug 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245378; cv=none; b=bmKg8mmdN4LtS4gg+Mu+LNVjAGAprLG59vGgWyqKjHp9u60IKldxymfzgs4xbk4kBCJAIhaSjh1TLYF1k/rons5l52Y45CAoXaOKzYl8Qgyr9SkYFumcH9Jl9/I0ls+UxLB0LgBExuZlDOAHPuOhs7MO0OydxjbqYp8hcNEITSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245378; c=relaxed/simple;
	bh=AAJU18OBl8o8+iDmdG41Ki05MWpShLtTzqE+u3kWNwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ifvoKFiqadZCUMjcgddI3RN0bd/vL4gO2rm/QUZ7s6bgPy/kpYx99s5lA95Ocdn03+su0J+blweUAyXlVY9Cd1I+3HNxDkqCJxoLTI+0mqlaXFjyaC4gmBwFR30Jxss5XRULuXQlw2JMpmnazuYDmhlfDh01xUtW2cccE5K5Luc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=J7wL/N1H; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724245377; x=1755781377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AAJU18OBl8o8+iDmdG41Ki05MWpShLtTzqE+u3kWNwI=;
  b=J7wL/N1HWM5vEpitBr7Wvq6eBMFqiX+jkwglIPubJyNwWYtlttVstm0G
   W9GjL6x9yhr7S81JVdsQEjhSQ6r/yKKEfqj0/cSvuuiIfST0sPfKzxzQO
   TK6v4Yve/l2OhrY2oPJrV+P1oR5nsrODQI0PhkrJOcuasvUPQ0QzvqVpG
   HZm4Vu+0BIH4ftZvdHiOV79iJ1FnnAjCZSMEN5Iusiy69iEmYV7wNi6b9
   YbSZ7yroOb+3kWZmudurtffM+miwcKTW/q0MPmBTIyR/tjb9lkn39jxPL
   oLlF5FwSVStMshqGKvNnYpzrYlnMDZLReyWxWtZvEp8BITxl8kOSX7QyD
   g==;
X-CSE-ConnectionGUID: hYt9Btb/Rtq04w/yiOUfIw==
X-CSE-MsgGUID: lyWViQzjSR+R7G3o33eTUg==
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="30743856"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2024 06:02:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Aug 2024 06:02:38 -0700
Received: from daire-X570.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 21 Aug 2024 06:02:35 -0700
From: <daire.mcnamara@microchip.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <conor.dooley@microchip.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <daire.mcnamara@microchip.com>,
	<ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v8 3/3] dt-bindings: PCI: microchip,pcie-host: allow dma-noncoherent
Date: Wed, 21 Aug 2024 14:02:17 +0100
Message-ID: <20240821130217.957424-4-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821130217.957424-1-daire.mcnamara@microchip.com>
References: <20240821130217.957424-1-daire.mcnamara@microchip.com>
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


