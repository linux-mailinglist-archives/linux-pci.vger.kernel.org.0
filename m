Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70DCAAA036
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 12:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbfIEKqJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 06:46:09 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17798 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfIEKqI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 06:46:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d70e7720002>; Thu, 05 Sep 2019 03:46:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 05 Sep 2019 03:46:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 05 Sep 2019 03:46:07 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Sep
 2019 10:46:06 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 5 Sep 2019 10:46:07 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d70e76a0000>; Thu, 05 Sep 2019 03:46:06 -0700
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
Subject: [PATCH V4 1/6] dt-bindings: PCI: tegra: Add sideband pins configuration entries
Date:   Thu, 5 Sep 2019 16:15:48 +0530
Message-ID: <20190905104553.2884-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190905104553.2884-1-vidyas@nvidia.com>
References: <20190905104553.2884-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567680371; bh=7marwzx0rlKDxIvDyAZhpOJl9XZi3qeL7058e2xIxPM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=QQl8WkpUTOLsWia7lHK4Vnwc50g9DF7RN8eEpYNH/0euF5615y3637pAWhzVlRmC6
         K+g6giDUQKpn5fc8YBbiztPHysMhYE88GUAn808yOchwk22SLK1k4227Xn5G6UFfIF
         YxLALsXFi0BT9syhXWf+p59ttOemvevjEw6ZDQwQewchirdbzohSGZVKCQU0QGdL3w
         3zuIGJkd5jghGHc/aQY0hes0AteNUF75RYZbP7vYk66dZIm+x9UkF+yF4y724N1efv
         /zQdRXRjylrGOBgdZq8dN9taTrxSgvMnjdXW5Sz1HWLZ4DSU2XyeMqvBhJ0xJM0VXf
         th7HOCQVmVtnQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add optional bindings "pinctrl-names" and "pinctrl-0" to describe pin
configuration information of a particular PCIe controller.

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
index 674e5adb2895..0ac1b867ac24 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
@@ -83,6 +83,11 @@ Required properties:
 - vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
 
 Optional properties:
+- pinctrl-names: A list of pinctrl state names.
+  It is mandatory for C5 controller and optional for other controllers.
+  - "default": Configures PCIe I/O for proper operation.
+- pinctrl-0: phandle for the 'default' state of pin configuration.
+  It is mandatory for C5 controller and optional for other controllers.
 - supports-clkreq: Refer to Documentation/devicetree/bindings/pci/pci.txt
 - nvidia,update-fc-fixup: This is a boolean property and needs to be present to
     improve performance when a platform is designed in such a way that it
@@ -120,6 +125,9 @@ Tegra194:
 		num-lanes = <8>;
 		linux,pci-domain = <0>;
 
+		pinctrl-names = "default";
+		pinctrl-0 = <&pex_rst_c5_out_state>, <&clkreq_c5_bi_dir_state>;
+
 		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
 		clock-names = "core";
 
-- 
2.17.1

