Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DC1625105
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 03:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiKKCp2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 21:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiKKCpI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 21:45:08 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2063.outbound.protection.outlook.com [40.107.105.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D95654D7;
        Thu, 10 Nov 2022 18:39:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZcjh8QG5UXNxOBSkHYl1tCwfT69YIaJJAzsF2AxT6L3RKchAr81NLSw9j1Um5VB/PnEfC9OG0xPbAA7vFQfh9gLWJrWE81y8v9ET3ggB0jZAMQBrPndty25+Jz+EDEN5w+Z41OSAKaX3Rw11tkO9swlTpHzNHa8skrAlkRfa1ODRahuLth2X/+Vtd1AltOEHiBmMv2W3/tdVQ9oAZUe1/fbqEKkLd0NzRYU0+QGOcLsOXHUEzmtryWabeE0qEeOx2Tp6gL/8DG0SJOLRHMJgDMucxnmqvEKp4ipMD0Cph2Ew26LDuLjFCNl8PTDUO0kfSo6PsxbSOXkpoiL6pHQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIhxl8vLNTjF20gPueSS4mUfs/25hSk4NAQRT+/mS/o=;
 b=EyWrRVeeuD/lkqIDFWhYaAOzJDt+G6UCagNidWA7qfRDP2+p60ZCoDlVJRpc+/Xy8LyWC97mQsCy3CK+nXqnQ+h6S97qqy1keCjsdUUwbN66DHiE7/EwxFYxG45+UJ2fmRbis4nzzuay9PjwUfPUUx8b2YWXm1fPZh4qZ5emjMBoDFIN561TcnXh7vpKl4OM3sDyzLqShIJy04qA7DAaPZMAHKNR4oQm+n9rB+uSCV97odMN/scarPt+Yu1opG3TZeCIqW/MMdt1/SccDEcgDuF2MN3fVlq4cdqA3EwPSOoACpFseTD1l+X4zjUKyCB/Acmwbk1QS23Q3N57/UOf8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIhxl8vLNTjF20gPueSS4mUfs/25hSk4NAQRT+/mS/o=;
 b=USzKc6O1EjkaQOJyp5LXfYVLQz9Oj26iZCQ4a8b/mSX1LujL1ayHqU/+6xne2sLNB+f8i5+jhgfm5eC344TbbKXr73EDdlBLtJLl4DfQ57rJ9ypMoeADRgxL6AVyPW+BQ9VyWC6ycj12OMkbur8m92xTMWMlmn1zCautbfpkejA=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by PA4PR04MB7567.eurprd04.prod.outlook.com (2603:10a6:102:e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 02:39:13 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%11]) with mapi id 15.20.5791.027; Fri, 11 Nov
 2022 02:39:12 +0000
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
Thread-Index: AQHY7sTonrEmeP19GkSdtJORZ+azn644VMCAgAC5MsA=
Date:   Fri, 11 Nov 2022 02:39:12 +0000
Message-ID: <HE1PR0401MB23317A2372FCE691C230806E88009@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221102141014.1025893-1-Frank.Li@nxp.com>
 <20221102141014.1025893-5-Frank.Li@nxp.com> <Y20Yt7T0bivqUvop@lpieralisi>
