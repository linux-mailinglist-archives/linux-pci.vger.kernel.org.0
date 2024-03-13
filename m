Return-Path: <linux-pci+bounces-4780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFDC87A64A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 11:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70ED71C212D9
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 10:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B35A3D96E;
	Wed, 13 Mar 2024 10:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdlbhBQw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377DE3F9C3
	for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2024 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327518; cv=none; b=a3EbuZ5RChwxRzDf50pfT5ZReb/ewkfsMoD+fm+70Df0X1b1449vLivOoT7SzemQilGC9juq/Rx1skAtKIWXMqN/Z2EhLuZLzsgtxUO65tWwg1eMK13oalgO7JvYl1fMBtTl4CLM+qzhYBwEWj4MHvsk/qA5RQQH8EDgAx8tvMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327518; c=relaxed/simple;
	bh=u3NEnQH3hbpbvPQy3Ae5HxD+/6PFY6jbiy6uI31gAxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pULZdY+arzJd+nds+MiL2rkmuwgDHtIFg//Qsh4C/x2YM3srlII+7BS1bPvCaJdCONB3hiNOwRI2C5Uw4F5pPiuZpxvG6l1G6B6ID1gapdHs819cahgDJ363AK23rpi1byHqUoT4uIxYbX/ekuhXfyCjuwcTW7a4FVA1STDAX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdlbhBQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22C5C433B1;
	Wed, 13 Mar 2024 10:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710327517;
	bh=u3NEnQH3hbpbvPQy3Ae5HxD+/6PFY6jbiy6uI31gAxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DdlbhBQwV11Rd8XygsrCQy6TeNiaGppG5MGN6uXR3KZKnqbPN1n/LescPH2zVV/q6
	 MT7SJbyRgEmrDLwE6YcGXHn8DTUEGrODfxmGhCnYqYtLyPWJm4BNaogWlbZImYK0uB
	 EAcDJeVVswx+wV9oAMgxKdnc6DThKFASTGbHgJtEfocSH1Opa54JGaL/pYDdUgAZ/I
	 a2wx2HVMBFY9lXqQnDlugUXD0ySP6eFbiueMg7u9Qs6nLNs0eI95GFaii9HjECcXR3
	 esZa6FxF8LWC5Ob44n41My4Dj4UkXsBO/mztgg540DilD7/LrQ1Kf5357tSmR8yVUZ
	 3Vk/RxXS9ZWfw==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 6/9] PCI: endpoint: pci-epf-test: Clean up pci_epf_test_unbind()
Date: Wed, 13 Mar 2024 11:57:58 +0100
Message-ID: <20240313105804.100168-7-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313105804.100168-1-cassel@kernel.org>
References: <20240313105804.100168-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up pci_epf_test_unbind() by using a continue if we did not allocate
memory for the BAR index. This reduces the indentation level by one.

This makes pci_epf_test_unbind() more similar to pci_epf_test_set_bar().

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 91bbfcb1b3ed..fbe14c7232c7 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -690,20 +690,18 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct pci_epc *epc = epf->epc;
-	struct pci_epf_bar *epf_bar;
 	int bar;
 
 	cancel_delayed_work(&epf_test->cmd_handler);
 	pci_epf_test_clean_dma_chan(epf_test);
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
-		epf_bar = &epf->bar[bar];
+		if (!epf_test->reg[bar])
+			continue;
 
-		if (epf_test->reg[bar]) {
-			pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
-					  epf_bar);
-			pci_epf_free_space(epf, epf_test->reg[bar], bar,
-					   PRIMARY_INTERFACE);
-		}
+		pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
+				  &epf->bar[bar]);
+		pci_epf_free_space(epf, epf_test->reg[bar], bar,
+				   PRIMARY_INTERFACE);
 	}
 }
 
-- 
2.44.0


