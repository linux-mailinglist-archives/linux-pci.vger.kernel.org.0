Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04025624B0
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 22:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiF3U6z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 16:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiF3U6y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 16:58:54 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130084.outbound.protection.outlook.com [40.107.13.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FF74881E;
        Thu, 30 Jun 2022 13:58:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoXlWkccdpyVgRKQhsyQmR3fYR03xn+CwgWEaXiSYZq1UDmaMdXGUc+2aeMRr94iSEbT1nmFMdszPOc0zU8vmZBeJfBG72MjKzYhQbu4H+Zgj8ZDvOc3QZXH5lA2NP1HqVjEn35j9cxFaA36c/mjsISPPqocqKWu5/G0haiZ4cqUDz0icBV+TB/i3GGfF/Sx+VnHxsnfhOMseeElIjlnUkCGqXbPviQwyN56IXM+c2QH9A3siaCjr5vp26FMRIad9TCEDLFlV/H889FDMVtLMbiNoqzuFm8MZo0XeU9OLcnvdwn/bAIpz1YFC4+Lqe9vRGhcp0Es7PZQDon1tx3Ihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyyCT7ru+AVoNH08Zpt2zzJt/YEeEXWx25gFAdyyMm0=;
 b=nkcG3wPQY7hX4+jIE5n8Kvp140LPhblipL5vm+mfP3yYd8i8gmAT+hQWT8sd7KIbMiUzrC5SxJw9Lu1ZmJfOsDIJ8LeVeiLiseklP1XpsM8JUbr6Jr0XGppANfF/gKUndzMlx1PFDq3VGS1XDC9M1KCaWKkvG8Y4VliQ9u7BOJUbZhKpc23f1lkEk3K7ccUh1o0rL1GThOpNQJOKlt9QeemSjWPjaS4PQdzI/U/cXAp2ITbxbNoan2ZTMrvoH0CunbMSum+CTtDWbMvtrYj51s5tnJbB6NK7aDQsQu+vf95yt0rJ1bjvJYcASBklHvZ17q50I12x65Zxcrkud9zmsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyyCT7ru+AVoNH08Zpt2zzJt/YEeEXWx25gFAdyyMm0=;
 b=C7N7AmLIWC8F21eEQiNc9ALPDF4fPuN08+3YvfOpmp+3dSvfyQ4Wn66kpbkAPTXhWbSiaEosWMRNzfKH1ncgaczZuF6FA+kmf7SD7HAVArw0AjtDIhbPvw/19ercJmtt7yfKbuFfHjRoYExNDSUy1FcaSaMBRGJvnOjQfTfm27Y=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB4625.eurprd04.prod.outlook.com (2603:10a6:208:71::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 20:58:48 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea%7]) with mapi id 15.20.5373.018; Thu, 30 Jun 2022
 20:58:47 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Tom Rix <trix@redhat.com>, "kishon@ti.com" <kishon@ti.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] NTB: EPF: reduce several globals to statics
