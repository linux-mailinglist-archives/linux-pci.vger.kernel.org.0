Return-Path: <linux-pci+bounces-2833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF98842CD2
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 20:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A16F7B22084
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 19:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6867B3E9;
	Tue, 30 Jan 2024 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqhj+ga6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581457B3D7;
	Tue, 30 Jan 2024 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643179; cv=none; b=a+i/i0I+7tt/2YuxEZlHhDZgqUp5CoDb0DG7cSADU//qfYAmJsTXP9m1H+b5YMurC17IA+AefJCga0SCOYKTCxTgn2+7r+LnwVDyOAZZ3HCpMGYW00tB3OceUczcSlyml6dnoaFvWNXAO7kG+4pUp8NBRDUc9ilBXofbrNkhsx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643179; c=relaxed/simple;
	bh=t1zaT2PqWJmTPD8CEXsvLf7gjiZz+GzDPD84WF2ALbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNikxT+NmeJkzB3OkCeA7wj1WoArMSupbyRLrOcSzSv3f0LbvjAly1ORi/Jaritb+O2OF5vITlKNe7118jZreANxFhZTcHVj5aDqu6Zg6VC5Np9XncWT9TnFReVFWPNu4hJzglb7cnJ+cvWy+ESpoFLV81gTb3GDRdmPHia0S9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqhj+ga6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4E6C433F1;
	Tue, 30 Jan 2024 19:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706643178;
	bh=t1zaT2PqWJmTPD8CEXsvLf7gjiZz+GzDPD84WF2ALbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bqhj+ga6J5EJIhQchzSWbTVYifYT4UUWWexEKOvFB6bQ8z3IJ8SwNoZbpV0rvrsA1
	 i7RVlokFqjsyabsXGwhJawzMh/m/JXGke2AHYLas+NVfDOKlMDSFQ0AtCa+fazReJo
	 vGPdXvaQoMbEVal1IcAwvbD6lbJWRBTbGwCG8sWoDvFZBE8Wzx8oQ5F9nWfmNSRWBW
	 RJzYKpx4BcjBDQEzCght4AL8bnqDwf67UdBtLJA+G6yW2QmYOsN4KETmlXH810oi2R
	 MPxYwo//wV2xiyeLejt4f6JZst88TZ7h2845ihwUmyRQXq/pcs9JMBMSwg7Wj9TXRv
	 xL2EM4FQeaCYw==
From: Niklas Cassel <cassel@kernel.org>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: [PATCH 3/3] PCI: endpoint: pci-epf-vntb: remove superfluous checks
Date: Tue, 30 Jan 2024 20:32:11 +0100
Message-ID: <20240130193214.713739-4-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130193214.713739-1-cassel@kernel.org>
References: <20240130193214.713739-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove superfluous alignment checks, these checks are already done by
pci_epf_alloc_space().

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index ba509d67188b..eda4b906868b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -527,7 +527,6 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 {
 	const struct pci_epc_features *epc_features;
-	u32 align;
 	struct device *dev = &ntb->epf->dev;
 	int ret;
 	struct pci_epf_bar *epf_bar;
@@ -538,16 +537,6 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	epc_features = pci_epc_get_features(ntb->epf->epc,
 					    ntb->epf->func_no,
 					    ntb->epf->vfunc_no);
-	align = epc_features->align;
-
-	if (size < 128)
-		size = 128;
-
-	if (align)
-		size = ALIGN(size, align);
-	else
-		size = roundup_pow_of_two(size);
-
 	barno = ntb->epf_ntb_bar[BAR_DB];
 
 	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, epc_features, 0);
-- 
2.43.0


