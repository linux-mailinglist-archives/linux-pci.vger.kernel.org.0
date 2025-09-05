Return-Path: <linux-pci+bounces-35552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEE0B4627F
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 20:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A124D17DEB1
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 18:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DBC2741C0;
	Fri,  5 Sep 2025 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="O+WAb/Q7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UG8A1lIt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF7BA42;
	Fri,  5 Sep 2025 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097779; cv=none; b=mHXvqGLqt1trCx4Stq99ANWkQqJBqeZxPZxV5iIuiW4wWzX1AGDTupidm4P/xGXj6RanZXfArgZdNj+W3nsduoiDeoRGmv1ntGUdyPMmGhQEHj6NxyEyKNqen5Xh8Zevq53Mh3AKxPhr904FYXHkZQEBBdwXouw3oCwKlCnoBqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097779; c=relaxed/simple;
	bh=E8b8dxChwNwDlcqRRyz694U+QlBhMByyuUVVGHBkpCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YPiNFUv3i7XoXO9MejfKOtLe/UHtNGOOhWtdN2rkvI770Hn5J6Pi2A2HbElcCtkHfyeeJ5M2SKmDIQ6v7qT98O1CmsvBrgoOykx9oRRhsve4udwmCBiwjLh0p2gPrxxgRAcni8VJXA/4u5nnxFW5qBAlPUn2+84QUQA9k5iU6IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=O+WAb/Q7; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UG8A1lIt; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cJQFq5gLDz9sy4;
	Fri,  5 Sep 2025 20:42:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757097775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XH2z8dk1aIBtC9igAXuw1MMQ+HESbem3MsiwJgT4haA=;
	b=O+WAb/Q7oa3VzIsi8KIm5UVhLGZutU8rLNX43Gi/n5ecXUBDs0b7sWknZ6SiatBCQfW3Ax
	WJp4QVHUwqVdC+39pmb/xgqBfGba0ZC6QGqjE3uOm3FVxGU509XLRx33QCwQNTGk9aAMvT
	oktLAWWecPjxfbgMtm2TvJmm7VpQaclrTy1zaQayHC/uHqy6DUSwcIW8ujCRqBFK3vhm9w
	ig9QKfCwYF4jawmLQvxYVkVW+52AeICurftHLZiHJv54e9qLvbRTnKBaZH/dXt/wTXGfaP
	et/zsbkeLepnYM+QDYRbXgA1tg+vWhosghjc8yXAh2oDwj06dOhrLG8nIGG0Qg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757097773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XH2z8dk1aIBtC9igAXuw1MMQ+HESbem3MsiwJgT4haA=;
	b=UG8A1lItzjav2j5kpiT1aOQhjim1eRPVSCIQNjc1CTvXv4gRyyvDLA78JdDFgmRgInq03/
	2Jaxot11h98nw22eeYVO18zkv4n9accWlfQkOT3AhQoyVQBQPzHLZM3z7dmCbSbouj3UzE
	9r6gRLuCX4Q7lgu+jUc9W8rEFEM+ntcEYqTjT5XH573qoyLTDhh52mJqD7zXRFhRZsA/sY
	opG+DelckW18syFTFTOOWKmAhQPBGZd/QSRgAUCI4Dl0ia4HMS6n+ECgwCgOQFyF6Zf0DQ
	D3GHdbXOKf2tjMIucXKLmlqd3lV0boLMsVQdB0uG9wFi/77ytDS9iJ4k84kFhg==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Wang Jiang <jiangwang@kylinos.cn>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3] PCI: endpoint: pci-epf-test: Limit PCIe BAR size for fixed BARs
Date: Fri,  5 Sep 2025 20:42:10 +0200
Message-ID: <20250905184240.144431-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9b6542a1c96162241f4
X-MBO-RS-META: 98qou455kri4u4y53yuk4mr7wzt9t3i8

Currently, the test allocates BAR sizes according to fixed table
bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 } . This
does not work with controllers which have fixed size BARs that
is smaller than the requested BAR size. One such controller is
Renesas R-Car V4H PCIe controller, which has BAR4 size limited
to 256 Bytes, which is much less than 131072 currently requested
by this test. a lot of controllers drivers in-tree have fixed
size BARs, and they do work perfectly fine, but it is only
because their fixed size is larger than the size requested
by pci-epf-test.c

Adjust the test such that in case a fixed size BAR is detected,
the fixed BAR size is used, as that is the only possibly option.

This helps with test failures reported as follows:
"
pci_epf_test pci_epf_test.0: requested BAR size is larger than fixed size
pci_epf_test pci_epf_test.0: Failed to allocate space for BAR4
"

Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
Cc: Wang Jiang <jiangwang@kylinos.cn>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: Simplify the conditional to always use fixed size BAR size for test
V3: - Update commit message
    - Add RB from Niklas
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index e091193bd8a8a..2418add64104a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -1050,7 +1050,12 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 		if (bar == test_reg_bar)
 			continue;
 
-		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
+		if (epc_features->bar[bar].type == BAR_FIXED)
+			test_reg_size = epc_features->bar[bar].fixed_size;
+		else
+			test_reg_size = bar_size[bar];
+
+		base = pci_epf_alloc_space(epf, test_reg_size, bar,
 					   epc_features, PRIMARY_INTERFACE);
 		if (!base)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
-- 
2.50.1


