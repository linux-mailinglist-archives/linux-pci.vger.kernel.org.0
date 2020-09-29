Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BECD27C2C0
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 12:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgI2Kte (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 06:49:34 -0400
Received: from mail-bn8nam11on2043.outbound.protection.outlook.com ([40.107.236.43]:20577
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727761AbgI2Ktd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 06:49:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgK4TbOnr0fczpx5TAK6RA2ni7US/7NnDQ+LvZW8WoKUpwIPuLYiLtUsw1hfq05CLJDyTf/LaK488Qq33vHlh+Yxf9DsSMzvu5i5lmFbhjDNn3m+itfDeDIBGz2xHYecjRSxLpa9MGlANfT8qd9vN6iQz/FYD1jthiVQUJm0wIGuQG0VxKu9dWnOcKmb8GL85xCjesKevcxiSYZG2xum/5ptx045qcw7snH6BIAGjtUx93X30OnjzHdWreE9UpGlXb1RMiPCqqfv0DR3HHQET3Lx4J5N3qkdvW70XXwJ2XdqSA6NKkaXkMtGZR6Z4CrvxUIJZbDpxu9A6/wLFMFBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrEqLeOG0e+YEU9Ew3Jbjzgylpn3z6Ewcxvzj7PRsog=;
 b=iwGWAcbqwq5ivUMM3n8DQNgsckZFsme7VLkdsyWxRFDVYywsvYSEhf4zL2WDvfL9fySw6VhuKrTPnxw8TJmLYAjy+MZNjdR+qdpEhlMs/9ksg0r7sv4lk6QMgxbxvIU39A5OXQC7XAJ7sqrg6ODL8wvIEIdwGg6Z/0wPFLEo8SPO9x0G6d2CtjE9F/JKVhHhgCF3KkHW2r1xMGyCF3Da6q35WTpEedEyO9YHePl/IhSI0ZXKO8Qs4UrwNrumveAicLuBWFkAJC/tflH89Tx4Ppc9Ku5coWsCsBi5gNWYUoP1UL8mfe4xFUHcBJVOiksCPhSyUikAPUlewJ3PO+iwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrEqLeOG0e+YEU9Ew3Jbjzgylpn3z6Ewcxvzj7PRsog=;
 b=fzGWL+Dtmv1fbrzf/1UqoiwBl4DNVP8RYtDYz8YuHO6crpagZ1TAA0Fj5DVPqzC6PE/7L9J/Jep9nES1qMUNSKsWyfziinUmfbT6uRs4sziCKH4vpY4KRthBrm0R2Im5jNpKbqoX66pG4dr9kdx+SPih/r2nKZlYZucEA8snNNA=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB4442.namprd03.prod.outlook.com (2603:10b6:5:10a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Tue, 29 Sep
 2020 10:49:28 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 10:49:28 +0000
Date:   Tue, 29 Sep 2020 18:48:51 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jon Hunter <jonathanh@nvidia.com>
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
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <linux-arm-kernel@axis.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH v2 0/5] PCI: dwc: improve msi handling
Message-ID: <20200929184851.22682ff1@xhacker.debian>
In-Reply-To: <de4d9294-4f6d-c7d1-efc7-c8ef6570bd64@nvidia.com>
References: <20200924190421.549cb8fc@xhacker.debian>
        <de4d9294-4f6d-c7d1-efc7-c8ef6570bd64@nvidia.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0054.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::18) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0054.jpnprd01.prod.outlook.com (2603:1096:404:2b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Tue, 29 Sep 2020 10:49:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7998fb7-2a5a-4760-9244-08d864655641
X-MS-TrafficTypeDiagnostic: DM6PR03MB4442:
X-Microsoft-Antispam-PRVS: <DM6PR03MB4442DDA95D15D07A19C05B42ED320@DM6PR03MB4442.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdv1cSzH0wAYG1qqqX9oVTw7xry1CEJvAkVhoAYoETIovnkvhyU9bR2l8SJsKl/2HDwWFtggQHCE02U5rq7nmuvzIlBk+Q05L+5vvP0AOf32sg3STsncAFYVV5mPvGUmte6Bl1L2RR6Z4aCq4wla9AkyAYf2fqEgv+xXdkxurNvxjoOvcy+aFXPh0NyE+uLGOJDmAiXmIETWWQ556OXr5g3yvYTsaTM0H8rgbyfsYTw6yCSt8gPHpHtv628GpNVvcFmiW83uRD1m0OLV8y7RhEzkpPANRTg41ICHSRdEzlTJnVcm26IyCIPiXYfq+X0Kw+bk85hh4oMbCnua/Xahush3rUUFt3YK6vBN9Gzswd+WrIP3fLkDpr+kiGnDEU8D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(376002)(366004)(396003)(66946007)(956004)(6666004)(8676002)(86362001)(478600001)(8936002)(1076003)(6916009)(4326008)(5660300002)(7696005)(52116002)(7416002)(7406005)(53546011)(2906002)(16526019)(6506007)(26005)(186003)(66556008)(316002)(66476007)(9686003)(83380400001)(55016002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mXCAddAnPLSkQjPzsCwpnlw31nefGW/Yx2Iy7B5gG4NvIlsPMeoj+EycO5dJ+1dVLM4SMg1eYvdh0/J4xRdUKxV7hyi8HkEmu5s3ikYHSViqYO+qdYIwse6fRJahYUy2WRPvTJLxZAeyOHpYnfzRQiQ8S5uNddpGtkt24/VGOn8TDwAN3LpOj4a6cSiCHvUwkAarEoOFdAMkVBbu+1TpATEBRxv2qLS08noWBQLcfiBD2FZOXiHB5KkhEA5t7QrCRi2nvDwHio/JzxjDOFQNhmXez8HKEDGT9g1FNVQyXSvYvZjhDmnOAx3jgOyDH9c01jjz6r9UpcXNArgsdAy60sEETGRsKusk9/bkIfpGMJpl/QNQ9DQ1T7CN+uShmyBjGFRmUeQrXxLiNUpiaNtHf1Fu5JPXQJXHfHUg7932UXTwzsQpiJv9YMZrBYJJjIpbh7RXIG1P+BB+m7ntLyMTbz9m1jbnFtk/0Px1Zrgxv2DhjmwJxNTS5Uba/lKCgu2XsPF1aZpWGt1wQF4eIvxz+E6fyhNHagR3OniEkeJ3TUx27m+3hFEhI0pV5GrXLuOekQPRcTiYrWrtAF6y4DVaJQeCzPhwnB8MGZfS5+CT18dTXYefIZ6ZQInu4H9tICnzeMht4P2QLbwsNfNzCvng/A==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7998fb7-2a5a-4760-9244-08d864655641
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 10:49:27.6996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lL2OHFP21JIEiE6gpUPB0JP6ixr9g7VrYwQhCn1EXTXxDmQDeFIIIviGQOFYASIUIctBsQ9kmm1z1Za8IFSsjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4442
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jon,

On Fri, 25 Sep 2020 09:53:45 +0100 Jon Hunter wrote:

> 
> On 24/09/2020 12:05, Jisheng Zhang wrote:
> > Improve the msi code:
> > 1. Add proper error handling.
> > 2. Move dw_pcie_msi_init() from each users to designware host to solve
> > msi page leakage in resume path.  
> 
> Apologies if this is slightly off topic, but I have been meaning to ask
> about MSIs and PCI. On Tegra194 which uses the DWC PCI driver, whenever we
> hotplug CPUs we see the following warnings ...
> 
>  [      79.068351] WARNING KERN IRQ70: set affinity failed(-22).
>  [      79.068362] WARNING KERN IRQ71: set affinity failed(-22).
> 

I tried to reproduce this issue on Synaptics SoC, but can't reproduce it.
Per my understanding of the code in kernel/irq/cpuhotplug.c, this warning
happened when we migrate irqs away from the offline cpu, this implicitly
implies that before this point the irq has bind to the offline cpu, but how
could this happen given current dw_pci_msi_set_affinity() implementation
always return -EINVAL

thanks
