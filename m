Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED48E752F3C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 04:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjGNCMe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 22:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjGNCMd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 22:12:33 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2133.outbound.protection.outlook.com [40.107.114.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC112700;
        Thu, 13 Jul 2023 19:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgPZ2C3bXrJh9E0qQsG6OuvBxAabMpam/hwJMmhq/3Phf/qQyLRvYdw1N9NbyS13KaqZ6gXG14z0FRsUByvIFWT8AssbreRJ1VdYGaco9Geo013PHmMXMpzolgeF7WY7M+IgWnwQpyKZ/BFrAD/T9SMv74jU/hFaKEnEF9RpwjM/eaacraOu5hJRXaMoEIrVud2w4Rhf+eWKzsMqz1E4lUgjmToI82O7GLgr7C0XpRkNHirKiEqhH5goSwPAlcnefb94NcT9mZSh7jhiODZt89TuyrjFKmuqQcMitubuZnun0GljxhtaXUjzcK8l9jm1NqNZrP8ih18kVPHCTeUKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXrvWKs8CObWVFVqc+YwZd6LkbzANfRG/ANSpPhYnVM=;
 b=Isnu6p2TXNzQtc8nO5w592gEkCb1Lu02FQJlGSI5fshKqPM+D0l4uu1ATgG/H1vdkIZ0+f8bNungExK44Il0ntsw+MXU6Sfw4E6ZumdBaxp6mQuey00HgxwKJiDgibZAH2FzYA5SxOPMdfIFdXbUrX6lL7wyDZufDovLHo2Pq3pwnWxTgGXni9QlLTT1z56L2BZryLYNy6Aa5yPMUf+60dG6NEcTgqpQ+m4P979QwgdWPGt6EmvO4JwXRhUv03UpHYpDXwiz2njJ0NIJLhMuJ+bGLgWfRXfnT5Q0gVw4UuFvn2rQuw1xO88lNmwOtyoiPMnGW3oBUlXU+v1Bm0Fmow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXrvWKs8CObWVFVqc+YwZd6LkbzANfRG/ANSpPhYnVM=;
 b=dkhfbRjgUXsbfv/URJXR8iEggWJpq5ltlHAfzeK3Rx1kAH8DvoZIzrnDUqy8YKBEPot3tA/LeL1/qRNIIxkXyWrX3wEa+pni57Ut2marBfDSjdebyFsdCLcIkVjHd3cwcYxP/8SbuWkknavJxL+xEww3cMtBRVP9tWGqEk/XS/E=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYTPR01MB10952.jpnprd01.prod.outlook.com
 (2603:1096:400:39c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26; Fri, 14 Jul
 2023 02:12:28 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::4aa4:531b:e63:3d61]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::4aa4:531b:e63:3d61%2]) with mapi id 15.20.6588.017; Fri, 14 Jul 2023
 02:12:28 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v17 09/20] PCI: dwc: Add PCI_EXP_LNKCAP_MLW handling
Thread-Topic: [PATCH v17 09/20] PCI: dwc: Add PCI_EXP_LNKCAP_MLW handling
Thread-Index: AQHZrzZOE8U93hZ+r0S4/QlSQ5IKm6+1E3aAgAN/LoA=
Date:   Fri, 14 Jul 2023 02:12:28 +0000
Message-ID: <TYBPR01MB534145378A2CE2C17CFFD44ED834A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-10-yoshihiro.shimoda.uh@renesas.com>
 <4dik7u3sk42itkmp3o7e5r4fx5ziquo6j6f67dq4s3qtp6kzxq@ji2ss2c2n7zh>
