Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A469062A35B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 21:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbiKOUt6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 15:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbiKOUt5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 15:49:57 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95124A45E;
        Tue, 15 Nov 2022 12:49:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3z68MzlU6bVKGnL8G/C2AatB8mQoPuKuzdUTdnCQsCgXU4r5dc56Sa6tG7zXnPCjHapVPD4NNsARjfmiGaD4fR8MBCo2JwiP+rcGBs+TfnBU4wtDZqSxKnkNODssrHfoU02YtVVyZHcteYszyihMkVXheMHB6MdR9Z/MXs/Erz6LNeGkXeZfIR0EczdxAayGlrNmoGpObdNpktwcGQECrC58vG0/ZBlv6RKXmaH15Hr1CpgWQ6cdqFVvu4E1Gr8dFR7Af2LPD7dEGVqkEKkNAw51Q0ES3fe3j8HMQhjdz9rsuLqRK1ZjS1Lhxx+fIApI1yttRj3NxF2Y+OkIuG7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2xd2luHoS4IU1h/aS5oxjSIiXbwn2f3Yc7CXEptHyc=;
 b=FEvybzntWPrh35Bb5YL8Oqf9C6qoMyjCovlxmyVfIYtDejGzeEVW0uSs5V546gLY/MdN+7S5YGbA2mVF+xTuJ5WKC0RQryRv4HHz00ojfffdOJrVZLBs3XwDyIIU/hdweXaeFaHk5TWgqsrSkUmdhaoGtR4zCuyB/hwr6DSmNUypb2ZQIvr+c4rDwND1T5K94Uu3NYxYxirEo8QeY4KVATRUQuuhhVqxi7j7UFjpFK0PrspxIU3k3XqE70ojFwFVOjAkOBQVnSuyZx1qkWrlMU2VLggKKIPGMh4EOQkCg/0qwn7RWpJoxYC09KYQQsJzr2WX85E/8dgfI2ePaPxtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2xd2luHoS4IU1h/aS5oxjSIiXbwn2f3Yc7CXEptHyc=;
 b=KJ04HTsM20W4MIly//EmOcTHINJJxnP4NIZl60otDHrEuwi/ZTJ1vhexqwPS30xiFKMiwP7leB7NbcP6cns1/UPuDUV6qUSNDLJfHb5XtxQIW3SQiXSUYCdhzTpAB6acD1x6Y1nZOQIvPzt2+Trz4ncUc85CaAOuItA+fcyhHkA=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AM7PR04MB7110.eurprd04.prod.outlook.com (2603:10a6:20b:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Tue, 15 Nov
 2022 20:49:53 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%12]) with mapi id 15.20.5813.018; Tue, 15 Nov
 2022 20:49:52 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
CC:     "mani@kernel.org" <mani@kernel.org>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kw@linux.com" <kw@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v16 4/7] PCI: endpoint: pci-epf-vntb: remove
 unused field epf_db_phy
Thread-Topic: [EXT] Re: [PATCH v16 4/7] PCI: endpoint: pci-epf-vntb: remove
 unused field epf_db_phy
Thread-Index: AQHY7sTonrEmeP19GkSdtJORZ+azn644VMCAgAC5MsCAAIzCgIAG7pog
Date:   Tue, 15 Nov 2022 20:49:52 +0000
Message-ID: <HE1PR0401MB23316A12EB6890260ACB9E8888049@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221102141014.1025893-1-Frank.Li@nxp.com>
 <20221102141014.1025893-5-Frank.Li@nxp.com> <Y20Yt7T0bivqUvop@lpieralisi>
 <HE1PR0401MB23317A2372FCE691C230806E88009@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <Y24qJb9UisCqpdKZ@lpieralisi>
