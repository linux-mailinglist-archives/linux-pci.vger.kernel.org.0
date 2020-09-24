Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D44277042
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 13:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgIXLtq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 07:49:46 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:43530 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726406AbgIXLtq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 07:49:46 -0400
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A4911C06FE;
        Thu, 24 Sep 2020 11:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1600948184; bh=014EpVGBfv2VMCkXzimL9jn4TRXp7tdrtfH67KofY/M=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=M3OuE6U3e5enSLN4NH2Eaw0JpQihbF+NWBFQQz1+NG2USKbAO4wa6OFOv5aoYjD+U
         Z7HSU/9hh/cPYEpq+bb0f+qPwZumb8FnY4LCDqDOafoI2/lrK5Qguc9BXjKWnJRBL0
         7ZR/NmFU2xfusXwMgLEieRGUwb0tWTKbokKkjY/vZ2IGui3Vmlld9fAQ0Ekw2HjOo4
         ZaC7TcMXOM1vHawpTafG/jfBuVk48Ey2heglvjGr/4qboh3Fvj2QDSXecUHkGV6OOq
         XdThqxKYQknLEkaV25aZoyYtE30TVFe0sp5OMClHRO7s+tp6TBfBNSAqeYxTmK4zjN
         UXIxt03EXt+XQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 204F9A0084;
        Thu, 24 Sep 2020 11:49:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 980C0400A1;
        Thu, 24 Sep 2020 11:49:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="GuRkXg/K";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2a8k5GRcsBPJa+GfKvgZNJwm4xOiw+L1cuhhkSBWqCjSVKdAEDZTnbYbJVEuW44NTjxUBs/G8qDpkvrqiePIM8WU+YZTAMxp4og0aTwas7Cw7NQg03e716EmSqPp0Jvexlef9Bqdtf8e2ymqtP2/KwPuW2Gaf7B16i3oNonVVLxthH3IKAsi+GUT9pTja/m//Q9HO7zF6QwwPlBhbwSIhaBQPyRnKpNSLCEq6E9Ubfox/4sJnj/rTtWpNujLFsTEy00FmDFrIdeqmTZZGijk0Ln7kXayydiMaKHowg+82HMONvMk5wv8s8wAGl4RtYbsOe9UIwRCGOWEnXyBAiQCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAgH6oKaun2YXcf19pYj2u01WiTDFmoS0nIpoFu6Avc=;
 b=KJ++5lWaORMlAdcwIqoUu0uGWYVJqeoJ+znda0mKVSgPXNxAscQY9IwtFtnVYXcSX3nJZab0En3FrsY1Zx+LQU5Gg5F8f7KkmBBAa6wmlJdAsf+NzZxMSLa+YRkNZNM+MmFAT9KB2NNbHowrcL8WM6/LJmxIC/PVwqgW7htTSGVH7C5jXf9cTh/cKle1jXJMOsRXt3Hukw9uWmoqO9kRy49h3MzpRrDVY6HFvKsh4AKfp+cQvKZg3HNMGhESIlygfEYAGjBZnGnwuq5KtcSIuHssVDK8KGoaYeeBZ41TDjV84gYO1Ls86kM3cUE5PNVjs6x8QyvOw7/2vSXgvD/RQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAgH6oKaun2YXcf19pYj2u01WiTDFmoS0nIpoFu6Avc=;
 b=GuRkXg/K33j53Py6IR7tjmrktrmOBSbrHfUy2KmBzK1hv+VeNks2TSyZjT8qwomXM8Obx7yUPDUs+s2oTkiIsYOHDb0+7uhfsouRgrHZDS0/odq2+ZV7LjWbqcS/GA1Lxz7as5vzxUi3ntWc5uHEJkjiKGPo+eiVH+pVXw0R6qo=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM6PR12MB4863.namprd12.prod.outlook.com (2603:10b6:5:1b9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.19; Thu, 24 Sep 2020 11:49:38 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::742c:dafa:9df7:4f4]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::742c:dafa:9df7:4f4%10]) with mapi id 15.20.3391.025; Thu, 24 Sep 2020
 11:49:38 +0000
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
Subject: RE: [PATCH v2 4/5] PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI
 is disabled
Thread-Topic: [PATCH v2 4/5] PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI
 is disabled
Thread-Index: AQHWkmNpCpWGgFFQ3kqjKgJyOhD+pal3rLnQ
Date:   Thu, 24 Sep 2020 11:49:38 +0000
Message-ID: <DM5PR12MB1276EACBFE1EEECC23BA0E51DA390@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <20200924190421.549cb8fc@xhacker.debian>
 <20200924190713.74e0afd6@xhacker.debian>
