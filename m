Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A482783F5
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 11:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgIYJ14 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 05:27:56 -0400
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:28896
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727428AbgIYJ14 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 05:27:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCCMn01NgRqC607Qf60XtpUA5S7vZTBeS7ymYdf0G6jC1f+Lo47jBNZm+iXed44RtpTwi21J5ASy4CdHMwu2laNOq3POWrStXJR7c3jcOU1C2Ds675ON7RCk08yVA2iVpM3lAxWeSEz6zHOSjr2/o3IfPKaf6APFAYT3WllIgAIyOO+6IsV+PDbY1x8XAoEjyzMYJOu73ewIi813bK/QkVNaGFI5PmG9qC4Hb4E+Jdtcp2QuT0kn5Wz8+qo77/UE8ZGp3RtfhWZPVLRsGjRTNJQffK0S6Y99VjkCyFH9nIC9wSEpCk6KvGo9NxiR60X2FFDuML8H3oXXkQ6FgorF6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQtmM6YxLmySA1Vuq7uzCm/RSj0khAM/y0uXrFWDct0=;
 b=Tg25HEkPTj7dMvxcAgyiaHD1qchNveDi+IhyLmJ8IPKM1BylB/tcQ5VFgCP/v4QcCYg/wgvyeJm0ii+WanKAERQpRmyavnLNfo4vqFMkKmcv84xAzj0cOj6Xtd6JCP+wRA6zdyk76jXDeI+aGS/Y3PFtdaU3FB4EwVWcSXsBa7IRVKJ443CEURdI4JFd1Ertftlb6+Q3utwVJJAligQZ5alLuvxH1qlkmLNxk9ziJzuexXI1A1sTfuAwPcTuazKiJpRwZMIC5gQZSFe/xF+vKQW5ZaxtJpMNiF7zF5gt3FFiocobm4kcsANCRDEeRzPpcaf85WupF/MK5imdcio/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQtmM6YxLmySA1Vuq7uzCm/RSj0khAM/y0uXrFWDct0=;
 b=BfGXtqJRS5Yx/Hy/5408fDdyXwUlt6kIpERB3tz68hSnmu+3zHQhaYbr5M6FHRcjLrYBWMYaKX2x6tqU1uXJUhLYKCSqtGSrxhwnsq0HT9Km2s9QmqdJul7WSPp1ZSbdAUFM3QuJl318afeUxr/Ac0COuQVLj98j5DAMO9J8HFI=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB4442.namprd03.prod.outlook.com (2603:10b6:5:10a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Fri, 25 Sep
 2020 09:27:53 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3391.028; Fri, 25 Sep 2020
 09:27:53 +0000
Date:   Fri, 25 Sep 2020 17:27:24 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-pci@vger.kernel.org,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@axis.com, Vidya Sagar <vidyas@nvidia.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        linux-tegra@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Kukjin Kim <kgene@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-msm@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Yue Wang <yue.wang@Amlogic.com>,
        linux-samsung-soc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-amlogic@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 0/5] PCI: dwc: improve msi handling
