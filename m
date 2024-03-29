Return-Path: <linux-pci+bounces-5381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D5A89156E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 10:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F3D1C213C7
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 09:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0485939FCE;
	Fri, 29 Mar 2024 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsMFTM1E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B5F36AE7
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703398; cv=none; b=kAEt+o8oolqofPS3bZi///SXVXanoclITryWwvRQ05z9lk9xycGS41JL7S5xhOQLCOdbsZWMisj8tRdAbzcsfuGWpoGjP476HjqGDO3PGVVqY6oGUaPdTdk8eGjvOQmoo1K7hcVw/2JvRzwCsg3ZFz2kvu8ALYcgZBKR9ev6s6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703398; c=relaxed/simple;
	bh=eTw3lNRbr8KXVdzPW1SwocJ9mAakSZelSr8uef0y60M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLOt/9ikTprxz3NhqHxqaAThnGYkidI8QDp+KEpZTOLzZlcudF56AC+qis2T9PQyMkw/AHxEsB47B8DrIFH3obEtk/Ji466yNENZLVBl6kjP0IYO8dutm52kswYciO3kmXaJyQCK5J6BhGzY0PcQXwf9y3vE+I/8WHfNVQQk8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsMFTM1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91675C433F1;
	Fri, 29 Mar 2024 09:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703398;
	bh=eTw3lNRbr8KXVdzPW1SwocJ9mAakSZelSr8uef0y60M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qsMFTM1Ew65BHQoYV3KHaPWQd6rEco0sqVcsiPqHgl9DuPL0JH9weqtPKbIDX3Ieo
	 wzpiUYmcVXdXHroGXMTtXo3MgTx6tKeEiQKFH316spSegRQBD4weQlRmq7/4tYAkNN
	 +GTtDZHSriUsE+kh8Nv60xN1xhG7M2VwgD1PUTbh5Kd7xnezySUUNTGjUKlMhC4Axg
	 69TT4SK1g9frPqSK8EheIM6mIATAc48hKoYwddc6fNE3ypBKisBzKJdE+8mqljeYeV
	 tsHJte5xWdnYfiGO4+7MZVhJSUricm+zXOi6A5IpoS1kBS033ZRUdN2NalqqWdI97S
	 7yowI7FWpbZUg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Subject: [PATCH 07/19] PCI: endpoint: test: Implement link_down event operation
Date: Fri, 29 Mar 2024 18:09:33 +0900
Message-ID: <20240329090945.1097609-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329090945.1097609-1-dlemoal@kernel.org>
References: <20240329090945.1097609-1-dlemoal@kernel.org>
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


