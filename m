Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236305FE0D5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiJMSPE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiJMSOc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:14:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20625.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::625])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25897183E18;
        Thu, 13 Oct 2022 11:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+B8mGHrnK7sgVjwojKYx+9RftbZ2x+CutbJvNpo1MEaVDJaPzKy1hrA27EVgZBfGLLMzgf5MmP/ruer4QDbQDU95X1Mvm23cMOUCx+8Evg9L0Mk1awFL2LBtDO/KVl+QLw6qdHXZzZ973/nPGnoat76GOK10KWL1FqV9Na2SU9EUkPIM+CS0qw+RCBuDDmVvVPbwGwLv1YFNz7/rXUNA0A/zmmJu35DxfKEnBodSfjjhISZne/qPT52F7UtBwDay/DtY/fdXRM1KBwfihCCaEKiei/5NIn55s1Cs1yQxZHfgfgg09XL0yxMa0WrRGfILBiGqNRKEuIr047/awLbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1gjqg7L4/2RxWainXFQrd7fIoFu1Cqs2UbwwWuBGRQ=;
 b=O/72saJ+hnqQ/JPxmC6gNKhf3h7I6DwInvL1dfUiBOchrJocwDsj87LZ/tQlRgkw16AIeE9DTw5jKbyFCaClLKJHsymGgpdIj1DsgX3NIsfJXeWaom+ZXqCt1KF/E3W5HKZHpsA/eV4D8OzDbcaxUmFw9jjef/UnC/aF4CXy3bjxbzfT7zVXEFhoEGk71od72PyRla7ogURRc2jFjdpe1VqX7NYn3zLogv67uaSD75Q5XlHkaFXTU+xBa+aV6duTVJ4UPAnxM/Bn4K/YF1FzfA4j1WMNjvMtn7R0+/D7yVg3rNbgJ2yTj2A/IGGbcdwZac03RMGC8y9xuisQAC0NzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1gjqg7L4/2RxWainXFQrd7fIoFu1Cqs2UbwwWuBGRQ=;
 b=nqEyd3sLdhdbeH7bwBzFK4f/TON9ZAgaPUwzdMUB7CkRv6Ohlrh2NeNW5aqWD2jvGQObEf2LeGHSjQW/tenYnHWsLl1tRrXKRWOc7JwFNkL7flZoDinfPGjaS0VwT6SbdSiZNILkg2yAeb6xedClsF0AkukeN9VSzVuhZ/ElYb+1FHUcmZ9QfZPJuiMTr9PoUSXpgl3DhOKDEwNTomvelZelkhnwgpHQze/E0VortZCu3TXgSrbTB88/WA9Ixim7y94EHEMkrLUaNTsNs5Hw/WlBseczcb0gzcOsj/Nb6M1hNfl2WT6HbObt4gywOCwfoEiLt/bWVvi1D8s2B7vy9g==
Received: from MW4P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::28)
 by CH0PR12MB5297.namprd12.prod.outlook.com (2603:10b6:610:d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 17:57:39 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::55) by MW4P223CA0023.outlook.office365.com
 (2603:10b6:303:80::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 17:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 17:57:38 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 10:57:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 10:57:19 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 10:57:14 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <mani@kernel.org>,
        <Sergey.Semin@baikalelectronics.ru>, <dmitry.baryshkov@linaro.org>,
        <linmq006@gmail.com>, <ffclaire1224@gmail.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V5 0/3] PCI: designware-ep: Fix DBI access before core init
Date:   Thu, 13 Oct 2022 23:27:09 +0530
Message-ID: <20221013175712.7539-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|CH0PR12MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c065dd-d0db-49ba-8df6-08daad446b06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYXrHcBCB01dtAPZCwCMcqfHLvNXSt2A5pBKn1hDhmapm7HXpjV/1V7mhDw61GjpamG5Df21DZOuL2e4AIBp+EWjaOZKpvYwmgBas3eRl7e5HCTa55tZru9/GjeDm/fJa5MPW6AgxZMSbzi7iERbXSPI5OwlOzAJ5v1utfuElqiUH8Sq36gUmoeEcjML1z+yitI/vQbaRFZ3WfCpCEAHI2MUh7ObxHE3jganaxECC23Yh6rtJpGlP3QplBg+f/8PfpkckHdPQFmB/az/11kdDgJ6soCuiHkH+emvcxVijf/O1pImnUMzYNfO4dXJI+VMBkfolXE1uLcGz44VvgP/urwa0QWPo/TESLnX2QDOEpMQQ3OLudKB7Qe35vxQuRCLgHQ4wRSJh6mtxtFyqAKYYsakUZ/yfttLYWVuYvKsJ5SgKLg2zYriz61MzNiRX6mj2Y3f6+Ulf5cTLrSePNNnH5nl103LBaRQPZR5soBRqPPQ88OP3rnETOTfhY5jBXq+vr6LXOXdTayDIPbFhOLpl6idhzwmkwsltE4laAKnNrwbjQpY0WLTaHTpVRz++vhoIEIyN7iTDgAUeYxrNsVXb9I8g1GZNjYFddmzt2FPS/ZserY8A2BhzLjf7084qByl/0fzhU+dEOsIvL/6w939Ycc0a09thPP0+gVYzaG6Urd2BN4GVPxljwJyL0dT7ioZ3Xyssjaz8VPzd4nTCGd7LDTAA+aT2g1wr3piiLlmh4MmUIyAQfgK+QjbReA6XIOk1K6bthQJSchCwYLAhBk81wFtRRPKN29mZCIKA/GPf88=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(6666004)(316002)(40480700001)(36756003)(356005)(7636003)(83380400001)(70586007)(70206006)(4326008)(8676002)(426003)(47076005)(40460700003)(7696005)(921005)(82310400005)(36860700001)(336012)(8936002)(2616005)(110136005)(7416002)(26005)(54906003)(41300700001)(478600001)(186003)(5660300002)(1076003)(86362001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 17:57:38.9444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c065dd-d0db-49ba-8df6-08daad446b06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5297
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series attempts to fix the issue with core register (Ex:- DBI) accesses
causing system hang issues in platforms where there is a dependency on the
availability of PCIe Reference clock from the host for their core
initialization.
This series is verified on Tegra194 & Tegra234 platforms.

Manivannan, could you please verify on qcom platforms?

V5:
* Addressed review comments from Bjorn
* Changed dw_pcie_ep_init_complete() to dw_pcie_ep_init_late()
* Skipped memory allocation if done already. This is to avoid freeing and then
  allocating again during PERST# toggles from the host.

V4:
* Addressed review comments from Bjorn and Manivannan
* Added .ep_init_late() ops
* Added patches to refactor code in qcom and tegra platforms

Vidya Sagar (3):
  PCI: designware-ep: Fix DBI access before core init
  PCI: qcom-ep: Refactor EP initialization completion
  PCI: tegra194: Refactor EP initialization completion

 .../pci/controller/dwc/pcie-designware-ep.c   | 125 +++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h  |  10 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  27 ++--
 drivers/pci/controller/dwc/pcie-tegra194.c    |   4 +-
 4 files changed, 97 insertions(+), 69 deletions(-)

-- 
2.17.1