Thread-Topic: [EXT] [PATCH] NTB: EPF: reduce several globals to statics
Thread-Index: AQHYjMLaeesEUccliECcKt+tSgyT0a1obPWw
Date:   Thu, 30 Jun 2022 20:58:47 +0000
Message-ID: <PAXPR04MB9186172AC78714446493041188BA9@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220630204859.4134463-1-trix@redhat.com>
In-Reply-To: <20220630204859.4134463-1-trix@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e6e1402-f549-4b5c-57be-08da5adb53e9
x-ms-traffictypediagnostic: AM0PR04MB4625:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P1JmcxeHCYE9ESY9qA2zcwb37no/AtpU8X16cE52eM82ePNVTBTVYv2jHEl3lGAbPGUDU3ZGppvro9LfUB3JWy4hSvny5v7AlJD7hBk7SfbTFCFbk8lnI27iqduorb+nYhepQBi1uFc5LiNLcNYqX2BICKHo5Ll4RwIX2CWBzqc64rTnTA3bMHYH4sRKQTUYJ8yTR8+jW5wa2B4sqrsEDWOSjpse2G3IE7G+SdbnGFLcmMoS7ZCCmNuSHPd28rjf5GF+3ORaRvi5MOZI6h88LDhV/7ahLuNJqNGTk65LCreIAOfBNaZ7NNQdiMNFlzqwasBFjMqWRbnxBW8xLQSWzR2AKt+GtsPzachDxP4pNTzolc6R670QXg8qt1Pm8pGrzbxFh4Va1GwcnWKC+wkAY0PY/HrTabVTW0/bjWlOxTb01zF2V3NV/sWr6pbzdYJ1S4+4ueOo39rIw3OrbAFIO6/uKBQmcdWrLFnbchiI5+NfTeI0HsMXIWy+jp8GwU7soAP3EzJZsdPV/GdsqDLbnoZC+OnmmmYc7rkDsJ4dfsFhThLaAaSQNR7bVStj2ac+0k074X1nObv41LoxO0ve755BlIK+FIzgilhIJE/byUf4abCRAP17zjL1VEaP8VVgf8yA2QbM9MgeOE5iLCrFrRnWujBXeYsO6/f08Z4jfCGJFbifCeC2vYMbfmae4VS9HSaG2luL9ejUVdb7tpfjj2t/RQqtTuLeU/RdqXN61dUqERnS1dnw5TurQLm2YINi8kZi69MjhhDi9kU+J4YzKbt58fJmVQY0P8yS18tt3HaLI1C134NypAkkw9KjSiGE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(26005)(71200400001)(8676002)(9686003)(55236004)(41300700001)(66476007)(66446008)(38070700005)(53546011)(44832011)(64756008)(86362001)(7696005)(66556008)(6506007)(33656002)(478600001)(122000001)(4326008)(8936002)(83380400001)(66946007)(55016003)(38100700002)(186003)(52536014)(2906002)(54906003)(5660300002)(316002)(110136005)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zG79Uzp4IGseV+XA7fN8Ezo+EXtCuCs0fdBbe3ZlbSs22C0R2NdGUbWfUqdZ?=
 =?us-ascii?Q?rKSVrMd9M5VDlbDHh6yem+I8xLI9hCMucZw+k2nktiiyUWLVek+MwWKAyrIQ?=
 =?us-ascii?Q?a5U9t1qbpp4TRuB0hnu6x3fP/8yCDnkcD9kimvZ++BNXrbJBsPWtI9+JfzxP?=
 =?us-ascii?Q?DZIYivDFu3+QiYuNTpP1MiMhTuvAr4OeduaLpVLXEEpv/4AaZFKVNfaLJjaP?=
 =?us-ascii?Q?5nD7R95RGpT+oCFCkuWS2ateJfLu7Ta+XFmwHuL/KRFMF3cm5Xy3Rc4xUO0Q?=
 =?us-ascii?Q?S/htO5xTi8mOz5JSAwhfFLLg3N9+E7EoHAj1h4WKrxJCWuM6ZGGdvPxc05BA?=
 =?us-ascii?Q?tHz+XoJapKoAZAoggtAK0lb/mo3f57Km/yNbu0vPCsdt96in8D2HWd6T830K?=
 =?us-ascii?Q?mlw9NvtKYSk3UU/fjahH9+5f2OywYgQAuK5hZT2nrhKtXfr6ckDG57Yar8pu?=
 =?us-ascii?Q?cIsNUHS+1vnvZYqU06l8YJD7lKnvS8nULL2YIJOYLUkz6aFVIF0nX66MswdB?=
 =?us-ascii?Q?LjOFvKYNd1A50AiXMZ8uOQewjzNY8iVdhfvsQYZ63bEa7cAv2TN0mmZ8o4P1?=
 =?us-ascii?Q?J9xO8oRINBXxcohuMfwbuHrDa08VdijKOpz/sQjMfOTIKHxISpCNPikr0Px+?=
 =?us-ascii?Q?zJbNHK/XTjnuobiKbRmlmkyoULSyiMu5R3eQUMfvLHhtftlJIR5/AteIcWdv?=
 =?us-ascii?Q?yaaHSgvoBlxNTnZyzNPHHMyk6E/m0Gb7c84wD+wAnMFA08GynIfdbpv6drlY?=
 =?us-ascii?Q?9xl5EcTZv2bKbQSlpfEWrdFf9hj1yRjaHXbEqvIX3vq+vcod7lJlh2uVOd2I?=
 =?us-ascii?Q?M/me0dRg6pln8qQCuo+rLLirj2r83DfZv0pX+qRK4r+8NQceOX9p6Cbsv5kD?=
 =?us-ascii?Q?hF1bvDa4qNK+8NLcBKGTXebu+/ey3ryIlzxkrqL4Q62Vw0FsqhGKOqTBtTqP?=
 =?us-ascii?Q?M5ImF/4KcQPi4Hz6J4jKRJQH9x/zoG7KLSlSF0hHd4SzltEi12sbC4o6+bIC?=
 =?us-ascii?Q?Ti+FZiynzZ75wgL3apEcKtseXmxVDRw1/KA1pMo2vjMsKPtPfNJEs6ZO1R0U?=
 =?us-ascii?Q?TBIjg2PtkkApPRhxLWPM9O4DiKMq5faK25/ERRRytzM7TuWkPX2m12LxY36+?=
 =?us-ascii?Q?dYVAk0METyy8tmtfQqyJEkB6K33rn1m/wBGI4eRpb/kGGYWoWcjW1F46FvCl?=
 =?us-ascii?Q?crrI8Ktrk+tkXi0hiOocOl1l9Bxyn7qnA1DJmtQ6dE8KAoOFC3tMxQrRdfzu?=
 =?us-ascii?Q?L/0pnQ2n+Kb9QAuL1ohdvxdqHGPJbUVNIxKfovXrnZG0ku7Gaj9pAOU6t2vX?=
 =?us-ascii?Q?uW3MIVeQWBjeX0L+YN8yOaMwGg7NUqFw1PNjlLCk5m/A/ZIWzPiG4RJ5SN3p?=
 =?us-ascii?Q?SoQkmUOfz1YzazXgAHFq3n0RtVccPw0JQE7iCQL/Swl7JlGz+zMalhPVKqqF?=
 =?us-ascii?Q?ShoxuzWH+VRF6WlIXDiC7C+ZQr7n1aWdUqIJsbmC/Hx6lBfsI+g+BZ+v8D52?=
 =?us-ascii?Q?+LCgp/EgD5NwoelbAYTsILVVAptkpoBipahsiGq1ITL0+LH7h15vl2XZAFHn?=
 =?us-ascii?Q?w1/PT2jg94smcoYoBk0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6e1402-f549-4b5c-57be-08da5adb53e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 20:58:47.7860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LEe2UgF/0EJZyEjCAqNCPESCeo9V2a++cmfxHKOOt3zv8ZaUsXxrYKrWJOsZtOYAQtGmm+eoQcZya/Z34y2Vcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Tom Rix <trix@redhat.com>
