Return-Path: <linux-pci+bounces-8536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC90902173
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 14:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AE47B26051
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 12:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954C880633;
	Mon, 10 Jun 2024 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Pct1v/i0"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DB98004A;
	Mon, 10 Jun 2024 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718021949; cv=none; b=KtONH0hcthwCItqaOe/GgwqyJdwfm7LFclWQM3WwqBkONKPvvwolE1Ej2LPLxLXVYa/hdxwPqAt/MvDa9O7zOnrEBZNhY4qtDyKU5btXhRVQX8YWtlmb608+Yvy1VMIwB68IZCELgK1B7UVzFt3PoR6689B9C6Ezm+cshSpOCug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718021949; c=relaxed/simple;
	bh=Qb9Up+t11DzcZW8H2Jjuu7ECFDelJkgS8AlOnO1SlWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5ECk+TccB2LXf+tmBOygMYXcjkrb+bXUj9StbTFhe0Gchy3buyqsTEAfIxos2f5Gs0rf+WmchGFFp8SOrYFTJKMkaCL9xn63yN84hjtHEQmpWvLCIHJsCw9oN/jVmNLWhs1oinmWmRzJnEuQ+ts1Pks/jzhZHYxaY7mOFpDLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Pct1v/i0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718021948; x=1749557948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qb9Up+t11DzcZW8H2Jjuu7ECFDelJkgS8AlOnO1SlWE=;
  b=Pct1v/i0QSycSw3VrPzjiY4lS/WAWQbL1vL4fFsV/jgZBwrJyH6AfO1I
   Mg4AtPq4QsSYGMwxbs+FmgWqlM4QFv/PGlPUYJngkRlk40+wmf0NHGUU/
   WRm7qh5qkEcxs//MYRdA5l9e1me1KRYrJetFVNY7L29dIuUd5iqTSo5VW
   BR+3Ns9nGVuXBGejQGA0AVPIQPKYyW5+UCs2sDIcooANtOxlWrTTjKn2z
   yqsPJ6N7HRWKbYNA6Sm1j6hIp8WMr9d9fSmsXwPyKVTVpl9ZG1C5OStYL
   s3hqpq3oXuJSBx3xfuMgvXQR28l9qjg+HaJALz29XaZoC0PV9dIQVChHm
   w==;
X-CSE-ConnectionGUID: nZYSrxyTSBy6GiOz7aIYFw==
X-CSE-MsgGUID: gcpetgnSQTuJ3BvErvJgGQ==
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="258056938"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jun 2024 05:19:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 10 Jun 2024 05:18:34 -0700
Received: from daire-X570.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 10 Jun 2024 05:18:32 -0700
From: <daire.mcnamara@microchip.com>
To: <linux-pci@vger.kernel.org>
CC: <conor.dooley@microchip.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <daire.mcnamara@microchip.com>
Subject: [PATCH v2 3/3] dt-bindings: PCI: microchip,pcie-host: allow dma-noncoherent
Date: Mon, 10 Jun 2024 13:18:22 +0100
Message-ID: <20240610121822.2636971-4-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610121822.2636971-1-daire.mcnamara@microchip.com>
References: <20240610121822.2636971-1-daire.mcnamara@microchip.com>
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


