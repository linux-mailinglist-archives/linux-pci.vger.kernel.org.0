Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F753AA31D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 20:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhFPSZK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 14:25:10 -0400
Received: from mail-mw2nam12on2043.outbound.protection.outlook.com ([40.107.244.43]:19040
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231613AbhFPSZJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 14:25:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEoXmaN6j0URYx6cJCAHDF6jvqIwB25iKC5cAl5bPixEZOHNxRxQIPa5eattrYdMcU5KZOPDMOD6lk9fjmKJ+H1pIt1IjE53YlOH8kDn5CsR+Mj47+B8KOvY/2PXNfQzqjTfG/d5xG4z1kRv/IJ0vMSOYLr7TTeVK+RJMMTogtB+dpX75HwaRpk4yRxpa61o9jTcMW4aUo+SaAf4l3/V/6PGHnuP8kum+XgxnR1ygph1GgExTFdpH1/8/G82RPnECOFb32SZHlMnoxG8OI65tnM5lPxn0UzwdugvSf/ewtFeJuQdZq9ZFS3wlNzdWHQOgkts0oyEFQPLCC/vgKDaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPmcxdY0UU7/u+yMtAPMs6NFk2YYciIJJXNun6jXegM=;
 b=YR2W1efea/bZtdu0H9cb9A47Edd/1AUTQZJy4syVoKSjaeXZj/LtAdJgwZActstHvgQ5E1uC0LgFABitCQhRppLwhlERAJFRVufyjfC2cSOzbojzZb92KI1JN+YNexfFr97hzuWC/8poySfxBMVC5Mvz/DpGi14rsbKYgQWnG1gRiva8jummiCzdN3P+2ZMebbRiVBHAqj6j464Vb0I5hsNTeeNad/vPtfxPtFx5PimfDaYpNIPnUcEzV6iPbEkTyCDXckk3oivZY6BnSCc21+UH0vEDOjdE/Gnlo4gwxklN0McM1FCS6Q9sLVOe0gMXVGEZIktZouCLma8rBk49tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPmcxdY0UU7/u+yMtAPMs6NFk2YYciIJJXNun6jXegM=;
 b=OkvpCWaAGH7+A0uGkshIGoG7Xe167qm1eEsxb3CH501U2fwoap++cTQY9DkNXcZkSzcfXZu65COG4UP20rHsA3Pd1gUY12b1h7OPSCeeDWHr44GpMH0IHv4av4EBIu+KjrtgYPejnfd/gQdq5bbsKpmZQYAkpdN+xRSPQVMJqXZCv1L+D357IZFFPJGebXrYNfkJFyY068vRQdQCKVaIzhg/8fybJ3AhuQl57bj19VpMz/9YTNuMbBCugj0yjc5NVgtHJBbyCF8pPXAZjC3evyG+WmkSLLSi/9i6rVjS/FvFAgFhsmBsF06eEBH2NaQotQ4iGUp8kESW3bAQERPH1w==
Received: from BN6PR19CA0056.namprd19.prod.outlook.com (2603:10b6:404:e3::18)
 by DM5PR12MB2488.namprd12.prod.outlook.com (2603:10b6:4:b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Wed, 16 Jun
 2021 18:23:01 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::8a) by BN6PR19CA0056.outlook.office365.com
 (2603:10b6:404:e3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Wed, 16 Jun 2021 18:23:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 18:23:01 +0000
Received: from [10.40.203.90] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Jun
 2021 18:22:57 +0000
Subject: Re: [PATCH 1/5] PCI: endpoint: Add linkdown notifier support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <kishon@ti.com>, <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <hemantk@codeaurora.org>,
        <smohanad@codeaurora.org>
References: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
 <20210616115913.138778-2-manivannan.sadhasivam@linaro.org>
From:   Om Prakash Singh <omp@nvidia.com>
Message-ID: <443ec752-08e2-83dd-2b6f-b5e74c7bd8e5@nvidia.com>
Date:   Wed, 16 Jun 2021 23:52:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616115913.138778-2-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f37ccc4e-0340-45a2-a796-08d930f3c67d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2488:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24886E41A0501A1EC24A2167DA0F9@DM5PR12MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7/1whZiVcgPuYs2TKgsH7HNVwNeUl4zG7lYhd+XYlaAxvQlRE5IBTeA8Cqojmt9OpCcWOiQVthBm8B+0jARDm8ViVwxYFM5PZJenguM8cExXEMglbYjatazCQuUkAlXht+fqoZk5GAXh2R33aU5helfZLUmOP4YkJit9HJ6ZpqNmuwaCf4vLkH9c0+bBq6iXfbm6vsYgRPxYNORio6MCFeu6Pn8x8BnE7QjaipTLruVWXGmEYpsnPwA6qXd57nDEPhCzea+MzqMPw86CxVvjaVoGYgJh45C6SFyU7utW8vuEmcj5gSeeyEUB+Sk5iUcp8IQtxT479M2oV9bN5SoOKuEPiqeFUYo8c0rJ0TF0C4UIfwb269bFYBOmnXNtlm0xux4FAJdvdwATebgOpFanXAGONvW2L96J6eGvtkDmVp5lhzrQHYqAq4yWT2RvbYafk0Aw/qZnM7HB3iMcm+3Q7vQJD+MAN/2CyzZPm/tsdRzcIqbe/qIJEnPgpw1V9woxZavbDiUc95yAmkKjwtmVVSI3RwqOt4hMQfHqg9685d+INROswBJg7QQ3dmwQozhUuwP5P/6VVCuac2+rHL6rlFQz45SDNZF2yNJTGGOqhvIKKix7oy1MzV+e5m4te8VsZ5r8YLRtqfKm8v1zXgbBC/szbIRqbAC3nTLGcYxsKr+QNRq6DznHEgrOC+4w16f2
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966006)(36840700001)(316002)(8676002)(53546011)(86362001)(4326008)(31696002)(36906005)(82310400003)(16576012)(36756003)(5660300002)(110136005)(54906003)(6666004)(8936002)(83380400001)(82740400003)(70206006)(356005)(336012)(26005)(36860700001)(478600001)(186003)(426003)(2906002)(7636003)(2616005)(16526019)(31686004)(47076005)(70586007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 18:23:01.2946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f37ccc4e-0340-45a2-a796-08d930f3c67d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2488
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/16/2021 5:29 PM, Manivannan Sadhasivam wrote:
> External email: Use caution opening links or attachments
> 
> 
> Add support to notify the EPF device about the linkdown event from the
> EPC device.
> 
> Usage:
> ======
> 
> EPC
> ---
> 
> ```
> static irqreturn_t pcie_ep_irq(int irq, void *data)
> {
> ...
>          case PCIE_EP_INT_LINK_DOWN:
>                  pci_epc_linkdown(epc);
>                  break;
Can you provide use case/scenario when epc will get LINK_DOWN interrupt?

> ...
> }
> ```
> 
> EPF
> ---
> 
> ```
> static int pci_epf_notifier(struct notifier_block *nb, unsigned long val,
>                              void *data)
> {
> ...
>          case LINK_DOWN:
>                  /* Handle link down event */
>                  break;
> ...
> }
> ```
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/endpoint/pci-epc-core.c | 17 +++++++++++++++++
>   include/linux/pci-epc.h             |  1 +
>   include/linux/pci-epf.h             |  1 +
>   3 files changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index adec9bee72cf..f29d78c18438 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -641,6 +641,23 @@ void pci_epc_linkup(struct pci_epc *epc)
>   }
>   EXPORT_SYMBOL_GPL(pci_epc_linkup);
> 
> +/**
> + * pci_epc_linkdown() - Notify the EPF device that EPC device has dropped the
> + *                     connection with the Root Complex.
> + * @epc: the EPC device which has dropped the link with the host
> + *
> + * Invoke to Notify the EPF device that the EPC device has dropped the
> + * connection with the Root Complex.
> + */
> +void pci_epc_linkdown(struct pci_epc *epc)
> +{
> +       if (!epc || IS_ERR(epc))
> +               return;
> +
> +       atomic_notifier_call_chain(&epc->notifier, LINK_DOWN, NULL);
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_linkdown);
> +
>   /**
>    * pci_epc_init_notify() - Notify the EPF device that EPC device's core
>    *                        initialization is completed.
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index b82c9b100e97..23590efc13e7 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -202,6 +202,7 @@ void pci_epc_destroy(struct pci_epc *epc);
>   int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
>                      enum pci_epc_interface_type type);
>   void pci_epc_linkup(struct pci_epc *epc);
> +void pci_epc_linkdown(struct pci_epc *epc);
>   void pci_epc_init_notify(struct pci_epc *epc);
>   void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
>                          enum pci_epc_interface_type type);
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 6833e2160ef1..e9ad634b1575 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -20,6 +20,7 @@ enum pci_epc_interface_type;
>   enum pci_notify_event {
>          CORE_INIT,
>          LINK_UP,
> +       LINK_DOWN,
>   };
> 
>   enum pci_barno {
> --
> 2.25.1
> 
