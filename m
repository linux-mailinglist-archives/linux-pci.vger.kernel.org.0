Return-Path: <linux-pci+bounces-5259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB3088E357
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 14:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21FA1F280B4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 13:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ED1181BB2;
	Wed, 27 Mar 2024 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKG0/+Kx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3752E181BAC;
	Wed, 27 Mar 2024 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542317; cv=none; b=nG+remQwbAF3tjdIFEfSFO1iZCgTmRdAaZieNi4Y16NJz1b887tMXVLbmpAa7EVV8cmmBCuMCKY8Qk04C8O2EjrpO+eyVTWlWwOUJ5KzhJMaCBZycQaixIdz7HsWrp20WQAP4rmF/9DBacXAwfslihgiceHIXdJ+UoVPtZO6fI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542317; c=relaxed/simple;
	bh=Lbr7IoAyrDhiLzvuJzo9IGXeuw1UGQU0B8IX5xK2H+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBOj9NrONB4SWqylfRFcsTcVHbfPr3MKxdJcAVHdLtHhW1bArcA4PN8EJcM1Xo9qlQg2B84vfL8AHhFs3DqERoQDiggBrASIffsZPAzN8XgTVUzApj2Jt3AH+JpQA9aN0n9V4HXjLWnFxpEeKad4351r/Vyt87oOtxSjAX5dHuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKG0/+Kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB2CC433A6;
	Wed, 27 Mar 2024 12:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542317;
	bh=Lbr7IoAyrDhiLzvuJzo9IGXeuw1UGQU0B8IX5xK2H+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IKG0/+KxX65U8B6XpOGDDqAnJTt+kb8aYVgZVTGIIpD0/6rdJUY93+ccYMTxo7IFf
	 LxuZ3RXakM8fegH9uin6VNqDqC6iqCpicoHl1u0Mgi7spfRpjl9uPpFtDKdqmp4RLm
	 QfDGm/DmxnEoUsPk15G/Z29HFv2bws5U7xOtI004KDQd/i+VD5JBOc1sSlWqEThj5A
	 x294jM3hfwg8lL4SkUw7/S7jPbQ4nTp+3lqWRFPO1e43J1L8cMG+/8AO9xhf6tx3YO
	 YzakB6MjgI2zzH1QsxN2LECunJvf1q9iMk6HaJiFSnHNxxvVAC6oHU4GvECZfehSSa
	 DyY8OGa8cEwNg==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Jamie Gibbons <jamie.gibbons@microchip.com>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v1 4/5] dt-bindings: PCI: microchip: increase number of items in ranges property
Date: Wed, 27 Mar 2024 12:24:39 +0000
Message-ID: <20240327-debunk-perky-f5514ca332be@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327-parkway-dodgy-f0fe1fa20892@spud>
References: <20240327-parkway-dodgy-f0fe1fa20892@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=945; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=buQq0yDz7uxZQBF0BhuHfxwtzcUDoTRsuZxOB+uRXCE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGksAmxvph4tLRbY8dV+n4ex5fzX1dfyc423lMvFPOeWm sV8+UZsRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACay7BfDP7UKSWH7FpHjCadu feA3O8MZbdTkc5atf4PHCgsfw0v5exgZFh1rWJJvfVfzX/L1688fGPueFpf4EHqXuWSm3bu3h9s ncwMA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>

Increase the number of items in the ranges property to allow up to 3
ranges. For example a prefetchable range, a non-prefetchable range
and an IO range, depending on configuration.

Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index f7a3c2636355..e8212a05b7b1 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -65,7 +65,8 @@ properties:
       - const: msi
 
   ranges:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   dma-ranges:
     minItems: 1
-- 
2.43.0


