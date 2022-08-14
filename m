Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE10C591DA4
	for <lists+linux-pci@lfdr.de>; Sun, 14 Aug 2022 04:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiHNCyA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Aug 2022 22:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiHNCx7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Aug 2022 22:53:59 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4406E2B265;
        Sat, 13 Aug 2022 19:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqI/8BgglujBzN7rxBkLyAWDaEq1V//LDCabSGJe6Ak/eI5koSGSQZTUseqw4a+OggfHMswcoYrfnr0rX1T490myfSq0DAZlRLZDDs0G/ELGbfpevmajPRwtIZVPSebXDSiocZxU/8TxTeJ+1tPNNIG8TD14hLNasNwrfA1S6t84xFIjBEUfrqzd5cQxZbPrWZIBj1QQrq7ruvBtUKbgl0q5z+l/SSkQp6Vxs+09rgMKnoaFXUJJ0xW37BWAkfoq4bmp/BxRAtvdpT1LwcZMVBEyp0JX2gOQkf4M8t0RJxzDlQ37hrfutpWVhbHo+FPdDBYFbILkAgm9ommcOLzlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24wTQm4PcMeaY9EnWVjI1YJhNtY0mxqd3I3ZVb6jbfQ=;
 b=Yj3oipsuROZGNzRd6Tk0PkYAISJihRN/DVF3mKp07cGqeRJV5kOsINcS7evbjerFZ3Xz5ZgNKhwTjDJvDnCkd1oibzVl0Y56z9RTjZbiUUDSxYfL+QZZHwsMXKY3U0jAG/JB+xxa56JQoDGa3Z5ho+7ISDsrMgSMwtxsu6F97c7cJlcufGoTsn92DO5QUssRKnMdSunccUBTat/vIg23Z5PgG5lY8krYCMtZczrBv1gcRV+169+xf4hzdoqDIlVpaizDj6zAik9RiepiRs2i/iQTUTV7CAErAjwRy8ISAXpBkPJYCs6O30eTpZna0Pr9+5vxr67CHsn+dRnw72JQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24wTQm4PcMeaY9EnWVjI1YJhNtY0mxqd3I3ZVb6jbfQ=;
 b=suUIQEUPL8oi/appsn4PumBaTnWK+jh6smQAQLRiFMLyGUEH/628jbSOiAlM6ySh9OqLDnVTd7n2EtvkW2bWF2/qkSdrcPlHtIPK8dxhOE4SiBDQDc7C0W/E5bnm6eeBSyolHWQkIlz8Dlj1/P7ySadSat+Y77EQ3QtH4rJ8wZ0=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by PA4PR04MB7936.eurprd04.prod.outlook.com (2603:10a6:102:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Sun, 14 Aug
 2022 02:53:55 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004%5]) with mapi id 15.20.5504.027; Sun, 14 Aug 2022
 02:53:55 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>
Subject: RE: [EXT] Re: [PATCH v4 2/4] irqchip: imx mu worked as msi controller
Thread-Topic: [EXT] Re: [PATCH v4 2/4] irqchip: imx mu worked as msi
 controller
Thread-Index: AQHYrpXqVoTaplRNPkC0NMrsvBWgTa2suoiAgAD6LxA=
Date:   Sun, 14 Aug 2022 02:53:54 +0000
Message-ID: <PAXPR04MB91869E2B67FAFA84CE229B2288699@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220812215242.2255824-1-Frank.Li@nxp.com>
        <20220812215242.2255824-3-Frank.Li@nxp.com> <874jygs6e2.wl-maz@kernel.org>
