Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7B8696BB1
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 18:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjBNRcc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 12:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjBNRcY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 12:32:24 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C4B2ED53;
        Tue, 14 Feb 2023 09:32:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6Cd+SHwOcbvBIqo4r8ldT+mhnLVYUCeZuo/21xVHFB+ThUXVNINKW3VPF9CaePnQkTYXC/CqSkLNabZGFALvkO77ycvGuUDudok++jVSWk1qsp7yCciVUBhnMafg7Sv/zpvi74aB410ImZY3m2RKgAzEEJGyem24jlvQuX9O1LSp0Obxe8Oa9dyExoswFQo9/RUe0Fyuq9WJL/2AToQM3qSrX85WaUBEt04v2yI17Cj3y22XYKHg86IceHktknwGEMXQeOJLMBz+PGf8ZuZ0YfMCfAMueuwOBLad9zIIFcyTEeB1nVk26NodT66uiIJREjDMeqAkrBaZL6//jkR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUmacs2Si16Nwd1In0nfau9SeQf0i21bj8HxKgfLzvg=;
 b=JjK99Afh4RKjt7oNrQuZ8/jeQKGLkq/vdTT5PL9devKIyoZnFmtQvtU84SDpWQqgUAbtLwBXMY8bGvroPLIDZm8uD6XfPcAqhcaPY1rc3zrD0Kj0u362cap0l6hAWtFf4no+2Dki3m1UYRbizJx+/qZKRy20bV8GGyIk9ZQ8xIPQIvYcZkc36rhBmkkmz2xRrpg/2uYYDZ6u2FyDuRg1859gaST+tUsuiKUvXRUdQNANO4RtVSWvYz9r63mUfM8l5K2/LQkB/1c0F5tfxE3ObPJXqxeLdX1ZlDBI+Iw7jrajD+G/G9E0mIYGotFgakffRFYFzwxZDMGNzIALJPRNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUmacs2Si16Nwd1In0nfau9SeQf0i21bj8HxKgfLzvg=;
 b=pQTjg92omz10ZVo8dOZFEaatyJyY2hJAFg3Zt9iJBSJzssI0f6j7DtjMxW8l58o0RwxLiSNYu65KR+a/S7UTiSbiRfQm8NZd4XUSYLvF/chiT4DKzcUdjrJLpjfmH1WzjfEpWJPvRHMfGnRDUqaG+IXPq1y9XemKd05xt4Kd2bg=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by PR3PR04MB7306.eurprd04.prod.outlook.com (2603:10a6:102:81::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 17:32:13 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd%6]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 17:32:12 +0000
From:   Frank Li <frank.li@nxp.com>
To:     "M.H. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-pci@vger.kernel.org>,
        "moderated list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 1/1] PCI: layerscape: Set 64-bit DMA mask
Thread-Topic: [PATCH 1/1] PCI: layerscape: Set 64-bit DMA mask
Thread-Index: AQHZJr0yaCK3pFdB6EKPvZEvJoExp668DfrggBLY4AA=
Date:   Tue, 14 Feb 2023 17:32:12 +0000
Message-ID: <HE1PR0401MB2331F2FCBCA939B32F1F7D8688A29@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20230112193621.1513505-1-Frank.Li@nxp.com>
 <HE1PR0401MB233139AC4E34F2D5E495AECC88D69@HE1PR0401MB2331.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR0401MB233139AC4E34F2D5E495AECC88D69@HE1PR0401MB2331.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|PR3PR04MB7306:EE_