In-Reply-To: <Y24qJb9UisCqpdKZ@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|AM7PR04MB7110:EE_
x-ms-office365-filtering-correlation-id: b6801aab-ef43-42bd-0a8d-08dac74af1d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J+GRflNKG1FOCWcDReb++xiTMG5mX910l4GRoSNwUiWRXNIKvZdNjmDlYRZQTjWOSbNOJ/Bj60TV7KJbDAojpNTy2iiMOAnc78F5dR7E4XIsyOHgvr/xqci+V5Vlbl7QhWbaygn7vhdpTocNE06EMZi3cF64esk3eG3S3hk7lnLBUDOo0VcMvdDPkWglqBprSL4LZNy7O/wzk5uTKlNt6F/5gBrJrdrBw2HGqk4dOb1S0JMIsj3FHdv5CdMaN7jkKI59S2cLsfUR7pSEwjcG6/ZtDdivxMAbzBWA1eelIsdI+BTiQYCb+9ff5nDKHGQOENwrzqr29H84fXzjehAVJxaWah5wKaDDIJlQNvimX0xGGD/8gL7q0I0M4gxuxs4lOtfM3isB/bqid+NDjpIKOIhVI8I51U1Uo0op64oy2cQQ1gIF+LMqXf3bKXQVNKvze4ngP9puDAkY+5B0XgI8vdvc1TEEsUsh3aEqdmJ7mI3FwDrPidRea9RTAUiAIIPJzznx8LZZ7TNRodmma9GYJ1h8M52dKN+UCI1EhfLixsbAraQd96/BvZ1pbbRvF0sPlT0kOuSeJHBK8HiBYNnvnC7fe40GfCUmCNwWfQYkDPsJLPYvDuD5gUjfDUhWzD+0vAnUolqiCiBhiWds1E6Lk1sJT+0tHtP6zfDRtSnMKHg2AQmeKtpzKMhUfyyrgYQqOWNNoWBQpYqC/boK/ZxKt9kvREdW/HvV+osQyXi5AaG9EZLqwNOcCz5oIwETL2cpJEf4kGPn0ddDjMt7/v9FC+5B3OXhR9Q+kYTJwhcWCis=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199015)(5660300002)(316002)(6916009)(54906003)(4326008)(8676002)(41300700001)(186003)(66946007)(66446008)(66556008)(76116006)(122000001)(64756008)(66476007)(38100700002)(38070700005)(83380400001)(7416002)(8936002)(52536014)(44832011)(55016003)(33656002)(86362001)(2906002)(9686003)(7696005)(478600001)(966005)(6506007)(26005)(53546011)(71200400001)(45080400002)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LluW0ZJDTt/VCqPxnGVah7V47UVMtKuBDQg0HZJRhA5FyuA8mpmjmWnuur1Q?=
 =?us-ascii?Q?mEFUjLQMUU+Q76yMRFIBmann8Xe8H8vGsK5PZE+91QcIAiBZmsMlsZQhCIb+?=
 =?us-ascii?Q?Iuq447LsCPYxv68TNxPLC1AhuYVATLQ37+TfMSXLQqiV0jq5rvmTebDqY+XQ?=
 =?us-ascii?Q?R7gbkUYBMaOHZ3OYd9RarM1l0KD8e9uOUPsBlJSq3BKUyEaA2989/vEoUWh+?=
 =?us-ascii?Q?ri+kJ72k+iaw11fslX4bG7LvSfavH2zH1jrRJXX+t+/rIWpIfiBvdfQpJqC2?=
 =?us-ascii?Q?a4EE/R9WAsMRUBPKzO/eUgGYZjFuB8HvW4kIi9y5WWV5tzcgGNwDIgsE7Wi5?=
 =?us-ascii?Q?z2cotvton9dkIgD48uxh6THtoeQCyMNlQvcEoSMBnO5v5h8kP9Zq1o5T9rSh?=
 =?us-ascii?Q?wcebP0hY/xK51AjqwfICnU/qS0zG/JVfLYnmb/WJ53QUor9Q78mKS3e0tdCG?=
 =?us-ascii?Q?s7WdbzoiYxeOBR8I6/2NkJexnaPWaPpNKIFKAq+5W8iwX5bW/CddVSvGOw7v?=
 =?us-ascii?Q?1AY8TiOb4p0JGDyjqhVrx2zcdVI5eiInc70VZuzjAvikXLVQCBHj0ObV8W9U?=
 =?us-ascii?Q?s8M5d5fhsxuJH8WtlbwVoVuCu6WsTmmv9dP/8dArlJX5GIAi7szKVQjBYDS7?=
 =?us-ascii?Q?7Rv8L9kA5MZnx/nWnkAos17VV96iNp9b9P9ALThwZiPf5E1iaNPe+2qFK6ES?=
 =?us-ascii?Q?mzDIKn+yzA71eknxID/l1At+nKqU10HdmPnE62Jw+5PsS08bQj542kiFr+DY?=
 =?us-ascii?Q?ujZ0bfxmOUb38u9rhDzGHce+YsOrtx1oIqEWoV470oEdM4QpXZqKY7zMvyDb?=
 =?us-ascii?Q?oXLlJAr0VL/5PixKNE7WyVDJwQ3mhnLSSAKnrJG2k3etLGwL7gqZzpTy0pay?=
 =?us-ascii?Q?wzzSSx1cpjE6fWFFSWolDZmtoCrb/YOetYBeqpu7F6DXzxJgg532iBuU9VZI?=
 =?us-ascii?Q?Wmk5DeEbkRe8wlT/rl2IllaihFE2gRVIaEAZ2WmZckWz8HIO0a8qtjErjZZa?=
 =?us-ascii?Q?3/goMGjTDgn7ka6p4vSlMmf+voziCDHG0IQTY6FEhPAn6rPT1UjJC9GiLB03?=
 =?us-ascii?Q?+7fsLG8H9/LsKZmK8VmEEcf783tlAqEcTmgk4AXgU5bUDX1ozBPndQBexU+N?=
 =?us-ascii?Q?OjdtQA1paEBYLbKqbb/I0MeXQOrhjPpHhaU2yXh4SJZvSBGmMOr3g6J4PKIL?=
 =?us-ascii?Q?zXr750xv+b2TynRXP9nP+gtcbApdqTgQ1C4HuNA3fNplOKjuV0R4/lVWTPwA?=
 =?us-ascii?Q?QWODtuTIXn+EVWIgWBgEwakRJ7uuuZGbz35k+ECR9/wBezYfEn8Kox0HiDXm?=
 =?us-ascii?Q?c0wUd7YrxL/6uB960/lF2FwFVNjuRmN0dL54nyhz66ijf5WPwIiq3TS/U/hk?=
 =?us-ascii?Q?/tkE47PEyF73rgUjKjz3O25JYVJnXYnXRbk+JagpDKe05GlPzy6cNTcyiLQX?=
 =?us-ascii?Q?HqaiQr/YlFIp+6s0Tc4X+f5thvneXboJYlSR60djAtoqia2M5PtXG6JcO72v?=
 =?us-ascii?Q?QR5WRySv/9VXN+m3sHiebch/zqexoSgtAkQOMPIOFTlzem00C1pX9mUrlFIC?=
 =?us-ascii?Q?gAOzUiRSV84bv+8N/6c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6801aab-ef43-42bd-0a8d-08dac74af1d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 20:49:52.5034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4dgMs2MkqG+XbTbIFRgwZNf8lnTDZruK2ZvvaQI7OkaLBvaYJf/n398Sanlo9khDKF2Z6XWxkOZg6lbi66Lrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Sent: Friday, November 11, 2022 4:56 AM
