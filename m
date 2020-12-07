Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050522D092D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 03:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgLGC0d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Dec 2020 21:26:33 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:22156 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgLGC0c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Dec 2020 21:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607307992; x=1638843992;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=R7aMZAti7JDketCcpRA4uiwTUt/V4fcn01FwtoZOmTM=;
  b=pzoCPXZi1K+MGQurW5ReltYGA7W3r2TpCDzN+BLNCk1B15N7F6CKbXeF
   uM58z9hZ/RMTDRpAFQ2aj+/NRBAqK7gMj3VfqjywBsMyRN+ysopxgN8zP
   DbzSuDMPGK5VQYVXw3GC9Tsez+lTNL/kWe0nVBLQFRntrxAksZ5eSFx01
   GChOlZEsCcOQ0EyIa9v2+RCVBjbnqIzf1fE5WCPUyz/1TNidneN+Z+20t
   hQCY0+DYc1+5txuZTX/XVLhCGzAuZcZv56ebtSXCcFueQ9F2LtqdgIfyO
   1sNgcnq1aCTu6uH+RKh/jMR6seDWLAY2xPXuFwfMHzAdgWOfGxt9CaDkk
   w==;
IronPort-SDR: TEH7yrfP37BbfMzuVFcvh/qME2mTjluJ8prRll//wAwDYFsgOqBa6DFBfnBgh2w3gxSXpU4mGw
 yDYUm9g96gaY9LpzHhI/C3y0/NIA/tV/ys43B+wueEDVZHKtVNclZiMJHiLp4lIOZl0k37FIMz
 h7E2pTmEOdDnGnY8UH2TI8dSS4do4MTGFi4C3NZZZwjys8LNiS3uRxMq3Mj0i8LosJMEz/cCGq
 0C1VHJmVwPnz4/rdFnxpG62BNX6fRQCogUKN7FHi5S6iqxHAbkoyXT2a+//YE3SCXHla/1NZba
 9DA=
X-IronPort-AV: E=Sophos;i="5.78,398,1599494400"; 
   d="scan'208";a="264715147"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2020 10:25:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUOKo4252vplZX+uLLO9t9EtsXmPym4GzctWql8FfYGTDT/mQ2iglrWQhW7YAgJyGVbaUr8hfmN2i3yWxn1jzh1WYDgt9jGzREWc8aO/EaaB01Hjy3/0ZyocmVvovuzpJEnBrWexA6cK9vQdIYoiNxSqJFfnzK7gC16qkxTJZHO6QVukqWnpqsrIqhoLFzSAFreFmqrS+lh3Zk8r85pCOj/wXnyhGnoSZlV1EHQc9V77jj4o6amXzgffbTrjw+zdsXwqrsu/8DhXl2kpdSV/YAVIkqrVWlbdJVRpU7tQwFu9J979UF5u9/y6YZ2SNafC+oxkpuKHEnu/liqRneD7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0M0Cl7R/OPH5vO0DfO56QXDqpC3+qbHnSD0grhHfufs=;
 b=KLh0wDLpaBZYlnHiI0VSN2QU6f9zZnECxVaAiJVqvx0MDVpCzbLQ2bcO9jGgt2zC83T3HB+FPZgWfIgDuQq31fUoJ+sCYrrvTRyJDxpdkJMwyRerZHqM9HQwlPbyTma081OOSUi1Ir2rH9QEsyG5FtcX+vFBXlorctEtXmvOfpcc0Bf2Tx+6b1Kadzb7TtoZTK+udFSp4tOZa19odtoGAHVZvdPbOk+wL4n9ZWAkjki1VCDU/SywC3Zf9Puj2Ezltq0GinY3jsfDKxbGJEK8N3Lb+nMNBnn3IQfl1YPHz36MHUg4RQ1DCts4dxe9uF77g3Ig4RrA5zcYdIM+zBCfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0M0Cl7R/OPH5vO0DfO56QXDqpC3+qbHnSD0grhHfufs=;
 b=FWJXrB9AVAUi+9D0/2ZScNZF7EI372pjMbrXlbKy3OUuIYWJjcWTjEvCaBovDMm/RVmvqPvycW7Kux9Cd44EBBOSxlnMEdxKbrMeaz6qTyVg+696NNG94vGFj1dG3VMoIT7135JevsV4HhhkpmbFj4dxW8wyG7nDpJk1JvCvMvw=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6903.namprd04.prod.outlook.com (2603:10b6:610:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.22; Mon, 7 Dec
 2020 02:25:25 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 02:25:25 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Puranjay Mohan <puranjay12@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] drivers: block: save return value of
 pci_find_capability() in u8
Thread-Topic: [PATCH] drivers: block: save return value of
 pci_find_capability() in u8
