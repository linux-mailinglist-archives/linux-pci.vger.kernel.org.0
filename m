Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB6A2D07E1
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 00:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgLFXJ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Dec 2020 18:09:26 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40857 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgLFXJY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Dec 2020 18:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607296163; x=1638832163;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1k8V1osH+oVHBkUkAswECaHIRLWqO9Ufb9W7WqqfMSk=;
  b=bSMIHHkaC8dh/4eCYbl119vlv0Pg0PKAr9VPvwWthEsfqKwzfEkP8CzO
   0/ZEjGP9OaZb2NuXIs52PAvoqIBD8endciXwQFj8afXp7dBFIEvmcqhkH
   ElIoBXiEvqKF7tmgnkQuQNGYdM8+GAKH8Q1DqcpwTZMpBvid8BA1+wREE
   j3hlID6n7dnG/EsyTXcWEgcyFmWPd58xBcmeFx3ROSt75r/e6jUJzLT0k
   SJqrJ8QQ5poNErtqU8fDWJR+OTCrmCvN/mDUEuyRt0TOTJ3ecj60/1jPz
   /W+bjlCIaymI10Uxf/9tctkkpdshi2bSJ/XEePPKuLiZ3/rSVc7QRb6dB
   g==;
IronPort-SDR: nz5gJlRl8rN0fkk3IWX9xS0oTBtMVlPoyDKj5PoTGWxzcj2Y765/li4XwlSYGfYL6PaD4S25Xk
 12TePJ2bQSOfJsdkiv9p3YgOG3uk8VZinbM6ovFEJypIEw66OgybpEKQvEZ2/5zH5AImhB1gaZ
 GT/fbfEKmLSVJv5CPNPk6isWFAXmX1gILH8TQz0zE/Z+ANMmeVz3vykYPvxds+YfR1y9aVyML+
 xFPvbojVlB4oMujdXURl47AVrQHbwtBnztqetD36rbBtqUa/q7mSnpNI7zqGpqu314qksX6rCd
 p5Q=
X-IronPort-AV: E=Sophos;i="5.78,398,1599494400"; 
   d="scan'208";a="159012881"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2020 07:08:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcSYrBCStbJNDOtfU9nBDb91T5wlwgkJf6H1AuXKhWBmwvzikiDYQVNoR++9B7OfPBrWKscw8Eyo/YVsEx7fOXZJXq7ofCpX+/dy58CzQ9YurPFtmZpE70nZrl6xrqKIqz3h1MSUnMnyH7WQkCkWBcJ2VfE2qQyp/1Z1MpQEuHJFHdSgiRnH5RycjBlUY1wFrtSpI02JRoB0x4oy5x4syfBnVI6icBLYDhJsQeQ15FX42xzPxnBdpVbBif4rrfg7qtJcYK8kLOhnERbyjQtoj43bTX40psmLG7o1uDB6kEr6N9p31jhLhhY0lJ4N+Z+0dGke2IiD8hJuidVz7ccmKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzytcC6nKgftMs/2LCWWrKxTTpVy/3Q/h49qN03OyV4=;
 b=lFZClRlyoroL98pQLk6aJqB8UkGd6XFO+C3DwIi9i0TjXLrh1Il62GRp7i4gfNn2jcAa8BtPgprjIn+QPTFu8lcITlCOOKbMmd6elLR3VwZZAkOR9G4vpKkVk2NBiSEmT3xOm3zd5OsTkrhZHnQJIwQTyNAdse6+NxDTck5AGa/GHal4ip3T5Ln1eewHZ7nPTvbNL/CtT/2ROUX0OLNgbWuumaGlIIMjtslTfufSkDbwyXRAWCFGLlSkLmRNyg3K2C7bIdIHbLz0fWO1/B+F073P1m2d9xG7BngTctpwX3seVEBzkI7vMW7rieHDHPoNlHCEq92uZH742zi211oVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzytcC6nKgftMs/2LCWWrKxTTpVy/3Q/h49qN03OyV4=;
 b=E1mwZMTPgfIePA3P5itxE1gtm4VpALyTAJEezGQUtYf6URnIg6FYwsGLV2BXZJ1nR3kTtIquPrwv3E97yl1viFlPviHGtREa9GjEK/aHIMUyd9he9Ns6hp/rOr2SCXBBIekOvDbitxDkZd+HUC3EnlZIX6LiB16MKqkcMXR16Rw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5336.namprd04.prod.outlook.com (2603:10b6:a03:c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Sun, 6 Dec
 2020 23:08:15 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3632.021; Sun, 6 Dec 2020
 23:08:14 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Puranjay Mohan <puranjay12@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] drivers: block: save return value of
 pci_find_capability() in u8
