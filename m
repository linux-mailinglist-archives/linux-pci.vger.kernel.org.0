Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2678A6271B0
	for <lists+linux-pci@lfdr.de>; Sun, 13 Nov 2022 19:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbiKMSj1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 13:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbiKMSj0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 13:39:26 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AECFD
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2022 10:39:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZD/FBNWlI5UDiAiURV9dchR69MR9Qj1I86NloKoYyu2rzElYigTnhUL4f6TzHlWGib5bOX9TdipFUZDryqykPTwnIUh7usQLaVaY+1yaMJWzMocRafAG45iuObAU4aU5VxOV5p9U9kOeIWtk0LS6NTGWVZTbMf6SKWCl7UXSKqxK97zCz5vFxeOrd+3tf18X/v8NmzTXkdd/dCmnRIHeOYzYGnX1lMUVQ6T71LzNJV5ocglZ6Kzeb1G/KmnvoQjyIo2Q6zf5Wqgtu2ARNYIxkRD0Nj3QiTu7uzpAxka3BxM+vwDM8B7UGan3c95Nn29UM+cO6mZhtK5CKTG/C7uorw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrvdfVzT8naIUgoeJW11VZEoNFIAOwZbnUWuILfIiCY=;
 b=lwKvOxISSfylqEEIXZx3V4LzTNz2pj9hhp0nDiEgw5ccHjkYFykj8Wnm7zHl0bqcm6Q/mZLMj3UXcbj2UDZ4G9ZV42SCCrYddy5rVTGTuOvWEbo27VD59BLABeQ31rGe+7Muqi9OzZLXUpRWsP2A/iw/CXIGq1FgfwJe/DfXozYvyaIzX5THbriNkeKhIuEtTO7ETvCRKki0P/eHSzSjhY2ww6F16zn12SY82pifZfx37QZLbCP4NfS0wdL+mWjwO//DDWbtJQAIQA9E5gs3Bg/XLT2/rjwcSzbNFsF5v/2BiQbF+O7nVuApPQqdtG7czgiPteYKXuIkNqUIcVef5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrvdfVzT8naIUgoeJW11VZEoNFIAOwZbnUWuILfIiCY=;
 b=mhjQMMBfiESlL+t98ngk1vboo927LzTttLik2Fh+VpLMOsgXZhnyu9UEZR3NcEeI8Kb4jHvGgG7SylUr8t2mda5H4GIkyLrAkHIJeqrIoYo5yC+Ldus4Tu1GMH2FOZwIXyNK/+k+MlnT3XrEqLEY6PMSShl7WFaJ6C/aPamHExw=
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by AS1PR04MB9263.eurprd04.prod.outlook.com (2603:10a6:20b:4c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sun, 13 Nov
 2022 18:39:23 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::c6c7:b5ff:b1a6:4ae6]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::c6c7:b5ff:b1a6:4ae6%5]) with mapi id 15.20.5813.017; Sun, 13 Nov 2022
 18:39:22 +0000
From:   "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Tyler Hicks <code@tyhicks.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: RE: [PATCH] PCI: Align MPS to upstream bridge for SAFE and
 PERFORMANCE mode
Thread-Topic: [PATCH] PCI: Align MPS to upstream bridge for SAFE and
 PERFORMANCE mode
Thread-Index: AQHYfNofgEASmrYSw0OBa+REYGw7zq4W1sSAgAGzeoCAJZSnUA==
Date:   Sun, 13 Nov 2022 18:39:22 +0000
Message-ID: <DB9PR04MB92361C48F8870B56DDC96DC284029@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20221019182559.yjnd2z6lhbvptwr3@sequoia>
 <20221020202437.GA142348@bhelgaas>
