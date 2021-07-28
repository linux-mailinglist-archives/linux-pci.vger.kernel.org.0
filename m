Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0539B3D8598
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 03:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhG1BqM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 21:46:12 -0400
Received: from mail-co1nam11on2050.outbound.protection.outlook.com ([40.107.220.50]:38172
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233149AbhG1BqL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 21:46:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZ3wZ0b++OReqNhsiQQp1UFkfN1xV0R+/upb0wxq0GVBSmQzMB7SopYrJXN2vDYnabqugFXcMb8a9UNLHs/gJGdJB+iXtWsjp5eYoRAK0YG1UOEQWhwGYKjLfYj24ijrTElVI2bsls1KPVJIPUnVbLX61JIWq/ZHL/2+yZxS9KV30qPUZyKW1yHT9z7uFD7WzYHHcAK4R+/gdFzTBypgyj+RBWD0Jq4CnQiOPtOO/si1U0gz+IKUuo9hKpsceuE4d1ch3Cuwtp+sACgi/ltDM56VjXvUTUx/q6j6a1PKALnva0PlkmRsoeLOr/2781Gy5TADlGcn0+ktb0yyaeYCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLOHiIinSj8lX+0M5fbo/+L7apxYN1ikmzMKZkE8NVw=;
 b=DX1PzUFGNVwcdgr5DcG5AC5OIkzHs6kXJMVHcE9HKCLwkDhwpBPbsZO9mQeTlFWv2NlVS/7Pn12gli4sPbxsUimzXihPUxLWGsg357o8wYalb3Jr/UyiRaL66rwleA0tcWa8csP09hNwf13wYqISFgYzX2mmJWy3rqTQEZHav47VZifapCH//B8DqbHWhCwb/FS+ky2hZjIz50fk2VvqLSvOW+ACmKmDRxkROVxxwLzq5lSD2vHZommb1xCtEJ6EqnE0waq6qCI9RJjkUOtiNphYT9AUQMTJR6iNE3K2Q3acvGB/+omt2+7CMP92wl5Smkwt78YIW0oFr4Pu1DuW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLOHiIinSj8lX+0M5fbo/+L7apxYN1ikmzMKZkE8NVw=;
 b=SCYisUUY+sDCt8Nkr/Y8ZodB1VejHodM6UwIAPKw/TiQ/CBES9CLna44jNQTjQU10lSPYQtL7y+JKnAojJJB+3j3gysSdb/jC9rvDw1ktQWOybLNstMYU0FrBb9ure0nzp1QrmocmeNRVurGAiRafwwk/pT/0igetR3lF/75Ggi9+5GQE91/unXp9dDIn2OlHne98cKA6e/vebCCdJ2uOyQgEle5+hS5kaiavUbJbCmWKOoaZLTAjGehhhQt+hw+AIymW0ZZpSH6l9EK4o7dC5QIQvv7KrQuzFUbIN+J+HHUHDPnLl3OcebjSu+G7mBl7k+NKElOnu2JOs8bIQ6PFQ==
Received: from BN6PR17CA0012.namprd17.prod.outlook.com (2603:10b6:404:65::22)
 by BN8PR12MB3427.namprd12.prod.outlook.com (2603:10b6:408:62::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Wed, 28 Jul
 2021 01:46:08 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::db) by BN6PR17CA0012.outlook.office365.com
 (2603:10b6:404:65::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Wed, 28 Jul 2021 01:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Wed, 28 Jul 2021 01:46:07 +0000
Received: from [10.40.204.204] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 28 Jul
 2021 01:46:01 +0000
Subject: Re: [PATCH 2/2] PCI: designware-ep: Fix the access to DBI/iATU
 registers before enabling controller
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
References: <1627429537-4554-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1627429537-4554-3-git-send-email-hayashi.kunihiko@socionext.com>
From:   Om Prakash Singh <omp@nvidia.com>
Message-ID: <2cccd427-cd00-146a-7268-0014a9e3e099@nvidia.com>
Date:   Wed, 28 Jul 2021 07:15:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1627429537-4554-3-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddc0ac9c-b6c2-4721-e8ca-08d951697844
X-MS-TrafficTypeDiagnostic: BN8PR12MB3427:
X-Microsoft-Antispam-PRVS: <BN8PR12MB34276B615DCBD97F4BF58348DAEA9@BN8PR12MB3427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phzuKZQZodBEtqQ2NQV4lEwlvxjYQxO+RSQue1eyRsS1KK8Ssk6IREUTwiE0E4poibOpBVVphbNpsl7WsPHhDq2BAPxhVr4ngzsZPDGM+XMSnJH6jaS3TGNzlLFh6u9tD8rlNRk+Pk6rvjsJP9YL7ba2Jn5tL3SxbFE4EisZ6qPRXS63W/n/InQ21eARaIAN3OWCvhu7b4b3+3n2GbM0GaofDdel8wtiQ7dUspBgjdzhi3cVpZHZ/cfRUgn/No9fIsnhYuN9awqax1npwekZ2IJblgzN1RIEhe/hhhnbh6o6TzNR/M7eBaUojaG7jYLMCMgrlqsAiMNiH3gOvxRl2txWNP34S2D0CDR0FKHN0tFIlNoa3WSqLKq9CENpwmMkbuScPjyLADORWeMEqoiumvb+yolYGSmE4mqHw3heeVOY5WBG7MVdWS+onFLwn5H9WSxBUdkSpVwUyPRwEFisUYvRLrwAmcvtIuSm2znmRhemQMohvsR4z/som3mZfSUmRWpYLmua+Y/NGvDlT3YsiWCgYiLhHMCiGZT3OS1A8gkCV1IKc9xN8/aEudgTCHCbu2snp31nl17l6olULE3NkkNHgqA2c1d3t/f0R6Qkfkgzww9N/1V+pxNrXMGQT2MMyKN2UN0/LfC95gbSSWQmkIpbW9aJzF+udS4mNs77jZVJt0TADo5Sgvb2fVCUOgxz2GHBNbZwk7hVms3E6qBrtAJIamExGcC+a420iFyFRnY=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966006)(36840700001)(36906005)(70206006)(83380400001)(82310400003)(54906003)(36860700001)(336012)(70586007)(8676002)(426003)(110136005)(316002)(6666004)(16526019)(47076005)(186003)(26005)(86362001)(2906002)(356005)(478600001)(16576012)(31686004)(5660300002)(7416002)(31696002)(2616005)(53546011)(7636003)(4326008)(36756003)(8936002)(82740400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 01:46:07.9084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc0ac9c-b6c2-4721-e8ca-08d951697844
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3427
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Acked-by: Om Prakash Singh <omp@nvidia.com>


On 7/28/2021 5:15 AM, Kunihiko Hayashi wrote:
> External email: Use caution opening links or attachments
> 
> 
> The driver using core_init_notifier, e.g. pcie-tegra194.c, runs according
> to the following sequence:
> 
>      probe()
>          dw_pcie_ep_init()
> 
>      bind()
>          dw_pcie_ep_start()
>              enable_irq()
> 
>      (interrupt occurred)
>      handler()
>          [enable controller]
>          dw_pcie_ep_init_complete()
>          dw_pcie_ep_init_notify()
> 
> After receiving an interrupt from RC, the handler enables the controller
> and the controller registers can be accessed.
> So accessing the registers should do in dw_pcie_ep_init_complete().
> 
> Currently dw_pcie_ep_init() has functions dw_iatu_detect() and
> dw_pcie_ep_find_capability() that include accesses to DWC registers.
> As a result, accessing the registers before enabling the controller,
> the access will fail.
> 
> The function dw_pcie_ep_init() shouldn't have any access to DWC registers
> if the controller is enabled after calling bind(). This moves access codes
> to DBI/iATU registers and depending variables from dw_pcie_ep_init() to
> dw_pcie_ep_init_complete().
> 
> Cc: Xiaowei Bao <xiaowei.bao@nxp.com>
> Cc: Vidya Sagar <vidyas@nvidia.com>
> Fixes: 6bfc9c3a2c70 ("PCI: designware-ep: Move the function of getting MSI capability forward")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-ep.c | 81 +++++++++++++------------
>   1 file changed, 41 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 8d028a8..f0c93d7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -636,16 +636,56 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
>   int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>   {
>          struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +       struct dw_pcie_ep_func *ep_func;
> +       struct device *dev = pci->dev;
>          unsigned int offset;
>          unsigned int nbars;
>          u8 hdr_type;
> +       u8 func_no;
> +       void *addr;
>          u32 reg;
>          int i;
> 
> +       dw_pcie_iatu_detect(pci);
> +
> +       ep->ib_window_map = devm_kcalloc(dev,
> +                                        BITS_TO_LONGS(pci->num_ib_windows),
> +                                        sizeof(long),
> +                                        GFP_KERNEL);
> +       if (!ep->ib_window_map)
> +               return -ENOMEM;
> +
> +       ep->ob_window_map = devm_kcalloc(dev,
> +                                        BITS_TO_LONGS(pci->num_ob_windows),
> +                                        sizeof(long),
> +                                        GFP_KERNEL);
> +       if (!ep->ob_window_map)
> +               return -ENOMEM;
> +
> +       addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> +                           GFP_KERNEL);
> +       if (!addr)
> +               return -ENOMEM;
> +       ep->outbound_addr = addr;
> +
> +       for (func_no = 0; func_no < ep->epc->max_functions; func_no++) {
> +               ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> +               if (!ep_func)
> +                       return -ENOMEM;
> +
> +               ep_func->func_no = func_no;
> +               ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> +                                                             PCI_CAP_ID_MSI);
> +               ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> +                                                              PCI_CAP_ID_MSIX);
> +
> +               list_add_tail(&ep_func->list, &ep->func_list);
> +       }
> +
>          hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
>                     PCI_HEADER_TYPE_MASK;
>          if (hdr_type != PCI_HEADER_TYPE_NORMAL) {
> -               dev_err(pci->dev,
> +               dev_err(dev,
>                          "PCIe controller is not set to EP mode (hdr_type:0x%x)!\n",
>                          hdr_type);
>                  return -EIO;
> @@ -674,8 +714,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
>   int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>   {
>          int ret;
> -       void *addr;
> -       u8 func_no;
>          struct resource *res;
>          struct pci_epc *epc;
>          struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> @@ -683,7 +721,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>          struct platform_device *pdev = to_platform_device(dev);
>          struct device_node *np = dev->of_node;
>          const struct pci_epc_features *epc_features;
> -       struct dw_pcie_ep_func *ep_func;
> 
>          INIT_LIST_HEAD(&ep->func_list);
> 
> @@ -705,8 +742,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>                  }
>          }
> 
> -       dw_pcie_iatu_detect(pci);
> -
>          res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
>          if (!res)
>                  return -EINVAL;
> @@ -714,26 +749,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>          ep->phys_base = res->start;
>          ep->addr_size = resource_size(res);
> 
> -       ep->ib_window_map = devm_kcalloc(dev,
> -                                        BITS_TO_LONGS(pci->num_ib_windows),
> -                                        sizeof(long),
> -                                        GFP_KERNEL);
> -       if (!ep->ib_window_map)
> -               return -ENOMEM;
> -
> -       ep->ob_window_map = devm_kcalloc(dev,
> -                                        BITS_TO_LONGS(pci->num_ob_windows),
> -                                        sizeof(long),
> -                                        GFP_KERNEL);
> -       if (!ep->ob_window_map)
> -               return -ENOMEM;
> -
> -       addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> -                           GFP_KERNEL);
> -       if (!addr)
> -               return -ENOMEM;
> -       ep->outbound_addr = addr;
> -
>          if (pci->link_gen < 1)
>                  pci->link_gen = of_pci_get_max_link_speed(np);
> 
> @@ -750,20 +765,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>          if (ret < 0)
>                  epc->max_functions = 1;
> 
> -       for (func_no = 0; func_no < epc->max_functions; func_no++) {
> -               ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> -               if (!ep_func)
> -                       return -ENOMEM;
> -
> -               ep_func->func_no = func_no;
> -               ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> -                                                             PCI_CAP_ID_MSI);
> -               ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> -                                                              PCI_CAP_ID_MSIX);
> -
> -               list_add_tail(&ep_func->list, &ep->func_list);
> -       }
> -
>          if (ep->ops->ep_init)
>                  ep->ops->ep_init(ep);
> 
> --
> 2.7.4
> 
