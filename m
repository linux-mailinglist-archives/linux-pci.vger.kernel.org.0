Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FDF501C4E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 22:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345570AbiDNUFx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 16:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbiDNUFv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 16:05:51 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00063.outbound.protection.outlook.com [40.107.0.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D940DCE06;
        Thu, 14 Apr 2022 13:03:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Er/Mo08jcgrqMcFXKrgpXyHMg8cx+M4xWPb2J0a+wjWLazDDZ0XCm5o7SudVvzfDe4NyIbM5XF06qMkDb+IZNOUWiss39Ui6FxkhQ2VKnchJeizPanh35Wc9+EeemLpTXy8wfWAUN7EztRqcYelrNgPWQxnxHQmwK736oprH2Y49dez2Vix2x1BIdniOpy0pymvEYMBfl44dWamyIw5yBHVob1iK6+npFCaBl9WOU1AQEIrTbstimb6XpVa9JJnaAzp71PAiPnGXUklbkQ7UkfEJcwvEd2e3xEJQlImnDWiB8kLVgpFHBYrSu7NxkFhLeAX4SSGqs28HaiJAzb15tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeJMUfKp59VeicrTlZ9ZSNUa8D6hF5BNzKqGsTwWzx0=;
 b=L2tgg5bnboqmeqtK3DFIm8IPgP8uAMhKYon8lqbWs+FVnd6oIk9p3CkbVfuB259IQ/BW5iJSk3Tmpieb9+OcBltgnWB8CuZ3vY4AWm3p7+9YR0fPSANjcoh/kuHpERn9CUjjbjb0P5vWp/ViSMz9N6k7A/0ZqmBMdhyFGrW7g/jjQt2LoM0wrV4v0NXt4b1x9n8iyhuE5JnsOgEixdlVq6Bv+OVnMbxyq6TDrOozxypDAyS7K6yqpf/atnPDrmkBSRIU9Bz7M42nXt3BOdYMXa9Gtuk7L0FzmFO1INYxvatzbmuG5uG+M94PQP5bwrZvsRJ8oHBmuoxsaJ3rEdHTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeJMUfKp59VeicrTlZ9ZSNUa8D6hF5BNzKqGsTwWzx0=;
 b=Y8ZZsUwBAYrK4TszPNOg9n5dP48jU/DB2s/yQuO9NMcF3zRgsNfbX99gbA4lNeT3Z30jnoMlgmI9fld2+dM6SBvfk5qCYaWsG7ZAi2Df68NtYsXRGLlY8NmRfJ5rEFI9EopMWgVLBeAu3FDRJAwVnmwXqFm1AtYCYDRqWje3Nz8=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by AM9PR04MB8400.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 20:03:23 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::7481:f0a2:5c7d:3484]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::7481:f0a2:5c7d:3484%7]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 20:03:23 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Rob Herring <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/4] dt-bindings: pci: layerscape-pci: Add a optional
 property big-endian
Thread-Topic: [PATCH v3 1/4] dt-bindings: pci: layerscape-pci: Add a optional
 property big-endian
Thread-Index: AQHYUDW0fDUPXyGu0ECMPrAb9noz5Kzvzw9Q
Date:   Thu, 14 Apr 2022 20:03:23 +0000
Message-ID: <AS8PR04MB89460EF821A142C8BF2303588FEF9@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20220311234938.8706-2-leoyang.li@nxp.com>
 <20220414192730.GA763552@bhelgaas>
