Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0C3444CC3
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 01:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhKDBBS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 21:01:18 -0400
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:63299
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230509AbhKDBBS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Nov 2021 21:01:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LN9xbAvbxTYWTkjCxSb9oZPJ3l+DS+jUuDoUjrqiGTHAhG/mV1lvBdKc1bwXaRPrlw61qxIeRGIK8cujPii5YH3JJgzqSTFtFZhqmsuiTsc2vctfi7FznwjHt7PVqN37kC/hKTKNjoRDci/lEJPI2uSkurGk7XQMDkm9YXpLRhlQpwaMQEfFMqwip7JEJXrM7AuQzc9rs3T9qdQkTBgjspkRwzjS2Hke0ye5T9T+5zIntNyxUoZP8zy/yk4af2vsgZXICCW5KcT1EVu0iyxPJZd4bX8q9EKVeUUluFHMEKBou6Zdan5U55Ldvyrpo7LM0KSxPGt0gt4dBF6Kcxa77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evWehDQ4BmtZANBLqbVI2yf2cVo006NQxjgUTej7e1w=;
 b=mC7HAZQy6uNd1Erkfj6Kwo3vIW7CHGmgA40gbYHJT2qdW8f9rKtz+qeXasw7ipCa4Vh/Ry+DdWnJcUhBNK1h1WDn8Er5fl825zPlx39fcM9edvWIEvmrRoFb5XN6gDdcMTSyqHfzWWev7Wawv1DZj50LJ9nWhVVARjPD/zYNyfpW2SPKv9lAFy8/LCYQNDRZ/l2gUjk/iH7H0DHwZ19Xk/IvawgzC/EFrNDjRkhRg3qbtXwvN1FRxPjPr4lyi9nt6sKvwpKNMwKP4J/4UWzPRuuM+xVNHyuSkIOxhdtX2SLp82Q3vT+8c8Fl0nJpFdyhPcvZEkY7gvW2wmdtUOgmwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evWehDQ4BmtZANBLqbVI2yf2cVo006NQxjgUTej7e1w=;
 b=R2Nf5fGPhGM6JecT3sQZrLTo4iqfjt/Yzu47G/uQ2z34vwrQSPGetoodH0r/rKR8D0OvtHR60poNyQn3B0AVtyk4E1Y7zQ+oqwE8nyynOp65lxxhl6HDbZP5Aw2Zhil/H0tEA0ZKpQTVTnslvJsaOC2ap9odwVyth9+gLMGFzNc=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8532.eurprd04.prod.outlook.com (2603:10a6:20b:423::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 00:58:38 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%6]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 00:58:38 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI: imx6: Allow to probe when dw_pcie_wait_for_link()
 fails
Thread-Topic: [PATCH] PCI: imx6: Allow to probe when dw_pcie_wait_for_link()
 fails
