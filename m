Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4B8432DBF
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 08:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhJSGJL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 02:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233786AbhJSGJG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 02:09:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7372F61355;
        Tue, 19 Oct 2021 06:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634623614;
        bh=1yoLD7UxQCKRek9SwmvM0DGsrQjtyzfsq6N4DgP+9Ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GkH5bq2EiUejCMe7IzYbb4pkRp8wb6ZYsMu7wWNuvzQp/i3yZUj+w7V9SCvPb+Lyl
         0dqRoYVuz9gWsu84PGxUp/fVtKJCKQHZXJP769BXWLWjpZjrK74uFMjl6JcLrp8064
         QEojuDO5OzQiz8E7UEFWbGjsj0yHPqLim8B6Ktzd02jracE4sliGEEG86HKkFIz3+x
         8jGRDQx3DOCjFWyLPT6OHK7zs6jgpKlzOaevbHcLISbz8Yvf+ZQLYprQ+bbACnNwV6
         8Ig7yVm+4YexcAwnr02Y7q+2jSPMqSyB+vTc10lD3YDR9Bip7sbSjzmHxXBEFix4Q/
         Jr+1ZtrI5mAyw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mciGx-001ks2-Tr; Tue, 19 Oct 2021 07:06:51 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Songxiaowei" <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v14 11/11] PCI: kirin: Allow removing the driver
Date:   Tue, 19 Oct 2021 07:06:48 +0100
Message-Id: <a0033f35cee9847a7d90aa7cdf3919a77c656130.1634622716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634622716.git.mchehab+huawei@kernel.org>
References: <cover.1634622716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that everything is in place at the poweroff sequence,
this driver can use module_platform_driver(), which allows
it to be removed.

Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v14 00/11] at: https://lore.kernel.org/all/cover.1634622716.git.mchehab+huawei@kernel.org/

 drivers/pci/controller/dwc/pcie-kirin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index fea4d717fff3..cdf568ea0f68 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -827,7 +827,7 @@ static struct platform_driver kirin_pcie_driver = {
 		.suppress_bind_attrs	= true,
 	},
 };
-builtin_platform_driver(kirin_pcie_driver);
+module_platform_driver(kirin_pcie_driver);
 
 MODULE_DEVICE_TABLE(of, kirin_pcie_match);
 MODULE_DESCRIPTION("PCIe host controller driver for Kirin Phone SoCs");
-- 
2.31.1