In-Reply-To: <4dik7u3sk42itkmp3o7e5r4fx5ziquo6j6f67dq4s3qtp6kzxq@ji2ss2c2n7zh>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYTPR01MB10952:EE_
x-ms-office365-filtering-correlation-id: 7d48d76c-5ca5-4e0e-34f9-08db840fc5fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KXWYIJ5H1e//27vLvpemFjTPk87NOLuM9vy5/4HzABGiOi9vP4fHi4L7m0QO+SvEl5hYDNM0Y7j8J6ePERj7AnEffBH5HTKuM/B+tAapFMKNHQ8Cwwwop4Lt2126GOlS1GlgFuReLuCBhZKFpMiSzt/rMcpIjXLqRgjEc2mE5k/gavrYXO7/mnpqalvf3SBybpUcPxxUEOs1DEpN8rR/hjE0vZZinOn0NzLYszZ+wTP3AciRFxEidte4joSV9qnLMwaRlW3JwE5kYkvpT4yICJ0FCMPPdxlB9rBgoY34OiVGF1ssx6rOD3pCXMypib9TucZkTi0yHKXgp9p/JWMT3HEE6+k0sBMfqyC7V5ezxLIF8LPWqFcjbVja41HM4jAZRI7MdXUa+4nfJ1WqlZu5GrrzDoRHtAT9571cTaQRGOF57swFPge7r5u4Tv9bObIRA0kF8wypFf6sO0u873+7VGyDKwzoU80BI8mNzmp0ozYhydwtPtzDUkBq2cHubZWq9kzS7rhL8em9SkLOmx/ZP6UwveVoSGtejspA262qQLaGyh5V4LXjCjGcyrOWO+knWjdi4c/sMD9R19gKs6F8WULQINpybL2wTyKZ7munPpEKYcBKUjIYJ/Z76xw7OEPA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(7696005)(71200400001)(33656002)(83380400001)(186003)(122000001)(38100700002)(38070700005)(86362001)(9686003)(6506007)(55016003)(66476007)(66446008)(7416002)(64756008)(76116006)(66946007)(66556008)(6916009)(4326008)(41300700001)(54906003)(52536014)(5660300002)(316002)(8676002)(8936002)(2906002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u+9/nZOmo+ntXOveYNYW9RM5bBL8w9xa/OpbhfWQXUEU90qs2zqCgkAcMQ4N?=
 =?us-ascii?Q?Qfc+0OEMn6VYBLUjNuyGI9F0i2SQ+kDImr2CWaXx2i6kWRQOqJd2xtcLhoQX?=
 =?us-ascii?Q?umC82t6z8grMygAoXEpzse0gGqApn1JADyK16PkQvxa8invsJgesY1UwvmgS?=
 =?us-ascii?Q?/poSnWwhRcahGOrdxOiFMNO4j2SA73nXyDaUr1vdSAkPpg2UWOueQ7Oqq37u?=
 =?us-ascii?Q?7EWXxeoyN/CIIgitMmzeEyRVGwknBlVnskfPNv3BuVkfS/6jhsZovFETDspu?=
 =?us-ascii?Q?T+e+hEB7r6Av0HsEL4CoqxgUP8FpVTSUS2P1d57ETCqoiXjS3g5zaAte9FRp?=
 =?us-ascii?Q?wo+tjqEue1bEhmxWpEaGvLoDCIoUE9pNJ1RSFrb53kLpUkJmn4zwjMQUil0T?=
 =?us-ascii?Q?QOGtdV4ZnDj6JwmYR/HNhqVvOqYMtx3DLyM5CNmTEQYuKa5kMOftU59JB8OV?=
 =?us-ascii?Q?sKZIuV2q+xXBVhUa4zwc10UFU1sqC29AfQ3l7Uj6btUISUyG8WjccA2YkH0w?=
 =?us-ascii?Q?r8NHBXNtla7EyJMI5S2xR0gsLVmtx6TjkO8mB9fJyccuZG3hNeb0oe+dMojN?=
 =?us-ascii?Q?cGge2kIJxkWCEswerEcCWjVH4WJKqamCP7dQgTqf3FO7ZQianY2lZjJjLRdD?=
 =?us-ascii?Q?FDaxyjkc3817rg8D1LZdd8mfDv6XkkxzuNgIbV7lpbE3OHV6l4RLL6TIjiPq?=
 =?us-ascii?Q?yZAZMbuTodx/DN+IuilafzNJAv0SDbU2D9i8FCSbuUxp5PP+fLob7qKVG6uR?=
 =?us-ascii?Q?JX3uTfBB0I75QOV+ftxrDl9iRibR4Oc+dDPOFa63QxOGVrYC7cjMOmc8a/ig?=
 =?us-ascii?Q?vyFqjC5iG7UPuwbFIdASxZ/WS9s3BlwMD6oHMmAxgRKihk6eIE+VfHXPBb0a?=
 =?us-ascii?Q?78h8P9ruLS0iVmUclLU2+G7myqyWKc6jRjI5zt+VshJNsRuz97IUoE3bTOOt?=
 =?us-ascii?Q?RZww8In5c36fHCeqZhIrec3rx6fVsXBbm0zKvKr9pj/rLh9AHyHLOBe4+5Xc?=
 =?us-ascii?Q?nCR3QAXMtPuM6FtWQ1D0hP9phAXZEc8Zg4035fPEGiomvoipIZvQf3gpDhi8?=
 =?us-ascii?Q?1v+mWJHIk9Nyy3ojEOsoODQukmxfoN7dRnMav4oxau6GAlHPO7/HK4Xx7Fs1?=
 =?us-ascii?Q?WwmOMaF7XJiMDHkcfhLiRsmlA6c+nS9cS9yvGl87IHR2CDdKNdc6vKHRanLp?=
 =?us-ascii?Q?eftamI4aO2VRt+0hOJbhdgw0/smKl184AprWB+F+5tj8eNxwuFilYNddF2kI?=
 =?us-ascii?Q?RmPqM1eZi8vrBMqeL7SakadqvpbdbCjwxUZGdgGMCbfKrp6l6mAR/NziY1b3?=
 =?us-ascii?Q?GVgN96xsDDkh3kAnBZEKWz74xJ+jNBF9EKl7nGqdjsN5yu/Q8ox/LG7oc1Ju?=
 =?us-ascii?Q?7ivllZxjjlqqU2G50YMml1Nj7xnwczzc5FySWA9ivB1B46uQMKqxVPU0hXF5?=
 =?us-ascii?Q?EVtvY1njx9MJ4kGOrxOvjFmrmVQ4BB+BIfkVVjEqo91rwy24aFvzol4WfMVM?=
 =?us-ascii?Q?n/UvgR63z4ZUBplRcMvtDSMFHfcqeSjR2xTjKgXF8SvcTS4F8kd2MIzS6Taj?=
 =?us-ascii?Q?/jfsdyx5d4MqIA/2wu/dP5IopCK5lFYKtr9gfb+5TDjvfbzFOE0azYoKevcE?=
 =?us-ascii?Q?Ovn1K7M04Ve8jeA8DOvFFVH7tVLe3YkKC4JYYeAZukj3JbXTCRuOmcPSiKvV?=
 =?us-ascii?Q?7h8QwQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d48d76c-5ca5-4e0e-34f9-08db840fc5fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 02:12:28.3499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/lifqvulaWACY+g9EetRYIPYVBrfUMPFRVZCEmrPSJQxrCvEN5gOy0+Yke/tKNT+NW/j1aALf36mwTWBlxF65j633FDAhw/fLYCzLOoRmroBL7XPPwy0gmzWPdwcVJM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10952
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Wednesday, July 12, 2023 5:48 AM
>=20
> On Wed, Jul 05, 2023 at 08:41:55PM +0900, Yoshihiro Shimoda wrote:
> > Update dw_pcie_link_set_max_link_width() to set PCI_EXP_LNKCAP_MLW.
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
> >       Version 5.40a, March 2019, p.1396
> > [X+1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root =
Port,
> >       Version 5.40a, March 2019, p.1266
> >
>=20
> > The commit description is suggested by Serge Semin.
>=20
> This is implied by the Suggested-by tag. I'd drop it.

I got it.

> Anyway. The change looks good to me. Thanks!
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Thank you very much for your review!

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >
> > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index 7b720bad7656..44150d34720a 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -730,7 +730,8 @@ static void dw_pcie_link_set_max_speed(struct dw_pc=
ie *pci, u32 link_gen)
> >
> >  static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 n=
um_lanes)
> >  {
> > -	u32 lwsc, plc;
> > +	u32 lnkcap, lwsc, plc;
> > +	u8 cap;
> >
> >  	if (!num_lanes)
> >  		return;
> > @@ -766,6 +767,12 @@ static void dw_pcie_link_set_max_link_width(struct=
 dw_pcie *pci, u32 num_lanes)
> >  	}
> >  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
> >  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
> > +
> > +	cap =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > +	lnkcap =3D dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> > +	lnkcap &=3D ~PCI_EXP_LNKCAP_MLW;
> > +	lnkcap |=3D FIELD_PREP(PCI_EXP_LNKCAP_MLW, num_lanes);
> > +	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
> >  }
> >
> >  void dw_pcie_iatu_detect(struct dw_pcie *pci)
> > --
> > 2.25.1
> >
