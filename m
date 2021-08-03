Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276323DF21F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 18:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhHCQId (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 12:08:33 -0400
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:36723
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231871AbhHCQIc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 12:08:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSOKo08xfMcQEppHiaAK/36FsK1jYRv8SeWEuO4ZYlz4JpiLzQmWAoxssfPGq0WncusqSSFKGLxsIxq5y+dAwe9qcvk3ysbtB3fAEe6Uhu2noOWufIL1+Nlq65JlHt750yauBNTqz3fdQiPWxSeU469orzRjDtJgELkLNqcddLTmvloL+tgSTczNYa1ZQz0zIkYPHhXFO0ya03IdlPdCsp5Bc0kM7gzI0RbBvdjErzzLFqnd75GvDYcuZSM1kNla4yL26l0ooaE9y9Er8m731EPgN9Rm4Mpk+cJuHi/Q9bdK5/s7x2OBCvbozeluWnCqK3MTMUqPNQuGomZykH/hEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJSSGXfjp4dqZZe+cEwG9spB/YGpX6UQg7IHAVa4ozE=;
 b=DajbNwFHFSPnHSsszEr/vF3rTJQCZj0OAyjPPsmx6BzcDlU9ytmFQabQJCIdUrn20eCw+bbQijWhlJb5JQl9+zL8GnYoyvFF5AesFDnFxy8iyrG+sPAOFKwh8KEB9lKmy1UpLsgaKPoks2d8FvBBmcLiikqmu3nyg/ue+6JeC5u9StwKfZXB1mS6pde7V7mZf3yrzMz6nqqFzECjblaCBGNWcd4n3FLds1hYMQTDVX67z4bzUhXm2PDJ6g9zRnYogABDxgZPjzT6D9E2mbFRYCynAyZMN9lT8l8nUBhdS4X8ku+He9UF/Id3c3AsroaAJJGfsJ6Pc+gKg8BM3ctUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJSSGXfjp4dqZZe+cEwG9spB/YGpX6UQg7IHAVa4ozE=;
 b=QZNYEM3QFX3ciMS4AVRgAe4xcdB0np6w2k42sV6vgA2ZnAatu3uKI2sIzehneLGLfUnReDfAC2DmR/psXy4QUNgj70MUwIAEicPiBtsrfnpZvlmTHat1KrsLtJztG03j2fDpylsOzaUJ7uhuTS3a6mEllPaJrscPHm24WAy4ht4+kAGFAmRhi1mCwhld1D7Ro0s+PcoT904PHU96Iui/imsE97SDu28+ibfDzXRDAEEmH8b4tzG4GHSkPINyOPXFZFm9PJhDRkhXv003D4I9WsA+G/yTY3YQjOW3SS341qgDTqqsCw0rFgm29pgCCai6DzTUhxGj8e1GtX0No/d8Sw==
Received: from BN9PR03CA0278.namprd03.prod.outlook.com (2603:10b6:408:f5::13)
 by MW2PR12MB2539.namprd12.prod.outlook.com (2603:10b6:907:9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Tue, 3 Aug
 2021 16:08:18 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::3a) by BN9PR03CA0278.outlook.office365.com
 (2603:10b6:408:f5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25 via Frontend
 Transport; Tue, 3 Aug 2021 16:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 16:08:18 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug
 2021 16:08:15 +0000
Received: from [10.25.100.144] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug 2021
 16:08:12 +0000
Subject: Re: [PATCH 2/2] PCI: designware-ep: Fix the access to DBI/iATU
 registers before enabling controller
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
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
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <bc5b914e-16cb-a019-1b0e-6619a97cf00a@nvidia.com>
Date:   Tue, 3 Aug 2021 21:38:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1627429537-4554-3-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56530d4a-f516-4287-f6cc-08d95698e87d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2539:
X-Microsoft-Antispam-PRVS: <MW2PR12MB25391A83F90432E8D2CDFBC1B8F09@MW2PR12MB2539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4apjgr3dDse4cOxbGhnxdGRkOA2QMuxqpYDXO/bPtUIflaar/wHwpz0ctE5gRtfX8G+RpYePov2RuWDRPVDJKPXgbhT3G1Rhy/GMtmrOMLMTJxGFU2inF8YOXdWoXqcX/EB9peDNXhHZ0B7ujwNisTR5na0DK/NJcT6kJc5nDnl8iYGCCtlmTet2hAaBFYVXAoLnbG3rHNfaAq+uTc1HXlDd8SKZa07oN57B5LB61DCpZ2GDQVDAvTcM10nwVAwwdMgIApbXxUPTctbxrcDAalCiwS9XYdvlRjhNygPt2CsexP0VmqgE1qzPOo4c4MMBKiPCfyEx8B0wpSDaNnZ8fIv5YYLCbdeDSiSdLevQRmqvCd3tcApatdUi55gm2yNQWhnWIJ8itAuuUg9PvNdemtLbgbqGmQVj5G3usKSLA9raDGuevXu5Usn+J9sZ3Tc8wBQsQ4cyYQQbybRM7DlCqcfY46sGWK5zhIguusTN8h9XuiBLttAyni6uXgm6w2gexcpos0U0zmVjqG71x+MKF26QsEPFQgJLIudegSyjNWKCqF0e76Jkuw2/kuVCXAql42Um/uH42boxfq2ikXDRkckyFz7lU+KkJ7rNFK9z8gx772x7W22Am/KbQE7rzqrxOqpOglTsMx10rX8eMWGaHn6+wjJpSnaQeredMAs7ZHxonzBMGGPTh23zkLBF/D1CrcMSX8bjkj9gu2avK4pJZz6cH4bkyA8VBemzAZVS7SM=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(36840700001)(46966006)(16526019)(54906003)(6666004)(336012)(186003)(110136005)(26005)(70206006)(316002)(8676002)(16576012)(36906005)(2906002)(36756003)(478600001)(70586007)(53546011)(82310400003)(7416002)(47076005)(356005)(31686004)(82740400003)(86362001)(31696002)(36860700001)(2616005)(426003)(8936002)(7636003)(5660300002)(83380400001)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 16:08:18.3423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56530d4a-f516-4287-f6cc-08d95698e87d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2539
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reviewed-by: Vidya Sagar <vidyas@nvidia.com>

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
