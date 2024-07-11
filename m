Return-Path: <linux-pci+bounces-10148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C07792E47E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 12:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23FCB22A6D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 10:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC475158D79;
	Thu, 11 Jul 2024 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y1XJBL3K"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D698314F9E5;
	Thu, 11 Jul 2024 10:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693394; cv=none; b=XPjihaMef2SHiKRyBCaP8ZMhyRR/VtDRfqrSOku9c+63Wq+DFJwTwWqyvk3hP+aYoVaItYzAxaX+Uq3xHGuan36OrTsGESKxOUgFOj7D7nLEHRvIfKVsSTojBWvZBa2wu0SiGgGXFneqk2VB21nVCd2XmWYhsyyvMjfI8NG4G3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693394; c=relaxed/simple;
	bh=jiUij3wRRe5sE48zPdwi6+NvzYyJIr+GpOYj/SVthjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kukFgLSFPCnZXIlcL5RpSxNLPK2JM231BpiR0vRJua5+8/Sx6GvTGY7cZeEC0b4flAEegKbTISwEZyio3kNGEoupnv+O5BqGyiisrZEqxdsoryhTFE9FuxvEVkJRmxtXwVBeZtfkG3B5nOXrpB82tN0XUCyzbMJO/wyF06wb3JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y1XJBL3K; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720693392; x=1752229392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jiUij3wRRe5sE48zPdwi6+NvzYyJIr+GpOYj/SVthjg=;
  b=y1XJBL3KSMWGLvHs7/6W9TNacKUBOHCjSfNKOXOpzdQfyZrcYFIKCo9W
   Luhh5rp/d6G95PmUQYRdYJsW97mDeKu4eFGmhlAb927UQGkfJtSjrhbO7
   YWSC+ys/bN+UaTkNAw6QooMGPx14lQoDjwi2D6bN1NUyWM+ocwEOR/D0g
   c71GVoGFct3NxBYLJRYLGjoLLyzFpMgP1qPAQPLtgq6nzh3aTKDIQeb2N
   G2jnL5mt5KmdR6FWbJwsLWydnnU7kl9Om7vI2ONCBwdvWrMBo9adzOQ87
   AVt7gnx3/9AAcL32WkvhTq1sx0XTPb49V2Hvrh27DawQxtFfC0A9DFYOW
   Q==;
X-CSE-ConnectionGUID: WkJ7eC8TQierunlUA02PGQ==
X-CSE-MsgGUID: S6X149yARRuVdHRhEe6r5w==
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="196511501"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jul 2024 03:23:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jul 2024 03:23:08 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 11 Jul 2024 03:23:05 -0700
From: <daire.mcnamara@microchip.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <conor.dooley@microchip.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <daire.mcnamara@microchip.com>,
	<ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v7 3/3] dt-bindings: PCI: microchip,pcie-host: allow dma-noncoherent
Date: Thu, 11 Jul 2024 11:22:19 +0100
Message-ID: <20240711102218.2895429-5-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240711102218.2895429-2-daire.mcnamara@microchip.com>
References: <20240711102218.2895429-2-daire.mcnamara@microchip.com>
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


