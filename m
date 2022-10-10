Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2035F9D75
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 13:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiJJLUM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 07:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiJJLUL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 07:20:11 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90041F2CA;
        Mon, 10 Oct 2022 04:20:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oe3s/Q6u6Cc38y8Y0KNBuLJ0WjjvxzzUVrMzjx77/1lGC0Skx6O/3yTL0LkArui0kNeg9o9YSf2Qw5V/MpRd0nQ8znj6TtEyyEPXlwx/Uoi4kmcjtUKsxJSRoDQKSvyb7Q76PrDgcMuw8aqt7Y+GLM+Xa6Tm2DPBdSOcWOhjuvgC1cnpD8UVAiR+hlcrO+TWD+w/YHq2HhICha9hEKhLGgSIUd+RNGzQJ01Mn1vO0l92uEFFl7prkgSEd5H6noqyopZdqyn5lum2vDcYKtBlNq8Rmyu2HwQyHtrbGGhmiDV+xXYlIaR1y8Y3eJU5P9miqgCntcruCyGrWHaR1ne2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvtZ1O7AJE21ydLaJZDBHlnbhVm4LlDocp+jPMldGg4=;
 b=Vi3DCMMW8V48awJUYTp2oWNgHC1swVoaKCDDjXa8ihfHQUIZDWV8c+k9oN1kVQKy66gLG05YCW5NjzaSBO3W+uRnrMuAnzorQdZELl2E3I+7L8cQLziQv/G7LJql+FOqTTTfxDopfoPETHovjJo8Ut8oDsJeG7MGVW5N7B8sGMNd7/9BOy6fTB3acLwqLi4xAyC63hsRFi+DiqU7to9heS6h/TeN+Pkjsk0qfL7G0V4T2V+oRD9SDVa+IpYYJ/2uN51A0wHXf87QAGEuQbQHaItfYJGrNycj7jYoVovyHvI6HT5IOcsZNz78wpM8mlKa+CCE0ysSCnu+LbABZx1kgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvtZ1O7AJE21ydLaJZDBHlnbhVm4LlDocp+jPMldGg4=;
 b=Io1AWzy+Le268w6Xa8+1POXg78J5q4eDlAhLMTD9QfgIbB2hCVzNwoFSWc8agDLOyoo43zQEGWxk1GDuhGz0BTH4zmwKrX5dJqdWelI/h9H84TVj8nfJF9RH9uffOmRgV/+eCd3e3QFQxkNyAVZas4jImV/nusb28TByKPkz8jQxo2uxQJ5xcNYU3wbvq2e+6rl9MC+JnNua9ySjrySoTkLITjKA1gwNgx6uPEg1IknU6W+NiAr42LrkbRJwhM0dS+5ay3Bj7IkNBqfPlgqBAIMLUfjlOuAHxp793df32Xa5k/DSpqr8LfwCEN1QKp9oUPavD8mNuW4x5PmLwdq0BQ==
Received: from MW4PR04CA0111.namprd04.prod.outlook.com (2603:10b6:303:83::26)
 by DS7PR12MB5983.namprd12.prod.outlook.com (2603:10b6:8:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Mon, 10 Oct
 2022 11:20:05 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::1d) by MW4PR04CA0111.outlook.office365.com
 (2603:10b6:303:83::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 11:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 11:20:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 10 Oct
 2022 04:20:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 04:19:59 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 10 Oct 2022 04:19:55 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <mani@kernel.org>, <kishon@ti.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 0/3] Add DeInit support in the PCIe Endpoint framework
Date:   Mon, 10 Oct 2022 16:49:50 +0530
Message-ID: <20221010111953.5422-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|DS7PR12MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c5cfbb-04f8-4893-fad4-08daaab1620f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s26+elSRgBrkUslT5sYGpEtXA/z3DuGayzOQJzcsWq+Rx7FxtFTnS5jiK7EsLD16vf9lxqfQ5UP+1caobGN4mjwZFYJ3cyz8MzkB3OFr3KGXoAMPj90PUPCVfb+1iJbUKsWhgeIIt6qczPgj0w0xrbRgwKtUKc+OX3sDGfR72e0bgfF6toXWMtywee0QEFOxlMx2JN1c7m5+XnHOijNCVCAjuegRUI9aolCLK0bju/qgx0yP+41zwyJcrvXH/FskJNUkRPcxA9M0THxQSPjXvU2dMiGPfGB3hn3M9qR9PPio19lCgQiM8vjt/aKN+WKlIY6Bc+TXxjs95ZwMgdd21OcPTiZoDvVvA1wAHBlVqqcOwSqOB7qrl2o898xUn2UxAdVqsWfxw2UuzGMJ+VvrePnPvongvvvxOvxsr75WeIxSN7bnqyF76hf7SeisNwyk7XjMZfPQlPWOt4JwbR5WAIT6+wHh18bkCrsLh+MQggezNzZ2cR0XiNEn5pCkMCU/kGjGdsmKeazPT0OqNzINclENdy/DbFixnzITlg16yFVhq7ExO9ycKIFd86IjKW7jZOpCzWZdoxKU6SPt72ozge9kmJVAoE1c/PbL8GLE1DC73CAmb4sgpQ3dOxpVyCs0gqBifadt58tDnv2Ox1r43VPwPb5KMLRqvbwrUu8iWyPVx7sBnBQoZ7ZLjd9Gq47qDZ3JXOZhrQBb9RKOOfGVvwX4MSVcFPlfwcJoPRllglCiXE6Egf4YEuwNUR+HZ7vKUXvLigP4Qa3yFy/+HFOyDvticIpt3kidCvqZnnMI/4EAqeMNaImp3W/RBsehkxWDgz4roWnRNDdHbpZXb85IuF1BxkVxIH9obTqM0UD0lNw=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(6029001)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(82310400005)(478600001)(6666004)(336012)(1076003)(8676002)(186003)(8936002)(110136005)(7696005)(36756003)(5660300002)(47076005)(4326008)(316002)(2616005)(70206006)(2906002)(36860700001)(54906003)(7416002)(40480700001)(86362001)(356005)(7636003)(426003)(70586007)(40460700003)(26005)(966005)(82740400003)(83380400001)(4744005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 11:20:05.6556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c5cfbb-04f8-4893-fad4-08daaab1620f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5983
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Endpoint function driver should cleanup its resources which accesses the
hardware during endpoint controller deinitialization. The patches in this
series address this requirement by first adding the callback notification
in the endpoint code driver. This notification is invoked by the controller
driver which is propagated further to the function driver.

This patch series depends on Manivanna's following series.
https://patchwork.ozlabs.org/project/linux-pci/list/?series=317729

Vidya Sagar (3):
  PCI: endpoint: Add CORE_DEINIT callback support
  PCIe: dwc: Add a DWC wrapper to pci_epc_deinit_notify()
  PCI: endpoint: Delete list entry before freeing

 .../pci/controller/dwc/pcie-designware-ep.c   |  8 ++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  5 ++++
 drivers/pci/endpoint/pci-epc-core.c           | 26 +++++++++++++++++++
 drivers/pci/endpoint/pci-epf-core.c           |  5 ++--
 include/linux/pci-epc.h                       |  1 +
 include/linux/pci-epf.h                       |  2 ++
 6 files changed, 45 insertions(+), 2 deletions(-)

-- 
2.17.1

