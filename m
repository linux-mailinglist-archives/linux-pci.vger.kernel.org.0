Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCEA3A02E6
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 15:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfH1NPb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 09:15:31 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3245 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfH1NPa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 09:15:30 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d667e730000>; Wed, 28 Aug 2019 06:15:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 28 Aug 2019 06:15:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 28 Aug 2019 06:15:30 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 13:15:29 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 13:15:29 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 28 Aug 2019 13:15:29 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d667e6c0009>; Wed, 28 Aug 2019 06:15:28 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 2/6] dt-bindings: PCI: tegra: Add PCIe slot supplies regulator entries
Date:   Wed, 28 Aug 2019 18:45:01 +0530
Message-ID: <20190828131505.28475-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828131505.28475-1-vidyas@nvidia.com>
References: <20190828131505.28475-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566998131; bh=KMMmGVGW4lBUib9Wwb7U+YdF0LFNEuCa5iHqfUQ2I9M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=VgpwTBf0r9xOLkXeoDu95tNqEfLEj95sjCP4URh2+J9LWIsY2SZFwCaz1vAYev4rG
         gbK79tyqKGDoYrZBNQVRrcgHk3rLihoHICqtTVX6NGCL5pIWxz57UYHOTrHNEdNf2E
         jOy33taa173Kdwggsq12HGFpE+MJwvtoR68Uo2lUJ4m9KmEVMLSy3hkHyJsIi9CNh2
         4vS52B+qqK3j/uIe9ZaFnqFnNwatIpi9Jk01WPYeFzZ1Rv0Mog00z44aK+QgGSYHtE
         caPS/xKjWudmHKy8wg4qtPYxGABfLIz6+zjHVl0/AoP6g+8U+lJ4lAWkU689SZe57P
         3B1clJPNUbZVQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add optional bindings "vpcie3v3-supply" and "vpcie12v-supply" to describe
regulators of a PCIe slot's supplies 3.3V and 12V provided the platform
is designed to have regulator controlled slot supplies.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* None

 .../devicetree/bindings/pci/nvidia,tegra194-pcie.txt      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
index 0ac1b867ac24..b739f92da58e 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
@@ -104,6 +104,12 @@ Optional properties:
    specified in microseconds
 - nvidia,aspm-l0s-entrance-latency-us: ASPM L0s entrance latency to be
    specified in microseconds
+- vpcie3v3-supply: A phandle to the regulator node that supplies 3.3V to the slot
+  if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
+  in p2972-0000 platform).
+- vpcie12v-supply: A phandle to the regulator node that supplies 12V to the slot
+  if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
+  in p2972-0000 platform).
 
 Examples:
 =========
@@ -156,6 +162,8 @@ Tegra194:
 			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>;  /* prefetchable memory (16GB) */
 
 		vddio-pex-ctl-supply = <&vdd_1v8ao>;
+		vpcie3v3-supply = <&vdd_3v3_pcie>;
+		vpcie12v-supply = <&vdd_12v_pcie>;
 
 		phys = <&p2u_hsio_2>, <&p2u_hsio_3>, <&p2u_hsio_4>,
 		       <&p2u_hsio_5>;
-- 
2.17.1

