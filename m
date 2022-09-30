Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3FA5F1264
	for <lists+linux-pci@lfdr.de>; Fri, 30 Sep 2022 21:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiI3T2N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Sep 2022 15:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiI3T2M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Sep 2022 15:28:12 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B784AC1EA8;
        Fri, 30 Sep 2022 12:28:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg5n/AOHqy7WBQm5IVsQBhAghQC9TcW+ETdqRnPGW/KhJs1hi2LSPdcTgB3eIx860JWKrfvftg6Ns/L27sjTheNJc4V7EZTEbZB23O+uxzghFsSBsiA5fK8fjtir08nRmbg8WbzaMA7Eic2CBaW9py138R9uqtrZdmXvhnmHSEM6QCGaatT/vO29Z69xYJ2zSFC7uSnuGo/m8QVuUoKBCtu6wLGB1C2jJmCPQk2KDG7el/TkIq/CHXVbhN/t9LptYle/GanrjxHWw0Xd6z6Mcx1oEtPyHECvJlzBCnmiZqI8acTPnwjIlGgw+GduFr+b2jmxftuQk+iSzxMiVl+7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUGV1ZDXwm7yxkNxJb/YtWkxA30+Sh9Tesq2p7kC+9A=;
 b=kn+R3rADPZvyeNq7peO5eG4WwkTCD3tupW1oB6GVpuNMtgZEoXgFYy6yxkqLgcP5g6mWCD3vFAbhzPzptQioVNO2oXL/IV9yFjGJ7J0M3JHg/xu/zkPwTRBjn8jaYJ3JSSjT9OFcWgeKoKzj/6Dg1GCM/LfaFDQl69k3EtBIEGnzROVSpvS8F/U6Tzfy0TCSeY9+G8qBaNiL16guYd9YHDovkW8BurGdxcfDrDxhG2lf4CAL9ypofqTtEtw3QNoP+SppNh2siP7ouSJIj2A0/TLN71D5eneLo1WM2BRtCoRgTlEdU+KikSeBmK9OTYz+jOIAYKEmTsokns3ClPHgSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUGV1ZDXwm7yxkNxJb/YtWkxA30+Sh9Tesq2p7kC+9A=;
 b=TkFqPFJHJNJGL/oxcNFa0P0w//LydUJWq/lpJrQ5xhV3Hkh7i0EgfCw4rBo++T4RKkXd+2ivKJ1qctOo85OgP7eaZSRXn6J8AstACncAxzixiKy/CE6tRjip/recD/SMqZdXYSK8aMbQYryJHfFTS7WABBEiiC9aOUFw4l20pM5h/1q4BtymKI8/2fY1rIZhvQYBrWZQu8YuQnVwPtBemfDcm1j9D4r3v6Dw2gm2dA6GM/nNe3ek2KMZN1WDKmUMMk4PI0jVWjnJ/9tyBeVKt0EvrHeduCxO7FnLx3LMyk7SP6BK2W/6PEYjUPw93MwRdDkiO/m9BSqMOVdgY7Ocvw==
Received: from BN0PR08CA0006.namprd08.prod.outlook.com (2603:10b6:408:142::26)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.19; Fri, 30 Sep 2022 19:28:09 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::51) by BN0PR08CA0006.outlook.office365.com
 (2603:10b6:408:142::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.22 via Frontend
 Transport; Fri, 30 Sep 2022 19:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 19:28:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 30 Sep
 2022 12:27:55 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 30 Sep
 2022 12:27:55 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 30 Sep 2022 12:27:50 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mani@kernel.org>, <Sergey.Semin@baikalelectronics.ru>,
        <jszhang@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 0/4] GPIO based PCIe Hot-Plug support
