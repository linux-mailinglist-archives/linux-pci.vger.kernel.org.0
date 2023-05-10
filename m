Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7963E6FD332
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 02:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjEJADp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 20:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjEJADn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 20:03:43 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2102.outbound.protection.outlook.com [40.107.113.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB9C173F;
        Tue,  9 May 2023 17:03:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxKNb288XP71PHoD0ytTaA6Yx5HUwtKyAMy04bZTf31VM6NCN6FC++HQ1VLbVAiY1lZIBgwPiLgaucMUDhgr085TOxS68mUhgENBJuA2PyLtcs6p6JiA4Mpq7NuJsRxlwHQLamE85jfOrrspRnw5HxVP78sbN5OF1DWwexEkDM8yOQrEPBywuAQVNEEam2vH4fiws1D5ikA+ZjvY+E9fFEwHXeYe2qC9M3exPjKgiYtrq2DzwxgZVTLyBU1zIB+nFJ/mTah23WYRmYQxh+vixmAE9mMfVvOwN0weYAKO4jrJ3CCFZvo1HU54crDxJ89+mcJiiT/G3TzY10NdfKPYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+V9PQVnzH0lITIv6UyP2BRGqI0On14rRg3Tu+F3h/Ms=;
 b=khs1CLKi2nK3XpyxgElNCG6F+amXLvyI3FZb0ErNX7IIDzQTYA9eqlBbdtUkSdX6RcPymu7KZHyzTuoit0k+Kf8vXm1B06ssv2+Bm6TBozG6VKL7HN8aFpWim3VGsVncM/vHml3IhvPkCzLcMoxUMjasbxdWIS4QQLGjOuRHgiRTQAceDdnOck7J5F3zaFJ4I7tbgByumNQbsMo6/5+cR1dRw6ImAZi8JaRqPqCy51onosL3a1yONjm1QbStoDKhMivLlWCVGG3Na3c2HxZCP6euODUtKiwP35umb0nGgG+Gllfxjvh+qcpyjxyF3TX3FHOhz4EXPavFbi4/oWmrbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V9PQVnzH0lITIv6UyP2BRGqI0On14rRg3Tu+F3h/Ms=;
 b=A7kE+xNtTqJu5TBu4Qr5UQSenshxkcJrvPfuxJ4nDGTDdgU00Pe7OScFk7c/Lq9dflrQE7h8tHwkJ0LH2Kb/Q2uflX/oD54lm0VNvofij+XvIymMvfb+726zwox/ubZJPFcT4SSFEwoHj2EfN9gP3BLAYCGozS48zbICJzC+wxQ=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB5869.jpnprd01.prod.outlook.com
 (2603:1096:400:a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 00:03:39 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%7]) with mapi id 15.20.6387.018; Wed, 10 May 2023
 00:03:39 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Frank Li <frank.li@nxp.com>
CC:     "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>
Subject: RE: [EXT] [PATCH v15 08/22] PCI: designware-ep: Add INTx IRQs support
Thread-Topic: [EXT] [PATCH v15 08/22] PCI: designware-ep: Add INTx IRQs
 support
Thread-Index: AQHZgnOp1x5vCUHL6UeCCGlO/sd44q9R+AsAgACoYmA=
Date:   Wed, 10 May 2023 00:03:39 +0000
Message-ID: <TYBPR01MB5341F528C9C929806E7BC2B1D8779@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230509124156.150200-1-yoshihiro.shimoda.uh@renesas.com>
 <20230509124156.150200-9-yoshihiro.shimoda.uh@renesas.com>
 <AM6PR04MB4838CA729D82DBB18852F9CB88769@AM6PR04MB4838.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4838CA729D82DBB18852F9CB88769@AM6PR04MB4838.eurprd04.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB5869:EE_
