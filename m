Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1235148E259
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jan 2022 03:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbiANCDH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 21:03:07 -0500
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com ([40.107.21.58]:14177
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238752AbiANCDG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jan 2022 21:03:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DR3n3yJyxLgMqdweVMAkkxhuQmPlrcjosXJfFaSrk5J2Fnhzzg7N6H0LkP0pX1vLA02r0Ym4eAvLp5SD2WFTI2WMIAMHm2sR3iFbwoi0CVjb3kJmssnCTG0GoVHZnTza01zbmkp/JzzbLUPd0RdpkodYG0yO6E8HuYe9yUdzrJxl+TI4qBraYT3LzEzW+icDk1CyJy56FczfzAir/iDUwauSTQryCv0xIgm9v6C/yIQP55NnUri+XmKzyXNtWYZOgdTNE6CJgzX17aCMbpXz296WAxmLXY+yKIEJRj8wklQhJJ/beNZYPYEad79Oh0wH1CNxJCB2j/zP5qAyiEnA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vb1I0lSNVyaX9Rjlqwn7AUfZothCSQMSkdqGoXfZj5Q=;
 b=GwoJwPwMNS+UNqoO54qGawlQFWv6U81FP/fnI1bI+vP8lharrqkYTXDgOA6OWeSDdQX0H4N2mHaEOSLRo++MbDPo4UE6rRJrvzDU4t/W/GNnOVybi4YScan7q2WfCv/mpFPGDn3X/Zsrrg+zGk10m4OTKZWPGMUNTUe7ioAi61+svH7YIYXYrUCY//VXhzYEIHWCAZr7XLHwMP4cYHlW5sjPgHNCpbTssXTLzU+YDZmhqoyiPqaQbXiPyQPfFbdDfiS4+eTSCtpCCWZvKC8Lz8uYCVTL/Zy7Lqdn2l4N3nloJGHEqxEx3B6zFnhEXaQcZoc2cRsn1APqx14onobeRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb1I0lSNVyaX9Rjlqwn7AUfZothCSQMSkdqGoXfZj5Q=;
 b=iDuXoWV3cwqd4UQl5lqekWUmkeSWsa59JgZuOnW2fdPIAfYZRlAtKixMRRiJrZ4enu9LwhBmmEQIOKwN6/eKV6oTxro7tpWJoJTiO0XBAME55NXkhW0RsLuLGzxv78jzWWXNP61ngEG7h1ntBlSFB++UWzCxnwd9kcHTZibeMnI=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB4016.eurprd04.prod.outlook.com (2603:10a6:803:4a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 14 Jan
 2022 02:03:03 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::949e:59fd:6098:6508]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::949e:59fd:6098:6508%4]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 02:03:03 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v7 0/8] Add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Topic: [PATCH v7 0/8] Add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Index: AQHX51bVkIoDiCpdp0CHxa+OOhw1w6xg2nSAgAElzfA=
Date:   Fri, 14 Jan 2022 02:03:03 +0000
Message-ID: <AS8PR04MB8676CCA4C3CC431875A0657B8C549@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1638432158-4119-1-git-send-email-hongxing.zhu@nxp.com>
 <8c11bbded57df020ba0897f7ad0295d60c9ee2cb.camel@toradex.com>
