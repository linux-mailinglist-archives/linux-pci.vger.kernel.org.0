Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D383E8B45
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 09:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbhHKHzW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 03:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233850AbhHKHzV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Aug 2021 03:55:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77A7C60FC3;
        Wed, 11 Aug 2021 07:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628668498;
        bh=DIaYlAqGSSNogck6c8+7tffKBZEzgkCKP9DQtTZZp2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFmYNGQuhK98Yzi7TYh/hUGLHFILryUA36Kg81IPxeMod6UAzF3HvPMpE4IKfFFyt
         YndAjJxWJ+qsfJuZ80shWTmudxOiPtGJ5E/wuyJddTzEAB+nRZsPDilp775ZcjMPev
         F2vzk13FtSJririda9vGuXPKReHAXT2Utr7/91w4fdNB7g9vmLMXLsMThpO4bGnyXI
         QxwlZIAVinWyv3VycIaD1Dnc9uiiIlkRhW+1trXDGYhU8v3gdE1mfTJm/PqmKC/cT0
         VjOoodl3CV8lE7woc3AJCy0E98nK1L0zLbeMNAHQHVe5ELbqZ7SWUXuhf3YfqlYasL
         uwS4BhBO/EWeg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mDj4i-00BuOi-9w; Wed, 11 Aug 2021 09:54:56 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: PCI: kirin: fix bus-range
Date:   Wed, 11 Aug 2021 09:54:52 +0200
Message-Id: <70d412242f908a6fd4ec4a96ae7d56af8ba58d0a.1628668306.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628668306.git.mchehab+huawei@kernel.org>
References: <cover.1628668306.git.mchehab+huawei@kernel.org>
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

