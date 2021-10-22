Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D926343736A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 10:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhJVIEk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 04:04:40 -0400
Received: from mail-eopbgr60048.outbound.protection.outlook.com ([40.107.6.48]:32514
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231923AbhJVIEg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Oct 2021 04:04:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oky6NrpKIETQBznugviXN2970KFCFzR1vDIWqCNnLlHh6onMWTOGaWByIV/x90wxaBHwmIEgadlay8RK/37hT3knpkRpXzKrmFnymMAUOGGIJZKur2ldWW0Qxq+tbhmlh9QPZHKcwjXk7+1Y9SMS1B2DIs9djScQhD1ZpMc+YEf89Vv6954iXldsG+VzMuk7h64JVcRr/lK+vM5zAekZS3qiNpNvyusm8GtkIGpSPMPnEENWt98L/15q/y15zj5eXwkm+dJddRd/kVcbXf4Aw/LM4eCuKcdCcRBvqSr73eM9K0H19u7uvCr+hLe36DGUYxreO4cYJkB0Url1bfFzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx8zvenTk6QiU+PX/SuIBW9KcMVeWMux7WZYEVf3u64=;
 b=QMPfXhBSWaOAGJGr9rCCegDZib+1Y/ZWXJ7GZBnApW5wb/89v3aGEAmw02zNb2JPXFk6elEvuenRaWGnPe8xEmvcL92la9yC2Sf8se+lm5HUAIE1AoiHTA/FqKA8UJX9094mlDd+/FJ8oDR/6gZNqpVs3tgRAxuyn2pjk5u6riUPfYLD1MxRk9Upk18EavB+TN7a3Dv2tdZtjDCBAvGlRZ8i7sAZKVmdCs2VQTVJitYyGviEXdan+/jrLfc+XeJMSanbGvWMggEu790M+2A0EPon3mnlf/SNsKKLeLUaxtK9ajLkXnwc9PYB/GAx74y/oLJkXeGK3yksjgvLl9Ooew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx8zvenTk6QiU+PX/SuIBW9KcMVeWMux7WZYEVf3u64=;
 b=mQNb2BTq5pUzpjni57ugCR5q3vw4OT4PFT6h1NtZrPOVGL012u70vQpM+pJjgukPVo2Y1jKaZnzgL8zjw5gJwcF6KKJckrI3OnRxQJgEYJIM6Gq66n3wMmvA4qeXW2kVLnp6lspqNBBSDszcQ5o4T9HGKScHAazba2/8yAvsgbI=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8451.eurprd04.prod.outlook.com (2603:10a6:20b:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Fri, 22 Oct
 2021 08:02:18 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 08:02:18 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
 unbalance when link never came up
Thread-Topic: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
 unbalance when link never came up
Thread-Index: AQHXwY4ue+QOjCGA8ESB+dHo+5+VOqvUZ7iAgAAAjYCABY9dgIAEuu9Q
Date:   Fri, 22 Oct 2021 08:02:17 +0000
Message-ID: <AS8PR04MB867697359A6D51903D0098308C809@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20211015184943.GA2139079@bhelgaas>
 <20211015185141.GA2139462@bhelgaas>
 <AS8PR04MB86767ADAB5021E1C320094148CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB86767ADAB5021E1C320094148CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d914d962-466f-490d-12e2-08d9953244a5
x-ms-traffictypediagnostic: AS8PR04MB8451:
x-microsoft-antispam-prvs: <AS8PR04MB8451A2D0BB448FCA0DC052198C809@AS8PR04MB8451.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ic2OeVmCDpH4L4RUiRzUlmp4d7CxWjEb2oEJ3C6d6wAcsy2Ftb69evuaH/iVwTV/db9PvFjHvi4pLMSUBd3BONZ4Sic1ss4JvDSdWoXplnNLDYCcyqfm6Lvxq86wfFdRz5uTdpAPXr78znNSYnWoddsvgHh4hYyJw7BCk8ZM/a+gpwFRbFKetIBQedHehP/hyFRmdYazbDq2HxtqEJDcopHPImqBQu+IuI0vqOVtignyHn3EVGjMHVVDWLyotNzCoWz3mLal0My+Q6mPsXQuDAR3GoAKnLrATt1i2ZhNja0RMdUIwI5JUJq7SXHuxgI8EGWE9DP9atOEqwupskbjNcHstjMyCkeWeEwk4E1tcfAHWel7m2ryAgYRpHcsltBeraPuV21DqOGcl0ompL+7b1JwUyNcmFW2KXXY+E1h4SrqrFgFMRh0ADdJPkrd/KTj3CAM+nEHlFwOvWByY6OM2MUDWDdvPjbyElcvpBDrWjM0pFgs5UyFn5y0ZeP6fNqF0aA3mMvGxmUAOSy3ppn8prsyzIMa0G5N6OpZIFQ9e2Y5gzlW2r0aox6tL94sQJBjMzjJnhl0GhtYv4ZXGQ8ch+CsVfag2E2b0CQxFe2xvN9yXJZeHOdwoiCBBWtidJVGPlrY9Tz2JUGSXZzB3/kKj2Y8Dfi6JcCtICOIaCaQFCeRxRIXU4Uu5wbqqKqHpQDrn+t1DIsBoBrr4p8tZdzceQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(6506007)(9686003)(66446008)(38070700005)(71200400001)(26005)(52536014)(7696005)(186003)(122000001)(76116006)(38100700002)(33656002)(508600001)(66556008)(8676002)(83380400001)(64756008)(2906002)(66476007)(55016002)(54906003)(6916009)(66946007)(5660300002)(86362001)(316002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sqZIhH8cFDSCZfHkOTA//yY0cWqTQKhsceeVG49L47QexQyo6Oqhlun3bkc6?=
 =?us-ascii?Q?itGt5o9YJKov/vd0M4hDXpTw0eabR3OBmKECJW3zT4Ucz5OBdvvT17cpdZKk?=
 =?us-ascii?Q?nqukc9xHrbFhjZWGQTmfE2Hfy0Vlu9DEYcUfpYi5QmeNBik5rfGoplHkCI93?=
 =?us-ascii?Q?deRhlca/WmBI7LxNI+Bp1hgw2tE+8oKo7ayAfEW/Nc7q+OqnFGCmxKaARayI?=
 =?us-ascii?Q?f4TW+WjE9IZGySr/pcXt9RcGE6XVOLyOY+CsXyb8EdmfbcDWSM7F7u6SWv13?=
 =?us-ascii?Q?crtsJEZfOqF9KmLHWYM/vBN64H2ZHZnANbt60qsL05d2wA/EGrzdHtn/l+0J?=
 =?us-ascii?Q?5xRupdU5gvZDG4A2MKznfLgsV8l+MxyDDaMne54NuT6a+MbinUebgC/DCjDB?=
 =?us-ascii?Q?4m54ANua3bCCfh+wkwio+Ob0msd4ozM1R9HbCJU+GtiGGuwmYz7O/O/PL1Xk?=
 =?us-ascii?Q?1brx4Wn5rCBtFq3Hik5T1erUBISkkYu3JiDWAi5I8o4KfRgybjm12vOPNX2i?=
 =?us-ascii?Q?jsJ+8vDyKpAnl3Eg5ylJ/qlw8Pwk8eDvzbU0axt8LR4fUQK0ZX5j5/pzRfLZ?=
 =?us-ascii?Q?tnL/D2TUuLGwhn06SqHaSE0ypmpMF8GyIyIX/uyJo9ikQuAX4fZPtdV4gOAn?=
 =?us-ascii?Q?DB14Mau/5Q77Lup70X4iS+Pnk6iMqjlEUBLyi3Q3fJkRmDkTa9SV2Cojmdkh?=
 =?us-ascii?Q?Qq5wLJGcPL+Gld/LOWHhWEgaBzUSdvcGpO4ex7ENIiuZqkcwxlAH2d/dBwMc?=
 =?us-ascii?Q?fXQEKfKCZbPVUduP27VEsuY1nVxNwpPsErjjncK+ILWT8hxtETLDNP44Wx/9?=
 =?us-ascii?Q?DhSoI4i2bsclCPhOunw4jwA3YeIkdF88nXutZPA/gJQR6AnDaTStcxUkXnIj?=
 =?us-ascii?Q?6Vv35hXVku7ucnqLLXBhj0I4+nnkb6GPCB0fjgsNl166idNAkzKuLCEHA+VA?=
 =?us-ascii?Q?fVIli0CvC/J6j7TL67nXGQBK7Cd1ntm0OEZrr0jg3vq4PXXo2VHTuJtQ03ml?=
 =?us-ascii?Q?dLzYPE6eZ7ZydYSjVQcniucFfb/Z+Tt/sI/B1BM8KJxjxxIVmBHfyw/JiQEj?=
 =?us-ascii?Q?dtnlgfWxhEGHKzQ/0JMYSPywsIQBoXczUrWZtU+Gpk0Jx8EqzYF7caqFfrUo?=
 =?us-ascii?Q?wa79kEcVh1LjsggM45JJpreFKpKN55EhEZlRWXfele0f8gzgyq3FjlCrk3rl?=
 =?us-ascii?Q?jgMNVx6OoAn0DEIKbdrVRtaqQcb6uLkw8v2HSUHEj/ngjOGQ/cOt/1ylOjXk?=
 =?us-ascii?Q?XaTJrKcyj8B8Ocj9m7ugUcRu1iAiYZqt4UrZo1S37ppK/3pwi6Z9CiexTnUy?=
 =?us-ascii?Q?r+GUJeSg7434wVZ6D5y1kmExnMNVGrnjHJJqqm6FseAKUrVVgmIqOe/13eqb?=
 =?us-ascii?Q?oYte4BmEFd0xwQPWywf0s/GTnLxHBnMC58TQaBhWyrJZnzMag+UPTnpRKnFx?=
 =?us-ascii?Q?hAmFVmc4JPc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d914d962-466f-490d-12e2-08d9953244a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 08:02:18.1212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hongxing.zhu@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8451
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

<snipped ...>
> >
> > > > -static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie) -{
> > > > -	clk_disable_unprepare(imx6_pcie->pcie);
> > > > -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > > > -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> > > > -
> > > > -	switch (imx6_pcie->drvdata->variant) {
> > > > -	case IMX6SX:
> > > > -		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> > > > -		break;
> > > > -	case IMX7D:
> > > > -		regmap_update_bits(imx6_pcie->iomuxc_gpr,
> IOMUXC_GPR12,
> > > > -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> > > > -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> > > > -		break;
> > > > -	case IMX8MQ:
> > > > -		clk_disable_unprepare(imx6_pcie->pcie_aux);
> > > > -		break;
> > > > -	default:
> > > > -		break;
> >
> > While you're at it, this "default: break;" thing is pointless.
> > Normally it's better to just *move* something without changing it at
> > all, but this is such a simple thing I think you could drop this at
> > the same time as the move.
> >
> [Richard Zhu] Okay, got that. Would remove the "default:break" later. Tha=
nks.
[Richard Zhu] I figure out that the default:break is required by IMX6Q/IMX6=
QP.
 So I just don't drop them in v3 patch-set.

>=20
> Best Regards
> Richard Zhu
>=20
> > > > -	}
> > > > -}
