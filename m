Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477F850CA1B
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 14:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiDWMwO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 08:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbiDWMwL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 08:52:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D941C104;
        Sat, 23 Apr 2022 05:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHcZv581F4ejnVp9sXOuJK+tVRhXcrlRTNCXu49jJ1ZzN0ON9GUcvMXJc+jumfgEtmeAK5/gVcskf5k7tB+SjY9BS/pxPT6jUsz4PkalpVRZSXIy3eZZVBeyjkq18vHz5dWlgkGeHji2XGD+EyJFfCcYTbr+EdkIWjVLrC1HbFwGtvWdpA12+lmOSfBJO3iz4e5WF6MtTTtzgLDv+IQCE1mqZyLFR9XDr7keO9H/0tOPutUER2bRNuWP4n0YTjVrLgfh0fdeNG4iwX6s4HC0rtDHhqxbPC4JBfTI0757mqyu34MdnghTbQqtnStHN/Flrk16yimG7T3WvUHdxHgkpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VSrfIEeCgjAE6SlteodsRP2cpEA+/pREv17aJeQFN4=;
 b=g9ZWRw6PJ7ym6c5H/a2nk3xqBCclgX3oIG0W4dRvzdkGbdvwbCqRVI8rq4jjjKVZWzFDy/jcCKIPIPknqKDuVlw6aRy4xG3khx1Hvp3aQV0kcl49R7UBNqo0Jt+6GKH9MwGJvmicVEzcCTqBAnMgdjur0zNy0bTa45Kf3NTe1acQshqB3dH1GNkjEgqaCSROQKaKM7wU2QMi+5W5Ap/NGsfU6jsOONgS4TJjWccN2hGUOoSPKZ82hiJeXiPWOyXb6bu7DCRrG1kCMo0Yk5jfCa8sb8sUcyBXqlXcPfAnPjIR2ltLmH9W2+rXV0coaMr1Dg7zzZhuOuB7pujS5kovqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VSrfIEeCgjAE6SlteodsRP2cpEA+/pREv17aJeQFN4=;
 b=p47dN7Kw8prnJBYFP66KKr2UdsInFNIFjJaNlxSObBsT7/qKlBSlEvVMiOwSNBjxbgt4ehKd+dnn8zvw+kjiPYtUQx9GZkJZiikAV34Z6jiBvTvGiytV2tJ4rjpdmdzgjN7R9l1QWvbgN3bot+rfVdyl1x53Nyxz7awKY13cuE8w4R2gTR7K96HJJk9ppP20BjZYhpcHCOgHWKdm2RS5J0MThoE6kD0wF+X+t9QSybJ36pWimhmZnGw0XoTeRB7lNPqkPm2Q2CMd5lGltsMn7rii8ni1LAHglazKuMULWj9U6KjbLZ0ul3jOZiXWC+zk+ropKaHxU+f9urGxx9KyRQ==
Received: from DS7PR03CA0265.namprd03.prod.outlook.com (2603:10b6:5:3b3::30)
 by BN9PR12MB5036.namprd12.prod.outlook.com (2603:10b6:408:135::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Sat, 23 Apr
 2022 12:49:13 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::4a) by DS7PR03CA0265.outlook.office365.com
 (2603:10b6:5:3b3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Sat, 23 Apr 2022 12:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Sat, 23 Apr 2022 12:49:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Sat, 23 Apr 2022 12:49:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 23 Apr 2022 05:49:11 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Sat, 23 Apr 2022 05:49:07 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <kw@linux.com>,
        <krzk@kernel.org>, <p.zabel@pengutronix.de>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 1/8] dt-bindings: PHY: P2U: Add support for Tegra234 P2U block
