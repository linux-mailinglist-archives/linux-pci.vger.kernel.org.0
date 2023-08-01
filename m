Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7272576A9AE
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 09:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjHAHDY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 03:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjHAHCy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 03:02:54 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2097.outbound.protection.outlook.com [40.107.114.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78420119;
        Tue,  1 Aug 2023 00:02:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBGf+dZcAfAeEsHJtaVIXB2iQN2UsQxTTcuFFd3HfVcA08Syw5pir9X+SeVraThPIrb/cYkrK08+u7gTGec/QIsBVXFjoMhgWuacaMKbM9K2KzdeFZzN4b/AtMEKNEDVtSqm7+noX5RVniVpOqcNS+05X+zCGurhbSF79ISfG7F7E/TC8frUwYCTimUsiTtiuSqsAdgqSjEAjoaHHuOwK9Bop3Q6SLBNnem3+8qdl6YTJ6kfztSZu8AidYahiPb9j9du2V/XptAqI7B6HiABwZpsV4MJJNRJns8Wlbq5J1BYmL1Eo6YMeO7kXuY40RD8GdVRbCN6hYnQnPn7ODkzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AuGNA7qO3x3OsVQMi3XuSzf78P+Lny+wMDg1R/joyQ=;
 b=mKIQiBALuEoYOUTwIGJvk9fAwcBg5PDD9b0Kld5d9bFOJdOpn/VufNj5KispoqyR/pzXTcRIqSa5Zb0+IvXPTETOOBzBYkkXoNeMQXPUkw4YGll9Zib8NLa1FHdl62TG3aLob5nCtNh1EWLN3jH/ZOlXdoBqBSy1mxlD6T0J/oCVMS9gSTl41YoawVWZ6Vj9642SNfGmTEvy2HwWc72B7IPQ6abFBxkF/uAUUaeUzm7Ltmmy7vCA0nGhJlB+S7XcheIzhlHX+848DqgLrUFQeStFVJC7aAlSFnZx3n2LbSxBs1KYBBemfKx9UJtmW8ITZD0C+yaC8iPAYfaTnC6MoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AuGNA7qO3x3OsVQMi3XuSzf78P+Lny+wMDg1R/joyQ=;
 b=KaQ5S60Np/R1QNcZ89CN5fZ6/lLHt7bmVTP6wKX24iKtjJQcPv6EvrdH6Er3acGVD/MRm1pNTVJG/vH5WnPo0jfb0cvhQ1Y81sfHtMftduyW+fZ4oJUfwZ2dnXSj4f9QstZRj1EDk57QWKWr5IsHoRCZ3QSJEXffWkA4oboETWs=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYAPR01MB6316.jpnprd01.prod.outlook.com
 (2603:1096:402:3c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 07:02:41 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 07:02:41 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
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
Subject: RE: [PATCH v18 04/20] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Thread-Topic: [PATCH v18 04/20] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Thread-Index: AQHZu6dDb7hFhSogz0udklVWjO2cJ6/QC08AgAMXU6CAAVM9gIAAQCcQgAAGMACAAFhoEA==
Date:   Tue, 1 Aug 2023 07:02:41 +0000
Message-ID: <TYBPR01MB5341ECC93ADBA697D4EF4B6DD80AA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-5-yoshihiro.shimoda.uh@renesas.com>
 <u2lzrypnaevcp5r5xueeceoq6b5v6ngzdmwyadel2liloxb3rz@6ribp2lqv2db>
 <OSYPR01MB5334EBCD11ED8D3104A0BEFBD805A@OSYPR01MB5334.jpnprd01.prod.outlook.com>
 <4idgmodxlnzv2kkscniuw3336ynmukh3duu4rt2db354ln5sbg@e4jnmhfugmj4>
 <TYBPR01MB5341F15483816E81A073B12DD80AA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <jgizq7ibill2bd735fh7elzb74guwjjwxqkfgn3uwh65lyuoe2@pqo4qdrpvkpw>
In-Reply-To: <jgizq7ibill2bd735fh7elzb74guwjjwxqkfgn3uwh65lyuoe2@pqo4qdrpvkpw>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYAPR01MB6316:EE_
x-ms-office365-filtering-correlation-id: 736452fe-877e-4808-e596-08db925d4c3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ms4wqV8jmWSdCEr7bT53pHMz1Ejn73LqtUE2VFZIEtvkX027knIGYSbwhHw+/6Ck1CE1XJL/iMYrXWd29KTTbKzRGoh87PYQySMsbRzZVx/vvMn6XJaYOuTm6UrPBXL1U7mo2APngxnpix7RHCLI4jAQk+TzoRKPX/rr9Y5iRlKIoU1GGcO+Pcgbkwojm74KWdB/CECtrZGHrNO8F6Qsm/4JRze5O2KN8N4cCKwOCKdvjHnMTfWb8Dli2pUpuKsAeP5QTFH1rbHqIXT865P0Ht9HePiDVMYCu5zwbUE/OIria0w+O2ffqcMfViqiRKmcHOyxJpdsFgyweR5CRqbRZrwn1FhPJJDKI6LkM63ragxJ2nGnSwwGQuZHF+NqR9e91DG7f3wWsmIUhiyjaPBHzZLSXeZ6EdrHeNYpPoYU3pfrL2n+3F7qRI9Brtvfs4MoTE7pb7CuTLRP072cRgymxzZqrm0D1K05Bf6+63PGilL7vKiUk6BGVRBKAUGnyMRAQ53tVBQyy7rfEdu/a5Y3asvcW7HjYB0b0NlElocGzg+HR1gXqx9FKnPscTxSlumMpwMAhD8UkwkaKWZvrnwRtpIeLYDhA5qxkzwIlv16MCIb7l19Ywn7UFRdylUbCvP+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(451199021)(38100700002)(122000001)(55016003)(86362001)(38070700005)(33656002)(9686003)(478600001)(71200400001)(7696005)(6506007)(186003)(26005)(8936002)(8676002)(7416002)(5660300002)(52536014)(66556008)(76116006)(66946007)(66476007)(2906002)(54906003)(64756008)(66446008)(6916009)(41300700001)(316002)(4326008)(30864003)(83380400001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/HukL8NulGVxQ2bnVkmf3J83P4prJW5sdQk2u+mpCvRjOgYIxY+iS3E+EHYc?=
 =?us-ascii?Q?A+wt4njjVo2IOnVhUfkDtzXeNaXNU/0ulR6QMbZM/Y60VnvshmpVKjXLHqcO?=
 =?us-ascii?Q?Loo4EHWdCnRpKhfFRNtZFypceCBpNc51eqKwiEncEB7nz4m7sEam+EndIO18?=
 =?us-ascii?Q?Wmd4zmAk5sJhqqZWOBMzqAoSXsrr4w6ZzVhS17+0N4eHEJTzHrRUKYMCZC4h?=
 =?us-ascii?Q?XeKMwDmCt+SuuiZSN553DE5niTEdwRl9APV6gB89CgW4kYIaU61IOnCvN1TP?=
 =?us-ascii?Q?C+H4COenoz7BfNve3KDYCbhyrGyNrSJSWOhbj/6N8V/F5wqwHT0xpxx0k/5s?=
 =?us-ascii?Q?U6GH6l5Fl4OVjem4weGxUmJorrhXSbmNTTfIJliROYsFGRhtl8sduCZWUsIF?=
 =?us-ascii?Q?wh0FukrDh3xn768JiVfACMn4qjU9mXTqc97ONbNrTAba1N6ZN/nYm2FeRm3I?=
 =?us-ascii?Q?UgD5QGo3LCyA2Z47RE9uxM9m2GaMPmZwQoM0HCeC724F+sjuKQoQ/cF1Lqx2?=
 =?us-ascii?Q?91L9CcOAcbElAxpgdW8XFsDicUqDOMK6LKlOp73QBWsvGWCBk0ppu+cs0UuX?=
 =?us-ascii?Q?xw64zeVTdfkw+XdZaCDycKTySkOVwf9e6VCiCyF4WVlSYt7ZW5RwE3LyZ2QG?=
 =?us-ascii?Q?ay1EFmMfzrq2CwSnbJ/IEoKdrYTdPBfNzWA2zhA13endCBBaKm/ck0wydYnR?=
 =?us-ascii?Q?uYV8AWrwHqe7dDruCdKfhofRX6MCoK/4XbB65ji1S2Eo3IPb0Wrtkv9xbDeq?=
 =?us-ascii?Q?pkxusaKtLVRTC3wPSZ9mtXF+RB0J0KGRC5ohmq/IcZEwQkMxw7Gox7tACM/D?=
 =?us-ascii?Q?dJoBUp7D5+xnFUH7vE2OO7KxQJ7ZNPvr2nijPdyiyJQKytdp6OXTZkTWwNjk?=
 =?us-ascii?Q?zF4NtouALgFGzIG8v1bATKZboTvM7dvw1PAE4WdV6HnRpm6OppJi1Yjymlvm?=
 =?us-ascii?Q?0Q6O+IKdFsXoNw1gdCch8MbvkFWSaD3As+zh3btYFMdiQ81J4ta2sBOECech?=
 =?us-ascii?Q?crLNaPbbjBOMi0ptxnIH59lqGGG5uQHObQ0n2UteW0djO/FLqa+vsdbiGhoR?=
 =?us-ascii?Q?m5VzsfExd52lI8oPdOmM2Hq/TR/19jp/cscB6mNWCAh9+S7/Tkf9QMjFO7Gl?=
 =?us-ascii?Q?4WI88W1+cnGOtzyhyCMvSaLHycPKHvYZHt40C5FjEjLQcAtXt+X0ER1XhizG?=
 =?us-ascii?Q?+T0z2tzhrSkDnEjlSmV0kQuMhuZ30XM51mZOdLriehWVBaGR9kQb6kFQ5QBI?=
 =?us-ascii?Q?aOGUwAnz8GyZSwTJbIlBPGPdKQlm0HpcW2AevUlXXSQWzIpD/lIM9/BvG4A1?=
 =?us-ascii?Q?PbVKoG24BIBO/4NLzsodlkY1HkouhP4wPHlTFNUzRpzClrJdwCFZnIgUoTso?=
 =?us-ascii?Q?LO5NneSGYxg96nDcUDJ2sHeogjfCD0F99sLiJBCUarI2Ktt50phGkP3cWx3p?=
 =?us-ascii?Q?WbTXg0hB9lOPCx5CCp5mzXDlKu64YPRTCAe1hfZFPP+giWh0aavxOB//XtLr?=
 =?us-ascii?Q?MJGoiVHzjgoBOTdKSXwroov5ixqKjCqaYqzy3J7MqRTSWXQv8JlEBeN/9evm?=
 =?us-ascii?Q?Ye2BO9lygIS1xF3AoV5k3S54amo/eM7Hob2w3zfJN8+1V0X42qAZMt+DK998?=
 =?us-ascii?Q?uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736452fe-877e-4808-e596-08db925d4c3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 07:02:41.1398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfp1eVODapAdbEoWkcH1HZpAMLOsJbqUGqZbb9UYfyydp/cLwZZZe4Cm041YJtUX7wLLWQqQnfyZwqhwxH2UaU7jpEGUcsx6Ed/U9B6HXx/uTMWRyL1kRj1XRwRvOpE8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6316
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

> From: Serge Semin, Sent: Tuesday, August 1, 2023 10:45 AM
>=20
> On Tue, Aug 01, 2023 at 01:29:10AM +0000, Yoshihiro Shimoda wrote:
> > Hi Serge,
> >
> > > From: Serge Semin, Sent: Tuesday, August 1, 2023 6:33 AM
> > >
> > > On Mon, Jul 31, 2023 at 01:24:27AM +0000, Yoshihiro Shimoda wrote:
> > > > Hi Serge,
> > > >
> > > > > From: Serge Semin, Sent: Saturday, July 29, 2023 11:07 AM
> > > > >
> > > > > On Fri, Jul 21, 2023 at 04:44:36PM +0900, Yoshihiro Shimoda wrote=
:
> > > > > > The __dw_pcie_prog_outbound_atu() currently has 6 arguments.
> > > > > > To support INTx IRQs in the future, it requires an additional 2
> > > > > > arguments. For improved code readability, introduce the struct
> > > > > > dw_pcie_ob_atu_cfg and update the arguments of
> > > > > > dw_pcie_prog_outbound_atu().
> > > > > >
> > > > > > Consequently, remove __dw_pcie_prog_outbound_atu() and
> > > > > > dw_pcie_prog_ep_outbound_atu() because there is no longer
> > > > > > a need.
> > > > > >
> > > > > > No behavior changes.
> > > > >
> > > > > So you decided not to use a suggested by me in v17 more detailed =
patch
> > > > > log?
> > > >
> > > > You're correct. I thought your suggested comments was too detailed.
> > >
> > > I strongly recommend for you to use mine instead. It gives more
> > > details about the change and the patch context. Moreover it much more
> > > clearer justifies the change implemented in the patch.
> >
>=20
> > I didn't realize that you have a strong recommendation about the commen=
ts
> > you suggested. I'll replace the commit description and add your Suggest=
ed-by
> > tag on v19.
>=20
> Just to note if there is a misunderstanding on your side. Suggested-by ta=
g is
> relevant to the patch idea in general.
> See Documentation/process/submitting-patches.rst:559 for details.
> So you don't need to add the tag if somebody just suggested an
> alternative patch description.

Thank you for your comments. So, I will not add Suggested-by tag.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >
> > Best regards,
> > Yoshihiro Shimoda
> >
> > > -Serge(y)
> > >
> > > >
> > > > Best regards,
> > > > Yoshihiro Shimoda
> > > >
> > > > > C&P it here just in case if you change your mind:
> > > > >
> > > > > This is a preparation before adding the Msg-type outbound iATU
> > > > > mapping. The respective update will require two more arguments ad=
ded
> > > > > to __dw_pcie_prog_outbound_atu(). That will make the already
> > > > > complicated function prototype even more hard to comprehend accep=
ting
> > > > > _eight_ arguments. In order to prevent that and keep the code
> > > > > more-or-less readable all the outbound iATU-related arguments are
> > > > > moved to the new config-structure: struct dw_pcie_ob_atu_cfg poin=
ter
> > > > > to which shall be passed to dw_pcie_prog_outbound_atu(). The stru=
cture
> > > > > is supposed to be locally defined and populated with the outbound=
 iATU
> > > > > settings implied by the caller context.
> > > > >
> > > > > As a result of the denoted change there is no longer need in havi=
ng
> > > > > the two distinctive methods for the Host and End-point outbound i=
ATU
> > > > > setups since the corresponding code can directly call the
> > > > > dw_pcie_prog_outbound_atu() method with the config-structure
> > > > > populated. Thus dw_pcie_prog_ep_outbound_atu() is dropped.
> > > > >
> > > > > -Serge(y)
> > > > >
> > > > > >
> > > > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.=
com>
> > > > > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > > > > ---
> > > > > >  .../pci/controller/dwc/pcie-designware-ep.c   | 21 +++++---
> > > > > >  .../pci/controller/dwc/pcie-designware-host.c | 52 +++++++++++=
++------
> > > > > >  drivers/pci/controller/dwc/pcie-designware.c  | 49 ++++++-----=
------
> > > > > >  drivers/pci/controller/dwc/pcie-designware.h  | 15 ++++--
> > > > > >  4 files changed, 77 insertions(+), 60 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/=
drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > > > index 27278010ecec..fe2e0d765be9 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > > > @@ -182,9 +182,8 @@ static int dw_pcie_ep_inbound_atu(struct dw=
_pcie_ep *ep, u8 func_no, int type,
> > > > > >  	return 0;
> > > > > >  }
> > > > > >
> > > > > > -static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 f=
unc_no,
> > > > > > -				   phys_addr_t phys_addr,
> > > > > > -				   u64 pci_addr, size_t size)
> > > > > > +static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
> > > > > > +				   struct dw_pcie_ob_atu_cfg *atu)
> > > > > >  {
> > > > > >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > > > > >  	u32 free_win;
> > > > > > @@ -196,13 +195,13 @@ static int dw_pcie_ep_outbound_atu(struct=
 dw_pcie_ep *ep, u8 func_no,
> > > > > >  		return -EINVAL;
> > > > > >  	}
> > > > > >
> > > > > > -	ret =3D dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, =
PCIE_ATU_TYPE_MEM,
> > > > > > -					   phys_addr, pci_addr, size);
> > > > > > +	atu->index =3D free_win;
> > > > > > +	ret =3D dw_pcie_prog_outbound_atu(pci, atu);
> > > > > >  	if (ret)
> > > > > >  		return ret;
> > > > > >
> > > > > >  	set_bit(free_win, ep->ob_window_map);
> > > > > > -	ep->outbound_addr[free_win] =3D phys_addr;
> > > > > > +	ep->outbound_addr[free_win] =3D atu->cpu_addr;
> > > > > >
> > > > > >  	return 0;
> > > > > >  }
> > > > > > @@ -305,8 +304,14 @@ static int dw_pcie_ep_map_addr(struct pci_=
epc *epc, u8 func_no, u8 vfunc_no,
> > > > > >  	int ret;
> > > > > >  	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
> > > > > >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > > > > > -
> > > > > > -	ret =3D dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, =
size);
> > > > > > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> > > > > > +
> > > > > > +	atu.func_no =3D func_no;
> > > > > > +	atu.type =3D PCIE_ATU_TYPE_MEM;
> > > > > > +	atu.cpu_addr =3D addr;
> > > > > > +	atu.pci_addr =3D pci_addr;
> > > > > > +	atu.size =3D size;
> > > > > > +	ret =3D dw_pcie_ep_outbound_atu(ep, &atu);
> > > > > >  	if (ret) {
> > > > > >  		dev_err(pci->dev, "Failed to enable address\n");
> > > > > >  		return ret;
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > index cf61733bf78d..7419185721f2 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > @@ -549,6 +549,7 @@ static void __iomem *dw_pcie_other_conf_map=
_bus(struct pci_bus *bus,
> > > > > >  {
> > > > > >  	struct dw_pcie_rp *pp =3D bus->sysdata;
> > > > > >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > > > > > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> > > > > >  	int type, ret;
> > > > > >  	u32 busdev;
> > > > > >
> > > > > > @@ -571,8 +572,12 @@ static void __iomem *dw_pcie_other_conf_ma=
p_bus(struct pci_bus *bus,
> > > > > >  	else
> > > > > >  		type =3D PCIE_ATU_TYPE_CFG1;
> > > > > >
> > > > > > -	ret =3D dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base=
, busdev,
> > > > > > -					pp->cfg0_size);
> > > > > > +	atu.type =3D type;
> > > > > > +	atu.cpu_addr =3D pp->cfg0_base;
> > > > > > +	atu.pci_addr =3D busdev;
> > > > > > +	atu.size =3D pp->cfg0_size;
> > > > > > +
> > > > > > +	ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> > > > > >  	if (ret)
> > > > > >  		return NULL;
> > > > > >
> > > > > > @@ -584,6 +589,7 @@ static int dw_pcie_rd_other_conf(struct pci=
_bus *bus, unsigned int devfn,
> > > > > >  {
> > > > > >  	struct dw_pcie_rp *pp =3D bus->sysdata;
> > > > > >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > > > > > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> > > > > >  	int ret;
> > > > > >
> > > > > >  	ret =3D pci_generic_config_read(bus, devfn, where, size, val)=
;
> > > > > > @@ -591,9 +597,12 @@ static int dw_pcie_rd_other_conf(struct pc=
i_bus *bus, unsigned int devfn,
> > > > > >  		return ret;
> > > > > >
> > > > > >  	if (pp->cfg0_io_shared) {
> > > > > > -		ret =3D dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
> > > > > > -						pp->io_base, pp->io_bus_addr,
> > > > > > -						pp->io_size);
> > > > > > +		atu.type =3D PCIE_ATU_TYPE_IO;
> > > > > > +		atu.cpu_addr =3D pp->io_base;
> > > > > > +		atu.pci_addr =3D pp->io_bus_addr;
> > > > > > +		atu.size =3D pp->io_size;
> > > > > > +
> > > > > > +		ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> > > > > >  		if (ret)
> > > > > >  			return PCIBIOS_SET_FAILED;
> > > > > >  	}
> > > > > > @@ -606,6 +615,7 @@ static int dw_pcie_wr_other_conf(struct pci=
_bus *bus, unsigned int devfn,
> > > > > >  {
> > > > > >  	struct dw_pcie_rp *pp =3D bus->sysdata;
> > > > > >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > > > > > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> > > > > >  	int ret;
> > > > > >
> > > > > >  	ret =3D pci_generic_config_write(bus, devfn, where, size, val=
);
> > > > > > @@ -613,9 +623,12 @@ static int dw_pcie_wr_other_conf(struct pc=
i_bus *bus, unsigned int devfn,
> > > > > >  		return ret;
> > > > > >
> > > > > >  	if (pp->cfg0_io_shared) {
> > > > > > -		ret =3D dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
> > > > > > -						pp->io_base, pp->io_bus_addr,
> > > > > > -						pp->io_size);
> > > > > > +		atu.type =3D PCIE_ATU_TYPE_IO;
> > > > > > +		atu.cpu_addr =3D pp->io_base;
> > > > > > +		atu.pci_addr =3D pp->io_bus_addr;
> > > > > > +		atu.size =3D pp->io_size;
> > > > > > +
> > > > > > +		ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> > > > > >  		if (ret)
> > > > > >  			return PCIBIOS_SET_FAILED;
> > > > > >  	}
> > > > > > @@ -650,6 +663,7 @@ static struct pci_ops dw_pcie_ops =3D {
> > > > > >  static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > > > > >  {
> > > > > >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > > > > > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> > > > > >  	struct resource_entry *entry;
> > > > > >  	int i, ret;
> > > > > >
> > > > > > @@ -677,10 +691,13 @@ static int dw_pcie_iatu_setup(struct dw_p=
cie_rp *pp)
> > > > > >  		if (pci->num_ob_windows <=3D ++i)
> > > > > >  			break;
> > > > > >
> > > > > > -		ret =3D dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
> > > > > > -						entry->res->start,
> > > > > > -						entry->res->start - entry->offset,
> > > > > > -						resource_size(entry->res));
> > > > > > +		atu.index =3D i;
> > > > > > +		atu.type =3D PCIE_ATU_TYPE_MEM;
> > > > > > +		atu.cpu_addr =3D entry->res->start;
> > > > > > +		atu.pci_addr =3D entry->res->start - entry->offset;
> > > > > > +		atu.size =3D resource_size(entry->res);
> > > > > > +
> > > > > > +		ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> > > > > >  		if (ret) {
> > > > > >  			dev_err(pci->dev, "Failed to set MEM range %pr\n",
> > > > > >  				entry->res);
> > > > > > @@ -690,10 +707,13 @@ static int dw_pcie_iatu_setup(struct dw_p=
cie_rp *pp)
> > > > > >
> > > > > >  	if (pp->io_size) {
> > > > > >  		if (pci->num_ob_windows > ++i) {
> > > > > > -			ret =3D dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_IO,
> > > > > > -							pp->io_base,
> > > > > > -							pp->io_bus_addr,
> > > > > > -							pp->io_size);
> > > > > > +			atu.index =3D i;
> > > > > > +			atu.type =3D PCIE_ATU_TYPE_IO;
> > > > > > +			atu.cpu_addr =3D pp->io_base;
> > > > > > +			atu.pci_addr =3D pp->io_bus_addr;
> > > > > > +			atu.size =3D pp->io_size;
> > > > > > +
> > > > > > +			ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> > > > > >  			if (ret) {
> > > > > >  				dev_err(pci->dev, "Failed to set IO range %pr\n",
> > > > > >  					entry->res);
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/dri=
vers/pci/controller/dwc/pcie-designware.c
> > > > > > index 2459f2a61b9b..49b785509576 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > @@ -464,56 +464,56 @@ static inline u32 dw_pcie_enable_ecrc(u32=
 val)
> > > > > >  	return val | PCIE_ATU_TD;
> > > > > >  }
> > > > > >
> > > > > > -static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8=
 func_no,
> > > > > > -				       int index, int type, u64 cpu_addr,
> > > > > > -				       u64 pci_addr, u64 size)
> > > > > > +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > > > > > +			      const struct dw_pcie_ob_atu_cfg *atu)
> > > > > >  {
> > > > > > +	u64 cpu_addr =3D atu->cpu_addr;
> > > > > >  	u32 retries, val;
> > > > > >  	u64 limit_addr;
> > > > > >
> > > > > >  	if (pci->ops && pci->ops->cpu_addr_fixup)
> > > > > >  		cpu_addr =3D pci->ops->cpu_addr_fixup(pci, cpu_addr);
> > > > > >
> > > > > > -	limit_addr =3D cpu_addr + size - 1;
> > > > > > +	limit_addr =3D cpu_addr + atu->size - 1;
> > > > > >
> > > > > >  	if ((limit_addr & ~pci->region_limit) !=3D (cpu_addr & ~pci->=
region_limit) ||
> > > > > >  	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
> > > > > > -	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
> > > > > > +	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->si=
ze) {
> > > > > >  		return -EINVAL;
> > > > > >  	}
> > > > > >
> > > > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
> > > > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
> > > > > >  			      lower_32_bits(cpu_addr));
> > > > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
> > > > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
> > > > > >  			      upper_32_bits(cpu_addr));
> > > > > >
> > > > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LIMIT,
> > > > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
> > > > > >  			      lower_32_bits(limit_addr));
> > > > > >  	if (dw_pcie_ver_is_ge(pci, 460A))
> > > > > > -		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_LIMIT,
> > > > > > +		dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_LIMIT,
> > > > > >  				      upper_32_bits(limit_addr));
> > > > > >
> > > > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_TARGET,
> > > > > > -			      lower_32_bits(pci_addr));
> > > > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
> > > > > > -			      upper_32_bits(pci_addr));
> > > > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_TARGET,
> > > > > > +			      lower_32_bits(atu->pci_addr));
> > > > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
> > > > > > +			      upper_32_bits(atu->pci_addr));
> > > > > >
> > > > > > -	val =3D type | PCIE_ATU_FUNC_NUM(func_no);
> > > > > > +	val =3D atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
> > > > > >  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> > > > > >  	    dw_pcie_ver_is_ge(pci, 460A))
> > > > > >  		val |=3D PCIE_ATU_INCREASE_REGION_SIZE;
> > > > > >  	if (dw_pcie_ver_is(pci, 490A))
> > > > > >  		val =3D dw_pcie_enable_ecrc(val);
> > > > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val)=
;
> > > > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1,=
 val);
