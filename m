Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3540485F5B
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 04:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiAFDt5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 22:49:57 -0500
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:56995
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229485AbiAFDt5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jan 2022 22:49:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zzi9csfAYTS6yxiUnIhf7HTO5kvVPERcJf0NXzvlCAaPcmvKoD7A3BN5QLiw7SlCAjL1K4LgBNnlPq13zklG0rp4XR7g9t62JfIVp4dEq4isY1ca79mrjePp/iAAU+tI9VzXEAdwhp5QZDk6gadX1QlupkVlGyAhr/tW26gYPukECyzD35DqQHjj1XqPYiDhD+4PVogqO2cKN0A/SgRD+hTPd6K9HWuXK1nNDWYB+sjBMezs9BupvFyz/Q9pEWJfe8vJT/opWDBM35G3llHWIq7KGmFwHDYhPre+uF7EyCP1SHzqtSE2hHVM53pgAvY75SKGm/OmaVVPvoOzMx6r8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inCjppuPE9BsMNHuG8b0XAef4cSshUPjo2R9LbvjiR8=;
 b=OjLSHdxuQpQ6uTxzJUh1E406s8BE2rwf3YIkgdPIwDrmoYkob0DVwDlIPQYSVDQlE8vW4VvCjezJILoWVKGfEkVQ2Z6bhLxkSmfZqorULtgFn1mxz3xkLtzb/R1fX/Gkj09KWNYhTwA+GCGhDsjLAAqkbkioysMsBHnlpoHbu7Beu2eXH94yn8D8DG8gnqW5MLb7VF1S6E7YgVJb4RU5RJJibVE7ZY/8s3qyzQKG6N7+qehITkqdwcwIcPiQmIxNnisWzFmRRtV2cDADO94z49DQWnb3Ayd0krcKRoCVecfWtJ0cFEn6+moaJtv1L8ucTSbOOiUABieij2KHWew5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inCjppuPE9BsMNHuG8b0XAef4cSshUPjo2R9LbvjiR8=;
 b=K2F6C/O+TRG1RQvsnrjikpmJRm5d/Pzed35/zLtIKV1u8GBZnJP8SFgbweOHwo+zmZCI+pQzheaLRdghjU+GInId7ToeUGUSwXg2QcSC9dtM8dEE0u8X+e1S/JfxBELN/Ey7Fj8aR5zn+Ymim/bYwjSWBKcde7EKnqTxiTdJGGA=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS1PR04MB9455.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 03:49:55 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::949e:59fd:6098:6508]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::949e:59fd:6098:6508%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 03:49:55 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v5 3/6] PCI: imx6: PCI: imx6: Move imx6_pcie_clk_disable()
 earlier
Thread-Topic: [PATCH v5 3/6] PCI: imx6: PCI: imx6: Move
 imx6_pcie_clk_disable() earlier
Thread-Index: AQHYAgwMSPIaEKJlb0e9k5CvmHch2qxUyesAgABe+SA=
Date:   Thu, 6 Jan 2022 03:49:54 +0000
Message-ID: <AS8PR04MB867679F2DD3E130109E2C44B8C4C9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1641368602-20401-4-git-send-email-hongxing.zhu@nxp.com>
 <20220105190404.GA213307@bhelgaas>