> Sent: Thursday, June 30, 2022 3:49 PM
> To: kishon@ti.com; lpieralisi@kernel.org; kw@linux.com;
> bhelgaas@google.com; Frank Li <frank.li@nxp.com>; jdmason@kudzu.us
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Tom Rix
> <trix@redhat.com>
> Subject: [EXT] [PATCH] NTB: EPF: reduce several globals to statics=09

[Frank Li]=20
Bjorn Suggest use " PCI: endpoint: ..." at other similar fixed patch.


>=20
> Caution: EXT Email
>=20
> sparse reports
> drivers/pci/endpoint/functions/pci-epf-vntb.c:956:10: warning: symbol
> 'pci_space' was not declared. Should it be static?
> drivers/pci/endpoint/functions/pci-epf-vntb.c:975:5: warning: symbol
> 'pci_read' was not declared. Should it be static?
> drivers/pci/endpoint/functions/pci-epf-vntb.c:984:5: warning: symbol
> 'pci_write' was not declared. Should it be static?
> drivers/pci/endpoint/functions/pci-epf-vntb.c:989:16: warning: symbol
> 'vpci_ops' was not declared. Should it be static?
>=20
> These functions and variables are only used in pci-epf-vntb.c, so their s=
torage
> class specifiers should be static.
>=20
> Fixes: ff32fac00d97 ("NTB: EPF: support NTB transfer between PCI RC and E=
P
> connection")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index ebf7e243eefa..6f0775b1fec3 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -953,7 +953,7 @@ static struct config_group *epf_ntb_add_cfs(struct
> pci_epf *epf,
>=20
>  #define VPCI_BUS_NUM 0x10
>=20
> -uint32_t pci_space[] =3D {
> +static uint32_t pci_space[] =3D {
>         (VNTB_VID | (VNTB_PID << 16)),  //DeviceID, Vendor ID
>         0,              // status, Command
>         0xffffffff,     // Class code, subclass, prog if, revision id
> @@ -972,7 +972,7 @@ uint32_t pci_space[] =3D {
>         0,              //Max Lat, Min Gnt, interrupt pin, interrupt line
>  };
>=20
> -int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int siz=
e, u32
> *val)
> +static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, =
int
> size, u32 *val)
>  {
>         if (devfn =3D=3D 0) {
>                 memcpy(val, ((uint8_t *)pci_space) + where, size);
> @@ -981,12 +981,12 @@ int pci_read(struct pci_bus *bus, unsigned int
> devfn, int where, int size, u32 *
>         return -1;
>  }
>=20
> -int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int si=
ze, u32
> val)
> +static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,=
 int
> size, u32 val)
>  {
>         return 0;
>  }
>=20
> -struct pci_ops vpci_ops =3D {
> +static struct pci_ops vpci_ops =3D {
>         .read =3D pci_read,
>         .write =3D pci_write,
>  };
> --
> 2.27.0

