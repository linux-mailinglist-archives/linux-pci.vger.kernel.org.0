Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C973B276A01
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 09:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgIXHFD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 03:05:03 -0400
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:27361
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727001AbgIXHFC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 03:05:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcP3lVK+QwfdYTG6mnlOy5xeDb9JCE+vlstE+oXiBSwIo7ZprauhgDEZxxNsiCX17QiIOWoxrnRNAFVVqxof3r8NLjGHV89PMgi/SWmI4xB3DwfITFnRlKVkUWN0OkL/0YOEcsPhLZKQhUvPRizCLqeFFisfjCEO6GZ/i5fB2QW7Bon8C7KD8D0fARN6Tdu8Xuo2+e7TIYwkLpTa7etf6hmmGr3tVeEeVh/UXiGnCW5VChhh/gN7YEiQSY3yppNIhKnC0l1BLD6g7SNVZQnWpCvJsuTFNMyKF9KC6rCO5QOM6Khv4oOKKPLdlJxDa4uhFnZgGtxl8J3MHJaHQpK+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gHj7hzGavsWn/TRIzP7fYJB0k+J916yLzZrH+kcLDI=;
 b=X+/goKejXdR6W9A4Sy5VRh8DcFjkr8sLS1zZGpgV0BhykOu1Wt48ZQBLfcsqYw5+VjrHViDKmjEGyKAdKmhGZDgnoiSNvQHju+2P35p55Vuw0VBCoQnZ/C0J6RM1HRG2VLOGBAHe88GclqZUoE4yhVpnHZmPsiwWCQVK/W1khwvYuKhqarMoMGnKRwyICLKfpxaD4xgPG3m0r1ruJIAbIFdnLPcKblHRZz4IXyTamoxNKl/y0q9+JANHnyjnHW+z4uxZpo52c7dSX6mZBbvhwFVGzb2be7xt8Dh98taZqhpVEPs6aBrfrKHZIWqmSG/h2zwvWdWaNrRI8V7XZegSlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gHj7hzGavsWn/TRIzP7fYJB0k+J916yLzZrH+kcLDI=;
 b=ekFStvsICmnRxsZh20RWD1TfE5vaDIOOohVWqvMoFuP4DRjkdKqFWq5NPIEIfy6pUAUqk6ZnG4EbcxX9UoJYvtTr5cbnTL0/4ZH2qu3H75XrCV5qZKWxm7KDLlgONidydaUEQ+0vK+dzJtJ1IJ05m7kUngq/JmHVjPgA1TiS5eQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB4156.namprd03.prod.outlook.com (2603:10b6:5:a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.19; Thu, 24 Sep 2020 07:04:58 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 07:04:58 +0000
Date:   Thu, 24 Sep 2020 15:02:16 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: dwc: Move allocate and map page for msi out of
 dw_pcie_msi_init()
Message-ID: <20200924150216.47f04296@xhacker.debian>
In-Reply-To: <CAL_JsqJV_8sCVB2fAi6kk19ZLbO+nKbk-kYsBNEbN+jR84LUgg@mail.gmail.com>
References: <20200923142607.10c89bd2@xhacker.debian>
        <CAL_JsqJV_8sCVB2fAi6kk19ZLbO+nKbk-kYsBNEbN+jR84LUgg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:404:42::28) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR06CA0016.apcprd06.prod.outlook.com (2603:1096:404:42::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19 via Frontend Transport; Thu, 24 Sep 2020 07:04:54 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0578d452-315b-4c53-3ab8-08d8605825c9
X-MS-TrafficTypeDiagnostic: DM6PR03MB4156:
X-Microsoft-Antispam-PRVS: <DM6PR03MB415697426E3A7FDC3A2DA756ED390@DM6PR03MB4156.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: upL3IbNE1d8aZnE0lyYPrxVQkrcIR9hYPF4YEVlLzl8U6F38mnrRd7m7e6FKoJjT6MkzPTKu7GmSTb+zEIDV8sQGh4aXhMP64NYp5ObE18s2t/yGoU6SkwoAtiCxiXVv5Xgvdgal91u87rDQDtMipZp3t9XmonB1lh1wIqMo7hRpePYlfHBCekyiG2NBpIHhZ8VN81UAkhivu1qPYGGpX6KMQlnWwTC64cej5Ji1Ws2ywwDHELqTTWNyPGDL9aouRhsGsAFCnjLI9EhyUIbeNgBrw1y+I3JKnML4RrB6Bi6Pc6gfGSQM20Y48LvGEbqsZYtIPp+P6LyMiAHGQ7a4yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(366004)(376002)(136003)(2906002)(1076003)(9686003)(5660300002)(55016002)(316002)(4326008)(6916009)(83380400001)(53546011)(52116002)(66946007)(66476007)(8676002)(186003)(54906003)(66556008)(6506007)(16526019)(956004)(86362001)(7416002)(478600001)(8936002)(6666004)(26005)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NOqo//Zaa4kNdqSd8TNAf5UhwoOQQusns0KJetcz11+zVLK8Mol2t+2Wp+aopjPP8JvCWjMLX6toUnVWWDuYESluzWfXtpR1+243bQ5Hrw39p+nDYIKcb/mpzcsMliuoX6jipiaWiFvGSO0Cqro7BN5UnXgKpSNSIVErpnHUo3DWpulmd6HNeLsnyNW2L2argMqWiadtFxqnFJUxHNUyZQTDUZZl3n6XNPhIr3DMBYXm5baUuNK7IXITu4Z0NI3ZJGkU8SjOuf6tUZbKfccZEedI3ta3bwkKNPtKO+griMQfZ1P73ru/INbRLsvYHC/E7rUEEO4swak34jCqlvHeg5fZUvuu6ucrP0+QkTzhKMxb+UFxQ599l2fCzaHwyKXaf9ulFjGPGcfk/q41ljOhEkRhzcQlJ92p48wVrQrlumUwbnullLXLabYE01TE53t0Zoj+kFRPRKsd5E7t2iTEyGyFe2p+aPIWEhR0loyNHG6nAfcmaR8EH7SmItso/aP4F+BeW5nBoSdaiMWiqIOVpYfNrGnDtEfLlY1+7ADmaeHN626fF9rJ1gyO+eIBboOTJjRtuDFskoUZqqTVWdat7twpliumZ0P+4qGylSnXNJcWCEeIUryW1EPvg631YPX4MSbMDJf7OKE/1VeBW/mckg==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0578d452-315b-4c53-3ab8-08d8605825c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 07:04:58.3186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUV3esoGiOwWsR3iXxu+9lMpXzIJwL2R5GL2gMDTc6XdFCCJ06YJKe7BFMAlsFZiDDoD/UZHCWm3nrMEZzyFmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4156
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On Wed, 23 Sep 2020 10:41:45 -0600 Rob Herring wrote:

> 
> On Wed, Sep 23, 2020 at 12:27 AM Jisheng Zhang
> <Jisheng.Zhang@synaptics.com> wrote:
> >
> > Currently, dw_pcie_msi_init() allocates and maps page for msi, then
> > program the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI. The Root Complex
> > may lose power during suspend-to-RAM, so when we resume, we want to
> > redo the latter but not the former. If designware based driver (for
> > example, pcie-tegra194.c) calls dw_pcie_msi_init() in resume path, the
> > previous msi page will be leaked.  
> 
> It's worse than this. I think there's also error paths too leaking the

I think you mean the leaking in pcie-tegra194.c's error path. Synaptics
SoC pcie driver(not mainlined) needs to call dw_pcie_msi_init() in resume
path, pcie-tegra194.c shares the same problem, so I mentioned it in the commit
msg, but the patch isn't targeting to fix all the leaking issues in
pcie-tegra194.c. This patch at least fix one of the issue. 

> page. Also, there's never a dma_unmap_page call which should happen
> before freeing.

Thanks for pointing it out. I will add it in v2

> 
> > Move the allocate and map msi page from dw_pcie_msi_init() to
> > dw_pcie_host_init() to fix this problem.
> >
> > Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/pci/controller/dwc/pci-dra7xx.c       | 18 ++++++++++++-
> >  .../pci/controller/dwc/pcie-designware-host.c | 27 +++++++++----------
> >  2 files changed, 30 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> > index dc387724cf08..4301cf844a4c 100644
> > --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> > +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> > @@ -490,7 +490,9 @@ static struct irq_chip dra7xx_pci_msi_bottom_irq_chip = {
> >  static int dra7xx_pcie_msi_host_init(struct pcie_port *pp)
> >  {
> >         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +       struct device *dev = pci->dev;
> >         u32 ctrl, num_ctrls;
> > +       int ret;
> >
> >         pp->msi_irq_chip = &dra7xx_pci_msi_bottom_irq_chip;
> >
> > @@ -506,7 +508,21 @@ static int dra7xx_pcie_msi_host_init(struct pcie_port *pp)
> >                                     ~0);
> >         }
> >
> > -       return dw_pcie_allocate_domains(pp);
> > +       ret = dw_pcie_allocate_domains(pp);
> > +       if (ret)
> > +               return ret;
> > +
> > +       pp->msi_page = alloc_page(GFP_KERNEL);
> > +       pp->msi_data = dma_map_page(dev, pp->msi_page, 0, PAGE_SIZE,
> > +                                   DMA_FROM_DEVICE);
> > +       ret = dma_mapping_error(dev, pp->msi_data);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to map MSI data\n");
> > +               __free_page(pp->msi_page);
> > +               pp->msi_page = NULL;
> > +               dw_pcie_free_msi(pp);
> > +       }  
> 
> I don't like having 2 copies of the same thing. Also, doesn't keystone
> need this too?