In-Reply-To: <Y20Yt7T0bivqUvop@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|PA4PR04MB7567:EE_
x-ms-office365-filtering-correlation-id: 64bc2e31-daf0-4e63-124f-08dac38deb21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1H0fEVAIgCRDX8imByyzl1QD+M94eh3QxVz1b4KYLziaSN8+JwnhYZWzX6LKvSTi/X+nt4jrpK9b6Kd/YX5HkeGBm/88G8FpLO32AMmTi7yNMJsjwe8fs4Mupwo9OkFoIDYnLGzPNzY1oTocfglKv7MWTFCHAXuKWMsJaBvB+ti2M5bIaEBCisOpxp0c9wDVIQZlKFNmpJzLNNZW7X39dl7+3xYF9+P4tIJLdYBGz61G/Px78S3XzaCdj7PhrnnV2onO4qlJcqzkjgnoYHIpY6QZG9NddPKq0+FA0x9nnU/WYGf3w66jAAhO3KgsimqjnKTW6se/M3Pw/3lU2L8kiv6xexVJSVljEVCJhFvFJnB/l5dUWbEn2PZsdWEQvHGs9wnuLTKLQNVsufMyvgruwirtwHgru2EQ3x68Up8/kBxmGBIqQWyqtXrRVCDr4HfES0evSv4T4ndAe10rd6iujgWsUi/1EngRLmf7BhXl5w04AgnCqCoeXeufxjfbMw8qPoSxNLbmKT2S+hqO0p3M+9w2HkN/DffiOJvkfP9jcke8KV5QzAup1LbnTdri6u0Emki+Jhqzkwz+MMCyQv0XYxIzUbYXYGkkYJh7+tQv4lc4Le8cU2VI6IUYHjuJ2vKxR9BY5207wGnQ01j4Vqgt0CrxBPbc9Kg9K5SHNF9fCTDcAWdd0hxmOA6dihfAufLQfpFX9flMs23RCWGwoZoIg09Ogj+ryY8PoRsTqXTywovzoc25Gq0ndLbzzgOl6DyHEMTC6FfgYZUT5aEAdZJjnI1ixwa3klQ2ZIyKkK9ddnA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199015)(33656002)(38070700005)(86362001)(122000001)(38100700002)(83380400001)(55016003)(7416002)(5660300002)(44832011)(2906002)(26005)(53546011)(55236004)(6506007)(7696005)(186003)(9686003)(76116006)(66946007)(54906003)(6916009)(71200400001)(45080400002)(4326008)(8936002)(52536014)(8676002)(64756008)(66446008)(66476007)(66556008)(316002)(478600001)(966005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SsMrubXIrxF9O7L6kiBcYjcHbtCw5o5zWmIv0VX2M66iiq7omUSNs2pJ9IKt?=
 =?us-ascii?Q?yvkMllhgZb2rsJgpBl8aVxA/1neYnpuv/5zX+Ct4bJSpGABP0MQOuv/dBrfs?=
 =?us-ascii?Q?VjLZH12TlD67f8L+qFsSRMPWYIv8GFPdBivT0uTiqzDRQ+7ALKGddrUCM5Sa?=
 =?us-ascii?Q?17Cl3Q6phqYuHl4ZRa7YaiIqCqgf7XJiUuKkhwq5NrglpsbQCjuBuiJL+I1F?=
 =?us-ascii?Q?8KBmYIGkU/JOInK0wNgmEIROQqOaatbUMJVTIoEBNcF2NjuS2cW2YdWe3eB6?=
 =?us-ascii?Q?vhEfh/e6O1Unh2remTbB82NX6jUQ6ItFYBMGOYU/IiOyAlNi8ic6CUxOxCYW?=
 =?us-ascii?Q?MzqkdDMkgtDS6JBSJ3fX0jUjfOgfugoCKvI7Tu5Qzc3Xf6MxpIHxaz+BbA7q?=
 =?us-ascii?Q?oUscQOmvJCP5LStkF+TuhDBBGOGtzKvl3e+9Mn+rc8Og7DZqb9ZNxICR3biC?=
 =?us-ascii?Q?fHuL2NuT9Tr5KO+DtLn+1Wm13h3ob+7nV7QozXdG9m8iKsgU6jZlMS+hCHlx?=
 =?us-ascii?Q?UxQmjLqK22PoeQG3gFfvr7OTEDBbfuvUHqlwqKAoSQWIN62e6aoWjnJm5ZT6?=
 =?us-ascii?Q?7tHduFYJwMYxS+cY+p2h+UXFECtcwAUvfiNFcWewMbuZmWSwnKaIif18oypm?=
 =?us-ascii?Q?wcMLMtbYfYCqcY0h2drRjTNGPkde8EJKF1dPl3ZN/LKqb/TcXO/trdQ5NsNg?=
 =?us-ascii?Q?c2/PqgEV7EIS/vAYmR33LZ74+7nHpLkTvnrL4iqRPTeXkOk6Kpnz9nMIuAJw?=
 =?us-ascii?Q?+N3JKHj18gQ2TsZ+Y3abKUGhFMFVhANY562PTmadEMJ709aLHG2F1BSkXRDF?=
 =?us-ascii?Q?4jUyQzp20a8eZkNJdA25EEXBX7gnZtebkF5PdxI6a9g6OzAKHNK2IKL8dgSB?=
 =?us-ascii?Q?y7R9GnymO/PCWhDklHvyrk6jLZ2XENTGAt+ZP2g4BlFlioqZx2CVq71ELdi1?=
 =?us-ascii?Q?kH0CQertIf3SjQFsa0g8QnGR3zBgGXi4yGrYZajnDdZns1k8uczupsaWmvzK?=
 =?us-ascii?Q?hdidMmfe93EHKiuR8Rfznr0ezzam+nb6zv181nNSViCJvb7IOEfqCTQE+lnq?=
 =?us-ascii?Q?v4eNrsT/R5KXBTSVTYiIeY/BMbEkVsktJWLR2UQscgAPXyZpSEBb5dhs5dTO?=
 =?us-ascii?Q?pAfeQjfVI99+JBB6FqpEkCoSBnavWvafuAcBt61QG7Mf8U5WRBybPU2x5l/Q?=
 =?us-ascii?Q?fmfMSL5T6XpwwzLwJsw0Yb1351aVYvQ6S7g5aWLZQzL/urLsUfAJS7pqrCpj?=
 =?us-ascii?Q?th8erOvRXx5uJRCVC8iuMnvPdjFBDqK5oCiOBJMFeCa6luxgHcdStFvz8avt?=
 =?us-ascii?Q?SDsThEwdQVa6L7aXCcjXGPqgaFloGTIJp4w86H4TVKZY8E2pk+HZpL0SPc1x?=
 =?us-ascii?Q?DSKjqdznJ3ph2HijpX/1kWpGFYaBPVtoeLezFL7K+SBmBfhVkjS8JBSxOzbC?=
 =?us-ascii?Q?dWfvip938/YbygZl76BATYZK5Qh09SjhNyNpZG7zsNyxm090HsK7kXPkDZry?=
 =?us-ascii?Q?gH/NKPteIIbD/JZrdkyMa0Cg2NSPznb3EPn5NWYmNfub+mDx8Cjojg3iNaUl?=
 =?us-ascii?Q?0HELpKhlUR1QSOQqZHQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bc2e31-daf0-4e63-124f-08dac38deb21
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 02:39:12.8314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RjyJzEFaj97Wb1LJnfs2ubINiCJa6aClxLEGS0SAj6noeBPEVlLnKs/X0ztT8/wvp1sqwD1LbHuJa7430d3wVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7567
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
> Sent: Thursday, November 10, 2022 9:29 AM
> To: Frank Li <frank.li@nxp.com>
> Cc: mani@kernel.org; allenbh@gmail.com; bhelgaas@google.com;
> dave.jiang@intel.com; helgaas@kernel.org; imx@lists.linux.dev;
> jdmason@kudzu.us; kw@linux.com; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org; ntb@lists.linux.dev
> Subject: [EXT] Re: [PATCH v16 4/7] PCI: endpoint: pci-epf-vntb: remove
> unused field epf_db_phy
>=20
> Caution: EXT Email
>=20
> On Wed, Nov 02, 2022 at 10:10:11AM -0400, Frank Li wrote:
> > From: Frank Li <frank.li@nxp.com>
> >
> > epf_db_phy is not used, so remove it
>=20
> Sentences end with a period (.). I can fix these things but
> we can't spend our lives telling you how to write a commit log,
> check how they are written in the PCI subsystem and follow the
> pattern.

[Frank Li] Do you need me send new version to fix "."? Or you will plan
queue these patches?

My means:=20
Mani's below feedback will make both live easy.
	 >=20
               > None use epf_db_phy and remove it.

                  "epf_db_phy is not used, so remove it"

                >
                >=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Fall%2F20171026223701.GA25649%40bhelgaas-
> glaptop.roam.corp.google.com&amp;data=3D05%7C01%7CFrank.Li%40nxp.co
> m%7Ca0924bed538a494cbfd508dac3304e8e%7C686ea1d3bc2b4c6fa92cd99c
> 5c301635%7C0%7C0%7C638036909484154968%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000%7C%7C%7C&amp;sdata=3DB3G7sfaSVdLDC8BG95WzpBPFO5lPJ
> QpThKDcEexOHfU%3D&amp;reserved=3D0

[Frank Li] Thank you for your documents.

>=20
> >
> > Signed-off-by: Frank Li <frank.li@nxp.com>
> > Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 191924a83454..ee66101cb5c4 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -136,7 +136,6 @@ struct epf_ntb {
> >
> >       struct epf_ntb_ctrl *reg;
> >
> > -     phys_addr_t epf_db_phy;
> >       void __iomem *epf_db;
> >
> >       phys_addr_t vpci_mw_phy[MAX_MW];
> > --
> > 2.34.1
> >