Thread-Topic: [PATCH] drivers: block: save return value of
 pci_find_capability() in u8
Thread-Index: AQHWzAhI9dB/zhTwEkK+svNTv+xS0Q==
Date:   Sun, 6 Dec 2020 23:08:14 +0000
Message-ID: <BYAPR04MB496516ECEDBE667B5813460586CF0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201206194300.14221-1-puranjay12@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32f8555d-fd3a-4d0e-0cc1-08d89a3bcf6e
x-ms-traffictypediagnostic: BYAPR04MB5336:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5336B4D457EBF69D7026341686CF0@BYAPR04MB5336.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: REV5QNqLF5A7wTAnRVgI2M/tIC1C0brv2A6QNvFeelSGAmClck8kQCjh0P9N7sEQXVzprvy8GOzffwr4lqR4aSzrceGLBYfd9c+t2mQ6XtGGUkyytli3yQnX/eQWbod/NXYn7RsrfoyUrwB7n+Mg+OWB3qOvHQd6W28OX+NombvWURQJPcgsPloswdhq2Y3WKwmSznelFXbJ2tGGqz90xww3+ftKaQPcTGpyUEA5YK5aIW0u5/WQrynpNn5QhQHYJjGsWLbemtDmQvriHmf0CMEDukd4T0K/nOWittm3ex8UYgsXB0E5v3dYRtaC/jdeSjgW7OfUrkc5jCHFMPKLLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(66476007)(2906002)(110136005)(76116006)(9686003)(66446008)(66946007)(5660300002)(66556008)(33656002)(8676002)(8936002)(26005)(55016002)(186003)(478600001)(7696005)(316002)(6506007)(53546011)(52536014)(71200400001)(86362001)(83380400001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ChVCLgjsL5amKV0II+oxkCkGLbKpi+YptIU1CiIRmmOq6jQ2PvN21hB+eNGn?=
 =?us-ascii?Q?5XPZpuLqGnKx8yHtdo0RIEZEmxBpTYzOa0AFfxnqqjF5IeKkJu1D4B3X8QRd?=
 =?us-ascii?Q?qMB3q4Og9F2iEpbgNMisADz87kcqr3HmAYu5fKox5JyTivph9vXiFf/OkgLe?=
 =?us-ascii?Q?C0Gsa31iaMyFBPTKSfoSALIqFM6tScHKTYBW75Xz46J2G9n6KCivqyl9UT4n?=
 =?us-ascii?Q?kDwE1+DKQpV4CQY0j+DCISbNmE1jeCmDjpcmW6KremcvatiiO4an0H2YYuoH?=
 =?us-ascii?Q?HqxOzFzr14vcGUqn3moemNz8084wGd9mOeNkX87+AuHD7Dp+ArrOXE0FBMvR?=
 =?us-ascii?Q?fNd+bFPXwveTLTa8opkRQm7dVzPpSJtH6T16uYNHJNB1to20xhJXTpLvM1MO?=
 =?us-ascii?Q?5+GVdCqBPfQrFoJOo8BrwI9MW0mL+4VCRr8AiZIl7RUnN9+8Q+1GTJwJc4tY?=
 =?us-ascii?Q?roEbfO6g69muZbqUucDo4BtGYd+CwV4YuQlbopawfmrEm5X1n7OiIr/0WSDM?=
 =?us-ascii?Q?nUTWbRhI1K5Kt+8ORl4Z9BnJg3eJKR4ai55uOh6wTr66wEvDJifMlvujQax0?=
 =?us-ascii?Q?z8bl3kak0RhoN6KtV3FjysVlVDZKq9ymqXiL02sp7twA5FdNHh9UJCaZi0tt?=
 =?us-ascii?Q?Y7OEKZ6f6CYhDXa+EqYR2ddYSlJLnuLpvFC2qioMYg6qe6CAkxGjGSfdzhcq?=
 =?us-ascii?Q?Z26YbRmZW052XMYbepjKRvGY5xbQcAR+Ncstwr63gRciumntDwEjRgsHj1lh?=
 =?us-ascii?Q?J/1IQmSTrUUXWn3qG3LYBBq+Fxfkayz7juwRId50DIa5CF4deHJ0AuUA/V8y?=
 =?us-ascii?Q?WavOelW+Ij6EKJR8icj7s0yUGtaMRQjqfJZMDoCLW2GP+FExsqRetXLZfFYv?=
 =?us-ascii?Q?OXCfwl6nFb3fdooxr5IuEwVyfU2OmU9ftt3kllVpLMWiFzlS9pe3eGzfluUI?=
 =?us-ascii?Q?Tw8uU1H84+taBK8+sKa6f2vQpaliYou28SedXUvg8tRLboTlpTE12abmjBjY?=
 =?us-ascii?Q?farl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f8555d-fd3a-4d0e-0cc1-08d89a3bcf6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2020 23:08:14.5070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhQy9fql5Op7mvbkqdBRht+p1ewL62T/8E20TjlvBmdycHE3m3E49V2xXtpWpc/rMFYYl25Hy26xfndP6RypjxJvWOaUetk5T2SJ3pK21o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5336
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/6/20 11:45, Puranjay Mohan wrote:=0A=
> Callers of pci_find_capability should save the return value in u8.=0A=
> change type of variables from int to u8 to match the specification.=0A=
=0A=
I did not understand this, pci_find_capability() does not return u8. =0A=
=0A=
what is it that we are achieving by changing the variable type ?=0A=
=0A=
This patch will probably also generate type mismatch warning with=0A=
=0A=
certain static analyzers.=0A=
=0A=
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>=0A=
> ---=0A=
>  drivers/block/mtip32xx/mtip32xx.c | 2 +-=0A=
>  drivers/block/skd_main.c          | 2 +-=0A=
>  2 files changed, 2 insertions(+), 2 deletions(-)=0A=
>=0A=
> diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/m=
tip32xx.c=0A=
> index 153e2cdecb4d..da57d37c6d20 100644=0A=
> --- a/drivers/block/mtip32xx/mtip32xx.c=0A=
> +++ b/drivers/block/mtip32xx/mtip32xx.c=0A=
> @@ -3936,7 +3936,7 @@ static DEFINE_HANDLER(7);=0A=
>  =0A=
>  static void mtip_disable_link_opts(struct driver_data *dd, struct pci_de=
v *pdev)=0A=
>  {=0A=
> -	int pos;=0A=
> +	u8 pos;=0A=
>  	unsigned short pcie_dev_ctrl;=0A=
>  =0A=
>  	pos =3D pci_find_capability(pdev, PCI_CAP_ID_EXP);=0A=
> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c=0A=
> index a962b4551bed..16d59569129b 100644=0A=
> --- a/drivers/block/skd_main.c=0A=
> +++ b/drivers/block/skd_main.c=0A=
> @@ -3136,7 +3136,7 @@ MODULE_DEVICE_TABLE(pci, skd_pci_tbl);=0A=
>  =0A=
>  static char *skd_pci_info(struct skd_device *skdev, char *str)=0A=
>  {=0A=
> -	int pcie_reg;=0A=
> +	u8 pcie_reg;=0A=
>  =0A=
>  	strcpy(str, "PCIe (");=0A=
>  	pcie_reg =3D pci_find_capability(skdev->pdev, PCI_CAP_ID_EXP);=0A=
=0A=
=0A=
