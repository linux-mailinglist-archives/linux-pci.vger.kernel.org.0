Return-Path: <linux-pci+bounces-34188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BE4B29E21
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 11:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07EEB1896CC0
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B7230E83E;
	Mon, 18 Aug 2025 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUSdn8u/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335E212575;
	Mon, 18 Aug 2025 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509710; cv=none; b=E8lLtfkuAw2N2JfCDt+ivJ7QXga+9H7U6mcGi4vRcs2HeT9HY3yPYTYomOIrEzu1SMC2qBcI4xg94Iv+V+stUon/DHaSp732N6FAxctKGRZlNOiFyEKmrhOEzD8EwjIglPtwjtU7qxxa7RGqcdSm8xCxT5gOgL9z3V/9lNkRI0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509710; c=relaxed/simple;
	bh=rNwl2lgK/CJRrcZxa4Dc+9tNcynpL7lokinB7iQZH/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fdAUO4t4C5QlrBcNbuC20IE+pM25odpgwWAIVBmieSqybMtFHxvp4eGbTKDQNHgSF6US6E1PT3zNSFNe4teEcnU7cvp/3KrjefRMc/S0BHWUijSX8c2B66dPd8malFuya2+K4rEqdWqy0iyfPtY2OTFnepYr1fS5L6QFtKHXe3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUSdn8u/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C72C4CEED;
	Mon, 18 Aug 2025 09:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755509708;
	bh=rNwl2lgK/CJRrcZxa4Dc+9tNcynpL7lokinB7iQZH/k=;
	h=From:To:Cc:Subject:Date:From;
	b=EUSdn8u/CKDv5sEvNbKKfsSPPyNCNZXgK1/tMS4lVGj3TNP2Hyf5wH6wMb1fNzqZU
	 Mr50wKLqNY+GFITkdAcv28XOZ/+Jd+a8GbFo2uZjmOoTfEww6aWT0OLC9ehdu8Izig
	 uZUslazQneIgjD4PYlarMWMzyyWdwQkmGmaz6ksLA+Pn6rR2wiL8eZUEDukKliDBcE
	 +aWKBf+O5UwatQ7uAAP/djOWL8AwssmSFwRhjqB1R+YtrlEr/QNP86VCR3FxkP2q2X
	 Wy+J/sMmltb0+pPNFibvQfeaaiROGbvWWQw49IInO4rb7Cw2/K1VLjcl2fWCUbRbMK
	 kg5iratASL3Hw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH] PCI: of: Update parent unit address generation in of_pci_prop_intr_map()
Date: Mon, 18 Aug 2025 11:35:04 +0200
Message-ID: <20250818093504.80651-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some interrupt controllers require an #address-cells property in their
bindings without requiring a "reg" property to be present.

The current logic used to craft an interrupt-map property in
of_pci_prop_intr_map() is based on reading the #address-cells
property in the interrupt-parent and, if != 0, read the interrupt
parent "reg" property to determine the parent unit address to be
used to create the parent unit interrupt specifier.

First of all, it is not correct to read the "reg" property of
the interrupt-parent with an #address-cells value taken from the
interrupt-parent node, because the #address-cells value define the
number of address cells required by child nodes.

More importantly, for all modern interrupt controllers, the parent
unit address is irrelevant in HW in relation to the
device<->interrupt-controller connection and the kernel actually
ignores the parent unit address value when hierarchically parsing
the interrupt-map property (ie of_irq_parse_raw()).

For the reasons above, remove the code parsing the interrupt
parent "reg" property in of_pci_prop_intr_map() - it is not
needed and as it is it is detrimental in that it prevents
interrupt-map property generation on systems with an
interrupt-controller that has no "reg" property in its
interrupt-controller node - and leave the parent unit address
always initialized to 0 since it is simply ignored by the kernel.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Lizhi Hou <lizhi.hou@amd.com>
Link: https://lore.kernel.org/lkml/aJms+YT8TnpzpCY8@lpieralisi/
---
 drivers/pci/of_property.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 506fcd507113..09b7bc335ec5 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -279,13 +279,20 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
 			mapp++;
 			*mapp = out_irq[i].np->phandle;
 			mapp++;
-			if (addr_sz[i]) {
-				ret = of_property_read_u32_array(out_irq[i].np,
-								 "reg", mapp,
-								 addr_sz[i]);
-				if (ret)
-					goto failed;
-			}
+
+			/*
+			 * A device address does not affect the
+			 * device<->interrupt-controller HW connection for all
+			 * modern interrupt controllers; moreover, the kernel
+			 * (ie of_irq_parse_raw()) ignores the values in the
+			 * parent unit address cells while parsing the interrupt-map
+			 * property because they are irrelevant for interrupts mapping
+			 * in modern system.
+			 *
+			 * Leave the parent unit address initialized to 0 - just
+			 * take into account the #address-cells size to build
+			 * the property properly.
+			 */
 			mapp += addr_sz[i];
 			memcpy(mapp, out_irq[i].args,
 			       out_irq[i].args_count * sizeof(u32));
-- 
2.48.0


