Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A0D6FA332
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 11:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjEHJZn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjEHJZl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 05:25:41 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2092.outbound.protection.outlook.com [40.107.113.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987891BEF;
        Mon,  8 May 2023 02:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOAUH2b/skp0fmyz/OHyHiv+UXbYood1XcAo4uDT4AqnIhVxv/IEhUs/+2ESOceZDNcNEudhKJz91vg15XQ8O04/DguHabFWj4Sfn6r/PxpJFUwJ8aWHMa5vEXL2+rOwJltfmgxnU8kF1uB69D/aFEmfgnEy10MLxOUmhmrWkQjkS+q6nAWGHjJDfb9GRa37in+yBPt3a3qgVNN3s71MYVccUHolwRjrtHHD5WC1P5lbyhYFMMaSs3dW6ek7lelxJQo3kr4AmKaNoc15V7ok93TD9C8tfRITolhCF65jIV47c71QsN8d5i0unDBNVO48RaSAnbGFCsHmwa1F4Cl45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ji1LxIX9l4vjExo5DDKs027/yoMsscyiOBPCgu/dmxY=;
 b=DdGV60mW6cw2uvKFMTek6yoBdYPizSwd7Yx7q4TZjfGH2x3Ip/i3v0yPGqHX3qYrbyxWQAL5/ojD8PdSJT4Mjvtj6N3AeXTKTTA7IoC7SS4QFDHOUEIVfHFq+Aq85mHMZDCaWdpDeVdhTmKbROINgV0XHqYEC3PN/BleElKI8vqT46H8wfH355DKxtWrBxpMGeNUMJpG+HdtlGxYXs3y1Cjn0XQwXb1dGr/fXAtu4JJZm85+6MWvp3qnzl5zivR/LfGeAcRGWyC81qi6s3G5fhVosrlCtl3yILtPywIt1FXCfzMbJH3pu7+JEHVvRKI4oDKR9n0fCxqEGBldTQB+8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ji1LxIX9l4vjExo5DDKs027/yoMsscyiOBPCgu/dmxY=;
 b=F8VTobY1swtI/oEttpBXnUucALlQDGqYVCGXonpPB1sJcvomV9po+ClZL/vw6FXR5GQwIDwceSUD8MfGHMkqA2cBMUaZk0qgBSw6j+GqutA0bLA/j3WPHTskZbnfMSTdJBZVFqc/D9Luzo9mu4DWVW2+pQcsp2J8fjDmXIUII9Q=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB10283.jpnprd01.prod.outlook.com
 (2603:1096:604:1e0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 09:25:35 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%7]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 09:25:35 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v14 11/21] PCI: dwc: Add dw_pcie_link_set_max_cap_width()
Thread-Topic: [PATCH v14 11/21] PCI: dwc: Add dw_pcie_link_set_max_cap_width()
Thread-Index: AQHZd/tryj030WWjTEmN9mzd0370wK9F3neAgApF5eA=
Date:   Mon, 8 May 2023 09:25:35 +0000
Message-ID: <TYBPR01MB534143286825C3AB97BF8F9BD8719@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-12-yoshihiro.shimoda.uh@renesas.com>
 <20230501195753.o3qfcs7qyergccnr@mobilestation>
