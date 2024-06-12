Return-Path: <linux-pci+bounces-8663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1073A905154
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 13:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 576D3B23EAD
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 11:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EEC170844;
	Wed, 12 Jun 2024 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ly4XYAeX"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B12A16F901;
	Wed, 12 Jun 2024 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718191413; cv=none; b=WcQv7AT7xvbj/4P4an6tkAizr7aTkP729LGW+Boj9GGL8MKeZfiVgiXE8L7MhZ91qC7RpXEHiAFQKnSrTY6ab980w8zs2bmM+Ik59DqmlhZQYB32bPNLE1i2j3zrXZE77yr4mPRbqgVO0beKQ9x72sQ2tojXZvDsUbnnBdtpilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718191413; c=relaxed/simple;
	bh=eOM+rlNe4Ccmiqqj78VRC7CbyAJhediEgq9+gqUJt5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9NbLKCPtSgxLcBbDS1KEj452gXpPCA0Yq03mW77pcD3iKtgHYlhjeV6t77KpejJDXzrIgBuiUZY9UY7DHlynCjEN1RFwHoVPPXnuwfyPAT4Hq6RDiUAa+c3dPwiRT1xvqMQv4+7C4asWJS3g2qWvfmMZY6RZMmrjMigAAH1Zxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ly4XYAeX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718191412; x=1749727412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eOM+rlNe4Ccmiqqj78VRC7CbyAJhediEgq9+gqUJt5c=;
  b=ly4XYAeXU368ABooJbncngtIeO6etP3CVj343H5xygIAYlG2AzYgn+a6
   vcfAEyVMPjwIKCChRBMyu3hp3Fy4VLifZI1sWvtvoYET5stlPs6YV38TJ
   arYpf5Rb6qIHK6tP4sfXdeTXKyGm1N12MpC97ZxHGMLook8kn3u02HLal
   s5Z5BPVK0uHzLf1+48CUuriQzpfsiiy1Z/4fGmYe6mr7ipcFzydFXFw2n
   TE8aiSJH4oCoB8/2E3ve0xYBg7izvr+SnwXobGKnbepJlmvGlN8HppdoK
   SEpZjyhVU7lbJnvSH4klUAO3jG/3mFzkrVHmA4VM/4+3x0FYapps5G/zl
   g==;
X-CSE-ConnectionGUID: hzPuRHFvRM+Wy8rrRTyffQ==
X-CSE-MsgGUID: jgaw45dBQPqiWppOjWLXvQ==
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="29761713"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2024 04:23:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 12 Jun 2024 04:22:52 -0700
Received: from daire-X570.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 12 Jun 2024 04:22:49 -0700
From: <daire.mcnamara@microchip.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <conor.dooley@microchip.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <daire.mcnamara@microchip.com>
Subject: [PATCH v3 3/3] dt-bindings: PCI: microchip,pcie-host: allow dma-noncoherent
Date: Wed, 12 Jun 2024 12:22:13 +0100
Message-ID: <20240612112213.2734748-4-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612112213.2734748-1-daire.mcnamara@microchip.com>
References: <20240612112213.2734748-1-daire.mcnamara@microchip.com>
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


