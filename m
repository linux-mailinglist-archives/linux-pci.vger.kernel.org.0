Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03FA277041
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 13:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgIXLt1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 07:49:27 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:43472 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726406AbgIXLt1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 07:49:27 -0400
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 366EDC0648;
        Thu, 24 Sep 2020 11:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1600948166; bh=hMr7mpw+k2CeWVmWj0Ph5MeO4xVp9Bt0Bl6ktc1NfJM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=lj19ckjmVn9JTkh0kr9i9xqriiI17GdnGhOdUnrwiXI90nFhGFoClv6hThu1O/uDC
         XZUnfuRDpryqocYSX7VcFzPxdy57pgFYSE9onLEgl0DwfKSQDgqUC6UAA2Jfgc67D/
         NMh2aY2/aRyo4vEj4zOSULOdc8QntS/m6x12+QYsJi/c/vHZXqEhcy15buL7P2Mrtk
         jAymMh+OpB93+v2N99D7UKGsnUqaAoxD62meAx16Lg4vUyK0qPmzkZ9mUr+eb6UAPa
         YBUiljtbZ9Ra79Jl0iKC0mlJEFweng8ArujUGXb8hk8J2ZZBzI/0j+qbelPtB9QrP4
         pIsLL+CZMXoLw==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E5FE3A0063;
        Thu, 24 Sep 2020 11:49:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6AA54400F0;
        Thu, 24 Sep 2020 11:49:19 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="ggHBvLko";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+/1jnFrLf0hg17s37XOixlJHI8HSDbU6KXPPyGW5/PtUMO5Jd/vhN46e3vukBmZEREpQp93CoUVWTcsiZwImYziaVItQLgepS7rf6SckeAHlthRVbaIbiRXHKyEcQNfAlLwIqM6CsAj8YZgJS5fZrQ8bDm5bH660nxvXdJd82vGWl0XDpviDUNyCXGyn+gy3LuKDt9cYE+pj2DOTwZNzZoqzG/Fylp1H2sviT0H6DJLpYJwX1sNHIvNA11/SJRiz4Eui7N/WUOWNGwUtjniIqnxBLv/d60mR6SDseY3RrEvGgpmudsB2Fg3d7KpG3jYvHH+dMcRtPA1Gc+/2z6OIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vVCTxDP6DDaVbV6hLGD124YNpGUPR5dggkVJ/hDdeQ=;
 b=HA/+wmmfG73Pr7bkDJ7xvw3x2OjbSKoaP5UyCQ55tbaWVFmUt6lSuCaQ9qMNms9tkVPAf06Y+Rg586PGYnfNyCWLVIN9I6q+m5xf7M8PfsIlPGzeJVh5UjMGCJGUaUzppFCfa4N4bWpgo7nOGUXB2Pl1ye77hzz9CBwXC+trV7ImZTuoqur9jKvCOPkLKWsGS+rbKfGXdhaLZYEY3KjJ5gXg+10py8mQ1NebEgm5hL/skz5cIXVAamdg3f+uMMkRtwoMwRF76zU3AaT9z1yC6UtjO4BDYNpqT0KzJEzolvhEVOm/kxkqL36I5GUoD5tainbti0zjSQBHcXvuq2if1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vVCTxDP6DDaVbV6hLGD124YNpGUPR5dggkVJ/hDdeQ=;
 b=ggHBvLkoUpKr3e+R6t10wIYQEDgw4bB+OwRejmfPl3jXjAmiThLhTRgGfJR9ASWd39YOVBDFmvi+EahymIMDXCqYKYYnj3d986nvie1E7tiGnmKdqhC3EpDgIw/kGCx4tnJIsFfl+PooTVoRzL7Zio8Rm9HMRX8edygm/tqCOuM=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM6PR12MB4863.namprd12.prod.outlook.com (2603:10b6:5:1b9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.19; Thu, 24 Sep 2020 11:49:17 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::742c:dafa:9df7:4f4]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::742c:dafa:9df7:4f4%10]) with mapi id 15.20.3391.025; Thu, 24 Sep 2020
 11:49:17 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
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
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
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
Subject: RE: [PATCH v2 3/5] PCI: dwc: Rename dw_pcie_free_msi to
 dw_pcie_msi_deinit
Thread-Topic: [PATCH v2 3/5] PCI: dwc: Rename dw_pcie_free_msi to
 dw_pcie_msi_deinit
