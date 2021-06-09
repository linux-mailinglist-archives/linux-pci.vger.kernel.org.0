Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1425E3A1B54
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 18:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhFIQ4j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 12:56:39 -0400
Received: from mail-dm6nam11on2057.outbound.protection.outlook.com ([40.107.223.57]:26401
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230215AbhFIQ4j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Jun 2021 12:56:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3umhmbAtCh1kRRu/SabYI2V+OMH0w8l/2tczQiJ/D2YL39s3llmrh1sEPPRu+B+dDpHduEhbvaY9ghWgw865PaHy6aVr7dlGp/q1yJ/JFV7WEBq3A0w5If7sf/yM2ajF0a2BLsgBegXa0abduVcqfnQImQlXJqU+NfEuSxdxxx9sHwsm/DkwlYzfYrp8pojEjYyfiShECPb9FUsnfdq0diPe6dXxMQMQ65ihMLEiJ/Es8Yp81LLD74CXItvhvmFsAp9NuEynQznGZ+44TwVuzqjWtZzzFm5gnIdUDgFDa9PPGFpXCPRMsSvaQH7n+slHndTQXwVPzbjs0BotvlJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zDfrTwl9SB/NWQLL+r6go8LJn22f2yFqIQcI2B+lS4=;
 b=S2dlujqY96uGyt7ZQWISCS9/opac2VS4WOAYI5jmzmHS9UG70/XJv9bO7eG/1wklb9NYEzKGf2SlTwc4plTznjmrBidJDEgcPzIqrXxR1+udRcZ4SoqTh+N4JHwrh3Wh3ghQJ/R8uqZsBOW1a0nbGr3kZ+l9Y2dL/CxYuA4ImY3PUT59XmyswjUZVo++UersUBPi6nJ+Exucb69iYCiOv2pcIWvrwlpknRPGE47nG4oprFhtzrNg/ANl2i07h3RlzHU0uoxTUxAX9iwsL4A9cL88AHf8hNt64DXgyCAS1AWReDx8q+zybpYYz5Rme2b5Nsgx0hMBThiVflpzkOTdpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zDfrTwl9SB/NWQLL+r6go8LJn22f2yFqIQcI2B+lS4=;
 b=HNVdEs1/75h0ZbkIieIl1P5dil6qM0J00aQoJ96KxTzMsdTAJ0AukTNIUgaJQMC2dZYjAtJM5imgD+ljji1WWgFfY36p2hrCfOtvI5yaKSUURAJS4EdeyK0EriRPs+jn5N+SU+oj2NAZLOo79o0tHBPxg78YIHy0VgCQzslla9cwvL/1C2iC/76O+PSRJEesDFO8XwwKpLSdhtSH8AmVSqFjUnP1lF7r/Zcwu7nlonKOEbhtIz/o5ISgeeu3wWp1b1meecro9Anr/AFbXzIs7H3KFbwid+JZVc/BWCybt4/x/iO6rff5zhTC4mF5dNMgKs5jH/WM8psnqIN7by3iEg==
Received: from DM6PR04CA0024.namprd04.prod.outlook.com (2603:10b6:5:334::29)
 by DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.20; Wed, 9 Jun 2021 16:54:43 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::c7) by DM6PR04CA0024.outlook.office365.com
 (2603:10b6:5:334::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Wed, 9 Jun 2021 16:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 16:54:43 +0000
Received: from [10.26.49.10] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Jun
 2021 16:54:40 +0000
Subject: Re: Query regarding the use of pcie-designware-plat.c file
To:     Bjorn Helgaas <helgaas@kernel.org>, Vidya Sagar <vidyas@nvidia.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <amurray@thegoodpenguin.co.uk>,
        <gustavo.pimentel@synopsys.com>, <jingoohan1@gmail.com>,
        <Joao.Pinto@synopsys.com>, Thierry Reding <treding@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210609163010.GA2643779@bjorn-Precision-5520>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <2970bdf2-bef2-bdcb-6ee3-ac1181d97b78@nvidia.com>
Date:   Wed, 9 Jun 2021 17:54:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210609163010.GA2643779@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75542ed0-9c67-4aaf-047e-08d92b6747d6
X-MS-TrafficTypeDiagnostic: DM8PR12MB5431:
X-Microsoft-Antispam-PRVS: <DM8PR12MB54311CC0A7B363AC0C9E69B4D9369@DM8PR12MB5431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIJWNszG2Rdh0Nam9myfZo0mGQDcMeh2Srih1oXiaEyT7trS4r0BkTQNpi3TN1/Y30AZGJ1EQg4bUdyph4qaSwRmfcMrWwl3eiq5ZdvhNRv2PVTfvXOzVt/xmXQHvrGS5h8EFwuDGIi6t5xSGwJHBSBBIwXepfMWKUIgDgXKd42jrEzqH7z9hQU6WrfHx8/7oodNrNB3wKNNPqV6DA2y6ikGr4HCF6sXQxcdqENf752YtX2yk4E6dlJInl5B1f9IVWA40dWLY7galc/GpNhV+WKoeC5gKa/emklm1bbG/JkSqI+pDj+qLWuQkkxBaeC4NeCSOBqhXEKn3iPR/5I0MgG41ksZFbnGrLV6kC0ac6XD5nW7HLF80kek7LqYFe95/AW69wGNumVrmrCALBrxwubXnkMB2BJ7b5g1r4CEBo6Tz5jXHG/RFd89vG3LMZ1dKxJSth9d5FxO+rA3gU4rw0EJ0T9SnpKYi1Iceu0+4/YknHVwOnH7F+qTSdxfC8B4Rc1cYeX2w6SqqDxNn4Lyi9YzbjVFtsOWp5230WWDOCtKm5dTxRTVoyrq5OnhL+ZWBxbB/BXS8sH/H1Kh/lFVbIrthujrRH36jojKfrpVAvO+INysv/kXaaZbsTI9AFbsJjh6swiThBjJNaizmGsQICv45Uxy7mI9co3ubayMpvdIhlW9QI7X/WJJvQft5FTR
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966006)(36840700001)(82310400003)(53546011)(356005)(8676002)(336012)(6636002)(8936002)(47076005)(478600001)(86362001)(31696002)(2906002)(26005)(31686004)(82740400003)(316002)(110136005)(70206006)(7416002)(4326008)(83380400001)(7636003)(16526019)(186003)(16576012)(70586007)(36906005)(36860700001)(426003)(2616005)(36756003)(54906003)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 16:54:43.5390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75542ed0-9c67-4aaf-047e-08d92b6747d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5431
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 09/06/2021 17:30, Bjorn Helgaas wrote:
> On Wed, Jun 09, 2021 at 12:52:37AM +0530, Vidya Sagar wrote:
>> Hi,
>> I would like to know what is the use of pcie-designware-plat.c file. This
>> looks like a skeleton file and can't really work with any specific hardware
>> as such.
>> Some context for this mail thread is, if the config CONFIG_PCIE_DW_PLAT is
>> enabled in a system where a Synopsys DesignWare IP based PCIe controller is
>> present and its configuration is enabled (Ex:- Tegra194 system with
>> CONFIG_PCIE_TEGRA194_HOST enabled), then, it can so happen that the probe of
>> pcie-designware-plat.c called first (because all DWC based PCIe controller
>> nodes have "snps,dw-pcie" compatibility string) and can crash the system.
> 
> What's the crash?  If a device claims to be compatible with
> "snps,dw-pcie" and pcie-designware-plat.c claims to know how to
> operate "snps,dw-pcie" devices, it seems like something is wrong.
> 
> "snps,dw-pcie" is a generic device type, so pcie-designware-plat.c
> might not know how to operate device-specific details of some of those
> devices, but basic functionality should work and it certainly
> shouldn't crash.

It is not really a crash but a hang when trying to access the hardware
before it has been properly initialised.

The scenario I saw was that if the Tegra194 PCIe driver was built as a
module but the pcie-designware-plat.c was built into the kernel, then on
boot we would attempt to probe the pcie-designware-plat.c driver because
module was not available yet and this would hang. Hence, I removed the
"snps,dw-pcie" compatible string for Tegra194 to avoid this and ONLY
probe the Tegra194 PCIe driver.

Sagar is wondering why this hang is only seen/reported for Tegra and
could this happen to other platforms? I think that is potentially could.

Jon

-- 
nvpublic
