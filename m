Return-Path: <linux-pci+bounces-141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7367F4ED6
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 18:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0332812D3
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 17:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4C658AAA;
	Wed, 22 Nov 2023 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qanKbij4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wZIJWP2I"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45624101
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 09:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700675977; x=1732211977;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FeDo05J2p0j4OPB3dDo/9DpiTJQ1HvKlshqSAp/5svI=;
  b=qanKbij4eWvzRwW9nYoMoGNYs/6T29GbEhjQraUpl3FMLvI7Gg6mSDna
   ak9N5cG7oTHZypnKrixJRKTrAnKVrgwlhbUBhI2PfWo3BB6nkTUn37Kbp
   eVNLZJWD+mAVLjbqAI7wMtRP6+BSRhxYahtRBI4W5vGS7MrptZma1xbgx
   olVWrb0+Sq9ImQCn7OpGyVTetZsYK6VSY0NSVGl0x8x/GIK+oX9egpypo
   zaOd/g0GjNHam6Wd2axHS7PFHYgDLYUMs9vxl18x3EAstO1YThHFSPHWg
   xkchUdfKRjaafTey5lyi1AaGoR+OLP3IiaowliT6qYM3FZkYLaBNsjwtp
   A==;
X-CSE-ConnectionGUID: r+R5mSGaQLqiyP8kT7VWig==
X-CSE-MsgGUID: a54QSke4RuepNbzcqhjdsg==
X-IronPort-AV: E=Sophos;i="6.04,219,1695657600"; 
   d="scan'208";a="3189595"
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 23 Nov 2023 01:59:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2u39UGz1KMUv7FzR8IhpJASKv/KqTr5wS7+vSM4ixPKZAk797sgFJu5m0K0d/oavYEmQ9PMDbSLjjGpQe/RDESIKqOwt4F+jeZAUbJ0+ZB6SWKUwkpc+zEm4yQPmwLnvw3QVdLwtn2rbXs6LQ0IkcfAnZ9REPwzjBs7wW/bmyVRYlR22ih34aq6RW2iDUX0Oo0p9Fen9ByDQxHWSyJbvIk6x2lH8GtTqtbVQO4/SMsO18In1S+nssItrM3Gj3q4RGHW/rtehvnWvWliqioJKgflrg7d3gEc7TibvnKXokTFo9NgCxjwmTsFFx+KePiYMubjixunvfGZj1b9HV4hfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ec8kaflvNUoVhgSktbYl8HEQZAFzWous8WKrs7hg/g4=;
 b=fPhz5uXcVMbr5nrZ3OVTbZNlr0P05J8ymRO71b3fmaHLW2Oc87KZ4Sv9DNIsMkJtmPmIJ5BRUN0sLXrYNZX7YRTuSk4oPVQqnyPBfhO23bH9D/Wi78TCAheDN347o1e0dNORkRXDEt3I7q4HwGVxiE20iMBBxyGdTAoEmpje7SlROEryFAqCwfAQaNfGZRdncrAiTiU3KguwZ/mzM2xsAhsEdempgP9s92Lbpt+Pg03CDunFBqSe0UNTDIUYKxrXXn3aBjLrbtOBkj0FgMJ1fXofqFETm3TB9lxlXjbq8jgK432sIC6x1rBFezHHUK14yBDsePJo4DLK7FUer4pOFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ec8kaflvNUoVhgSktbYl8HEQZAFzWous8WKrs7hg/g4=;
 b=wZIJWP2IqgnS0FJ4cpaWYGJWJ46lRPORrluqwYYKx4F8IcfYmrJXsCUpblSICnCr2eDINVynVl6+ewkT66Y+5vhq0kCqMb3AgcDO5HSApFvhKn5jBwnwKLinoERCijfg6wpWThg4yhy8Qz2afJ1f/vuDGk8MjXZg/oKPjliJ9dM=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CO6PR04MB8347.namprd04.prod.outlook.com (2603:10b6:303:136::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 17:59:34 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0%4]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 17:59:34 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Niklas Cassel <nks@flawful.org>
CC: Jingoo Han <jingoohan1@gmail.com>, Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>, Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Kishon Vijay Abraham
 I <kishon@ti.com>, Damien Le Moal <dlemoal@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq()
 alignment support
