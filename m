Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC57736B7A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 14:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjFTMCQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 08:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjFTMCO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 08:02:14 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2136.outbound.protection.outlook.com [40.107.113.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF26E7;
        Tue, 20 Jun 2023 05:02:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SygO1r/WSwFhNHGPXr+ELEfqSdJfnmVtSW8c7oPpbQlE3QHmaqUccdvArCYT7e9miod5ixj9xF8i4NU4dMU8AvhLb+3+wVjMeu/Y1OLGfZZ44Td1GGAxiCUTFr65FFlP9yHh5z0cSLsnxdfeYnC3SR/YRPW+HwycCFWtUtBc1t/wMPTIg/y1vlAPQQdJsD0TscYsmyEenSjcE3fg4kC8hm+M29lB0ub5jSe01cYpr4Gj8QpmG9Tw0oTvN2RWCNmD+qnHlJjKCn9K8q8UEHhX4Gjwc5/91N4ShowbwelzYeiPR1Iz0WlmgmWGa1oBube0WMV6NJXoXqhdgobJn/YnvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y63evR3CSHAaS68rawMlrODAqZ9PMcT+MZn7bEeGpmw=;
 b=oX0DIR4BE/ycQ7s03AZT5Mstju/ArydnLSHj9JMdA8w14sN1XTdRFpfBp3KgrVTd72aEiIoFSapEcvRXejs8EoJUGL7BIcxvZ5w6Wba0uJYwnOcRlAewonhlQnx4cclQrN65rvxp2OjUSqlY8g8MUZKyZStUr5dFneM8MCKhpawGri8DwkIi04sF0WWESH2L+HZpEea66sLolL0rCSUGdmw/CaqY916AepH0zQTqx2P0qMySjV7vD2tsT9UOAw4nhWy1/kdLMNu/WiRs0qNQRWw69UrW/+0UhhEDihg2/7Bfr1RzuPgMvIXw51u8ApeP/+oa2SjRy/P10Ir/ppoUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y63evR3CSHAaS68rawMlrODAqZ9PMcT+MZn7bEeGpmw=;
 b=edgZgnM52/PZ0qY5I8O7rzpauTkLSBUlDtQmiiwDwKJE288Kc8e3+D8YhCfZ5aUQA2e6L0Add1eIobu2a0QOE8DwlEEdF48XrRzhxC4T/VxcrH08/Gjk1oscdiUfJ1j0iwkouvp2Af23lMQr87RYsGfaJRwlGb+jSfXwvsnWWJY=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB10931.jpnprd01.prod.outlook.com
 (2603:1096:400:3b3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 12:02:08 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1%3]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 12:02:08 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v16 19/22] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Topic: [PATCH v16 19/22] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Index: AQHZgwfSD1pv8+kZFEalYK7OljPo8698cOgAgAEOU0CAAe45gIABPKpggABUd4CAANbBAIAApgeAgATdZkCAAG/UgIAB+7uggACfWgCAAIPogIAI76wA
Date:   Tue, 20 Jun 2023 12:02:08 +0000
Message-ID: <TYBPR01MB53418EF6548818FCA2D1F45DD85CA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <TYBPR01MB5341A67CF6DFFCB396F13195D853A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230607121533.cxvidvdqat5h2tqu@mobilestation>
 <TYBPR01MB53417E55F5F9E667D679901CD850A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230608121115.qnilmougdfd6fdyq@mobilestation>
 <TYBPR01MB5341AD39983D6B39034AF01BD851A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230609105407.c4olqepv7vuoqktz@mobilestation>
 <TYBPR01MB53411835ACCD884FCA9ECBE2D854A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230612195149.hdnttkcabynmf4kx@mobilestation>
 <TYBPR01MB534161A79DFF1830B65D303FD85AA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230614113924.7ssdcl2njivdienp@mobilestation>
 <20230614193131.6nlqyzwmhpv23ksv@mobilestation>
