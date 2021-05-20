Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E429A38B076
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 15:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242468AbhETNwa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 09:52:30 -0400
Received: from mail-bn1nam07on2062.outbound.protection.outlook.com ([40.107.212.62]:3973
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241427AbhETNwU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 May 2021 09:52:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtMAzIvaisOKbH0+AEXAz4pvqqvDyodSGQyAqcQ3fNqhRezN1plHuSW68AgbL8zKfu1HM49MYgpRqYrQ2v1eyMwVcTjgCIeSX/IbQt5P1oK9iMfv9ywK+8BpxL6wNGU2MLFacFgOll1+uZHsJvfZOQ4vfUWlSNrWnhU1bRSN4OcHUOEFgn6qYZAXQeQT47/DlWsAenTAlt9rv9AGfAtbfyxcKKuggNM5jTqsx+9QWMw23vy74T0SHqYN/9QB8s3JNGBrA82y8c3aJplfKaxPQjLuF9T1ed/acaxMitUTNe/l468cg+v+eIOhyV5sHODqnTaShBMsSP0EgInBqWrk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/IEGHhtmItuoKlAraksHKqlJ83vJZxxZAqbLjBTz0w=;
 b=ogUyUY0fquzrmJT/pTUdkGRorvIccNRLBCVkHsez/XhxNBg8MLtJ+KKIkyIhSa8Osa86QpPfvUHdkq8a/w3hyawK1mM9zNoI7KN9i4TleV4PPWVWuFqA0tojLBblE8CPf3CpSSgkc+Kbt3GimyNeSC4eAbFX968xZ2V6Mr3/ckg5Z2XDBKSRazYDlJp12a15k6w+T31iejRWGUnM2l0HL89skqUeLbibqOsRZlEzncT4GWD2g51Hb/3YqXfByIE3ok244Nr8SziYaqFpJrnExNGZQOsFce0PsIcu/pFDcoySQeAwE4qtZmwO8vCuSxvxobOXWMtFdKFVTF5nDXZm0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/IEGHhtmItuoKlAraksHKqlJ83vJZxxZAqbLjBTz0w=;
 b=tnEpli4WFSbPhqWJtxv7ilKimkQW5asEuChzVUo+dB+90NU7Z0V6qJI4yq45Rp8SAFzM83Io1SI2RMgZPGZEdyo10Z9U6GR5u4H1XL9Mx5G6nyiKZmwh00AZojhDjd7jv437XqDJjWh1rMWDlPdxASXnbgDicrt9tIlOjpnUXJa52oKPF+kadhN1KPo70uktyz+EysXuh6VKdCwzwZeGK1uQwIF9z0GsOGtKd1GZOfZTqjL7n1zDbJP7eONP2jDYSUEdQVb6n0Spb5cLOZ6IKgG7W7iuFyCYtgvaROtvWFIdGZ6sbvqcNPaLS5LYUb6FbihwMLorRuzbxLYYnGWrCg==
Received: from DM6PR10CA0006.namprd10.prod.outlook.com (2603:10b6:5:60::19) by
 BN6PR12MB1251.namprd12.prod.outlook.com (2603:10b6:404:1a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.31; Thu, 20 May 2021 13:50:57 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::c5) by DM6PR10CA0006.outlook.office365.com
 (2603:10b6:5:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Thu, 20 May 2021 13:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 20 May 2021 13:50:57 +0000
Received: from [10.26.49.10] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 20 May
 2021 13:50:53 +0000
Subject: Re: [PATCH -next] PCI: tegra: Fix build warnings when CONFIG_PCIEASPM
 is not set
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
References: <20210520134209.1667244-1-weiyongjun1@huawei.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <152ea963-1a3f-eba6-93d9-95161b8f7b7d@nvidia.com>
Date:   Thu, 20 May 2021 14:50:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520134209.1667244-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0129770b-1f39-416a-da79-08d91b964b71
X-MS-TrafficTypeDiagnostic: BN6PR12MB1251:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1251E494ADD317B1E1D0867ED92A9@BN6PR12MB1251.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:94;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7mKJw0v/a4Tw9OChvO14Abc9S2V9yhHLB451Vu+HO3UxHnzvNFyNDrt1C4G8mtXUDk08uEx7ME0owH1L3g5eGJj65b2+1TwtQ4T0idx6nWzRmwCJFsuKv/oXuBdzNanDaOfBVZc2Abw9pncaBnCNbcZQf5MxjRrQDVjeP8XsaD1xFyNAADVUKRuT/aVJ8X1mIVxAIkExD3PK8oD8E9OsenAugyslfia7ovj7nbTkSS4SKVMGQbKFzWFhhtVW71ZqFem2cblgU25RpUWq0LfqsFrBnv7dIGcr73nXIB7ikd13kinlV4lTC8M12USdb3P8o8nOOyxMVdO0sDNBfOWkZHR3BXDn70xHkr0GhgT8ys5AGDJeOggIWnmDywWpPstpwAoLDJbsm3cVTw2exwn+Exb2bs/bX7PIXeOzqTkJx8eukA2i2BwL81mOyJbmhoB4ctTerP8ES7MUpjigExENwR0jF29/6CLOm6kJMBVmljywnWH8RolWBw0sc8EYD1narX5r75yYh1QTBs8G4bBzGFNwfqHkMaM0P9Jgi7x1CkxOOIe/2oVjqkJA6Q8vQs3zS9yjAZeDcIU74KAOBOSYOSqpWQWm9gd8veoyZhRSDYRvWTa8GGod7MMpGx+B+eHDfNnNpCXxKLGe51sQ+q4znTYPPHJPrSV4AGam/PnFv4bgZq37OLYxm14JBMCao+zN6GP3BtZ/GBxqm5O8XKy+xgAJ+CWA1Wz4wnZ+ChoWq5UaUB4JFDx6tIwahHP7j6HN05Jv/oVioGVUj1boPnqt8HGCeHDZlsXc9J/QErB1HM=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(36840700001)(46966006)(47076005)(2906002)(31686004)(7636003)(356005)(53546011)(82740400003)(966005)(8936002)(70206006)(70586007)(83380400001)(8676002)(26005)(36756003)(5660300002)(82310400003)(478600001)(54906003)(426003)(110136005)(4326008)(336012)(921005)(186003)(16576012)(36860700001)(36906005)(316002)(16526019)(31696002)(2616005)(7416002)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 13:50:57.3303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0129770b-1f39-416a-da79-08d91b964b71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1251
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 20/05/2021 14:42, Wei Yongjun wrote:
> Fix build warning when CONFIG_PCIEASPM is not set:
> 
> drivers/pci/controller/dwc/pcie-tegra194.c:259:18: warning:
>  'event_cntr_data_offset' defined but not used [-Wunused-const-variable=]
>   259 | static const u32 event_cntr_data_offset[] = {
>       |                  ^~~~~~~~~~~~~~~~~~~~~~
> drivers/pci/controller/dwc/pcie-tegra194.c:250:18: warning:
>  'event_cntr_ctrl_offset' defined but not used [-Wunused-const-variable=]
>   250 | static const u32 event_cntr_ctrl_offset[] = {
>       |                  ^~~~~~~~~~~~~~~~~~~~~~
> drivers/pci/controller/dwc/pcie-tegra194.c:243:27: warning:
>  'pcie_gen_freq' defined but not used [-Wunused-const-variable=]
>   243 | static const unsigned int pcie_gen_freq[] = {
>       |                           ^~~~~~~~~~~~~
> 
> Fix it by only define then when CONFIG_PCIEASPM is set.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>


Thanks but this has already been reported and there is a fix available [0].

Jon

[0]
https://patchwork.ozlabs.org/project/linux-tegra/patch/20210520090123.11814-1-jonathanh@nvidia.com/

-- 
nvpublic