In-Reply-To: <8c11bbded57df020ba0897f7ad0295d60c9ee2cb.camel@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54189295-96d2-4036-5164-08d9d701ff95
x-ms-traffictypediagnostic: VI1PR04MB4016:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VI1PR04MB4016E2D70B61671748FD97918C549@VI1PR04MB4016.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PYbimsFVzHzkyHk/eo5spFd1I0iPdwYaTfHCfRA2curBv3XDCp0TzoiWfMtbGsoZs1RXwniseoWxuCKOIPqeIvgMEK2+GNtlNyM2qGmJOb5XeUalwijSt7EmHB4RscMbDEFv4UhTKin2jHDzG5iMJwBe4LKxJjHcF1xM1HH5/m/TIowwgavhROiamar9KPJVFEOTbIf4oON5L37ivVNiFheorje3ltDJwTrhKcItZhy3wvWabMGubiJxL0oWbboSMCWjZmgpfb55KZ4RmG0Gi3R2PguxMJPH6FoHzY1qpe8/T83//WRVWdmgHQdip5rcto3HQxULhZi1eeOYPJJ6zD7PqY7qYtzEv/9ZuG63AjiT9S7GBJ6hjK8Kd4zFl4lSv9NZ8NbPssXOK0PIbnhYj40lB9A7xySY4cPUBT0FvWLUwrNNilFo42HNJHyEha+S2OSONYV7p89mfwI5+H/pNk+W0EnOGjxjx/dzgqSgLNC9mLouAttESR7f6Qx9Jni+hoF+hKZQ9FL1QW661GHtMVYlEkG9pB6UHrQTc4BnZk3QglXM4HNJu3emopAbJVbxDmHYfmyeaurgBzgHrAc+qc9fnr+KZFbx2HeV//xixcf8dfhcwYciEwYMl0fjwXovqtmj/dWu3iRLf0vQCAi/ISPPhtHl67JblyQemLIfDvcxD7S9wuRZ/Tvkis1ov3Q/RS+0JnBv7yDc53GyjNBfjjH0k3snwovqqiseNS5BJrUT0FKDATSmUwpQJJ3/8W0xpzrnQJN0uWHlfoJstvxd5G1mlBKOqDxK9t7z2Wg08abpwJJFFNK+xVQc5ynxifb+KPYlE2ZYE3lDeGYBKDh0eA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(186003)(45080400002)(44832011)(26005)(508600001)(38070700005)(55016003)(66946007)(76116006)(52536014)(5660300002)(2906002)(66476007)(54906003)(53546011)(7696005)(33656002)(86362001)(921005)(83380400001)(38100700002)(110136005)(122000001)(6506007)(66446008)(66556008)(7416002)(64756008)(8676002)(4326008)(8936002)(9686003)(316002)(966005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?f5WhwbkWb9aBSnMmY6VuaLip9pLjYuRsB8M2ysMM5tomJ0VfW5Uxhn4nCi?=
 =?iso-8859-1?Q?r5+8C8lq8bDasRY+F+uPw+oCz86VrGQwJO7aogZV00PMvyeSQ7C8AAv7HQ?=
 =?iso-8859-1?Q?AnfWkghj+mkASbF5q1dX5SlEGzfiL9bMUiS7TjyH58G0qrdCQOFriNFOji?=
 =?iso-8859-1?Q?l3v3SHBJTARarX8677T8Dl+SUTqP3WYrRYS6vv8wbYVJPe/4UrOy7TcE+6?=
 =?iso-8859-1?Q?oY93TsYZOJ6uh/T8UqL3l1mbRKgn7Ecosc9aHoXQP/GpwLzZcuuJYi3bJP?=
 =?iso-8859-1?Q?eKasrsAPXZB8lBE4bcoFxrplNcvwY0cigoInEkTLZi6wZfDRcV0md+WqBT?=
 =?iso-8859-1?Q?HuSyw4JRGvQDv+pgLP/VMEb0Txn58p08rhTrEWzLQpymL3gzCb4FDyINXZ?=
 =?iso-8859-1?Q?E3bMu7piuu/ZrYz8KbUTXXvHpgRBAEy8N+fv/P1WWDcQPfQhJnWZKP9mrx?=
 =?iso-8859-1?Q?0eHrjdJeMvhQ/pHSKXStV4mdDAvuYv0kHk24BHTaW+xEh9JMtxG9gVjA6f?=
 =?iso-8859-1?Q?xzdEKLQz5qhAMiPo6uqA+xnL/E+iy+dt44hB95KrOzjsn0PB9gTwSx0eSz?=
 =?iso-8859-1?Q?Lyzorq5C7ePIAoN2lmnc4Z2skA+ICNo35mo1uFSwJVLx0fbFcCyhsvkzoF?=
 =?iso-8859-1?Q?TeZdgfzMHI3kus/+gM1o5kqhdBei6htSImupygFvk86Q3cEu+ZHNybNUAw?=
 =?iso-8859-1?Q?r92LtM5y5yTTG4D+GdHs7TgZTNz/M6jL+M8LHieAYR39PpVJHuov2h1snL?=
 =?iso-8859-1?Q?LuBX6T5h/0AcC99E3g+9wN1PgRT61O9zgM0pg866ItIExCnaa5ycgijagT?=
 =?iso-8859-1?Q?JW//acpck+aP9ZhFM811ySovlg5x1c4b7cxT6j1I6wgCXLyyhY9Z8s6ZBB?=
 =?iso-8859-1?Q?lJZG0htHYRG2uj5caZVg/8ahu6rsoCqBrTUg3s5rbzx0oh8mnzRGu2iw1t?=
 =?iso-8859-1?Q?lMXckITwATxsSziDP/Zw7w+vm00CPUD5hbMwbXGIe9W5HRCMjypoUwCmQc?=
 =?iso-8859-1?Q?wx94unbCojAyiOP2KBlitwWLlBF9yNC8G1z0ShGsyi7oGd6jj04L1a/s7N?=
 =?iso-8859-1?Q?2dx7jynDZGP5jG3/HAv3W1wuDYKcgb/t+UeXiEabiCj/lH5h2azUbowu2v?=
 =?iso-8859-1?Q?qZ4t+38In3AwVz3koD4wRqxz6nL2L3DZWiGybFTAQ42r+cDUYBxUU/vM5P?=
 =?iso-8859-1?Q?hKgbm8wsYhd+pl0UaeejnQBWiINVYHTWBWaBaGQU24EfArzlVpJl28GHi1?=
 =?iso-8859-1?Q?Kos95eMxXKrDQ0khl6d2MRAv3DHAQaQYj5DjgGmkun7B6HXBwWIaoF2meT?=
 =?iso-8859-1?Q?G+ygo4QSfXOApJHk5jtIYskXyBz5hZEpKvkXpjo+3L6tJeccDBz06KyA5q?=
 =?iso-8859-1?Q?NyrlFnxFGVfxG4LtgG8xN+aELj8/vrB8gtwXkcHCa7gcOS4HF1TPLF9wYT?=
 =?iso-8859-1?Q?3YNqsaY87w7txksqWQFyeo4dz7tsfUbHz8DQ+NRyjRrYt5tre4tJfAHbZJ?=
 =?iso-8859-1?Q?wesSHbQfw9tDj7Rq02B7L2R+BjkR72plROxWtwSWztXVrWFekRllsrKus7?=
 =?iso-8859-1?Q?GDOOvS2PB3XYdfdil21g9rZDWQhEGsg16plgf31FGziVSfvz7Gu6x6sUck?=
 =?iso-8859-1?Q?h/0mQBAaqzmtlJwiyPwR8bNMz30IAaCsoNL9zVJ45O81cg8P+a5uDHOA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54189295-96d2-4036-5164-08d9d701ff95
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 02:03:03.1613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dqo+eMwdR5BOD3PP5bXwTrZ4s3b8sL0gM1Ydb2h+1CcdJliDXHM4pfGki+3ItR0VOedxNL5x61BvPIvMqHFaKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4016
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Sent: Thursday, January 13, 2022 4:07 PM
> To: kishon@ti.com; vkoul@kernel.org; lorenzo.pieralisi@arm.com;
> l.stach@pengutronix.de; tharvey@gateworks.com; robh@kernel.org;
> galak@kernel.crashing.org; Hongxing Zhu <hongxing.zhu@nxp.com>;
> bhelgaas@google.com; shawnguo@kernel.org
> Cc: linux-phy@lists.infradead.org; linux-pci@vger.kernel.org;
> kernel@pengutronix.de; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v7 0/8] Add the imx8m pcie phy driver and imx8mm
> pcie support
>=20
> Hi Richard
>=20
> On Thu, 2021-12-02 at 16:02 +0800, Richard Zhu wrote:
> > Refer to the discussion [1] when try to enable i.MX8MM PCIe support,
> > one standalone PCIe PHY driver should be seperated from i.MX PCIe
> > driver when enable i.MX8MM PCIe support.
> >
> > This patch-set adds the standalone PCIe PHY driver suport[1-5], and
> > i.MX8MM PCIe support[6-8] to have whole view to review this
> patch-set.
> >
> > The PCIe works on i.MX8MM EVK board based the the blkctrl power
> driver
> > [2] and this patch-set. And tested by Tim and Marcel on the different
> > reference clock modes boards.
> >
> > [1]
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> tc
> >
> hwork.ozlabs.org%2Fproject%2Flinux-pci%2Fpatch%2F20210510141509.
> 929120
> >
> -3-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7Chongxing.zhu
> %40nxp.c
> >
> om%7C487b28aecfd14bdfe1b808d9d66bb4ce%7C686ea1d3bc2b4c6fa92
> cd99c5c3016
> >
> 35%7C0%7C0%7C637776580350900040%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLj
> >
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&
> amp;sdata=3D
> >
> 8pMSNCoRVpWBld2dSGUUw2Dpq%2FlRAqsVWLqAJ0njEgo%3D&amp;re
> served=3D0
> > [2]
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> tc
> >
> hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F20210910
> 202640
> > .980366-1-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7Chon
> gxing.zhu%
> >
> 40nxp.com%7C487b28aecfd14bdfe1b808d9d66bb4ce%7C686ea1d3bc2b
> 4c6fa92cd99
> >
> c5c301635%7C0%7C0%7C637776580350900040%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjo
> >
> iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000&amp
> > ;sdata=3DMHPLXbIyL2pnZK%2FdVkDcJBJBjlqtPIOzzwLsNEKlCqs%3D&amp
> ;reserved=3D0
> >
> > Main changes v6 --> v7:
> > - Add "Reviewed-by: Rob Herring <robh@kernel.org>" into #2 patches.
> > - Regarding Vinod's review comments do the following changes.
> > =A0 - Don't build in the PHY driver in default.
> > =A0 - Remove the extra blank line
> > =A0 - Correct the license tag.
> >
> > Main changes v5 --> v6:
> > - Add "Reviewed-by: Rob Herring <robh@kernel.org>" into #1 and #3
> patches.
> > - Merge Rob's review comments to the #2 patch.
> >
> > Main changes v4 --> v5:
> > - Set the AUX_EN always 1b'1, thus it can fix the regression
> > introduced in v4
> > =A0 series on Marcel's board.
> > - Use the lower-case letter in the devicetreee refer to Marcel's
> comments.
> > - Since the default value of the deemphasis parameters are zero, only
> > set
> > =A0 the deemphasis registers when the input paramters are none zero.
> >
> > Main changes v3 --> v4:
> > - Update the yaml to fix syntax error, add maxitems and drop
> > description of phy
> > - Correct the clock name in PHY DT node.
> > - Squash the EVK board relalted dts changes into one patch, and drop
> > the
> > =A0 useless dummy clock and gpio suffix in DT nodes.
> > - Add board specific de-emphasis parameters as DT properties. Thus
> > each board
> > =A0 can specify its actual de-emphasis values.
> > - Update the commit log of PHY driver.
> > - Remove the useless codes from PCIe driver, since they are moved to
> > PHY driver
> > - After the discussion and verification of the CLKREQ# configurations
> > with Tim,
> > =A0 agree to add an optional boolean property "fsl,clkreq-unsupported",
> > indicates
> > =A0 the CLKREQ# signal is hooked or not in HW designs.
> > - Add "Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>" tag,
> > since
> > =A0 Marcel help to test the v3 patch-set.
> >
> > Main changes v2 --> v3:
> > - Regarding Lucas' comments.
> > =A0- to have a whole view to review the patches, send out the i.MX8MM
> PCIe support too.
> > =A0- move the PHY related bits manipulations of the GPR/SRC to
> standalone PHY driver.
> > =A0- split the dts changes to SOC and board DT, and use the enum
> instead of raw value.
> > =A0- update the license of the dt-binding header file.
> >
> > Changes v1 --> v2:
> > - Update the license of the dt-binding header file to make the license
> > =A0 compatible with dts files.
> > - Fix the dt_binding_check errors.
> >
> >
> Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml=A0=A0=A0 |=A0=
=A0 6
> +++
> > Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |=A0 92
> > +++++++++++++++++++++++++++++++
> >
> arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
>  |=A0 55
> > +++++++++++++++++++
> arch/arm64/boot/dts/freescale/imx8mm.dtsi
>=20
> > |=A0 46 +++++++++++++++-
> drivers/pci/controller/dwc/pci-imx6.c
> > |=A0 83 +++++++++++++++++++++++++---
> drivers/phy/freescale/Kconfig
>=20
> > |=A0=A0 8 +++
> drivers/phy/freescale/Makefile
>=20
> > |=A0=A0 1 +
> drivers/phy/freescale/phy-fsl-imx8m-pcie.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 |
> > 236
> >
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> +++++++++++++++++++++
> >
> include/dt-bindings/phy/phy-imx8-pcie.h
>  |=A0 14
> > +++++
> > 9 files changed, 532 insertions(+), 9 deletions(-)
> >
> > [PATCH v7 1/8] dt-bindings: phy: phy-imx8-pcie: Add binding for the
> > [PATCH v7 2/8] dt-bindings: phy: Add imx8 pcie phy driver support
> > [PATCH v7 3/8] dt-bindings: imx6q-pcie: Add PHY phandles and name
> > [PATCH v7 4/8] arm64: dts: imx8mm: Add the pcie phy support [PATCH
> v7
> > 5/8] phy: freescale: pcie: Initialize the imx8 pcie [PATCH v7 6/8]
> > arm64: dts: imx8mm: Add the pcie support [PATCH v7 7/8] arm64: dts:
> > imx8mm-evk: Add the pcie support on imx8mm [PATCH v7 8/8] PCI:
> imx:
> > Add the imx8mm pcie support
>=20
> What is the status of patches 4, 6 and 7? While the rest has been pulled
> those are still missing in today's - next.
[Richard Zhu] Thanks for your care.
I used to ping Shawn twice on Dec17/27 2021, but couldn't receive his respo=
nse.
Anyway, I would continue to ping him later.

Best Regards
Richard Zhu

>=20
> Cheers
>=20
> Marcel
