Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76B53455DC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 04:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhCWDBe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 23:01:34 -0400
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:14561
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229574AbhCWDBd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 23:01:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyemWk/f2UAO9DirQ+H77MPn9oLyia6W182NZ3bZVmQ+gNmk0irBNPXHlFiUwFF7IHJS13bDw0NdIQwNK7IA2gfeJWSvLvF4w/V7s69KEzcddRjmDZGVALjyw/YNqMUGoYm5fNErUMWMxzCnykmOSuB5qVDRf+gQFxL/KBu0+KDMcUJeSGUI+mpyIhRM2KN3qEprCLUGXIkbdOkQAfCwJ3O2V2O4WdPrs6iPdXYZwzeWFtl1ghCermzMNKNFZ9J854ebn7fD0JgPCnmnn0651h1gyIg4X46NDNK9icIn39BQTf3nri4YXcocMCBUj1ouTWb2Z1wIFDGENilKiDOcNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZC+DsSq8uiOXzlLcsFdrz+zpECXrJsuTC5MQ3fDK3I=;
 b=DujOoVWutjhTryfLWopeOJAyvlPvDWGfrpw0MWigUG1/4tnvkRcYPLzVQb8rryqR8DF3uYPa1khAYFPZ44PePaoN2eL0H/5P1SWaAFH+t11nT9MqQRYvM0hixk7TnOhnYrgnWwlR8AP6/+KXxG4CII9jI/n74GXyVkdWfVPC1KW+Not3TT5TJ3b4nnrAbHUsTOLvbmg82LR6vy7d8QZGhOcu8M5OgncbhCqaeTlwBQjjhX9BXs8K7EPbOAn8v7dsMnFXuGBwJBhivuc/X6YZgOHOz5+qYuWtgK9sj0Z9khHCt7OjT3wwqR0aU2YMOLgbSaUUpZQwTvO+eU+CRWHQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZC+DsSq8uiOXzlLcsFdrz+zpECXrJsuTC5MQ3fDK3I=;
 b=K3ilxEhPxPa/lHBBf/sS3pbEV/qqILQxwnNAHrM1TKQ0irMEJQNYZWWp9Y4vzHZn+lKSOjR2USYdbptBiG3aw500Gbtrvqukc1sw8lyfTLbtP9wpFOzqFTkB7GPJeSGqxc+d83u5RgNOlHZqqz2udla+cEzQS5odzVkiNLfxdIE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by SJ0PR03MB6272.namprd03.prod.outlook.com (2603:10b6:a03:3aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Tue, 23 Mar
 2021 03:01:27 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%7]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 03:01:26 +0000
