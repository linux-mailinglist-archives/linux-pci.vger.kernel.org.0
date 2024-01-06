Return-Path: <linux-pci+bounces-1733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B437825FAE
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 14:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C692B217F6
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5676F6FC8;
	Sat,  6 Jan 2024 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DU65tPTo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB47468
	for <linux-pci@vger.kernel.org>; Sat,  6 Jan 2024 13:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4785AC433C8;
	Sat,  6 Jan 2024 13:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704548076;
	bh=Mh7Tjmn58tpzvDk6szE0G7B5YY29XWuISdIGGbbZZRo=;
	h=From:To:Cc:Subject:Date:From;
	b=DU65tPTocy0xL3Izd+YnEDfz0yxgMvcLyKce47gXuHub/ccdb08jacDH072hRUSyj
	 Yn9VXDzbAbcphJG8JODqGHw5/xeZbfV1jNyvvmjjL1oGJysr7eiONSCoxzswcPqDdC
	 981fqZBc/6KdYaL+s4uVlzqxijHpevoXWKKDchLdjWxaiws2MMsBMfdj9utCfDgiuP
	 06tcfIUhF8ccUanREM6xqAfaA/MYOAO5IUTkE+mtz/NesZpzV1FkNnBKFUhqO55pG0
	 51KQYRjA34lWOSqsv2gw/BHYr2oxigGKM+etPGfvzcT/YvZabp3b8IaTJWY5+fwUNS
	 ZdT4qvm1KpVug==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: "Bjorn Helgaas" <bhelgaas@google.com>,
	"Thippeswamy Havalige" <thippeswamy.havalige@amd.com>,
	"Bharat Kumar Gogada" <bharat.kumar.gogada@amd.com>
Cc: "Michal Simek" <michal.simek@amd.com>,
	"Lorenzo Pieralisi" <lpieralisi@kernel.org>,
	"Rob Herring" <robh@kernel.org>,
	"Dan Carpenter" <dan.carpenter@linaro.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: xilinx-xdma: Fix uninitialized symbols in xilinx_pl_dma_pcie_setup_irq()
Date: Sat,  6 Jan 2024 13:34:33 +0000
Message-ID: <20240106133433.41130-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The error paths that follow calls to the devm_request_irq() functions
within the xilinx_pl_dma_pcie_setup_irq() reference an uninitialized
symbol each that also so happens to be incorrect.

Thus, fix this omission and reference the correct variable when invoking
a given dev_err() function following an error.

This problem was found using smatch via the 0-DAY CI Kernel Test service:

  drivers/pci/controller/pcie-xilinx-dma-pl.c:638 xilinx_pl_dma_pcie_setup_irq() error: uninitialized symbol 'irq'.
  drivers/pci/controller/pcie-xilinx-dma-pl.c:645 xilinx_pl_dma_pcie_setup_irq() error: uninitialized symbol 'irq'.

Fixes: 8d786149d78c ("PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver")
Link: https://lore.kernel.org/oe-kbuild/202312120248.5DblxkBp-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202312120248.5DblxkBp-lkp@intel.com/
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/controller/pcie-xilinx-dma-pl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
index 2f7d676c683c..96aedc85802a 100644
--- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
+++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
@@ -635,14 +635,14 @@ static int xilinx_pl_dma_pcie_setup_irq(struct pl_dma_pcie *port)
 	err = devm_request_irq(dev, port->intx_irq, xilinx_pl_dma_pcie_intx_flow,
 			       IRQF_SHARED | IRQF_NO_THREAD, NULL, port);
 	if (err) {
-		dev_err(dev, "Failed to request INTx IRQ %d\n", irq);
+		dev_err(dev, "Failed to request INTx IRQ %d\n", port->intx_irq);
 		return err;
 	}
 
 	err = devm_request_irq(dev, port->irq, xilinx_pl_dma_pcie_event_flow,
 			       IRQF_SHARED | IRQF_NO_THREAD, NULL, port);
 	if (err) {
-		dev_err(dev, "Failed to request event IRQ %d\n", irq);
+		dev_err(dev, "Failed to request event IRQ %d\n", port->irq);
 		return err;
 	}
 
-- 
2.43.0