In-Reply-To: <20200924190713.74e0afd6@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTA0NDQ4NzM3LWZlNWMtMTFlYS05OGNmLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFwwNDQ0ODczOS1mZTVjLTExZWEtOThjZi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjExNTYiIHQ9IjEzMjQ1NDIxNzc2MDQy?=
 =?us-ascii?Q?MTQ0MSIgaD0iTnZGZHlidnhGaEdCNmVQalUrbUFnR1plL3JjPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFC?=
 =?us-ascii?Q?QnRwekdhSkxXQVdmZ0QzcU1zdEpjWitBUGVveXkwbHdPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 2b278ab4-665d-41b9-786f-08d8607fea98
x-ms-traffictypediagnostic: DM6PR12MB4863:
x-microsoft-antispam-prvs: <DM6PR12MB48631D0452329D4B00C810D2DA390@DM6PR12MB4863.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QLItCaiEk/G/hgzseKDWS5q631mnHbjp23/2JeUH9fSakPR5voee7NY9PuC73VSpW/r7PporK3y8dVk/McTGIZFiWhqxfBVQYEWlQmayVmJ8D6gClZaQl3aWWt1HrWKqpO9EP1TWw11IQnTepasyd8DU86SBlgrntx6I7DqLujams0twEYmJlhm2cNZKcHHyr5+oupNY71XSTPDvrMc/aPKkPFqVJpXGkkE5Er+Won9KDuSIhiusFnBZQ0EmcjRUBudm5qoljwFNV5kycJiNNGCixKif2Ad/25Q8nrAGTiLJyoUjAKZXfHbf4ZhE/CMEqtg/utwmVYjt8UWF6zaIIzTQir9WaGYmDzpqeCsEpxXThbO/b0ooORF8fm6eFk6d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(54906003)(4326008)(186003)(8936002)(7406005)(53546011)(110136005)(83380400001)(316002)(7416002)(26005)(55016002)(2906002)(52536014)(8676002)(71200400001)(9686003)(33656002)(478600001)(66476007)(66556008)(66946007)(4744005)(6506007)(66446008)(64756008)(86362001)(7696005)(5660300002)(76116006)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +f8iavAzUWzHg3R7rjdfkXa4Hup2FDZQMbdtjqLeLgkLRsXa4aNjT0rKpiv+z3slzu3aEHKRCh9FoY30RSGGbkvU69Lzt2LxrSLw4NEjoftCIk0tktBIGA2/ApRDpDiY7z9aNBVWg0bw4kHv6GkIQGN4qeUiEb89aQqBo3HY24FmDmmn9p8P7hxlzF0kroml28lQaq5l1hyo90iYAngoyvp7b1gtLrnGa8HgYJs0F7feqKfv5DTazEGBiZ62zjcekXYcTbqk4twtN2HIOeQoSl6lo5FYKFWMNqwnSx2/ImCzL7sXcJqei94eZif3nxq8N9bt6scQ/uKcF2x4L0itD7XN6DeBAQSEV5vBic5h+laxxjbeHrDnF40l/j5CV2UU+PWJVg8nf4C1IOmdgRL/3Lsjjw87teO+5G3HlI4pqR+H2sFjNQsIxdbVZTvCgjCzw0baDB/KQtDeuOXu0m28MJhPwefNCCB+iUDViJ0bCkpWjTIpJaWOLYOU/NYY8K0hQ54KSMhJNl+nbI7mV/vAzPqs7bUhWPUjiNFods2lf4CFf21OA46OC7VjOE6wkP9AOu8FVNjtxocUQv7dEAfmGXnm3l0AtJ2/EygA/u3pQzMFDPKeTbCo+jsGUVRwPJR0SFPHTkn3a2UC5PY6k8HTbg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1276.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b278ab4-665d-41b9-786f-08d8607fea98
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 11:49:38.3360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oPgHhAhGdrhBF/1g1b+ViKpGBj8KebGmQyluIPJnxR6cZMin4Kw64U1v2Ujn+DFfRz6SH3NalLCsG1AtNVWIIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4863
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 12:7:13, Jisheng Zhang=20
<Jisheng.Zhang@synaptics.com> wrote:

> If MSI is disabled, there's no need to program PCIE_MSI_INTR0_MASK
> and PCIE_MSI_INTR0_ENABLE registers.
>=20
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index d2de8bc5db91..7a8adf597803 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -641,7 +641,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> =20
>  	dw_pcie_setup(pci);
> =20
> -	if (!pp->ops->msi_host_init) {
> +	if (pci_msi_enabled() && !pp->ops->msi_host_init) {
>  		num_ctrls =3D pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> =20
>  		/* Initialize IRQ Status array */
> --=20
> 2.28.0

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


