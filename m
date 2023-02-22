Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2A469EC12
	for <lists+linux-pci@lfdr.de>; Wed, 22 Feb 2023 01:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjBVAtS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Feb 2023 19:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBVAtR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Feb 2023 19:49:17 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2093.outbound.protection.outlook.com [40.107.113.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7092CC64
        for <linux-pci@vger.kernel.org>; Tue, 21 Feb 2023 16:49:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgTrq8Z01XHqWZiZCmx/6VzXqltItpg/oDVwaRe3o1Zu8auFpF9NiJwO5AaY7E9K8KbcQJs2dMCqLzPr6wwP6HHrkyACWzEdVPuDJSoDPSLYJ/H5RDDBKGozHeT3fr8pCrzexbnMc6t2sr2uS5QLuTMA+J3V3WJjvaqOYf7zDV3wFztn825YXbq1R32vSlDKWX2WF17+Wr3HX3TzGmiMoh/kXCXitAyBvn+ZFJknJCaUHMbh37m2CtThxPFhB9pV2264Qjfh+xnWWYEXrBarHKYKAjunPmJiswXtg/dOCRCq8zXMloA2DT6MkDSsXgAIGnbnWyJpgnie8O1gpDTb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpyr/7nMajg24CQtJJx/QWaUwavGvaehjsfQc7HZlHs=;
 b=HQ3w9tiAgvW2GeViHIhSzXak9u/pgyB/mclDTfVvXyAxpLOqoYEfh3BhIIqoJi5rlqBwGQulfLA34mwtsFCpt/8xPFL0asUp5sWjiwltJE3BQZwO9iFfcHKrIS4U20huyak/URZIIoiU87rVqDIa7ZhrwABGpeg57esbGTX8wvDdfJNC3fuwCVZulislOsirJ9BF8yvKDEzgOUPnSdVbbC2tdEoc+I7sczw5RmXJkfoAwiBteY81L8LbzvSX50cvsdweFzG8SJBZyf7oX0LgLT5qNbcAO+kz1/l/gE33jQqnYW/G8L2i052AwqOXTsdgeC5pCRE/eYv3mNG7bgTTMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpyr/7nMajg24CQtJJx/QWaUwavGvaehjsfQc7HZlHs=;
 b=iYP5qt6QFfcl4eKOjGYfiyrpA0yn0FS9G0lHHBHVMMW4xaNr4m6yoKXdGHWrFQTnTEF096nzFrwopBEwqpz/HgUGTH9qb0bGt02Io9tYcWCphK3m3gqiok4AMVKq7XoGzSz75c4mcxKU/CNrbJ4ZvCohePzPHRS9Twos5jJNROg=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB11370.jpnprd01.prod.outlook.com
 (2603:1096:400:36e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 00:49:14 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1%5]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 00:49:14 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "mani@kernel.org" <mani@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Frank.Li@nxp.com" <Frank.Li@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH RESEND] PCI: endpoint: functions/pci-epf-test: Fix
 dma_chan direction
Thread-Topic: [PATCH RESEND] PCI: endpoint: functions/pci-epf-test: Fix
 dma_chan direction
Thread-Index: AQHZRd22aWO5D2OWo0+A8dd2vi88T67Z1LiAgABN9cA=
Date:   Wed, 22 Feb 2023 00:49:14 +0000
Message-ID: <TYBPR01MB5341044E7B5A38A65235652CD8AA9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230221101706.3530869-1-yoshihiro.shimoda.uh@renesas.com>
 <20230221200813.GA3722066@bhelgaas>
In-Reply-To: <20230221200813.GA3722066@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB11370:EE_
x-ms-office365-filtering-correlation-id: 7c38bda3-0d64-40d4-726b-08db146e9e90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OFsxxH2nyT+BUw76WAyON+DsZAPZ491gYAXxTWyLRBBD8bkH7F30guQNgZaNh+ghQv4uEEhYgmzvdMEiDA1/KcbXEjHoSv0yc2nsFQDelQP2ecgAVx80+DOLXHSiORLT4SruE+jD8Qj9kjJ9490pzmkzT1E0jyXyFTXk9Vhnif66EdSeVhBx9xdpxgJwuuCSBmZB4s7xGmsFGYdB45lqyYCqH2Lf4qR5N15l+LjpSY8D3bcDq/A2vmSqIkZzBEZZbEaPAsk3eX8wJYcpL0z1N3liLG3KoFjR4ubs9RtoPCxhG3abDN52psp3+9/ZvFb/gqswh9Xopj51p418O1NeU2f2Nw3qI5oEOz8erEjv41MpUTsgFv6MGQqKwMG2m98m32crYA1oR07rWQV9aCWvpGWPqlNoB3v4ngc107X+X3STHC+4lXEpVVzphfDJfxMCzPibsOlTxwGglHdVQzLCpA/wD1hJiiPREq4AhL9d5qH2pdlDeePK2Z01tEnHOSZczfh1kXQpoefPsLD9bAJghwSGJ7aHfxyLJfIl94bMe0RoSOll7+tpifRHQ20W9SlF8nxUgBKcXArqxwl9NVFLf0MrUnAStjZJF4vj0if+yStuQYv99bJXj6g2zilYBK50FieXEItyMOpwzX58ASgswUkZybHORsY7ArtsEMwoWixV5JbUnFjIRk6qgTSW8lEiTPlCi4i9u5s64DBSeXYMyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(86362001)(38070700005)(33656002)(2906002)(4744005)(5660300002)(52536014)(41300700001)(122000001)(38100700002)(83380400001)(8936002)(66446008)(478600001)(7696005)(66556008)(76116006)(66946007)(71200400001)(54906003)(64756008)(8676002)(6916009)(66476007)(186003)(9686003)(55016003)(4326008)(316002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?23D1vVSpZ4eAbqQuY2n9nu2hBx8KXoG2U3FJH9ApjciauV44yqGgKUD8NWzx?=
 =?us-ascii?Q?XdRTRUjlAtPCo+tkFBDrbXnFXjeuQDK1u/53XqZZkZeh1Ar/bBZye16iSGnD?=
 =?us-ascii?Q?aeNG3WGksQ1m1NQrqBZHy7eetz5iBdKGrJsJAZS6PXfXTOdk72rhxOt8Hv4Q?=
 =?us-ascii?Q?s4pwByHTeE8Z0ibuT4TWlgUl69GRWrR8yrapIkn//eszsXecHdF/2wzdqfqg?=
 =?us-ascii?Q?s+dOVUFyyohURtyrgvTDYQ/X0ARREsNH0S5+Uj4N2cScMBZ4iBCuP8JMErZ2?=
 =?us-ascii?Q?/UBZQOQzu4miMY7dbj8PuJFILuOe9PaeOOLbvK0AKe0uUTG9Aa3hQqDpYE9U?=
 =?us-ascii?Q?ggtx+R7q3ekksPowUfbgvMa0LyU3DcG52lO/CyETAc7Q+n5TTZ800Bk0RPxB?=
 =?us-ascii?Q?OZWeQlrE0cO/ATYVeakeLO4KElshxhcFx4kDNkPw/+HJvnQghK08zKskXI89?=
 =?us-ascii?Q?n5rZGSDSNqR5r0Ms+e5GndITRVApYJE8Nen1o4xMHWjXpjTfozNtOoB0oGRs?=
 =?us-ascii?Q?eBjuW4129BTcjeD0sNeh/+aUmIP+ChmLCuT0HZNfrEfHXTMbbTKHkxFAv4vp?=
 =?us-ascii?Q?QovROxTPx39JGdf3Zy5POs3UoUbd0WqGHLcI0CyFCVGBdPlObddUnV7xhEcr?=
 =?us-ascii?Q?qxHJmGK5nu9uQM7Qqi4R1y8UHCpMD9/nhr1Z/QmavFoNPD/2D+5QameUVKMD?=
 =?us-ascii?Q?YFJb2V5atRFtwfjfTJOri0/8CJZO6txsy2HyO5UFrZIignIK1+NQg4RKHJyF?=
 =?us-ascii?Q?GJ/wywdLrtqA4YH+TlzCsqiOltG4SmIJ5jnEcMm9HTkVFeDP371gH0y0E8cy?=
 =?us-ascii?Q?d1dQ7MfW0O6tfja4bED74z8jCWjlhQE8hnCpM89jBN5o0iQtSiVzZioYd4MA?=
 =?us-ascii?Q?J8h6vhaRyNjzm8/68VSjCsYjzgsJ7hgnD1oIdSZW5s3CRkGw3TGbXtgcnq0W?=
 =?us-ascii?Q?9ET2UXc/YOHHtr0cgKIShsX2cK5r3aTo9u0pFoV6ECiXfTETqaFO0FPt1oTS?=
 =?us-ascii?Q?kW2jmpy6GbbACj/ZL11hCTqaf4JHtD/6m+yF4hL3TYnjEk2JiKnonUtvc7qQ?=
 =?us-ascii?Q?wwsVnpcD+e1qGlU7MGMB10NnIma40aXaBox8TiTUzmkuTMXsGzQzYWhagy4/?=
 =?us-ascii?Q?XjkmpYPiGGHSHR2czDsjHY1hVNTgVTfBq43GrlrCUOeaV53ByjBqtiXyV3up?=
 =?us-ascii?Q?fwXA3dNXBQynDFgytnadl5VVlaUbGWA5ltn9nG2fMYIOJj5LAfL07mUuXfra?=
 =?us-ascii?Q?oFWeMXfioPWPaH3UgB1RZpb90PfbKSfs2C95s4nVw/MCIKX018QJhF6ItimW?=
 =?us-ascii?Q?WFm3fsA20jEor8yzOBbHGdty8tva2VWUSY4RJudz6N44gNnOtzVP4Qh6R21t?=
 =?us-ascii?Q?LuWIH6NGUU89v74Fnk8iXpaPx4/ja9hbjGZBgY6NoleRjbH2Bn1B55+QWqEU?=
 =?us-ascii?Q?RCNSfTlG6fmWCNzvattr4jSjf5dnJv5baB1oB0fi8o75I477TUEZSDKLplpg?=
 =?us-ascii?Q?DzC0kv79PhTStB+wFzZRIXuJqwefNyy2acVnXQ07FCPtaYm4P7yoLMbCtATj?=
 =?us-ascii?Q?8BoT0uBSUEwL+erNRzQ69ZH4PjadpSoEPW0m1BqSAYa43cTfFAHoKf8Nh2Zh?=
 =?us-ascii?Q?ehhjyknm0k/T2woWSNU14Jfsq/InnmSlhA85BjtJkCzKeYM7GB7/jYs8PepE?=
 =?us-ascii?Q?8JgQvQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c38bda3-0d64-40d4-726b-08db146e9e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 00:49:14.2125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9fJ1CYQ7idzXTnwBah+Q7eOENqVInOD307XBZ9a8l0YOrMkhp2jaHU4j21Hs3oyUPNRJIyeP4DtB01zaFjvxPvXFL73V9TYaFuww5U1oIwlp/rhHj8qUUpViYYgOJGdV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11370
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> From: Bjorn Helgaas, Sent: Wednesday, February 22, 2023 5:08 AM
>=20
> On Tue, Feb 21, 2023 at 07:17:06PM +0900, Yoshihiro Shimoda wrote:
> > In the pci_epf_test_init_dma_chan(), epf_test->dma_chan_rx
> > is assigned from dma_request_channel() with DMA_DEV_TO_MEM as
> > filter.dma_mask. However, in the pci_epf_test_data_transfer(),
> > if the dir is DMA_DEV_TO_MEM, it should use epf->dma_chan_rx,
> > but it used epf_test->dma_chan_tx. So, fix it. Otherwise,
> > results of pcitest with enabled DMA will be NG on eDMA
> > environment.
>=20
> "NG"?

I'm sorry, I completely mistook this.
This should be "NOT OKAY", not "NG".
I'll fix this patch on v2.

Best regards,
Yoshihiro Shimoda

