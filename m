Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04433A9478
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 09:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhFPH45 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 03:56:57 -0400
Received: from mail-dm6nam08on2069.outbound.protection.outlook.com ([40.107.102.69]:10720
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231195AbhFPH45 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 03:56:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/xE6y7vdx9wn6Sw7bKrxIYxQT9hPXOJoN1LINm0JBRRMENkSqYH1uOAAwa4tQhDD922Z3hvB212yRR8Vub7d2XTEkxeEFKGok+wJ3jKP//OcRLBxrMU7G/ldRaONYVHQ9SfYkwU8mSZ7JCakS2sNPhiYiv5Aea1oLRY9rDN7dSpg23oxoSysuLI+yAI/64rUf41+QkUMj/qKxX3QjvOKFfQ6ihYLEgsGb4T96GgSGpYcbboQFS3Ldygjgoz50ItM45OiREKdGtKLVvpVXZE+oSZqq7JX5bw1Pn2dp53VLELuzus7lRXb4vSbRwZZIK7U3QQpgGgr8fTtm/N7PucLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9GppNZCWNLija63MfpbTkOSDLQdzB/6ngy5C+XJjV0=;
 b=JOBQGVOJonGzEIqxPrEnbae/F/fL2aDzKn2T91kCUIFGLABPFCdTtGfQ7uCpiLknv/X2PTTYrgZrdkVYQ2z3XnTHyfSA688LAaQ1ozr8C5dBEU/ivzSKDGUljQRThn6XDjK/nS7mCvsyEvaHqFTtXTzj16/hGnUrUZke/JrAtSgVKywh2D6VnUaK7HlqgURUFz1k2BgR24OQTeaoMdA9XKcO87EjLGNQPWN7pyhBXECCkNjeDQJ4U/G9fwi9iOQnFjkHf1DUULe8Y2JYK7vSVyEIcfxiXqPHterI/3+hbOSoRAfopWPCMCOoM6NflSIJfoyHDLiy6LNVh/HegmFABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9GppNZCWNLija63MfpbTkOSDLQdzB/6ngy5C+XJjV0=;
 b=tFmRvvsOcNKRKEcq/iEi4AB+rXOAhFtQ4NMXd8MCNzKlzgaipMlOBe7OGfpyo2Yvw27AS5DSto1laeiWfYOuPJjbc0FckxAQ5IcAA9AM5BSPFqgtb5sbXzigMdo1lFT9sCK/aRn+pmOVZPzAIEnA5TD+90qDASxK4NFxxODVBJSXrfFHTLz4GsLbPNSO7jc5yoNpLRzhY3J8Qo61BNnZrapPccXVJpfhRU33r+D74nq2nCq/7OugZ3Z79GG810S2w/taYucgjYgSBtkI5IyKM1cFonnab2YgNc0J5/P1YsFSkGTMBq3QF4FqKEB/b4aRkbpngqFKDzGzX7RFHWAspw==
Received: from MW4PR04CA0309.namprd04.prod.outlook.com (2603:10b6:303:82::14)
 by CY4PR12MB1446.namprd12.prod.outlook.com (2603:10b6:910:10::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 16 Jun
 2021 07:54:49 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::bf) by MW4PR04CA0309.outlook.office365.com
 (2603:10b6:303:82::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Wed, 16 Jun 2021 07:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 07:54:49 +0000
Received: from [10.26.49.10] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Jun
 2021 07:54:46 +0000
Subject: Re: Query regarding the use of pcie-designware-plat.c file
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Vidya Sagar <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <amurray@thegoodpenguin.co.uk>, <gustavo.pimentel@synopsys.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>,
        Thierry Reding <treding@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210615194209.GA2908457@bjorn-Precision-5520>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <10a92c35-6e4d-0428-079c-7e98ff6e9414@nvidia.com>
Date:   Wed, 16 Jun 2021 08:54:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210615194209.GA2908457@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20fb257a-973c-48a8-f480-08d9309c0442
X-MS-TrafficTypeDiagnostic: CY4PR12MB1446:
X-Microsoft-Antispam-PRVS: <CY4PR12MB144613349ECB30413758C078D90F9@CY4PR12MB1446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEE7vN03nvUYBUNq48Cn4gqSyN/GCn3IJd9ztARuf8XqFB7wcD1Fk60m9tH4rSLbwSSVKC+2wFTmr+saYgvUqaC5XGXdLpKSTmEuIXFmSL/+nIOySLqip/32HA5gV61DUAZ9MIICxIjORynWQwgpmnwhdl21rmsVgFimNhNmUc7yn4duHbTix25SKkH9bVJkiON59+hIHqPttQxgkG2Z+5tdmZy9s8E/wAsGyDsXHl/xObXfbcGyYNjUmfPz8Nkg1iip7cONZBopplBYCOo09gjMbROSizUpnQU6Z4dqnw9L4OJmDnwoNyj0Bk6uEQm80Xu62vX2M1/bpBUnYUJwwYeA4pRzSFNdYX+SEokQxmOAbe9/+dE2prgvOLSHe8h41+SyoSEyBGY6ZhQBdZrq5dsgV0h9c9tRzOFPC0haFifoQMOc1QEWi6cBJzDP5J9yXqQnDU6W3C0EIxwMGBfrx1JCWTljs4+vjF8m2dUyjwrN1CBcB+HgPjv5KxTliAk6blYP9DGf4HByakMS6+dI66AiI+iLyIpGQ7TMeRiO18NVEtMwcBAR0G2l9cj/roIWUaAIFbEEV53pD+o3Ob+p2Z6Ql+WiJiB7K67L1xQRlkCJ44TZoRYY7i2dQeJzQzSnCVWz2MvAUXb1e1pADmd+O3+bBfXlryoOf4k4wQQocDKbvmCjdsKukPrcnJxeVdKq
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(36840700001)(54906003)(86362001)(31696002)(5660300002)(8676002)(53546011)(478600001)(186003)(426003)(316002)(2616005)(31686004)(2906002)(16576012)(36906005)(4326008)(26005)(47076005)(8936002)(36756003)(356005)(336012)(36860700001)(7416002)(6916009)(7636003)(16526019)(82740400003)(70586007)(70206006)(82310400003)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 07:54:49.2644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fb257a-973c-48a8-f480-08d9309c0442
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1446
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 15/06/2021 20:42, Bjorn Helgaas wrote:
> On Wed, Jun 09, 2021 at 05:54:38PM +0100, Jon Hunter wrote:
>>
>> On 09/06/2021 17:30, Bjorn Helgaas wrote:
>>> On Wed, Jun 09, 2021 at 12:52:37AM +0530, Vidya Sagar wrote:
>>>> Hi,
>>>> I would like to know what is the use of pcie-designware-plat.c file. This
>>>> looks like a skeleton file and can't really work with any specific hardware
>>>> as such.
>>>> Some context for this mail thread is, if the config CONFIG_PCIE_DW_PLAT is
>>>> enabled in a system where a Synopsys DesignWare IP based PCIe controller is
>>>> present and its configuration is enabled (Ex:- Tegra194 system with
>>>> CONFIG_PCIE_TEGRA194_HOST enabled), then, it can so happen that the probe of
>>>> pcie-designware-plat.c called first (because all DWC based PCIe controller
>>>> nodes have "snps,dw-pcie" compatibility string) and can crash the system.
>>>
>>> What's the crash?  If a device claims to be compatible with
>>> "snps,dw-pcie" and pcie-designware-plat.c claims to know how to
>>> operate "snps,dw-pcie" devices, it seems like something is wrong.
>>>
>>> "snps,dw-pcie" is a generic device type, so pcie-designware-plat.c
>>> might not know how to operate device-specific details of some of those
>>> devices, but basic functionality should work and it certainly
>>> shouldn't crash.
>>
>> It is not really a crash but a hang when trying to access the hardware
>> before it has been properly initialised.
> 
> This doesn't really answer my question.
> 
> If the hardware claims to be compatible with "snps,dw-pcie" and a
> driver knows how to operate "snps,dw-pcie" devices, it should work.
> 
> If the hardware requires initialization that is not part of the
> "snps,dw-pcie" programming model, it should not claim to be compatible
> with "snps,dw-pcie".  Or, if pcie-designware-plat.c is missing some
> init that *is* part of the programming model, maybe it needs to be
> enhanced?

Right and this is exactly why I removed the compatible string
"snps,dw-pcie" for Tegra194 because it is clear that this does not work
and hence not compatible.

Sagar is purely trying to understand if this is case of other devices as
well or just Tegra194.

Jon

-- 
nvpublic