> To: Frank Li <frank.li@nxp.com>
> Cc: mani@kernel.org; allenbh@gmail.com; bhelgaas@google.com;
> dave.jiang@intel.com; helgaas@kernel.org; imx@lists.linux.dev;
> jdmason@kudzu.us; kw@linux.com; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org; ntb@lists.linux.dev
> Subject: Re: [EXT] Re: [PATCH v16 4/7] PCI: endpoint: pci-epf-vntb: remov=
e
> unused field epf_db_phy
>=20
> Caution: EXT Email
>=20
> On Fri, Nov 11, 2022 at 02:39:12AM +0000, Frank Li wrote:
> > > -----Original Message-----
> > > From: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > Sent: Thursday, November 10, 2022 9:29 AM
> > > To: Frank Li <frank.li@nxp.com>
> > > Cc: mani@kernel.org; allenbh@gmail.com; bhelgaas@google.com;
> > > dave.jiang@intel.com; helgaas@kernel.org; imx@lists.linux.dev;
> > > jdmason@kudzu.us; kw@linux.com; linux-kernel@vger.kernel.org; linux-
> > > pci@vger.kernel.org; ntb@lists.linux.dev
> > > Subject: [EXT] Re: [PATCH v16 4/7] PCI: endpoint: pci-epf-vntb: remov=
e
> > > unused field epf_db_phy
> > >
> > > Caution: EXT Email
> > >
> > > On Wed, Nov 02, 2022 at 10:10:11AM -0400, Frank Li wrote:
> > > > From: Frank Li <frank.li@nxp.com>
> > > >
> > > > epf_db_phy is not used, so remove it
> > >
> > > Sentences end with a period (.). I can fix these things but
> > > we can't spend our lives telling you how to write a commit log,
> > > check how they are written in the PCI subsystem and follow the
> > > pattern.
> >
> > [Frank Li] Do you need me send new version to fix "."? Or you will plan
>=20
> You don't have to write your name in brackets all the time in replies,
> it is clear from the indentation what I am replying to and to whom.
>=20
> > queue these patches?
>=20
> I will queue them but next time I won't fix the commit log myself.

