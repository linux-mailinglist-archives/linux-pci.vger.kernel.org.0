Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235A4392D47
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 13:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbhE0Lzg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 07:55:36 -0400
Received: from mail-co1nam11on2051.outbound.protection.outlook.com ([40.107.220.51]:17761
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233633AbhE0Lzg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 07:55:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwGsziMk4ez9uX4BHLUY23KZgcSr6b09urGlORspuik3wVaC1K0obGYgmG00lENwqeWeffRnzQcIGJMjqEU7yakRrm3sRoH2Kg3ALaqUCykdHv1ddpcpYv8im7ojLAQ9LjP2yeweAdbsHBTBNhQB1Zir6vmfcS0BBNWzWDXsgtI1loIcTi+QJz74d0swjy53Knvbsrh/lvbxu22HFlldZSbu3/J4WirJA9BlzTuklnwN53CCK2ckExHO4Vlb4+amPJGz/WA9ybGSwKvPrRFrRHW5aAblsXybV99B0loVvCEs1evP/Ce0Psk1/JdsnfqVWPPFL1+cLkXewVksnacRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4iMtqJZxaQ09eq+cBlFwVRGk2FDk4OKfgzdOeVx3QM=;
 b=IcL/FOQXTiKKCEOXPLG7tCuBflQYYVPKPE3Htx00ZKYIDlvImpl14HgRkZ+XdBwofpcCkHOK7YGaPHcCzlcfjEM3M5qhk1C7q1HAoWvZ9RMgRI056UMdwYyvlhVUjWI67BQBjHEmn267YjSqksrgKCaXNXlP34HdOZ7xeuWmjhCfG6hhmn3AuvE54DFjOgkJ0tqV3H0l9ZmvY/0RntgQtXbHWshWtjwqXcoyiRCyzeGSsS02dsi7Rd6q3F9csUwxKJDyv2fQm3I+5/PDzddYYFxTx5mnblwkw6SGwqCWRMA2+fH8IGzCgDG8YPXGqv1JE/qqCjQvckT8ialOn9EcZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4iMtqJZxaQ09eq+cBlFwVRGk2FDk4OKfgzdOeVx3QM=;
 b=DDWRsDJeYk4jRZszusr3KKKbVvZ0lHskAcPzwhRht83CMJoAnXZYULc6migXIdmPfU4LwGumYi1VQvQJQdQkMOPcEpibQZqeC5lOvOyKpHvfbGzPkcNB5oq+6K+OUoy/bOCvsoRP1v90qx0xmqjRpG6OQqyHr9SeoLlEzlDacHYpppdHzWg94CoSK814PTlAkewpoOj8J6Mj3zHYRDOqqaIJLNEo5RuLpb6BXPhg2iUJa8oHtN1hjJfVPHkM54EqSSArEKdOid5sPKs+wAa5gNvPjzqusMFpZMBSdIX05q4jCpN9bKgCNyDNEH92hDVMdrkYi2icotfL7qg8+fDU9w==
Received: from DM5PR06CA0062.namprd06.prod.outlook.com (2603:10b6:3:37::24) by
 DM5PR1201MB0156.namprd12.prod.outlook.com (2603:10b6:4:59::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.22; Thu, 27 May 2021 11:54:01 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::a3) by DM5PR06CA0062.outlook.office365.com
 (2603:10b6:3:37::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 11:54:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 11:54:01 +0000
Received: from [10.25.75.220] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 11:53:57 +0000
Subject: Re: [PATCH 3/3] PCI: dwc: Create debugfs files in DWC driver
To:     Shradha Todi <shradha.t@samsung.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <pankaj.dubey@samsung.com>,
        <p.rajanbabu@samsung.com>, <hari.tv@samsung.com>,
        <niyas.ahmed@samsung.com>, <l.mehra@samsung.com>
References: <20210518174618.42089-1-shradha.t@samsung.com>
 <CGME20210518173826epcas5p32f6b141c9ab4b33e88638cf90a502ef1@epcas5p3.samsung.com>
 <20210518174618.42089-4-shradha.t@samsung.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <8766f746-4688-996a-8368-3fe0f608546c@nvidia.com>
Date:   Thu, 27 May 2021 17:23:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518174618.42089-4-shradha.t@samsung.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91cabd21-8623-487e-025d-08d921061eb9
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0156:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0156EA810302A610747DB086B8239@DM5PR1201MB0156.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4tDZQandPXAtZjqNDmIbalf+J68U7x832eqIpwyki0PNXqoDIQ0mJphjR7BRi+yjstOhV2ZDRpzz0XyqGpImF4f79YhQXggpn3Iex72RS4YTi2XWuMLrrB5lrgF3zTYITYkuspjIKSsRZlDHAlFfmL4DBwSOsiemm1cwOSUYImv/4Epnqv+pvTfFh/QKZDbHRs/8u9Om5YPnur/rlH6e/940reNcryKviOuz4f5kXiZLhRVpZwMwEAZ0hJcXJszJxMRm9yX6qQQek/eMceY81bWTxrRsHOqs0jjuS3sbM6vj+UVvFFaWJ1At65SLzF+eYpNA12bqWOpg4OOVX5x24zr0rKLlaqpRqPi+BkwdAVGsy6SIWNpOmgSEs/dkvtb2HciF529PSbqNXjApeOOOfaj4J683SHUD+Qsfz8ibg+Io0qs/zTxDht3dXe31ajkIdwWXM6372XZuTXESsv29wzaJ1Cp0y0N2CVJyTZLFP6RYt44zkWsqygi9noewekry/WaycKPRzRjiNSmogGrZXFkohr+vUX4c8pY7NJ8z6VvcnaBn14lDWc8zqoxQ5Vm21J1X9YdYbo38j3k3idTUI9qqSuvseRRAz+bR12S+mUH/gRCWKIXS0wkEKLOsAuatHEqtCfcQFVWuICxD3UXEjMydBnjU9W6N/DZLToTtdTdOvVpBfzix3sCxHRHwQcB
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(36840700001)(46966006)(4326008)(2616005)(31696002)(6666004)(8676002)(336012)(426003)(36860700001)(356005)(82740400003)(70586007)(70206006)(47076005)(7636003)(86362001)(82310400003)(478600001)(5660300002)(36756003)(7416002)(186003)(16526019)(31686004)(2906002)(26005)(53546011)(8936002)(54906003)(110136005)(16576012)(316002)(36906005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 11:54:01.6808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cabd21-8623-487e-025d-08d921061eb9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0156
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/18/2021 11:16 PM, Shradha Todi wrote:
> External email: Use caution opening links or attachments
> 
> 
> Add call to create_debugfs_files() from DWC driver to create the RASDES
> debugfs structure for each platform driver. Since it can be used for both
> DW HOST controller as well as DW EP controller, let's add it in the common
> setup function.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 348f6f696976..c054f8ba1cf4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -15,6 +15,7 @@
> 
>   #include "../../pci.h"
>   #include "pcie-designware.h"
> +#include "pcie-designware-debugfs.h"
> 
>   /*
>    * These interfaces resemble the pci_find_*capability() interfaces, but these
> @@ -793,4 +794,8 @@ void dw_pcie_setup(struct dw_pcie *pci)
>                         PCIE_PL_CHK_REG_CHK_REG_START;
>                  dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
>          }
> +
> +       ret = create_debugfs_files(pci);
> +       if (ret)
> +               dev_err(pci->dev, "Couldn't create debugfs files\n");
'ret' is undeclared in this function . (for reference, I applied this 
patch on top of 'next-20210526')
>   }
> --
> 2.17.1
> 
