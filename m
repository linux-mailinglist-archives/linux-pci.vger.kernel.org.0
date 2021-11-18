Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D451455EE4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 16:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhKRPG0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 10:06:26 -0500
Received: from mail-dm6nam08on2044.outbound.protection.outlook.com ([40.107.102.44]:38152
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229607AbhKRPG0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Nov 2021 10:06:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBGAbnO7LPJH2xnXa+m+Gu3ULg7fRSkQ9ee6xm+bJYyBJU1WGKQDoDzXt62hRLnvd2KqB8nB6dYjuh3ljMZR8vlMsyVb2RbvnTkSwh1G3qgvOaG576rKyCIfIrFS2f/6BSIPalhAWI3Nhi/rxmJBOQfb6eSS7eltrGsda+Ci9lAbhHfEilT2I7I66YpTDW55b+AHVVUhSHAhw0z7jSvIA6KIlcpuF8M1qB25e0eQOFmzWjVpKOMngr7TE3mgGtbFK9xTDBn9w8AG/i2S31kaUOuo/hjlJQv9Ldd6XhtGtqvRQgERbI2s9whrXhHFSF5/k5T/1DmhQcCMPTnBY23KCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3qQ45fsmxvVxqL8wr5ZfHMpYpaPJ3Fm+RyvHmNuEoI=;
 b=aXAcroWP1oI+Qo+WA37UtgtTLv+4sbTRggUsv+KJ9Ja60Qek/gd0JPjfVPtGjS6URE6MtRjotBcAAjH2l79u2AXUie9nWs21hRiFFQDI+dwXl2QeLMk8ByQMo9U9p4XbuRInuDN/TH/olYhqgp3TlSJuned+VA4utSFIvFcLCCBbgFya7mJtJJMf/tlMW+VWkPaCKem2T9OdnUL0tqc461bAUCk6eR2fn9MfGrKy2H9mqkR4RCh8sFX1hTQwzuLK4WBcN6vPGPNg+lYQmWlZNy3XkWdgXmJfzQNlZpFuYiKAJQYFqH/MjMMvvDKyyE9naP46IZoTolvJ513K5N83zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3qQ45fsmxvVxqL8wr5ZfHMpYpaPJ3Fm+RyvHmNuEoI=;
 b=GZg5UyopTg/gXFYm2NKt6EWyqbvpsHluyEW6br+imK7SSs4p/gruabGIH1TrPnuhGUmUAzOqz8xJCEYgXugGag6babzkjsv8WnzBDsfoGXxcWTVIJnVH/XHvAgzH/Wh/lbe06xoGqrvpX1W/EWW7U70v1ttLI45GIYBsbMyxkPffnxl55pU1EK691mksJFzry9JpiCrqjYrfFcxbDnHGIw1ANNy/Fm+3IHqe7NJ2SIbkLMRk6w/NqM4IaMzF0h4fIvwdQvKj1mhO6qi4MVzIfRQ7OisyB0cFaxVhaAnHQuRT4x/l2Wd6ZHs2++OxnOUFnt6utKmPq8YoPnUvjUXxpA==
Received: from DM3PR12CA0127.namprd12.prod.outlook.com (2603:10b6:0:51::23) by
 DM8PR12MB5397.namprd12.prod.outlook.com (2603:10b6:8:38::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26; Thu, 18 Nov 2021 15:03:24 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::72) by DM3PR12CA0127.outlook.office365.com
 (2603:10b6:0:51::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Thu, 18 Nov 2021 15:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 15:03:23 +0000
Received: from [10.25.99.100] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 18 Nov
 2021 15:03:08 +0000
Subject: Re: Query about secondary_bu_reset implementation
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>, <hch@lst.de>,
        <okaya@kernel.org>
CC:     Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        <thierry.reding@gmail.com>, <linux-pci@vger.kernel.org>
References: <40b03450-8f42-29d5-b65e-43644ec44940@nvidia.com>
Message-ID: <0cc150cd-664f-05de-c8eb-81c81583cad7@nvidia.com>
Date:   Thu, 18 Nov 2021 20:33:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <40b03450-8f42-29d5-b65e-43644ec44940@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2008cc7a-c986-40c9-b8bb-08d9aaa4915a
X-MS-TrafficTypeDiagnostic: DM8PR12MB5397:
X-Microsoft-Antispam-PRVS: <DM8PR12MB539738545AC9740DFCB3E942B89B9@DM8PR12MB5397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fZWNWvtFRQCbOkTQprwjIP4ATe4W80Mq/ekjI0y0ZWS3emAY9FAuwc869VL1HHRH4EysbF/GifvhgpPS12u9YFfETsaCtAgkUhlLBDdSBNG4BFaNL/+5ozBLWM3PwYIUWwenoDTrhKxK5NGC5oTowdUYomIvIPjckvQxHHPFwvDVyz2mAUDd0po5vZmDkFOMSDEFo/SdUCmYWCBaGlWXnF9r0zYHJoTj1y57Y3XebkwGtJ0JVk2+LGeKZi8UO9SLYsX3a+wyKrD9T4EJjKeKQxvOdvtPz4pdORjXVT94IRqP29pl1Q0cVbJ7AvtuCmm6aK5guT3X7aug2v4D4B47ij6+nGpvF9o99uafewENqMmtaGLkAeMySTXUBIulhLcn08nxTmlG2tG43ISQ5WlMpxcpgio3VOrRWOTzGyKPDPJS+Pp0sOo/kVLtap033dE1GRKvdOj91Hgolhd1IV9BQYBRmXetVRp+srOmtFrImE6VE7j8IP1+rHtA1Lf4fzKl043hSVXbJkle2sKtl8aDSQC/LlkpMYVHbn1cy7ylvPaVmMVWes4izrMUZmuxKmwD9KZdrPa8C+qgoBLztXOTwYKUNbBFdJc6CxPqpcc16xmrDXq4dy6tff9fbQG56iElLJS1B77RLacEFmbYuLJupH2+fK1xby+9foA/lqm8MEG95ctke960R5LuX9DSFGSsBCEfx+CsmwTFsARqx5jciiWeIQ5t0LR7nnM2oAfd9k=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(31686004)(36906005)(82310400003)(2906002)(5660300002)(31696002)(26005)(316002)(186003)(16526019)(2616005)(70206006)(16576012)(36860700001)(86362001)(508600001)(426003)(70586007)(8676002)(336012)(54906003)(4326008)(6666004)(47076005)(83380400001)(110136005)(53546011)(36756003)(7636003)(356005)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 15:03:23.8576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2008cc7a-c986-40c9-b8bb-08d9aaa4915a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5397
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Folks,
Could you please take time to help us understand this better?

Thanks,
Vidya Sagar

On 11/15/2021 11:24 AM, Vidya Sagar wrote:
> Hi folks,
> Regarding the below commit that added pci_dev_wait() API to wait for the 
> device (supposed to be a downstream device.. i.e. and endpoint) get 
> ready, I'm wondering, given the 'dev' pointer here points to an upstream 
> device (i.e. a root port) because the same is passed to 
> pcibios_reset_secondary_bus() API, how is passing a root port's dev 
> pointer to pci_dev_wait() is going to serve the purpose?
> My understanding is that it would always get the response immediately as 
> the reset is applied to the endpoint here (through secondary bus reset) 
> and not to the root port, right? or am I missing something here?
> 
> 
> commit 6b2f1351af567110cec80d7c067314c633a14f50
> Author: Sinan Kaya <okaya@codeaurora.org>
> Date:   Tue Feb 27 14:14:12 2018 -0600
> 
>      PCI: Wait for device to become ready after secondary bus reset
> 
>      Setting Secondary Bus Reset of a downstream port sends a hot reset. 
>   PCIe
>      r4.0, sec 2.3.1, Request Handling Rules, indicates that a device 
> can return
>      CRS Completion Status following such a reset.  Wait until the device
>      becomes ready in that situation.
> 
>      Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>      Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
>      Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index dde40506ffe5..0b8e8ee84bbc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4233,7 +4233,7 @@ int pci_reset_bridge_secondary_bus(struct pci_dev 
> *dev)
>   {
>          pcibios_reset_secondary_bus(dev);
> 
> -       return 0;
> +       return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
>   }
>   EXPORT_SYMBOL_GPL(pci_reset_bridge_secondary_bus);
> 
> 
> Thanks,
> Vidya Sagar
