Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5801127DDB6
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 03:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgI3BXp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 21:23:45 -0400
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com ([40.107.92.80]:17025
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728149AbgI3BXo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 21:23:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3J6dHJfPVNv6CjeEta09Jj4kRH3sX0yo9jyK0xJtXIzEo+SOko0SWEzJ+xFGVcKL+JVTmjZGspjCE/2B6fEr6F0SORO3stqBkw9YmngSVnbcneeg5hxN0h6jCrMRsnClM4MhEyAvtR2BrvuN7UJDHX/LJLWumkn1cP+cbfNVzvhMMMkiloDjV7Q9bTLSyhKCbPigjB86IrXVFThPgKsSny/FvqMBfu3ZfaItXJCJSTF9BW4hrkxgVv1wrUOztxtaDQTz8coVBcBOSWpKEgAbZMkg8svTuPfn+UuJwjRjNQCcnzPiIhWcne6C9qlG6Xvx8EH9upWcNRqYM0wZHfOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8nw3Dec9uN1gNyB6+voYhdiaRUQvu6G396QHm35HN0=;
 b=JZu8PXDiv4Sn8NvdjLOjkTBXKdmywHyrR9BDWPc6xjxpRQko3HgOuacp/Or+buJb/6us4j0Vz22aLzCBtM75H+wqiYVMP4GJEG8sQaXN+FsRSrzrFN1Y26c4wvDfRbQhHfiVIz/Co4pnmw+PNypDVIooUUct/WRt7qoqj2/bsgIXoymesjWG/c0KppkKHiIGSt0rc0NEcb0wBtkrGW7JRMpcmfqAxecWlGXImzCduNuzeis64cxsNNKLoDd/5D71KCKkDU/0bdq629khxzIMe1uhJpCcFJDb1WSJ/18ZVWxuptzV/HMelb9YNPYPbaG9+cN49p3SpUn2rwA24njpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8nw3Dec9uN1gNyB6+voYhdiaRUQvu6G396QHm35HN0=;
 b=TbGAkIpMlhPQJBajq0fJGDBMWLXgpjO6UHCm+rE8ju/vGhETQ4Xs1UH3RzhyK1F4Id7LwPA9gbAC/GdzZ1QF7NuEK/66R9g3aGxfBwUZNCnPPzpNOssIflsObszT4RhmaWutpcaqcmyGXpRcCTDGcbX23XLpMdmdKTCG+5q0AhA=
Authentication-Results: misterjones.org; dkim=none (message not signed)
 header.d=none;misterjones.org; dmarc=none action=none
 header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB5099.namprd03.prod.outlook.com (2603:10b6:5:1e4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Wed, 30 Sep
 2020 01:23:40 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 01:23:40 +0000
Date:   Wed, 30 Sep 2020 09:23:13 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Marc Zyngier <maz@misterjones.org>
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
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
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
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/5] PCI: dwc: Check alloc_page() return value
Message-ID: <20200930092313.6124a082@xhacker.debian>
In-Reply-To: <74af578c79bd09f2111e5438917f2c6e@misterjones.org>
References: <20200924190421.549cb8fc@xhacker.debian>
        <20200924190623.3251c2ac@xhacker.debian>
        <74af578c79bd09f2111e5438917f2c6e@misterjones.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0055.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::19) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0055.jpnprd01.prod.outlook.com (2603:1096:404:2b::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Wed, 30 Sep 2020 01:23:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d24250ab-a243-439e-357f-08d864df7653
X-MS-TrafficTypeDiagnostic: DM6PR03MB5099:
X-Microsoft-Antispam-PRVS: <DM6PR03MB50995B1FCFA034BDAD2B05B0ED330@DM6PR03MB5099.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vASMwgp7dj6oRqrQKwOMOalj8jNKVyNV8jsplf4scAaN/Oj+7CLCGQANuxMgumUSZCzKbZmxfFXV0SirJd7PgeeY6lOZirPt1dU5F1bJfo84U/5O4nXvppjgDtQP2+1Pa04NTzi4hvfepVQeqMzRmcQ2gSj7uvXZw9vbsCvKHZIF59GDSTdpUOE3s39l5aVBYvAXEJvjbDa4e/yaW++Hus6PsonCi0zKX5WGdK8dPl0eWye9FzQY9mMLpwvQeNKIkH4pVRZ0WNQblyPRykBkLkwJNxXw0NKnAHUrl4V2zt31ZeNUg3+ZcLfm+y+rJXcqNFlmiz5RxYjpg1zbnu9yA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(136003)(376002)(39850400004)(9686003)(8676002)(66556008)(6916009)(66476007)(316002)(4326008)(66946007)(7406005)(7416002)(478600001)(5660300002)(6666004)(2906002)(1076003)(8936002)(53546011)(6506007)(956004)(83380400001)(86362001)(54906003)(55016002)(26005)(7696005)(52116002)(186003)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: P3UnmWd3vnE+fFbtVEPHm7djjY+q6NxF+7Yj5Af1XT/oCZUCZbaLHg81jjgNawX1sBXiHB27FHsZqCJV+jFbhtdp3LScteYXKLPR+0QcyH8jyd6ok2PilyZVcVMJ2+9kaLzx5t8FCKkAc494a/ESl4yPho54sbTA4Dn9Y4Jqgwk3TTXWK7t7150szNcYWAKaTsPz2aHPcvpqrY4wK/20qo0dye861XZ7YNLYcOgpFls67AHTFu1ul/9nAgDODxfB4/vvYWtYCRuMrJgu5qdCp8Pp0QEyftJMWHfXr2ObXhdIi5oTcvCToptdny2IlCt4D2RNrDvc7ffiigC8hCAgmQTzvbxGAsX05Nga3gapn9nq12KOSJET7stlMPXIamD0uF/+XBvLlek+dCRIGPQpcHmM6Qq7Qd1JbIuGA2XKYaOI7V6uc+fwb5d6aoWGrY/DLCGLuxhi7vTikVofqGHAIXv0m5gqmgVj7PVK3BLQaOeod4qur9iFbqB0AB3FI8itTGyRSplo9CkAwxcSK3AM7etJDHyuErqviJHJjr6OgxlIq9FcDDhSS4a5pwhA16ruuULXoATcGnSWA3HCCjhB0R4G/JcZiojRK3sJ3rkuALluZNhMuk9YC6ZgNukNjXz/TY30poFSa64M0VePSs8DgA==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24250ab-a243-439e-357f-08d864df7653
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2020 01:23:40.1912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKcNhXuEm07mcD4LtDFkb57sxMOOhAL5B/aTa7EbOue++PRWoIErKCd2JbYjrCIZsqEQFkREaLLYy6EecEwpEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5099
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On Tue, 29 Sep 2020 18:29:52 +0100 Marc Zyngier wrote:

> 
> 
> On 2020-09-24 12:06, Jisheng Zhang wrote:
> > We need to check alloc_page() succeed or not before continuing.
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 0a19de946351..9e04e8ef3aa4 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -303,6 +303,11 @@ void dw_pcie_msi_init(struct pcie_port *pp)
> >       u64 msi_target;
> >
> >       pp->msi_page = alloc_page(GFP_KERNEL);
> > +     if (!pp->msi_page) {
> > +             dev_err(dev, "Failed to alloc MSI page\n");  
> 
> A failing allocation will already scream, so there is no need to
> add insult to injury.
> 
> More importantly, what is this MSI page ever used for? If I remember
> well, this is just a random address that never gets written to.
> 
> So why do we allocate a page here? Why do we bother with this DMA
> mapping?
> 

Ard and Rob also pointed out that there's no need to allocate a page, instead,
we could use an address in the driver data for MSI address. So I refactored
the patches and verified this solution works fine. Could you please review
the V5?


Thanks