In-Reply-To: <20221020202437.GA142348@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|AS1PR04MB9263:EE_
x-ms-office365-filtering-correlation-id: 13a23295-fdb9-49c7-a360-08dac5a66215
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xGPHEoCQ+31Cg5UwKxzxW1nzh2SzhnZ/zXhS0ZKDBH2jnVZ9/+y+V6jlFyp1o4LsCZDSU0Pa50UMd4tBjcpU6wKlWag9ZVU/fnoemm0XdOeAA2jELlB4S6PnssP2y9DYoihhGUSjIhSp//2UqfUN2+M6vUcZpLHiVErPG6JPWS8pnO6vO11wdxaQsm75crm5OI7d2UDBBwru3bPVPi2N4UutS/+e/oyNJQ3NUOCvX/kSPquTco1zAwQwgjqGpVhtoXXrc3Hxmwm8B5u1mEOucqvgw6/EtsaPi8UmLQ7k39FsFEjm0ssdfBkl8djgBTQJqXY2Def6gdd5G8+9kGFKGpNkBOehQIYUIiyuXuLIF7WwPBKn6KwRI+CI2QTW51vPCAu3kMyfi/XBtbyby72mT9L0B447SqQCfM63kDFq8MBUBkPaFz18DsTkU/3B+2BxMUd9H0LSN3b+fuaaa+HZHdr7Ya8g2UoBTnz64pHbe4wINH9I5W0efemCbZ4gOpU24cd5qbULnzjsQJ4m85aTH79E03yheURs1u18sPIxExJBX7jZppBItvjODnyMo2+L4q64rO25tDJA8mBva6CXGfFonquMe/qgEQQdiVOQDe8x9tqvnKbPHrMQN+HHbmmbhNYyI4WNezCTvwrkVUSrS+TqkVcO5U+NRBejlc0GmA2GFIJvp/W6P28PIzQ28HIBe58l2g2WWGa2PpaPpmRZaMetL3/UgYZ7okjWlummuITgA/PIbwFVLuceekbfWIuICUIv3ytwBPRGIaqpUudWsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9236.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(84040400005)(451199015)(71200400001)(478600001)(110136005)(54906003)(316002)(53546011)(38070700005)(186003)(6506007)(9686003)(7696005)(26005)(5660300002)(8936002)(83380400001)(41300700001)(4326008)(52536014)(8676002)(2906002)(66446008)(64756008)(66946007)(66556008)(66476007)(76116006)(122000001)(38100700002)(55016003)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oU/zyOw4sGP9jY2mmBUPmCMCiQfcq2XjXHHCnWGRjzJpEZ0xqB4BGP/YKwnw?=
 =?us-ascii?Q?mJvxfm+JeXoWPasWUIqJoRsrX4Uwt4bgmoD4ztbPYx2/cx1q9ADc7dvfGJa2?=
 =?us-ascii?Q?Xk8rED+iWqHHMKP67qUMcj4eqiCAa9wiD3csVcNju6kotvDTMwunRNo1FRkT?=
 =?us-ascii?Q?4RTOBz+Msej5yBGRMHsEdEsOIoKGgRHHmmEHkj/r9uHXfPrUcwZs5WR1f7Qz?=
 =?us-ascii?Q?49WZjw9UcAlmAzRbauIPGxt2XPMmQC3hMo0bUNmTTFiDQV3CYWGKCtzCr+Z+?=
 =?us-ascii?Q?gnJUsoch9+R0cHG7S8lsfwAhyXzzpSjBtnYH0AuqqGT4R5jug1rvUU2UAFDK?=
 =?us-ascii?Q?cMr+87xl+u5t4vL8l91sPQupslWJQhNdwpH1Do+0q+wpde8YQSWI/Ct4p+Jn?=
 =?us-ascii?Q?xNy6pmIH+9hEDi4bfVgz28U8bW4rnZDVbbkYpPu30eK3IDtasjywF2Byt37k?=
 =?us-ascii?Q?XHv/Uxq+k55kKgjpnd8GC6r0daXe78DOJ/01JH/i+vsUjszJeETdXPCKJc/S?=
 =?us-ascii?Q?ozxxhtUDxEdhpT9breIPr37AkfW7suJ94uFDdz0eUQ3UrJmUJ2FGJVtRyFaU?=
 =?us-ascii?Q?95hC2VeE7ormGMPKAk8DkSX9Z6oTQzqJ2Xf9JeYMgCL7f4TxEtuJLGfNh2vB?=
 =?us-ascii?Q?20aaTtfZEUi4uVfePz5XolUhIZwgza27uuqs/+mjCegBENhhcdll8TD5VkVa?=
 =?us-ascii?Q?9pdKliMd1Yt+xg+HO/zEOgMj1dpS8AdOVjbw4H3XAklYUyiwhcfQDAg+JQXF?=
 =?us-ascii?Q?nCrl9S4HflKTLS84MHPqCgp+lOe0v6aUwgp2zq39LlkOYaIeSKUzkXcJwlt/?=
 =?us-ascii?Q?A43KGu8EuMTcRQ79RL1tJ/LkmRA0oIzGqwJreQpgGeprUyxWF8o09FNZQxtL?=
 =?us-ascii?Q?1w3errqBZyP+GLruEg/IfPziUcu3CLqxFtWzdf8IETYAyZwPUWMbnqiGe+Xd?=
 =?us-ascii?Q?ohlVT96DIkbRxH6ifXlIbAvbau7zGaj0pUIHu72lg5JXmpa6lIvKfWoqkntZ?=
 =?us-ascii?Q?DBDbDG8iKK1QO6Gzx1iAeA6kpva0RxJwgtxkUIKH52j8Tn6lD95Ee6kUEs7u?=
 =?us-ascii?Q?fI/4EvrnMNd7Pzdukj02RjwSJt+ZHqifE6+ip3TPCsOHMrcifEQND8c1cn8h?=
 =?us-ascii?Q?FjWediHeyRun/oStnYefCddz7gDuDWC8fWYuVvbv3/CiWeGKAkInaeMlJDxs?=
 =?us-ascii?Q?cmo2kN3JpaQ+cDAVvswPXM1JKA2fmnM5/puw/NrwnrLLdIKSYTJp4gIiEjPz?=
 =?us-ascii?Q?Qg2CeSLiXNyTHgCWXGisp7/mTDI9XfyQLuYPbUMmAiaHFn9KJkd8dhLQ/66l?=
 =?us-ascii?Q?OVU/7BcvhP5jpgZNywvddx/3iQgXpf446rzkf2ON9Oz/BnWr4D4D+BuNWA6w?=
 =?us-ascii?Q?mWKmKj/XgFEpjeFybupNTD+0kKZajmmAOXo2QYZ72UNR+LtUZRb3xjeXwypp?=
 =?us-ascii?Q?hNyIFgxVxjUdpdSiscBQmvh/ksSKuRIF4x0I6GPaYR6VP5reHor4JG7jGV7r?=
 =?us-ascii?Q?GcuSOoH9iOdN90l4zCYcPM2c24syZ3r/9uCmWc2H8x3Efn1LUqgjKbnH7AnC?=
 =?us-ascii?Q?eqJozAHnOyDS9/iD4gAWnQGOqXW25OtqYAMczJaY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a23295-fdb9-49c7-a360-08dac5a66215
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2022 18:39:22.7018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0gOYj3uzEnRvMSMza7KwLCzeWIF8LnSpd7lJD5rEe/QQLgDOePzAtCW96cTgGoXXpoU/E3IZEwDVEr/r30Kjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9263
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, October 21, 2022 4:25 AM
> To: Tyler Hicks <code@tyhicks.com>
> Cc: bhelgaas@google.com; Keith Busch <kbusch@kernel.org>;
> linux-pci@vger.kernel.org; Z.Q. Hou <zhiqiang.hou@nxp.com>; Lorenzo
> Pieralisi <lpieralisi@kernel.org>
> Subject: Re: [PATCH] PCI: Align MPS to upstream bridge for SAFE and
> PERFORMANCE mode
>=20
> On Wed, Oct 19, 2022 at 01:25:59PM -0500, Tyler Hicks wrote:
> > On 2022-06-10 23:01:31, Zhiqiang Hou wrote:
> > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >
> > > The commit 27d868b5e6cf ("PCI: Set MPS to match upstream bridge")
> > > made the device's MPS matches upstream bridge for PCIE_BUS_DEFAULT
> > > mode, so that it's more likely that a hot-added device will work in
> > > a system with an optimized MPS configuration.
> > >
> > > Obviously, the Linux itself optimizes the MPS settings in the
> > > PCIE_BUS_SAFE and PCIE_BUS_PERFORMANCE mode, so let's do this also
> > > for these modes.
> > >
> > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > I wanted to give a little more information about the issue we're seeing=
.
> > We're having trouble retaining the optimized Max Payload Size (MPS)
> > value of a PCIe endpoint after hotplug/rescan. In this case,
> > `pcie_ports=3Dnative` and `pci=3Dpcie_bus_safe` are set on the cmdline =
and
> > we expect the Linux kernel to retain the MPS value. Commit
> > 27d868b5e6cf preserved the MPS value when using the default PCIe bus
> > mode
> > (PCIE_BUS_DEFAULT) and we're hopeful that this can be extended to
> > other modes, as well.
>=20
> Thanks, Tyler.  I need help understanding what's going on here.  An examp=
le
> of the topology and what happens and what *should* happen might help.
>=20
> Some MPS configuration is done per-device in pci_configure_mps(), and som=
e
> considers a hierarchy in pcie_bus_configure_settings().  In the current t=
ree,
> in the PCIE_BUS_SAFE case:
>=20
>   - pci_configure_mps() does nothing (except for RCiEPs).
>=20
>   - pcie_bus_configure_settings(bus) looks at the hierarchy rooted at
>     the bridge leading to "bus".  If the hierarchy contains a hotplug
>     Switch Downstream Port, it sets MPS and MRRS to 128 for
>     everything.
>=20
>     If it does not contain such a bridge, it finds the smallest
>     MPS_Supported ("smpss") of any device in the hierarchy and sets
>     MPS and MRRS to that for everything.
>=20
> If you boot with a hotplug Root Port leading to an empty slot, I think th=
e RP
> MPS will end up being whatever BIOS put there.
>=20
> A subsequent hot-add will do nothing in pci_configure_mps(), and
> pcie_bus_configure_settings() looks like it would set the RP and EP MPS t=
o the
> minimum of the RP and EP MPS_Supported.
>=20
> Is that what you see?  What would you like to see instead?
>=20

Hi Bjorn, Thanks for your comments!
This patch is for the case that kernel boot with 'pci=3Dpcie_buf_perf', the=
 MPS is tuned during the enumeration, but if the EP is removed and then res=
can via the sysfs, the MPS won't be tuned in the rescan process. And the MP=
S is also tuned in the 'pcie_bus_safe' mode (see the Documentation/admin-gu=
ide/kernel-parameters.txt, I pasted the 2 options below for your reference)=
.=20
Is this expected behavior? If yes, can you help understand the reason.
                pcie_bus_safe   Set every device's MPS to the largest value
                                supported by all devices below the root com=
plex.
                pcie_bus_perf   Set device MPS to the largest allowable MPS
                                based on its parent bus. Also set MRRS (Max=
=20
                                Read Request Size) to the largest supported
                                value (no larger than the MPS that the devi=
ce
                                or bus can support) for best performance.
Thanks,
Zhiqiang

> Bjorn
