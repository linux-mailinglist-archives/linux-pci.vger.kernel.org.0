Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5187947DC8E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 02:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbhLWBLQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 20:11:16 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57468 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241087AbhLWBLP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 20:11:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C6E4ACE1EFD;
        Thu, 23 Dec 2021 01:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF62C36AEB;
        Thu, 23 Dec 2021 01:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640221871;
        bh=hG00kWbWXHmSwWgo7vfy0tK/cDWcyfPAdzTXQsCGsWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+Vhgkel6nBIgd3Ta4wvAsw2WlgcLdYXD3cSEXHxLLiDWWxoGyEGmpqbeJgJzeDoo
         gJQ/BAkHieRO0ishtxWcvqeCqG6bU4kpHO08y0QHVPPlpOBttVn5uHJyW/dloPsx4t
         eIMi1BoWPoV9eRar3/BZlTxj6LZ6SoCukCKk/04UlRhdWw83SgCf/1p/yHSygSr6lZ
         tLwwCL7N5mg4s4bq6gLvPbNXEyAHWJb/3EfQdVS9wnr+IKOKh2DeO19GNDvoM2c3at
         joUqfXPw8GSvk7m892YHzlBvz2wbie6+VW6d2XipZjZtjNSxOfRIxilRuPivUduA5z
         qLjKBCPlhzk0Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Fan Fei <ffclaire1224@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joyce Ooi <joyce.ooi@intel.com>
Subject: [PATCH v2 01/23] PCI: altera: Prefer of_device_get_match_data()
Date:   Wed, 22 Dec 2021 19:10:32 -0600
Message-Id: <20211223011054.1227810-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223011054.1227810-1-helgaas@kernel.org>
References: <20211223011054.1227810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Fan Fei <ffclaire1224@gmail.com>

The altera driver only needs the device data, not the whole struct
of_device_id.  Use of_device_get_match_data() instead of of_match_device().
No functional change intended.

[bhelgaas: commit log]
Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joyce Ooi <joyce.ooi@intel.com>
---
 drivers/pci/controller/pcie-altera.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 2513e9363236..98ada2e20e02 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -767,7 +767,7 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	struct altera_pcie *pcie;
 	struct pci_host_bridge *bridge;
 	int ret;
-	const struct of_device_id *match;
+	const struct altera_pcie_data *data;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
@@ -777,11 +777,11 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	pcie->pdev = pdev;
 	platform_set_drvdata(pdev, pcie);
 
-	match = of_match_device(altera_pcie_of_match, &pdev->dev);
-	if (!match)
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data)
 		return -ENODEV;
 
-	pcie->pcie_data = match->data;
+	pcie->pcie_data = data;
 
 	ret = altera_pcie_parse_dt(pcie);
 	if (ret) {
-- 
2.25.1

