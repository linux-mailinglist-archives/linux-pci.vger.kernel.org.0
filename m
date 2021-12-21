Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDD447C1FE
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 15:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbhLUO4x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 09:56:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43892 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238687AbhLUO4t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 09:56:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BCC66163F;
        Tue, 21 Dec 2021 14:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE3BC36AFA;
        Tue, 21 Dec 2021 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640098608;
        bh=JIc9DZvQtZV6dPDjTKJepvnaF8txTQekZ8XLf4Z30Bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAJWQLvJT5LTxmJCJ6lxdGPpgtcSiq13Vvn+OQ5USyhM8xP1qSBZp4Pz4A8K4FCJE
         X8odFUY10I0i/nP+UWT+BUeM33aeiDlqdPUHDqsFZr8ywu9ZxgWdfe68wmO7obOWQu
         RB84ejBxaZdmkhjMSlcUsJVoAmWExRewDLY+oiUsV7y4ujH7JHvl3xZ9B0lcSq1OMP
         6VfOq5B8X1iwdJjd4IWvaBJMZM1Ol0w6FJ9J0tHnyoi7aETmZnndm8lN70MxpRtoQ6
         WeJcsiDQ2I+szF4iHrsDWi+N69W18F9joP3aylG7iHWLLOlGt2feGPN9TzsEiQYILZ
         A7V6Luv50I41w==
Received: by pali.im (Postfix)
        id B0C792A85; Tue, 21 Dec 2021 15:18:14 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] PCI: mvebu: Remove duplicate nports assignment
Date:   Tue, 21 Dec 2021 15:14:50 +0100
Message-Id: <20211221141455.30011-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211221141455.30011-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Member pcie->nports is initialized to correct value before the previous
for-loop. There is not need to initialize it more times.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 2e10ade660a1..016f709b3067 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1337,8 +1337,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		mvebu_pcie_set_local_bus_nr(port, 0);
 	}
 
-	pcie->nports = i;
-
 	bridge->sysdata = pcie;
 	bridge->ops = &mvebu_pcie_ops;
 	bridge->align_resource = mvebu_pcie_align_resource;
-- 
2.20.1