Thread-Index: AQHX0Q86pmFTFD0HQ0+vlkapkYarDKvyiKYA
Date:   Thu, 4 Nov 2021 00:58:38 +0000
Message-ID: <AS8PR04MB8676C527C11B6E0BCB455E1B8C8D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20211104000202.4028036-1-festevam@gmail.com>
In-Reply-To: <20211104000202.4028036-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97dadb89-1035-4e6c-d987-08d99f2e3ccf
x-ms-traffictypediagnostic: AS8PR04MB8532:
x-microsoft-antispam-prvs: <AS8PR04MB8532CC3C1EA9089E876210A38C8D9@AS8PR04MB8532.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2JEypuRGYpGXswys9n4p241EcPpt5/gJO3bxAqGCx75VpLy2nYPdkwBIcdIDY/IZ4OpvmfTgdmxyTSyHODvPRZudF2/4byQq+8YvwrLMt+Q1TTMiqu1w3AwF/Bbr1ya8EY/7kKNeERdsq+3kieDXoGyFSRsRA+bZHvOoxHep7/1qlL6fKo8CTdgAaGwMDshobrPydPdwCOIDTaNZs/ju8LJt2uaRp+7FO/xmPYFvjBKnndXwrHvlvX6an1dye642NJUWfNI+JI4UgYwPHWWnOGZtgkOyoEGXjj+w1h1jjgVzrXNhyhzTKBwhjuOBSXId7yB30jmtXUY546dO1aOAu2ful2paNC+BFL9E1ugd1SasUvnlTXDaQJCmXiRhx0CpGtSBHFnbId7HQ7rw2USHQfQk+Fnqb2vtkjb847R83MlW6qYa2PtV1GJMOeOMaSbCqxzVJAxD6ZlaLCzj7TrvVrOQmfmzds8YS8qhsh+yFC8+L4PcGsueJKJ3qwqIZAvl1gKirizPTQXLKBEDapscLsgaX8WN1u59JePOvHxjNGwtEd8KOKDP9kdrv5nfdi8NmrfUPJCfGRIMTV+UOqMItaqgCTZRnGtx1b8KazcB9SHMGotRIasdBVcN7ogSx4ZfNfg2YgEHUmF2cgL7d/yDsnAbS4vpXvkJZ0NhPeBQSFqdP2iAnxfHJLCrrcGEmv74IxSD3hI2gBkjK8/dnRGcac3cegTuPusgxaz2rn1RWlgTd2nODRtjlwxtpV9doVmL1MzIfDjO+of30YabXWhGhTjtcTN+tdNif0hZC1wMTSc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(66556008)(64756008)(38100700002)(5660300002)(66476007)(45080400002)(6916009)(44832011)(2906002)(7696005)(52536014)(8936002)(508600001)(86362001)(122000001)(71200400001)(9686003)(66946007)(26005)(76116006)(186003)(8676002)(4326008)(53546011)(6506007)(33656002)(83380400001)(55016002)(38070700005)(316002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UoR299I4vA0LvxOPB0l/ozrRj+B3YLzydcQJtfsycLv97s31xlBTT8TJ5dgo?=
 =?us-ascii?Q?aob9FdvcY908utriLKymF6YeRJe0CIakorDWphwjhtOvOy9EVhVkpYCJ9WeH?=
 =?us-ascii?Q?EwruOHFsC3BU33E3GkUNJLhtHcpv8VL9Xm5gJMfjLj+W8k0MrepDZL+3LAxv?=
 =?us-ascii?Q?xcxk2LHhz6HIW2YkXi7/QQ8tcjTO7OG534Vi69M9k5iG2HdBbqpp4pMEjnQH?=
 =?us-ascii?Q?hEDGHgKNhqiUIxzryKOB1SWh6I8qSwsD5jQcSvCVTZ8J9/R+uW7tU9A+z00Q?=
 =?us-ascii?Q?PTrGopXP2t9e5Q5lh8x97zCnnudSVJUey9YPOVUtNBwuhvefkI0ThVUCBD0x?=
 =?us-ascii?Q?NUSTa4WJGKMDVB2TsnSWHoqZ4afGvlwj6gBGiv+PauuKtm6GJXCjV3x4qOdc?=
 =?us-ascii?Q?ifC3rJQAlJX/pyf9uaOrb1rg7BZdmULCncBMJJiifJPdHHi0HbKccaZWIZUa?=
 =?us-ascii?Q?T5M6LxmpdHZ8f1uXbGeDqbUl0rHDuQFhy49HIw9R7zGF78xtITUWbh1HZQ7G?=
 =?us-ascii?Q?hRiDpBw4xM96+WTxNUoCQlTCVgFRJKQmijUTU/ZiAaWTYINK7PV96wstp3/G?=
 =?us-ascii?Q?ybuv3wKwDqgIG6Egg6GJamX+KqFzaONf4+WUqr/g/dWMNxPWI4ylqzMLxVzC?=
 =?us-ascii?Q?gapz5ecgLRLrDWOUeSsRZJOz99U7oF43ROZucLDkb0GMBzwX9zK+HulUJpic?=
 =?us-ascii?Q?d9TGAHzmiTacd3as5RvPnwhsUNkf+J/2/bm3l3szf/Z3nOpHdWuFFNyfgXdA?=
 =?us-ascii?Q?T3f2xD33GKvOxgRCXuw2mPhF047CK2lY4GuznkT0S0F4qjmKZkVAw9TF/wKd?=
 =?us-ascii?Q?xtqrY9kTNPra0IgRYDwcpPm5PB/WJMjctrCfPVxb/8VX2SVSuqOld3jfOXvH?=
 =?us-ascii?Q?vH+/ULlSsL0aexAeZfzWuhUIOOyTu1b0vSSTk/DNF9kK2iCa1AIbETdT5Pj+?=
 =?us-ascii?Q?nJkbv+TtdtQQg4UmFxDKWOV2bQnNReIPMOAq3Q5QH+vvkcw8yOLinHz5GyBI?=
 =?us-ascii?Q?Qn7h8aJp2ttrElUF4TgOm3E1Rf9U4cd91FIFrARDVMSPUMsWgR97BM5ABY4Y?=
 =?us-ascii?Q?YdqCkGl/n8xm74U6g9JrGHgX9A73qZJzV4YxzGdFYxcZncKXPlFAdc62zB84?=
 =?us-ascii?Q?lHcH0VXXPhJVB03QiruDeWI4lBEv2BUT3xL8ZiDzwOnpvdJtBRbWA6Hgs4nS?=
 =?us-ascii?Q?g9I6SuoPHGE39f8HaYzWQkZYUJ0VEO2Ya97UshAkcl/qpGr3LIW99jy9RkXR?=
 =?us-ascii?Q?FieYx9PRWwGBYy2ETZ9oOLpwow7dBadUv8xc4NLju8rGWECF4ElgvrvlWOwD?=
 =?us-ascii?Q?C/rs8IdSl4X6Kkou6unc1LS5VhRDRUmNYaZVFMT9N5GD4J2cvWM4p71cRQPP?=
 =?us-ascii?Q?qUkgAzM+Uo6xjsAE5J3dzMAoVCMUgHGrjVhcy4NL3ytb5NUdRvWqTax1ebMi?=
 =?us-ascii?Q?ZbNVEUPrKQxUlMoXVSewtUpTLzcb+kCDfOqEIpvdlQ+QLVDo4OyPxANfMeus?=
 =?us-ascii?Q?YUy87lQ2zOayOibvlduVr18pkaD6eRETgjQ9SBLWhYd21KofzsER7TNPaiNw?=
 =?us-ascii?Q?qa8NkckCk/KoCJxD0RNF3413imzJI4X6p78bxh5S0bVWYupZ2jGq5RoZQJs2?=
 =?us-ascii?Q?8A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97dadb89-1035-4e6c-d987-08d99f2e3ccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 00:58:38.6216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vvelhxmbyfs+SVZzrE+kwkrox/UzT68bGWFTpNAAlOjP0PHZDIjXH/jlcL/YdKTmoIbBJJPIZij1jGyYY1P4oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8532
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> -----Original Message-----
> From: Fabio Estevam <festevam@gmail.com>
> Sent: Thursday, November 4, 2021 8:02 AM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> Cc: l.stach@pengutronix.de; lorenzo.pieralisi@arm.com;
> robh@kernel.org; bhelgaas@google.com; linux-pci@vger.kernel.org;
> Fabio Estevam <festevam@gmail.com>
> Subject: [PATCH] PCI: imx6: Allow to probe when dw_pcie_wait_for_link()
> fails
>=20
> The intention of commit 886a9c134755 ("PCI: dwc: Move link handling
> into common code") was to standardize the behavior of link down as
> explained in its commit log:
>=20
> "The behavior for a link down was inconsistent as some drivers would fail
> probe in that case while others succeed. Let's standardize this to succee=
d
> as there are usecases where devices (and the link) appear later even
> without hotplug. For example, a reconfigured FPGA device."
>=20
> The pci-imx6 still fails to probe when the link is not present, which cau=
ses
> the following warning:
>=20
> [    9.199175] imx6q-pcie 8ffc000.pcie: Phy link never came up
> [    9.208701] imx6q-pcie: probe of 8ffc000.pcie failed with error -110
> [    9.216214] ------------[ cut here ]------------
> [    9.222057] WARNING: CPU: 0 PID: 30 at
> drivers/regulator/core.c:2257 _regulator_put.part.0+0x1b8/0x1dc
> [    9.232411] Modules linked in:
> [    9.236201] CPU: 0 PID: 30 Comm: kworker/u2:2 Not tainted
> 5.15.0-next-20211103 #1
> [    9.244086] Hardware name: Freescale i.MX6 SoloX (Device Tree)
> [    9.250284] Workqueue: events_unbound async_run_entry_fn
> [    9.256067] [<c0111730>] (unwind_backtrace) from [<c010bb74>]
> (show_stack+0x10/0x14)
> [    9.264258] [<c010bb74>] (show_stack) from [<c0f90290>]
> (dump_stack_lvl+0x58/0x70)
> [    9.272245] [<c0f90290>] (dump_stack_lvl) from [<c012631c>]
> (__warn+0xd4/0x154)
> [    9.279969] [<c012631c>] (__warn) from [<c0f87b00>]
> (warn_slowpath_fmt+0x74/0xa8)
> [    9.287882] [<c0f87b00>] (warn_slowpath_fmt) from [<c076b4bc>]
> (_regulator_put.part.0+0x1b8/0x1dc)
> [    9.297273] [<c076b4bc>] (_regulator_put.part.0) from [<c076b574>]
> (regulator_put+0x2c/0x3c)
> [    9.306122] [<c076b574>] (regulator_put) from [<c08c3740>]
> (release_nodes+0x50/0x178)
>=20
> Fix this problem by ignoring the dw_pcie_wait_for_link() error like it is
> done on the other dwc drivers.
>=20
> Tested on imx6sx-sdb and imx6q-sabresd boards.
>=20
> Fixes: 886a9c134755 ("PCI: dwc: Move link handling into common code")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
[Richard Zhu] Hi Fabio:
First of all, thanks for your help to care this bug.
This dump is planned to be fixed in the #5 patch of
 '[v4,0/6] PCI: imx6: refine codes and add compliance tests mode support'
"https://patchwork.kernel.org/project/linux-arm-kernel/cover/1635747478-255=
62-1-git-send-email-hongxing.zhu@nxp.com/"

As we know that the hot-plug is not supported by i.MX PCIe. i.MX PCIe would
not have any chances to be functional after one link down.

To save power consumption as much as possible, we should do the error
 handling after link is down.

Ignore the the dw_pcie_wait_for_link() error, PCIe would keep consuming
 the power, this is not friendly for the system power saving.

Best Regards
Richard Zhu
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> b/drivers/pci/controller/dwc/pci-imx6.c
> index 26f49f797b0f..bbc3a46549f8 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -779,9 +779,7 @@ static int imx6_pcie_start_link(struct dw_pcie
> *pci)
>  	/* Start LTSSM. */
>  	imx6_pcie_ltssm_enable(dev);
>=20
> -	ret =3D dw_pcie_wait_for_link(pci);
> -	if (ret)
> -		goto err_reset_phy;
> +	dw_pcie_wait_for_link(pci);
>=20
>  	if (pci->link_gen =3D=3D 2) {
>  		/* Allow Gen2 mode after the link is up. */ @@ -817,11 +815,7
> @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  		}
>=20
>  		/* Make sure link training is finished as well! */
> -		ret =3D dw_pcie_wait_for_link(pci);
> -		if (ret) {
> -			dev_err(dev, "Failed to bring link up!\n");
> -			goto err_reset_phy;
> -		}
> +		dw_pcie_wait_for_link(pci);
>  	} else {
>  		dev_info(dev, "Link: Gen2 disabled\n");
>  	}
> --
> 2.25.1

