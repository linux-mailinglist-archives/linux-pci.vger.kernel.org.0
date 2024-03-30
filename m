Return-Path: <linux-pci+bounces-5438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E5B892945
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 05:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751F81C2109A
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 04:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4D18BE7;
	Sat, 30 Mar 2024 04:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhUxeh/U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273D2883C;
	Sat, 30 Mar 2024 04:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711772391; cv=none; b=BPF9R3ISQvlLxxVfocHT1D9gZwyM3Kf53ksJeye+od3vd8vie91LCIgK0CCCbAlTGv/6+jd6sis6QuL7po4epDCt8GbKADgkHW0hsbymmLsB+55ctI8slj9rhk92bnW0/7LrbCDCmwdkvWqFiH9hL3YT0oL+ehUiHLP6vYpvvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711772391; c=relaxed/simple;
	bh=7Csd0n7kv5QXdaAzg91Mtj2IgQHbVhJebQ8xA5NsDJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5ZMZrSjvY1ENOGooXOr0EJpE+rPP7H7+9FnpSQTHdVIsKqF159Ullr/ovUPujFnJ/82LFPbo4sIAGP4V3BaUxnKIPtLheR6XqN2Pp76oDAYfD20uhiXPRfrdyI7+TP0eqOri5/6f1FD+V9JSiCgZrxAL+dpdJ6p4BuOgYRQRhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhUxeh/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06708C433B2;
	Sat, 30 Mar 2024 04:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711772390;
	bh=7Csd0n7kv5QXdaAzg91Mtj2IgQHbVhJebQ8xA5NsDJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HhUxeh/UoT/YQhTuYt6KJtbteVy+/KnhJ2v/zGKS5C9UfPfA311npSI+qTeVV3veU
	 vINHMF2FHveAHt7qWXXPha5EL0DE8gBuVMg7ZKdFAMJl9ERQp1I8txkig671PxQqSB
	 ARYxkJ5CTbwQLeJe9A5qcMZgRLSgzg0r/FV+EE9XfCqDgP1aUAXG0/3EXxkJQCV9eN
	 KsTX78SMG8dJdK3+lvWiuhi4DNz1IOhitT3ERABCdj7qrxeorF8wu5MGnhf6+oPLTc
	 gkWwaLzgbn/ynIFk1v93uwNK6qjg1f4noL6dh5AhQJrGCaGVD7R3V0tgtXiWR58L1P
	 mchOjcl0kYzqg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 06/18] PCI: endpoint: test: Implement link_down event operation
Date: Sat, 30 Mar 2024 13:19:16 +0900
Message-ID: <20240330041928.1555578-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330041928.1555578-1-dlemoal@kernel.org>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the link_down event operation to stop the command execution
delayed work when the endpoint controller notifies a link down event.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ab40c3182677..e6d4e1747c9f 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -824,9 +824,19 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
 	return 0;
 }
 
+static int pci_epf_test_link_down(struct pci_epf *epf)
+{
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+
+	cancel_delayed_work_sync(&epf_test->cmd_handler);
+
+	return 0;
+}
+
 static const struct pci_epc_event_ops pci_epf_test_event_ops = {
 	.core_init = pci_epf_test_core_init,
 	.link_up = pci_epf_test_link_up,
+	.link_down = pci_epf_test_link_down,
 };
 
 static int pci_epf_test_alloc_space(struct pci_epf *epf)
-- 
2.44.0