In-Reply-To: <20230501195753.o3qfcs7qyergccnr@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB10283:EE_
x-ms-office365-filtering-correlation-id: a59f8a64-b34b-4e38-0bd7-08db4fa62df7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /E06XAJY8/am+E4h9rFbtpc8PlIDeV5+IBgyMNLTPa+JDWPzfTXZLWgW1fl92BCr44oP82Hhwg+EJgHzodiHERHxbSnR68eo/PsZS04sgdr7n1FsgBAKEO3usTT2amYJGU5cLYVnJru4Y9QY3OBUuzM+sgVM7LC3KM2xF47Y/W4dPl8HzcAwFJQUwu412NtGNYEsjK3h1RZjWYrD68sSfl+EBSAOuIDaRUFlofwlIgxVqCE9pMtbgldCRx8pOUxFyLcmB94xMXkIgVXySmQCdvEuFt5Hjgc9hTQc+UKIkqbqK5z2fRyCqRVzSnfI2U/reVRKHyIVfBGSzKiicoqJpOK3SH3HSksSKEUfnzesQr3nyFBoh0clYFL0bYsCJ/IqOQy8qKSVjp+Pu1XIKCNIQQ8j03I7tiP08N76pbyvjy3JDUd+fUZwekAfh+DoQvuRYpK0t5N7fJXf0lYCXe28RwnHfBvdllVTnDu7zMaOuRz8y7uQZ3IEW2QCg72zqxs2bAum2xxefP3E6NEKiaJ9sMVBGWUrpyraS64O8VUqS6Sh2sw3gkk79C8RLJrNvjHE6rUJZLWRKMROzSu/YljxueKzbPULDtpFqNXu/DMfQwizPXdhFwcICznApqUuW4NJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(66946007)(66556008)(66446008)(64756008)(6916009)(4326008)(76116006)(478600001)(7696005)(316002)(54906003)(86362001)(66476007)(33656002)(83380400001)(6506007)(9686003)(71200400001)(5660300002)(52536014)(41300700001)(7416002)(8936002)(8676002)(2906002)(55016003)(38100700002)(38070700005)(186003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kVvn4xTi8lfa86jfBfi6LDwOJK2jP2dpyyanhNxgmU1Rj/sqO6FantYd7GOB?=
 =?us-ascii?Q?+zSCF3KtipAgWVAOqhSplxtZweo1wAl2COlJl8As+KNZKKkY86Yfw/MSvwOy?=
 =?us-ascii?Q?f5l0oa/bEYdtmHISvvkQOdzCpjM2+fFzIgL6PqJY3C+Z4eFVRtpj1Ild4JoY?=
 =?us-ascii?Q?PJRq/0MFjAnP+Jc53qynN121b5EMaU3VNWVZMoagIZUYeLWcClGFna5OpQS+?=
 =?us-ascii?Q?saObIlQ83q5LS210n9t0WWaaHmNkriMdOP7dfZxYX+R8ttA9/pAjvmSdEc/e?=
 =?us-ascii?Q?ObQLRVIMcYbQIFe9WnBXPR0hk/nsnxn9p3ljdQJgvVkcGxFzqHWXn01qZeFK?=
 =?us-ascii?Q?aGQ0T9BZB2k0ZoUK75BSA1mPVUCaT0oWiXRpH1dGICscAvjsCoNRZPnFhr/i?=
 =?us-ascii?Q?nlvAXhYgFk4oDXhCMdP4HzKhE3ZsC4iitXGtPg3jAoBerC0x0GDRBx4dMDQ5?=
 =?us-ascii?Q?n9mTgHG0W/uZ7utIUYBAxL/+sHwEk0FuPpjN46cS5tghsPoaM2+CFb/842T5?=
 =?us-ascii?Q?NVuJ1t/GReLcCta+dNfwp17pB607GnbJUiaX+HP4uV1BnlQnAU5f9Hyrlxr4?=
 =?us-ascii?Q?wQOo1ol/p2FYG0O1/KfqbpsvLk2+puFhD5mX6KbfWvTutuqBLjjdghzGH47T?=
 =?us-ascii?Q?iep1mAGRjycHCJ38TFexKg1Q7fPZFmBPmiSo2gJf3e58P+IIquH/rjlZKZJb?=
 =?us-ascii?Q?JuMYcFVWE56TNEFV8F3cSALZMidFQXgfWucZ7bZfExqQfcW7h1kD2xSFPtMs?=
 =?us-ascii?Q?BOKLt/wPJXI7ZkO3K1jR4H8h+4AJ+/vNP2V+41lXAG4AFsvF7Zn8OoZFmGpm?=
 =?us-ascii?Q?Gw0Gd/6WujN4swRArufPAUbeYJBC1BHkN8EGZTd6Xp+kz/Kpjjr751QSiWau?=
 =?us-ascii?Q?4wqix/JyFVT8jFqhcdFo7ilV4Sbt/XkWQUlEmuv5TlXv3/xAxoOrQouGrR3J?=
 =?us-ascii?Q?HJQOXZTOgb8VvgJZ7gjAEuZGC3bskXwJg/tgxi3fQItf99YqxAqbDzdXJcQi?=
 =?us-ascii?Q?D99BodMYWoZVAd2kb3BXMO0MlRIdPxUhWvjzBxOCtIO4GXCVp3h6SeBb6y0L?=
 =?us-ascii?Q?r6YpqaRCsDaqUPg7bwHbLQ2g6GnMUTHoC4uOeNtEoIG2yB+/dMMVtQnmZo7Q?=
 =?us-ascii?Q?rtxhUEy/cgSvx0MO97g4MX1NxDLRMqUdBGITzEicigyWcuUZdM28ydTbV+ai?=
 =?us-ascii?Q?yMiLPk0euB8GOrx1uxVkinroYsR4Ak+fUlyDJzT0+ai5p2XvUHtKLMQZdvDw?=
 =?us-ascii?Q?//Kr98PlZ2AFPbbqjR2YFt5yru1DqqZKwh+wZwGBla5Ofc6+EW5WpW0x79Eq?=
 =?us-ascii?Q?RCDNTn6Mz66eTmC0hLf58UN1etQx6WVNffZvjhWjndDnmA3hxYAVfh9ncTKE?=
 =?us-ascii?Q?qCP5s4aGVc+MB56VdBwdAy1XboPoGknZ//FW7lYXVE7SB2LCauZYWHCoS46m?=
 =?us-ascii?Q?bFC1ozfaYj0VwHsWTxYO99lO351NsBGRecrwDMOYNWEpup8VEph98qoD+H9i?=
 =?us-ascii?Q?et6rcdllVYzkijX/ZczLK63Z9yQ+1Jn+avB0WIwE4KMx0DswXYNrNlvxCEvf?=
 =?us-ascii?Q?/Ngyvc4gr/grepcBHWLZkesWXwxJldiiztR71wMCkMzSMca9obY7VSeUGvB4?=
 =?us-ascii?Q?OAF6jt0SRRnwcrwFg3HBfAsO19fxl405PGFE2c1Nzit4wtyO4xbuKcOduyQv?=
 =?us-ascii?Q?ojiO7Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59f8a64-b34b-4e38-0bd7-08db4fa62df7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 09:25:35.7078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YX27pS/mx/buW7WnZWzJJdrqst9Gd2zN/oOi4TBFG5xVwZZWBIQDgPnh1KcmTCP8RPolO0lEdttZVXxuMdNViOLRs2ZYBKPwqInnjf2a0YiDtAk9E0toV0IxJQ5fBdCq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10283
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Tuesday, May 2, 2023 4:58 AM
>=20
> On Wed, Apr 26, 2023 at 01:55:47PM +0900, Yoshihiro Shimoda wrote:
> > Add dw_pcie_link_set_max_cap_width() to set PCI_EXP_LNKCAP_MLW.
> > In accordance with the DW PCIe RC/EP HW manuals [1,2,3,...] aside with
> > the PORT_LINK_CTRL_OFF.LINK_CAPABLE and GEN2_CTRL_OFF.NUM_OF_LANES[8:0]
> > field there is another one which needs to be updated. It's
> > LINK_CAPABILITIES_REG.PCIE_CAP_MAX_LINK_WIDTH. If it isn't done at
> > the very least the maximum link-width capability CSR won't expose
> > the actual maximum capability.
> >
> > [1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Po=
rt,
> >     Version 4.60a, March 2015, p.1032
> > [2] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Po=
rt,
> >     Version 4.70a, March 2016, p.1065
> > [3] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Po=
rt,
> >     Version 4.90a, March 2016, p.1057
> > ...
> > [X] DesignWare Cores PCI Express Controller Databook - DWC PCIe Endpoin=
t,
> >     Version 5.40a, March 2019, p.1396
> > [X+1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root =
Port,
> >       Version 5.40a, March 2019, p.1266
> >
> > The commit description is suggested by Serge Semin.
> >
> > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index f8926d5ec422..bdc5ebd7cd5f 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -737,6 +737,21 @@ static void dw_pcie_link_set_max_speed(struct dw_p=
cie *pci, u32 link_gen)
> >  	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
> >  }
> >
>=20
> > +static void dw_pcie_link_set_max_cap_width(struct dw_pcie *pci, int nu=
m_lanes)
> > +{
> > +	u32 val;
> > +	u8 cap;
> > +
> > +	if (!num_lanes)
> > +		return;
> > +
> > +	cap =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > +	val =3D dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> > +	val &=3D ~PCI_EXP_LNKCAP_MLW;
> > +	val |=3D num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT;
> > +	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, val);
> > +}
>=20
> Just move the function body to dw_pcie_link_set_max_link_width() thus
> the later method will be as coherent as possible.

I got it.

> Also note the duplicated code can be dropped from the pcie-tegra194.c
> driver. Please submit an additional cleanup patch so the Tegra driver
> author would have it reviewed.

I got it. I'll make such a patch.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +
> >  static void dw_pcie_link_set_max_width(struct dw_pcie *pci, u32 num_la=
nes)
> >  {
> >  	u32 val;
> > @@ -1074,6 +1089,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
> >  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
> >  	}
> >
> > +	dw_pcie_link_set_max_cap_width(pci, pci->num_lanes);
> >  	dw_pcie_link_set_max_width(pci, pci->num_lanes);
> >  	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
> >  }
> > --
> > 2.25.1
> >
