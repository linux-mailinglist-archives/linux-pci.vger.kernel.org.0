Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD57369EC0F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Feb 2023 01:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBVArQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Feb 2023 19:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBVArP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Feb 2023 19:47:15 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2135.outbound.protection.outlook.com [40.107.113.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DA1303C8
        for <linux-pci@vger.kernel.org>; Tue, 21 Feb 2023 16:47:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iD0fCGuk5yKxjdiH1a44glrA3d+vGxFS27IAdbL7GB7H/mBMLmk4uBlsY7JnRH0kuLf/CO9gkRe80fwU9C2/MGsK3eNsEHKnpKNlpGBcS90bp1doi+KeDeUZBisUdJCRlAKvDKXXxgGkFaq2ndTy8Q3Um664JrIT2f7QYUj4RgsgSa9Ii8ZwZ8PMQETZ0dEfXu1DYvF7yW4jxj0MG7dPQBgxH6GtryXJVZ/aa9drSEnAyluXlGIU/KQJeo+jF52SmUyoup6xkM6a6Y1qV1G/E9hFoem3NGr0rBuCo3Oi2jrcH0/Xp7Ns21Up8+d1cmHOTsrS7Ka3Jl9JGf6fF8NBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJM/gmd7Ly7hHQgmiR2xMYLEZxw9Kdw7gxEpyJApppg=;
 b=UUmcOoFVTycJNXX06/4d98nWIgsooXeN+C8KAJ6ka96llSjQyqH1pNKpgBIbuqJtFb62bYb4fj63RK/tZbCGZiYdL7BH7rjId0zPYH4LxrRo7WIrsdoNEU2SeLSSSdpeW0Op7N67WRYM9j7zBPqJcvc0Fdc9Ujf+/x1asNq/91TGYTl038XJJhKxrC4eFbf9gqZppyPTsdRz0bOptWyDg+btNIVo2xu9FHN5kmvMAee/Y5QzrADKKRY4S4Ku187fotqmYGmNqDkjkwW+2dz3U8KmMgR8xz4Hinwz1MjiSsNCi1YEdkI4I+OBHERuFxCqEeIOM5GAW1pDqJa4n98EPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJM/gmd7Ly7hHQgmiR2xMYLEZxw9Kdw7gxEpyJApppg=;
 b=lT7MvXDXyWfAbCqP7jfK4kOoXKfqzt2XG+LIZLvDcZ8pq09ce4DnNNgNdY57KsVoWYCoVOh3Cgl8oFlfS9nwUwyEi0MkEcRRHl+mrxcryy594ehTOnlrytRp5ot55S1ArrcrLQSSR56TR5FIBA9+MPipBOC0RQRtZABkAUFMinA=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB11370.jpnprd01.prod.outlook.com
 (2603:1096:400:36e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 00:47:11 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1%5]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 00:47:11 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Frank Li <frank.li@nxp.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "mani@kernel.org" <mani@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [EXT] [PATCH] PCI: endpoint: functions/pci-epf-test: Fix dma_chan
 direction
Thread-Topic: [EXT] [PATCH] PCI: endpoint: functions/pci-epf-test: Fix
 dma_chan direction
Thread-Index: AQHZRdytzxPTIa68KUOjfG7d64Qc867ZkS6AgACRMsA=
Date:   Wed, 22 Feb 2023 00:47:11 +0000
Message-ID: <TYBPR01MB534180EA3DFF3361B27B62E0D8AA9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230221100949.3530608-1-yoshihiro.shimoda.uh@renesas.com>
 <HE1PR0401MB2331F8A482E2D3D9C782F2CB88A59@HE1PR0401MB2331.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR0401MB2331F8A482E2D3D9C782F2CB88A59@HE1PR0401MB2331.eurprd04.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB11370:EE_
x-ms-office365-filtering-correlation-id: 740a377f-c3f4-40a6-dc42-08db146e552c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qXji6zy834DdxNHMx3MXwJci+9jM6+HI+nLSCOkdIFrw5H3pMwiaq9+sSPoXs000qPQvZHlPJ7gYUOclbhKG4DXOpcpvU8N6kFVkGeV0rvCBzUSB8I4Sa9Gl2J0DnJ7oUqdsOkWycZJEalDz1+h4IRLEEyqtkgLhytySzjUaKHe0llLGZ3swsk4iORRcSpY+HHUJ675K8mx/qaSj+jVL/OVTTnXXTmtmsL/LrloRLuNJ6Ep9wszwn/ZZ7/XnJsXF9Bamz9wUKoXe5UGd1dGipE9QCYCnw0ZVYfz26D1T9tvgfXKgl+HV/kvVsYuAsBaHmHQDoMzY6Jkj96e3pLEGTKAxpaXAhA5igVjoIjilsRl3PwUKn/d66gKMTJAIPPklIaX1EGXB14UZfqhs1YgRZWuoIQdSpdLQC4PIggDlzrZ7ARm28PGTGHFt2eKPBAcw6SXyfHLtHVn5sIugjWE5zIEm+3cP7pbTj/+iavTD/6IbKwYTWWoS6WTCsNQrkOjtkCAQFgWpnvWzQ0zZTx4oq5AlhcKjf517mmnJauH1G/nlcr3W0BXDg5gbQtw5Iif/LVFfM8GpzR99RxZYKZab5FbwA2DOu00bmSg2PfGN+Vb8WRBJt5AedqHCFCr09uDAUF2ZNFoFswUPuEtkvfpOSIM3oR1lafEXGU94oIhh/KpzfOuHHmC7mJsuAU1T+itp1dhXSUdnCP8Wt3eWYY3MDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(86362001)(38070700005)(33656002)(2906002)(5660300002)(52536014)(41300700001)(122000001)(38100700002)(8936002)(66446008)(478600001)(7696005)(66556008)(76116006)(66946007)(71200400001)(64756008)(110136005)(8676002)(66476007)(186003)(9686003)(55016003)(4326008)(316002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e6cBv2R/ztDF8jyZVkW42V0U8iLedxPS6ou8w5gYwJGRGwJF1b9IrbfKnb6y?=
 =?us-ascii?Q?GCHUVpKzj8tzFMjE+vVis9MJ1E64d+Wrrd9qLT1ckAcEvIdSm1hYqwmrUTKa?=
 =?us-ascii?Q?XL+2f9i2oJ9P3nwAt4RqNGFhz4Cnl6nAuEYVeYZR/aeIbZcvgXbZFYIXu9a9?=
 =?us-ascii?Q?ww13ZQ3UDSdJb3HG7tIf63TQoQJUpRNMwIA8yp3HgJl9IgDf3teThrkaqbl9?=
 =?us-ascii?Q?d1LkgjJpJDTnylS2U0JgU2RNyivfez/wAdpi7OzWAjLNH+GZnro0uL34+81m?=
 =?us-ascii?Q?orLyvrHkY6wZZ3DnErvHG8IB27zdMAVLYfhM7dU3IX4ZMyLsVvlDcYGTR1i8?=
 =?us-ascii?Q?f6I5Olkwc9MzoCeBFSAMmKb36KpJs5K+w9GCzCP7uQdqVN5qfXmUn+lph2WS?=
 =?us-ascii?Q?OlbK6UA20wC7lC9lqp11uWFpDeTsNXfvJeKjBErt37RFOhPL8c/y24CNX+3n?=
 =?us-ascii?Q?1dt6C/GP8PKxEMxr2yGr2QTo+JZGS+YfOz+yP3XHP90PNeXtJN0ZJgV4/bcL?=
 =?us-ascii?Q?Kmj1BNIMWRrMoSbos3DtVc1aNjsC8bW12CovAxduglTtA8M5pbt/MoQNQwo7?=
 =?us-ascii?Q?G7zQUQDYW8zJTOWbm0n7xXJKSkiGdH53o8ieqO7UopNt45s0wFgp7x1lT/5c?=
 =?us-ascii?Q?h85JiSspnnUJGxsvtC8sMcoUzuIoY3R12g26HiG6+eYXbAWbPyKzmYfcAmYq?=
 =?us-ascii?Q?MgPZqK/7Wg6b+dfGzQ6UlzjfCPslDLzzJbJslNH97fBIC56XzXKdylzcp/1I?=
 =?us-ascii?Q?/a6XCiwoG72PTCUusW8xjL+0ScZd9Etb9xRFd62sIGDDPPPc4BqsiE5dzr5q?=
 =?us-ascii?Q?1zrdnBXidVICzhiVlyIRWhNyPNPrtR3vl/uwmDUbhczNAop1qY1GrHRJq1pZ?=
 =?us-ascii?Q?ueq/xILjYoXGyzK8NQvFrImlFgsTthv8wcdC5ghaErQNzQRQbH+Zp3SjQSo3?=
 =?us-ascii?Q?06DcWlYnp9aslh3grVJjiwWXP3C8IxgoTikbJiX5gpw8gKqJ9w6AoFeKl71/?=
 =?us-ascii?Q?367WtDlki52Tusp9ZEtqrV7/GXXUtCc2nUWLLMjE5B3W0JZ8oRPcz60/9ZGa?=
 =?us-ascii?Q?VlkxJ4Rr/CgtjeyBap90bFBuuT4XuxR0JpvCbSYkBsT1EQYlYlZH+daech3i?=
 =?us-ascii?Q?UHzGWf0BNtZte3kRtDs2I3nkVzY5veKvEPVnl670nAvxctLdZ1GoIgNnhnLh?=
 =?us-ascii?Q?7OANOwhkzuqhoDiq49hFy/RDjx+kcAvZiAs7oQYxmzTJ5LgtTU5h38nurf7b?=
 =?us-ascii?Q?pW+H/QEMnoY4hvQqD4NIUvemgu3U7KYuE2raQGvNbKkomisCeWSzOdcORRxb?=
 =?us-ascii?Q?WggrHAw7HFQCwceQ+3ZD1L5/hSI+Nvu25JEyqazAUfyKfZWW4c3Gfwck9T8i?=
 =?us-ascii?Q?iL4LpWEv3yppEPby9Z7IhwLrTeQmiC/1Llcp9ADIJMU2U/lTZcXd84RFFe8k?=
 =?us-ascii?Q?gUQ3olCqNdBl7OzsV32Muno+Fk/5KDsOserqe5TFT7Bg368z+POJqaMwz6ao?=
 =?us-ascii?Q?YpmZ1/kuW00dNdlVR3YoA8hgTXBI3GppI/zeLcZPilkQy2vwRVgr8CwMCpQz?=
 =?us-ascii?Q?sccyF87dtGLLzD3EiDbGzxK7riFK4cSWoViZD9m0sz9XprcwzsoOhxzzjum6?=
 =?us-ascii?Q?4hRt8Q0hGNZpzyH/gP/xpiwJgvfKu3AbsHGLJ9eNufIxXeBBrfydaQUym89D?=
 =?us-ascii?Q?2x0HkA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740a377f-c3f4-40a6-dc42-08db146e552c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 00:47:11.0862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JLqKnDLIQ1eNM3d+FDceVxjI6YSZ+SpMp0muIiWJ1HuyqX9R/465Z4t2ptEfUkltaeg1/wy++7K4VA4ajdahWPaQDiuRGqiUPuicTPo0K08dprr1QE6nLGux1vzGG5+8
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

Hi Frank,

> From: Frank Li, Sent: Wednesday, February 22, 2023 1:06 AM
>=20
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c
> > b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 55283d2379a6..3a720ed4655e 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -113,7 +113,7 @@ static int pci_epf_test_data_transfer(struct
> > pci_epf_test *epf_test,
> >                                       enum dma_transfer_direction dir)
> >  {
> >         struct dma_chan *chan =3D (dir =3D=3D DMA_DEV_TO_MEM) ?
>=20
> Can you use (dir =3D=3D DMA_MEM_TO_DEV)? match following check
> dma_addr_t dma_local =3D (dir =3D=3D DMA_MEM_TO_DEV) ?

Yes, I'll use (dir =3D=3D DMA_MEM_TO_DEV) instead.

Best regards,
Yoshihiro Shimoda

> Frank Li
>=20
> > -                                epf_test->dma_chan_tx : epf_test->dma_=
chan_rx;
> > +                                epf_test->dma_chan_rx : epf_test->dma_=
chan_tx;
> >         dma_addr_t dma_local =3D (dir =3D=3D DMA_MEM_TO_DEV) ? dma_src =
:
> > dma_dst;
> >         enum dma_ctrl_flags flags =3D DMA_CTRL_ACK | DMA_PREP_INTERRUPT=
;
> >         struct pci_epf *epf =3D epf_test->epf;
> > --
> > 2.25.1