Message-ID: <20200925172724.5bdf6aab@xhacker.debian>
In-Reply-To: <20200925171712.254a018d@xhacker.debian>
References: <20200924190421.549cb8fc@xhacker.debian>
        <de4d9294-4f6d-c7d1-efc7-c8ef6570bd64@nvidia.com>
        <20200925171712.254a018d@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR06CA0023.apcprd06.prod.outlook.com
 (2603:1096:404:42::35) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR06CA0023.apcprd06.prod.outlook.com (2603:1096:404:42::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Fri, 25 Sep 2020 09:27:42 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08b5c9c0-366c-4ceb-680c-08d8613546fb
X-MS-TrafficTypeDiagnostic: DM6PR03MB4442:
X-Microsoft-Antispam-PRVS: <DM6PR03MB4442C9D838716EA6EA073FABED360@DM6PR03MB4442.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJSGkfRAHDXDHjqUDFfaQ4pnN7SpUhEkOYEiP8cPOHJO1V3WxXkRm7gxobdsF/Pc5WS7b0vdGyl0J9niToq7p9cKLXI4XHs2SqEcTWSZ5PJKLA0HB/665ZGRc0oYW7Ydzaj4/MpOPfCCFXFrJjQyBy8Q++3JCh/q1k2ABbNONyaum0u79GCHtIMKyn3JarFkWuX6RT4T2XOJb6LDSJtunIx5z2C8pbg3+Qtlbicg1bz04WAeM4Y0dIQhHA6zR0Xc2TdEy/DMEZKjNi5rfAcdg08pKqdWUNPhfWdyoop6OFYemhJddDSJZudXGpMIoow5cmvoGqFJflv4PstV6YhqXbj+ERg+9Ihd06OyrwWRFEwtYSGSHbzw69zdRuPZ7pDU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(346002)(366004)(396003)(316002)(9686003)(8936002)(55016002)(4326008)(83380400001)(6916009)(54906003)(66556008)(66476007)(66946007)(5660300002)(7406005)(6506007)(8676002)(1076003)(2906002)(956004)(16526019)(26005)(52116002)(6666004)(186003)(7696005)(53546011)(7416002)(478600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GiG8+SfVuXOIaBCnAUuUBwmzRd4zisLOF7dcvTvyp5tJk1CmsQdVVw2nXL7WfO3o/jE4lWyLcfNSyINmEcNjRWgo3jvfwLNapKTVCoakd/xJ4XMKD/DBNmViHjtIxljHnEPFMO6M4hUb+7hxHuwzWE/DVWJXlnmdYuJew5m1eShcxqYMV7rCJ1RNKpYpZTX09i+hLJcc4O+wLUOU0ryN5psXVAidVXyYJ7lDcCyMA2H5AxnIzS2L3WOmqh81XmD2dFb1lH4MyzweSqEU6UBsJSkS6yp20jJIwgvw3bbt/s9UrDD1PKgjWyoQRufaOVmn8p9oI4CEGwBZFhCxZ0tH4rsoNPOJwf+VbcXEWDn02/2sU1y6JxtUbbnXibj1Mw285Ah0eJhzFqQ6YZKSgG6TMw4gmvzgbfMI+NRbmZPdIE/sAn5CSWRSKr9tiNKBVXsnO5s01m2rRU0qBnnxkTN+ABntem7CheF6rKWLLBFIfi6RuY3kMsPhR0raRkj0N93cG82pbb3fJXqJMQl0mYkp2uoSRgqBoMqd6hi6O1czdj0Caa6GYgkTA7/eODveC4gEuN/2V54NXS4QYxLdbNc5YaukSJrDLqeM1sYl/KMtN+tJ6kndsSrEZ6LyBLHzzowKKy8pxeQAwknGW4V6NpkbwQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b5c9c0-366c-4ceb-680c-08d8613546fb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 09:27:53.2243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rofo6AOMlWuSpQFgUURNt+ONytHUCHAdLDZZq3JgCZcsUePwfWT1xvPp1a6pzS8+8xDKQYSS4KOh3B06ksq4EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4442
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 25 Sep 2020 17:17:12 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Hi Jon,
> 
> On Fri, 25 Sep 2020 09:53:45 +0100 Jon Hunter wrote:
> 
> 
> >
> > On 24/09/2020 12:05, Jisheng Zhang wrote:  
> > > Improve the msi code:
> > > 1. Add proper error handling.
> > > 2. Move dw_pcie_msi_init() from each users to designware host to solve
> > > msi page leakage in resume path.  
> >
> > Apologies if this is slightly off topic, but I have been meaning to ask
> > about MSIs and PCI. On Tegra194 which uses the DWC PCI driver, whenever we
> > hotplug CPUs we see the following warnings ...
> >
> >  [      79.068351] WARNING KERN IRQ70: set affinity failed(-22).
> >  [      79.068362] WARNING KERN IRQ71: set affinity failed(-22).
> >
> > These interrupts are the MSIs ...
> >
> > 70:          0          0          0          0          0          0          0          0   PCI-MSI 134217728 Edge      PCIe PME, aerdrv
> > 71:          0          0          0          0          0          0          0          0   PCI-MSI 134742016 Edge      ahci[0001:01:00.0]
> >
> > This caused because ...
> >
> >  static int dw_pci_msi_set_affinity(struct irq_data *d,
> >                                     const struct cpumask *mask, bool force)
> >  {
> >          return -EINVAL;
> >  }
> >
> > Now the above is not unique to the DWC PCI host driver, it appears that
> > most PCIe drivers also do the same. However, I am curious if there is
> > any way to avoid the above warnings given that setting the affinity does
> > not appear to be supported in anyway AFAICT.
> >  
> 
> 
> Could you please try below patch?
> 
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index bf25d783b5c5..7e5dc54d060e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -197,7 +197,6 @@ static struct irq_chip dw_pci_msi_bottom_irq_chip = {
>         .name = "DWPCI-MSI",
>         .irq_ack = dw_pci_bottom_ack,
>         .irq_compose_msi_msg = dw_pci_setup_msi_msg,
> -       .irq_set_affinity = dw_pci_msi_set_affinity,
>         .irq_mask = dw_pci_bottom_mask,
>         .irq_unmask = dw_pci_bottom_unmask,
>  };

A complete patch w/o compiler warning:

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index bf25d783b5c5..18f719cfed0b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -137,12 +137,6 @@ static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
 		(int)d->hwirq, msg->address_hi, msg->address_lo);
 }
 
-static int dw_pci_msi_set_affinity(struct irq_data *d,
-				   const struct cpumask *mask, bool force)
-{
-	return -EINVAL;
-}
-
 static void dw_pci_bottom_mask(struct irq_data *d)
 {
 	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
@@ -197,7 +191,6 @@ static struct irq_chip dw_pci_msi_bottom_irq_chip = {
 	.name = "DWPCI-MSI",
 	.irq_ack = dw_pci_bottom_ack,
 	.irq_compose_msi_msg = dw_pci_setup_msi_msg,
-	.irq_set_affinity = dw_pci_msi_set_affinity,
 	.irq_mask = dw_pci_bottom_mask,
 	.irq_unmask = dw_pci_bottom_unmask,
 };
