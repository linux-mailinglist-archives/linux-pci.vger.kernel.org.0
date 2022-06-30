Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A845624E0
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 23:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbiF3VJU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 17:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237342AbiF3VJR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 17:09:17 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20086.outbound.protection.outlook.com [40.107.2.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359F61EAF2;
        Thu, 30 Jun 2022 14:09:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgCoawlGID8cYVPMsH8UGFFPJgfD/c4Fv5KlbI0EG/I4ia7ZqlKhEQra7fRDpsRDFVxHNPoORHVr9pFqvAYuxSLmqbZazn34e6fV+uTLmasUn0KM8MYWSRBngnCSvyxkUUGEnDcdhScXa+tC3l9exNHPOnGzM2XsMQ8Mcc67ol1pat8i2tX0mMpRRK6yfaFk96KQt9U+TQWgKKJy2LMRqUuGkhwjtVGJ8Q8Ylpq9lYWvYwHEy3D6RH6AW2wSmjPFVq4yf0QEwpjGHCx1s5Zh4sRHxoV6axnMuWQmcV7EzhOiaaa9jYFcgUgEntJye39UszeoVbMY1xeisNY1OIH6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjwCtcMoXGGhA85UQ4gin/m45Dy+qrMYgjFioig+Vc4=;
 b=NHbW+0aU+anDF/AZCyj3V6xkea/OvNgCk/frSrWbDPXkUPhtWrI8rm7kTlrOCNFRt883wtZlxZP21EHs6B4jYdbO4PEazduP8Fff3jHH8HbBM4NXJ5MKYjBxTaX+O6PboPbgYAkrAFXQoaS1UBRxCSt6heAVTOYOGx3BCohg2d+OfBJCOM7MQZNYumARILbfyMgCL7da5PYyaW+FHfqL7sEbFJc90lnqOyUzwXdfuJep7i5u5Nk65gF9LEYysRi/J4GcGcKOMN/Z7S5f1R0LwDGtt3OVCq7zWyYVDZ5fZ8FOJBp/xU+3y4Cxwta+HHukH0wmXwSaTmMRDaweTqPR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjwCtcMoXGGhA85UQ4gin/m45Dy+qrMYgjFioig+Vc4=;
 b=Ffn58z1fkKzuRe7rxsWcSnMJDkXPVgIXqonKCMU1WQpa33GSkWuvNhx6QDTK1qQn0z3bmYHdo68ToZpTBCh/pMjy+63UW7LNNDUnCZmK4HQoRnyx5EO0SnSiT1JFN0hU6djDkQbwNAsiyj/aW8N3KsOnEYYKJDUJKSw5jfRkfXc=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by PAXPR04MB8893.eurprd04.prod.outlook.com (2603:10a6:102:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 21:09:13 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea%7]) with mapi id 15.20.5373.018; Thu, 30 Jun 2022
 21:09:13 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Tom Rix <trix@redhat.com>, "kishon@ti.com" <kishon@ti.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>
Subject: RE: [EXT] [PATCH v2] PCI: endpoint: reduce several globals to statics
Thread-Topic: [EXT] [PATCH v2] PCI: endpoint: reduce several globals to
 statics
