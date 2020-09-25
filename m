Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74AA278363
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 10:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgIYI7P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 04:59:15 -0400
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com ([40.107.236.47]:23563
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727044AbgIYI7P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 04:59:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k69ehfUG7myWLyzcUmM2W0Rr7rFyIO8OLPbq5mvQhdh2euWQEEyPwy8sfDf7jitw437zZ8QmrZaTD7QPDL0CaSDtnRRwxrfRCXCt7t16iMQc4eNIzVlDAvHxaqlE351JYIyiBrSp9eYMgJYS5GUA8ZI5L4iycH2rmW1iZmpejjQdnv6vTxwePubBCUWHo3vhQ142apGRbvS25gnv9awYkWU5e3hbLbIK4dih2n3pEsrpdfv/ZTBa/hesog8D1aLmEO1w/8Awwu1pXnN4aUDvlZLtz5xYQEwKqRbiq7xRqyC5H8F2L3uwvsaJWlFH+taxItmBAxQrkSAe3m2wpp4T/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULlTMrfe9062LCl2EX8wo8BdtFeK98qf5K3RdOJxmMA=;
 b=hnND4F92LvHSSnTwmgvvkh5ilBphhOerDqnWrOjyu3k9tLp+hODjnZcPbiubclcC50vEn+YxZqKFIDn/5uvHf5QVtP927FbMZxTdx9Uecimytnf6C8NZHHA8weaPxQKiH9eiKljUNJ1J/+kPIV/P5dIpsa80kjgDTCAb6q+aZqj+241KKblRNHbb7Fvvg9qZpJ/IfvQ5BsMkJi1rdfmeHc/dNv6Jazl2MAxdXqoyccLpU3RcHzXTZ4Fg0jUufjaSDuW95HyCWNF3uTy9EKD8l5SSH588tgK05L71wfehP4dOHBxzGL+i6aRuWib0H0k/zbs7PqARKpuCZQRyEPHZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULlTMrfe9062LCl2EX8wo8BdtFeK98qf5K3RdOJxmMA=;
 b=exoHN8W9S2jWqDhSeJTl5XYBx3HeMqbrz0y/q1WpCoVttjfbVR2Tjx2GSOeKclwjVusLp4WZ2l3QZnjdq74DQtAJkLvTIt4m4hO3kQTPqFY53nJjznAJ7DaSplv/x/RDMHh2losUXSCqy9it2VU8tssQzOpSyPvdGqlnYJRxfkU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM5PR03MB2682.namprd03.prod.outlook.com (2603:10b6:3:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 08:59:10 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3391.028; Fri, 25 Sep 2020
 08:59:10 +0000
Date:   Fri, 25 Sep 2020 16:56:44 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Rob Herring <robh@kernel.org>,
        Niklas Cassel <niklas.cassel@axis.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] PCI: dwc: Move allocate and map page for msi out of
 dw_pcie_msi_init()
Message-ID: <20200925165644.312f76a4@xhacker.debian>
In-Reply-To: <CAL_JsqLkQ_NqrDDJZkm5ef-mf4_Vh0sW1DqQjitz-GzGBNbWhA@mail.gmail.com>
References: <20200923142607.10c89bd2@xhacker.debian>
        <CAMj1kXEyQGEu7=-kbDuTDW9_xXkmns1HM2dQMrLn=XL9W88vJw@mail.gmail.com>
        <CAL_JsqLkQ_NqrDDJZkm5ef-mf4_Vh0sW1DqQjitz-GzGBNbWhA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0160.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::28) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0160.jpnprd01.prod.outlook.com (2603:1096:404:7e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 08:59:06 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc6b7ce1-1805-4d68-1135-08d861314461
X-MS-TrafficTypeDiagnostic: DM5PR03MB2682:
X-Microsoft-Antispam-PRVS: <DM5PR03MB268213055DBDCB7289C21B1AED360@DM5PR03MB2682.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qyoh+CPYmYQvefACXFvAYOJoTsQGBqCAv4XDErshp+JyXNzJVpAuT56KN8bDpNWMXZCvWyvS+2ff5adETrl/DVLw4QpXKXfhemYRVddAaCMCI2zl/cOZ1FUchBxuojHAmSjU3eY+WHd4kEAbFYOL5RJbM4kDf6kvvkvqV/dXhrOc1pMZ5KQyOH8j3Y3MvbwDGYYnNb99Z21YPiTgBxzuvODRfkQaVG8jz9HHJmPirxdyT5MdZaLS0YJ2Kbum6i23MvuYf0roOD0cDkkUrC2+rTZefEh35Dd/gpuIY0K5HHEtkfa+DMwmGXX2BkfQRtEN1AuaDbWeLr2hQqMkJW5jqX3eD+G2ynJtr3HG56sdaGBu7/U078Wc+BEcZRlfWk4KIWRatETvy+M8r9zI9so2pbd3Y8PaNmMp31CQBwxebFiB3fdB5Dv0ACerp1c7Ka+PHupenBnH7b2gNIUE+bYtFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(396003)(346002)(39860400002)(316002)(54906003)(2906002)(110136005)(956004)(83380400001)(6666004)(9686003)(55016002)(478600001)(8936002)(1076003)(8676002)(7416002)(26005)(86362001)(7696005)(4326008)(53546011)(16526019)(186003)(52116002)(6506007)(5660300002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BdPrT0Yh4rmvEI6YYpkXg3kLOxLHCGSZGcp9oO9vgWeX8Rkvk0G8XjnDz8X1nqgWQkxkRBoqA9zxIcrqJ0NVDVBSU8Q52YCZfdBdObPZm9H/2HT8yXPX5QGDo0/YyOmc/qCh0AVrDOJg6/INwRhh2yZPOqNYw1WIqYGBFhmNmTbka+xBelVDtMSYLXRuVNB3r8EXwfKTNeHOnI050VHg0ZYaCPqoCqv8CMTcNjAle0m9YVOmK3mA8tK30RgEdgMG/M9d74CZkz7aaO/8FtC2VJJzn0xRLagjJvWkGLFUYmpvUC5qM65Xj87jPm24hBmhrkd7XGEgVzlZgh1KEm4NVM+eMpGDh57y9ApuzT1/bGG/N8Xn8QvryeMK4rYvhmEqHYynjLQn+jVH3Dd2wHMDFYqCuksbz95BFsPrxVLSBWI+rg+hxhl6sCYzEZF0aJsK4suLzZQFdFK3gmi7k+NTh6hNIQWRvwJ/+4MzF1DmeHxmX2LOTxxQRNvAjLBmfeJZTbjakfJGJaVBQBNpN8MNX4+TzUSPIQb70bHQsiuOR9h3bxQoqTAeuvh0ngUG00+vwsUhtOae8ZIyQArX0XlkwFkafpNGVgShwsblIFEpmD1uWOqOXXdi+tJ6/6TJJyFIInzHUjAuL+jkBYTTo11rPA==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6b7ce1-1805-4d68-1135-08d861314461
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 08:59:10.3068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVoef3eU/5pi49sVBxYtkF4NbCqwEsgTDrne5wuKAu0ijhABimEccEGN3it9utnmXlZH207zycXv8nVWfhQCsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2682
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 24 Sep 2020 07:28:25 -0600
Rob Herring <robh@kernel.org> wrote:

> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On Thu, Sep 24, 2020 at 5:00 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 23 Sep 2020 at 08:28, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:  
> > >
> > > Currently, dw_pcie_msi_init() allocates and maps page for msi, then
> > > program the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI. The Root Complex
> > > may lose power during suspend-to-RAM, so when we resume, we want to
> > > redo the latter but not the former. If designware based driver (for
> > > example, pcie-tegra194.c) calls dw_pcie_msi_init() in resume path, the
> > > previous msi page will be leaked.
> > >
> > > Move the allocate and map msi page from dw_pcie_msi_init() to
> > > dw_pcie_host_init() to fix this problem.
> > >
> > > Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>  
> >
> > Why do you allocate a page for this in the first place? Isn't
> > PCIE_MSI_ADDR_HI:PCIE_MSI_ADDR_LO simply a magic DMA address that
> > never gets forwarded across to the CPU side of the host bridge, and
> > triggers a SPI instead, which gets handled by reading
> > PCIE_MSI_INTR0_STATUS ?  
> 
> My question too after digging into this some more. I've asked the
> question on the thread that further complicated all this changing from
> virt_to_phys() to dma_map_page()[1].
> 
> > Couldn't you just map the zero page instead?  
> 
> Why a page even? You could use PCIE_MSI_ADDR_LO address itself even.
> Or just an address in the driver data which is what some other drivers
> do.
> 

Thank Ard and Rob. I have sent out V3 (https://lkml.org/lkml/2020/9/25/272)
which uses an address in the driver data for MSI address.


Hi Niklas,

can you please try v3 to see whether it solves your problem as well?

Thanks