x-ms-office365-filtering-correlation-id: caedc5b7-d410-4a26-2bbe-08db50ea0251
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fzY4rFak1IhSiZCHUnZLPsmiTiEsPVqPpv0FS0AaWN22rKQFxA1KMBDCYFdcJKEOJ9L8uaAWsQzIk4b/szf4E2vpU+xrDbC/zngMM8jR8Y6Mj4K6H1VOKrygAvMbEKMg8oy4XpotKAOxgNgb5lnIwpOrAz+pihgoXQEUdAjoyvbEMRjN/VKVnXlFZEjzynaCoJijCDlqPEs9/sNuEF2sz7ExL08P26tA5/LFYvp515ct0wFPmjTr/y1z3nxHSDcyL/VLZmNRQhpXqtZi872DXUTtTeCx+ieZCyUc71I3A4s+Z6Zd7k5C+l+odpC2Bwb2s4uq39pB9PTHyM7JQOrsXwn6csoP6IaV4oEFbqG1LXlZFyY7mcxuLOtBvfe4XY4j5vspobE5ETj4okYJ7GfL9IXL+JGvcmfMxhCstvafHHp4wk7z6oVT/XUz4v7CGFvNk5t/na5e7ytpiaZ0AaRIplUfb8kYVnNSh7Ngf/UufYbU0K37wKhU/IX2keMMlj+RYlAzqKKuuQlSTgA8bV+iG6+GmC9b4UExHura8pM9XmlpUbuGMHqgtmr/xUQ/68t21p8zmW/vDLdXAODJAHU9Csmz4cs8QP2uEMDN69qNGc4Y4ys4aQAsIuc996vuJEs8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(54906003)(86362001)(38070700005)(316002)(71200400001)(7696005)(66446008)(66946007)(6916009)(41300700001)(66556008)(66476007)(76116006)(64756008)(4326008)(52536014)(8936002)(5660300002)(8676002)(478600001)(7416002)(33656002)(9686003)(6506007)(2906002)(4744005)(186003)(122000001)(38100700002)(55016003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n5qkNL9XF4PK/k4J8+SQGA9eVzS2CJC/8sp18+LeKtObseELmHEfHObQIjPc?=
 =?us-ascii?Q?oF00NJqHWUrzUfMqQcKzloV0LSQ8+jhrSbjvV8bUvGpZ1G8FIypc07XEo1nk?=
 =?us-ascii?Q?t59cwKhej5RQy91uEyNh6ldPOsmT5lFtT5kkLQ4UjX0PAwJq6f4e3LtlkdvG?=
 =?us-ascii?Q?BqmKNEG0B32Ht06SuoQKPMEFb0RE/4V2d5axIJp9olVYuMxsZHE9TRdYnUzJ?=
 =?us-ascii?Q?/dpeQblOkDLLLrKNH8O4WLyZ1oXXED89k3kxUoqJE1v9RFprnt9140ZCV0xY?=
 =?us-ascii?Q?mvAE0R/bJq2oY9Nu9Qqu4htzJ+EuC5v4Syb/56+eeMG2pcp7TSY4VrFdbxtP?=
 =?us-ascii?Q?kLoRv/ZL4ebRXgp8wz6svl7A/+kIr8RI9szJraseC0OqYajJR5ZADmm6Xkn5?=
 =?us-ascii?Q?RxRCN61rFf+Am3oC9XZnIcWoNa6SlYgGoybba2qrUpU0rVeFKJbD1NUv1R42?=
 =?us-ascii?Q?2uRe/lmG58NCFT1GtN/V/W5DDtzuoCv5FCuaUuIKbx99CtFv4rAZSqdVOv1V?=
 =?us-ascii?Q?SNtEJnUdngfOi2ovqdvYK17sIi0EJCMRBzJOB+dr1RQPrCcJ/UIRj9jRMVE2?=
 =?us-ascii?Q?KKgZjjwu8Iip+I9dCLY2rybHr9zkw3zQYPytnsMdMgUHNgm9ygz7tW8tIsXp?=
 =?us-ascii?Q?O4QnCdrkHQLQbRpclgIv8kFR3i7NN91yu16Kx33bvCzHltd1msIbEiBpBpX0?=
 =?us-ascii?Q?CQICOEIXwseFVErgNnnYxrRj8Dxx5GauGwVOZVUJzJXgsgBBGvUAdTXxtyUK?=
 =?us-ascii?Q?cB5jputIycIF+K2ca9yBO5O/+IoZ02/6YImJnLAkjJsKCj0D2bLwJ0hL5XEP?=
 =?us-ascii?Q?JhZuoUibUj1WlnipFL0dosegdd4lDUTZ9AlPR1p5+SPUYLwfYd0NNTPan4Zt?=
 =?us-ascii?Q?3c2Lk4K4iyU6iyahivfhv9aGcRD9rd6T1YzZPq8oXC3snkoNxoyMKYWIigwB?=
 =?us-ascii?Q?732ZRu+n1wSWhAWmw3Mt4Xq60dr2FcXATlGPp0QN8Wfj+yPcOptPy0+y985u?=
 =?us-ascii?Q?BaEreg2vyp3BvaTR76856ze9T5CSdVccvheapYJog2DNsSFZLnzlJZh2ae3A?=
 =?us-ascii?Q?s+ZfW69nJJqDTqmZBYIzB0dLnhkowlXfA55iF4RQmyg1vjvpDJvq9pth6yq6?=
 =?us-ascii?Q?6c6nMfvgZNTmJQ62EQvWn0btMCY41SpRaJEQyFa7ULDLXZTWKV/xxxJM85Ca?=
 =?us-ascii?Q?JB81qfPg0Vytq3ZzRIv4EHZedV469ku5CVE4R6a9m2Uc718Fx85lwIJJBdrs?=
 =?us-ascii?Q?Brd23Ffg3DIr9crqDwyLemOzDe5vkeEa8vYWBGvo5P3J8XDzKJ7VK2jTycJ+?=
 =?us-ascii?Q?a0emT+iqQ5/KrZFbfPcCCusGxAQoEsFVaOgzH+D6FxBAyJNrC+NQPoUeKdOx?=
 =?us-ascii?Q?fGAkmHYltEo/1vy14U1VDdQWunUE6d2mKOnn1IyXFa3zRhERvPnivQ5bOCyL?=
 =?us-ascii?Q?0bfEQZdZjHLy6f42YEuHQwOOAW9R+eCXjE0eWypazZVFmkB3r+QkP4gncGdJ?=
 =?us-ascii?Q?qJUMaZ/T6E+eyd9WL2gHM4EUj4SbNA+5gChtpkNZl50dHvVwyQ4rsQvpl4iU?=
 =?us-ascii?Q?AkcNBPtxq2ppr4nu95Qp2MczptBaAKac+2YkDOZOGx9ENIUNHpcy5BJ+l6hQ?=
 =?us-ascii?Q?GwYZ2tj2gR4T1L1g+wrfr+360YhjQucBbN0iNapMt7Cx3rqwOQfGopdWX7FY?=
 =?us-ascii?Q?3wXTUg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caedc5b7-d410-4a26-2bbe-08db50ea0251
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 00:03:39.3887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GLCqLXZizRcb+HSIliCMyQs3Od7TEbWM1mI+pV6pziH7SqJGUVF0cHiAb0xGRiIeiDcSHt8DJJcbm53U7cFudXDOPpSZEK2XJ374/cjZV5CmycMBMxNV5ZdLs5JbVbi6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5869
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank,

> From: Frank Li, Sent: Tuesday, May 9, 2023 11:00 PM
>=20
> > -       return -EINVAL;
> > +       ret =3D dw_pcie_ep_send_msg(ep, func_no, PCI_CODE_ASSERT_INTA,
> > +                                 PCI_MSG_ROUTING_LOCAL);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /*
> > +        * The documents of PCIe and the controller don't mention how l=
ong
> > +        * the INTx should be asserted. If 10 usec, sometimes it failed=
.
> > +        * So, asserted for 50 usec.
> > +        */
> > +       usleep_range(50, 100);
>=20
> [Frank Li] At least, comments should be updated. It should be level irq.
> Here is edge trigger because frame still not supported yet.  Will improve
> Later or some things. Otherwise comments is misleading.

Thank you for your comment! I think so. I'll update the comments on v16.

Best regards,
Yoshihiro Shimoda

> > +
> > +       return dw_pcie_ep_send_msg(ep, func_no,
> > PCI_CODE_DEASSERT_INTA,
> > +                                  PCI_MSG_ROUTING_LOCAL);
> >  }

