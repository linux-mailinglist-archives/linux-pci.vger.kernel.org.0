Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FC1435F86
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 12:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhJUKry (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 06:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230316AbhJUKru (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Oct 2021 06:47:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8DE861212;
        Thu, 21 Oct 2021 10:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634813134;
        bh=eLjGS50emBath6Dva8luhePYLJ4Az8GwBrWJmSsy4uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sYRpMVtzxNPkcsOF60SFW1uOdAQ1EHGjL/Hh9spBJtxXkOQltTAynSugOPk7YVgOB
         uTKHVvtxH5vBZbv/G9cxew4EeXQ7aEX8qw/zRiL1p2IUpc4HehWShHz+j7CtLubBg7
         YuiBp4o7K16S4CIDs/VY2ZoDi7P8uRBdXVtKIRMiUDx55UD9lNChFdA5tdkiy/xQNN
         tJZBlZ6+GizPKffv5ERxfUEYHjPrrkiezSXc4yBdgKnFDxAeyCZa5UCd4Zn2sFOMj+
         0niGK7alY+oIeAGEJMM3Wvv/INQ6u+tVgc9BC9ZV2YRkqi8e/EZwtDMvJbIMckntlt
         k5N5Stc7/i7Eg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mdVZj-002z5N-7N; Thu, 21 Oct 2021 11:45:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v15 12/13] PCI: kirin: De-init the dwc driver
Date:   Thu, 21 Oct 2021 11:45:19 +0100
Message-Id: <838621e1c84ebaac153ccd9c36ea5e1254c61ead.1634812676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634812676.git.mchehab+huawei@kernel.org>
References: <cover.1634812676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The logic under .remove ops is missing a call to
dw_pcie_host_deinit(). Add it, in order to allow the DWC core to
be properly cleaned up.

Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v15 00/13] at: https://lore.kernel.org/all/cover.1634812676.git.mchehab+huawei@kernel.org/

 drivers/pci/controller/dwc/pcie-kirin.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 4c3fa02b7108..fea4d717fff3 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -750,6 +750,8 @@ static int __exit kirin_pcie_remove(struct platform_device *pdev)
 {
 	struct kirin_pcie *kirin_pcie = platform_get_drvdata(pdev);
 
+	dw_pcie_host_deinit(&kirin_pcie->pci->pp);
+
 	kirin_pcie_power_off(kirin_pcie);
 
 	return 0;
-- 
2.31.1