Date:   Tue, 23 Mar 2021 11:01:15 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: Re: [PATCH RESEND] PCI: dwc: Fix MSI not work after resume
Message-ID: <20210323110115.3740f6b1@xhacker.debian>
In-Reply-To: <20210323012441.GA515937@bjorn-Precision-5520>
References: <20210301111031.220a38b8@xhacker.debian>
        <20210323012441.GA515937@bjorn-Precision-5520>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR11CA0077.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::18) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR11CA0077.namprd11.prod.outlook.com (2603:10b6:a03:f4::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 03:01:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e38b3cb-4312-4687-304a-08d8eda7f2e5
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6272:
X-Microsoft-Antispam-PRVS: <SJ0PR03MB6272C955D340E1F39E85823EED649@SJ0PR03MB6272.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdYV4oyY8znnIByP8BRs4HrTsx41u6z2W1KqNTQJMQPbbKvATPTYNNUNV2NL2Qp8RiY9QY4tg2uA/JWylESVzbXIhXhIzRRSFQBPuauetF1R4k09sL6jEXKhpdJs+4suROYkgCpY0GgbtT08gVUKMtFowxUMTfgFxmEyr4IYykqL326Fska9BIhyioJbP3Nl0qVvi5aIUSuoMQ+7I+T6PanmFsdTHJ9o7AfBUR30nJwqdo/Zexfk3JctSEnpEOYMFf8Dhs0a4xclNp5ZM/o1fvJbZtAC9TZrNdPZ4MMvEoXipEzQ5yBdkUmsroVTGf6vIpYDIAE2AOkhIi9oP8KO/TUAB8BG1+VPcZpiEXe90JMLxJt+W6s37Jgpgp+iMUNAsy5wnO2K5Vc/tlx5dcQOa+KdeZsMnuA7Hf/JnGgRSOPolvtovhJ/eGT/cSzeYzyS+c7NGXGksko4gigK9WzQoDPz1mF2KeNYxvydrxWRFIcfvzczhcWKhGw5NSoeMMOFoT5iRUT/nXAWTEvrBXHPu+R2fLwSJ9WceS0XhyQSHODpUdVaYaarNPqJHzuQs1w/C7cL2uUND+5f0bwAGr+8NDPiS9WRC2diCX+t+z9IDfyxK+XTKO7MmX0oBmGjbR4cC0CQejQSyrWMOg8uVoUvbZHwSxT6jFUqA+XHgN0iiGE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(376002)(136003)(39860400002)(2906002)(83380400001)(6506007)(1076003)(186003)(956004)(16526019)(38100700001)(5660300002)(86362001)(6666004)(7416002)(26005)(55016002)(54906003)(478600001)(316002)(8676002)(4326008)(7696005)(52116002)(66556008)(6916009)(9686003)(66476007)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rCHkPqSV24QykX5RgZxFZivB1kCMO2uBpJqP6mM0CPuxHUEC1jBDOpyiGxP9?=
 =?us-ascii?Q?h5wGbnIyTMXtM3nyecjj4xIabeR8Abzhf5PolpXxpcToXeO/OrebSl+5Rapt?=
 =?us-ascii?Q?AbTapEZp1MPFBQdeiEodSt+LnggU+iAkEEF/m8dOuYYR8t0LUaYeqeVbn95x?=
 =?us-ascii?Q?B2gN9/YhBShpLH2kw3s3s/N0QzaA0OMb7p205qVFxTVkeUT2eDJQV7HkBfSF?=
 =?us-ascii?Q?3M1IoDcrXRZm0vIsktH8OKcTtw1qCIkSsdlVs1VDUJN7WjkOoL555AiK9A4u?=
 =?us-ascii?Q?sapGHbME9lVtFZW82IWCXsPBtTnPzMfs03TpdFnzcHmsPTzbSh2u0bYaKw05?=
 =?us-ascii?Q?czrjTAbAaMwu+Oo4SmsBrSKciEs/XilXtRK0ElCYPMNAd8PHQmvZnBAOj2y0?=
 =?us-ascii?Q?M7IihAtk6pOZRabvvRPsOnLb4FRLyGPSJCfIeGG3VRRxR3douRG1HjHJntxK?=
 =?us-ascii?Q?4esmJQk9kzYYzg/N9gEpxxayomVaBeRhsIWw7qB+PrSq2GoO2rwn2Rj2XD6g?=
 =?us-ascii?Q?2SpvNHi5HyqHDgRxntENZnnyP+NmVJ2fOSXM53W6HYdGysgFAVI6BS8uurzO?=
 =?us-ascii?Q?Y5l7Z6zRQ16tWHa1un0i+hsr0TiAGqTfJ3iNGOEUBy538BjPY1aM5cWySTJ6?=
 =?us-ascii?Q?cQf9vJRZReEu2dQs2rTAwanM2Q6PlsNjD8iyf4GbeOHOaK7EdczYWee7tR/n?=
 =?us-ascii?Q?PP5De51F1vTPlpffVDiS0MtLec0o48tQ85+p41CDwdAK5q6tQ6mLIjuZlq2/?=
 =?us-ascii?Q?wIXp2lF7TjOHb3cPT+YJYjU5zEBFvu4JrQvx8WNhNSNT8+CE3SPnM1DgZOaH?=
 =?us-ascii?Q?OxiyNJLVBAF2Le/49FFs760BnNsDi2oEDj9qKrA++kJziuFjOJRVDWO7+UWM?=
 =?us-ascii?Q?EX5QhqRqVVRVKOiBTLRHSv5mTepVUhV1Eo/gCzETeZZEk2WBxoiSS6cWf2ta?=
 =?us-ascii?Q?RhZrsS3TW6RrRUWQjLSoegJ+zdeIf9ipcg+yVjCrosoYogwt7NTuqXbPhR33?=
 =?us-ascii?Q?9pylv/UKoBLQPrKpsnlbeZ5m8zeHvb9Y80qmHIHUl8SO1swwyKEbNzuDzbn+?=
 =?us-ascii?Q?qTvlsyr1Xm1qQWjmzdS5fS0FAqV40IPpBKhB7TINqPpPK81CyxX+lqko7aRl?=
 =?us-ascii?Q?VXsDubsPhIlC9ku/3UySPOpgngGMgl+FpNdWoMOSu/qodpcfxvBqzu+D6RYv?=
 =?us-ascii?Q?O/14xU0okxAabIzbCR2De7hwoAG6AdQHpQlmfnJMxA9EZ9fe5PWA4ywZx81B?=
 =?us-ascii?Q?woLp5zbXH97m0qwvjJ6aEfdwoExdbB6CrZKaUgssfttZQzXi9XSYLQVBrl1i?=
 =?us-ascii?Q?fDimANkFu6eLLaRz+OAF/wiu?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e38b3cb-4312-4687-304a-08d8eda7f2e5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 03:01:26.5642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+VKZ3fD+ErPke3Lv3+Ku9NMsE0MVPFr53B+EAdp4NrsNnQk4AkHLU8AUgJBUxRtFof+2fG2In1Obo+IlL8MAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6272
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

On Mon, 22 Mar 2021 20:24:41 -0500 Bjorn Helgaas wrote:


> 
> [+cc Kishon, Richard, Lucas, Dilip]
> 
> On Mon, Mar 01, 2021 at 11:10:31AM +0800, Jisheng Zhang wrote:
> > After we move dw_pcie_msi_init() into core -- dw_pcie_host_init(), the
> > MSI stops working after resume. Because dw_pcie_host_init() is only
> > called once during probe. To fix this issue, we move dw_pcie_msi_init()
> > to dw_pcie_setup_rc().  
> 
> This patch looks fine, but I don't think the commit log tells the
> whole story.
> 
> Prior to 59fbab1ae40e, it looks like the only dwc-based drivers with
> resume functions were dra7xx, imx6, intel-gw, and tegra [1].
> 
> Only tegra called dw_pcie_msi_init() in the resume path, and I do
> think 59fbab1ae40e broke MSI after resume because it removed the
> dw_pcie_msi_init() call from tegra_pcie_enable_msi_interrupts().
> 
> I'm not convinced this patch fixes it reliably, though.  The call
> chain looks like this:
> 
>   tegra_pcie_dw_resume_noirq
>     tegra_pcie_dw_start_link
>       if (dw_pcie_wait_for_link(pci))
>         dw_pcie_setup_rc
> 
> dw_pcie_wait_for_link() returns 0 if the link is up, so we only call
> dw_pcie_setup_rc() in the case where the link *didn't* come up.  If
> the link comes up nicely without retry, we won't call
> dw_pcie_setup_rc() and hence won't call dw_pcie_msi_init().

The v1 version patch was sent before commit 275e88b06a (PCI: tegra: Fix host
link initialization"). At that time, the resume path looks like this:

tegra_pcie_dw_resume_noirq
  tegra_pcie_dw_host_init
    tegra_pcie_prepare_host
      dw_pcie_setup_rc

so after patch, dw_pcie_msi_init() will be called. But now it seems that
the tegra version needs one more fix for the resume.

So could I sent a new patch to update the commit-msg a bit?

> 
> Since then, exynos added a resume function.  My guess is MSI never
> worked after resume for dra7xx, exynos, imx6, and intel-gw because
> they don't call dw_pcie_msi_init() in their resume functions.
> 
> This patch looks like it should fix MSI after resume for exynos, imx6,
> and intel-gw because they *do* call dw_pcie_setup_rc() from their
> resume functions [2], and after this patch, dw_pcie_msi_init() will be
> called from there.
> 
> I suspect MSI after resume still doesn't work on dra7xx.

I checked the dra7xx history, I'm afraid that the resume never works
from the beginning if the host lost power during suspend, I guess the
platform never power off the host but only the phy?

> 
> [1] git grep -A20 -e "static.*resume_noirq" 59fbab1ae40e^:drivers/pci/controller/dwc
> [2] git grep -A20 -e "static.*resume_noirq" drivers/pci/controller/dwc
> 
> > Fixes: 59fbab1ae40e ("PCI: dwc: Move dw_pcie_msi_init() into core")
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> > Since v1:
> >  - collect Reviewed-by tag
> >
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 7e55b2b66182..e6c274f4485c 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -400,7 +400,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >       }
> >
> >       dw_pcie_setup_rc(pp);
> > -     dw_pcie_msi_init(pp);
> >
> >       if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
> >               ret = pci->ops->start_link(pci);
> > @@ -551,6 +550,8 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> >               }
> >       }
> >
> > +     dw_pcie_msi_init(pp);
> > +
> >       /* Setup RC BARs */
> >       dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
> >       dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
> > --
> > 2.30.1
> >  