x-ms-office365-filtering-correlation-id: e6232fc0-5377-4e3d-4e6f-08db0eb16855
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pIOQGNzk/932n0LtpOZl6RPHE0yZdMDzXBNWJgSc1kVp6LVZgP2tIIgap8bNbu8mz+dLbgjc8CjhX/qlWuJ2Bpo4TOxq791AzYhnmjdichUCIAxj7N9jXVISbL6OCvJbTEN4csOKOYE367zBGRzkdYM99jWQTuRui35AnAj6gzRJDGMfxLJLrduWsRVAW56x81ZdcM5nmCzOi77WkzoYuxquEAU5cIyAFaRPEaNJYuN3JWsvS/bgmmLNPbixIE8sJzh+6a92LLFVNk10dY6thAHHKb7CzjYg+r+BkBsOoGocHVuS5mXwxjPIgj2V6vOXsXw9QjkoWIMeZx0XzcYAHj/R+I7D3/Eom4m+h1iBgvi2kkJ4DfWKLLjpAN1GnvFE8qJ7xijezA8c2FQgURqYYZPJeztf64zQdDU59cgZrCmMm2McSbEzKk6I2DwDCxgfe5eLYfHaCll8PTJn65MsUfl5nw8Gqkd6yRNAlJVjgjBLuTAvqjnf2uFK0Gh4ePWeTnBQGmLOxgpit7fjj0+Qt8aU+5EdZ2a4Ri7jqU3exUJ4kKafNYxZVWP3G3u24WsLR8KRxuO2dKi7fyx0q/WV5DO0aSgqKD6IQoT8ohusinrEV+OEUDWF8Y9iUpEeOp9+9vOb//TFe0ZbuvpjyJ2bkkn+5vsDpyoSKSfCKtAxw2Abtnngxf6sqEMMLs2/pOShjFg8vu7mijcqW+ZfTC9vWpEOnz9o7Tq13q2tkb6YfRo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199018)(5660300002)(52536014)(86362001)(8936002)(41300700001)(44832011)(38070700005)(33656002)(2906002)(4744005)(83380400001)(38100700002)(921005)(122000001)(7696005)(66946007)(71200400001)(478600001)(66556008)(26005)(8676002)(55016003)(4326008)(186003)(316002)(64756008)(66446008)(76116006)(66476007)(110136005)(55236004)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?M9jVdvhTmrcTfsoJjafMrkwbUsBcMmPMGFRbEjAxNQFSdiwWK57rTpMX1B?=
 =?iso-8859-2?Q?vLh3y/novlEll8gCpjso8whz9/BX1vib+HVnlttG06X7j3TSTPPEc1irBb?=
 =?iso-8859-2?Q?QZBN5OOmjjTcdNk2Vte0FgP5aEMR+4otcNypgBQBCWptUbU0WFmivW81Pi?=
 =?iso-8859-2?Q?KInwq+sldzdHrTFKdqH1l5muaPZpEyhzeFvq/XFLjY5z4IqDRAG7UswIg7?=
 =?iso-8859-2?Q?4LqzjY8dyf6e9fhDLqd8pB3jyFflNTKJla0N0hA7LskXxzUTe/UEnT6Q+v?=
 =?iso-8859-2?Q?KmcQi8V/+PN2oXUk3wWR/Ix1FOFeVH5fX0/tlPqStb4fRbDocmh+E3j5GY?=
 =?iso-8859-2?Q?EQ+fxQvorEfLpa2QBDtReH3I5YNLLuSCbESSMtDIU72OWgu0ypDGJ6rfis?=
 =?iso-8859-2?Q?WBaZDOAV9kh3G4Q9lE8Q6iSwDQ0CXlwv0P2BWcEx5bhyLe5Q06Il9MTHTJ?=
 =?iso-8859-2?Q?dWXcTRdnD/Jib/wzzt7Xqd6J7MWeh0Hxge+5df/3h8y4kUdKhDPUJCNwA+?=
 =?iso-8859-2?Q?lHiLJn9bXyNa6mZG/1LLM3g1gvGQZGrIwIqJKZry8DLq6j0ms5OdNIr5oG?=
 =?iso-8859-2?Q?tNEVUTp9wko08TXdu3abtKIsr4lRMrRTvLbzwps7+SF5SxS5jH2X1Ekezv?=
 =?iso-8859-2?Q?7np/9FDaehyckkmFAC1oykPN90cU78PyzxVlcZKViUXmMlYonFGdtPzwSg?=
 =?iso-8859-2?Q?ID49leOFpu574hK+yKH7WggUbJ/osHw4MaSXPMMDsQUPJT01XHHxB2+agm?=
 =?iso-8859-2?Q?OEUIhdKvb0tTtWM/BC/hCd2mV9QZ+QjElpsjGRI5vcp+PziZM0j99EF5KO?=
 =?iso-8859-2?Q?YydLwbTsv2Xh/uVSrhMw2vcfUmy8JmRNNh264ZV7nGwXQVPcMetit8+7Br?=
 =?iso-8859-2?Q?ZnlK4x4qjCZPoCXCewGXZY4q6rcNy0BKXeYb/No+2kXQK2up8m642qg8di?=
 =?iso-8859-2?Q?dfI03HDLqoreHoa/1WKXtkR6TtlCOQjelCKwlwNJqXJmAhINhHzyPrvxjP?=
 =?iso-8859-2?Q?QFjuGbhNk6uZnFedXkOus3UtTujcyFxgGuPmp7dL+A0a3pyWZMYYQcdIH0?=
 =?iso-8859-2?Q?u/hsiShTFn4hbctrWdmzWK3iE8arM6YzXKxM2fVn9N2N0o3AeyI7avSUYB?=
 =?iso-8859-2?Q?Fd3yCbhcDDqSwcE46Uu+Zq+ddQLlEQYswEDNDYm0ZMafD4XEzonOXvMdxP?=
 =?iso-8859-2?Q?kLU8+Mic6a2q+x8re1bm11rlJTU7nKT8E9rZs89DXP7IRvzqv1pmu33AKJ?=
 =?iso-8859-2?Q?sz1Wx4ccOmsrKtMNjj+aEy10lF/llGFlBrBKwgHwrFW/cNdO6WAqyKj01P?=
 =?iso-8859-2?Q?UpWEtCUgM8ymuAkpLVvpJnBRggQe18YVWUVqPJdquec5IvufDZ86iEo2Ma?=
 =?iso-8859-2?Q?TuqsqRABJsDl6b9w/lpkyKJJiImS4CxUbio138Ewhfo1RZ/+0X3SP2mQsW?=
 =?iso-8859-2?Q?sWUr51J5MhKlk3DfuQwmCgY+KtivZBUZMf31C1mv/oWoEjgVE6g4rnG7kN?=
 =?iso-8859-2?Q?xqTgsmifz5tnNtki2BG1IH3W42JOu7NBT2/YZXDHFqbYDnFVO2BXznSggQ?=
 =?iso-8859-2?Q?WbZbKxgcSo/yPlW6qbFf/4gH9gKKotxnOa8w+2v6tatjRHmkSlW77XTFrA?=
 =?iso-8859-2?Q?5OFOrOZaFjyzI=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6232fc0-5377-4e3d-4e6f-08db0eb16855
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 17:32:12.4853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cklEZqnqWs9AbFfJXmVdL57hTlmPkLcOPfnrLrtn9s9Sy9gX6FbeY2Wr1YwUIGTGwkhP1D3aBa5Fws3aFCU3mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7306
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Frank Li
> Subject: RE: [PATCH 1/1] PCI: layerscape: Set 64-bit DMA mask
>=20
>=20
> > Subject: [PATCH 1/1] PCI: layerscape: Set 64-bit DMA mask
> >
> > From: Guanhua Gao <guanhua.gao@nxp.com>
> >
> > Set DMA mask and coherent DMA mask to enable 64-bit addressing.
> >
> > Signed-off-by: Guanhua Gao <guanhua.gao@nxp.com>
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
>=20
> Ping

Ping again

>=20
> >  drivers/pci/controller/dwc/pci-layerscape-ep.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c