Thread-Index: AQHWkmMk/ppnRr4f/UaRejE6DvpHaql3rKLg
Date:   Thu, 24 Sep 2020 11:49:17 +0000
Message-ID: <DM5PR12MB12763FB5508BC95ED82F4B79DA390@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <20200924190421.549cb8fc@xhacker.debian>
 <20200924190650.24c0ff8c@xhacker.debian>
In-Reply-To: <20200924190650.24c0ff8c@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWY3OTExYjcxLWZlNWItMTFlYS05OGNmLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxmNzkxMWI3My1mZTViLTExZWEtOThjZi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjI3ODgiIHQ9IjEzMjQ1NDIxNzU0NzMx?=
 =?us-ascii?Q?NDg3NiIgaD0iTUdpb2FPWTNMYnZ5WmcrMCttWGpOWUtiWUpNPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFD?=
 =?us-ascii?Q?ODl1aTVhSkxXQVpzVlNqQ3VleTczbXhWS01LNTdMdmNPQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFOclNWM2dBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
 =?us-ascii?Q?QmhBRzRBWXdCbEFGOEFjQUJzQUdFQWJnQnVBR2tBYmdCbkFGOEFkd0JoQUhR?=
 =?us-ascii?Q?QVpRQnlBRzBBWVFCeUFHc0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtBWHdC?=
 =?us-ascii?Q?d0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCbkFHWUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFiZ0Js?=
 =?us-ascii?Q?QUhJQWN3QmZBSE1BWVFCdEFITUFkUUJ1QUdjQVh3QmpBRzhBYmdCbUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1BRzhB?=
 =?us-ascii?Q?ZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWN3QmhB?=
 =?us-ascii?Q?RzBBY3dCMUFHNEFad0JmQUhJQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FY?=
 =?us-ascii?Q?d0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0J6QUcwQWFRQmpBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJn?=
 =?us-ascii?Q?QmxBSElBY3dCZkFITUFkQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFH?=
 =?us-ascii?Q?OEFkUUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBZEFC?=
 =?us-ascii?Q?ekFHMEFZd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhr?=
 =?us-ascii?Q?QVh3QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QjFBRzBBWXdBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQVp3QjBBSE1BWHdCd0FISUFid0JrQUhVQVl3QjBBRjhB?=
 =?us-ascii?Q?ZEFCeUFHRUFhUUJ1QUdrQWJnQm5BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6?=
 =?us-ascii?Q?QUdFQWJBQmxBSE1BWHdCaEFHTUFZd0J2QUhVQWJnQjBBRjhBY0FCc0FHRUFi?=
 =?us-ascii?Q?Z0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFITUFZUUJzQUdVQWN3QmZB?=
 =?us-ascii?Q?SEVBZFFCdkFIUUFaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBY3dCdUFIQUFjd0JmQUd3QWFRQmpBR1VBYmdCekFH?=
 =?us-ascii?Q?VUFYd0IwQUdVQWNnQnRBRjhBTVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QnpBRzRBY0FCekFGOEFiQUJwQUdNQVpRQnVBSE1BWlFCZkFIUUFaUUJ5QUcw?=
 =?us-ascii?Q?QVh3QnpBSFFBZFFCa0FHVUFiZ0IwQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhZQVp3QmZBR3NBWlFC?=
 =?us-ascii?Q?NUFIY0Fid0J5QUdRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFBPSIvPjwvbWV0YT4=3D?=
authentication-results: synaptics.com; dkim=none (message not signed)
 header.d=none;synaptics.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26492c13-fae4-4bd9-8c1f-08d8607fde15
