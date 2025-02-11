Return-Path: <linux-pci+bounces-21211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87318A3160F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21DEF188A17C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F7E2638AC;
	Tue, 11 Feb 2025 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="NPj1gyI8"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C60326561B
	for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303685; cv=none; b=li3+TJoIpMa8nfblNh0dBYE/b3qzq64zfL+cD+uWDYg81lrmp0k40uOdb/hN+27ymElokvnmMC6QRY2d5+CnnPuS1cp5W5ZYIPej8/t03z28GIZk7bygftJR61o5gntjNcGpG8Y+33HjCd5/3xXOoZp6HBrm8pUIbGEqRyveiL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303685; c=relaxed/simple;
	bh=cRC6Mm9xvEF3QPvD9hkNc+NlaqTFkpFSLSGHFnrodP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GQgoZFqi3wQQqjfeaZmq+gBOGyU+LtEryf4/w7NFMdBYFlDOHH/dPqEXhzEualPFgMa1F+hJktRstZ7LRdvFz6X8iuA8ys4FV5thj2eB+OjLiBWagUH/hUk/hUynYwtqTcOhOEhRRTi/7l4kjLzQRpqDB/nG81iYzN+p68JqUOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=NPj1gyI8; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739303682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KETb6jUJDsIFYbLNfZswJFm0D8g4KXETeYZ9lpgFSZU=;
	b=NPj1gyI8ZymeuCqAhTbAbmYWvMnmfdxaADDxf9VoSVNMZ/at+eh/gHVHOFI/90EF3c2cQR
	UpbhkH4mQ+2HDpvCv0mtW86NI74Jvgjp99AHOFdUpur+LkYa5ISGw8G64MkGroTiuWl6Re
	W9JOwR8FVPmDlDmb5TnRoxof5qYy8tpZZ+S9uhN++aqd5Huo7O4g5i+sgmWfXIGD89GpeX
	701q+NNVX3Dnh/fBV8FMuQXpdxuUY+iHMWcyZfIoFahCiLEuvCy0JrpN310AafK458hE4G
	0YDj0/4ckIC+r6RM1DOogk2xor7BIhKlzviztDwQGL9NohnTgX0gtrG0jGhOZw==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Tue, 11 Feb 2025 14:54:28 -0500
Subject: [PATCH 3/7] PCI: apple: Set only available ports up
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-pcie-t6-v1-3-b60e6d2501bb@rosenzweig.io>
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
 linux-kernel@vger.kernel.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Janne Grunau <j@jannau.net>, stable@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=VQa9ECNMV5dQ+VPNHGrM6EfNjLD7vuIHAEUchvK/Y2A=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnq6r1foBi9YRZrXcHVAkQvYeTVMv9aps9Nidwj
 jtblZ/PGlCJAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ6uq9QAKCRD+/lBaCvVY
 DSxzD/9rBloDn6QBlNmK/61u1BJgVi4Dw6MNkUXbiP98cvMYhll8U+3HoGG8yje/h8NueaqDxBZ
 8iP89Scdg69/sCTU4EHBf2a3+uWS+8SSRmiDxJliskEzJ+xyG8f7MzPb2WLxuGbF/pspBm9RiFH
 kiiQ8Wi+HkS0oN0F5lMjc1cxcrW2O5DgfxSDsTbWfegmDfCH6R1GXnUMwpTfWYwI/fBCR4OSjh+
 1LdU3dGSC6wZvuv4ng2YlieS5f0N/jJU9keKq9al2kCkzr/mgSJun8TN9a0JT8N46JAgDWKKFzH
 OCJKtf0GHw+5cniAd6LP9AN6VMUNzaWoEqeNd3f2PGPa6qPG/Mu4lOLFi9ECzHLxuvlG9an0IwO
 G2eVoAGIsHtUgG5NOrGP0RgDzZLkBGFFGGK/ynQIISN0p9xHdTs+k814S/TcRkGtfnI7oQNMj1y
 OdXCBxhvJPRP4vIk6EPse1/RT7L1cjixTsNr6oF5UeSPn8sAv6PXP4wHuDQeSDYWQaSF7lVL2KA
 xlKEYjmy0GHMPdvJ6H2sROdftJIb0+SFabsQrHHwheitA0idvHkS2IOjBLm/38Rsz0ggNXJQnpT
 R1vJ23PAlTArB9RESOINl6YJO4RDnW4yYepnCILX4aHcFhOQ6U6GYCepgdR1PzurcaAUmeh6F03
 uh9EHFESSald4pA==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT

From: Janne Grunau <j@jannau.net>

Fixes "interrupt-map" parsing in of_irq_parse_raw() which takes the
node's availability into account.

This became apparent after disabling unused PCIe ports in the Apple
silicon device trees instead of disabling them.

Link: https://lore.kernel.org/asahi/20230214-apple_dts_pcie_disable_unused-v1-0-5ea0d3ddcde3@jannau.net/
Link: https://lore.kernel.org/asahi/1ea2107a-bb86-8c22-0bbc-82c453ab08ce@linaro.org/
Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
Cc: stable@vger.kernel.org
Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/pci/controller/pcie-apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 8ea3e258fe2768a33ec56f0a8a86d168ed615973..958cf459d4c64dffa1f993e57b7a58cfb2199b8f 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -758,7 +758,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 	if (ret)
 		return ret;
 
-	for_each_child_of_node(dev->of_node, of_port) {
+	for_each_available_child_of_node(dev->of_node, of_port) {
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {
 			dev_err(pcie->dev, "Port %pOF setup fail: %d\n", of_port, ret);

-- 
2.48.1


