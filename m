Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74FF432DBE
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 08:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhJSGJK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 02:09:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233717AbhJSGJG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 02:09:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A20861353;
        Tue, 19 Oct 2021 06:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634623614;
        bh=szle1bT5olJ89Gu3BNaMhKrdvcdWwZPAbT0cQmEaRss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dc7f02gsdm/F2FLaxqPuVl5pJbYyQzEk0ODO3LOnSZMA1rjnoOf/UeDYemarCEOYt
         2QH4AlF/zBxXk7FMFcUU+Ws+bb0NYHI6NXlD+1pfQfF+J+gJrWScPRs+lp+ArQq2CP
         YoFjLnvFXzJIxkYn3OEdu8q/+7NhWH3/G6GcA6l5gUCfxEU66A3jtOEinDAsDEvzHf
         RvWxypeEUIRHZfw9soYmW8dZ6UzmHXIyUObYERmVEkS/RSPDuu6ZuCN69mqGXjRb2A
         8CbEdNvbz9Z0S9RQ75DRGxCIfjKW/aM3MmANVsCM7oStABrAvmlfnJGs2Om9HhR+vY
         y2ZZTfdq8PqUw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mciGx-001krk-Qz; Tue, 19 Oct 2021 07:06:51 +0100
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
Subject: [PATCH v14 05/11] PCI: kirin: give more time for PERST# reset to finish
Date:   Tue, 19 Oct 2021 07:06:42 +0100
Message-Id: <9a365cffe5af9ec5a1f79638968c3a2efa979b65.1634622716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634622716.git.mchehab+huawei@kernel.org>
References: <cover.1634622716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Before code refactor, the PERST# signals were sent at the
end of the power_on logic. Then, the PCI core would probe for
the buses and add them.

The new logic changed it to send PERST# signals during
add_bus operation. That altered the timings.

Also, HiKey 970 require a little more waiting time for
the PCI bridge - which is outside the SoC - to finish
the PERST# reset, and then initialize the eye diagram.

So, increase the waiting time for the PERST# signals to
what's required for it to also work with HiKey 970.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v14 00/11] at: https://lore.kernel.org/all/cover.1634622716.git.mchehab+huawei@kernel.org/

 drivers/pci/controller/dwc/pcie-kirin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index de375795a3b8..bc329673632a 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -113,7 +113,7 @@ struct kirin_pcie {
 #define CRGCTRL_PCIE_ASSERT_BIT		0x8c000000
 
 /* Time for delay */
-#define REF_2_PERST_MIN		20000
+#define REF_2_PERST_MIN		21000
 #define REF_2_PERST_MAX		25000
 #define PERST_2_ACCESS_MIN	10000
 #define PERST_2_ACCESS_MAX	12000
-- 
2.31.1

