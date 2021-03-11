Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07ED7336C80
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 07:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhCKGvC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 01:51:02 -0500
Received: from mail-co1nam11on2047.outbound.protection.outlook.com ([40.107.220.47]:38311
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231328AbhCKGu4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Mar 2021 01:50:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXaHlJA6xy8BbMBzrH72C4TY4xe9Z58itqAzAmoSUj63MRGOs08XVaulDPQLLBWAF/UVVeFoXFfU41/Biiy6VKSlvsiwDdB+DHL8Al2lreMMTsA1WteNgzBzn8L3K5S222V9WyOQ7P3kRvGiOcldzbdmzKhbNSTcwYFupiW145GmWg/uN9EhiNLTVh+/73U9vy/Qo8jN637SbBMA5ISKnw1XNpVyFUwxwGTxI8I4UcA7Q81IuNgq75xq3mtYr9/bSN/v8S2Y/y873AvydMHBaHWTHJJRPQ6UShMMgRMxTNXoML4CXZYSrQ2j+4iFDd1xR9K3ygzHzP0aseGFJQ6e0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXZBm8Ahpu6/AXps41NEnsLlvP7ufeJ4B5ghnHg6ap4=;
 b=VkqpDGHIbRI0xtQrdY2MWJC+eWc7VO+MBEWmethr8QJ2aPxHisHf1Du64/hOqNMHjbNiyYVuy3VOSs6VDeXnAFj9vgd6GhWznh9RUplElb96BjaoesmvUTembn2veVszkqo86dXviuRqEWMb+0aSeLk/wLKJgM8uDCIodppz11vTbdFHvIqAw8w7oQLms6kIlaRY3CWocKkFt+0s+5+2vI0zagvoFyHFOqIzuHtvymoXNpLBnwaB5adJMSTkhpvw50f2IJZa1eR/52vzsckIQgnsTVoDdQzGKG2Kya1BG8NrRcuN1CcXl6U0X9N1hoKdoiYbo2LgF70GseOeOdsETA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXZBm8Ahpu6/AXps41NEnsLlvP7ufeJ4B5ghnHg6ap4=;
 b=OGlbhRFspa9YmfkWs6FrW5rBrOZB1BopBAY5IehAAO2b05vvL5sW7xdUL0eFZ5wj4cKFTo08qo/6zwyluqCxlukQNJt0IktWokjGJZ3A6U57l21R1kOhuK3zjLAQ2J8yzV5v3g+d3L3/rSnlKM7IIBexd7n6HylzI6AhrMs7kpA=
Authentication-Results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN3PR03MB2307.namprd03.prod.outlook.com
 (2a01:111:e400:7bb1::16) by BN8PR03MB4755.namprd03.prod.outlook.com
 (2603:10b6:408:6a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.30; Thu, 11 Mar
 2021 06:50:51 +0000
Received: from BN3PR03MB2307.namprd03.prod.outlook.com
 ([fe80::246d:2f3d:93bf:ee56]) by BN3PR03MB2307.namprd03.prod.outlook.com
 ([fe80::246d:2f3d:93bf:ee56%4]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 06:50:50 +0000
Date:   Thu, 11 Mar 2021 14:50:27 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
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
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 5/5] PCI: dwc: Move dw_pcie_msi_init() from each
 users to designware host
Message-ID: <20210311145027.58f3955e@xhacker.debian>
In-Reply-To: <YEVPRDt1By8TG9O5@rocinante>
References: <20200924190421.549cb8fc@xhacker.debian>
        <20200924190742.76939458@xhacker.debian>
        <YEVPRDt1By8TG9O5@rocinante>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::21) To BN3PR03MB2307.namprd03.prod.outlook.com
 (2a01:111:e400:7bb1::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0136.namprd03.prod.outlook.com (2603:10b6:a03:33c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 06:50:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdf97653-b3c2-4657-c850-08d8e45a0201
X-MS-TrafficTypeDiagnostic: BN8PR03MB4755:
X-Microsoft-Antispam-PRVS: <BN8PR03MB47552C5D4FDDFC79B66D68B9ED909@BN8PR03MB4755.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CVCP7/lF/iqP97om8cFjn3zGh8BZYPQ3HTFOm4juYjzx23azX8BqHADHU5j0MWyRudsCS7+y75aGQzxURx5fbZsrAu46RIIBKHfPLacCh6uunGSERGghy1ASScDFl2TCKmhx2YGl35bMPWad0OLfQLnu9RUctQAFfMCbbGbBdZq+Koo69MZi+5S4b78miOqmltr3EG92i4MgnDF7XthtPwi8hlj8tj2vUbjxv9dH51A/b/cjKkZcf7bC4qEw9FetEyBYRWyQC5gVl+w9QtsUh26LYzUNu1ksPuQv9miUiCs/p3FRz/A4zWTv3TWUBY9k47XWGBE+djh8uZ69L0hlBAIkKIs9A5FKs1RgdzElFP+oQpD/ws7RzRv7jKoXP7zIh8GCSBz4lU2xIe+unCjIRtG3WLazCMUJgnFmOAATU5mzegWi/kTfz/bXmcxqiwzI8pU+cEF9ljg8bVZldm5kUNeTRQnLw7VZ9Y2EQ3Io2lroeSfPtmJ4XT/EmLUJSjTli88UsiprPVLkdbbYkhoxpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR03MB2307.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(39850400004)(396003)(2906002)(8936002)(86362001)(66476007)(66574015)(83380400001)(6666004)(316002)(54906003)(66556008)(4326008)(8676002)(7696005)(186003)(7406005)(55016002)(478600001)(6506007)(7416002)(5660300002)(1076003)(956004)(26005)(6916009)(66946007)(16526019)(9686003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OVdIVE1JYXEzRm94UEJObFZXd0V3ejNxTWxEeXlITEJwd05FZFdWL2ZlcGJL?=
 =?utf-8?B?SkNNWTVPb1dueEFUcHdaVjk5ZVREN0pKbFM2eklHY0F4cVBabFVMRTJWTWZ1?=
 =?utf-8?B?M1Z2bXVmVmxCcjAxaU5VM0t0TlhYdHVxQTJqSmptWFRuYTY4bk50S1BMQjhM?=
 =?utf-8?B?OHJnOW9XdWNXQjBVZC9WZUtiZkk4ejBNRVBJcEFBY0NXbHVHWEhkRHAvTnha?=
 =?utf-8?B?ekZrTEFjUkR4ZjJYd2ZteXF0K3djbkFDb0pXd2tZTDdNdm9acEY0TjNqUkZQ?=
 =?utf-8?B?Rk5xdmpNdDBPVFUwcWdxR3BNUGhhMHdMMytRTk9nVnZDMkRmTEZIS2VBaUVz?=
 =?utf-8?B?V0M0RHd0b2hOYlR6Mk9USGVEeEFLd1M4aUc5enJpVWxlVFI4dktWTEdVTkRF?=
 =?utf-8?B?cmdGdkpLTHN5M3p1dnE5d2JrZjVsT3R1NzJ4anoydDYyT0ZRRkp0QTB2U2xL?=
 =?utf-8?B?LzR2NFVxVFExN1JtNXhCdUNGTGJYaWRHMnBoNEd6NFhFK3h2ZFYvNlpNY1lV?=
 =?utf-8?B?S1FXVURjRFh0TVVFazdmMFIvV0ViNitCN3JZR1p1Ri9YUlU3blpOY096UG03?=
 =?utf-8?B?d3VETmgwdi83emVtMTFZMVp2WHk5MzdCaitlMXd1eWpRMWY1L0NDVm93VkVx?=
 =?utf-8?B?dWEycnBXazArQ1hWTkVmMUczVWlnV1JzMFdIUy80SlpCL29SQVRjakZ5RTJC?=
 =?utf-8?B?aXArZDMvYmxHYmJlQnk1em11NmxVTDhiY09reUxvaEcwRjZ1VUVVL0V4NVZP?=
 =?utf-8?B?ZjBkaFpla09ueWY0N0lrckhXaXBweVEzYk1ZQUVCdm1tZzZvYis0YWFuc3Br?=
 =?utf-8?B?Tm9YWFVEUERvc0ZLcjByOFZ6a041ZFE2VGFMZWQxTnh1UHBLU2t5N1B3VUJz?=
 =?utf-8?B?cHRZMWQvaVE4VDltd3FoZU5raXBmeUxFNDQ3N2cwNDQ0RkNTQ2RRQ0xmVFUz?=
 =?utf-8?B?VEI0ekF3Mk4wd3JUbDhOYldPaFlaOFVKY0Z1bWJkN1Z6OHhHL2Q4SmFIbDVQ?=
 =?utf-8?B?RnZHNDZDSk0rc0JjelhkTWcxc0MzL3JNdkE0N05qTFFuWlNkVnR2c0RMa0l5?=
 =?utf-8?B?eUYxWkJzYUUxZGIrZzhYN2FLZ3ViKzBrSWVySC9MODZnTFBKSjkxMUhBQUgr?=
 =?utf-8?B?R3MyM2FkVk9iWWR5WVYwbXE0cUZyVk05M0lhZUVsV2VUdVlkRWIzVzZqNjJt?=
 =?utf-8?B?TXNkVG9ZVDNUM3U4WHRVUlhaay9Id2t2V29sYjE2V0syOVZkWTYvcGlSbmxB?=
 =?utf-8?B?eFhxdUF4VEZ6NkdGaWE0OHFjTWpoVXBMZE83cjhNZHJaTVJMV1luZ0ExMTNy?=
 =?utf-8?B?Ukk4OWQ3MG5RbHhSN3hNMEVPN0JKcHphckptUHhOYlN5aHllVEhTTVNGZ0pD?=
 =?utf-8?B?V0ZHSlM2QjJXcXNZaHl1NExTZlJqOXRCN0tkRHExNWFDUkRCZ2NRVCtCL3JP?=
 =?utf-8?B?VHhEZVFMVTdhOTltYWNtdkxTcXNZWjRlKzFYTm5Pd0tsaGlXaGVuQ1VFVnFD?=
 =?utf-8?B?MXdMN2FxTWVhMnFFZ2ZHdTBKY1ovUk5TUlVHVWYrMkhYWW45NWozN0l5THdW?=
 =?utf-8?B?N3pZYVc3Sm1vajdBYnRTTVprY3lkSVdDWkp0Lytwa0d4SHMzSlZCaldpZUtj?=
 =?utf-8?B?eGhLUUhGQ1hEbkc2bWlKUmJrOW52N3dVTElJSmxVbmxwTklJTmQwV3FjeVZQ?=
 =?utf-8?B?ZE9TNVBzeTJGWlpPNjRYVGRIRS80NFBtUUtmbFJ1ZUF4dXNFQ2JKVkZSbm1h?=
 =?utf-8?Q?xKAMHqzH8xliUpCajwSr2wIzuaXJw52pmby4v5A?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf97653-b3c2-4657-c850-08d8e45a0201
X-MS-Exchange-CrossTenant-AuthSource: BN3PR03MB2307.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 06:50:50.6635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWJ4ofTe++Lcvd8ZMOK4s6RAJrCG13IXWiA6aUdT/FkU38y1lLYSzy9L+HL+ZGGLwK1c/0n6r9RNO7A9ZXbrSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4755
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 7 Mar 2021 23:10:12 +0100 Krzysztof Wilczy=C5=84ski  wrote:

>=20
>=20
> Hi,
>=20
> > Currently, dw_pcie_msi_init() allocates and maps page for msi, then
> > program the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI. The Root Complex
> > may lose power during suspend-to-RAM, so when we resume, we want to
> > redo the latter but not the former. If designware based driver (for
> > example, pcie-tegra194.c) calls dw_pcie_msi_init() in resume path, the
> > previous msi page will be leaked. From another side, except
> > pci-dra7xx.c we can move the dw_pcie_msi_init() from each users to
> > designware host, I.E move the msi page allocation and mapping to
> > dw_pcie_host_init() and move the PCIE_MSI_ADDR_* programming to
> > dw_pcie_setup_rc(). After this moving, we solve the msi page leakage
> > as well. =20
> [...]
>=20
> A small nitpick.  All the "designware" should be "DesignWare" both in
> the commit message and the subject.  Similarly, "msi" would be "MSI",
> and "I.E" would become "i.e.,".  If you ever sent another version of the
> patch, that is.
>=20

Hi

This series was dropped and useless after Rob's excellent dw pcie code clea=
n
up.

Thanks