x-ms-traffictypediagnostic: DM6PR12MB4863:
x-microsoft-antispam-prvs: <DM6PR12MB4863B614DB72DFBBE469013DDA390@DM6PR12MB4863.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XROHW882jB1ry+wITXrZnTvC39OR/FofftpGLDLZ3PL5jh53uKgFdmxtmjGZQjoa1Gl8/DodVAJ5OUbIDYmzJaouCk/q1+tqgGSKiYxzieG4tTQOklfO4Ak02hVB+I9sEZTXlmtrcUg+q7ux2Td0hgzeUj16I/alLPG5kHtHkQLW5FRix0W3r5jvHs6a2xSxn4T7u/kf7YTFR4xKzkGymD83pHEJ9nLms0AwlSk+HG2LSPYq2AYXfe4b6e7+V3ccixjuOdeNA3/w0R0KE5uxVswf3cL2WZpvUdkRhgmxPpPLeJZetFT3ZVFpkwVJQBKI8BlqO0Ckw3xmEAWrL4usoBgCszIVtdehQOnd8YikdFsffsZInqOHzGjcGFSwjdbD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(54906003)(4326008)(186003)(8936002)(7406005)(53546011)(110136005)(83380400001)(316002)(7416002)(26005)(55016002)(2906002)(52536014)(8676002)(71200400001)(9686003)(33656002)(478600001)(66476007)(66556008)(66946007)(6506007)(66446008)(64756008)(86362001)(7696005)(5660300002)(76116006)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mwfJRi804+mEKBk54cQQTMQj5JFBHcu1qivx4s268AqkaOSs0hLtH66KO4JryoBOFXSwBZdrYYkRRo/DmK4eeuFp8XvJCWV+FRO7I5CEgYZSGn+daJrT6ibKJjjAw+csqpCYd3+dQTTTD0RghFuLmn3KmZa8aTjQDXDDDZNm+Bn54l4v0IG49mWGNoyisJxqhByYbzlKeUFLEnz6u9q/AvgodnqAEzyMquHVyDPktqMFHR+faxwjudsy97DWU7UM3g6xfvR8blC9xrP9SdtA5a7kxEUOgsyhPHsXX8nHq+HGzKJz9HZjXbPJMWPC8uBOdUFcyCKjdP9ljWH+V76124MKjOxe14kGw1uzQh7J+Ni17bOQf5aNWIYLOXsQS2HiM3kP3w9dXerbgjokGwcscR9aBoXmsGvLj5hjqmvUOxL+vNf0QnosdNrABmjqlPGgt+XZVsicPT9IFsmpJ8gSvVLqg8/HX/0/1xaJzMnHYq1qAVfv7i5ObjJ2+9w4+hWsmOFF5oGVfToUOvnZwdCb81nade9/PsNdYKF8VcLp4ZubI8SHvsZQHJ7Y2oK4z/OIXAsicLQaTOtSECnV8Mb9WYYhR+jfxe/7TzMMJm2ThithcOeOU6x0ij2BUKz91CtiHcja/hIpZvcXOrSpeeKBtQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1276.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26492c13-fae4-4bd9-8c1f-08d8607fde15
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 11:49:17.3623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anOJMG3qvI60Ejwva/iQJsOOB28P57eEo8x5fCm3+g7HnkeY0x4ZYkShHWphiAI4wD0EYy+vfTVqaocv7KKMVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4863
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 12:6:50, Jisheng Zhang=20
<Jisheng.Zhang@synaptics.com> wrote:

> The dw_pcie_free_msi() does more things than freeing the msi page,
> for example, remove irq domain etc., rename it as dw_pcie_msi_deinit.
>=20
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
>  drivers/pci/controller/dwc/pcie-designware.h      | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index 9e04e8ef3aa4..d2de8bc5db91 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -278,7 +278,7 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>  	return 0;
>  }
> =20
> -void dw_pcie_free_msi(struct pcie_port *pp)
> +void dw_pcie_msi_deinit(struct pcie_port *pp)
>  {
>  	if (pp->msi_irq) {
>  		irq_set_chained_handler(pp->msi_irq, NULL);
> @@ -500,7 +500,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> =20
>  err_free_msi:
>  	if (pci_msi_enabled() && !pp->ops->msi_host_init)
> -		dw_pcie_free_msi(pp);
> +		dw_pcie_msi_deinit(pp);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_host_init);
> @@ -510,7 +510,7 @@ void dw_pcie_host_deinit(struct pcie_port *pp)
>  	pci_stop_root_bus(pp->root_bus);
>  	pci_remove_root_bus(pp->root_bus);
>  	if (pci_msi_enabled() && !pp->ops->msi_host_init)
> -		dw_pcie_free_msi(pp);
> +		dw_pcie_msi_deinit(pp);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
> =20
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index f911760dcc69..43b8061e1bec 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -371,7 +371,7 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pc=
ie *pci)
>  #ifdef CONFIG_PCIE_DW_HOST
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
>  void dw_pcie_msi_init(struct pcie_port *pp);
> -void dw_pcie_free_msi(struct pcie_port *pp);
> +void dw_pcie_msi_deinit(struct pcie_port *pp);
>  void dw_pcie_setup_rc(struct pcie_port *pp);
>  int dw_pcie_host_init(struct pcie_port *pp);
>  void dw_pcie_host_deinit(struct pcie_port *pp);
> @@ -386,7 +386,7 @@ static inline void dw_pcie_msi_init(struct pcie_port =
*pp)
>  {
>  }
> =20
> -static inline void dw_pcie_free_msi(struct pcie_port *pp)
> +static inline void dw_pcie_msi_deinit(struct pcie_port *pp)
>  {
>  }
> =20
> --=20
> 2.28.0

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


