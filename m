Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2D15BD4C4
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 20:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiISSeJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 14:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiISSeH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 14:34:07 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF4A4363E;
        Mon, 19 Sep 2022 11:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHftH1gUkXs/ZWJiGS7x4izbxGlIcKXMdaisLkBDZ8Dly4O2AJ0wpk25tnVKOWWP4ghqLG3ubMJXOClwxu9OWVB2g/ZIXGkNvmKG3AB99seB/dvebqwyWJfLtSaj/13EYmkQ8crpynYZ88RjSDfYCoSMbwW5K3VQaDoMAhBwOC0fGr39US97vA26OxdY+0/4aw/ThMs7lnmXX8NPdoQb2j77G+WbNEzLawtLua2+LXkfi2nJfRJ8ph1j+AEWutYzxiegIyOA2FABySHaHyt70qhsq3QJ8E7VOgzmKc9giwiDmS91w8B7qeV1VVp2pmj+9bz01j3fcRYFF5mLjk5HJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxt/3OzoQp8OMnRP9pjAxNqOmyMfxCgVtheEcPR9F5I=;
 b=eK2DSAFCWKaKwKpnCUHi00Qx2xZqQsSOWxgqofez+N6GwKEYl+sKTHU3xGbvo4p8QElYLH0YyC9aOeDUmDLYGTTNKkEhxBl9U7tCwv+WTm5pBBkGIJ2kpH0FuyXLehq4DVLY8MG5RAkZElZANucIaeBoPMEKY2hVRzg5Cawx2c76G2ABF1Hr7UR85+Ur6tnR7OjBvCfn6y7INFZkw+T5ePZVXz5bDRl2Vm9Dn23lqfeH6eISGNBpdZCkofmsNeP+xBWI9IVkc7m5XgKEd4vtaH6RGOWdGOrGYhk02Kq7yT/ATqfqgVLLZv9dRjzPorfREbeYzgafsKJKEEVJ2ETOJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxt/3OzoQp8OMnRP9pjAxNqOmyMfxCgVtheEcPR9F5I=;
 b=k5nmctTP38plTt+u+8Qvr6NgZHVws7VJ6XeDyK355sDa2va3MLifeO3Hd5mN7rMyaO91KpN4tz4JUi7ghffaQhAUATsoNBJnkunIInffgVTVPLhA3JfzdpjQKLSlrwXRwaNZDBu5pCSE4sJ4WcOA0Bzr2vf9X2XUpEki/THZcrvUieoQFbm6ZolfrCwJbYEyLnx0OgUZrI95y/suCeb7z/0sFVsE1BvcriFPU6ncW8hTNVj/NvdjEKc+aDPzb2NBrPJmck49NknClyPh5Q9LOHVJHwC43i4rCOggFAl7bPzXZpn/LODMHO1f5caWKQm1qgnfl/LE2vVFBUjj+fSXOQ==
Received: from DS7PR03CA0321.namprd03.prod.outlook.com (2603:10b6:8:2b::6) by
 BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.21; Mon, 19 Sep 2022 18:34:03 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::5b) by DS7PR03CA0321.outlook.office365.com
 (2603:10b6:8:2b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 18:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 18:34:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 11:33:50 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 11:33:49 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 11:33:45 -0700
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
Subject: [PATCH V4 0/3] PCI: designware-ep: Fix DBI access before core init
Date:   Tue, 20 Sep 2022 00:03:39 +0530
Message-ID: <20220919183342.4090-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT060:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cae5e07-9b1e-411c-a53b-08da9a6d870d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PsKcn1oo2MJ/2vf+hWvsdt0Edx8j/jZH/WZss8ZnmZFDLFmDy867CPiwq6dVwx6qG36O5yfiiQjWV7EOuL7CMe5401gHITP9u36JOQxsN/rPnbaYA4A4gTyzmqlljcm3WFbRrmkEgemE2s5GDmmvAQ2JWrKHbtDdIL9pa3hLdmqLQccy+bECrFoHmN9ecNDCwKc+GE5BRXEvvqlJ+8EM+/YgbT+TQzWrunMN+3RqsyrlzZi0Cc1UbAvaOSSGmk8CZOSZyCY2E2q0A2np/TXr6XRtqwmxUmPLI1EqZZ3kj0+OzmxLchOUNuwJfHKGc0HTXt8Cmz7DVbFW5IPw427ZxT7JwpvyFzbwclWqDCJ3kURatseD5HRGq1m7gY+WxDnNKXYlsj83fU1dkr80/CR/oGhLOOsX8TQkx6WuPkb1GEByyH2/hYTBevN1hhO+uC8yFJPIgEnT/US2YYcMfgF/5u5s7u6E4N+JVzVBs7KFF+da7AIzVhB0rgFfcI7wedplVaf0Xx0sTy4hSGienlY6CHspbx5eQnlmrGPa4xJk4jc/kMngaQn+nk23PtlMW18FUBUI6n7o+DksRCQslLSH8Z3c2IEMs9HBIBd8pyy8kpjYUdaQCX8X6m8anaz/iZce983EsVwYSgzHHlyhPx2FLO/9jX1v1NK3AmzE4UpzYxHoe/bspDx1ZdMe5G5VC6ZMku2srJ/xX2pSblnQzZcqLunzsgAeO4JGALzn5aV3oFzHrEidqCkLAtuuSXtrKTcIJ/mPDv36RGtk3QCU2POvwo0XvLHuPuwAKXfpV/mK3B0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(70586007)(70206006)(7416002)(4326008)(5660300002)(8676002)(110136005)(86362001)(8936002)(54906003)(316002)(47076005)(82740400003)(426003)(36860700001)(83380400001)(41300700001)(7696005)(40460700003)(6666004)(478600001)(2616005)(7636003)(336012)(186003)(1076003)(356005)(26005)(921005)(40480700001)(2906002)(36756003)(82310400005)(4744005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 18:34:03.2715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cae5e07-9b1e-411c-a53b-08da9a6d870d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

V4:
* Addressed review comments from Bjorn and Manivannan
* Added .ep_init_late() ops
* Added patches to refactor code in qcom and tegra platforms

Vidya Sagar (3):
  PCI: designware-ep: Fix DBI access before core init
  PCI: qcom-ep: Refactor EP initialization completion
  PCI: tegra194: Refactor EP initialization completion

 .../pci/controller/dwc/pcie-designware-ep.c   | 112 ++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.h  |  10 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  27 +++--
 drivers/pci/controller/dwc/pcie-tegra194.c    |   4 +-
 4 files changed, 85 insertions(+), 68 deletions(-)

-- 
2.17.1

