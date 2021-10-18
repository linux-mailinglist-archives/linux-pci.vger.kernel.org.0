Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2A6431108
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 09:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhJRHJv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 03:09:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230346AbhJRHJu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Oct 2021 03:09:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3FB7610A3;
        Mon, 18 Oct 2021 07:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634540859;
        bh=Jaz1dCWkfUPQBIPDA93cbPW9Lxs0mZkpHgPjwVulMzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/osVfDlLS8iqNhRj28riWiaGbiZaYUDP/hELwaVRmly+03g4xohRHsjQhgptv0F6
         7ioF09jQgE7xh3EuNOx+8FbWV3R9oa+KNagHspzoFZq2K7ihAWYWfp9iKPIMg6HhNq
         wRR+EGCPqbhCYj1W30XLgo4zRpTTIKwRwkFEMtXTR3fK59xo3C05lTHrbc4LZAMN6M
         twajz/PIHSFefOTsLZ72BPmmPx5vFt+5ClaM6qucMVo8zuiZawJNM83b9SRXhM8cAh
         VGdhwqrq6zlXFS0kc4gWDXz4pZpyLy9r2F1z9M0FN2kotsXiHESXfGcTk6xHFARMh8
         FG81CC4YzhgUQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mcMkC-000Id7-RH; Mon, 18 Oct 2021 08:07:36 +0100
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
Subject: [PATCH v13 06/10] PCI: kirin: Add MODULE_* macros
Date:   Mon, 18 Oct 2021 08:07:31 +0100
Message-Id: <cbcae9898145cd3b93a2e3d9143327916e4c10f4.1634539769.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634539769.git.mchehab+huawei@kernel.org>
References: <cover.1634539769.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This driver misses the MODULE_* macros. Add them.

Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v13 00/10] at: https://lore.kernel.org/all/cover.1634539769.git.mchehab+huawei@kernel.org/

 drivers/pci/controller/dwc/pcie-kirin.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 4f4c86b92353..d5c29a266756 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -804,3 +804,8 @@ static struct platform_driver kirin_pcie_driver = {
 	},
 };
 builtin_platform_driver(kirin_pcie_driver);
+
+MODULE_DEVICE_TABLE(of, kirin_pcie_match);
+MODULE_DESCRIPTION("PCIe host controller driver for Kirin Phone SoCs");
+MODULE_AUTHOR("Xiaowei Song <songxiaowei@huawei.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.31.1

