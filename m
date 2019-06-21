Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA484DF3B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 04:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfFUC5h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 20 Jun 2019 22:57:37 -0400
Received: from mail-oln040092254015.outbound.protection.outlook.com ([40.92.254.15]:27284
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725906AbfFUC5h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 22:57:37 -0400
Received: from HK2APC01FT008.eop-APC01.prod.protection.outlook.com
 (10.152.248.58) by HK2APC01HT033.eop-APC01.prod.protection.outlook.com
 (10.152.249.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1987.11; Fri, 21 Jun
 2019 02:57:32 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.248.58) by
 HK2APC01FT008.mail.protection.outlook.com (10.152.248.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1987.11 via Frontend Transport; Fri, 21 Jun 2019 02:57:32 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::8c3b:f424:c69d:527e]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::8c3b:f424:c69d:527e%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 02:57:32 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Logan Gunthorpe <logang@deltatee.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [nicholas.johnson-opensource@outlook.com.au: [PATCH v6 4/4] PCI:
 Add pci=hpmemprefsize parameter to set MMIO_PREF size independently]
Thread-Topic: [nicholas.johnson-opensource@outlook.com.au: [PATCH v6 4/4] PCI:
 Add pci=hpmemprefsize parameter to set MMIO_PREF size independently]
Thread-Index: AQHVJqdtisSX95SZEkGuUZAlsxs7iaajL4kAgACJCQCAAAr4gIAAzHoAgADcxwA=
Date:   Fri, 21 Jun 2019 02:57:32 +0000
Message-ID: <SL2P216MB018710C0513F97989DCD3A4880E70@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB018784C16CC1903DF2CEDCB880E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <a473bee0-0a25-64d5-bd29-1d5bdc43d027@deltatee.com>
 <SL2P216MB01875B40093190DBB6C4CBB780E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <89c6a6ee-46cc-4047-0093-30f07992e7e5@deltatee.com>
 <20190620134712.GI143205@google.com>
In-Reply-To: <20190620134712.GI143205@google.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0116.ausprd01.prod.outlook.com
 (2603:10c6:201:2c::32) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:9B8241F894DEE63248D946841A1EF5C52DD609926872C97CBECE04EBE3A29B51;UpperCasedChecksum:26E024198425AAEE36CD632A5DEFFFB151BC9DD54056A9C139F63CA8AC1C5912;SizeAsReceived:8034;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [QvYyO0U3I1a6wJHm/KVDD8ZyrpFm3OR3TYNaCmiy0zB1Vpn2Z+FiX9x1fquBDmCP]
x-microsoft-original-message-id: <20190621025721.GA2610@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT033;
x-ms-traffictypediagnostic: HK2APC01HT033:
x-microsoft-antispam-message-info: iRg3O7TlcX//PVRyJpsuCwJdPFH6rBrsKXXD7z3jGwkJ60E4cUO91o//8YmWfgkHyH7ldKCXnZ9SxCsYr5bXokp5kleGYTm5Ji/axsilG0Qti8+ulKBLzplsRQxeB3tIdMH21gBC/DwSCfygQkxab/bFPe3ZShBQl9Vs5ZotlJpyZyoHlxhLN7Twce53sLG3
Content-Type: text/plain; charset="us-ascii"
Content-ID: <218282BE8B72D14984AC076BA4F8F093@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 77da1cfa-f649-4770-2016-08d6f5f43493
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 02:57:32.7870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT033
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 20, 2019 at 08:47:12AM -0500, Bjorn Helgaas wrote:
> On Wed, Jun 19, 2019 at 07:35:21PM -0600, Logan Gunthorpe wrote:
> > On 2019-06-19 6:56 p.m., Nicholas Johnson wrote:
> > > On Wed, Jun 19, 2019 at 10:45:38AM -0600, Logan Gunthorpe wrote:
> > >> On 2019-06-19 8:01 a.m., Nicholas Johnson wrote:
> > >>> ----- Forwarded message from Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au> -----
> > >>>
> > >>> Date: Thu, 23 May 2019 06:29:28 +0800
> > >>> From: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > >>> To: linux-kernel@vger.kernel.org
> > >>> Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, mika.westerberg@linux.intel.com, corbet@lwn.net, Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > >>> Subject: [PATCH v6 4/4] PCI: Add pci=hpmemprefsize parameter to set MMIO_PREF size independently
> > >>> X-Mailer: git-send-email 2.19.1
> > >>>
> > >>> Add kernel parameter pci=hpmemprefsize=nn[KMG] to control
> > >>> MMIO_PREF size for PCI hotplug bridges.
> > >>
> > >> Makes sense.
> > >>
> > >>> Change behaviour of pci=hpmemsize=nn[KMG] to not set MMIO_PREF
> > >>> size if hpmempref has been specified, rather than controlling
> > >>> both MMIO and MMIO_PREF sizes unconditionally.
> > >>
> > >> I don't think I like that fact that hpmemsize behaves differently
> > >> if hpmempref size is specfied before it. I'd probably suggest
> > >> having three parameters: hpmemsize which sets both as it always
> > >> has, a pref one and a regular one which each set one of
> > >> parameters.
> > > 
> > > It does not matter if hpmempref is specified before or after
> > > hpmemsize.  I made sure of that.
> > 
> > > Originally, I proposed to depreciate hpiosize, hpmemsize, and
> > > introduce: hp_io_size, hp_mmio_size, hp_mmio_pref_size, each
> > > controlling its own window exclusively.
> > > 
> > > The patch had the old parameters work with a warning, and if the
> > > new ones were specified, they would override the old ones. Then,
> > > after a few kernel releases, the old ones could be removed.
> > 
> > Well I don't like that either. No need to depreciate hpmemsize.
> > 
> > > Bjorn insisted that there be nil changes which break the existing
> > > parameters, and the solution he requested was to leave hpmemsize
> > > to work exactly the same (controlling both MMIO and MMIO_PREF),
> > > unless hpmemprefsize is given, which will take control of
> > > MMIO_PREF from hpmemsize.
> > 
> > I agree with Bjorn here too but my suggestion is to leave hpmemsize
> > alone and have it set both values as it has always done. And add two
> > new parameters to set one or the other. Then there's none of this
> > "sets one if the other one wasn't set". Also, if I only want to
> > change the non-preftechable version then your method leaves no way
> > to do so without setting the preftechable version.
> 
> Adding two new parameters sounds like a good idea to me.
Yeah, that is basically what I did originally (except I depreciated the 
old ones rather than keeping them).

I did it this way on your direct advice in keeping with minimal lines of 
diff, minimal disruption, etc. If I were to do this, the number of lines 
of diff will increase and then I will be fielding complaints that it is 
too large to sign off.

I am already scrambling to make last minute changes before end of 
release to the other patches and I am not even convinced that that stuff 
is going to get accepted based on proximity to deadline and how many 
change requests are flying around.

So I am going to have to respectfully decline to do this for now. I need 
to know earlier in the release cycle if I am going to go back on stuff I 
have already been asked to do.

Cheers.
