Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEC99AA03C
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 12:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbfIEKqP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 06:46:15 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15979 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfIEKqO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 06:46:14 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d70e7760000>; Thu, 05 Sep 2019 03:46:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 05 Sep 2019 03:46:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 05 Sep 2019 03:46:13 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Sep
 2019 10:46:13 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 5 Sep 2019 10:46:13 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d70e7700000>; Thu, 05 Sep 2019 03:46:12 -0700
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
Subject: [PATCH V4 2/6] dt-bindings: PCI: tegra: Add PCIe slot supplies regulator entries
Date:   Thu, 5 Sep 2019 16:15:49 +0530
Message-ID: <20190905104553.2884-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190905104553.2884-1-vidyas@nvidia.com>
References: <20190905104553.2884-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567680374; bh=N2xSbEeco7MflIcCuTCLEJmxwVL2xhrZpdQdZjq2giw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=MVlyMIXWnm1etK8JylYBuWyMlA+ASGjvXN9FOnClKgv7CuHcjCDg9IwP3dgJVQitI
         mNWl6/Kjr5nreywsxhQMPeqKO0J2UYK9POYX5B+WbFh5+fLNBimgxK5iIpgYo10CfC
         AQl2aKIehI/9Mwo0WkSV4Tg98O17uPKkGts54Q4l1AIilaJqKGtvnK1qZmJQEijyQy
         LYDKZ3UWJrWezBALtxx5Njdyidt83PgD7ZH/+R+aztNF0VmK8GSiIdK67hfoqKG4dH
         ubGqIlrR4kTyxwmbbem3eQSr5wrxG8PtmhAXWQvYFC7nMS1yyxpVj1x+PTFNzE4E5y
         6ZAP9jfpwcavA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add optional bindings "vpcie3v3-supply" and "vpcie12v-supply" to describe
regulators of a PCIe slot's supplies 3.3V and 12V provided the platform
is designed to have regulator controlled slot supplies.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V4:
* None

V3:
* None

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