In-Reply-To: <20220105190404.GA213307@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3839170e-a8db-4eed-9aaf-08d9d0c79a07
x-ms-traffictypediagnostic: AS1PR04MB9455:EE_
x-microsoft-antispam-prvs: <AS1PR04MB9455DFF94B0739920BEC1F5B8C4C9@AS1PR04MB9455.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /i42nLGryBYJi+prxmRNL8hqdTk2ZL5URrHAMpATi+kxnMnM4/8iYL8NoDkuJ7msnu/X+Bhvj9G/ZhPjB15GohUJz2hAh73k4dxEX7gpbqCtQ+GZYatMm2/c3/THG0tBohbnt5fNKdcIaYQZ4+pBjOybAxCY5ViznU7DO9tjW9dSG3C/erW44tm8b6ce2nCskFT9nGY7IU4fbd06DHM8hAaJTuPJfoY/XlTaOJcDFDerbH1PaeKCZJ7mB7D9Xis2QLJx9+9N/DhO81FuOyhSbNaqi0RGPZOfr/MTXF0h5EHYBk40LA6wbexzDBFfEy7BwtnH8FdSVq0ogr46du1LDLogNN2tRQ2Kjo6GExz2UjAGx0CzCKMZg6OQmsYUmhcOQRWUW1sx/+FomkIpgkMnfF3slMDh9NTH8dsMe7uF5KLBgh4JhkDWqLMGDzTbisX3jzpxRqlGfpGcrVQMBUE7tBRTtFp7A27mPsWD8o9tgqG1aNvqw2KTtY0ggFJYigaFX4Lejrxm0gs3moNtR5oi6J8j54cAEtSYTjfvXZ48XLCs8/nb4/FRdQRTyhsji4/p7LwkasUv5TBT6M9Jesr1U6/gLHJM3swVFmGpJSyS3hFfuIxCNUhzvuQXvsCBfSuilLIkJXCxH71rno6RVOjg9Dj1aHYb/hTUWdXEQyQTPhUSzdGwAYZnPiPi9SktUdo3v3gNEhYYuBlON9z4XUjoGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(7416002)(38100700002)(508600001)(6506007)(64756008)(186003)(52536014)(66556008)(316002)(6916009)(122000001)(9686003)(44832011)(38070700005)(86362001)(8936002)(33656002)(55016003)(66446008)(76116006)(83380400001)(4744005)(66946007)(2906002)(54906003)(26005)(8676002)(7696005)(53546011)(5660300002)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oUkZwo30s4A/C9E7+wIfJ/nEo2Im1kQGDNTVTG1JwUA7FqTFZCcw63Mvi2S9?=
 =?us-ascii?Q?ZPNvwd8jWVavszLkYvKfk3u79SQYX24CGwhwa9n4x7AAPCZrWjG33DgXtl6L?=
 =?us-ascii?Q?eN1ZScTmQmMJHxrRJxbUEcB8ecxKHqyW9iD00RdxGCMJjEPzrqoGl9H360lZ?=
 =?us-ascii?Q?iUIUb/hHtbS8MsXOj8NhjHFBi/CKihI/slRTJSoQ5er63z/GrP70imCR13FM?=
 =?us-ascii?Q?YYxor+UT4Gevr4nL7VI55lq9xmduwsuGLkOoJPXtrAVIniIDCg4gZWgY5Hci?=
 =?us-ascii?Q?iXzinMFfTTLpnnHX+/LB8IcFUS5w4xtzF3Ht6Vt7oGFHCpEmrZZ5MZQXkGRh?=
 =?us-ascii?Q?SjwXwyFShy0iXIWOtsmJiWLKlKUxUaxIKjHjvE/Yuy/TMezil5nhEaYOqctY?=
 =?us-ascii?Q?ZkSSHNG18u9eqS0/FSvur7s5NkpWHW//mDdWjOWGWxL/96f0rnTE3ZJqBF2I?=
 =?us-ascii?Q?Dj9YlyiTCisN7OwKDg7buygoNjWxDaKoKOY0FApvcUwXD3WaYt0il6rjJX+H?=
 =?us-ascii?Q?vCYTyvH08acnDvsPCLCU4yRLLeV2gzOwyoB/lbftPQB2DousDzeyA17rzqJg?=
 =?us-ascii?Q?Or8iKB9SpS8a5It7Dnw4yIRlHRcKWNJsvLWWstEZvovfcACOIU0PScLwNNoz?=
 =?us-ascii?Q?xyM7LUu2yqOlTwnABuri7IrV+JY9NECBoZk+OSaXRAbFX2cMPhL0AAnyGKOb?=
 =?us-ascii?Q?P/jC+/s3YKybvVszfdA9HE3ST18HuRsd0hQ0YkDtZdg/ANptbwODeaDd1CpN?=
 =?us-ascii?Q?GE6Dv8h+3y586kGWZmMyEi976lo/cdln1CnvfaK9XQ8NvZpsMERMUvUTSiJH?=
 =?us-ascii?Q?62hlmfKgKQawLtx56X5RjG/WcFM4GlpBWAFOCOyqaq11U8ZGNWsrD4c2TUnP?=
 =?us-ascii?Q?7y1SPSzchQ6RCgkIoLz+3Dim09J1Ah2z8siAuCANiC6Wx3wpQOBUbAu4e3CM?=
 =?us-ascii?Q?ugX3hpRqVgTtyHoXQOFGHk+z9MW0+Cbj+Xx0i3xz7qd3cSoc3FckgDp+GD35?=
 =?us-ascii?Q?P1wBeAJNNBXadH7rvuuu84a6wB5dG3+TEMXilZ6bQGkrW52ipza2Pneu9Ifr?=
 =?us-ascii?Q?U764DR5DIeHtsKBK3J/Z9vyIcQ6lYHORzVYMYZreKHtU9LBgvSCF6QEqaT20?=
 =?us-ascii?Q?ADUSJyIYogTK5EbWvAtfQqeAzyMzUX8QJgLJ64kx26GmmSHXeoUTisaCprMO?=
 =?us-ascii?Q?KH8l0kYDI6QU3ce1VRSzcnFmyxQ/Y7cNy/BpnpY0ef+pDQb7Nr3XecCz8cG6?=
 =?us-ascii?Q?IZ/SgjYCpn3jUU8QdURLeK/tCNb40B7wIF2xNBQGsWMpR1BKLmsjyXfJn0TN?=
 =?us-ascii?Q?2LhR/FNJIxzMA2JTY8iPT1kKHOjdvxWWm/QbHEcPcuzaqbkJafrcH/qVGaaM?=
 =?us-ascii?Q?VLmAHoJcHrRb6KKisr/VpV3jMaWgVI/BUYL0b/hEwbATktMwTY5CciMvI3JN?=
 =?us-ascii?Q?iIBTmbERHEO5Th3kIpTNiBpttLIHbKlSVSnujBqYy2NlkCeyTx1Z61O8PQz1?=
 =?us-ascii?Q?0aYrpHPmeaxYlPXt6XEczpu13H95d1z0biFq6qt9lxqnotUIBQpfbx+f+V57?=
 =?us-ascii?Q?IgFm7001pokXb0s+8wtj1+XT5NS+mRDOJh6DOoIeyAUPUrdKzWrSX4IEq0sW?=
 =?us-ascii?Q?Rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3839170e-a8db-4eed-9aaf-08d9d0c79a07
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 03:49:54.9488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MCmbe8QXrUcBGUovVQ37XISiTAE4OLN82QTOASm9rB1IG/dB2vIwZNWtH/ZW84e20F93go1uibshPxszVUQEvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9455
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, January 6, 2022 3:04 AM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> Cc: l.stach@pengutronix.de; bhelgaas@google.com; broonie@kernel.org;
> lorenzo.pieralisi@arm.com; jingoohan1@gmail.com;
> festevam@gmail.com; stable@vger.kernel.org; linux-pci@vger.kernel.org;
> dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; kernel@pengutronix.de
> Subject: Re: [PATCH v5 3/6] PCI: imx6: PCI: imx6: Move
> imx6_pcie_clk_disable() earlier
>=20
> Remove repeated words from subject line.
[Richard Zhu] Remove the stable kernel mail list.
Sorry to add one edit mistake here.
Would remove them later, thanks.

Best Regards
Richard Zhu
>=20
> On Wed, Jan 05, 2022 at 03:43:19PM +0800, Richard Zhu wrote:
> > Just move the imx6_pcie_clk_disable() to an earlier place without
> > function changes, since it wouldn't be only used in
> imx6_pcie_suspend_noirq() later.
