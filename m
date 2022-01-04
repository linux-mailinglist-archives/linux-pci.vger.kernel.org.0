Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46024844D1
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 16:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbiADPie (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 10:38:34 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:39720 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbiADPic (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 10:38:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D2F87CE1804;
        Tue,  4 Jan 2022 15:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7EBC36AE9;
        Tue,  4 Jan 2022 15:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641310708;
        bh=BAz0sgl9jkfKnkSJVwW7u56anhqkAh5YBXeqtAKyf+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L+SHJXwP5tVS0BcMLd5wYZ78HFBj8s3KajKQIKoD3eIAxi4M4qHSBe5n3s4m4rQeZ
         GZJ0MyqHyTz+X9jBYgheZmg4mp9EzzkjabvbmiCsSkGMcwAHBw7mzthGezdot9mPh7
         7SVqMRq4dquPz7B85u6Vf8DlWpT0fYV4sxzTnOcx72hjdyw5StSsUFWxDxorigEjw1
         aLM6p2+QMiXifJMP/9E4wlvez2tw7JI2zBlkfwrKAPYd4VU8JFSfnF7cG6/t+vQU6w
         B+RIhOmUjAMO9X2/cXmGPLJmLBeqbS+x78jGq/r/Cm3cTTL1ERkPL0/bcPIubg5G6G
         GCtrA3pB/4DDQ==
Received: by pali.im (Postfix)
        id D76AC96B; Tue,  4 Jan 2022 16:38:27 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/11] PCI: mvebu: Remove duplicate nports assignment
Date:   Tue,  4 Jan 2022 16:35:24 +0100
Message-Id: <20220104153529.31647-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220104153529.31647-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
 <20220104153529.31647-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Member pcie->nports is initialized to correct value before the previous
for-loop. There is not need to initialize it more times.

Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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

