Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECC03E9FF9
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 09:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhHLH4Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 03:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234889AbhHLH4X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Aug 2021 03:56:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FCDD60FE6;
        Thu, 12 Aug 2021 07:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628754958;
        bh=DIaYlAqGSSNogck6c8+7tffKBZEzgkCKP9DQtTZZp2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pA83Yxu436j05pvnjfUXAB6UWbmgxtggbBZV0Yp2QXt1ka3afdUTk1/XrZGUUhJJe
         dLM0gMHe8bS12WdEkRhrlpo7tUYTURbRy2V/OBH/C6Mhqp/sZqxpHzXWH/P/4X7zWQ
         x2YEEO3ptmW9RUMkNrddEmdvtFwraglespg+VE0ZB1NfGiDREA9JPCPGYYeaM0D25P
         AYcqgGQ5Qb4P78GaXrmezhCwxR5yERvAfJlVGHaAz1YC9i413Reu7ZYGYmipwYBgy+
         69KCiS5jMpICk6UOjSlYGfHLNdEPbg9GlxyElCha0W3emcE1ojsBDA0M/BEby6MdBh
         IHVp4ajAsiF9w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mE5ZE-00DZ3y-LR; Thu, 12 Aug 2021 09:55:56 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: PCI: kirin: fix bus-range
Date:   Thu, 12 Aug 2021 09:55:51 +0200
Message-Id: <a5395599b110e30c2410d8af4ff4de0b4af3e270.1628754620.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628754620.git.mchehab+huawei@kernel.org>
References: <cover.1628754620.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Using bus-range = <0 1> causes a runtime warning:

            [    5.363450] pci_bus 0000:00: root bus resource [bus 00-01]
            [    5.396998] pci_bus 0000:01: busn_res: can not insert [bus 01-ff] under [bus 00-01] (conflicts with (null) [bus 00-01])
            [    5.284831] pci 0000:00:00.0: PCI bridge to [bus 01-ff]

On Kirin 960, changing to bus-range = <0 0xff> produces a
cleaner log.

Kirin 970 is more complex, so better to just drop bus-range
as a hole.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../devicetree/bindings/pci/hisilicon,kirin-pcie.yaml          | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
index c0551d2e606d..d05deebe9dbb 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
@@ -66,7 +66,7 @@ examples:
               <0x0 0xf3f20000 0x0 0x40000>,
               <0x0 0xf5000000 0x0 0x2000>;
         reg-names = "dbi", "apb", "phy", "config";
-        bus-range = <0x0  0x1>;
+        bus-range = <0x0  0xff>;
         #address-cells = <3>;
         #size-cells = <2>;
         device_type = "pci";
@@ -97,7 +97,6 @@ examples:
               <0x0 0xfc180000 0x0 0x1000>,
               <0x0 0xf5000000 0x0 0x2000>;
         reg-names = "dbi", "apb", "config";
-        bus-range = <0x0  0x1>;
         msi-parent = <&its_pcie>;
         #address-cells = <3>;
         #size-cells = <2>;
-- 
2.31.1