In-Reply-To: <20220414192730.GA763552@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fcd298e-678b-41cf-a438-08da1e51d478
x-ms-traffictypediagnostic: AM9PR04MB8400:EE_
x-microsoft-antispam-prvs: <AM9PR04MB840015B1BC7CD639203F885C8FEF9@AM9PR04MB8400.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NVk5zPvRUuO206ObFxFNdIBoO5iLFl55wm2I7WyPlAeWa6L64IZM46SG2B2syxbi2yqHVKsSkcVxaGz1ZXz1ikgaE1XURGkWvRHFGPnBXfGc+jmkbc1EYQoghCgiL047Jip4Lm22UJRJ67t851fCU5bZGn2bZFVstibBc1bZthUIfTTUGnBow3Cx/PogsWG73Y7brRRP+04wChroTb6MIF7tSrrFHgF2v4AONC4mIpo45PFR6gvunumnn1HVfBwWLGVV2/2Qs+q0BPFnhYtTZpCuMqdlBzuGJ5Ncj3vrWDebrZr9wuiy74voSkM7Lyn3qUvJrSJfuK/vdKTpqzHpVE3zv4HCO0/p2btzoPJdWuD8HZE+wjGjxYlKXQeo5AMCv0k3XGLd4vq5SJc0/CFT7tXYlDCTSNprdTCToUivsNpfQs0fSSt9sisoJTqqa4s8QqDwPF+1s6TzNHyooY7Mf7wV9BHk6msMQzfQAQ+PKSRf16ZQvjv6W+jx1S0km9ubJkl9IDxGxglC8VWgd5Jsc9a+qqBbifPSDYmOZ14B+r1h/bdIKMxkiZ6+/ITvPfudCuHtqBZy1xwGKHEWD9JshSLG1GjZYBtoha9wQsAmENms3PWzlfYVOtirT7WPGxpXa9GJHqTz7dXVyMEKdmAdBuAxOl3lbkiga+V5ZBLX7tGznRaHtQRq6Rxzaej+K11C0ozDdzP0hBl2vKzy/xPFyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(66446008)(86362001)(76116006)(6506007)(38100700002)(122000001)(66556008)(66476007)(66946007)(55236004)(71200400001)(54906003)(6916009)(4326008)(8676002)(316002)(7696005)(9686003)(186003)(26005)(83380400001)(38070700005)(508600001)(53546011)(52536014)(55016003)(8936002)(2906002)(33656002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K2lpfLnmP1JPjAVMMm/VwAqmPQBIGhgfJVUDDvfhC21dZeyzFNm22ta8sZBX?=
 =?us-ascii?Q?Jp1ajzQoJbNqRUfPgDZqz65by/lR8O/sJmZ9J03NqCKkZfP+hPN5U+LnLGYG?=
 =?us-ascii?Q?KQTj1nHZhE9mhMOShIGiit87C3xUOuo0pWiUX1zLK9pDAXFdHuiwlQ8ZO2/Y?=
 =?us-ascii?Q?T21ZOq/saLy8AfMpk5ooH2kIxKIJlKTxdMjOz/G6AWzB49JuF3R2Rh/OX+YG?=
 =?us-ascii?Q?P3pKm/hJCtwzlKwtUWiRvc8GjqBvbrcAyq0tfZAEswBzyc/Is1FLGW2PgMQb?=
 =?us-ascii?Q?ghNAls3ELuLpKiPPQr6jUyrILZ7jpzStVPObeYLuXTsa2jyBUmdTco+0R6QX?=
 =?us-ascii?Q?H2+KM8/NTBrfG9LLpx4dCz6hc3gSylNAgJlFfj1k3VGADwpnSVS44oISzi3V?=
 =?us-ascii?Q?RzkKvTe2Bo5QdA3jT7nsOgdoNc/LuEAun4LgGRPojmJ1JpAwJm4uZXbb4Xp5?=
 =?us-ascii?Q?72TlZGP9xhODq0UplZFCyy0z93czluHPO13KOqYI30x2LWhAO7K7VG03jzYP?=
 =?us-ascii?Q?9q8NqJ8JVCyOz+jSLT6b/evK4YWC1oSAF21Os/eWWJTTGB0GIUDWlks+r1AY?=
 =?us-ascii?Q?JNO/MjTyvgjW8OXEILNt+iJ20BPdkizcFSXyNG7yoWmn17lWkf6GtwRMI+eR?=
 =?us-ascii?Q?QEDXZ+T6nQ8lFFHKdAf8mpW9rJ20EDxhdu8LG00N91RcEcoC/vaatsY8pbPQ?=
 =?us-ascii?Q?dNu18hsMI0OsTVx+H3B9UPFq9x23WElUWRjdbZJP/PPuLGm6AQMr8udX6l2s?=
 =?us-ascii?Q?7tqGJg+J3Y7kipNT3U6000O+eM6taqpZ+kmyntT8tuPCIAPNTils/0BFrST9?=
 =?us-ascii?Q?evT1B/avaS67alHCQ2rjCMzZ4yY/GmgdndzY5SVlgfNu2rG385nopjN40uo9?=
 =?us-ascii?Q?wABgXYnlDhU30TCmjUqc4DS52YNn5wenrudLYB3jB8ph0NYTOxoKll9bcNwq?=
 =?us-ascii?Q?RiW4bvHq+yDkFkRnLAUdthbYI3HGgeepigczBOrNCfZn1wyJpvR1/6CUMh+M?=
 =?us-ascii?Q?f5N1vmuNaw24SkJw1zeSYNw5DjEoQelRuCCd9DsUkQbCXdHjWFxMGIbzlNTa?=
 =?us-ascii?Q?ppizwaNfHecEgqC/nKS+OZGQR60SHYiAWWIAb1NP819SoLLZCKj2Gp3xUO5u?=
 =?us-ascii?Q?tcn5mUfhSiVLTHsOAXpZG4KrtOLbsj4qaYRGXYTrtklyWs80ZPI6hzwFPMIz?=
 =?us-ascii?Q?XWwSQgkMxT/HW3liIK8hsazT/5VM91f0Vja0nEIiqfB+g3wfrzkbcZgByixJ?=
 =?us-ascii?Q?/UKPhhDiS44W1SVfnnqrPYV2OhPZ3CzVSFlYZqdw47Iklst/JSJRkhJJzJS4?=
 =?us-ascii?Q?UeJ9PHhfBaCwRCiMQ+ni9nieUqCnJ5iVyGxXHIKCzthaKyO9Q0ljBEKdnxtD?=
 =?us-ascii?Q?rY1qKdbBpQ0txHSMr8owQ10FiPY3mueFhZV8WuVFPgiD1fimW614fLkSUbVA?=
 =?us-ascii?Q?133pamnTiaeUF7/sS6xGRVcl/UFrKDsZnavodjKPYFPYsR5hOZZEiYst+42Y?=
 =?us-ascii?Q?MmovRYHcwQUZAh/9fqsYhVb59ujjrkYzYDcOeHJqARE88tHuY3PGqqCx+seK?=
 =?us-ascii?Q?Th5ZLGL6G8pbxyBGaygUUp1RhawDFqAvQMbna8RKtvv7ocYXM6AEMohc4QLq?=
 =?us-ascii?Q?pBdu60Tx6j7I2UVZQOdHEiyQhE/bumeKLnYbSbg/Jyvk1bSyBT6ysH6bwRI/?=
 =?us-ascii?Q?3SNTeBTot7oO50NI114I7yOTc00LNDyQx1XHrRnZz/8ITwYcolgpuvNNWxFv?=
 =?us-ascii?Q?Cjb/V7FSZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcd298e-678b-41cf-a438-08da1e51d478
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 20:03:23.1269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4oUVMHQZiRQL6qmGKPXR7L8LAK9vzLVO5vDRn5+nMtboGquSR+4IxysswA6DMSSRaJMFrpJgpWXv88RhHc0qIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8400
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
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, April 14, 2022 2:28 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; Z.Q. Hou
> <zhiqiang.hou@nxp.com>; Rob Herring <robh@kernel.org>; linux-
> pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v3 1/4] dt-bindings: pci: layerscape-pci: Add a optio=
nal
> property big-endian
>=20
> On Fri, Mar 11, 2022 at 05:49:35PM -0600, Li Yang wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > This property is to indicate the endianness when accessing the PEX_LUT
> > and PF register block, so if these registers are implemented in
> > big-endian, specify this property.
> >
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > index f36efa73a470..215d2ee65c83 100644
> > --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > @@ -40,6 +40,10 @@ Required properties:
> >    of the data transferred from/to the IP block. This can avoid the sof=
tware
> >    cache flush/invalid actions, and improve the performance significant=
ly.
> >
> > +Optional properties:
> > +- big-endian: If the PEX_LUT and PF register block is in big-endian,
> > +specify
> > +  this property.
>=20
> What's the purpose of this?  I don't see any code that uses this property=
.
>=20
> I guess this might be related to of_device_is_big_endian()?  I do see som=
e
> code that uses of_device_is_big_endian(), but nothing that looks relevant=
 to
> layerscape in particular.

These two register blocks are not used in basic operation but are needed fo=
r the power management support.  There is patch in review from Zhiqiang ("P=
CI: layerscape: Add power management support") that need to use these regis=
ters.

But since this is an intrinsic property of the hardware, I think we should =
include it in the binding and dtses before the code using it hit the mainli=
ne.

>=20
> >  Example:
> >
> >  	pcie@3400000 {
> > --
> > 2.25.1
> >
