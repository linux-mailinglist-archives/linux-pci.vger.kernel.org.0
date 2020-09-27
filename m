Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0884C27A019
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 11:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgI0JXx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 05:23:53 -0400
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com ([40.107.237.63]:54848
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbgI0JXx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 05:23:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoUnmtxXNnyfKdcNX503McxDFx/t/bSPk2+41drqbOXewWgDaEHR8ArHV2uzho2lXWUgXkKbqmQGgGi6+Mtb6Ezokrl77U+FK/9F2CUMpkxUyD24Iw3T6uBTXH0AkZzFdjd0aEUIg0qt3SCEE+O9wn6iPosTviP9cDG0LTgMG2EtOs1PGayMS2Qao0/4HrgFRm/SZpnRr78MBjTjTzHWnBpvAG9GH93qkfYAD5Dmqab4ebiZkLLbXK+KH6tppb5y/d1odZ3K8zzxsXnSwMKZN7FCBnblIY4eebkrzkf1Cy/1USfH9e3U1um2UDngnynN82ng8VqPU61uOzEerZljBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rkmt63cdtn/4G9hvdRDw7rsITQXjP2oleo1ad3Y7/wE=;
 b=KyFDy1JsgiNuMIgPHwpyiegeP2Av3lYLKlTH2RLHxsQ5acVzx223aqI29YD5fq3rE6YjaG8Vccdave3eOnprRKD1ICh6OPfE9nJfMutaPcG/QoI19YGDrWkSMExU/T6DTLLX/1g+epSS6knK4/N5CZZZUXLpY9R1FgC3rknxvFQh5ZovNRGiin9nMCIPwRgsHlrjkoTc9vPH8EFquU/otCFSQq81vE0FdW0hhkI+ZorqjI9TPcs1sw5om/VCRUTB+vKQthD8W0awYUVEtvwq+wmd0f/0wqDT9K60xa4uLuAHCZcRcnJh4aLZglXOS8B++FdpiskyGmphAMSv8aq0vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rkmt63cdtn/4G9hvdRDw7rsITQXjP2oleo1ad3Y7/wE=;
 b=b+H7FbxJi+s4J0/sq+zEZJ++Y6RHn9sjAN3zPT5lMC3UmRBqVx069P82q1Nz8Nn0zloONJ2/ITz7qiwGv09EqIk0VltiDelUPhjcpIpqIHsxKcCYrU7b9u9+0ZliMBV9jZWqWpTAiXoW0PPmXa9W2+JT2o8a3Q6GIqU5IRu7EoU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB3593.namprd03.prod.outlook.com (2603:10b6:5:aa::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Sun, 27 Sep
 2020 09:23:43 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3412.028; Sun, 27 Sep 2020
 09:23:43 +0000
Date:   Sun, 27 Sep 2020 17:23:23 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [PATCH v3 2/2] PCI: dwc: Use an address in the driver data for
 MSI address
Message-ID: <20200927172238.548912fe@xhacker.debian>
In-Reply-To: <CAL_JsqK6QURYdt-0mbuv6oeoqFr0acVh6Q7F2-FSXN-zOk34XA@mail.gmail.com>
References: <20200925163435.680b8e08@xhacker.debian>
        <20200925163852.051e3da2@xhacker.debian>
        <CAL_JsqK6QURYdt-0mbuv6oeoqFr0acVh6Q7F2-FSXN-zOk34XA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0198.jpnprd01.prod.outlook.com (2603:1096:403::28)
 To DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY1PR01CA0198.jpnprd01.prod.outlook.com (2603:1096:403::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Sun, 27 Sep 2020 09:23:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a07659f3-df3a-4e71-36a0-08d862c706cf
X-MS-TrafficTypeDiagnostic: DM6PR03MB3593:
X-Microsoft-Antispam-PRVS: <DM6PR03MB3593BB74A5608D1ED65155DAED340@DM6PR03MB3593.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z76EPF2DFLo3Sbw8KW3NxDzRMNCNeKOsPgS51S0ZmiKKxISRpWLZFZt866KTw8A3sYnzWZwOwIskQHsHNSG+H52d7Y9y6MvcNp2zt2wVIw+LlEha6aOgIouWBfjoSoD3h+xOQ8EDOeafjrStoaDinsBrqcw88KYihGbqCGX6ERNVmpYZzXOyGBZ8CNZClI5OXv5J8q9oGugOxtcXOZ+X2PIwPUCqdB5AKU09Put/oUpmu+3n3Kg9PMK9YwDGl0K6LSSAUrk56MVqykY/iqz0EIswUw3Ct1Ejj/6VzyT1EwzTW+R6lE2ce17ojWJFJinXU+5rdUczG9DcNIYgO0bQ0pnGTCrUcVPnzWSLQ5NNWSgqkudMdYTtxGLeR5O8243E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39850400004)(366004)(376002)(346002)(136003)(5660300002)(66476007)(316002)(6666004)(2906002)(54906003)(83380400001)(86362001)(4326008)(55016002)(478600001)(9686003)(6506007)(53546011)(66556008)(66946007)(1076003)(26005)(52116002)(7696005)(8936002)(8676002)(6916009)(956004)(186003)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eDFMyiRBtv8EtZNFxz4lxKYBiljcOY3dqOOhl85Mfl0h0loVEBwNxOFQ+tW6U75KETuUvnG7eJ5WN86RbiOYjlaDftfy1gbWLhcW2yCRmsmF+R0JG1rzdGH5TgtEnyrf6RqqSyzig5tKPN+AKcewGnCRQp058B2AzvGojboK6KId/IBAFzelyOzfeLCoQfNrmW3bJ+yAvj5433/o6KNvdMAbd9FcrfHxyijBlsH5xsTmgUVyBTFbKOQhp50XkwzLVbCmJOMbCxOWsFITBJDUsU5PedIitOgcOTg4cQrf7cA881XsllLWYlJNj4Gue18HBwM8pYa0X9p46p9wJg1nWqP7gvaae64N9iHC93YKQRHVUtlmEpA99hqBWBDOaFZnSM5H3WavMJW53nbCB0HUp/kIg7AGMOvPOMgey/RQS2tiHE3x4z/v3/EVNDj4Ymjxnj9qwbUvGkMSqMF57wpQE7AOaIV1PPibttn0qZn3N0LRxMxXD5yNkGGPJNoaRUlGj1fLwovR1pvgbS8eReuDhRN9IBRAtaUqDy98LqVKgGy7pjMX+cgCTVC76VCQHEob8A9aIkmmrGaw1+52c+/CHxvlEi9Z9yM6jk8uOFHR7VEXu+9b1lru7cNouVDIP5AiF4wLhfaJ3KvzvZy117E5YQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07659f3-df3a-4e71-36a0-08d862c706cf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2020 09:23:43.1039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0TTyeG8uZC9Lj1XRmE3ys+aQ0qTZ6RHljUhZIctSYGG+OVeR4aTgbY3CuNxxBepRDryHlxWR5nxeAwZFNKWZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3593
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 25 Sep 2020 09:33:54 -0600 Rob Herring wrote:


> 
> +Niklas
> 
> On Fri, Sep 25, 2020 at 2:39 AM Jisheng Zhang
> <Jisheng.Zhang@synaptics.com> wrote:
> >
> > There's no need to allocate a page for the MSI address, we could use
> > an address in the driver data.
> >
> > One side effect of this patch is fixing the MSI page leakage during
> > suspend/resume. Take the pcie-tegra194.c for example, it calls
> > dw_pcie_msi_init() in resume path, thus the previous MSI page is
> > leaked.
> >
> > Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-host.c | 22 ++-----------------
> >  drivers/pci/controller/dwc/pcie-designware.h  |  1 -
> >  2 files changed, 2 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index f08f4d97f321..bf25d783b5c5 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -126,9 +126,7 @@ static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
> >  {
> >         struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> >         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > -       u64 msi_target;
> > -
> > -       msi_target = (u64)pp->msi_data;
> > +       u64 msi_target = virt_to_phys(&pp->msi_data);
> >
> >         msg->address_lo = lower_32_bits(msi_target);
> >         msg->address_hi = upper_32_bits(msi_target);
> > @@ -287,27 +285,11 @@ void dw_pcie_free_msi(struct pcie_port *pp)
> >
> >         irq_domain_remove(pp->msi_domain);
> >         irq_domain_remove(pp->irq_domain);
> > -
> > -       if (pp->msi_page)
> > -               __free_page(pp->msi_page);
> >  }
> >
> >  void dw_pcie_msi_init(struct pcie_port *pp)
> >  {
> > -       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > -       struct device *dev = pci->dev;
> > -       u64 msi_target;
> > -
> > -       pp->msi_page = alloc_page(GFP_KERNEL);
> > -       pp->msi_data = dma_map_page(dev, pp->msi_page, 0, PAGE_SIZE,
> > -                                   DMA_FROM_DEVICE);

I checked commit 111111a72e677ff13 ("PCI: dwc: Use the DMA-API to get the MSI
address") again, I think we need dma_map_single() here, either due to 

The phy address is different with dma address on some systems

or

All memory isn't accessible from PCIe RC on some systems

dma_map_single() could work on all systems. But this leaves a problem: how
to avoid the map again during resume? A simple solution would be:

move the dma_map_single out of dw_pcie_msi_init() as V1 does, sure,
pci-dra7xx.c needs to call dma_map_single() itself.

Is this acceptable?

Thanks

> > -       if (dma_mapping_error(dev, pp->msi_data)) {
> > -               dev_err(dev, "Failed to map MSI data\n");
> > -               __free_page(pp->msi_page);
> > -               pp->msi_page = NULL;
> > -               return;
> > -       }
> > -       msi_target = (u64)pp->msi_data;
> > +       u64 msi_target = virt_to_phys(&pp->msi_data);
> >
> >         /* Program the msi_data */
> >         dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
