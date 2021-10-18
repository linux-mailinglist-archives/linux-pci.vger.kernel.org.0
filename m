Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB56431111
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 09:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhJRHJ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 03:09:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230444AbhJRHJz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Oct 2021 03:09:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B4E86127B;
        Mon, 18 Oct 2021 07:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634540864;
        bh=CEnqQn8efGo2ijFSZVkKGOzeZB2vyldoF2xv2gi1GPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j0GHCwHy+WkWSabbrQPbOnxr80wyI7y17ipBLPa0hWvVcIJVwM4ddrL/NQoAltEWw
         crCQGXCIvO/fZ/+WutBXI32PGqOt32G2ofRJjaoT/iOKxzWrt+MX9nCx9sYumJTghG
         Qy+trJfY/E40xBE3XtnocX+sCJUsBqZF9onnr8VhtLSgWaBW9SnJHbbKl+/ntCHaZS
         tTB6MwB/w2vOsvrR/DVxVk3j1KV1KF6z6gHFu/AkUN6CDRklYkhSQBNMx5yCgwm4p+
         kchN05fJfG9wGHjGhrvVMiNcUy7yhsVa2QmxvL5VSjBjw9vA18ntAH/RMeQCVc2xVG
         pAxmglrchRbmg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mcMkC-000IdJ-T8; Mon, 18 Oct 2021 08:07:36 +0100
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
Subject: [PATCH v13 10/10] PCI: kirin: Allow removing the driver
Date:   Mon, 18 Oct 2021 08:07:35 +0100
Message-Id: <2e4694a405dc49eb0a417005a65886e60adae4fe.1634539769.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634539769.git.mchehab+huawei@kernel.org>
References: <cover.1634539769.git.mchehab+huawei@kernel.org>
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

See [PATCH v13 00/10] at: https://lore.kernel.org/all/cover.1634539769.git.mchehab+huawei@kernel.org/

 drivers/pci/controller/dwc/pcie-kirin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index ffc63d12f8ed..efab2af093b6 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -828,7 +828,7 @@ static struct platform_driver kirin_pcie_driver = {
 		.suppress_bind_attrs	= true,
 	},
 };
-builtin_platform_driver(kirin_pcie_driver);
+module_platform_driver(kirin_pcie_driver);
 
 MODULE_DEVICE_TABLE(of, kirin_pcie_match);
 MODULE_DESCRIPTION("PCIe host controller driver for Kirin Phone SoCs");
-- 
2.31.1

