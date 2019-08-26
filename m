Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3529CA7C
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2019 09:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfHZHb6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Aug 2019 03:31:58 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1300 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730144AbfHZHb6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2019 03:31:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d638aee0000>; Mon, 26 Aug 2019 00:31:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 26 Aug 2019 00:31:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 26 Aug 2019 00:31:57 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Aug
 2019 07:31:57 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Aug
 2019 07:31:56 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Aug 2019 07:31:56 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d638ae80001>; Mon, 26 Aug 2019 00:31:56 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH 1/6] dt-bindings: PCI: tegra: Add sideband pins configuration entries
Date:   Mon, 26 Aug 2019 13:01:38 +0530
Message-ID: <20190826073143.4582-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826073143.4582-1-vidyas@nvidia.com>
References: <20190826073143.4582-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566804719; bh=jVsQ77MHmcaFLC4s0eTgGVoxDo/A2MJu8aiRKpUsI/Q=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=BX88ouucSggVa8KCQO3Bl2bAB0tI6aUNO8erv2/5t72+dQwwHKdtdWaqFUdD/1zg5
         CoDuzH3Oso0hnDZQxNZdHvdpdr4L8AQqOvz6FXb2E9TTEc4V/9cngOw4T1KqHssbM3
         oGbgV16zaIn2Z3FxedxDHRGHPmlu1kmZAtbTrfwKbTck0uF9ZcT0PBgn8wmUfqB71X
         X9T6EnNHrCjT0s9r6+5NJZ6RRj2UGVHXdmlqmMK+hZcASoDJoyBrhmmunmU+5KoCJc
         o9m3zcAChdZjLfHhzCEL2sKND/q5fadD5Hj+KQbj95rpjccyvISnOi8NDJG7g8oKTM
         8+KImlUGtrkCw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add optional bindings "pinctrl-names" and "pinctrl-0" to describe pin
configuration information of a particular PCIe controller.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
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