Thread-Index: AQHYjMVHk5JWT37pHkqd/SLw7itFJa1ocSXA
Date:   Thu, 30 Jun 2022 21:09:13 +0000
Message-ID: <PAXPR04MB91864363B29A14331E2E8AFA88BA9@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220630210517.1825677-1-trix@redhat.com>
In-Reply-To: <20220630210517.1825677-1-trix@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d968ab37-dce1-4fb2-0bb6-08da5adcc904
x-ms-traffictypediagnostic: PAXPR04MB8893:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vy5bwfEHnAIOuBdhaNyttMy9yhDMRarMDB0yh4u7pfEWUFpP3h38SYm1/sMWzezTBkt5pibip7vnZttrGyW+9TyKEpXL9MoBZVD69R6t7U5jtjVIYPaAPBTjjCmA1KrinZzsmVGltzBghcIO+hIzWgQcp1x6fsUy7lgH86w+z8tkVansapiPvDZRtO3s3UMiW9cW5PMmz0jENT7yQpuCQF+1l58pgDc0QbsyckKCmRRu9oKjV6cvbwAiomBf9cbBN+0+syU5AIbXrbdgGtY31ZahIcuQ/4VaPqwp+zJOQ6skQUXGmS2HQA9XGDcxte7zcRoSaj2PQWWppVoVKlIoPYN37yQW6s/3A/lS6tbXgnawTq8GeElsj3ibqchXRfl1PKTVx4xB3srrqZXt8MNeCh99BeeNiZgy7HELuINhtDuy/b+51owYKiQ8OkZXfyfl17gypZFihdpoVQnXV8UnysBCN23dxDG7EIkbCirom1vqWiwd0RUy6TUqh04LNWdJO1alvJUZNxpq9smiyWf+az0j3PNeV1y9I9C7WXDOh6AfMCjJoBpgPdWw+ldlrsVX0CUibf+Butm80LNcFs5i5rMrspOZ8naTAmfqAXCFfMCvZl1xuSVQ4A7hBEbOQW4Ej0wHykkJkUA8b4UoBag7/E8litOTZmAD21Idvo2KEut9UHxuCcfGUbBaSeG+Ttu9UButhxLAUDbONuh3FTwoUxoxSPdlgyarm5RBT9vRRkDPJNs2iIhSraeLlT5wejU9TRAXuXvajIp5FBgGV0Lr5a/N4EFa1+MSNxa/O8dmokN3d8X2FpO3V/S+8xNbZKBw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(26005)(55236004)(53546011)(86362001)(9686003)(5660300002)(110136005)(2906002)(41300700001)(6506007)(38070700005)(66556008)(66446008)(38100700002)(8676002)(54906003)(7696005)(4326008)(66476007)(64756008)(76116006)(316002)(66946007)(122000001)(33656002)(44832011)(71200400001)(83380400001)(8936002)(186003)(52536014)(55016003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pKmzyZ+kVpGa7zZcS/kHxV9aOKG0/Vw9RjST0pUYB/PbF3XbpEHWoxYnvYYf?=
 =?us-ascii?Q?LTHud3tfY4zLCv1qGtELhQAs3Jk4tMypsW9X+ALxr1wsYwwwIyVRR7kFrOaB?=
 =?us-ascii?Q?pMfgU6TvrAGFosTweae4jx0A0vYqmn6XDUeiMRN/3AdOVUEb0bgscRbEaVz5?=
 =?us-ascii?Q?5zVNKjrf9GqTFWaaAKkjuD1/8E4O2kdWngHlAohoKAEuFF44pUqnc4NCtvfB?=
 =?us-ascii?Q?GP3WpNdnrj5SnuD/SYiIpxmODA80re9BgRSkDMmw5oFBbZHmfcCyNVEnuW7n?=
 =?us-ascii?Q?hVCONVLtIAuC9wq29T0tesG1Oz3v8SgYgsjVklk3Cxj4QLwcHrNTbiyQTlbi?=
 =?us-ascii?Q?cSnEhniY4X1PAFigCQHRln5lgdSTB7tnlQrYGfGEpAhVrmb91NXtOqf9+hH5?=
 =?us-ascii?Q?fsziFu9reSI2E9+TiCstmRDCwyHiSJFYH8Fe6d7Q9bsq9VBoJJkiCD2EhQ17?=
 =?us-ascii?Q?bAonFMMVh5BBEEUg9oGp/NHczCSFIBzVEQkt+VZlVTlULgv1muTtcPJ0a0yk?=
 =?us-ascii?Q?DUWMOAHSFawJXXbR1GuBRDNdWVSWwtObz+riiCEisFd47EhVdxKpHuzhsCuc?=
 =?us-ascii?Q?UBb7LFbv8Vk6iJ69Zx88J/GMXKr3RDQFGFQ+owYfQjPKyWsugIw/CxiPD983?=
 =?us-ascii?Q?vn3MarkbwLV5m6Bn90y51hVTMiFYRihgD2RlctQxIucGManSnWT+F9VBkqtu?=
 =?us-ascii?Q?6XhBpmyUM9yI/qj8ETeaPuUPN0xVSfhClLO4AhbV7Fj/kws9MI2cIDql135O?=
 =?us-ascii?Q?zIsCdCPpmy+LKFSDH2RnSb71BEQRRPAVCh/kLxmJ1w8U6MPH8DT1nfjLpN4d?=
 =?us-ascii?Q?Wzi8zm31eu3/II97arvn225wqE36/Zier2w3ZDnkUbPbc0pws4yW8iH1kBpe?=
 =?us-ascii?Q?pMyCx4mrWM0v46wIPxUYDAZgW6sZBGBjt/XvQ2nHbEBZcsXj8STDvKRlx3A3?=
 =?us-ascii?Q?BIJ12nfrfJqY6RGy7F95NvrpELYApofEtiG7KTSVjMZuoa7jV3fvFxiJyi8i?=
 =?us-ascii?Q?pYYTyjwmR8L6V0HCD+g0dGFOUSee9CZAQDATlIWHbSHp4FXn71eWf98fRl2o?=
 =?us-ascii?Q?TLqzpIv7ISuEN44JZzbCmtR4r1j1WawMz9gt6lLgOA1Cd8iYQtGcBB1AUS16?=
 =?us-ascii?Q?pNsGtUGxWOMZgRCLMp05MxwnF13ARJa/S0tjWvIsQExi8rAdv/CH44bdyhhr?=
 =?us-ascii?Q?wtpCxHBeUXSLGFfiEG2lzPQnP4lLbJnzVgcBlj6eS4ohLkoOLC+RdMxl7sNS?=
 =?us-ascii?Q?CP/gBR7JuZcSysKaW8Gj1en9umldjLYkYny4KCN664bMOE+ObPjkzgCX6wPM?=
 =?us-ascii?Q?tUVI0K+WXa4NmwgDd6MlO2dSvwy3rOwU61HQc6LsqXQsS9lK2teXr8swvz7b?=
 =?us-ascii?Q?4qyqm/k360FSRd14Za09OqwEfpltbsuGipPILwGkEwznj5FT47iKeGVBCLvP?=
 =?us-ascii?Q?iv+hELzuIRn/spawqh2TrACSyfIhNZy6QUs7EjAd2E9Ea3PLF3IY5gYVMyZ8?=
 =?us-ascii?Q?sFmVTGdhkTkFMM6bp80NsYy5Lkas1IAhpk1v1g2dhTIdiORFF9+MvnpoJlDm?=
 =?us-ascii?Q?mbDc4BqDebuS70QuYuM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d968ab37-dce1-4fb2-0bb6-08da5adcc904
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 21:09:13.7816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H6cwL6wxAh2hl1/RqctxcDJEMI4TaqUdXXfE/vapfgimlNKWLl7XZZpJGXRV9RyfO6yy7oT4gxf12GOWLOxITQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8893
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
> Sent: Thursday, June 30, 2022 4:05 PM
> To: kishon@ti.com; lpieralisi@kernel.org; kw@linux.com;
> bhelgaas@google.com; Frank Li <frank.li@nxp.com>; jdmason@kudzu.us
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Tom Rix
> <trix@redhat.com>
> Subject: [EXT] [PATCH v2] PCI: endpoint: reduce several globals to static=
s

Added ntb mail list ntb@lists.linux.dev

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
> v2 : Change commit prefix

Acked-by: Frank Li <Frank.Li@nxp.com>

>=20
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