Thread-Topic: [PATCH] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq()
 alignment support
Thread-Index: AQHaHWxLz4XN64AhvU2f3EisEEfm+LCGoHKA
Date: Wed, 22 Nov 2023 17:59:33 +0000
Message-ID: <ZV5Bhf1BhhHFxrKY@x1-carbon>
References: <20231122174856.736329-1-nks@flawful.org>
In-Reply-To: <20231122174856.736329-1-nks@flawful.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CO6PR04MB8347:EE_
x-ms-office365-filtering-correlation-id: 77514821-0c12-422b-8a4a-08dbeb84c8d6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LoPMOwXhbYZIas0cTa1mhKKTtB8+5FAOzOWBVCeA7IddG83azf3B+x60viSPvlFC37yH7x2n99NHe3jD6gb3Kc5HjAoMFguchuEYl+oe2BQBjoxWDmEgfmHwsU3oaTPZS06KjijUAw5mL1vXRlV59yq4JgDhfPYWXlHdB/MqV1GBXnrNOqlTLLoI0pX5fNcsSo3WnAQaAGOyUhQRBmNemxtjrAEo+tkkLkdJmKlJ1j+oSBuIa0Nl37su22jioDubVZDPiGCetZXrcX971VsqEX3Kfeps0oklciqrKV9IG1oQAu9W+f8Hkv5HXDfU049jXjXidj/MUMLetkBRNwScfEiC6PtOOQOB6UqrXNWnnyVPiHVcaMeC57tIidloQpMKQEIBomr7uIizKxAnTGU/Kfp+XZHo8zwW0Lc5wQQT6NfGZoUsc6nI5y69tQImumvQGKzbeBD4sTNDsvB04SzzH/A5EJT8FWnc6Xf4zWwkBe+JyNpJKoV+ioRq2uA7NX8cLy+ZMjAddAhrFCgp+SL4Adg7iBEOwd/Gikxy8UVkynm7ToBcHnUCO8IYQUxW6dziqB0PN0knJGT7teqWT8deaHFQveEaUt9fIZHCZWmvrSP2uS7gggEX12n7/9BMzuj4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(33716001)(38100700002)(82960400001)(38070700009)(86362001)(122000001)(66946007)(66476007)(4326008)(8676002)(8936002)(64756008)(91956017)(66556008)(54906003)(66446008)(76116006)(316002)(41300700001)(5660300002)(7416002)(2906002)(26005)(6916009)(6512007)(6486002)(71200400001)(6506007)(9686003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?AkHrEqm/Genhil/tQqhBcpmpw6AiWz8ZCsY6+xnJ0FDeB1LrwAdf9CaYJi?=
 =?iso-8859-2?Q?EII+/W4+p8VPQ1JSYLQKwNOJK7wroWrVOMJfxz/r/p8WMrS6fjiJnx3HYx?=
 =?iso-8859-2?Q?+eRzIaaXecuXAXq778KQtsE7ritSpxUSBDDBlum740y+N0iftNJUIo4YKq?=
 =?iso-8859-2?Q?yy8pxo5s2aIcWif4oi+orBo7LpHlHpw0mGdDAOnWtui+RAVb6zcNhQJ2/C?=
 =?iso-8859-2?Q?belnpdJwiKFf5ZpY11JLh77ZkNEiZHb4mbwgKRx8ZzsomXtOl1/zLdJSB2?=
 =?iso-8859-2?Q?gnx1gKxbRgekaVhbqxBOIRdmWar7SaaOTyTAaEqllhnZyGSnKrQSgWbrQN?=
 =?iso-8859-2?Q?E3dwEgOPOljg8BKrOi+7WbSzSoJ8sc7MOVt+YFU5rW4jipRYro3nw4whTN?=
 =?iso-8859-2?Q?tD6BKJ8bZk3lZKPSifvRhs0kIaQzbSkQFf7ScRMp0dCpGNrEsTAHNCKQcx?=
 =?iso-8859-2?Q?stglE+IcPnmcV9cU6JRUgS3nH23FJFPJx9C5OxD4eSiWWiUg2McSWVDBdQ?=
 =?iso-8859-2?Q?x3ZsXs9Q2Zw2QhjQR3gud+vFOVM6Q/FHxuDECH0XC0+VIK9Hib6Bw+B0pf?=
 =?iso-8859-2?Q?7oYD1r2mazP2/9LZNNghSMY9TUy0KUn2lcQP29XjkDKl4cn+BQAloUhJoF?=
 =?iso-8859-2?Q?a6PQkwD68U5YA9765ugBDhyUq7dY1b46E9kCfa4i3Sft9B42JF6DZaF0Ty?=
 =?iso-8859-2?Q?YoXY2hGen3PwW+VVhidzSL7V/VwYEG0zeaprDBNtTzXN4jBV+hu5PXhwkV?=
 =?iso-8859-2?Q?4toXbt5DMifvxUbvLy0MJtVXpvOwi5RlPalQxGTmCsY+PVrW9zhqJUpR8K?=
 =?iso-8859-2?Q?hrvnUIHW49rQs7lWoSeiMwotXx0r6TJd28RhE7/Uu4OM6XHnMfBIvRVyau?=
 =?iso-8859-2?Q?ypWRkuUkRoEqqVyRalr9EOuE3lq2lJKsMvygmQ9doc0l9RJAXO9Xey6X+C?=
 =?iso-8859-2?Q?XlIabXLJqs6GynCZa0+DHFlRx52njZd6qmcVpvnNPMk0EYJ9+r6OSBTNdz?=
 =?iso-8859-2?Q?Y4kgomTm+GuAbXopu83PMp7ivRMNBxuLxkkoQ5rfAUNzQKJlU1ptTu/enb?=
 =?iso-8859-2?Q?uqVBCg33RFOvPsa1fxsai3Dpo225cOY/xa7VPNL/OFzRrhaNwT38Mk4WW9?=
 =?iso-8859-2?Q?uLMIMUIEyp75CAgrxAPqH7ysvlrUa9TsvZchoGGE7AMUwXYA6WhCvHoim/?=
 =?iso-8859-2?Q?+NOf4G77WXcspHa9QAZDdR32Yi4j8QMzrGNm45fi4QTp0enzGO+WO2oBNr?=
 =?iso-8859-2?Q?TU3u4MUFPxwRJR4XBVq29IboCaaEnpjsKU73ZakBt+TPL8mnjtdpUoW/Qr?=
 =?iso-8859-2?Q?tF9ZfCK8DvofNwlAi21KBXfYMlwqqP0k+krpK/n5H/Q8JjDiX1yrUVYlUQ?=
 =?iso-8859-2?Q?cNFXpItNcGVOHFKQipieg6WL8SI/JOUORseyEqjZSsYtSCxCJkIMQShXcD?=
 =?iso-8859-2?Q?Lwf3Ok0pk4NlZInyo4P6CKBGCgRDJdjoh8zNr+6/g58IUEbkiwVgd5+t+F?=
 =?iso-8859-2?Q?y++zUK5nzY1RyjSLBRv4N6NWmkaT3zoDSMNdbNZKCro+cEvs0o/2WT/VDF?=
 =?iso-8859-2?Q?Cs768GaShrndiSKdvG3oTlWTMpAtATrIRp8VhJUqLqTCfMK8Ag0JM3DyKp?=
 =?iso-8859-2?Q?6fxNUmRuX9RvYF/uHzuFDevgfzcHxADAubCEXKRFwlub8qFf4HNrwJjg?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <EBF0D0946219BC4CB4F458031AC41558@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	=?iso-8859-2?Q?n/MCvMo457cih/SNM0vgIcoHwHrBFkRQeLEmooG1oG7WLWkutfwS7fn/+G?=
 =?iso-8859-2?Q?8blee4ZOMbmruCYl+OmdSBvj9ZXm4Ww1GJ6eJ95+h4EViGlq+DmJTjx/mQ?=
 =?iso-8859-2?Q?C8yP0voM9DUAdo6V9Yl79tg095MS2ZIExXVdcOS/1EpnOSjowit+NrGPrP?=
 =?iso-8859-2?Q?YQRBHqytLGCJ4dvp7D3oYFQNPywOQPFWARrqm/Fp71Yyvf/Tms06dbJoDc?=
 =?iso-8859-2?Q?kKYIeiTA1p8FlWyLAp4yAZcnS/e9vyeUG4aRhTmIIFcTTwlpdlStfrwzQk?=
 =?iso-8859-2?Q?QBVw6KXK3NI5OyD+8VyuxM7RLacOIsEo6BTnZOvvrbvwqdHcpmkmfG204Y?=
 =?iso-8859-2?Q?7lOGW1iRERUtGFsKg3bQfHxlQBR8CGT8h+ulbFM+i+lsg5LEhHRebXNLtJ?=
 =?iso-8859-2?Q?62i2kynIyLEr6eei5othsDulnM4Z9leBlnq3E1u83z3LKT1nAG9mUbyfLr?=
 =?iso-8859-2?Q?HQf25uzVTq8b5jEzv+Hv1w8j9GiNXRaPGv+zcSOF29b5MI4TgziIirZ3Fr?=
 =?iso-8859-2?Q?/ll8aKjgh9c2RgYIZLozy9jw4MZCxaKG/JOtDh6nfpEzojohKRAt2brEPo?=
 =?iso-8859-2?Q?5An6yd9EqGv6K2WSXkhYu8Q0qLnigzDSGyTIc/pKpGybtNdK1fVtiM4jQ7?=
 =?iso-8859-2?Q?M589DRNrbArsRmuRtDBUXB9PFT0+fnlTjq08oFmXLIQ3Z7r4nBzBEQ3MAY?=
 =?iso-8859-2?Q?PC4wdAT+dIG8Ov1sQKwdKYfl72fvfqdttn5UNLm4ddLLiI7yam58gT1cEW?=
 =?iso-8859-2?Q?a912gmSx7krXM2iVsp/NU2SS/2HSOqgykkyANvaZP7p8ImBPJ2Zuljqvs4?=
 =?iso-8859-2?Q?SEnlLYCKL+V0Fhs2NHmG620XZ6aGpjI1h7i86H2l2PslolwpaOh46SxW2D?=
 =?iso-8859-2?Q?l4EeQCg0+/6Dym9H5mrnvtkQi7wtpImviVLsNqHyTz9bleUwMBSPKdFgQG?=
 =?iso-8859-2?Q?fa0TjbUYQmDdJBQgSmX8makVflJhW3lLKtDRDni0FaLLUIfODfrImlFBs+?=
 =?iso-8859-2?Q?hCjVYBFUDD3u2r190=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77514821-0c12-422b-8a4a-08dbeb84c8d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 17:59:34.0599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNpW8J+UddjzR9zp+dsX6ceD5MAd4c3TbMZfokzNcvnqB+OjvmhJ1fiVD6+R608D+4ALjJLIoKIYGoVUr+69vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8347

On Wed, Nov 22, 2023 at 06:48:55PM +0100, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Commit 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get
> correct MSI-X table address") modified dw_pcie_ep_raise_msix_irq() to
> support iATUs which require a specific alignment.
>=20
> However, this support cannot have been properly tested.
>=20
> The whole point is for the iATU to map an address that is aligned,
> using dw_pcie_ep_map_addr(), and then let the writel() write to the
> msi_address + aligned_offset.

Reading this again... I wasn't super clear:
s/msi_address/ep->msi_mem/
makes it more obvious that I do not mean the MSI address in the RC.

>=20
> Thus, modify the address that is mapped such that it is aligned.
> With this change, dw_pcie_ep_raise_msix_irq() matches the logic in
> dw_pcie_ep_raise_msi_irq().
>=20
> Fixes: 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get co=
rrect MSI-X table address")
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index f6207989fc6a..bc94d7f39535 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -615,6 +615,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, =
u8 func_no,
>  	}
> =20
>  	aligned_offset =3D msg_addr & (epc->mem->window.page_size - 1);
> +	msg_addr &=3D ~aligned_offset;
>  	ret =3D dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr=
,
>  				  epc->mem->window.page_size);
>  	if (ret)
> --=20
> 2.42.0
> =

