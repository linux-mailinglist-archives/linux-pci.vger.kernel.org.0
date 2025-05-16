Return-Path: <linux-pci+bounces-27845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E142AB9995
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 12:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24711887715
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 10:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC743231839;
	Fri, 16 May 2025 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSx8XvD4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8722AE8D;
	Fri, 16 May 2025 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389619; cv=none; b=UeA5yxuuuvM5DPwdT9Kx/Z/rQoP/p1tUA/sgP3z9SvZFlkDJbx/T+A2uc8XJqOuhZj+6oYjbAHz4000ligjByXOOsZoEtJAUski/nmH0axbjoDIBFeqIdYhgRNJZ6Dh2oa/wGC3OGfz1egMWCDZvDS2jNPBPfhXuDBvHE7tLgMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389619; c=relaxed/simple;
	bh=5gBmY6Zk+Ryoef5Q5jQQugVJJObL7Jg/Otn27Xfx+H8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQV3oTW2inuxWcwnoP1aWgM7l2UBgUyRjKfzTUgWacwGNibQFi4my2aoeFEmTown/2gGrUw4tj64Va5PpEDubGW1imk1yQOj/cH95354EPAznUGnGllRxpYE6bCif7yeKcRDBrZGRaEpCY1vwkV9Vr9ADUrr8T3V6BLPS+VzT1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSx8XvD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF03C4CEE4;
	Fri, 16 May 2025 10:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747389619;
	bh=5gBmY6Zk+Ryoef5Q5jQQugVJJObL7Jg/Otn27Xfx+H8=;
	h=From:To:Cc:Subject:Date:From;
	b=VSx8XvD4L3DRtchGh9gq++02KQtnShOLeYGZ7ch9CAbebcnQtg7Jk8J9jHU41wEVp
	 wMpRPxUCauKCBiVgz7BD9HVQhZupWTqXR3dEvwPQaGXK3H3XL5ZJ5Cf5GRq065j4M4
	 /JYU7bV+k/s5oGYr73DRfrrq6wPPSTCGkHFwANEgQ6jszgKZbaMpYnV6UB60gpOVWt
	 nIqvnKCGwQW6Kj2WgY7YB0aRwX8kcZfEE6UP3nRh1t0QDGVSRVFLwoLlE+kMm/PuSV
	 RIaeJL3q83gvYF77uQV9u1yQ4X+5WS/2hMIxeUmjXWgs/ljpoPtexsKnnbgCEcDyj2
	 6LvbSjYmsUu9g==
From: Conor Dooley <conor@kernel.org>
To: linux-pci@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: PCI: microchip,pcie-host: fix dma coherency property
Date: Fri, 16 May 2025 10:59:39 +0100
Message-ID: <20250516-datebook-senator-ff7a1c30cbd5@spud>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=kx7hE+1jGLWfA9X6Bwyb2haBWtsA8+rtUy5OmaCwQdc=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDBnqPN0/mbbyiVTk71zjNSupn+nhry1TFJJP7L48+fCrs xnbD1XkdZSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiZ2IY/hm+nJUe9Gld8wLf 7CnWB6b/vbbZyba/dNqUW8yepffZxMoZ/ofZF6yoTZrN8VlGquy85/MuPq0Fsa5dXTYtvUG7HY7 l8gIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

PolarFire SoC may be configured in a way that requires non-coherent DMA
handling. On RISC-V, buses are coherent by default & the dma-noncoherent
property is required to denote buses or devices that are non-coherent.
For some reason, instead of adding dma-noncoherent to the binding
the pointless, NOP, property dma-coherent was. Swap dma-coherent for
dma-noncoherent.

Fixes: 04aa999eb96fd ("dt-bindings: PCI: microchip,pcie-host: Allow dma-noncoherent")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: linux-pci@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index 103574d18dbc2..56397df2a6eec 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -50,7 +50,7 @@ properties:
     items:
       pattern: '^fic[0-3]$'
 
-  dma-coherent: true
+  dma-noncoherent: true
 
   ranges:
     minItems: 1
-- 
2.45.2