Do you have chance to queue it? I still have one patch (enable MSI)
depend on these patch series.=20

>=20
> > My means:
> > Mani's below feedback will make both live easy.
>=20
> What feedback ? I am sorry I don't understand.
>=20
> Thank you,
> Lorenzo
>=20
> >        >
> >                > None use epf_db_phy and remove it.
> >
> >                   "epf_db_phy is not used, so remove it"
> >
> >                 >
> >                 >
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> %2F&amp;data=3D05%7C01%7Cfrank.li%40nxp.com%7C200a354ecae54e7b1af
> 408dac3d34892%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> 037609466107831%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&a
> mp;sdata=3D3ngvYAIP0oTTF1uwAAHFAFmBVi1FvKtgTTw1u3tDXUg%3D&amp;re
> served=3D0
> > > ernel.org%2Fall%2F20171026223701.GA25649%40bhelgaas-
> > >
> glaptop.roam.corp.google.com&amp;data=3D05%7C01%7CFrank.Li%40nxp.co
> > >
> m%7Ca0924bed538a494cbfd508dac3304e8e%7C686ea1d3bc2b4c6fa92cd99c
> > >
> 5c301635%7C0%7C0%7C638036909484154968%7CUnknown%7CTWFpbGZsb
> > >
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> > > %3D%7C3000%7C%7C%7C&amp;sdata=3DB3G7sfaSVdLDC8BG95WzpBPFO5l
> PJ
> > > QpThKDcEexOHfU%3D&amp;reserved=3D0
> >
> > [Frank Li] Thank you for your documents.
> >
> > >
> > > >
> > > > Signed-off-by: Frank Li <frank.li@nxp.com>
> > > > Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> > > > ---
> > > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > index 191924a83454..ee66101cb5c4 100644
> > > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > @@ -136,7 +136,6 @@ struct epf_ntb {
> > > >
> > > >       struct epf_ntb_ctrl *reg;
> > > >
> > > > -     phys_addr_t epf_db_phy;
> > > >       void __iomem *epf_db;
> > > >
> > > >       phys_addr_t vpci_mw_phy[MAX_MW];
> > > > --
> > > > 2.34.1
> > > >
