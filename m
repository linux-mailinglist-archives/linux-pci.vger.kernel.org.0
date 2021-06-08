Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C603A04FD
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 22:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhFHUNa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 16:13:30 -0400
Received: from mail-mw2nam12on2082.outbound.protection.outlook.com ([40.107.244.82]:14208
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232764AbhFHUN3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jun 2021 16:13:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRNTk70lh+nI9UCxiRxo7Z6WNe1skMoiFE1VyzbUqAuRnUTq3+UVZDdzxXBIN/NMsKlzZfh1MqK5SrrRsSQQyn8VQO4Z3JTZLsKx38hRYxquE/TcqDCksVUl0ZYRwtNjWwOboBRmXgKr45xZCt+rcGGGqIdvf5K9EyytN1sTVhiCLucB6jHxdNRWzNAosEkTfOZ60GtrP4pdLB1FLQeusDSr2iRg1M1ZRND5PRmy9H0H6nPbpGivKlZ5fTvEHU96ZdR++gsMZzKYCumEM5kuaA2v1gZdZ8XGkZpfpwDXbLATGpdbKfYQScjtuebikaAKyeAKFBB56vlGfZiqrrlTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIVutr/W+6qREm1qtZjViDSWW3q2e7U8yoxh49uqjEY=;
 b=hJhKYt8/cWMWoT9IcUr//BiUdNfVObrkO8K1DOiZupZxFj5MgnoHYAMy0ATAOvXSebSitjIz9jdE9mZOckkl6PnS+RJPcU6Xz4IjH37Cpf5ubBuq88hiDTSC4YUwCb7xx/hlRV70s9MgBONyvLQqKDgelhzcxbhc3nyoRS0zxuW/JH1Yp1COkm8LfRJtKj6mBf9Ew/DmmjEvYGbp8NsKdzpz5Rf8P+g9/Hekc4RAyHxhNWyI1KyNJ6mJR/1JRht8WTXZQ1MwAGfzGkgmqwhPUxOwR/HJwx51huzz0HuQknvza+ilt28D8vOklj/hcrKHaJHKhd3kyuYl4YZueF5X0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIVutr/W+6qREm1qtZjViDSWW3q2e7U8yoxh49uqjEY=;
 b=G4dPlL56hgndZcozQcnKPJ/N8sz+eC99RcAnQ9FVml3irpwkPHaAHD4nTk/SBvoGtoSTv6fBemSBekdgTn3HLauMqrKsixIwYOxfpeSBckytCIEH0ucLjuitHqAdCSqDzHniN8K6LuBQNJuL2RYCUxR30akxl9+Gik0oipLREXNvLK/LEtVAYIblZ4BEMPuB2R7JSQV3yR3WYcoXYjS7htkMdz68iLywIxw41g3XBKZ4a6cevmKxIpfl+gLFr/qTdK2Fe8p0Ego2PdJElC9sSyFqNLBFeySCNfbvqhV/3rATg5CSI2GlGrab3bZeiHQ8nVCY6p8MjXpRv+DBPZPVXw==
Received: from BN6PR17CA0059.namprd17.prod.outlook.com (2603:10b6:405:75::48)
 by CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 8 Jun
 2021 20:11:35 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::8) by BN6PR17CA0059.outlook.office365.com
 (2603:10b6:405:75::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend
 Transport; Tue, 8 Jun 2021 20:11:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 20:11:34 +0000
Received: from [10.26.49.10] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 20:11:29 +0000
Subject: Re: [PATCH V2] PCI: tegra: Fix building Tegra194 PCIe driver
To:     Vidya Sagar <vidyas@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20210608130207.GA2597738@bjorn-Precision-5520>
 <754e3546-402c-2a0d-02e8-5d30701f3b94@nvidia.com>
 <9b027609-a2c3-3df0-5e65-1f282f03cc5d@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <303946c4-29a1-4f5b-6a4c-be451ece20fe@nvidia.com>
Date:   Tue, 8 Jun 2021 21:11:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9b027609-a2c3-3df0-5e65-1f282f03cc5d@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6b002e9-9e11-4201-c948-08d92ab99d81
X-MS-TrafficTypeDiagnostic: CH0PR12MB5156:
X-Microsoft-Antispam-PRVS: <CH0PR12MB515677D69A9A3CDADDC10BBAD9379@CH0PR12MB5156.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sax39P/2WtloKGio0WShMq5XFyF11HEkQNl9tx0PAYZVj1glAq8nohmS21QisKK1sVebRnZ22yl84U6zn7sIJh+Bk5dMu9qJWh1GPoxH1kbbr86o+c8WGGSUVomLQ6isndrpVeCCS6spieEg6WEGB6FT7SaIsR3NZND/lHXREfMA/KGU/z4x7DVj4MXwvNwz2w4wwaDRB7+ni1Pzq4ZGcWNEZU/Dv7WU3mDnk1IVvUfBd8xaq0J70VGjuKqTAO1k6TYHvJ5RP3+7TMWRcvyXJrITseGLaY2mV9w2aqGFfNAeUe2PCYPuIsc1Cj1goPf/7uys77K1UKJQXNVu4gtSlLpSBdRsBxA9oi8sXnayAKU+vWQWVQd8HK5aueheR72a31HmdtpjWsuwHIoLsIJW6F+IlhumiVhB0/eY3IvT48Ee3bodC//cPfPawREbVMQVLTXZnPFhrJYqUoaf4+98+DoUuc7KFQyGVTS0ragPCjU+mKbr1aUaTVSD5GphBlQE7cPRUNQoaLgazL6b63ad6eOJ3I54Ky+Yl/eeU/LvDPKrWJ2JeVN28n77tct0vEndRarViGE8LKLcEF0lQ2jZyv3/kFXNqaZyZvKnAZBHTbJ722jcqYStyPLpMTxpA8uASgecqlTg6XO5KDAdtUEvzrGc1x2bl3F1JBEKuqevTUrcOpL/T6SPvOmty/84VjlA
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(316002)(16576012)(110136005)(2906002)(54906003)(86362001)(31686004)(47076005)(82310400003)(36906005)(478600001)(5660300002)(53546011)(36756003)(36860700001)(7636003)(356005)(336012)(186003)(16526019)(8676002)(26005)(82740400003)(4326008)(8936002)(426003)(2616005)(83380400001)(31696002)(70586007)(70206006)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 20:11:34.7661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b002e9-9e11-4201-c948-08d92ab99d81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5156
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 08/06/2021 19:34, Vidya Sagar wrote:

...

>>> What is the purpose of PCIE_TEGRA194_EP (added by c57247f940e8 ("PCI:
>>> tegra: Add support for PCIe endpoint mode in Tegra194") [1])?  I don't
>>> see any reference to it in a makefile or a source file.
>>>
>>> It looks like one can build a single driver that works in either host
>>> or endpoint mode, depending on whether a DT node matches
>>> "nvidia,tegra194-pcie" or "nvidia,tegra194-pcie-ep".
>>>
>>> So I think PCIE_TEGRA194_EP is superfluous and should be removed and
>>> you should have a single tristate Kconfig option.
>>
>> This is a good point.
>>
>> Sagar, any reason for this?
> Although it is the same driver that works for both HOST mode and EP
> mode, PCIE_TEGRA194_EP depends on PCI_ENDPOINT whereas the
> PCIE_TEGRA194_HOST mode doesn't. Similarly the PCIE_TEGRA194_HOST mode
> depends on PCI_MSI_IRQ_DOMAIN which PCIE_TEGRA194_EP doesn't depend on.
> It is possible to have end point mode support disabled (at sub-system
> level) in the system yet pcie-tegra194 can be compiled for the host mode
> vice-a-versa for the endpoint mode.
> Hence, appropriate config HOST/EP needs to be selected to make sure that
> the rest of the dependencies are enabled in the system.
> Hope I'm able to give the rationale correctly here.

Yes but should we combine them like this ...

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 423d35872ce4..206455a9b70d 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -254,15 +254,12 @@ config PCI_MESON
          implement the driver.
 
 config PCIE_TEGRA194
-       tristate
-
-config PCIE_TEGRA194_HOST
-       tristate "NVIDIA Tegra194 (and later) PCIe controller - Host Mode"
+       tristate "NVIDIA Tegra194 (and later) PCIe controller"
        depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
-       depends on PCI_MSI_IRQ_DOMAIN
-       select PCIE_DW_HOST
+       depends on PCI_MSI_IRQ_DOMAIN || PCI_ENDPOINT
+       select PCIE_DW_HOST if PCI_MSI_IRQ_DOMAIN
+       select PCIE_DW_EP if PCI_ENDPOINT
        select PHY_TEGRA194_P2U
-       select PCIE_TEGRA194
        help
          Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
          work in host mode. There are two instances of PCIe controllers in
@@ -271,21 +268,6 @@ config PCIE_TEGRA194_HOST
          in order to enable device-specific features PCIE_TEGRA194_EP must be
          selected. This uses the DesignWare core.
 
-config PCIE_TEGRA194_EP
-       tristate "NVIDIA Tegra194 (and later) PCIe controller - Endpoint Mode"
-       depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
-       depends on PCI_ENDPOINT
-       select PCIE_DW_EP
-       select PHY_TEGRA194_P2U
-       select PCIE_TEGRA194
-       help
-         Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
-         work in endpoint mode. There are two instances of PCIe controllers in
-         Tegra194. This controller can work either as EP or RC. In order to
-         enable host-specific features PCIE_TEGRA194_HOST must be selected and
-         in order to enable device-specific features PCIE_TEGRA194_EP must be
-         selected. This uses the DesignWare core.
-

Furthermore, I wonder if we should just move the code
that is required for ACPI into it's own file like
drivers/pci/controller/dwc/pcie-tegra194-acpi.c?

Jon

-- 
nvpublic