In-Reply-To: <874jygs6e2.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d1f06d2-9869-4584-c4e7-08da7da03a19
x-ms-traffictypediagnostic: PA4PR04MB7936:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hc1QOqyRAPL9N41U2nrI+3EDWfqn9y7AUfhyGUbOXr6rArLIPRUFuWYe2MdHXiBsJUyIgtk7pCf4g/cbP6Du21mxGCr5ZPE/JxrHZ16n25Oa6dLTtcrpw729cACMHEznHavngZaSeilzcHnlyXMWyk06v2UZRW69WZPf5eZ8jfLb55jPQctBihl9vn6radrqn33GOgHBSx9eT2Z21nWvhtng41XxUuGW6pa8vRW3yFaaY+bsq8h4AdWFjCQzk30v/J+NY3G4doj444ymoJ5vMifgDAToEaIpZlYJYN+zfb9+3dtcTlskKx4LI93+IZwJ8Y5iRvz9Jn+eXPupPHSbHkoztwvtQjpIsCKfeef1KMuZUl+eXCSe7HtRo0mvxmdFKaDXoAsqBdgUGaVYfU/DYksrM5yVd88uG8BnPWnPBNAcJo+TM+w19KQb/AtZOc1BaLIp8ZG6Hvav5+g6sqBurXmyMYANL3w13mVmJcTakKVYefR6AV3BFS7tdw7vMA40cHcBA/v7uv7a1Zo57CdeIl9H2KcmJAmmZxzn/zoEoX2QPrKMlNv/RzLQSaTJj4Rgz35tf0xGHNWSR2lUCnQdqsvyJdDUGf8c/zwWfl4XEgyvOletEPW/h67MietK4zsuL6U9hSGFqvhwMguzSXqlXsCkEvnofatPHNHBexl8UlfdNSqQP+tZoGx4o1Ddtk6HkAw/gW03gFVo3ZUIDRak1cYliIDmLhf6npCKd4/EEcfBqqm/+0lo+sws8yaP8lGZEc2O3wIeRdNz+a+F+tJjzdkUZuJWNue8tWAbnmQPxVY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(41300700001)(71200400001)(54906003)(478600001)(26005)(316002)(38100700002)(2906002)(4326008)(6916009)(66446008)(66556008)(64756008)(8676002)(66946007)(7416002)(44832011)(76116006)(66476007)(5660300002)(52536014)(8936002)(53546011)(38070700005)(122000001)(33656002)(186003)(86362001)(6506007)(55236004)(83380400001)(9686003)(7696005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nYArN6Xojropr0aZ6Gxm6bI938djRBxd6zF494ae3rjopPJXc7wpcC5YwagI?=
 =?us-ascii?Q?YCxzb6ms80OOPizrw1Yha9Zi2BJYz8xwgQVjU7YQsghLkz6Jruj7lckPsgKn?=
 =?us-ascii?Q?K8qwR1HwrYEDGgikNYXJ5d7vir8ZobuOuMZK64AoyuPJnPa/VKACBC8vFDRi?=
 =?us-ascii?Q?3dPFJcw7qrBP6R9Gu6KX9Zk9KphZxp1OFKPA/ZIh/ie+ULFCRVC3y75ZPXKq?=
 =?us-ascii?Q?OLzR84UHEzUIMW02PAKtaMZHeP/kFG55KjRWaRY9FugPxQ0wM7wJGSVhDOS6?=
 =?us-ascii?Q?wkaJOb5SR0CPaoeCeM864XTvG4lUpV7YCj50G18wgOD1ZZ5vWwAlZ8+5XDEH?=
 =?us-ascii?Q?kF9vi0EXOLbP+TprRWfBNo8S6SpOw3Gg4U/CjfE8hMqs8E7lQ3m7V6OA2Hfm?=
 =?us-ascii?Q?ztJKJCm5RKM0AWVaDwHJZRzFZM/t+bNnFB5pYp0MKR2lhI78C9Qmq9+u0WYz?=
 =?us-ascii?Q?d/SiQw/vrdaGOYYtWcOLQ4K/K+u1wdU5lde7SwVl6w1BXJ6aWTl45rj3n1ut?=
 =?us-ascii?Q?tRPYvVClbX+TLEEO/RYNff5cq5xyQeme2iZPJMC3CO5hUiuwVjdI3R10KrUo?=
 =?us-ascii?Q?5mbK4hk/daM5T9QxMLX40oyY9XkkjC1lUu+lzxP1rBarQbzg/0aBDVHWPJ7Z?=
 =?us-ascii?Q?CQmotoNGSwncSFXPGosmv92xfeXMzmfnxxBl3lK+104894vo8RMGX1OIrNX1?=
 =?us-ascii?Q?yxHPdB5Nhs/ge/v57GbS3ZJTAZGHjEa6+r8Rw0chxQZAP1o6bDAPuG1+y4nB?=
 =?us-ascii?Q?VBf5EcDWDETISXJ7D3YgS/eO6oTjuIyDYt4GctYGs4Ke8EKricKHu8vCvA5y?=
 =?us-ascii?Q?c62kstlYkUkHAg/63Lj6bQSpxBZZOnd7gLVF15oqs8OXRnwFATM2e7vKIKJk?=
 =?us-ascii?Q?FwmwT0oF9xErrVDQsbU6xwxF+RswEjbhMj782w7RIogIbAPpFOLV4kzyQu0Z?=
 =?us-ascii?Q?DloIaqCjVmDlQOotXgBbLHvP4NklAiLW1yuin8uEbKaRjVV2sIWzP5K20FzJ?=
 =?us-ascii?Q?HyIA8OVijsBArG/mK1TiPiy9bciY9guMpvaxSI6pSA74mrwJiMuv9w8rxzQ0?=
 =?us-ascii?Q?zO/rLiJXfPA63jekivw8r5jvD5KDf9WXmaBD38E1xiYFl/NJRtP9csiRZOWz?=
 =?us-ascii?Q?pK+JknPM6obgrZQyacOo/OrjrNG587rm+MV44j1yXZM8MHIBaY6pOr9hZewN?=
 =?us-ascii?Q?qj/LipI8p4/Mt1kKLIxSxkbLIU6qaJYH45LDuYcSv5v303UXlQBhwsxQhejL?=
 =?us-ascii?Q?vP0hEmCxMQxdj8gm0h3ZWNFauQ3tG8etgL84knW1RdatrDuDBXTXbXdN3iAs?=
 =?us-ascii?Q?l9RDITG/m4Em2QBLtX/Uk/A2Zc4eiu2OyRSqleEiMB1O93wY9teD+wZtO0jV?=
 =?us-ascii?Q?5NluHf0I0mdHHtG9yIa0Ld30y9hJ+kmZCmXZ0sbk8CXM5gL5+L49xbOlOrwx?=
 =?us-ascii?Q?+HJ4OPvrULrReQJSgevzgQSzOm+Se8pkutOy35Rs5iJAGmM8kFwl9iirPuis?=
 =?us-ascii?Q?g4COU0lPUnrUiXms1Xkv+ympudTVqrJ/W3lPqAOsJ34voszcdDJIFlA/RFva?=
 =?us-ascii?Q?/62Y26fD+2pmPYs0/2Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1f06d2-9869-4584-c4e7-08da7da03a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2022 02:53:54.8728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OxOepHNY4uXDQ/VK+H9HdPCVrPeE1LfISimIvKk9ReVw9y9dRY17L7/wL4HfGs2Iw5JD7OUTiwMg14iYntqG7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7936
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Saturday, August 13, 2022 6:57 AM
> To: Frank Li <frank.li@nxp.com>
> Cc: tglx@linutronix.de; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kw@linux.com; bhelgaas@google.com;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> pci@vger.kernel.org; Peng Fan <peng.fan@nxp.com>; Aisheng Dong
> <aisheng.dong@nxp.com>; jdmason@kudzu.us; kernel@pengutronix.de;
> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>; kishon@ti.com;
> lorenzo.pieralisi@arm.com; ntb@lists.linux.dev; lznuaa@gmail.com
> Subject: [EXT] Re: [PATCH v4 2/4] irqchip: imx mu worked as msi controlle=
r
>=20
> Caution: EXT Email
>=20
> On Fri, 12 Aug 2022 22:52:40 +0100,
> Frank Li <Frank.Li@nxp.com> wrote:
> >
> > MU support generate irq by write data to a register.
> > This patch make mu worked as msi controller.
> > So MU can do doorbell by using standard msi api.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
>=20
> May I add that it wouldn't hurt if you checked what addresses you send
> your patches to? For example, 'kernel@vger.kernel.org' doesn't exist
> (maybe you meant linux-kernel@...).

[Frank Li] Thanks. Strang, My email system have not report error. =20

>=20
> I will not take patches that haven't been posted to LKML (and I
> shouldn't have reviewed it the first place).
>=20
> Thanks,
>=20
>         M.
>=20
> --
> Without deviation from the norm, progress is not possible.