Date:   Sat, 1 Oct 2022 00:57:43 +0530
Message-ID: <20220930192747.21471-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT033:EE_|DS7PR12MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed2b783-5934-4efd-604d-08daa319e80e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WL6+b+ajryHYjEGWOJMdWbj/KBQzVpoD2q8PmDSKtuOf0dRZE3V8YVv1/gG4x6CP6Ha0PSzlb2nHWzSYDFtLoqoQ9X9VfDj74PaRxjLNbau2ud3FrPVAXBGBbGiaETOzfNZRCbrei0C3o4/9MdD0NtYk2Q3j8xhPE53icMUv/F5Ab0zB9wWR+JgYCfYuvqqHFblobUumIRuRE8y/+qhaqNw8ClOqivvpzhS1P0NAYeTDnf0I2Yg65sEdNgE61s4gdsSV/FGCy/3GOJBW0rWSu8+tmGX5EQJqFbODt2qSkSNU5WFE6aaRnnOWGTmFqHS4IlQsIiz+zSHtg/avwmNOs8P7CQU5KKfAWjnwQGqIQFnZXNPDe36C5P/rz+eqtsYzVmPDxaoYy16mtKyDZrkMxp9IQDgixXGUZWQ5FzkatukuxVYb5zRSI9MG0Rp4ugZh6fV2ejCVq4SurXO8+fwdRvxW9GKT2eA8l3mn/q9UztGIqutyllofMhgu932Q8DpYghMGQckZs8nFQApNDSS/QETosejvvd61DBOe92tu9Y7y3iq+6GAtZjRrCK07qpG98Xr6EG+gUfZZXOeMA7GX5fwT0Ge1Q2wihFGrfFC+IQ5oe7BBIxPWDnI5o1mzkCESgQKv9xP7t1pBeZJMlB5Tf/QiZuZfsW6V0imvdVy3MtKcyWcDNOaJwuT51a3QPEJ/O4jSCEUH40AcGawYGNNA2TbzCRw+YPWC1m7BAqKFdnDlz2Yo7GD62jYYa4UWxFwALMR/n57ZHP67jkbVfqrDHsob8uI4AUhqQLy57HTs0DBt2QBsWDiraPpvAl9atoVMfYo3RYxOMNdDEMp7U8IOsKfztAdQoSUE8Aon8PgADtPP5ytD07CEdSb8KMr9MqmFnCPP1d5efCLONgambkzaValZMm0gFtABCRIpiZt0/aM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(7696005)(7416002)(110136005)(316002)(6666004)(54906003)(86362001)(41300700001)(40460700003)(8936002)(70206006)(1076003)(186003)(2616005)(82740400003)(70586007)(36756003)(4326008)(8676002)(36860700001)(336012)(2906002)(5660300002)(426003)(47076005)(966005)(7636003)(921005)(40480700001)(26005)(356005)(82310400005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 19:28:08.7081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed2b783-5934-4efd-604d-08daa319e80e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To support the Hot-plug feature, PCIe spec has a well-defined model for 
hardware implementation and software programming interface. There are also
some architectures/platforms where the Hot-plug feature is implemented in a
non-standard way and software support for the respective implementations is
available with the kernel. This patch series attempts to add support for one
such non-standard way of supporting the Hot-plug feature where a single GPIO
is used to detect and report the Hot-Plug and Unplug events to the SW.
The platforms that can use this piece of software need to have GPIO routed
from the slot to the controller which can indicate the presence/absence of
the downstream device through its state. This GPIO should also have the
capability to interrupt the system when the connection/disconnection event
takes place.
A GPIO Hot-plug framework is written which looks for a "hotplug-gpios" named
GPIO entry in the corresponding device-tree entry of the controller and
registers a hot-pluggable slot with the Hot-plug framework.
The platform drivers of the PCIe host bridges/root ports can register with the
aforementioned GPIO Hot-Plug framework along with ops to perform any platform
specific tasks during Hot-Plug/Unplug events.

Oza Pawandeep made an attempt to upstream support for a similar Hot-plug
feature implementation at a platform level, but the implementation as such
was very specific to that platform (at least the way I understood it).
https://patchwork.kernel.org/project/linux-pci/patch/1504155029-24729-2-git-send-email-oza.oza@broadcom.com/
https://patchwork.kernel.org/project/linux-pci/patch/1504155029-24729-3-git-send-email-oza.oza@broadcom.com/
https://patchwork.kernel.org/project/linux-pci/patch/1504155029-24729-4-git-send-email-oza.oza@broadcom.com/
This current series also attempts to address that by extracting out all the
common code to do with GPIO and Hot-plug core framework and expecting the
platform drivers to only register/unregister with the GPIO framework. So,
@Oza, could you try using the GPIO framework from this series and enable
Hot-plug support for your platform if it still makes sense?

@Rob,
Regarding the DT documentation change to add about 'hotplug-gpios, I'm not
sure if pci.txt is the right place or the dt-schema repository
i.e https://github.com/devicetree-org/dt-schema
But, in the interest of keeping all the changes related to this feature in the
the same repository, I made the changes to the pci.txt file in this repo itself.
Please let me know if the documentation change needs to be moved to the other
repo.

The Changes have been tested on the Tegra234 platform.

Vidya Sagar (4):
  dt-bindings: Add "hotplug-gpios" PCIe property
  PCI/hotplug: Add GPIO PCIe hotplug driver
  PCI: tegra194: Add support to configure a pluggable slot
  PCI: tegra194: Enable GPIO based Hot-Plug support

 Documentation/devicetree/bindings/pci/pci.txt |   4 +
 drivers/pci/controller/dwc/pcie-tegra194.c    |  85 +++++++-
 drivers/pci/hotplug/Kconfig                   |  11 +
 drivers/pci/hotplug/Makefile                  |   1 +
 drivers/pci/hotplug/gpio_php.c                | 200 ++++++++++++++++++
 drivers/pci/hotplug/gpiophp.h                 |  40 ++++
 6 files changed, 334 insertions(+), 7 deletions(-)
 create mode 100644 drivers/pci/hotplug/gpio_php.c
 create mode 100644 drivers/pci/hotplug/gpiophp.h

-- 
2.17.1