> > > > > >
> > > > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE=
_ATU_ENABLE);
> > > > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2,=
 PCIE_ATU_ENABLE);
> > > > > >
> > > > > >  	/*
> > > > > >  	 * Make sure ATU enable takes effect before any subsequent co=
nfig
> > > > > >  	 * and I/O accesses.
> > > > > >  	 */
> > > > > >  	for (retries =3D 0; retries < LINK_WAIT_MAX_IATU_RETRIES; ret=
ries++) {
> > > > > > -		val =3D dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTR=
L2);
> > > > > > +		val =3D dw_pcie_readl_atu_ob(pci, atu->index, PCIE_ATU_REGIO=
N_CTRL2);
> > > > > >  		if (val & PCIE_ATU_ENABLE)
> > > > > >  			return 0;
> > > > > >
> > > > > > @@ -525,21 +525,6 @@ static int __dw_pcie_prog_outbound_atu(str=
uct dw_pcie *pci, u8 func_no,
> > > > > >  	return -ETIMEDOUT;
> > > > > >  }
> > > > > >
> > > > > > -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, =
int type,
> > > > > > -			      u64 cpu_addr, u64 pci_addr, u64 size)
> > > > > > -{
> > > > > > -	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
> > > > > > -					   cpu_addr, pci_addr, size);
> > > > > > -}
> > > > > > -
> > > > > > -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_=
no, int index,
> > > > > > -				 int type, u64 cpu_addr, u64 pci_addr,
> > > > > > -				 u64 size)
> > > > > > -{
> > > > > > -	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
> > > > > > -					   cpu_addr, pci_addr, size);
> > > > > > -}
> > > > > > -
> > > > > >  static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u3=
2 index, u32 reg)
> > > > > >  {
> > > > > >  	return dw_pcie_readl_atu(pci, PCIE_ATU_REGION_DIR_IB, index, =
reg);
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/dri=
vers/pci/controller/dwc/pcie-designware.h
> > > > > > index 3c06e025c905..85de0d8346fa 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > > > @@ -288,6 +288,15 @@ enum dw_pcie_core_rst {
> > > > > >  	DW_PCIE_NUM_CORE_RSTS
> > > > > >  };
> > > > > >
> > > > > > +struct dw_pcie_ob_atu_cfg {
> > > > > > +	int index;
> > > > > > +	int type;
> > > > > > +	u8 func_no;
> > > > > > +	u64 cpu_addr;
> > > > > > +	u64 pci_addr;
> > > > > > +	u64 size;
> > > > > > +};
> > > > > > +
> > > > > >  struct dw_pcie_host_ops {
> > > > > >  	int (*host_init)(struct dw_pcie_rp *pp);
> > > > > >  	void (*host_deinit)(struct dw_pcie_rp *pp);
> > > > > > @@ -416,10 +425,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pc=
i, u32 reg, size_t size, u32 val);
> > > > > >  int dw_pcie_link_up(struct dw_pcie *pci);
> > > > > >  void dw_pcie_upconfig_setup(struct dw_pcie *pci);
> > > > > >  int dw_pcie_wait_for_link(struct dw_pcie *pci);
> > > > > > -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, =
int type,
> > > > > > -			      u64 cpu_addr, u64 pci_addr, u64 size);
> > > > > > -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_=
no, int index,
> > > > > > -				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> > > > > > +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > > > > > +			      const struct dw_pcie_ob_atu_cfg *atu);
> > > > > >  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, i=
nt type,
> > > > > >  			     u64 cpu_addr, u64 pci_addr, u64 size);
> > > > > >  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_n=
o, int index,
> > > > > > --
> > > > > > 2.25.1
> > > > > >
