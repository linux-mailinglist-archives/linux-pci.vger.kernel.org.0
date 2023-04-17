Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C163B6E4234
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 10:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjDQIJk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 04:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjDQIJg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 04:09:36 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2113.outbound.protection.outlook.com [40.107.114.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF344C22;
        Mon, 17 Apr 2023 01:09:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJPTeJSprIK2iKpp3fQPM0FpyYUaFktTwcsev8GbkXCDk70AXoAcvO2h8usvAPgh3tyuSE4InN3CKlL24HmwwAZDl1+1Ch8xnuF4h34uZy0rZuJbo5kOnaMmicggs8yb6bdvfXEmpxEygpXt40q/DYaXk4UIiGDnTBlqfjN73mw7sq8KncCFFRbaSbaHKl+g1GmuGvC4zYQmZLHWam9crwA4vUlaiYPIX7WVfxcSYD+SB+nkYh6xcCPU4mNrqyzbqOdRU7Sfn4rXHeIyIK1796jQK+3c+QoOi3y04dq8e4PEs68Y5PGZpam4W9eSbr9jxXEEwtl+a29WmlwlqSNwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqkQNITwtuiJx+1H1LaW8LhfBx0I3NW81fEBmrCHl4E=;
 b=RIFJ0cAdlsz3N3zJPVWcQMDitlO3h5QDdPdbXUnX+qUL59XVWV7d9K71eZX0kx34HBcjLk3KVztFxKYj2Ro6laT5hwKc1BWpCTXYhr5AUKgWWAaN0N+/CKQvj2GsQpLVi45GWLO+HV3oInR8u7n3cv8OB5MXnGQXupLKWmTgFphHEEpIxXI7mr6X7SwUU61s9pCZrjiD4IfwrHqiSepQTPoKKm+/dopooAb0d/UpWoiJDnkGNhoYzQZWe1LAPQD+sERrnj3wghlyndLgLQiYqJyBxR0QNlLpj8zDbrs2aqFRnYa7TLTdULIY0ewtw/Kv9g49+qTlXoYtkhRbUCcpvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqkQNITwtuiJx+1H1LaW8LhfBx0I3NW81fEBmrCHl4E=;
 b=VtgZSuP4kw0KeMl3eu3YUE822uWDBUdtk704kgEVPi95NcctdnBWWg39s734jWGSOEx9r5W4n9f1i5RRHgVNnMjgRvtWj4fkXFFlKStXPG3PbNPO4v5Iqw15zAhDQYJGa5rkuZfzEqc0x4ew1FqqeyOk99DVqFa3D/njv4m6WNk=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYAPR01MB5802.jpnprd01.prod.outlook.com
 (2603:1096:404:8053::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 08:09:25 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 08:09:25 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
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
Subject: RE: [PATCH v12 11/19] PCI: dwc: Add support for triggering legacy
 IRQs
Thread-Topic: [PATCH v12 11/19] PCI: dwc: Add support for triggering legacy
 IRQs
Thread-Index: AQHZbpipW3pZkrA810e6mcDjXjm9h68rNVmAgAPuL9A=
Date:   Mon, 17 Apr 2023 08:09:24 +0000
Message-ID: <TYBPR01MB53411FDF1B8709F74B798852D89C9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230414061622.2930995-12-yoshihiro.shimoda.uh@renesas.com>
 <20230414194239.GA214436@bhelgaas>
In-Reply-To: <20230414194239.GA214436@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYAPR01MB5802:EE_
x-ms-office365-filtering-correlation-id: 58598ae5-64be-4007-6b3d-08db3f1b0ee4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fN2ZPBowl+X5I4eK6fyZw1PDbRSmY9FYa2bB9rDl1QKvG+yUFDMrPIww6IpAxdoI+3bN5H/xlH+NKv+oyJI9aWO4SFMhp4eUpYYYp4+daHcDeAauPM78mFXg9oWDa2OeWcqUBf40yHrpKRdu0Gsp5Yp7q2vHROKoV9dNomMANgoCviicUnDc40gzQLozNtLKkD4J9d59jLYG56/LRBQauzR9quoy4Tdab9bIijOojyUBAuFQ69VCXN4vRBlb8aCHncmYS+9EEk4vImAoZ7bjm3ETaat2YD3pwGa8LKw7hFSkCr9IHUi0nvXUQGkR4pEvWLF2/Qfj9L3BFm//1Yv8Fn39S9npXuzhwpBsAT9SPLM330g6FZ44GBE34QPMV8AbyuQm+LRDuTwPslAACUj0m1Q7JO1hhEtoy5T9cazKcXH85t3FkRJyb01taBPjp/YTvmAyjfuh8KaizeKO/DITtXR2H1Xvoj38wcfwqcQB/Ehdatbno54x5gm6DkKpZJzog5hRhwW03ilVBiHEzTEewaumz20JPrWT+TMj1GilNnhr2jB4hVNkhQmqMDyLM19yqPAkMqwFvo+Akp7T/CswifVc8ZxpMbXKwqxGkyy73loQMxwBqj8yEHYFux/a+6rZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199021)(7696005)(86362001)(478600001)(55016003)(71200400001)(83380400001)(33656002)(6506007)(186003)(9686003)(38100700002)(38070700005)(122000001)(64756008)(6916009)(76116006)(66446008)(66946007)(66476007)(66556008)(316002)(2906002)(4326008)(8936002)(8676002)(5660300002)(7416002)(52536014)(41300700001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n6wIJMqkdKOmrh3naqDnmJovVY7fTnPtI8w9Yp2w0fyNxyDDUHEU8j/i85Ky?=
 =?us-ascii?Q?0PgfZlh4T2w8MRQ6Rig8o8YxTDWk4yC+nICH3x2nY/bQvSnfR1cHx5u3SLpi?=
 =?us-ascii?Q?WJXnA51C5K6aF+lmiEbtfIJ+IMkPIVpERgG1ECE4m2iawyjCae+0d3whf9oU?=
 =?us-ascii?Q?HWL78YU+x641AkyKICmnmb/J8XB7kScWvHpDWSx9p2dygKEcfIiXJwWG+7am?=
 =?us-ascii?Q?J1rWI5CUYktuxDl2dwbQTVGu4ZqVIrmZP+07wd4TdSAW/Rsjl11dCBsuDveV?=
 =?us-ascii?Q?BoiiVkez6AcZ/E3lenBH5Tqz0L38eWVKfoD+4H+gdyKc4jGeT/KuHAjyk9rl?=
 =?us-ascii?Q?IHaA3lvUywTu66eJ3d3GSELNYgmj53Xd727bMdfb06OVXs7pMQaAiVPWxfgH?=
 =?us-ascii?Q?t5JWnSBjwsLKo70iyw8nHgWqA3GA1roPu3gmP/SfpKQNdchM2WdQK/RIsBPJ?=
 =?us-ascii?Q?otQv3VkxaG2wXgs7y47n310z6NMRGBX5FolUCCtsM1HvPZuqT6KkLTEGEiGy?=
 =?us-ascii?Q?HsS8uOaLarMZ1/IctTU0l+XhTe1lR4zqzFJvZ8fDq0gHSEJhBszZJwPpHVSx?=
 =?us-ascii?Q?AhqwU0R8UapDUp3/qKWs+ZAIjafbMbzko4/TEKaXBAreNpEM7EWIO4BK33nc?=
 =?us-ascii?Q?cktFHJYYDgig991QjBzo0A5hxiYocww97QeEeuml3NA9Dg9m6Hiu4rGPUV9+?=
 =?us-ascii?Q?26v8rx96GKzADaXoTULFI8lntoZLBr8CadaVkJ0vVPQElCGxp9TdxvteaAjv?=
 =?us-ascii?Q?UDxws6DOz/lmfbmCwEcesbnTbfY4ejhbWJaXQ6q51dx47uBPyZiu6sB5rMna?=
 =?us-ascii?Q?Qf2ZixXYgyLqcSExUSSIPwnnfWH56tTi1XyO38q0mt8Xhl4+b5xF3FpdaZrT?=
 =?us-ascii?Q?IBKP0VudgDtljs8fKrXo2WVap/TqlBeUrMYSxirfQvEFr4G8lJVAD1hW9uor?=
 =?us-ascii?Q?UrMSVEH8cBMU8JkvDy7h31V+jk1dF6YOrqaFkF7df7h0zrW5CkneWUa6uISz?=
 =?us-ascii?Q?zqXt+7nGY56Uq6lDkeY0euqVqRv5TAdFURY4lMbjct1bhYcMcLD0rQfUDs4K?=
 =?us-ascii?Q?Hujd/BitV3xl17ojkDWEiUWF9iz+vEIws1YVCLvcYxDHLclDgBdCR7DAubx9?=
 =?us-ascii?Q?7+LVrUnrFg129zEWG11EFOXadLeAJOrrltdYTX6Xivgl3135FMJnW1Cb2Nt7?=
 =?us-ascii?Q?kbHfyBuudJNVqESkCCdNpGoLir1b+Sop7cILa14BrvnkLsa218LDDrnhzdn7?=
 =?us-ascii?Q?PjDWguHpJeEhdPzA3tjf6ZwDzfLc+YI/OIyVOMHawSNCXvf9Veb86mAlwbtz?=
 =?us-ascii?Q?mfiTilWTMZB9a9ZFJC2Bi1ad8dUR6qKN8sWLBgnZa62bQ2BFtCQEmecl3HJj?=
 =?us-ascii?Q?qL6hl5aiYDLCq9Bb4psOrx7+qNdZXjo7IiaKUlbzEBMgR+Vi4tDEaIUIWbwC?=
 =?us-ascii?Q?wcP/0XkifDFhDg2nR+a84gGd+/NP7dHzLoBpV9KWFdCMg7jEEr9X6oxWqqR4?=
 =?us-ascii?Q?ggL4ZU2SNnPQ+PPPoWiyMKMuIO6AhGGoqcUH+BwgsKDAdunOXRTBB/tn+epT?=
 =?us-ascii?Q?xCAMiCl4C9XrhKAM7ZvhJRfl3ujcmHO9ysW/HepZxaEIPQsm1nLk5Be25MLS?=
 =?us-ascii?Q?F1sJQz1iE2/F9vy2rNYLFktKibWa5sjtpMAcUFJAbTLqZuO4tzRxi4/SQ8wF?=
 =?us-ascii?Q?j20rag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58598ae5-64be-4007-6b3d-08db3f1b0ee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 08:09:24.9132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B50LoQcZIP677iptmO1RwSjdu4oKBL5PJeyBLiLVjDdpb53Hm+SwINR6sbuMHmMPhYGUs/EKUpb3mLtlnVdlRTUTSNmKH8o5R+eChefgTkd+/2b1ijOF7Bbo763zL6/j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5802
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> From: Bjorn Helgaas, Sent: Saturday, April 15, 2023 4:43 AM
>=20
> On Fri, Apr 14, 2023 at 03:16:14PM +0900, Yoshihiro Shimoda wrote:
> > Add support for triggering legacy IRQs by using outbound iATU.
> > Outbound iATU is utilized to send assert and de-assert INTx TLPs.
> > The message is generated based on the payloadless Msg TLP with type
> > 0x14, where 0x4 is the routing code implying the terminated at
> > Receiver message. The message code is specified as b1000xx for
> > the INTx assertion and b1001xx for the INTx de-assertion.
>=20
> s/terminated at Receiver/Terminate at Receiver/, since I assume this
> refers to the Message Routing mechanisms in Table 2-20 in sec 2.2.8.

I'll revise the description on v13.

> I have a slight preference for using "INTx" instead of "legacy IRQ" in
> subject, commit log, function names, etc because it's more specific.
> "Legacy" is clear now, but tends to become obscure over time as more
> and more features are added.  Eventually it just means "something old
> that we don't like anymore."

I got it. I'll use "INTx" instead of "legacy" on v13.

> > +static int __dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 fun=
c_no,
> > +					 int intx)
> > +{
> > +	int ret;
> > +
> > +	ret =3D dw_pcie_ep_send_msg(ep, func_no, PCI_CODE_ASSERT_INTA + intx,
> > +				  PCI_MSG_ROUTING_LOCAL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	usleep_range(1000, 2000);
>=20
> Where do these values (1000, 2000) come from?  Spec reference would be
> good if there is one.

I referred the values from drivers/pci/controller/pcie-rcar-ep.c, but modif=
ied
the second value:
	usleep_range(1000, 1001);

Today I checked the documents of PCIe and this controller, but I could not
find any specification about the period. So, I tried some cases a little.

 No sleep: Always "NOT OKAY"
 udelay(10): Sometimes "NOT OKAY"
 usleep_range(50, 100): Always "OKAY"
 usleep_range(100, 200): Always "OKAY"
 usleep_range(1000, 2000): Always "OKAY"

So, using (1000, 2000) seems too long. So, I'll change the values
as (50, 100) and add comment like below:

	/*
	 * The documents of PCIe and the controller don't mention
	 * how long the INTx should be asserted. If 10 usec, sometimes
	 * it failed. So, asserted for 50 usec.
	 */
	usleep_range(50, 100);

Best regards,
Yoshihiro Shimoda

> Bjorn