what about introduce dw_pcie_msi_alloc() to do this?

IIUC, keystone doesn't need this.

> 
> The other thing is .msi_host_init() is abused by having an empty
> function to disable MSI support. We should have a flag instead to
> enable/disable MSI support and then we can key off of that in the
> common code.

FWICT, the .msi_host_init() is to init soc's own msi support rather
than init the DWC's integrated MSI module. So the usage is correct.

> 
> > +       return ret;
> >  }
> >
> >  static const struct dw_pcie_host_ops dra7xx_pcie_host_ops = {
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 9dafecba347f..c23ba64f64fe 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -294,20 +294,7 @@ void dw_pcie_free_msi(struct pcie_port *pp)
> >
> >  void dw_pcie_msi_init(struct pcie_port *pp)  
> 
> Might be good to rename this function with exactly what it does.
> There's too many 'init' and 'setup' functions...

If we move the msi page allocation out of dw_pcie_msi_init(), then
it only initializes the integrated MSI.

Thanks

> 
> >  {
> > -       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > -       struct device *dev = pci->dev;
> > -       u64 msi_target;
> > -
> > -       pp->msi_page = alloc_page(GFP_KERNEL);
> > -       pp->msi_data = dma_map_page(dev, pp->msi_page, 0, PAGE_SIZE,
> > -                                   DMA_FROM_DEVICE);
> > -       if (dma_mapping_error(dev, pp->msi_data)) {
> > -               dev_err(dev, "Failed to map MSI data\n");
> > -               __free_page(pp->msi_page);
> > -               pp->msi_page = NULL;
> > -               return;
> > -       }
> > -       msi_target = (u64)pp->msi_data;
> > +       u64 msi_target = (u64)pp->msi_data;
> >
> >         /* Program the msi_data */
> >         dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
> > @@ -440,6 +427,18 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >                                 irq_set_chained_handler_and_data(pp->msi_irq,
> >                                                             dw_chained_msi_isr,
> >                                                             pp);
> > +
> > +                       pp->msi_page = alloc_page(GFP_KERNEL);
> > +                       pp->msi_data = dma_map_page(pci->dev, pp->msi_page,
> > +                                                   0, PAGE_SIZE,
> > +                                                   DMA_FROM_DEVICE);
> > +                       ret = dma_mapping_error(pci->dev, pp->msi_data);
> > +                       if (ret) {
> > +                               dev_err(pci->dev, "Failed to map MSI data\n");
> > +                               __free_page(pp->msi_page);
> > +                               pp->msi_page = NULL;
> > +                               goto err_free_msi;
> > +                       }
> >                 } else {
> >                         ret = pp->ops->msi_host_init(pp);
> >                         if (ret < 0)
> > --
> > 2.28.0
> >  