Date:   Sat, 23 Apr 2022 18:18:51 +0530
Message-ID: <20220423124858.25946-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220423124858.25946-1-vidyas@nvidia.com>
References: <20220423124858.25946-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f89e7b68-9c54-4e72-3c03-08da2527ab0b
X-MS-TrafficTypeDiagnostic: BN9PR12MB5036:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5036106AEC10B8F3A627049AB8F69@BN9PR12MB5036.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gyQxlwoW2jf4I705ctiXnuLbKfHba7b+WNdTywzS4hD0MWeCzuS2NVtSy9srdkPWZCJCeGueEZoL2YL63vhZVPV2Z6+e7PCRH9HnUOhBuB/23nA9VDF84+ZFBOCJcBGoJSA1Kgd9m+lk6iCzQunw3Kq0UQvivpncDTIoRKDJmvGQCeus6FiwljFukp4zJyshM5X3UQxUJamld2cVabQP4YitIyLE4j3RV01tvvvNATx92ic9dstXymXiwp/kM7BD1tzmU0RSOGl/tMN4Y820Zwq9GVbrjZc5x9301GpsiQ5HyBbzkT5buRGEzgrKEfKbJetDMpAJ7XAS+oHQEosSsYaCKcjMKZtVLQS/t8LTXWWnhTQmx5Vq5fXRE5G6gRIhlcJ4oaiBnp7eUdzva2TgFpxua0LXdfy+nrsgJI5BdBGxZ86Ifa/E4oTi9ne+P+Ns38wjA98OnM6kRHK1uB0cxe7hOsF/H7K4Pf5UGRgEGnd/T6M5mA3UKNCX4FEmFt9H/mzExxvyHAHWz+apHgMmjXDY36tvivkSLH6rNGqnE+hBpTsfRPT/LlM/+n3TwWrnKi7E/UiuRNgjOQdR9uDMqT/v8m3DDjsIg5Fik3QXLvFpR5zbf1aTUJrNTLW3woAt0QfvOvuo9uwE43GnLLnyVWpB2/tZEzXN3GMHigMNE9hMJBFzbL1n2lzcShsjwMynWDwDYfAq1O3Qa8zCqAQ+2dDviZoXhWZfdqBaTBRePAzh59kIdbbsZKIywUNzeUo7H9awK/6wkXb9ipnSyufcCSk+6SJAn8Tz1hjARGv6vnma27T+WOdOUfM4dhDuofNruXem+mmPLjxK7AXd8dUX9A==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(26005)(6666004)(7696005)(81166007)(186003)(2616005)(2906002)(47076005)(336012)(508600001)(356005)(83380400001)(1076003)(70206006)(426003)(86362001)(70586007)(36860700001)(8676002)(4326008)(5660300002)(8936002)(7416002)(82310400005)(316002)(6636002)(54906003)(40460700003)(36756003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 12:49:12.8689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f89e7b68-9c54-4e72-3c03-08da2527ab0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5036
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for Tegra234 P2U (PIPE to UPHY) module block which is a glue
module instantiated once for each PCIe lane between Synopsys DesignWare
core based PCIe IP and Universal PHY block.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Addressed review comments from Rob and Raul
* Ran 'dt_binding_check' and 'dtbs_check' on this change

 .../bindings/phy/phy-tegra194-p2u.yaml          | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
index 9a89d05efbda..4dc5205d893b 100644
--- a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
@@ -4,7 +4,7 @@
 $id: "http://devicetree.org/schemas/phy/phy-tegra194-p2u.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: NVIDIA Tegra194 P2U binding
+title: NVIDIA Tegra194 & Tegra234 P2U binding
 
 maintainers:
   - Thierry Reding <treding@nvidia.com>
@@ -12,13 +12,17 @@ maintainers:
 description: >
   Tegra194 has two PHY bricks namely HSIO (High Speed IO) and NVHS (NVIDIA High
   Speed) each interfacing with 12 and 8 P2U instances respectively.
+  Tegra234 has three PHY bricks namely HSIO, NVHS and GBE (Gigabit Ethernet)
+  each interfacing with 8, 8 and 8 P2U instances respectively.
   A P2U instance is a glue logic between Synopsys DesignWare Core PCIe IP's PIPE
-  interface and PHY of HSIO/NVHS bricks. Each P2U instance represents one PCIe
-  lane.
+  interface and PHY of HSIO/NVHS/GBE bricks. Each P2U instance represents one
+  PCIe lane.
 
 properties:
   compatible:
-    const: nvidia,tegra194-p2u
+    enum:
+      - nvidia,tegra194-p2u
+      - nvidia,tegra234-p2u
 
   reg:
     maxItems: 1
@@ -28,6 +32,11 @@ properties:
     items:
       - const: ctl
 
+  nvidia,skip-sz-protect-en:
+    description: Should be present if two PCIe retimers are present between
+      the root port and its immediate downstream device.
+    type: boolean
+
   '#phy-cells':
     const: 0
 
-- 
2.17.1

