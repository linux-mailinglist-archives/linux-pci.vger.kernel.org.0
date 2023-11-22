Return-Path: <linux-pci+bounces-88-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC8B7F3DD8
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB66AB21746
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60788156D9;
	Wed, 22 Nov 2023 06:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcEukota"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFD512B96
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E62C433C7;
	Wed, 22 Nov 2023 06:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700633054;
	bh=SnW/Kwsc2qPoMfm3fZFzBAtav2ujA+WVQ3FCswV6if4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YcEukotao28ly1CQhe5UpTULng7pwmrJbiYB70Z/TQKYWoiMkcZcB41DeeGklvgS4
	 Gj0oeMLHuh7MVDaiAjPxop/SJxsnhjGFjybx9vye63zeA35FIHm5ctPrOwNT8auhWZ
	 qePrsHYlM2Xb39HnXzDe7Bg6+tfvkwBwngg29PFkqxo8h8KvXNealD+xEgA5ijpblG
	 NK3puMaotD/xvw7gGCniQ69w5kBi5poAsMm83urOVuHOzXd0Sz5qX3wbVjwZ3P5sQt
	 BU84HUSTy5zdhP9454CkAKUus9mLzs4nUsPoWDtyUS4HKiiLWGF699KXIvy+dadtjH
	 q0IE9d5Dcr+Yg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 03/16] PCI: endpoint: Use INTX instead of legacy
Date: Wed, 22 Nov 2023 15:03:53 +0900
Message-ID: <20231122060406.14695-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122060406.14695-1-dlemoal@kernel.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the endpoint controller core code, change references to "legacy"
interrupts to "INTX" interrupts to match the term used in the PCI
specifications.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 0810420df42c..dcd4e66430c1 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -211,10 +211,10 @@ EXPORT_SYMBOL_GPL(pci_epc_start);
  * @epc: the EPC device which has to interrupt the host
  * @func_no: the physical endpoint function number in the EPC device
  * @vfunc_no: the virtual endpoint function number in the physical function
- * @type: specify the type of interrupt; legacy, MSI or MSI-X
+ * @type: specify the type of interrupt; INTX, MSI or MSI-X
  * @interrupt_num: the MSI or MSI-X interrupt number with range (1-N)
  *
- * Invoke to raise an legacy, MSI or MSI-X interrupt
+ * Invoke to raise an INTX, MSI or MSI-X interrupt
  */
 int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		      unsigned int type, u16 interrupt_num)
-- 
2.42.0


