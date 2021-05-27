Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CBE392D4E
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 13:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhE0L4K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 07:56:10 -0400
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com ([40.107.94.46]:30018
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233950AbhE0L4J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 07:56:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkPTsJIZ/C38pytofDWSy6DQP0xkaRluP7DHk5/uKgQUXrn7a1qj5mXztWUzE7/XJlTyNk8mJAlGQsJQ74xyAuYUPVcD8bXakHx3H+pI8iZD3p6rh3psXONVG+3630K9jABBg935jULXim2vpF4wbe1+44HyGeZEhBajDfQ0OSv4A/lFtnl2+SasHhJYTPotcNNg4jeBREyI+Esi+tBmQ2hxKQLWX6OFMfTJ4TS9m49J9wkw1Th+m0f8yJJ2b7loqyPOV0/JjnrEakEtpzk7a9J6+csDPdy13VB17xCoPIEd6tl7/zi+m7dRJlhIF5Pg/qiyFXVm9MOduvcAGmsEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4o6yTsHB2EJz2BrQnO5+dTJq61u8wT3ifwe/dRadok=;
 b=JWaxDm7A6WaZJoAZwq7GucA3NNuT4B0KZYFWTL/CNMQqPzl0KuFcxzaKN7YRWOtVfO57FM7J3pOZExAX3svN06bIFvjI+UCIT6gUPTJOghhpjrFqEXMcpCaJqCIW2ydkaZHQjdpbin2S2lsUy89S7H5dhJI8zIQChZ2nGxnZboxEHGq9uq3r7jIJj2dFe4R/l8zMwYoSrXE/xzAWhozkuig5NwbFRUQzI+tOdJ3lU+s84Xdrf81jkb5dINnfAu4YKVlEng0S3jQ/VMlsDnOvTeBGXh+m6Xh+39kI/uRKWiAf5g49OmZXZia18ffB3EcQrEF+SJK07TymPto7wcRNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4o6yTsHB2EJz2BrQnO5+dTJq61u8wT3ifwe/dRadok=;
 b=npouLL3NPyydVarrUeDTJ87DTVbiC82Nk/yVbVb533cRAQat+vUoznA4KmUtLY7I6GwY3S4vb5QrVo1BUh0gI9cSFZSAmVb272ybn2bpmLIpmiINJbAgJfQjjXjV2vYftc23tekUi0z6pBn+TU/oJXbGVyi7SzZIyPVMlSbRrHTO2oGcszKTzXPmWnR07kJWtmmmqy9L2fG8NNxGa8EmZYAuARRaiQGc4aSmmwWURZhI9LnBzfJjLArV0ecVPq2kEqJXoiMV1nxZEFY793IBxT3UJUojCO1fM9kkSxiH23Yo+il2ikybHtTBQuFDbQbn71ndigHr4RYe3Urh/BPBzg==
Received: from DM3PR03CA0011.namprd03.prod.outlook.com (2603:10b6:0:50::21) by
 DM6PR12MB4986.namprd12.prod.outlook.com (2603:10b6:5:16f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.26; Thu, 27 May 2021 11:54:35 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::a1) by DM3PR03CA0011.outlook.office365.com
 (2603:10b6:0:50::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 11:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 11:54:34 +0000
Received: from [10.25.75.220] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 11:54:15 +0000
Subject: Re: [PATCH 1/3] PCI: dwc: Add support for vendor specific capability
 search
To:     Shradha Todi <shradha.t@samsung.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <pankaj.dubey@samsung.com>,
        <p.rajanbabu@samsung.com>, <hari.tv@samsung.com>,
        <niyas.ahmed@samsung.com>, <l.mehra@samsung.com>
References: <20210518174618.42089-1-shradha.t@samsung.com>
 <CGME20210518173819epcas5p1ea10c2748b4bb0687184ff04a7a76796@epcas5p1.samsung.com>
 <20210518174618.42089-2-shradha.t@samsung.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <4feba4f0-e6e7-f5ec-6857-6d0779e24318@nvidia.com>
Date:   Thu, 27 May 2021 17:24:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518174618.42089-2-shradha.t@samsung.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf48ca13-9a00-4a15-7eb2-08d92106327f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4986:
X-Microsoft-Antispam-PRVS: <DM6PR12MB498676DD2EF620B6FB47CB63B8239@DM6PR12MB4986.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N3eJ3BvIbymb957s2Y4i6jjAgVsJfM5FaHNxY6Wp632Q1nOJERYuPxG4fnlbcFYZFRQfjg4v/ZOi7h5DkBHZQAi5YzAlpP/h0VAEzP6MmalgDBRyQtJy89hfWFLvLjqI8fGLwkZWfEa5RuvlxdgGAsqZSK/kODm7Moi9j9Jk3IJtKSv/RJl3BmDDU9e+xKSktF3ykuMcbRmkEUegAUiWQBQAE0HiwZ3J82FMvPy/2iaozH96z16cJxcxhAH01NbF/RPjOz5n5jF7rE77HT4ErVlLUzpplqkt+gVLkz3NhcsN3m1/jlL7X/rvVlEhvy59XHxP1S+sScl0eiIcCieHhXKyhFRsV+rihxILcrLuGpmcoJMGkwDLaJEKXnb7Fy5u518Gx7ePziqQ8hCMaVFhpj1GuAr6LOLk3i4oh9JYNd2is8B7UAjCsRHBfKFKMbW9kZGJXqCePNhVwsxpCzFOHbYG+rPQlV1GDSLTXjkTTi7Y3h27gLgTKbQi9Q9Nj2ShCuSITt4vEFeLBbyCOqq9mJdRdu6pFtHgDG90M+MRac1RpeLjQUZHcmY8NJGPrc0r4o52NmuyHNlb1PIP8eudHoWQJimH2aF4rJ3Bp0ahB0VabZ+jE5v2UcBCDT1dSIcoCR+RwdTndLb71LsqbtHrTcJ2Y2a1MrPfJABcVeLy6YKhse+K6PT3f84DwuUowIh0
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(36840700001)(46966006)(8936002)(36756003)(7416002)(356005)(54906003)(110136005)(4326008)(31686004)(16576012)(336012)(316002)(2906002)(70586007)(186003)(6666004)(82310400003)(5660300002)(8676002)(26005)(36860700001)(86362001)(47076005)(82740400003)(7636003)(31696002)(36906005)(16526019)(478600001)(70206006)(2616005)(53546011)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 11:54:34.9243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf48ca13-9a00-4a15-7eb2-08d92106327f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4986
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/18/2021 11:16 PM, Shradha Todi wrote:
> External email: Use caution opening links or attachments
> 
> 
> Add vendor specific extended configuration space capability search API
> using struct dw_pcie pointer for DW controllers.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++++++++
>   drivers/pci/controller/dwc/pcie-designware.h |  4 ++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index a945f0c0e73d..348f6f696976 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -90,6 +90,22 @@ static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
>          return 0;
>   }
> 
> +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap)
> +{
> +       u16 vsec = 0;
> +       u32 header;
> +
> +       while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
> +                                       PCI_EXT_CAP_ID_VNDR))) {
> +               header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
> +               if (PCI_VNDR_HEADER_ID(header) == vsec_cap)
> +                       return vsec;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_find_vsec_capability);
> +
>   u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
>   {
>          return dw_pcie_find_next_ext_capability(pci, 0, cap);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 7d6e9b7576be..307525aaa063 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -155,6 +155,9 @@
>   #define MAX_IATU_IN                    256
>   #define MAX_IATU_OUT                   256
> 
> +/* Synopsys Vendor specific data */
> +#define DW_PCIE_RAS_CAP_ID             0x2
This is not used in this patch. Better to move it to the second patch in 
this series where it is used.

> +
>   struct pcie_port;
>   struct dw_pcie;
>   struct dw_pcie_ep;
> @@ -284,6 +287,7 @@ struct dw_pcie {
> 
>   u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
>   u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
> +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap);
> 
>   int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>   int dw_pcie_write(void __iomem *addr, int size, u32 val);
> --
> 2.17.1
> 
