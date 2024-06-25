Return-Path: <linux-pci+bounces-9234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1AF916822
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 14:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B199B25E10
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 12:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291ED15F3F9;
	Tue, 25 Jun 2024 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rZm/GF8E"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B7158D97;
	Tue, 25 Jun 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319163; cv=none; b=FJs37uMJR1veSep7VfFtca2fDnqdLSgtzIGxBigO8LsP6TgZ0XX/al4Lj8fIu8yP2rO6Fzhl3pIrgpEBUnJGmb2KpgKbazJlFbuKVGw4V3Uag7w0emzmsVYSYOwAX5RuZOpc3VG/m7jMx2eeNZlK5dC/f+Nw4TcNlvd2c6JKVHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319163; c=relaxed/simple;
	bh=jiUij3wRRe5sE48zPdwi6+NvzYyJIr+GpOYj/SVthjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DvWGTfu+fn5CpbhtCAfQBGK6aAJPijXglliwoPCuxw68mTox3uwP1JGBk5AXo7j5Bvw9dGS/Ccezgcu9JjTLBFVG4soDS1+MkryqYjS7GixI7SomWZV+Nh07+XaGsN7fw2CU2OT8RimyM6xPZ2yFPtRcvGNHAMxr17vJn+WmuQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rZm/GF8E; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719319161; x=1750855161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jiUij3wRRe5sE48zPdwi6+NvzYyJIr+GpOYj/SVthjg=;
  b=rZm/GF8E4s75sf8xPqLUD8iefmYRmSs7h8ni/x0w4joSnAamdJ6XESRW
   rz6he4zEqJYcyj5NrdYOyJtuBt3u979rUWKD9NLxfAIHYUuWW/Q0ZJfzS
   v4iYN9ic8ngJc5SvP+gc4rqnOmVo2KoK19DNYp/29P1b2bBOQa07J7++q
   neWauSPGCZxqP3VU9EM081U6pcBw0EXUCxmgKgznsGbCi3twK/4uqqfK/
   HJ6rUXMaCDTec4nQXZaVPCY1YrCIqlMQbvASiAF4SYLMbjYtlYl65ouEW
   4aHE5yB3UlZsMsda5mJVLR+XOc7AntBVeFNRhPn3NsHZ0aHZO4FA/NlB9
   g==;
X-CSE-ConnectionGUID: mB3BUqYURGm5J5zo6AMIVA==
X-CSE-MsgGUID: f/MOvR+eT6+IIPo7csmNhw==
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="195864242"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2024 05:39:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 25 Jun 2024 05:38:52 -0700
Received: from daire-X570.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 25 Jun 2024 05:38:50 -0700
From: <daire.mcnamara@microchip.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <conor.dooley@microchip.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <daire.mcnamara@microchip.com>,
	<ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 3/3] dt-bindings: PCI: microchip,pcie-host: allow dma-noncoherent
Date: Tue, 25 Jun 2024 13:38:45 +0100
Message-ID: <20240625123845.3747764-4-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625123845.3747764-1-daire.mcnamara@microchip.com>
References: <20240625123845.3747764-1-daire.mcnamara@microchip.com>
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


