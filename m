Return-Path: <linux-pci+bounces-42846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E58CB02CC
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 15:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C711530FF028
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 14:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29916296BBC;
	Tue,  9 Dec 2025 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="L2/Ys5/r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail40.out.titan.email (mail40.out.titan.email [209.209.25.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD6927B35B
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.209.25.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288845; cv=none; b=YpH2wOR6/HZBf/85DXIm/q8HCPAS64m1TNpelji0BTYYDwHaJJK2ARm+H5f1R/Dlb7GGZTW0W7wIEnBp1AZLsmq9Qu/ah8Eqvt+IxGZW4ZqFjE9QzZWmcG5892Z1qS1A/Q5m5ZKLLD4W4ngBGK9STWCvYz1dshBRoltq6Tltt+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288845; c=relaxed/simple;
	bh=vX9kXXrJnR1rHWThBL7xU5N4xiOBbubeqzMIe08FOCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJ+ct/nFop/s5zOdCBeOFgF/hw0cU+R8QLfb+bbQtzd+A2CyeXTdqs+qXYs3sZo3t93XsPSNYPpvwWXQphjcNEcyPf3VRyyUHhff3RQ/ILaHzMc5PcFMOlQFxLZvumxP0CBbL9wL8A2E8DYNjng2iGnYrhCSfq0rlOQLeZkO4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=L2/Ys5/r; arc=none smtp.client-ip=209.209.25.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dQgVL3jrQz9s0n;
	Tue,  9 Dec 2025 14:00:42 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=UWQDG7nF1KGYTr9qrLmsnw74AeAFGq39le95Kv6fqh8=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=to:cc:date:in-reply-to:subject:mime-version:references:message-id:from:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1765288842; v=1;
	b=L2/Ys5/rRsHspyPxCmLtjuCLI7JH48PgtoxK5CJxsAgO9dl4uCbgPbEXdvRkNrQYFFRxWgNa
	Em9R1c9k3kbqsdXo3xIGtqiGGCUdiF+NGJu7U/3dAsfFaa4EMNsgTdki7UyPhNGeV61+DuGXesl
	tdO+X9nzL/g0u+M+W/A9Rf8c=
Received: from ketchup (unknown [117.171.66.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4dQgVC0wtJz9rxQ;
	Tue,  9 Dec 2025 14:00:34 +0000 (UTC)
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH 2/2] dt-bindings: PCI: loongson: Document msi-parent property
Date: Tue,  9 Dec 2025 14:00:06 +0000
Message-ID: <20251209140006.54821-3-me@ziyao.cc>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251209140006.54821-1-me@ziyao.cc>
References: <20251209140006.54821-1-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1765288842007571500.21635.6149325618728624297@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=a8/K9VSF c=1 sm=1 tr=0 ts=69382b8a
	a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
	a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=CEWIc4RMnpUA:10
	a=luwqUdSl4_V6MCu2PjAA:9 a=3z85VNIBY5UIEeAh_hcH:22
	a=NWVoK91CQySWRX1oVYDe:22

Loongson PCI controllers found in LS2K1000/2000 SoCs
(loongson,ls2k-pci), 7A1000/2000 bridge chips (loongson,ls7a-pci), and
RS780E bridge chips (loongson,rs780e-pci) all have their paired MSI
controllers.

Though only the one in LS2K2000 SoC is described in devicetree, we
should document the property for all variants. For the same reason, it
isn't marked as required for now.

Fixes: 83e757ecfd5d ("dt-bindings: Document Loongson PCI Host Controller")
Signed-off-by: Yao Zi <me@ziyao.cc>
---
 Documentation/devicetree/bindings/pci/loongson.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/loongson.yaml b/Documentation/devicetree/bindings/pci/loongson.yaml
index e5bba63aa947..26e77218b901 100644
--- a/Documentation/devicetree/bindings/pci/loongson.yaml
+++ b/Documentation/devicetree/bindings/pci/loongson.yaml
@@ -32,6 +32,8 @@ properties:
     minItems: 1
     maxItems: 3
 
+  msi-parent: true
+
 required:
   - compatible
   - reg
-- 
2.51.2


