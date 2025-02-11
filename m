Return-Path: <linux-pci+bounces-21210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EDFA3160C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85193A05CE
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E8B262D1F;
	Tue, 11 Feb 2025 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="pDEX3FAD"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361D226563B
	for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303683; cv=none; b=IP4JiZB7r7llPpc6TCnHTVIVO9y3Ara+yZLdeWvtVnLA8e+XRo7EK390AfitO4I/0toY1jKSsTIkmgzppiL1Wdxbn5tV6gCGXNtUGvwuhsQN564dc102QeYDYxa/4JYhuhnvUfzRgg0hpMSgzZ89u2pcsYympBzG5XW4TxSFaIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303683; c=relaxed/simple;
	bh=yl+USkLKEMh9QsdKOr60k5N73ynmCqgb8FX+a+0tI1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hCPwQeGkVnpkJRnMfHUu0u4PFMTGZ6KF56TffljTn0beT5FUBG2lfmm1Y/J9dJadKUqEM8R8UE6ZL6xhV7T0xjYVmYzcrAfJiH0Ba7aq9Hfbt90+Ppfy2GOFO2ZhFhSgKLCwzfKohnAfeouHnfL8FRFZmQQGzshEHqE4rLwGFTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=pDEX3FAD; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739303679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94QHz8s3x5xn+pO8rBCK3/IvZxkKB7/6zt01u+1XuTM=;
	b=pDEX3FADIaxZqP3isL/WiMyLef1K4xb9sxTX7LRopb4HsNgAR6VYntUTm4OhNJ6V1ZqCNO
	uRYkF0RR5WbaKAGWRZf0N4RBMib6cjbYWFRN2szniy9IE5gOEFvi3QKUUUPaLwqCnTVkLk
	uwE1XS1V2ldcaUQox8EDq9meAxiOAzzyf6OBL+ztG0B9Kfq64Rxg14wzyleimmABWnutSC
	vk+UcuDyDm0AwrQn5e3ID5G9o4UYqfJ4B02UukNqbXvB6+81OHaVZwtsW89fbEqBeaQebz
	+d+TQmBvQ4Sbnpv/GABq7Qe3WUu1BwkOfS8rhvJeqcuFgO5bLcdwsGCmonkLKA==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Tue, 11 Feb 2025 14:54:27 -0500
Subject: [PATCH 2/7] PCI: apple: Fix missing OF node reference in
 apple_pcie_setup_port
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-pcie-t6-v1-2-b60e6d2501bb@rosenzweig.io>
References: <20250211-pcie-t6-v1-0-b60e6d2501bb@rosenzweig.io>
In-Reply-To: <20250211-pcie-t6-v1-0-b60e6d2501bb@rosenzweig.io>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Marc Zyngier <maz@kernel.org>, Stan Skowronek <stan@corellium.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=br8u3Lwb/VWy9zwnA4KwWQFXuGukXNpIxSbrSFqjuw4=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnq6r1lSpZWagAS4cG/cY2wbT3jejBBZIBmSm+c
 HyLBDRftpiJAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ6uq9QAKCRD+/lBaCvVY
 DTX/EACUiHlwws8oozaS9C1v7YbZPWIKXIdhfYeASI4iF7fyekhYgal15Vnzf/jqgkN2Ma7vARE
 LOc23fkA9UBb0ydPBMRvOH3PyMzd1LZkrVTgBKkPqp0PN6o8XOB3MBdR2h2OB97ijw0rhJ0gds4
 yvE2X2F428EGB7LFX3/RAO9RhmZm54WpYy1ZMlh5UpLWKPi7NV1mErTYOs7ED2dFcaGOlg/ZekL
 1iFMNMmDCOX1vO0d1lFOl3/DGkoGmbCJlcATohXlsMfTApneIyUj92wmNUVgXjL/PEuLxFRTLcp
 a2Qr0qUK8disAbWvUQ+EFhvkc4qheHUaU5qukpSfTZdg81aznoVxSO4p44h5ihIDBr4KZlJLGaw
 0kAElwx+RZyQ/SSLjdgX+CAPxkC8Ir7MULoIX/t8LdWvXqk3NJJDxV4pFbnr8Z0KgD+URZXM5TL
 IulEHFmdkqEP3ZtmqqJg45zrTdWy2gZkGKhj4L9goQyTTaQt7w9fKaWX+rQqxqFkwvv86Ad6+NY
 eyO8G5FagnpQJhjyqGBPKP53Gb63LmTNX/coWpXY4H3AsyeIFJD7DERYM42A0EIsplFeZa0hE5O
 SkmOz4ly5bDySc1nGE5VoKjQm/sJO7S2u4WOXmbRktKy5xJedSE7dGzkJGdlZzQac/4heXHon3X
 Nb1lCU+DOd7WJow==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT

From: Hector Martin <marcan@marcan.st>

In the success path we hang onto a reference to the node, so make sure
to grab one. The caller iterator puts our borrowed reference when we
return.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/pci/controller/pcie-apple.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index a7e51bc1c2fe8ec31902816e9be6749b756ec77d..8ea3e258fe2768a33ec56f0a8a86d168ed615973 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -584,6 +584,9 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	list_add_tail(&port->entry, &pcie->ports);
 	init_completion(&pcie->event);
 
+	/* In the success path, we keep a reference to np around */
+	of_node_get(np);
+
 	ret = apple_pcie_port_register_irqs(port);
 	WARN_ON(ret);
 

-- 
2.48.1


