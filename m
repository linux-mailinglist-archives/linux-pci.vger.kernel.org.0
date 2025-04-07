Return-Path: <linux-pci+bounces-25455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7719A7EF1B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 22:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF2A179CF0
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 20:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475F0253B62;
	Mon,  7 Apr 2025 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eh1fLdHs"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8147C223320;
	Mon,  7 Apr 2025 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056830; cv=none; b=mgGe/DQZnMBBJmCefKpNLM1wQXkz3dOnogi6XzbkziAl/M3iZqqDqq316gPeXi+e1ikZKhIbO1oXLZtyN/ts+HZU4TvMzYgSnQdUTkD/P0uACHIdhHvdLdlNOo/3PgZY+NkAwQRajUzaSqVTo+0BVJCqlmXoZWQlG79n17NMh08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056830; c=relaxed/simple;
	bh=si2Bw5IJPROKqW+kfwLdvOeV0XJuRpoCT2Z9dvgX1pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPbRSDkIfXZZgGYLh+SkmQgIjlPrvNky0fyXnZV68JhZvybQqZWT1j99Gt1NAp/0j38J1IXYx02BI3LBfOHSPwQ4pwvCimUSU/mF4kKgGLrPEWpsyWEkCfE1rwGR4NdLo4qwDxOPwA1nKAak+/8pcdQE1UJB+JXVjhQ9cSMEoUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eh1fLdHs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id E8A8A2113E87;
	Mon,  7 Apr 2025 13:13:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E8A8A2113E87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744056821;
	bh=GR2GmT7fACAPkitPj8eTbd2Bh3lgrZjljTTbjCNGmE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eh1fLdHscTNwQLFz4zn+TFGCDTR5WNE5RWfAgxVBE5kVhHbssYmgCunRRVcnyWtXO
	 sJS5LCmWtQSYMpSw2AWlAV1L8bD0Qgqk9Cu5MVzEz3sGgy7GyMz5iaBB+6oUTcWos9
	 FbCUPCQWyA4ajE1ZqGzUjbCf3EcEddqpX3yQwxMU=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	dan.carpenter@linaro.org,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	joey.gouly@arm.com,
	krzk+dt@kernel.org,
	kw@linux.com,
	kys@microsoft.com,
	lenb@kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	mingo@redhat.com,
	oliver.upton@linux.dev,
	rafael@kernel.org,
	robh@kernel.org,
	rafael.j.wysocki@intel.com,
	ssengar@linux.microsoft.com,
	sudeep.holla@arm.com,
	suzuki.poulose@arm.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	yuzenghui@huawei.com,
	devicetree@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v7 07/11] dt-bindings: microsoft,vmbus: Add interrupt and DMA coherence properties
Date: Mon,  7 Apr 2025 13:13:32 -0700
Message-ID: <20250407201336.66913-8-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407201336.66913-1-romank@linux.microsoft.com>
References: <20250407201336.66913-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To boot in the VTL mode, VMBus on arm64 needs interrupt description
which the binding documentation lacks. The transactions on the bus are
DMA coherent which is not mentioned as well.

Add the interrupt property and the DMA coherence property to the VMBus
binding. Update the example to match that. Fix typos.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/bus/microsoft,vmbus.yaml | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
index a8d40c766dcd..0bea4f5287ce 100644
--- a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
+++ b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
@@ -10,8 +10,8 @@ maintainers:
   - Saurabh Sengar <ssengar@linux.microsoft.com>
 
 description:
-  VMBus is a software bus that implement the protocols for communication
-  between the root or host OS and guest OSs (virtual machines).
+  VMBus is a software bus that implements the protocols for communication
+  between the root or host OS and guest OS'es (virtual machines).
 
 properties:
   compatible:
@@ -25,9 +25,16 @@ properties:
   '#size-cells':
     const: 1
 
+  dma-coherent: true
+
+  interrupts:
+    maxItems: 1
+    description: Interrupt is used to report a message from the host.
+
 required:
   - compatible
   - ranges
+  - interrupts
   - '#address-cells'
   - '#size-cells'
 
@@ -35,6 +42,8 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
     soc {
         #address-cells = <2>;
         #size-cells = <1>;
@@ -49,6 +58,9 @@ examples:
                 #address-cells = <2>;
                 #size-cells = <1>;
                 ranges = <0x0f 0xf0000000 0x0f 0xf0000000 0x10000000>;
+                dma-coherent;
+                interrupt-parent = <&gic>;
+                interrupts = <GIC_PPI 2 IRQ_TYPE_EDGE_RISING>;
             };
         };
     };
-- 
2.43.0