In-Reply-To: <20230614193131.6nlqyzwmhpv23ksv@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB10931:EE_
x-ms-office365-filtering-correlation-id: d1334831-077c-434f-e96d-08db71862c6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wB+NqnpDb/NipGvOPNjwQM7eCA18OqrktSfGhkW69GQGWG0YUex1d8YVENuTghTOOOgMaxTtN3LZlqbiWf8O9Ozfw/yxJGJuiNqLxOjP6AZe/kbLE/1wuS1yGyMwZKi3huDxS5TG4QOlLMpeQ1gsRHXaM4iS56DuooK29f5cvc9LbkYh34EVLn1WHuAyutEskcuVEzu93cJuLNFPumFw4f4DtL2gYNVHRm+EjGrryBay9wQ5+xTVaF2l2N09F6mP+LUZRCp9RwDSYq4y1xR3wB0VY/0GEh0rspgqW2SUG+LePBm6B15KqRafu3OKa7Ind+oFUNm0zk2Ymj8l/Yje5eLR4ArMRokB4Tylx14LtFqrMaV9MIbHRrlYrvHx5Xstn3b0RXoSyqbH34/bKsk8Y4/fGGb/D/aOVY3Si4yWS0m6Ir4zmf4ILI+eV5jf0SX1m9lsc8WTwTAO9pHYHclB06bpnO1fYqMs6+mXxy3VzOttpymcpDJrW6Ncz4mZjEe1aggpdFEtenVGz0uSvE42RFby3YkKxCvRl5b1mVtXY31R+TOB93f3jctVlMB16QOTT2l8f+nypxwHkkvJBy5WlXcEIUkYBtWAagM5RPjtlAFOdTqhQcPzIbl31fm65xsU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(5660300002)(7416002)(8936002)(8676002)(52536014)(6916009)(4326008)(64756008)(66446008)(66946007)(76116006)(66556008)(66476007)(316002)(2906002)(30864003)(54906003)(41300700001)(7696005)(71200400001)(478600001)(55016003)(6506007)(9686003)(186003)(83380400001)(33656002)(38100700002)(122000001)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7wxFYzQDDHXl8A6luLDTtp3Fl/cx1qzk7+AC3NERdYLiYpRjnHE/HEbaBGMx?=
 =?us-ascii?Q?FFYLUVor9kEhqego+gLO2yTJINF1lRqiugp0S6+yNLOkJ9v2uER6tYhX6NsW?=
 =?us-ascii?Q?8w3cbHnDw+n0Ssa/m88LjrfPO44eb73j7WTNj+a7gqdGlyFIzsGvkuygEDys?=
 =?us-ascii?Q?fCgjc6TdgLe5vahr/hcWwamF+Ak/FLqFWki7xQP92tB2oktHGvM/SDerLwbe?=
 =?us-ascii?Q?gjQPdOT+31sa+iDMEMZPlPhB2XG0DU6Bs4Pj/nUqGuEzlEYtjxsWyynuzHhF?=
 =?us-ascii?Q?XJdjmMAxVtxpJ/NqAHXUMwb5sh8I6cLySD3FqXYhFAX/UTXNWFq9dP1acM3x?=
 =?us-ascii?Q?3gA7mZQ3uh0z3nnjIWko5M9a9KMUAsPHOFejzZ0Avut6xlklhVgGh/8qd250?=
 =?us-ascii?Q?nMMdLhiBFb6PtpnkmfJYzNveFEPE/9KJJZATv4eKcu0r6huiHf5To2btVCSp?=
 =?us-ascii?Q?Mz9jvdc9hYJ45WgdrRdvDmiWhJ2Do1kaSJ0YRTo6/SY2cJVJsJMjNCX7CIcz?=
 =?us-ascii?Q?Os5TcTd6HTy8copy5kgczlUUQP3rr3h60BFtOKAs1pMZyVME+pyNZnCIaZ2M?=
 =?us-ascii?Q?CBhS29L+ZxWP6kIlOjvsojeLO7fD9l7RovXO2o3s5UtOr6gEUntEuXCCEFEK?=
 =?us-ascii?Q?PccCnpj81ct28crKDbaxPnY2ZUaB3IVA+cpQoYGaW60fjC2Se/zh1IHNHPGF?=
 =?us-ascii?Q?cDFGpovks7rG4ddKf9Ogj7qo0xcdJMDsZYQq3K3lYHoIz/WRxEI/TAdF1B+b?=
 =?us-ascii?Q?eqzw7WdsbCHLqKZf/mih0py/rK4Grz+mDuRTY4iBLAwkBw1zCdwt6tWPIJjn?=
 =?us-ascii?Q?OEXw6UOgqZplrE8Sy9dS568+UhPBpwL6sUWWmpxtkkydo+hcREqPguZIkNh9?=
 =?us-ascii?Q?NAs6qS/qzTaVwlCB+w6CM0GWfIlAhjGx+LhxDYvrJJOn7j5oyY62/huAerDQ?=
 =?us-ascii?Q?p4Gmk2RUzAApTh2hWtNGQN4YLcFyUjQv/bibIR7isWG2LVuYwAZ5Ez+aHnl7?=
 =?us-ascii?Q?iSg3aN5KTi9HJxA3ZRkjH9ukfOKtB5CFDsdi/iNy9iFkrTKmb/STufnq7Uh0?=
 =?us-ascii?Q?+vbsBJFv2MpeUUHBUXVimHPHpp9DJsJ7dRaWlLhxmsxkkd3UNyShosOYQFek?=
 =?us-ascii?Q?LXaN8sU1TXjJWDcOxwzCj0JzBC6CpXQdue01KHzENDEaXluP4UaWuFv9ieqv?=
 =?us-ascii?Q?zcpbOuNMJlLswkejsp5n+tPidAkX1wngW0yH1W8VgIP4ALvG2K2c8yYx1mEx?=
 =?us-ascii?Q?rQjS9HORiwlKLSLJN/y/mjQ8OEpH/BvGx/RbpSbjQsSnwC6xRsy3JjNAHfVI?=
 =?us-ascii?Q?6oVLfu9Lv94EGCB8lsVtsJh+10loIgRmjH2Eh9ozA2tHYIY6l3eFKIvVT6Vb?=
 =?us-ascii?Q?4V7zMGI+9qm87MxGKLblKpc2XeAReUHFUQkaIxIyIDaObh38QeCKLn1Vfqwh?=
 =?us-ascii?Q?EE0O7KEgtPWmA3GIMIWZ4f+Y+Nz/GuKt5EH10MOnM33xb51ivA5EoKQ8Pk7N?=
 =?us-ascii?Q?fhKaoY3vZQmVaXV549z2tAW+SKGot1Fn2fa4rAZiw/BWt7DrtZZXJzMa88at?=
 =?us-ascii?Q?PyMng9P340+r2GviBx8C9JwilImkzry9TBOjQL2aHNc5TCzkBbo3GiapmPH4?=
 =?us-ascii?Q?YcsSKJjqrs5adVqxULFoI5ZCrWM9M0mXKguUS6v2SQdkyqNlnU/vByuWALyz?=
 =?us-ascii?Q?BgsJWw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1334831-077c-434f-e96d-08db71862c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 12:02:08.7550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1jlwcYXd0i3kEu7EFhaFquofch83a3feSAPPmWpHcOw72el80wYWboiEacw5D37oz2CORc7Mz4QehDeBkH/fLLboPovKHLzOwpA6ef1tSOGeASzp5Mi93b2Zu5mHt/Az
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10931
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Thursday, June 15, 2023 4:32 AM
>=20
> On Wed, Jun 14, 2023 at 02:39:29PM +0300, Serge Semin wrote:
> > On Wed, Jun 14, 2023 at 02:30:13AM +0000, Yoshihiro Shimoda wrote:
> > > Hello Serge,
> > >
> > >  From: Serge Semin, Sent: Tuesday, June 13, 2023 4:52 AM
> > > >
> > > > On Mon, Jun 12, 2023 at 01:19:02PM +0000, Yoshihiro Shimoda wrote:
> > > > > Hello Serge,
> > > > >
> > > > > > From: Serge Semin, Sent: Friday, June 9, 2023 7:54 PM
> > > > > <snip>
> > > > > > > > > static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > > > > > > > > {
> > > > > > > > >         struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie=
(dw);
> > > > > > > > >         int i;
> > > > > > > > >
> > > > > > > > >         rcar_gen4_pcie_ltssm_enable(rcar, true);
> > > > > > > > >
> > > > > > > > >         /*
> > > > > > > > >          * Require direct speed change here. Otherwise RD=
LH_LINK_UP of
> > > > > > > > >          * PCIEINTSTS0 which is this controller specific =
register may not
> > > > > > > > >          * be set.
> > > > > > > > >          */
> > > > > > > >
> > > > > > > > >         if (rcar->needs_speed_change) {
> > > > > > > >
> > > > > > > > Seeing this is specified for the root port only what about
> > > > > > > > replacing the statement with just test whether the rcar_gen=
4_pcie.mode =3D=3D
> > > > > > > > DW_PCIE_RC_TYPE? Thus you'll be ablt to drop the needs_spee=
d_change field.
> > > > > > >
> > > > > > > Thank you for the comment. I'll fix it.
> > > > > > >
> > > > > > > > BTW Just curious. Why is the loop below enabled for the Roo=
t Port
> > > > > > > > only? What about the end-point controller? It's the same ha=
rdware
> > > > > > > > after all..
> > > > > > >
> > > > > > > This is reused from v16 and then it used "link retraining" wh=
ich is only for
> > > > > > > the Root Port. As you mentioned, it seems endpoint controller=
 is also needed
> > > > > > > if we use direct speed change.
> > > > > > >
> > > > > > > > >                 for (i =3D 0; i < SPEED_CHANGE_MAX_RETRIE=
S; i++) {
> > > > > > > > >                         rcar_gen4_pcie_speed_change(dw);
> > > > > > > > >                         msleep(100);
> > > > > > > > >                         if (rcar_gen4_pcie_check_current_=
link(dw))
> > > > > > > > >                                 return 0;
> > > > > > > > >                 }
> > > > > > > >
> > > > > > > > Did you trace how many iterations this loop normally takes?
> > > > > > >
> > > > > > > i =3D 0 or 1 (if the max-link-speed is suitable for a connect=
ed device.)
> > > > > > >
> > > > > > > > Is it
> > > > > > > > constant or varies for the same platform setup and a connec=
ted link
> > > > > > > > partner? Does the number of iterations depend on the target=
 link speed
> > > > > > > > specified via the "max-link-speed" property?
> > > > > > >
> > > > > >
> > > > > > > This is not related to the "max-link-speed". It seems to rela=
ted to
> > > > > > > a link partner.
> > > > > > > 		LinkCap	max-link-speed	loop
> > > > > > > Device A		4	4		1
> > > > > > > Device A		4	3		1
> > > > > > > Device B		3	3		0
> > > > > >
> > > > > > Great! If so I would have just left a single unconditional
> > > > > > rcar_gen4_pcie_speed_change() call placed right after the
> > > > > > rcar_gen4_pcie_ltssm_enable() method with no delays afterwards.=
 These
> > > > > > methods would have been invoked in the framework of
> > > > > > dw_pcie_start_link() after which the dw_pcie_wait_for_link() me=
thod is
> > > > > > called with several checks parted with the ~100ms delay. It wil=
l make
> > > > > > sure that at least some link is up with the link state printed =
to the
> > > > > > system log. If for some reason the performance degradation happ=
ens
> > > > > > then it will be up to the system administrator to investigate w=
hat was
> > > > > > wrong. Your driver did as much is it could to reach the best li=
nk gen.
> > > > >
> > > > > IIUC, is your suggestion like the following code?
> > > > > ---
> > > > > 	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > > > > 	if (!dw_pcie_wait_for_link(dw)) {
> > > > > 		rcar_gen4_pcie_speed_change(dw);
> > > > > 		return 0;
> > > > > 	}
> > > > > ---
> > > > >
> > > > > Unfortunately, it doesn't work correctly...
> > > > > The following code can work correctly. The value of i is still 1 =
on the device A.
> > > > > What do you think that the following code is acceptable?
> > > > > ---
> > > > > 	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > > > > 	for (i =3D 0; i < SPEED_CHANGE_MAX_RETRIES; i++) {
> > > > > 		msleep(100);
> > > > > 		rcar_gen4_pcie_speed_change(dw);
> > > > > 		if (dw_pcie_link_up(dw)) {
> > > > > 			printk("%s:%d\n", __func__, i);
> > > > > 			return 0;
> > > > > 		}
> > > > > 	}
> > > > > ---
> > > >
> > > > My idea was to implement something like this:
> > > >
> > > > +static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > > > +{
> > > > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > > > +
> > > > +	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > > > +
> > > > +	rcar_gen4_pcie_speed_change(dw);
> > > > +
> > > > +	return 0;
> > > > +}
> > > >
> > > > and retain the rcar_gen4_pcie_link_up() method as is.
> > >
> > > Unfortunately, such a code doesn't work on my environment...
> > >
> > > > * Note: originally your loop used to have the msleep() call perform=
ed
> > > > after the first rcar_gen4_pcie_speed_change() invocation. Thus the
> > > > delay can be dropped if there is only one iteration implemented (se=
e
> > > > further to understand why).
> > >
> > > Calling rcar_gen4_pcie_speed_change() multiple times is required on
> > > my environment. I thought msleep(100) was quite long so that I tried
> > > other wait interval like below:
> > >
> > >  msleep(1) : about 5 loops is needed for link. (about 5 msec.)
> > >  usleep_range(100, 110) : about 400 loops is needed for link. (about =
40 msec.)
> > >  usleep_range(500, 600) : about 80 loops is needed for link. (about 4=
0 msec.)
> > >
> > > The delay timing doesn't seems important. Both cases below can work c=
orrectly.
> > > --- case 1 ---
> > > 	for (i =3D 0; i < SPEED_CHANGE_MAX_RETRIES; i++) {
> > > 		rcar_gen4_pcie_speed_change(dw);
> > > 		if (dw_pcie_link_up(dw)) {
> > > 			printk("%s:%d\n", __func__, i); // will be removed
> > > 			return 0;
> > > 		}
> >
> > > 		msleep(1);
> >
> > Why? Just set it to 5 ms. In anyway please see the next message.
> >
> > > 	}
> > > ---
> > > --- case 2 ---
> > > 	for (i =3D 0; i < SPEED_CHANGE_MAX_RETRIES; i++) {
> > > 		rcar_gen4_pcie_speed_change(dw);
> > > 		msleep(1);
> > > 		if (dw_pcie_link_up(dw)) {
> > > 			printk("%s:%d\n", __func__, i); // will be removed
> > > 			return 0;
> > > 		}
> > > 	}
> > > ---
> > >
> > > So, I'll use case 1 for it.
> >
> > Ah. I think I get it now. Your spreadsheet:
> >
> >                 LinkCap max-link-speed  loop
> > Device A           4          4           1
> > Device A           4          3           1
> > Device B           3          3           0
> >
> > actually meant (loop+1) iterations. So in case of Gen4 you'll need
> > three speed changes (one already enabled in the dw_pcie_setup_rc()
> > method and another two ones are performed in your loop). Similarly in
> > case of Gen3 you'll need only one iteration. I bet you won't need to
> > call rcar_gen4_pcie_speed_change() at all if gen2 needs to be trained.
> > Could you try it out?
> >
> > Anyway based on what you discovered and on my experience working with
> > that controller, there should be as many
> > GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE flag changes as the target speed
> > value, i.e. no flag switch if Gen1 is required, one flag switch if
> > Gen2 is required and so on. Although I failed to find any explicit
> > statement about that in the HW-manual.
> >
> > In addition to the above I've found out that
> > GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE field is actually self cleared when
> > the speed change occurs (see the register description in the HW
> > reference manual). We can use it to implement the
> > dw_pcie_link_up()-independent link training algorithm like this:
> >
> > +#define RCAR_RETRAIN_MAX_CHECK		10
> > +#define RCAR_LINK_SPEED_MAX		4
> > +
> > +static bool rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
> > +{
> > +	u32 val;
> > +	int i;
> > +
> > +	val =3D dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > +	val &=3D ~PORT_LOGIC_SPEED_CHANGE;
> > +	dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > +
> > +	val |=3D PORT_LOGIC_SPEED_CHANGE;
> > +	dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > +
> > +	for (i =3D 0; i < RCAR_SPEED_CHANGE_WAIT_RETRIES; i++) {
> > +		val =3D dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > +		if (!(val & PORT_LOGIC_SPEED_CHANGE))
> > +			return true;
> > +
> > +		msleep(1);
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +	int i, changes;
> > +
> > +	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > +
>=20
> > +	changes =3D min_not_zero(dw->link_gen, RCAR_LINK_SPEED_MAX);
>=20
> This should have been:
> +changes =3D min_not_zero(dw->link_gen, RCAR_LINK_SPEED_MAX) - 1;
> because Gen1 doesn't need any speed change action.
>=20
> But this part can be further improved. Instead of the code above the
> next snipped can be implemented:
>=20
> +changes =3D min_not_zero(dw->link_gen, RCAR_LINK_SPEED_MAX) - 1;
> +if (changes && rcar->mode =3D=3D DW_PCIE_RC_TYPE)
> +		changes -=3D 1;
>=20
> It takes into account that the GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE
> flag is already set in the dw_pcie_setup_rc() method. So Gen2 will be
> trained with no need in addition actions. If it's supported of course.

Thank you very much for your comments and suggestion! The suggestion code
works correctly on my environment.

Best regards,
Yoshihiro Shimoda

P.S.
So, I'm investigating endpoint mode issues which you commented now.

> -Serge(y)
>=20
> > +	for (i =3D 0; i < changes; ++i) {
> > +		if (!rcar_gen4_pcie_speed_change(dw))
> > +			break;
> > +	}
> > +
> > +	return 0;
> > +}
> >
> > Note 1. The actual link state will be checked in the framework of the
> > dw_pcie_wait_for_link() function, by means of dw_pcie_link_up().
> >
> > Note 2. RCAR_LINK_SPEED_MAX is deliberately set to 4 because DW PCIe
> > EP core driver doesn't set the PORT_LOGIC_SPEED_CHANGE flag. In case
> > of the DW PCIe Root Port at most 3 iterations should be enough.
> >
> > Note 3. Please use the RCAR_ prefix for the vendor-specific macros.
> > It concerns the entire series.
> >
> > Could you try out the code suggested above?
> >
> > -Serge(y)
> >
> > >
> > > > You don't need to wait for the link to actually get up in the
> > > > start_link() callback because there is the link_up() callback, whic=
h
> > > > is called from the dw_pcie_wait_for_link() method during the generi=
c
> > > > DWC PCIe setup procedure. See:
> > >
> > > Since the procedure will call rcar_gen4_pcie_speed_change() from
> > > ->start_link() once, my environment cannot work correctly...
> > >
> > > Best regards,
> > > Yoshihiro Shimoda
> > >
> > > > dw_pcie_host_init():
> > > > +-> ops->host_init()
> > > > +-> ...
> > > > +-> dw_pcie_setup_rc()
> > > > |   +-> ...
> > > > |   +-> dw_pcie_setup()
> > > > |   +-> ...
> > > > +-> if !dw_pcie_link_up()
> > > > |   |   +-> ops->link_up()
> > > > |   +-> dw_pcie_start_link()
> > > > |       +-> ops->start_link()
> > > > +-> dw_pcie_wait_for_link();   // See, wait-procedure is already pe=
rformed
> > > > |   +-> loop 10 times          // for you in the core driver togeth=
er
> > > > |       +-> dw_pcie_link_up()  // with the delays between the check=
s
> > > > |           +-> ops->link_up()
> > > > |       +-> msleep(~100)
> > > > +-> ...
> > > >
> > > > -Serge(y)
> > > >
> > > > >
> > > > > Best regards,
> > > > > Yoshihiro Shimoda
> > > > >
> > > > > > -Serge(y)
> > > > >
