Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF4728462A
	for <lists+linux-pci@lfdr.de>; Tue,  6 Oct 2020 08:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgJFGhq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 02:37:46 -0400
Received: from mail-dm6nam12on2085.outbound.protection.outlook.com ([40.107.243.85]:4704
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbgJFGhq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Oct 2020 02:37:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIAur3roak22cadXRKJDLcaF5Qw/FmtNehF+6bg/B9lJTe1KAZ7GJu7GqIuQXXvbXU0iN5RoYCA3HdvNZqeuln/R+198Lgck0WdCbr/G/8wyasqPEHi8YNQoMvOpVTC9Pv93oi+k5FcMQTt0pPiUVjSItJ18aN7Cqf4Mej3X0+39tEE7Bsd79wYtV3Fo0tsWn6LJP79nZGWUqPBaQEwZB3uNveYFqhOmZ7P8FEtuy2W9copaX4owtirtTc7Gjlw0+ReVHn8TIdFV/X5kYn92RlbV01CWVqQI8v8TW1l0zOevRaBTIwyO4IZN16D8Jkqdi6q4vRSFk8Y5/GqF7SgBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS+yBSoOjA7gY4d2V+qR1XJVBinMl8170V0nGl0J3nI=;
 b=LDBF4Y4VGVgWWUZI6JYs+xkxZAnmeUv0WHSrDIlGSoxu6+mM/065DXcnLmn5ao4qKmbaonf58xDKFEw+zePqLRBv5VbMwjfkmn3aNz/zz9cL7fh9NPmCFL5zEAMrTv0tsit7ybI9s7nB1WigJ8KTe5ELDfO1gdh/UjDJF0IACDEEYaU18Ss8mU6oFxs7qhUEGIxwJBH9OkVVL3oYxsnm4OmOFgRHEcTcg5eVaWq2+RLZ/BzdB4YI80AMr6Y9sXkYMxGEFnMbax0c/EU3Wvx2LNag8dktP5n00pFu+mhcSfjgwhU6IjJxPldf/BEUTttMFyP3cIp2xxOfkM8tGzeR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS+yBSoOjA7gY4d2V+qR1XJVBinMl8170V0nGl0J3nI=;
 b=daX+HHml8YVluihTZp3GG+KU8qL09Yu75tCzkraAfO9Z0rokmMZQuI7QXVtiEtFkB792dXS+++QenxBLbSMoVE4Vx8rUj2BFTfbspB2eMgl3u5Oft0YbUOAHPyYlVxVMrVCx4ZOQfJjEhw0wmVe0nH0FOYxVJAJm04OMwLOgQJo=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB3803.namprd03.prod.outlook.com (2603:10b6:5:42::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Tue, 6 Oct
 2020 06:37:43 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.045; Tue, 6 Oct 2020
 06:37:43 +0000
Date:   Tue, 6 Oct 2020 14:36:47 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Yue Wang" <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Kunihiko Hayashi" <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] PCI: dwc: improve msi handling
Message-ID: <20201006143647.3f989340@xhacker.debian>
In-Reply-To: <b977d9b4-cc98-e817-0d51-8f2c6ba1445d@nvidia.com>
References: <20200924190421.549cb8fc@xhacker.debian>
        <b977d9b4-cc98-e817-0d51-8f2c6ba1445d@nvidia.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0100.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::16) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0100.jpnprd01.prod.outlook.com (2603:1096:404:2a::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Tue, 6 Oct 2020 06:37:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cc23675-0c00-4ae8-89c7-08d869c253d0
X-MS-TrafficTypeDiagnostic: DM6PR03MB3803:
X-Microsoft-Antispam-PRVS: <DM6PR03MB3803FB3865A0D6D9542403C5ED0D0@DM6PR03MB3803.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocYdiWdeP25MEer81JOZ9QM5uaVSlQbMXVVtGeSYKdKbfqeX3Y+L0YRFBcrpqBcDidiCnDlNPpTjpmFdi98vGuOpbgf9svSlXES0bv7HXbfpdQCbOSbGdzbJ/wRtDHcSNjNGKCgbxu/UeuxCywXGZHnbYTEw+hccYB7ZTMSX7HYjT3KfStAXt9z0dmMja37QgbpmUm4YSJRiLgT4RaqClWA4XR7NwsdIwN/TIvGC8ljArq6DyJD/8IiGqo84zo5x/sXSFmWkNlwPv7jIlOnfoyM+sYDL5CNjuGtoFNjqg8Ljqk1FKW6uqfZ52QxlFFoNoJlSmSoPu+ndD95kxCs1KFVpRrT8IImOsoS/x7wSbURTZJPWHS2a4zhU/9WuqOr8J8e5Lgozr0FYtzLeysNolg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(136003)(346002)(39850400004)(6666004)(8936002)(8676002)(966005)(9686003)(316002)(55016002)(54906003)(478600001)(4326008)(86362001)(83380400001)(53546011)(52116002)(16526019)(83080400001)(66476007)(7696005)(26005)(66556008)(956004)(6506007)(2906002)(5660300002)(6916009)(186003)(7406005)(7416002)(1076003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mgYS0OlDIEQppj5rPO93HRRMrizcXjgBbKxeKVHekpU11NV5Nbvm9zhMKtM499eixKBwMSc2jMogx471N2+aZat9STgtuunmcwHaJjp9t6aTHqFy/rtydL3SvqlY2ATwA/d2XK18D3UA/j6KCIm4cNssiN/vgE2VwH/n9Ki/9StEiviS2mudORi1oHjOuH80H26V57VCg7qI5kUwQcCT/xHr79IkX53ndsW8JQ1Wy0tL+t00KvPdkR4kzeo7z8QIGv1qUcVSln8celJOiGDXqcbKqVkcchROgYBwkPxla8klbZsip72dCsKN4qpSGEGUNpEMAUHuFDOALpmB68hBwuCyV/D9Qbg9pvNIzCpI+tJckV6pEXWLRNf5ncJwdhHZVwdFaFqoeAKryKzUoQtDaTOTDxFy75AcptsU1EuT9j1Cp55x1X6BaOpndY/DrW6iE49TdTLWvr+PaDY2OkqhcnqddziFAtE3JUPWAvUV0rEb7Ihk/xn4Xb4+2vQtMkA/jQiwztPFPolb7pMiz8dmu5TCNd8QHzEnCXY+K9r7BYyHw39vIYqOrDFBQ1H0H5JtJt/WzCxgQpvpSX2vSc2fWt8TUNcEimkeky9W8Nj9/ohyvIzuwAPYiVud8y+ExJHeNPFKjBzstQcLTZdpcr85dA==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc23675-0c00-4ae8-89c7-08d869c253d0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2020 06:37:42.7670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIX9T9PwXwyW9UaeQpeoYyD4TEG/yN7WwneGwrug8VKcs53H47//1g22sFlzZ6hLMccd76Jlr00UYpOwYDGVDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3803
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 6 Oct 2020 11:56:34 +0530 Vidya Sagar wrote:

> 
> 
> Hi,

Hi,

> I would like to verify this series along with the other series "PCI:
> dwc: fix two MSI issues" on Tegra194. I tried to apply these series on
> both linux-next and Lorenzo's pci/dwc branches but there seem to be non
> trivial conflicts. Could you please tell me which branch I can use and
> apply these series cleanly?

This is a fix, so I thought the series would be picked up in v5.9, so the
series is patched against v5.9-rcN

could you please try v5 https://lkml.org/lkml/2020/9/29/2511 on v5.9-rc7?


Thanks

> FWIW, I acknowledge that the existing code does leak MSI target page
> every time system goes through suspend-resume sequence on Tegra194.
> 
> Thanks,
> Vidya Sagar
> 
> On 9/24/2020 4:35 PM, Jisheng Zhang wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > Improve the msi code:
> > 1. Add proper error handling.
> > 2. Move dw_pcie_msi_init() from each users to designware host to solve
> > msi page leakage in resume path.
> >
> > Since v1:
> >    - add proper error handling patches.
> >    - solve the msi page leakage by moving dw_pcie_msi_init() from each
> >      users to designware host
> >
> >
> > Jisheng Zhang (5):
> >    PCI: dwc: Call dma_unmap_page() before freeing the msi page
> >    PCI: dwc: Check alloc_page() return value
> >    PCI: dwc: Rename dw_pcie_free_msi to dw_pcie_msi_deinit
> >    PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI is disabled
> >    PCI: dwc: Move dw_pcie_msi_init() from each users to designware host
> >
> >   drivers/pci/controller/dwc/pci-dra7xx.c       |  1 +
> >   drivers/pci/controller/dwc/pci-exynos.c       |  2 -
> >   drivers/pci/controller/dwc/pci-imx6.c         |  3 --
> >   drivers/pci/controller/dwc/pci-meson.c        |  8 ----
> >   drivers/pci/controller/dwc/pcie-artpec6.c     | 10 -----
> >   .../pci/controller/dwc/pcie-designware-host.c | 43 +++++++++++++------
> >   .../pci/controller/dwc/pcie-designware-plat.c |  3 --
> >   drivers/pci/controller/dwc/pcie-designware.h  |  9 +++-
> >   drivers/pci/controller/dwc/pcie-histb.c       |  3 --
> >   drivers/pci/controller/dwc/pcie-kirin.c       |  3 --
> >   drivers/pci/controller/dwc/pcie-qcom.c        |  3 --
> >   drivers/pci/controller/dwc/pcie-spear13xx.c   |  1 -
> >   drivers/pci/controller/dwc/pcie-tegra194.c    |  2 -
> >   drivers/pci/controller/dwc/pcie-uniphier.c    |  9 +---
> >   14 files changed, 38 insertions(+), 62 deletions(-)
> >
> > --
> > 2.28.0
> >  