Thread-Index: AQHWzAgLm3ME/cQOmkKYlxTZoYgM2w==
Date:   Mon, 7 Dec 2020 02:25:25 +0000
Message-ID: <CH2PR04MB65226012BF740A12FC754ED6E7CE0@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201206194300.14221-1-puranjay12@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 526b8ba3-da0a-4691-022f-08d89a575b3e
x-ms-traffictypediagnostic: CH2PR04MB6903:
x-microsoft-antispam-prvs: <CH2PR04MB6903D299048A51872786DD9EE7CE0@CH2PR04MB6903.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Hgo0IrU8F9Jv9Q2b0ZiF4aYNRHDDQbIisdnA9/qU8nnVedosolkACNngqGyswvg/be7A14G8NUpH9QZYF01oRfsebaDEsVFBjYb0sADKvJ/eso/OmrKe+D3De5qUGyxS1UVps3nR+r3Lkx7pnSGYr0AwCs6Bo+ISqFDJFYywmMIfcaJPNQtHbfYQHK7EDY6BXFzsSFGPA2GVxr5diPiQ/86Nv4BZfXQ05dm4yM+l8zryJtYf+So1nXtOhG2FIWIjXaFiUO/BmH8tXXvS9nGdEDEmy9o3AnxhcZ9PR9/pxJ4s1OpguTSZGr88e1reIV2Lb4AfJqDrZY42nw7T0Ocuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(186003)(55016002)(33656002)(5660300002)(76116006)(6506007)(66556008)(66946007)(66446008)(8676002)(2906002)(52536014)(66476007)(7696005)(8936002)(91956017)(64756008)(26005)(53546011)(71200400001)(83380400001)(9686003)(110136005)(316002)(86362001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bXzRXwmioLW2fWmaqVptxwQT7KSmtpw1kLN9dsjekVKAJ0H/nutf8q91SDeY?=
 =?us-ascii?Q?CX+dEYpT3Ll5QWrpR+iMavXQSwjj2tLDb/4sYCbQQbUn9IrEyamU09AthgnJ?=
 =?us-ascii?Q?N4IhkQhUp5ukCBkrR5SRG67u8G/vAVsCXzRXSLoKnxObKGGvtXDHuP4eWhRJ?=
 =?us-ascii?Q?cA73QRN7TPdcC8PndTe25G+dDVwuEgGsz4XGksnDWz3otYi9qpM9wJJQzEBQ?=
 =?us-ascii?Q?AHpSsmgIMoZnz0qRywv0piKqK0gR+dHPgdIe+iU3uUJkbLx4PNmdMrKNqpxj?=
 =?us-ascii?Q?qxUwH0wD1n4IiAvZSs5MZCeurpBthTy0Gp+gYDImznwNXtwSBrAgjsD6fmXg?=
 =?us-ascii?Q?aRA2EDOfZAhyiXRkUG6WPtFnYH0akumRAhTGpW+C/fNjaTrWWpg5OZ3KperI?=
 =?us-ascii?Q?tzi94llcNUS/Qr7Xqa1EMgS+i1R5Lm0LE8ftlaOvwN9+IgQTsFKA5d+xuOSq?=
 =?us-ascii?Q?Au2+DwEos9cITbFFJpZN65UciywBpUvJBAFIbjPDofM3jCAdD9ZY/yt3XUCr?=
 =?us-ascii?Q?heywG2dCLf9Fx5cV9Z9K20omhoX44lpFn9dHjnjijCdG8U0N8wwqkzhknii2?=
 =?us-ascii?Q?W6hmM/e7RXG4A6XJKZncPjvasbK8qgC6V5rZQbuj7a4b1q+3qNvHixUSyQco?=
 =?us-ascii?Q?rfuliT/tGBo2J1/9OlpT04RrViqONM7E+VjxCw6jl9lx1oDOG1m5NswkHMMl?=
 =?us-ascii?Q?fdSCV0A/erBkGTLHy8gx2bw3qxVwAR94prR09zTzPO2fOJsDY7+IVtfFO9CO?=
 =?us-ascii?Q?9ulzb3tU92fer2vNNZMuCr5rrws9thkfX1PCNSAxL02BMpDbiFc2OUiA4JbU?=
 =?us-ascii?Q?fkkej3+UmDfZSIEcbqORUMnvmeUgTa/TcuEXmtcbfMsaiAHibODQEZMsoEBO?=
 =?us-ascii?Q?ZV2xuyc2/UpqvUSvGcHScEG76CPXOX3YlM8m/+CPUB0j0MyLEKqWkv6VvmpS?=
 =?us-ascii?Q?inCsuEbzOePajdiT4W4JJwwSSSuXqe93qtM3HE+7gZe7Bbq0uFuFgMP7WYPj?=
 =?us-ascii?Q?+QxY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526b8ba3-da0a-4691-022f-08d89a575b3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 02:25:25.5781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 46JOQJrvmChtyW3fkrku0BBy/RITk30TwP5lYWueraLsc8tsWSQAcKdq4IlP6YhXtNlbK0CJFCKrqMTfXlMt/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6903
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/12/07 4:43, Puranjay Mohan wrote:=0A=
> Callers of pci_find_capability should save the return value in u8.=0A=
> change type of variables from int to u8 to match the specification.=0A=
> =0A=
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>=0A=
> ---=0A=
>  drivers/block/mtip32xx/mtip32xx.c | 2 +-=0A=
>  drivers/block/skd_main.c          | 2 +-=0A=
>  2 files changed, 2 insertions(+), 2 deletions(-)=0A=
> =0A=
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
> =0A=
=0A=
Acked-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
