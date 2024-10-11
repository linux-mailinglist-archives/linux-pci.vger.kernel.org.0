Return-Path: <linux-pci+bounces-14325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 035C599A5B0
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 16:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3192866FB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128852194B0;
	Fri, 11 Oct 2024 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y7YVhH5d"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780354431;
	Fri, 11 Oct 2024 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655327; cv=none; b=S1H1/EO1g6MoNPwYqeRLedS/TA/NdMznmqUXjgGHoklTxVNpF5L8Mfn7PDqPTPZwhaN+SCTH3L64LzGre1ydpdm7VUsAEX3VJwOwkuaGQ62dYxcBwnGZ1CdqvAWHlTqz+yIXMVuRhO8WeqCc3dz7BwDR6RjXfb2bVlyctrMs9hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655327; c=relaxed/simple;
	bh=i/HxZYSj3x29bpukEzZcwPkb9qFoaouDs9iL1Ghkig8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSg2Zs+BLqHvhqIAIzZccslseKIX3e8TPW0ONJso5eDolZ0rC20wA9bn31tQWyTw7mFsTMEtHQiBaF2oTGqMa1dBGj6nuwTmjiPEphVO5dyaUfqvqdZPQDW1jd/w+hV3Q5AgjY1xWkx2KiQUc0Ov6cozfPFmTfZc3+C1jHcx+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y7YVhH5d; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728655325; x=1760191325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i/HxZYSj3x29bpukEzZcwPkb9qFoaouDs9iL1Ghkig8=;
  b=y7YVhH5d0n7/DBkLdTyNBb9zbueuNjscSm6hWXU8uwIJEzcuoQAmNRtC
   d2zQuICiDWjWR/C3qaTL7MupS5Np5wDxMjFa6YuSEMW+0HFPccUmL3+SO
   Ij/CwI7rbu6IJIy+S4oIVJ1NNVJ+NnpSFSdyRTUz0j1Y3+oBFUhb66dqO
   0iBRUvu9/mQ7ucA2SFflVd8xiNSH9Jd/0QSzxc0a6AeDq0SMpu/IoW1Te
   oKkkLK2UZfC1LN+7q/a3WHg2RcPHXuKTGMbIc4kxNXKUOf3O1wHSyIkUr
   w+hGuFK28Xo8E1kT1WY7uW+y1cd0buI/ASEPS0vGcNJRlK7gnYGxrzWLk
   w==;
X-CSE-ConnectionGUID: PBjGkC+SSZ+djG4FWi+TaQ==
X-CSE-MsgGUID: NA3T2Q4uRL6emXVb6Tl09A==
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="263956568"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Oct 2024 07:02:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 11 Oct 2024 07:01:42 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 11 Oct 2024 07:01:40 -0700
From: <daire.mcnamara@microchip.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <conor.dooley@microchip.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <daire.mcnamara@microchip.com>,
	<ilpo.jarvinen@linux.intel.com>, <kevin.xie@starfivetech.com>
Subject: [PATCH v10 3/3] dt-bindings: PCI: microchip,pcie-host: allow dma-noncoherent
Date: Fri, 11 Oct 2024 15:00:43 +0100
Message-ID: <20241011140043.1250030-4-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241011140043.1250030-1-daire.mcnamara@microchip.com>
References: <20241011140043.1250030-1-daire.mcnamara@microchip.com>
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
2.43.0


