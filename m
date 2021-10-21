Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50745435F85
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 12:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhJUKrx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 06:47:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230342AbhJUKru (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Oct 2021 06:47:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE55361130;
        Thu, 21 Oct 2021 10:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634813134;
        bh=8fOSqA2lJW4GkX4/ImU+E4+sVxOHMiRXyyfaCoSKklM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqH1qXnu458hBgT0balPv2x0Nsx4vvbjTY/4VKYFs6T+WFQ1WzhtXaMUT5GdqxNr5
         ZoayGYd4O3uowle7ykrOqxtErS1vsV5V1KRhF2Ka4T3GjBYay9aYLk3VfuMh/ocTYB
         KHEFtQ1G3OrDqGWC4MhXO8wFcQU3LOUGlt6D2f13KK8rJkZvGFdHQi3W6faDWw6DZJ
         SISzs79uBA/462BgGwOOov+Er93SDInzz8aVa6ZPThs6cIZRWLsBd8/vhXH3T5zAZ1
         D/Wn/OWrQ7Tf7rAFc7z7L10ylThxGTdafbwjEZHgakqaN78KoAAROv82C8A2W64ZOu
         shYIxoLU0wPZA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mdVZj-002z52-2d; Thu, 21 Oct 2021 11:45:31 +0100
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
Subject: [PATCH v15 05/13] PCI: kirin: Give more time for PERST# reset to finish
Date:   Thu, 21 Oct 2021 11:45:12 +0100
Message-Id: <1aa50f736464cd6e871d05990684b35faef76767.1634812676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634812676.git.mchehab+huawei@kernel.org>
References: <cover.1634812676.git.mchehab+huawei@kernel.org>
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

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v15 00/13] at: https://lore.kernel.org/all/cover.1634812676.git.mchehab+huawei@kernel.org/

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

